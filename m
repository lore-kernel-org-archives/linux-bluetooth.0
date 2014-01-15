Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 06/11] android/hal-audio: Add support to resume output stream
Date: Wed, 15 Jan 2014 19:03:52 +0100
Message-ID: <1389809037-11575-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to resume output stream via Audio IPC.
Stream is automatically resumed on first write when stream is in
standby state.
---
 android/hal-audio.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2a6b6c4..1de8830 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -435,6 +435,21 @@ static int ipc_close_stream_cmd(uint8_t endpoint_id)
 	return result;
 }
 
+static int ipc_resume_stream_cmd(uint8_t endpoint_id)
+{
+	struct audio_cmd_resume_stream cmd;
+	int result;
+
+	DBG("");
+
+	cmd.id = endpoint_id;
+
+	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_RESUME_STREAM,
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	return result;
+}
+
 static int register_endpoints(void)
 {
 	struct audio_endpoint *ep = &audio_endpoints[0];
@@ -473,8 +488,26 @@ static void unregister_endpoints(void)
 static ssize_t out_write(struct audio_stream_out *stream, const void *buffer,
 								size_t bytes)
 {
-	DBG("");
-	return -ENOSYS;
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+
+	/* We can auto-start only from standby */
+	if (out->audio_state == AUDIO_A2DP_STATE_STANDBY) {
+		DBG("stream in standby, auto-start");
+
+		if (ipc_resume_stream_cmd(out->ep->id) != AUDIO_STATUS_SUCCESS)
+			return -1;
+
+		out->audio_state = AUDIO_A2DP_STATE_STARTED;
+	}
+
+	if (out->audio_state != AUDIO_A2DP_STATE_STARTED) {
+		DBG("stream not started");
+		return -1;
+	}
+
+	/* TODO: encode data using codec */
+
+	return bytes;
 }
 
 static uint32_t out_get_sample_rate(const struct audio_stream *stream)
-- 
1.8.5.2

