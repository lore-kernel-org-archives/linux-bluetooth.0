Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 05/11] android/hal-audio: Add support to close output stream
Date: Wed, 15 Jan 2014 19:03:51 +0100
Message-ID: <1389809037-11575-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 2abd92a..2a6b6c4 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -420,6 +420,21 @@ static int ipc_open_stream_cmd(uint8_t endpoint_id,
 	return result;
 }
 
+static int ipc_close_stream_cmd(uint8_t endpoint_id)
+{
+	struct audio_cmd_close_stream cmd;
+	int result;
+
+	DBG("");
+
+	cmd.id = endpoint_id;
+
+	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_CLOSE_STREAM,
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
+
+	return result;
+}
+
 static int register_endpoints(void)
 {
 	struct audio_endpoint *ep = &audio_endpoints[0];
@@ -717,9 +732,14 @@ static void audio_close_output_stream(struct audio_hw_device *dev,
 					struct audio_stream_out *stream)
 {
 	struct a2dp_audio_dev *a2dp_dev = (struct a2dp_audio_dev *) dev;
+	struct audio_endpoint *ep = a2dp_dev->out->ep;
 
 	DBG("");
 
+	ipc_close_stream_cmd(ep->id);
+
+	/* TODO: cleanup codec */
+
 	free(stream);
 	a2dp_dev->out = NULL;
 }
-- 
1.8.5.2

