Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v4 1/6] audio/A2DP: Add implemention of audio Open command
Date: Mon, 13 Jan 2014 14:09:59 +0200
Message-Id: <1389615004-32612-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 1 deletion(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index b59c53d..b6b46e4 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -52,9 +52,23 @@
 
 static GIOChannel *server = NULL;
 static GSList *devices = NULL;
+static GSList *endpoints = NULL;
 static bdaddr_t adapter_addr;
 static uint32_t record_id = 0;
 
+struct a2dp_preset {
+	void *data;
+	int8_t len;
+};
+
+struct a2dp_endpoint {
+	uint8_t id;
+	uint8_t codec;
+	struct avdtp_local_sep *sep;
+	struct a2dp_preset *caps;
+	GSList *presets;
+};
+
 struct a2dp_device {
 	bdaddr_t	dst;
 	uint8_t		state;
@@ -70,6 +84,29 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 	return bacmp(&dev->dst, dst);
 }
 
+static void preset_free(void *data)
+{
+	struct a2dp_preset *preset = data;
+
+	g_free(preset->data);
+	g_free(preset);
+}
+
+static void unregister_endpoint(void *data)
+{
+	struct a2dp_endpoint *endpoint = data;
+
+	if (endpoint->sep)
+		avdtp_unregister_sep(endpoint->sep);
+
+	if (endpoint->caps)
+		preset_free(endpoint->caps);
+
+	g_slist_free_full(endpoint->presets, preset_free);
+
+	g_free(endpoint);
+}
+
 static void a2dp_device_free(struct a2dp_device *dev)
 {
 	if (dev->session)
@@ -354,10 +391,129 @@ static sdp_record_t *a2dp_record(void)
 	return record;
 }
 
+static gboolean sep_getcap_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					GSList **caps, uint8_t *err,
+					void *user_data)
+{
+	struct a2dp_endpoint *endpoint = user_data;
+	struct a2dp_preset *cap = endpoint->caps;
+	struct avdtp_service_capability *service;
+	struct avdtp_media_codec_capability *codec;
+
+	*caps = NULL;
+
+	service = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT, NULL, 0);
+	*caps = g_slist_append(*caps, service);
+
+	codec = g_malloc0(sizeof(*codec) + sizeof(cap->len));
+	codec->media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	codec->media_codec_type = endpoint->codec;
+	memcpy(codec->data, cap->data, cap->len);
+
+	service = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, codec,
+						sizeof(*codec) + cap->len);
+	*caps = g_slist_append(*caps, service);
+	g_free(codec);
+
+	return TRUE;
+}
+
+static struct avdtp_sep_ind sep_ind = {
+	.get_capability		= sep_getcap_ind,
+};
+
+static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
+							GSList *presets)
+{
+	struct a2dp_endpoint *endpoint;
+
+	/* FIXME: Add proper check for uuid */
+
+	endpoint = g_new0(struct a2dp_endpoint, 1);
+	endpoint->id = g_slist_length(endpoints) + 1;
+	endpoint->codec = codec;
+	endpoint->sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE,
+						AVDTP_MEDIA_TYPE_AUDIO,
+						codec, FALSE, &sep_ind, NULL,
+						endpoint);
+	endpoint->caps = presets->data;
+	endpoint->presets = g_slist_copy(g_slist_nth(presets, 1));
+
+	endpoints = g_slist_append(endpoints, endpoint);
+
+	return endpoint->id;
+}
+
+static GSList *parse_presets(const struct audio_preset *p, uint8_t count,
+								uint16_t len)
+{
+	GSList *l = NULL;
+	uint8_t i;
+
+	for (i = 0; count > i; i++) {
+		const uint8_t *ptr = (const uint8_t *) p;
+		struct a2dp_preset *preset;
+
+		if (len < sizeof(struct audio_preset)) {
+			DBG("Invalid preset index %u", i);
+			g_slist_free_full(l, preset_free);
+			return NULL;
+		}
+
+		len -= sizeof(struct audio_preset);
+		if (len == 0 || len < p->len) {
+			DBG("Invalid preset size of %u for index %u", len, i);
+			g_slist_free_full(l, preset_free);
+			return NULL;
+		}
+
+		preset = g_new0(struct a2dp_preset, 1);
+		preset->len = p->len;
+		preset->data = g_memdup(p->data, preset->len);
+		l = g_slist_append(l, preset);
+
+		len -= preset->len;
+		ptr += sizeof(*p) + preset->len;
+		p = (const struct audio_preset *) ptr;
+	}
+
+	return l;
+}
+
 static void bt_audio_open(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct audio_cmd_open *cmd = buf;
+	struct audio_rsp_open rsp;
+	GSList *presets;
 
+	DBG("");
+
+	if (cmd->presets == 0) {
+		error("No audio presets found");
+		goto failed;
+	}
+
+	presets = parse_presets(cmd->preset, cmd->presets, len - sizeof(*cmd));
+	if (!presets) {
+		error("No audio presets found");
+		goto failed;
+	}
+
+	rsp.id = register_endpoint(cmd->uuid, cmd->codec, presets);
+	if (rsp.id == 0) {
+		g_slist_free_full(presets, preset_free);
+		error("Unable to register endpoint");
+		goto failed;
+	}
+
+	g_slist_free(presets);
+
+	audio_ipc_send_rsp_full(AUDIO_OP_OPEN, sizeof(rsp), &rsp, -1);
+
+	return;
+
+failed:
 	audio_ipc_send_rsp(AUDIO_OP_OPEN, AUDIO_STATUS_FAILED);
 }
 
@@ -471,6 +627,9 @@ void bt_a2dp_unregister(void)
 {
 	DBG("");
 
+	g_slist_free_full(endpoints, unregister_endpoint);
+	endpoints = NULL;
+
 	g_slist_foreach(devices, a2dp_device_disconnected, NULL);
 	devices = NULL;
 
-- 
1.8.4.2

