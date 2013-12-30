Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 4/9] android: Add audio close command/response struct
Date: Mon, 30 Dec 2013 14:34:10 +0200
Message-Id: <1388406855-8809-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
References: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to audio close command and response.
---
 android/a2dp.c    | 9 +++++++++
 android/hal-msg.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 5cb01f7..43590f0 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -359,9 +359,18 @@ static void bt_audio_open(const void *buf, uint16_t len)
 	ipc_send_rsp(HAL_SERVICE_ID_AUDIO, AUDIO_OP_OPEN, HAL_STATUS_FAILED);
 }
 
+static void bt_audio_close(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AUDIO, AUDIO_OP_CLOSE, HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
 	/* AUDIO_OP_OPEN */
 	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
+	/* AUDIO_OP_CLOSE */
+	{ bt_audio_close, false, sizeof(struct audio_cmd_close) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4b52e5e..f359952 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -585,3 +585,8 @@ struct audio_preset {
 struct audio_rsp_open {
 	uint8_t id;
 } __attribute__((packed));
+
+#define AUDIO_OP_CLOSE				0x02
+struct audio_cmd_close {
+	uint8_t id;
+} __attribute__((packed));
-- 
1.8.4.2

