Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 7/9] android: Add stream resume command/response struct
Date: Mon, 30 Dec 2013 14:34:13 +0200
Message-Id: <1388406855-8809-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
References: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to stream resume command and response.
---
 android/a2dp.c    | 10 ++++++++++
 android/hal-msg.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 2dba482..284d44d 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -382,6 +382,14 @@ static void bt_stream_close(const void *buf, uint16_t len)
 							HAL_STATUS_FAILED);
 }
 
+static void bt_stream_resume(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AUDIO, AUDIO_OP_RESUME_STREAM,
+							HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
 	/* AUDIO_OP_OPEN */
 	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
@@ -391,6 +399,8 @@ static const struct ipc_handler audio_handlers[] = {
 	{ bt_stream_open, false, sizeof(struct audio_cmd_open_stream) },
 	/* AUDIO_OP_CLOSE_STREAM */
 	{ bt_stream_close, false, sizeof(struct audio_cmd_close_stream) },
+	/* AUDIO_OP_RESUME_STREAM */
+	{ bt_stream_resume, false, sizeof(struct audio_cmd_resume_stream) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2816f6f..fe433d1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -605,3 +605,8 @@ struct audio_rsp_open_stream {
 struct audio_cmd_close_stream {
 	uint8_t id;
 } __attribute__((packed));
+
+#define AUDIO_OP_RESUME_STREAM			0x05
+struct audio_cmd_resume_stream {
+	uint8_t id;
+} __attribute__((packed));
-- 
1.8.4.2

