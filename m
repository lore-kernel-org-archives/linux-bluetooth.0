Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 32/39] android/hf-client: Add Volume Changed event
Date: Tue,  9 Sep 2014 21:57:17 +0200
Message-Id: <1410292644-23497-33-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 11 +++++++++++
 android/hal-msg.h       |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 4e31421..5ea90b0 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -201,6 +201,14 @@ static void handle_current_calls(void *buf, uint16_t len, int fd)
 							ev->multiparty, number);
 }
 
+static void handle_volume_change(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_hf_client_volume_changed *ev = buf;
+
+	if (cbs->volume_change_cb)
+		cbs->volume_change_cb(ev->type, ev->volume);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -250,6 +258,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HF_CLIENT_CURRENT_CALL */
 	{ handle_current_calls, true,
 			sizeof(struct hal_ev_hf_client_current_call) },
+	/* HAL_EV_CLIENT_VOLUME_CHANGED */
+	{ handle_volume_change, false,
+			sizeof(struct hal_ev_hf_client_volume_changed) },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 01a1711..5da512c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1824,3 +1824,9 @@ struct hal_ev_hf_client_current_call {
 	uint16_t number_len;
 	uint8_t number[0];
 } __attribute__((packed));
+
+#define HAL_EV_CLIENT_VOLUME_CHANGED			0x90
+struct hal_ev_hf_client_volume_changed {
+	uint8_t type;
+	uint8_t volume;
+} __attribute__((packed));
-- 
1.8.4

