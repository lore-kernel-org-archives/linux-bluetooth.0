Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android: Suppress compiler warnings not used in autotools build
Date: Tue, 29 Oct 2013 16:23:38 +0100
Message-ID: <1383060218-25693-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383060218-25693-1-git-send-email-szymon.janc@tieto.com>
References: <1383060218-25693-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android build system is enabling some additional warnings that are not
enabled when building with autotools. This avoids spurious warnings
while building on Android.
---
 android/Android.mk | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index c88b27e..fc1b276 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -9,6 +9,9 @@ pathmap_INCL += glib:external/bluetooth/glib
 # Specify common compiler flags
 BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 
+# Disable warnings enabled by Android but not enabled in autotools build
+BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith
+
 #
 # Android BlueZ daemon (bluetoothd)
 #
-- 
1.8.4.1

