Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 37/39] android/hf-client: Add RING notification event
Date: Tue,  9 Sep 2014 21:57:22 +0200
Message-Id: <1410292644-23497-38-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 8 ++++++++
 android/hal-msg.h       | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index ff3c050..1dea263 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -263,6 +263,12 @@ static void handle_last_voice_tag_number(void *buf, uint16_t len, int fd)
 		cbs->last_voice_tag_number_callback(number);
 }
 
+static void handle_ring_indication(void *buf, uint16_t len, int fd)
+{
+	if (cbs->ring_indication_cb)
+		cbs->ring_indication_cb();
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -327,6 +333,8 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_CLIENT_LAST_VOICE_CALL_TAG_NUM */
 	{ handle_last_voice_tag_number, true,
 		sizeof(struct hal_ev_hf_client_last_void_call_tag_num) },
+	/* HAL_EV_CLIENT_RING_INDICATION */
+	{ handle_ring_indication, false, 0 },
 };
 
 static bt_status_t init(bthf_client_callbacks_t *callbacks)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index f09dcf0..16a341d 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1870,3 +1870,5 @@ struct hal_ev_hf_client_last_void_call_tag_num {
 	uint16_t number_len;
 	uint8_t number[0];
 } __attribute__((packed));
+
+#define HAL_EV_CLIENT_RING_INDICATION			0x95
-- 
1.8.4

