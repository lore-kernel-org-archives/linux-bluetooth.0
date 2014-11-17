Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/4] android/avrcp: Add initial support for new AVRCP CTRL interface
Date: Mon, 17 Nov 2014 14:59:15 +0200
Message-Id: <1416229157-10128-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1416229157-10128-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1416229157-10128-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp.c | 149 ++++++++++++++++++++++++++++++++++++++++++++------------
 android/avrcp.h |   3 ++
 android/main.c  |  11 +++++
 3 files changed, 133 insertions(+), 30 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 57f60df..335b957 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -60,6 +60,7 @@ static uint32_t record_ct_id = 0;
 static GSList *devices = NULL;
 static GIOChannel *server = NULL;
 static struct ipc *hal_ipc = NULL;
+static struct ipc *hal_ipc_ctrl = NULL;
 
 struct avrcp_request {
 	struct avrcp_device *dev;
@@ -1049,12 +1050,9 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 	dev->io = g_io_channel_ref(chan);
 }
 
-bool bt_avrcp_tgt_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+static bool avrcp_register(const bdaddr_t *addr)
 {
 	GError *err = NULL;
-	sdp_record_t *rec;
-
-	DBG("");
 
 	bacpy(&adapter_addr, addr);
 
@@ -1069,6 +1067,32 @@ bool bt_avrcp_tgt_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 		return false;
 	}
 
+	return true;
+}
+
+static void avrcp_unregister(void)
+{
+	g_slist_free_full(devices, avrcp_device_free);
+	devices = NULL;
+
+	if (server) {
+		g_io_channel_shutdown(server, TRUE, NULL);
+		g_io_channel_unref(server);
+		server = NULL;
+	}
+}
+
+bool bt_avrcp_tgt_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+{
+	sdp_record_t *rec;
+
+	DBG("");
+
+	if (!server) {
+		if (!avrcp_register(addr))
+			goto fail;
+	}
+
 	rec = avrcp_tg_record();
 	if (!rec) {
 		error("Failed to allocate AVRCP TG record");
@@ -1082,20 +1106,22 @@ bool bt_avrcp_tgt_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	}
 	record_tg_id = rec->handle;
 
-	rec = avrcp_ct_record();
-	if (!rec) {
-		error("Failed to allocate AVRCP CT record");
-		bt_adapter_remove_record(record_tg_id);
-		goto fail;
-	}
+	if (!record_ct_id) {
+		rec = avrcp_ct_record();
+		if (!rec) {
+			error("Failed to allocate AVRCP CT record");
+			bt_adapter_remove_record(record_tg_id);
+			goto fail;
+		}
 
-	if (bt_adapter_add_record(rec, 0) < 0) {
-		error("Failed to register AVRCP CT record");
-		bt_adapter_remove_record(record_tg_id);
-		sdp_record_free(rec);
-		goto fail;
+		if (bt_adapter_add_record(rec, 0) < 0) {
+			error("Failed to register AVRCP CT record");
+			bt_adapter_remove_record(record_tg_id);
+			sdp_record_free(rec);
+			goto fail;
+		}
+		record_ct_id = rec->handle;
 	}
-	record_ct_id = rec->handle;
 
 	hal_ipc = ipc;
 
@@ -1104,10 +1130,7 @@ bool bt_avrcp_tgt_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 
 	return true;
 fail:
-	g_io_channel_shutdown(server, TRUE, NULL);
-	g_io_channel_unref(server);
-	server = NULL;
-
+	avrcp_unregister();
 	return false;
 }
 
@@ -1115,23 +1138,19 @@ void bt_avrcp_tgt_unregister(void)
 {
 	DBG("");
 
-	g_slist_free_full(devices, avrcp_device_free);
-	devices = NULL;
-
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_AVRCP);
 	hal_ipc = NULL;
 
 	bt_adapter_remove_record(record_tg_id);
 	record_tg_id = 0;
 
-	bt_adapter_remove_record(record_ct_id);
-	record_ct_id = 0;
-
-	if (server) {
-		g_io_channel_shutdown(server, TRUE, NULL);
-		g_io_channel_unref(server);
-		server = NULL;
+	if (!hal_ipc_ctrl) {
+		bt_adapter_remove_record(record_ct_id);
+		record_ct_id = 0;
 	}
+
+	if (server)
+		avrcp_unregister();
 }
 
 void bt_avrcp_connect(const bdaddr_t *dst)
@@ -1171,3 +1190,73 @@ void bt_avrcp_disconnect(const bdaddr_t *dst)
 
 	avrcp_device_remove(dev);
 }
+
+static void handle_send_passthrough(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	ipc_send_rsp(hal_ipc_ctrl, HAL_SERVICE_ID_AVRCP_CTRL,
+					HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH,
+							HAL_STATUS_UNSUPPORTED);
+}
+
+static const struct ipc_handler ctrl_cmd_handlers[] = {
+	/* HAL_OP_AVRCP_CTRL_SEND_PASSTHROUGH */
+	{ handle_send_passthrough, false,
+			sizeof(struct hal_cmd_avrcp_ctrl_send_passthrough) },
+};
+
+bool bt_avrcp_ctrl_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+{
+	sdp_record_t *rec;
+
+	DBG("");
+
+	if (!server) {
+		if (!avrcp_register(addr))
+			goto fail;
+	}
+
+	if (!record_ct_id) {
+		rec = avrcp_ct_record();
+		if (!rec) {
+			error("Failed to allocate AVRCP CT record");
+			goto fail;
+		}
+
+		if (bt_adapter_add_record(rec, 0) < 0) {
+			error("Failed to register AVRCP CT record");
+			sdp_record_free(rec);
+			goto fail;
+		}
+		record_ct_id = rec->handle;
+	}
+
+	hal_ipc_ctrl = ipc;
+
+	ipc_register(hal_ipc_ctrl, HAL_SERVICE_ID_AVRCP_CTRL, ctrl_cmd_handlers,
+					G_N_ELEMENTS(ctrl_cmd_handlers));
+
+	return true;
+
+fail:
+	if (!hal_ipc)
+		avrcp_unregister();
+
+	return false;
+}
+
+void bt_avrcp_ctrl_unregister(void)
+{
+	DBG("");
+
+	ipc_unregister(hal_ipc_ctrl, HAL_SERVICE_ID_AVRCP_CTRL);
+	hal_ipc_ctrl = NULL;
+
+	if (!hal_ipc) {
+		bt_adapter_remove_record(record_ct_id);
+		record_ct_id = 0;
+
+		avrcp_unregister();
+	}
+}
diff --git a/android/avrcp.h b/android/avrcp.h
index cd109a7..bcca02a 100644
--- a/android/avrcp.h
+++ b/android/avrcp.h
@@ -23,6 +23,9 @@
 
 bool bt_avrcp_tgt_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_avrcp_tgt_unregister(void);
+bool bt_avrcp_ctrl_register(struct ipc *ipc, const bdaddr_t *addr,
+								uint8_t mode);
+void bt_avrcp_ctrl_unregister(void);
 
 void bt_avrcp_connect(const bdaddr_t *dst);
 void bt_avrcp_disconnect(const bdaddr_t *dst);
diff --git a/android/main.c b/android/main.c
index ee1e3a0..ed5e09e 100644
--- a/android/main.c
+++ b/android/main.c
@@ -208,6 +208,14 @@ static void service_register(const void *buf, uint16_t len)
 		}
 
 		break;
+	case HAL_SERVICE_ID_AVRCP_CTRL:
+		if (!bt_avrcp_ctrl_register(hal_ipc, &adapter_bdaddr,
+								m->mode)) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+
+		break;
 	case HAL_SERVICE_ID_HANDSFREE:
 		if (!bt_handsfree_register(hal_ipc, &adapter_bdaddr, m->mode,
 							m->max_clients)) {
@@ -286,6 +294,9 @@ static bool unregister_service(uint8_t id)
 	case HAL_SERVICE_ID_AVRCP:
 		bt_avrcp_tgt_unregister();
 		break;
+	case HAL_SERVICE_ID_AVRCP_CTRL:
+		bt_avrcp_ctrl_unregister();
+		break;
 	case HAL_SERVICE_ID_HANDSFREE:
 		bt_handsfree_unregister();
 		break;
-- 
2.1.0

