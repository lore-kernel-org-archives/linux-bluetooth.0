Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/10] android/A2DP: Add stream suspend command/response struct
Date: Thu,  2 Jan 2014 13:58:34 +0200
Message-Id: <1388663914-25003-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
References: <1388663914-25003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the definitions to stream suspend command and response.
---
 android/a2dp.c    | 10 ++++++++++
 android/hal-msg.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index d3c02d6..dc2890c 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -392,6 +392,14 @@ static void bt_stream_resume(const void *buf, uint16_t len)
 							HAL_STATUS_FAILED);
 }
 
+static void bt_stream_suspend(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	audio_ipc_send_rsp(AUDIO_SERVICE_ID_CORE, AUDIO_OP_SUSPEND_STREAM,
+							HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler audio_handlers[] = {
 	/* AUDIO_OP_OPEN */
 	{ bt_audio_open, true, sizeof(struct audio_cmd_open) },
@@ -403,6 +411,8 @@ static const struct ipc_handler audio_handlers[] = {
 	{ bt_stream_close, false, sizeof(struct audio_cmd_close_stream) },
 	/* AUDIO_OP_RESUME_STREAM */
 	{ bt_stream_resume, false, sizeof(struct audio_cmd_resume_stream) },
+	/* AUDIO_OP_SUSPEND_STREAM */
+	{ bt_stream_suspend, false, sizeof(struct audio_cmd_suspend_stream) },
 };
 
 bool bt_a2dp_register(const bdaddr_t *addr)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 259b687..6b2ec88 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -613,3 +613,8 @@ struct audio_cmd_close_stream {
 struct audio_cmd_resume_stream {
 	uint8_t id;
 } __attribute__((packed));
+
+#define AUDIO_OP_SUSPEND_STREAM			0x06
+struct audio_cmd_suspend_stream {
+	uint8_t id;
+} __attribute__((packed));
-- 
1.8.4.2

