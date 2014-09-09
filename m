Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 33/39] android/hf-client: Add Command Complete event
Date: Tue,  9 Sep 2014 21:57:18 +0200
Message-Id: <1410292644-23497-34-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       | 15 +++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 5ea90b0..c4a4943 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -209,6 +209,14 @@ static void handle_volume_change(void *buf, uint16_t len, int fd)
 		cbs->volume_change_cb(ev->type, ev->volume);
 }
 
+static void handle_command_cmp(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_command_complete *ev = buf;
+
+	if (cbs->cmd_complete_cb)
+		cbs->cmd_complete_cb(ev->type, ev->cme);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -261,6 +269,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_CLIENT_VOLUME_CHANGED */
 	{ handle_volume_change, false,
 			sizeof(struct hal_ev_hf_client_volume_changed) },
+	/* HAL_EV_CLIENT_COMMAND_COMPLETE */
+	{ handle_command_cmp, false,
+			sizeof(struct hal_ev_hf_client_command_complete) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5da512c..b88da52 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1830,3 +1830,18 @@ struct hal_ev_hf_client_volume_changed {
 	uint8_t type;
 	uint8_t volume;
 } __attribute__((packed));
+
+#define HF_CLIENT_CMD_COMP_OK			0x00
+#define HF_CLIENT_CMD_COMP_ERR			0x01
+#define HF_CLIENT_CMD_COMP_ERR_NO_CARRIER	0x02
+#define HF_CLIENT_CMD_COMP_ERR_BUSY		0x03
+#define HF_CLIENT_CMD_COMP_ERR_NO_ANSWER	0x04
+#define HF_CLIENT_CMD_COMP_ERR_DELAYED		0x05
+#define HF_CLIENT_CMD_COMP_ERR_BACKLISTED	0x06
+#define HF_CLIENT_CMD_COMP_ERR_CME		0x07
+
+#define HAL_EV_CLIENT_COMMAND_COMPLETE			0x91
+struct hal_ev_hf_client_command_complete {
+	uint8_t type;
+	uint8_t cme;
+} __attribute__((packed));
-- 
1.8.4

