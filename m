Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] android/README: Update documentation with AOSP 4.4
Date: Mon, 13 Jan 2014 23:47:08 +0100
Message-Id: <1389653228-5285-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This includes:
 - sample repository to AOSP 4.4 based repository with support for
   Nexus 4 and Nexus 7 2013 devices.
 - adds info about snoop service
 - other random additions
---
 android/README | 71 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 21 deletions(-)

diff --git a/android/README b/android/README
index 9c804a3..39ca9d2 100644
--- a/android/README
+++ b/android/README
@@ -13,26 +13,29 @@ in android/hal-apc-api.txt file.
 Building and running on Android
 ===============================
 
+Steps needed to build and run Android Open Source Project 4.4.2 with
+integrated BlueZ.
+
 Build requirements
 ==================
 
 - GLib - Android 4.2 or later don't provide GLib and one must provide it in
 'external/bluetooth/glib' folder of Android tree. Sample Android GLib port
-is available at https://code.google.com/p/android-bluez.glib/
+is available at https://code.google.com/p/aosp-bluez.glib/
 
-- Bionic support - BlueZ requires signalfd and timerfd APIs to be provided
-by libc library. Currently only 'master' branch available at
+- Bionic support - Currently only 'master' branch available at
 https://android.googlesource.com/platform/bionic provides all required
-functionality and running BlueZ on older branch requires backporting missing
-features. Sample Bionic for Android on Intel Architecture (Android-IA) with all
-required features backported is available at
-https://code.google.com/p/android-bluez.bionic/
+functionality and running BlueZ on release branch requires backporting missing
+features (currently only epoll_create1 call for Android 4.4.2). Sample
+Bionic for Android 4.4.2 with all required features backported is available at
+https://code.google.com/p/aosp-bluez.platform-bionic/
 
 Runtime requirements
 ====================
 
-BlueZ HAL library requires 'bluetoothd' service to be available on Android
-system. This can be done by defining service in init.rc file of targeted board:
+BlueZ HAL library requires 'bluetoothd' and 'bluetoothd-snoop' services to be
+available on Android system. This can be done by defining following services in
+init.rc file of targeted board:
 
 service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
   class main
@@ -40,34 +43,60 @@ service bluetoothd /system/bin/logwrapper /system/bin/bluetoothd
   disabled
   oneshot
 
-It is required that bluetooth user could start and stop bluetoothd service by
-setting 'ctl.start' or 'ctl.stop' property. This can be achieved by
-whitelisting bluetooth user and bluetoothd service in init source code.
+service bluetoothd-snoop /system/bin/bluetoothd-snoop
+  class main
+  group bluetooth net_admin
+  disabled
+  oneshot
+
+It is required that bluetooth user could start and stop bluetoothd and
+bluetoothd-snoop services by setting 'ctl.start' or 'ctl.stop' property. This
+can be achieved by whitelisting bluetooth user and bluetoothd and
+bluetoothd-snoop services in init source code.
 
 Required Android init system modifications can be found at
-https://code.google.com/p/android-bluez.system-core/
+https://code.google.com/p/aosp-bluez.platform-system-core/
+
+Some configuration changes like setting permissions, starting hciattach
+services etc. are device specific. For convenience examples are provided at:
+https://code.google.com/p/aosp-bluez.device-lge-mako/    (Nexus 4)
+https://code.google.com/p/aosp-bluez.device-asus-flo/    (Nexus 7 2013)
 
 Downloading and building
 ========================
 
-Building for Android requires full Android AOSP source tree. Sample Android-IA
-tree with all required components present is available at
-http://code.google.com/p/android-bluez/
+Building for Android requires full Android AOSP source tree. Sample Android
+4.4.2 tree with all required components present is available at
+http://code.google.com/p/aosp-bluez/
+
+This tree provides support for Nexus4 (target aosp_mako-userdebug) and
+Nexus 7 2013 (target aosp_flo-userdebug). Tree does not provide binary blobs
+needed to run Android on supported devices. Those can be obtained from
+https://developers.google.com/android/nexus/drivers. Binary blobs needs to be
+unpacked (EULA acceptance required) into 'vendor' directory of Android tree.
 
 Downloading:
-repo init -u https://code.google.com/p/android-bluez.manifest/ -m topics/bluez
+repo init -u https://code.google.com/p/aosp-bluez.platform-manifest -b kitkat
 repo sync
 
-Build for Intel ultrabook:
-'source build/envsetup.sh'
-'lunch core_mesa-eng'
-'make allimages -j8'
+Building:
+source build/envsetup.sh
+lunch aosp_mako-userdebug    or    lunch aosp_flo-userdebug
+make -j8
+
+Flashing:
+adb reboot bootloader
+fastboot flashall -w
 
 After full build is done it is possible to rebuild only BlueZ:
 'cd external/bluetooth/bluez/android/'
 'mm' (or 'mm -B' to force rebuilding of all files)
 'adb sync' to update target device.
 
+Linux Kernel requirements
+=========================
+TODO add section about kernel requirements
+
 =============================
 Building and running on Linux
 =============================
-- 
1.8.5.2

