Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/10] android/A2DP: Add stream open command/response struct
Date: Thu,  2 Jan 2014 13:58:31 +0200
Message-Id: <1388663914-25003-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
References: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to stream open command and response.
---
 android/a2dp.c    | 10 ++++++++++
 android/hal-msg.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index e3d58ca..7709b15 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -368,11 +368,21 @@ static void bt_audio_close(const void *buf, uint16_t len)
 							HAL_STATUS_FAILED);
 }
 
+static void bt_stream_open(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	audio_ipc_send_rsp(AUDIO_SERVICE_ID_CORE, AUDIO_OP_OPEN_STREAM,
+							HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
 	/* AUDIO_OP_OPEN */
 	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
 	/* AUDIO_OP_CLOSE */
 	{ bt_audio_close, false, sizeof(struct audio_cmd_close) },
+	/* AUDIO_OP_OPEN_STREAM */
+	{ bt_stream_open, false, sizeof(struct audio_cmd_open_stream) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index d1135df..ff62de0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -593,3 +593,13 @@ struct audio_rsp_open {
 struct audio_cmd_close {
 	uint8_t id;
 } __attribute__((packed));
+
+#define AUDIO_OP_OPEN_STREAM			0x03
+struct audio_cmd_open_stream {
+	uint8_t id;
+} __attribute__((packed));
+
+struct audio_rsp_open_stream {
+	uint8_t len;
+	uint8_t data[0];
+} __attribute__((packed));
-- 
1.8.4.2

