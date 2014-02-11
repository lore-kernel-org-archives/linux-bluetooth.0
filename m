Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android/README: Add Valgrind description
Date: Tue, 11 Feb 2014 12:43:53 +0100
Message-ID: <1392119033-23035-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/README b/android/README
index e3c314f..c7145d5 100644
--- a/android/README
+++ b/android/README
@@ -108,6 +108,22 @@ be found at https://backports.wiki.kernel.org. Sample kernels using backports
 for running BlueZ on Android are available at
 https://code.google.com/p/aosp-bluez.
 
+Running with Valgrind
+=====================
+
+BlueZ for Android is preconfigured to be easily run under Valgrind memcheck.
+Appropriate configuration and required modules are automatically included when
+building either userdebug or eng variant of Android platform.
+
+Valgrind can be enabled in runtime by setting "persist.sys.bluetooth.valgrind"
+property to either literal "true" or any numeric value >0. For example:
+adb root
+adb shell setprop persist.sys.bluetooth.valgrind true
+
+After changing property value Bluetooth need to be restarted to apply changes
+(this can be done using UI, just disable and enable it again). Property is
+persistent, i.e. there's no need to enable Valgrind again after reboot.
+
 =============================
 Building and running on Linux
 =============================
-- 
1.8.5.3

