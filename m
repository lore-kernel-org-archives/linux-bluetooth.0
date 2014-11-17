Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/4] android/avrcp: Rename avrcp_register and avrcp_unregister calls
Date: Mon, 17 Nov 2014 14:59:14 +0200
Message-Id: <1416229157-10128-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android Lollipop has separate interface for AVRCP cotroller. Current
AVRCP interface named it as AVRCP Target.
---
 android/avrcp.c | 4 ++--
 android/avrcp.h | 4 ++--
 android/main.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index a0d412d..57f60df 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -1049,7 +1049,7 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 	dev->io = g_io_channel_ref(chan);
 }
 
-bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
+bool bt_avrcp_tgt_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	GError *err = NULL;
 	sdp_record_t *rec;
@@ -1111,7 +1111,7 @@ fail:
 	return false;
 }
 
-void bt_avrcp_unregister(void)
+void bt_avrcp_tgt_unregister(void)
 {
 	DBG("");
 
diff --git a/android/avrcp.h b/android/avrcp.h
index 11e79b7..cd109a7 100644
--- a/android/avrcp.h
+++ b/android/avrcp.h
@@ -21,8 +21,8 @@
  *
  */
 
-bool bt_avrcp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
-void bt_avrcp_unregister(void);
+bool bt_avrcp_tgt_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
+void bt_avrcp_tgt_unregister(void);
 
 void bt_avrcp_connect(const bdaddr_t *dst);
 void bt_avrcp_disconnect(const bdaddr_t *dst);
diff --git a/android/main.c b/android/main.c
index 58dd9ab..ee1e3a0 100644
--- a/android/main.c
+++ b/android/main.c
@@ -202,7 +202,7 @@ static void service_register(const void *buf, uint16_t len)
 
 		break;
 	case HAL_SERVICE_ID_AVRCP:
-		if (!bt_avrcp_register(hal_ipc, &adapter_bdaddr, m->mode)) {
+		if (!bt_avrcp_tgt_register(hal_ipc, &adapter_bdaddr, m->mode)) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
 		}
@@ -284,7 +284,7 @@ static bool unregister_service(uint8_t id)
 		bt_pan_unregister();
 		break;
 	case HAL_SERVICE_ID_AVRCP:
-		bt_avrcp_unregister();
+		bt_avrcp_tgt_unregister();
 		break;
 	case HAL_SERVICE_ID_HANDSFREE:
 		bt_handsfree_unregister();
-- 
2.1.0

