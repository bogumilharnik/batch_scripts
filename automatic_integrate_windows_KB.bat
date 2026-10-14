@echo off
:: Upewnij się, że uruchamiasz skrypt jako Administrator!

SET WorkDir=C:\Win10Work
SET MountDir=%WorkDir%\Mount
SET UpdatesDir=%WorkDir%\Updates
SET WimFile=%WorkDir%\ISO\sources\install.wim
SET TargetIndex=6

echo ====================================================
echo 1. Montowanie obrazu Windows 10 (Indeks %TargetIndex%)...
echo ====================================================
dism /Mount-Wim /WimFile:%WimFile% /Index:%TargetIndex% /MountDir:%MountDir%

echo ====================================================
echo 2. Integracja poprawek (.msu / .cab) z folderu Updates...
echo ====================================================
:: DISM automatycznie zainstaluje pliki w poprawnej kolejności, jeśli znajdują się w jednym katalogu
dism /Image:%MountDir% /Add-Package /PackagePath:%UpdatesDir%

echo ====================================================
echo 3. Czyszczenie i optymalizacja obrazu (Zmniejszanie rozmiaru)...
echo ====================================================
dism /Image:%MountDir% /Cleanup-Image /StartComponentCleanup /ResetBase

echo ====================================================
echo 4. Odmontowanie obrazu i zapisywanie zmian (Commit)...
echo ====================================================
dism /Unmount-Wim /MountDir:%MountDir% /Commit

echo ====================================================
echo PROCES ZAKONCZONY SUKCESEM! Obraz gotowy do nagrania.
echo ====================================================
pause
