Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 08/26] android/hal-audio: Allow to autoselect endpoint in open_stream IPC
Date: Mon, 26 May 2014 15:16:34 +0200
Message-ID: <1401110212-11526-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

audio_open_output_stream always tries to open 1st registered endpoint
based on assumption that there is only one endpoint registered anyway
(due to support for only one codec). With more endpoints available in
future we need to be able to retrieve endpoint id which is connected
and use it for streaming.

This patch adds special case for id=0 in open_stream IPC to return 1st
opened endpoint on BlueZ side which is enough for now since only one
headset can be connected at any time (i.e. we should not have more
than 1 endpoint opened).
---
 android/a2dp.c      |  6 +++++-
 android/audio-msg.h |  1 +
 android/hal-audio.c | 36 ++++++++++++++++++++++++++++--------
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 10141d1..c8119da 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1357,7 +1357,10 @@ static void bt_stream_open(const void *buf, uint16_t len)
 
 	DBG("");
 
-	setup = find_setup(cmd->id);
+	if (cmd->id)
+		setup = find_setup(cmd->id);
+	else
+		setup = setups ? setups->data : NULL;
 	if (!setup) {
 		error("Unable to find stream for endpoint %u", cmd->id);
 		ipc_send_rsp(audio_ipc, AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
@@ -1376,6 +1379,7 @@ static void bt_stream_open(const void *buf, uint16_t len)
 	len = sizeof(struct audio_rsp_open_stream) +
 			sizeof(struct audio_preset) + setup->preset->len;
 	rsp = g_malloc0(len);
+	rsp->id = setup->endpoint->id;
 	rsp->mtu = omtu;
 	rsp->preset->len = setup->preset->len;
 	memcpy(rsp->preset->data, setup->preset->data, setup->preset->len);
diff --git a/android/audio-msg.h b/android/audio-msg.h
index 5981355..7b9553b 100644
--- a/android/audio-msg.h
+++ b/android/audio-msg.h
@@ -61,6 +61,7 @@ struct audio_cmd_open_stream {
 } __attribute__((packed));
 
 struct audio_rsp_open_stream {
+	uint16_t id;
 	uint16_t mtu;
 	struct audio_preset preset[0];
 } __attribute__((packed));
diff --git a/android/hal-audio.c b/android/hal-audio.c
index 9807a5d..8b82498 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -337,7 +337,7 @@ static int ipc_close_cmd(uint8_t endpoint_id)
 	return result;
 }
 
-static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu, int *fd,
+static int ipc_open_stream_cmd(uint8_t *endpoint_id, uint16_t *mtu, int *fd,
 						struct audio_preset **caps)
 {
 	char buf[BLUEZ_AUDIO_MTU];
@@ -352,13 +352,14 @@ static int ipc_open_stream_cmd(uint8_t endpoint_id, uint16_t *mtu, int *fd,
 	if (!caps)
 		return AUDIO_STATUS_FAILED;
 
-	cmd.id = endpoint_id;
+	cmd.id = *endpoint_id;
 
 	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_OPEN_STREAM,
 				sizeof(cmd), &cmd, &rsp_len, rsp, fd);
 	if (result == AUDIO_STATUS_SUCCESS) {
 		size_t buf_len = sizeof(struct audio_preset) +
 					rsp->preset[0].len;
+		*endpoint_id = rsp->id;
 		*mtu = rsp->mtu;
 		*caps = malloc(buf_len);
 		memcpy(*caps, &rsp->preset, buf_len);
@@ -452,20 +453,39 @@ static void unregister_endpoints(void)
 	}
 }
 
-static bool open_endpoint(struct audio_endpoint *ep,
+static bool open_endpoint(struct audio_endpoint **epp,
 						struct audio_input_config *cfg)
 {
 	struct audio_preset *preset;
+	struct audio_endpoint *ep = *epp;
 	const struct audio_codec *codec;
 	uint16_t mtu;
 	uint16_t payload_len;
 	int fd;
+	size_t i;
+	uint8_t ep_id = 0;
+
+	if (ep)
+		ep_id = ep->id;
 
-	if (ipc_open_stream_cmd(ep->id, &mtu, &fd, &preset) !=
+	if (ipc_open_stream_cmd(&ep_id, &mtu, &fd, &preset) !=
 							AUDIO_STATUS_SUCCESS)
 		return false;
 
-	DBG("mtu=%u", mtu);
+	DBG("ep_id=%d mtu=%u", ep_id, mtu);
+
+	for (i = 0; i < MAX_AUDIO_ENDPOINTS; i++)
+		if (audio_endpoints[i].id == ep_id) {
+			ep = &audio_endpoints[i];
+			break;
+		}
+
+	if (!ep) {
+		error("Cound not find opened endpoint");
+		return false;
+	}
+
+	*epp = ep;
 
 	payload_len = mtu;
 	if (ep->codec->use_rtp)
@@ -1096,10 +1116,10 @@ static int audio_open_output_stream(struct audio_hw_device *dev,
 	out->stream.write = out_write;
 	out->stream.get_render_position = out_get_render_position;
 
-	/* TODO: for now we always use endpoint 0 */
-	out->ep = &audio_endpoints[0];
+	/* We want to autoselect opened endpoint */
+	out->ep = NULL;
 
-	if (!open_endpoint(out->ep, &out->cfg))
+	if (!open_endpoint(&out->ep, &out->cfg))
 		goto fail;
 
 	DBG("rate=%d channels=%d format=%d", out->cfg.rate,
-- 
1.9.3

