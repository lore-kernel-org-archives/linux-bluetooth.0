Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 1/2] android/README: Update links to BfA on GitHub
Date: Fri, 13 Nov 2015 11:46:07 +0100
Message-Id: <1447411568-4361-2-git-send-email-andrzej.kaczmarek@codecoup.pl>
In-Reply-To: <1447411568-4361-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447411568-4361-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since code.google.com is now read-only, sample implementation of BfA is
moved to GitHub. README is updated with new links.
---
 android/README | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/android/README b/android/README
index fff4562..83a902b 100644
--- a/android/README
+++ b/android/README
@@ -23,7 +23,7 @@ Build requirements
 
 - GLib - Android 4.2 or later don't provide GLib and one must provide it in
 'external/bluetooth/glib' folder of Android tree. Sample Android GLib port
-is available at https://code.google.com/p/aosp-bluez.glib/
+is available at https://github.com/bluez-android/glib
 
 - SBC - A2DP code requires SBC library (version 1.2 or higher) present in
 'external/bluetooth/sbc' directory. Library is build from Android.mk provided
@@ -33,7 +33,7 @@ by BlueZ. SBC code is available at git://git.kernel.org/pub/scm/bluetooth/sbc
 BlueZ on Android 4.4 requires backporting missing features (epoll_create1 and
 ppoll calls). Sample Bionic for Android 4.4 with all required features
 backported is available at
-https://code.google.com/p/aosp-bluez.platform-bionic/
+https://github.com/bluez-android/aosp_platform_bionic
 
 Runtime requirements
 --------------------
@@ -46,9 +46,9 @@ board:
 import init.bluetooth.rc
 
 For convenience examples are provided at:
-https://code.google.com/p/aosp-bluez.device-lge-mako/    (Nexus 4)
-https://code.google.com/p/aosp-bluez.device-lge-ham/     (Nexus 5)
-https://code.google.com/p/aosp-bluez.device-asus-flo/    (Nexus 7 2013)
+https://github.com/bluez-android/aosp_device_lge_mako           (Nexus 4)
+https://github.com/bluez-android/aosp_device_lge_hammerhead     (Nexus 5)
+https://github.com/bluez-android/aosp_device_asus_flo           (Nexus 7 2013)
 
 Security-Enhanced Linux in Android
 ----------------------------------
@@ -62,14 +62,14 @@ bluetoothd.te
 bluetoothd_snoop.te
 
 For convenience sepolicy.git with all required policies is available at:
-https://code.google.com/p/aosp-bluez.external-sepolicy/
+https://github.com/bluez-android/aosp_platform_external_sepolicy
 
 Downloading and building
 ------------------------
 
 Building for Android requires full Android AOSP source tree. Sample Android tree
 with all required components present is available at
-http://code.google.com/p/aosp-bluez/
+https://github.com/bluez-android
 
 This tree provides support for Nexus4 (mako), Nexus 5 (hammerhead) and
 Nexus 7 2013 (flo, deb). Tree does not provide binary blobs needed to run
@@ -81,7 +81,8 @@ Downloading:
 Android 5.0 - 'lollipop' branch
 Android 4.4 - 'kitkat' branch
 
-repo init -u https://code.google.com/p/aosp-bluez.platform-manifest -b lollipop
+repo init -u https://github.com/bluez-android/aosp_platform_manifest \
+	-b lollipop
 repo sync
 
 Building:
@@ -152,8 +153,7 @@ CONFIG_BT_HCIBTUSB
 If it is not possible to use new enough Linux kernel one can use updated
 bluetooth subsystem from Backports project. More information about Backports can
 be found at https://backports.wiki.kernel.org. Sample kernels using backports
-for running BlueZ on Android are available at
-https://code.google.com/p/aosp-bluez.
+for running BlueZ on Android are available at https://github.com/bluez-android.
 
 
 Running with Valgrind
@@ -176,7 +176,7 @@ It's recommended to have unstripped libglib.so installed which will enable
 complete backtraces in Valgrind output. Otherwise, in many cases backtrace
 will break at e.g. g_free() function without prior callers. It's possible to
 have proper library installed automatically by appropriate entry in Android.mk,
-see https://code.google.com/p/aosp-bluez.glib/ for an example.
+see https://github.com/bluez-android/glib for an example.
 
 When running with valgrind SElinux needs to be set into permissive mode. This
 can be done by executing 'setenforce 0' from root shell.
-- 
2.6.2

