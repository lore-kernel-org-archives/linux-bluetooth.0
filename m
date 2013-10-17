Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] build: Add Android HAL headers to EXTRA_DIST
Date: Thu, 17 Oct 2013 12:08:06 +0200
Message-ID: <1382004486-24512-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382004486-24512-1-git-send-email-szymon.janc@tieto.com>
References: <1382004486-24512-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.android | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Makefile.android b/Makefile.android
index 4d7da39..895b0fa 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -15,3 +15,17 @@ endif
 EXTRA_DIST += android/Android.mk android/log.c
 
 EXTRA_DIST += android/hal-ipc-api.txt
+
+EXTRA_DIST += android/hardware/bluetooth.h \
+		android/hardware/bt_av.h \
+		android/hardware/bt_gatt.h \
+		android/hardware/bt_gatt_client.h \
+		android/hardware/bt_gatt_server.h \
+		android/hardware/bt_gatt_types.h \
+		android/hardware/bt_hf.h \
+		android/hardware/bt_hh.h \
+		android/hardware/bt_hl.h \
+		android/hardware/bt_pan.h \
+		android/hardware/bt_rc.h \
+		android/hardware/bt_sock.h \
+		android/hardware/hardware.h
-- 
1.8.4

