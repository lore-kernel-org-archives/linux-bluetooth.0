Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/4] android/hal: Update HidHost HAL for Android 5
Date: Thu, 20 Nov 2014 12:18:49 +0100
Message-Id: <1416482331-3766-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416482331-3766-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416482331-3766-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 11 +++++++++++
 android/hal-msg.h     | 24 ++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 58b0218..3cfc6b6 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -102,6 +102,16 @@ static void handle_virtual_unplug(void *buf, uint16_t len, int fd)
 								ev->status);
 }
 
+static void handle_handshake(void *buf, uint16_t len, int fd)
+{
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	struct hal_ev_hidhost_handshake *ev = buf;
+
+	if (cbacks->handshake_cb)
+		cbacks->handshake_cb((bt_bdaddr_t *) ev->bdaddr, ev->status);
+#endif
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -120,6 +130,7 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HIDHOST_VIRTUAL_UNPLUG */
 	{ handle_virtual_unplug, false,
 				sizeof(struct hal_ev_hidhost_virtual_unplug) },
+	{ handle_handshake, false, sizeof(struct hal_ev_hidhost_handshake) },
 };
 
 static bt_status_t hidhost_connect(bt_bdaddr_t *bd_addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index c575938..ca512d4 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1353,8 +1353,22 @@ struct hal_ev_hidhost_conn_state {
 	uint8_t state;
 } __attribute__((packed));
 
-#define HAL_HIDHOST_STATUS_OK		0x00
-#define HAL_HIDHOST_GENERAL_ERROR	0x06
+#define HAL_HIDHOST_STATUS_OK			0x00
+
+#define HAL_HIDHOST_HS_NOT_READY		0x01
+#define HAL_HIDHOST_HS_INVALID_RAPORT_ID	0x02
+#define HAL_HIDHOST_HS_TRANS_NOT_SUPPORTED	0x03
+#define HAL_HIDHOST_HS_INVALID_PARAM		0x04
+#define HAL_HIDHOST_HS_ERROR			0x05
+
+#define HAL_HIDHOST_GENERAL_ERROR		0x06
+#define HAL_HIDHOST_SDP_ERROR			0x07
+#define HAL_HIDHOST_PROTOCOL_ERROR		0x08
+#define HAL_HIDHOST_DB_ERROR			0x09
+#define HAL_HIDHOST_TOD_UNSUPPORTED_ERROR	0x0a
+#define HAL_HIDHOST_NO_RESOURCES_ERROR		0x0b
+#define HAL_HIDHOST_AUTH_FAILED_ERROR		0x0c
+#define HAL_HIDHOST_HDL_ERROR			0x0d
 
 #define HAL_EV_HIDHOST_INFO			0x82
 struct hal_ev_hidhost_info {
@@ -1398,6 +1412,12 @@ struct hal_ev_hidhost_virtual_unplug {
 	uint8_t  status;
 } __attribute__((packed));
 
+#define HAL_EV_HIDHOST_HANDSHAKE		0x87
+struct hal_ev_hidhost_handshake {
+	uint8_t  bdaddr[6];
+	uint8_t  status;
+} __attribute__((packed));
+
 #define HAL_EV_PAN_CTRL_STATE			0x81
 struct hal_ev_pan_ctrl_state {
 	uint8_t  state;
-- 
1.9.1

