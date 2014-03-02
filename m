Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 4/8] android/handsfree: Factor out HFP AG enable code
Date: Mon,  3 Mar 2014 00:50:45 +0100
Message-Id: <1393804249-12392-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
References: <1393804249-12392-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is in preparation for support to not enable HFP AG when
initializing HAL.
---
 android/handsfree.c | 77 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index cfdcc1a..7a1d697 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -56,10 +56,10 @@ static struct {
 } device;
 
 static bdaddr_t adapter_addr;
-static uint32_t record_id = 0;
 static struct ipc *hal_ipc = NULL;
 
-static GIOChannel *server = NULL;
+static uint32_t hfp_record_id = 0;
+static GIOChannel *hfp_server = NULL;
 
 static void device_set_state(uint8_t state)
 {
@@ -460,7 +460,7 @@ static const struct ipc_handler cmd_handlers[] = {
 			sizeof(struct hal_cmd_handsfree_phone_state_change)},
 };
 
-static sdp_record_t *handsfree_ag_record(void)
+static sdp_record_t *hfp_ag_record(void)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
@@ -532,27 +532,28 @@ static sdp_record_t *handsfree_ag_record(void)
 	return record;
 }
 
-bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+static bool enable_hfp_ag(void)
 {
 	sdp_record_t *rec;
 	GError *err = NULL;
 
 	DBG("");
 
-	bacpy(&adapter_addr, addr);
+	if (hfp_server)
+		return false;
 
-	server =  bt_io_listen( NULL, confirm_cb, NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_CHANNEL, HFP_AG_CHANNEL,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID);
-	if (!server) {
+	hfp_server =  bt_io_listen(NULL, confirm_cb, NULL, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+					BT_IO_OPT_CHANNEL, HFP_AG_CHANNEL,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+	if (!hfp_server) {
 		error("Failed to listen on Handsfree rfcomm: %s", err->message);
 		g_error_free(err);
-		return false;
+		goto failed;
 	}
 
-	rec = handsfree_ag_record();
+	rec = hfp_ag_record();
 	if (!rec) {
 		error("Failed to allocate Handsfree record");
 		goto failed;
@@ -563,22 +564,49 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 		sdp_record_free(rec);
 		goto failed;
 	}
-	record_id = rec->handle;
 
-	hal_ipc = ipc;
-	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
-						G_N_ELEMENTS(cmd_handlers));
+	hfp_record_id = rec->handle;
 
 	return true;
 
 failed:
-	g_io_channel_shutdown(server, TRUE, NULL);
-	g_io_channel_unref(server);
-	server = NULL;
+	g_io_channel_shutdown(hfp_server, TRUE, NULL);
+	g_io_channel_unref(hfp_server);
+	hfp_server = NULL;
 
 	return false;
 }
 
+static void cleanup_hfp_ag(void)
+{
+	if (hfp_server) {
+		g_io_channel_shutdown(hfp_server, TRUE, NULL);
+		g_io_channel_unref(hfp_server);
+		hfp_server = NULL;
+	}
+
+	if (hfp_record_id > 0) {
+		bt_adapter_remove_record(hfp_record_id);
+		hfp_record_id = 0;
+	}
+}
+
+bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+{
+	DBG("");
+
+	bacpy(&adapter_addr, addr);
+
+	if (!enable_hfp_ag())
+		return false;
+
+	hal_ipc = ipc;
+	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
+						G_N_ELEMENTS(cmd_handlers));
+
+	return true;
+}
+
 void bt_handsfree_unregister(void)
 {
 	DBG("");
@@ -586,12 +614,5 @@ void bt_handsfree_unregister(void)
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
 	hal_ipc = NULL;
 
-	if (server) {
-		g_io_channel_shutdown(server, TRUE, NULL);
-		g_io_channel_unref(server);
-		server = NULL;
-	}
-
-	bt_adapter_remove_record(record_id);
-	record_id = 0;
+	cleanup_hfp_ag();
 }
-- 
1.8.5.3

