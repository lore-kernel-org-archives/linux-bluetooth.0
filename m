Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 09/10] android/A2DP: Add stream resume command/response struct
Date: Tue,  7 Jan 2014 13:53:22 +0200
Message-Id: <1389095603-30504-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
References: <1389095603-30504-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to stream resume command and response.
---
 android/a2dp.c      | 9 +++++++++
 android/audio-msg.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 7c49bc9..5d540f3 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -382,6 +382,13 @@ static void bt_stream_close(const void *buf, uint16_t len)
 	audio_ipc_send_rsp(AUDIO_OP_CLOSE_STREAM, AUDIO_STATUS_FAILED);
 }
 
+static void bt_stream_resume(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	audio_ipc_send_rsp(AUDIO_OP_RESUME_STREAM, AUDIO_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
 	/* AUDIO_OP_OPEN */
 	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
@@ -391,6 +398,8 @@ static const struct ipc_handler audio_handlers[] = {
 	{ bt_stream_open, false, sizeof(struct audio_cmd_open_stream) },
 	/* AUDIO_OP_CLOSE_STREAM */
 	{ bt_stream_close, false, sizeof(struct audio_cmd_close_stream) },
+	/* AUDIO_OP_RESUME_STREAM */
+	{ bt_stream_resume, false, sizeof(struct audio_cmd_resume_stream) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/audio-msg.h b/android/audio-msg.h
index 4dfa8cf..8f92413 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -72,3 +72,8 @@ struct audio_rsp_open_stream {
 struct audio_cmd_close_stream {
 	uint8_t id;
 } __attribute__((packed));
+
+#define AUDIO_OP_RESUME_STREAM		0x05
+struct audio_cmd_resume_stream {
+	uint8_t id;
+} __attribute__((packed));
-- 
1.8.4.2

