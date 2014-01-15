Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 07/10] android/hal-audio: Add support to suspend output stream
Date: Wed, 15 Jan 2014 10:59:54 +0100
Message-ID: <1389779996-9749-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to suspend output stream via Audio IPC.
>From HAL perspective stream can be either in standby or suspended -
the former is default one and can be auto-resumed on write while the
latter cannot be resumed only after explicitly going into standby
on audio code request.
---
 android/hal-audio.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 3c799e3..224c3d1 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -430,6 +430,21 @@ static int ipc_resume_stream_cmd(uint8_t endpoint_id)
 	return result;
 }
 
+static int ipc_suspend_stream_cmd(uint8_t endpoint_id)
+{
+	struct audio_cmd_suspend_stream cmd;
+	int result;
+
+	DBG("");
+
+	cmd.id = endpoint_id;
+
+	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_SUSPEND_STREAM,
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	return result;
+}
+
 static int register_endpoints(void)
 {
 	struct audio_endpoint *ep = &audio_endpoints[0];
@@ -528,8 +543,17 @@ static int out_set_format(struct audio_stream *stream, audio_format_t format)
 
 static int out_standby(struct audio_stream *stream)
 {
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+
 	DBG("");
-	return -ENOSYS;
+
+	if (out->audio_state == AUDIO_A2DP_STATE_STARTED) {
+		if (ipc_suspend_stream_cmd(out->ep->id) != AUDIO_STATUS_SUCCESS)
+			return -1;
+		out->audio_state = AUDIO_A2DP_STATE_STANDBY;
+	}
+
+	return 0;
 }
 
 static int out_dump(const struct audio_stream *stream, int fd)
@@ -540,8 +564,51 @@ static int out_dump(const struct audio_stream *stream, int fd)
 
 static int out_set_parameters(struct audio_stream *stream, const char *kvpairs)
 {
-	DBG("");
-	return -ENOSYS;
+	struct a2dp_stream_out *out = (struct a2dp_stream_out *) stream;
+	char *kvpair;
+	char *str;
+	char *saveptr;
+	bool enter_suspend = false;
+	bool exit_suspend = false;
+
+	DBG("%s", kvpairs);
+
+	str = strdup(kvpairs);
+	kvpair = strtok_r(str, ";", &saveptr);
+
+	for (; kvpair && *kvpair; kvpair = strtok_r(NULL, ";", &saveptr)) {
+		char *keyval;
+
+		keyval = strchr(kvpair, '=');
+		if (!keyval)
+			continue;
+
+		*keyval = '\0';
+		keyval++;
+
+		if (!strcmp(kvpair, "closing")) {
+			if (!strcmp(keyval, "true"))
+				out->audio_state = AUDIO_A2DP_STATE_NONE;
+		} else if (!strcmp(kvpair, "A2dpSuspended")) {
+			if (!strcmp(keyval, "true"))
+				enter_suspend = true;
+			else
+				exit_suspend = true;
+		}
+	}
+
+	free(str);
+
+	if (enter_suspend && out->audio_state == AUDIO_A2DP_STATE_STARTED) {
+		if (ipc_suspend_stream_cmd(out->ep->id) != AUDIO_STATUS_SUCCESS)
+			return -1;
+		out->audio_state = AUDIO_A2DP_STATE_SUSPENDED;
+	}
+
+	if (exit_suspend && out->audio_state == AUDIO_A2DP_STATE_SUSPENDED)
+		out->audio_state = AUDIO_A2DP_STATE_STANDBY;
+
+	return 0;
 }
 
 static char *out_get_parameters(const struct audio_stream *stream,
-- 
1.8.5.2

