Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v4 3/6] audio/A2DP: Add implemention of audio Open Stream command
Date: Mon, 13 Jan 2014 14:10:01 +0200
Message-Id: <1389615004-32612-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389615004-32612-1-git-send-email-luiz.dentz@gmail.com>
References: <1389615004-32612-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 354895a..b26d727 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -37,6 +37,7 @@
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
+#include "profiles/audio/a2dp-codecs.h"
 #include "log.h"
 #include "a2dp.h"
 #include "hal-msg.h"
@@ -53,6 +54,7 @@
 static GIOChannel *server = NULL;
 static GSList *devices = NULL;
 static GSList *endpoints = NULL;
+static GSList *setups = NULL;
 static bdaddr_t adapter_addr;
 static uint32_t record_id = 0;
 
@@ -76,6 +78,13 @@ struct a2dp_device {
 	struct avdtp	*session;
 };
 
+struct a2dp_setup {
+	struct a2dp_device *dev;
+	struct a2dp_endpoint *endpoint;
+	struct a2dp_preset *preset;
+	struct avdtp_stream *stream;
+};
+
 static int device_cmp(gconstpointer s, gconstpointer user_data)
 {
 	const struct a2dp_device *dev = s;
@@ -419,8 +428,162 @@ static gboolean sep_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
+static int sbc_check_config(struct a2dp_endpoint *endpoint,
+						struct a2dp_preset *conf)
+{
+	a2dp_sbc_t *caps, *config;
+
+	if (conf->len != sizeof(a2dp_sbc_t)) {
+		error("SBC: Invalid configuration size (%u)", conf->len);
+		return -EINVAL;
+	}
+
+	caps = endpoint->caps->data;
+	config = conf->data;
+
+	if (!(caps->frequency & config->frequency)) {
+		error("SBC: Unsupported frequency (%u) by endpoint",
+							config->frequency);
+		return -EINVAL;
+	}
+
+	if (!(caps->channel_mode & config->channel_mode)) {
+		error("SBC: Unsupported channel mode (%u) by endpoint",
+							config->channel_mode);
+		return -EINVAL;
+	}
+
+	if (!(caps->block_length & config->block_length)) {
+		error("SBC: Unsupported block length (%u) by endpoint",
+							config->block_length);
+		return -EINVAL;
+	}
+
+	if (!(caps->allocation_method & config->allocation_method)) {
+		error("SBC: Unsupported allocation method (%u) by endpoint",
+							config->block_length);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int check_config(struct a2dp_endpoint *endpoint,
+						struct a2dp_preset *config)
+{
+	GSList *l;
+
+	for (l = endpoint->presets; l; l = g_slist_next(l)) {
+		struct a2dp_preset *preset = l->data;
+
+		if (preset->len != config->len)
+			continue;
+
+		if (memcmp(preset->data, config->data, preset->len) == 0)
+			return 0;
+	}
+
+	/* Codec specific */
+	switch (endpoint->codec) {
+	case A2DP_CODEC_SBC:
+		return sbc_check_config(endpoint, config);
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct a2dp_device *find_device_by_session(struct avdtp *session)
+{
+	GSList *l;
+
+	for (l = devices; l; l = g_slist_next(l)) {
+		struct a2dp_device *dev = l->data;
+
+		if (dev->session == session)
+			return dev;
+	}
+
+	return NULL;
+}
+
+static void setup_free(void *data)
+{
+	struct a2dp_setup *setup = data;
+
+	preset_free(setup->preset);
+	g_free(setup);
+}
+
+static void setup_add(struct a2dp_device *dev, struct a2dp_endpoint *endpoint,
+			struct a2dp_preset *preset, struct avdtp_stream *stream)
+{
+	struct a2dp_setup *setup;
+
+	setup = g_new0(struct a2dp_setup, 1);
+	setup->dev = dev;
+	setup->endpoint = endpoint;
+	setup->preset = preset;
+	setup->stream = stream;
+	setups = g_slist_append(setups, setup);
+}
+
+static gboolean sep_setconf_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						struct avdtp_stream *stream,
+						GSList *caps,
+						avdtp_set_configuration_cb cb,
+						void *user_data)
+{
+	struct a2dp_endpoint *endpoint = user_data;
+	struct a2dp_device *dev;
+	struct a2dp_preset *preset = NULL;
+
+	DBG("");
+
+	dev = find_device_by_session(session);
+	if (!dev) {
+		error("Unable to find device for session %p", session);
+		return FALSE;
+	}
+
+	for (; caps != NULL; caps = g_slist_next(caps)) {
+		struct avdtp_service_capability *cap = caps->data;
+		struct avdtp_media_codec_capability *codec;
+
+		if (cap->category == AVDTP_DELAY_REPORTING)
+			return FALSE;
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+
+		codec = (struct avdtp_media_codec_capability *) cap->data;
+
+		if (codec->media_codec_type != endpoint->codec)
+			return FALSE;
+
+		preset = g_new0(struct a2dp_preset, 1);
+		preset->len = cap->length - sizeof(*codec);
+		preset->data = g_memdup(codec->data, preset->len);
+
+		if (check_config(endpoint, preset) < 0) {
+			preset_free(preset);
+			return FALSE;
+		}
+	}
+
+	if (!preset)
+		return FALSE;
+
+	setup_add(dev, endpoint, preset, stream);
+
+	cb(session, stream, NULL);
+
+	return TRUE;
+}
+
 static struct avdtp_sep_ind sep_ind = {
 	.get_capability		= sep_getcap_ind,
+	.set_configuration	= sep_setconf_ind,
 };
 
 static uint8_t register_endpoint(const uint8_t *uuid, uint8_t codec,
@@ -550,11 +713,41 @@ static void bt_audio_close(const void *buf, uint16_t len)
 	audio_ipc_send_rsp(AUDIO_OP_CLOSE, AUDIO_STATUS_SUCCESS);
 }
 
+static struct a2dp_setup *find_setup(uint8_t id)
+{
+	GSList *l;
+
+	for (l = setups; l; l = g_slist_next(l)) {
+		struct a2dp_setup *setup = l->data;
+
+		if (setup->endpoint->id == id)
+			return setup;
+	}
+
+	return NULL;
+}
+
 static void bt_stream_open(const void *buf, uint16_t len)
 {
-	DBG("Not Implemented");
+	const struct audio_cmd_open_stream *cmd = buf;
+	struct audio_rsp_open_stream *rsp;
+	struct a2dp_setup *setup;
+
+	DBG("");
 
-	audio_ipc_send_rsp(AUDIO_OP_OPEN_STREAM, AUDIO_STATUS_FAILED);
+	setup = find_setup(cmd->id);
+	if (!setup) {
+		error("Unable to find stream for endpoint %u", cmd->id);
+		audio_ipc_send_rsp(AUDIO_OP_OPEN_STREAM, AUDIO_STATUS_FAILED);
+		return;
+	}
+
+	len = sizeof(*rsp) + setup->preset->len;
+	rsp = g_malloc0(sizeof(*rsp) + setup->preset->len);
+	rsp->preset->len = setup->preset->len;
+	memcpy(rsp->preset->data, setup->preset->data, setup->preset->len);
+
+	audio_ipc_send_rsp_full(AUDIO_OP_OPEN_STREAM, len, rsp, -1);
 }
 
 static void bt_stream_close(const void *buf, uint16_t len)
@@ -653,6 +846,9 @@ void bt_a2dp_unregister(void)
 {
 	DBG("");
 
+	g_slist_free_full(setups, setup_free);
+	setups = NULL;
+
 	g_slist_free_full(endpoints, unregister_endpoint);
 	endpoints = NULL;
 
-- 
1.8.4.2

