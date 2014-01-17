Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 8/9] android/hal-audio: Read fd from Output Stream response
Date: Fri, 17 Jan 2014 16:40:12 +0100
Message-ID: <1389973213-30251-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389973213-30251-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index f2cb12a..d8438f7 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -575,7 +575,7 @@ static int ipc_close_cmd(uint8_t endpoint_id)
 	return result;
 }
 
-static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu,
+static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu, int *fd,
 					struct audio_preset **caps)
 {
 	char buf[BLUEZ_AUDIO_MTU];
@@ -593,7 +593,7 @@ static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu,
 	cmd.id = endpoint_id;
 
 	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
-				sizeof(cmd), &cmd, &rsp_len, rsp, NULL);
+				sizeof(cmd), &cmd, &rsp_len, rsp, fd);
 
 	if (result == AUDIO_STATUS_SUCCESS) {
 		size_t buf_len = sizeof(struct audio_preset) +
@@ -990,6 +990,7 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	struct audio_preset *preset;
 	const struct audio_codec *codec;
 	uint16_t mtu;
+	int fd;
 
 	out = calloc(1, sizeof(struct a2dp_stream_out));
 	if (!out)
@@ -1017,13 +1018,15 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	/* TODO: for now we always use endpoint 0 */
 	out->ep = &audio_endpoints[0];
 
-	if (ipc_open_stream_cmd(out->ep->id, &mtu, &preset) !=
+	if (ipc_open_stream_cmd(out->ep->id, &mtu, &fd, &preset) !=
 			AUDIO_STATUS_SUCCESS)
 		goto fail;
 
-	if (!preset)
+	if (!preset || fd < 0)
 		goto fail;
 
+	out->ep->fd = fd;
+
 	codec = out->ep->codec;
 
 	codec->init(preset, mtu, &out->ep->codec_data);
-- 
1.8.5.2

