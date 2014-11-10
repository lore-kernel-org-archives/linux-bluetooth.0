Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 5/5] android/avrcp: Add initial support for new AVRCP CTRL interface
Date: Mon, 10 Nov 2014 16:05:09 +0200
Message-Id: <1415628309-7384-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp.c | 72 +++++++++++++++++++++++++++++++++++++++++++++------------
 android/avrcp.h |  4 ++++
 android/main.c  | 11 +++++++++
 3 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index a0d412d..f372128 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -1082,21 +1082,6 @@ bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	}
 	record_tg_id = rec->handle;
 
-	rec = avrcp_ct_record();
-	if (!rec) {
-		error("Failed to allocate AVRCP CT record");
-		bt_adapter_remove_record(record_tg_id);
-		goto fail;
-	}
-
-	if (bt_adapter_add_record(rec, 0) < 0) {
-		error("Failed to register AVRCP CT record");
-		bt_adapter_remove_record(record_tg_id);
-		sdp_record_free(rec);
-		goto fail;
-	}
-	record_ct_id = rec->handle;
-
 	hal_ipc = ipc;
 
 	ipc_register(hal_ipc, HAL_SERVICE_ID_AVRCP, cmd_handlers,
@@ -1171,3 +1156,60 @@ void bt_avrcp_disconnect(const bdaddr_t *dst)
 
 	avrcp_device_remove(dev);
 }
+
+static void handle_send_passthrough(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL,
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
+	rec = avrcp_ct_record();
+	if (!rec) {
+		error("Failed to allocate AVRCP CT record");
+		goto fail;
+	}
+
+	if (bt_adapter_add_record(rec, 0) < 0) {
+		error("Failed to register AVRCP CT record");
+		sdp_record_free(rec);
+		goto fail;
+	}
+
+	record_ct_id = rec->handle;
+
+	if (!hal_ipc)
+		hal_ipc = ipc;
+
+	ipc_register(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL, ctrl_cmd_handlers,
+					G_N_ELEMENTS(ctrl_cmd_handlers));
+
+	return true;
+
+fail:
+	return false;
+}
+
+void bt_avrcp_ctrl_unregister(void)
+{
+	DBG("");
+
+	ipc_unregister(hal_ipc, HAL_SERVICE_ID_AVRCP_CTRL);
+
+	bt_adapter_remove_record(record_ct_id);
+	record_ct_id = 0;
+}
diff --git a/android/avrcp.h b/android/avrcp.h
index 11e79b7..0af9f14 100644
--- a/android/avrcp.h
+++ b/android/avrcp.h
@@ -24,5 +24,9 @@
 bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_avrcp_unregister(void);
 
+bool bt_avrcp_ctrl_register(struct ipc *ipc, const bdaddr_t *addr,
+								uint8_t mode);
+void bt_avrcp_ctrl_unregister(void);
+
 void bt_avrcp_connect(const bdaddr_t *dst);
 void bt_avrcp_disconnect(const bdaddr_t *dst);
diff --git a/android/main.c b/android/main.c
index 58dd9ab..21becf6 100644
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
 		bt_avrcp_unregister();
 		break;
+	case HAL_SERVICE_ID_AVRCP_CTRL:
+		bt_avrcp_ctrl_unregister();
+		break;
 	case HAL_SERVICE_ID_HANDSFREE:
 		bt_handsfree_unregister();
 		break;
-- 
2.1.0

