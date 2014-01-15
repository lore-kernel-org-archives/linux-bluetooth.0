Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 04/10] android/hal-audio: Add support to open output stream
Date: Wed, 15 Jan 2014 10:59:51 +0100
Message-ID: <1389779996-9749-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389779996-9749-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to open output stream via Audio IPC.
Since only SBC is supported, we always try to open stream for first
endpoint only which is enough.
---
 android/hal-audio.c | 109 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 88 insertions(+), 21 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 3b4648a..2ced954 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -87,9 +87,23 @@ struct audio_endpoint {
 
 static struct audio_endpoint audio_endpoints[MAX_AUDIO_ENDPOINTS];
 
+enum a2dp_state_t {
+	AUDIO_A2DP_STATE_NONE,
+	AUDIO_A2DP_STATE_STANDBY,
+	AUDIO_A2DP_STATE_SUSPENDED,
+	AUDIO_A2DP_STATE_STARTED
+};
+
+struct a2dp_stream_out {
+	struct audio_stream_out stream;
+
+	struct audio_endpoint *ep;
+	enum a2dp_state_t audio_state;
+};
+
 struct a2dp_audio_dev {
 	struct audio_hw_device dev;
-	struct audio_stream_out *out;
+	struct a2dp_stream_out *out;
 };
 
 static const a2dp_sbc_t codec_sbc_presets[] = {
@@ -354,6 +368,38 @@ static int ipc_close_cmd(uint8_t endpoint_id)
 	return result;
 }
 
+static int ipc_open_stream_cmd(uint8_t endpoint_id,
+					struct audio_preset **caps)
+{
+	char buf[BLUEZ_AUDIO_MTU];
+	struct audio_cmd_open_stream cmd;
+	struct audio_rsp_open_stream *rsp =
+					(struct audio_rsp_open_stream *) &buf;
+	size_t rsp_len = sizeof(buf);
+	int result;
+
+	DBG("");
+
+	if (!caps)
+		return AUDIO_STATUS_FAILED;
+
+	cmd.id = endpoint_id;
+
+	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
+				sizeof(cmd), &cmd, &rsp_len, rsp, NULL);
+
+	if (result == AUDIO_STATUS_SUCCESS) {
+		size_t buf_len = sizeof(struct audio_preset) +
+					rsp->preset[0].len;
+		*caps = malloc(buf_len);
+		memcpy(*caps, &rsp->preset, buf_len);
+	} else {
+		*caps = NULL;
+	}
+
+	return result;
+}
+
 static int register_endpoints(void)
 {
 	struct audio_endpoint *ep = &audio_endpoints[0];
@@ -595,35 +641,56 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
-	struct audio_stream_out *out;
+	struct a2dp_stream_out *out;
+	struct audio_preset *preset;
 
-	out = calloc(1, sizeof(struct audio_stream_out));
+	out = calloc(1, sizeof(struct a2dp_stream_out));
 	if (!out)
 		return -ENOMEM;
 
 	DBG("");
 
-	out->common.get_sample_rate = out_get_sample_rate;
-	out->common.set_sample_rate = out_set_sample_rate;
-	out->common.get_buffer_size = out_get_buffer_size;
-	out->common.get_channels = out_get_channels;
-	out->common.get_format = out_get_format;
-	out->common.set_format = out_set_format;
-	out->common.standby = out_standby;
-	out->common.dump = out_dump;
-	out->common.set_parameters = out_set_parameters;
-	out->common.get_parameters = out_get_parameters;
-	out->common.add_audio_effect = out_add_audio_effect;
-	out->common.remove_audio_effect = out_remove_audio_effect;
-	out->get_latency = out_get_latency;
-	out->set_volume = out_set_volume;
-	out->write = out_write;
-	out->get_render_position = out_get_render_position;
-
-	*stream_out = out;
+	out->stream.common.get_sample_rate = out_get_sample_rate;
+	out->stream.common.set_sample_rate = out_set_sample_rate;
+	out->stream.common.get_buffer_size = out_get_buffer_size;
+	out->stream.common.get_channels = out_get_channels;
+	out->stream.common.get_format = out_get_format;
+	out->stream.common.set_format = out_set_format;
+	out->stream.common.standby = out_standby;
+	out->stream.common.dump = out_dump;
+	out->stream.common.set_parameters = out_set_parameters;
+	out->stream.common.get_parameters = out_get_parameters;
+	out->stream.common.add_audio_effect = out_add_audio_effect;
+	out->stream.common.remove_audio_effect = out_remove_audio_effect;
+	out->stream.get_latency = out_get_latency;
+	out->stream.set_volume = out_set_volume;
+	out->stream.write = out_write;
+	out->stream.get_render_position = out_get_render_position;
+
+	/* TODO: for now we always use endpoint 0 */
+	out->ep = &audio_endpoints[0];
+
+	if (ipc_open_stream_cmd(out->ep->id, &preset) != AUDIO_STATUS_SUCCESS)
+		goto fail;
+
+	if (!preset)
+		goto fail;
+
+	/* TODO: initialize codec using received audio_preset */
+
+	free(preset);
+
+	*stream_out = &out->stream;
 	a2dp_dev->out = out;
 
+	out->audio_state = AUDIO_A2DP_STATE_STANDBY;
+
 	return 0;
+
+fail:
+	free(out);
+	*stream_out = NULL;
+	return -EIO;
 }
 
 static void audio_close_output_stream(struct audio_hw_device *dev,
-- 
1.8.5.2

