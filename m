Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android/README: Add note on libglib under Valgrind
Date: Wed, 12 Feb 2014 20:23:47 +0100
Message-Id: <1392233027-3201-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/README b/android/README
index 75b0a83..3095383 100644
--- a/android/README
+++ b/android/README
@@ -124,6 +124,12 @@ After changing property value Bluetooth need to be restarted to apply changes
 (this can be done using UI, just disable and enable it again). Property is
 persistent, i.e. there's no need to enable Valgrind again after reboot.
 
+It's recommended to have unstripped libglib.so installed which will enable
+complete backtraces in Valgrind output. Otherwise, in many cases backtrace
+will break at e.g. g_free() function without prior callers. It's possible to
+have proper library installed automatically by appropriate entry in Android.mk,
+see https://code.google.com/p/aosp-bluez.glib/ for an example.
+
 =============================
 Building and running on Linux
 =============================
-- 
1.8.5.4

