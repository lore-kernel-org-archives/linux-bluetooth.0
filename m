Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Disable format warnings in Android
Date: Wed, 30 Oct 2013 12:30:43 +0200
Message-Id: <1383129043-30582-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android's bionic library has bug defining ssize_t (which is fixed in
Android 4.3). This seems to be the most appropriate solution until
we move to Android 4.3.
---
 android/Android.mk |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index fc1b276..db55d37 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -12,6 +12,10 @@ BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 # Disable warnings enabled by Android but not enabled in autotools build
 BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith
 
+# Disable warning: format '%zd' expects argument of type 'signed size_t',
+# but argument 4 has type 'ssize_t'
+BLUEZ_COMMON_CFLAGS += -Wno-format
+
 #
 # Android BlueZ daemon (bluetoothd)
 #
-- 
1.7.10.4

