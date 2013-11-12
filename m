Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/7] android: Report adapter address in adapter_ready callback
Date: Tue, 12 Nov 2013 00:24:14 +0000
Message-Id: <1384215857-19679-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
References: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adapter is not going to change while daemon is running so its address
can be stored after init is complete.
---
 android/adapter.c | 14 +++++++-------
 android/adapter.h |  2 +-
 android/main.c    |  7 +++++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 0c090bf..f337b5e 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -929,11 +929,11 @@ static void load_link_keys_complete(uint8_t status, uint16_t length,
 
 	DBG("status %u", status);
 
-	adapter_ready(0);
+	adapter_ready(0, &adapter_bdaddr);
 	return;
 
 failed:
-	adapter_ready(err);
+	adapter_ready(err, NULL);
 }
 
 static void load_link_keys(GSList *keys)
@@ -968,7 +968,7 @@ static void load_link_keys(GSList *keys)
 
 	if (id == 0) {
 		error("Failed to load link keys");
-		adapter_ready(-EIO);
+		adapter_ready(-EIO, NULL);
 	}
 }
 
@@ -1138,7 +1138,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	return;
 
 failed:
-	adapter_ready(err);
+	adapter_ready(err, NULL);
 }
 
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
@@ -1158,7 +1158,7 @@ static void mgmt_index_added_event(uint16_t index, uint16_t length,
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
 				read_info_complete, NULL, NULL) == 0) {
-		adapter_ready(-EIO);
+		adapter_ready(-EIO, NULL);
 		return;
 	}
 }
@@ -1224,7 +1224,7 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 	return;
 
 failed:
-	adapter_ready(-EIO);
+	adapter_ready(-EIO, NULL);
 }
 
 static void read_version_complete(uint8_t status, uint16_t length,
@@ -1269,7 +1269,7 @@ static void read_version_complete(uint8_t status, uint16_t length,
 	error("Failed to read controller index list");
 
 failed:
-	adapter_ready(-EIO);
+	adapter_ready(-EIO, NULL);
 }
 
 bool bt_adapter_start(int index, bt_adapter_ready cb)
diff --git a/android/adapter.h b/android/adapter.h
index c9f0083..96136bb 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -21,7 +21,7 @@
  *
  */
 
-typedef void (*bt_adapter_ready)(int err);
+typedef void (*bt_adapter_ready)(int err, const bdaddr_t *addr);
 bool bt_adapter_start(int index, bt_adapter_ready cb);
 
 typedef void (*bt_adapter_stopped)(void);
diff --git a/android/main.c b/android/main.c
index f82e6d8..27513f8 100644
--- a/android/main.c
+++ b/android/main.c
@@ -65,6 +65,8 @@
 
 static guint bluetooth_start_timeout = 0;
 
+static const bdaddr_t *adapter_bdaddr = NULL;
+
 static GMainLoop *event_loop;
 
 static GIOChannel *hal_cmd_io = NULL;
@@ -75,7 +77,6 @@ static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 static void service_register(void *buf, uint16_t len)
 {
 	struct hal_cmd_register_module *m = buf;
-	const bdaddr_t *adapter_bdaddr = bt_adapter_get_address();
 	int sk = g_io_channel_unix_get_fd(hal_notif_io);
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
@@ -365,13 +366,15 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
-static void adapter_ready(int err)
+static void adapter_ready(int err, const bdaddr_t *addr)
 {
 	if (err < 0) {
 		error("Adapter initialization failed: %s", strerror(-err));
 		exit(EXIT_FAILURE);
 	}
 
+	adapter_bdaddr = addr;
+
 	if (bluetooth_start_timeout > 0) {
 		g_source_remove(bluetooth_start_timeout);
 		bluetooth_start_timeout = 0;
-- 
1.8.4.2

