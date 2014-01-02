Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/10] android/A2DP: Add stream close command/response struct
Date: Thu,  2 Jan 2014 13:58:32 +0200
Message-Id: <1388663914-25003-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
References: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to stream close command and response.
---
 android/a2dp.c    | 10 ++++++++++
 android/hal-msg.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 7709b15..eac427d 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -376,6 +376,14 @@ static void bt_stream_open(const void *buf, uint16_t len)
 							HAL_STATUS_FAILED);
 }
 
+static void bt_stream_close(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	audio_ipc_send_rsp(AUDIO_SERVICE_ID_CORE, AUDIO_OP_CLOSE_STREAM,
+							HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
 	/* AUDIO_OP_OPEN */
 	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
@@ -383,6 +391,8 @@ static const struct ipc_handler audio_handlers[] = {
 	{ bt_audio_close, false, sizeof(struct audio_cmd_close) },
 	/* AUDIO_OP_OPEN_STREAM */
 	{ bt_stream_open, false, sizeof(struct audio_cmd_open_stream) },
+	/* AUDIO_OP_CLOSE_STREAM */
+	{ bt_stream_close, false, sizeof(struct audio_cmd_close_stream) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ff62de0..a708157 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -603,3 +603,8 @@ struct audio_rsp_open_stream {
 	uint8_t len;
 	uint8_t data[0];
 } __attribute__((packed));
+
+#define AUDIO_OP_CLOSE_STREAM			0x04
+struct audio_cmd_close_stream {
+	uint8_t id;
+} __attribute__((packed));
-- 
1.8.4.2

