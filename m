Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/doc: Add instructions for android-ia
Date: Fri,  1 Aug 2014 16:40:02 +0300
Message-Id: <1406900402-12528-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add instructions for building Android image based on android-ia from
01.org.
---
 android/README | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/android/README b/android/README
index fb00f40..79434fc 100644
--- a/android/README
+++ b/android/README
@@ -84,6 +84,31 @@ After full build is done it is possible to rebuild only BlueZ:
 'mm' (or 'mm -B' to force rebuilding of all files)
 'adb sync' to update target device.
 
+Downloading and building for Intel devices
+------------------------------------------
+
+Sample Android tree with all required components for Intel devices based on
+Intel reference image (https://01.org/android-ia) is availabe at
+https://code.google.com/p/android-bluez/
+
+This tree provides support for Dell XPS12, Minnowboard MAX, Intel NUC,
+Acer Iconia W700 and other devices mentioned in:
+https://01.org/android-ia/guides/devices
+
+Downloading:
+repo init -u https://code.google.com/p/android-bluez.manifest/ -b android-ia \
+	-m topic/bluez/master
+repo sync
+
+Building:
+source build/envsetup.sh
+lunch haswell_generic-eng
+make -j8
+
+Installing:
+Live and Install image is $OUT/live.img
+Flash live.img to USB flash and boot from it. More instructions here:
+https://01.org/android-ia/guides/developers/build-and-install
 
 Linux Kernel requirements
 -------------------------
-- 
1.9.1

