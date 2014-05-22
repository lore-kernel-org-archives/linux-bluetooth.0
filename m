Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 10/12] android/gatt: Add crypto needed for sign write
Date: Thu, 22 May 2014 10:07:40 +0200
Message-Id: <1400746062-24766-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk  |  1 +
 android/Makefile.am |  1 +
 android/gatt.c      | 11 ++++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index 4235a7c..4548ed7 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -53,6 +53,7 @@ LOCAL_SRC_FILES := \
 	bluez/src/shared/hfp.c \
 	bluez/src/shared/gatt-db.c \
 	bluez/src/shared/io-glib.c \
+	bluez/src/shared/crypto.c \
 	bluez/src/sdpd-database.c \
 	bluez/src/sdpd-service.c \
 	bluez/src/sdpd-request.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index e663790..1bde83d 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -31,6 +31,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/shared/ringbuf.h src/shared/ringbuf.c \
 				src/shared/hfp.h src/shared/hfp.c \
 				src/shared/gatt-db.h src/shared/gatt-db.c \
+				src/shared/crypto.h src/shared/crypto.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/ipc-common.h \
diff --git a/android/gatt.c b/android/gatt.c
index 89da60d..90f52f4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -44,6 +44,7 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
+#include "src/shared/crypto.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
@@ -180,6 +181,8 @@ static struct gatt_db *gatt_db = NULL;
 
 static GIOChannel *listening_io = NULL;
 
+static struct bt_crypto *crypto = NULL;
+
 static void bt_le_discovery_stop_cb(void);
 
 static bool is_bluetooth_uuid(const uint8_t *uuid)
@@ -5144,9 +5147,10 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	app_connections = queue_new();
 	listen_apps = queue_new();
 	gatt_db = gatt_db_new();
+	crypto = bt_crypto_new();
 
 	if (!gatt_devices || !gatt_apps || !listen_apps ||
-						!app_connections || !gatt_db) {
+				!app_connections || !gatt_db || !crypto) {
 		error("gatt: Failed to allocate memory for queues");
 
 		queue_destroy(gatt_apps, NULL);
@@ -5167,6 +5171,8 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		g_io_channel_unref(listening_io);
 		listening_io = NULL;
 
+		bt_crypto_unref(crypto);
+
 		return false;
 	}
 
@@ -5208,4 +5214,7 @@ void bt_gatt_unregister(void)
 
 	g_io_channel_unref(listening_io);
 	listening_io = NULL;
+
+	bt_crypto_unref(crypto);
+	crypto = NULL;
 }
-- 
1.8.4

