Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/12] android/A2DP: Discover endpoints when initiator
Date: Mon, 13 Jan 2014 19:32:06 +0200
Message-Id: <1389634333-25870-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389634333-25870-1-git-send-email-luiz.dentz@gmail.com>
References: <1389634333-25870-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 244 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 184 insertions(+), 60 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index a483514..8bbbe50 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -173,6 +173,166 @@ static void disconnect_cb(void *user_data)
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
 }
 
+static int sbc_check_config(void *caps, uint8_t caps_len, void *conf,
+							uint8_t conf_len)
+{
+	a2dp_sbc_t *cap, *config;
+
+	if (conf_len != caps_len || conf_len != sizeof(a2dp_sbc_t)) {
+		error("SBC: Invalid configuration size (%u)", conf_len);
+		return -EINVAL;
+	}
+
+	cap = caps;
+	config = conf;
+
+	if (!(cap->frequency & config->frequency)) {
+		error("SBC: Unsupported frequency (%u) by endpoint",
+							config->frequency);
+		return -EINVAL;
+	}
+
+	if (!(cap->channel_mode & config->channel_mode)) {
+		error("SBC: Unsupported channel mode (%u) by endpoint",
+							config->channel_mode);
+		return -EINVAL;
+	}
+
+	if (!(cap->block_length & config->block_length)) {
+		error("SBC: Unsupported block length (%u) by endpoint",
+							config->block_length);
+		return -EINVAL;
+	}
+
+	if (!(cap->allocation_method & config->allocation_method)) {
+		error("SBC: Unsupported allocation method (%u) by endpoint",
+							config->block_length);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int check_capabilities(struct a2dp_preset *preset,
+				struct avdtp_media_codec_capability *codec,
+				uint8_t codec_len)
+{
+	/* Codec specific */
+	switch (codec->media_codec_type) {
+	case A2DP_CODEC_SBC:
+		return sbc_check_config(codec->data, codec_len, preset->data,
+								preset->len);
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct a2dp_preset *select_preset(struct a2dp_endpoint *endpoint,
+						struct avdtp_remote_sep *rsep)
+{
+	struct avdtp_service_capability *service;
+	struct avdtp_media_codec_capability *codec;
+	GSList *l;
+
+	service = avdtp_get_codec(rsep);
+	codec = (struct avdtp_media_codec_capability *) service->data;
+
+	for (l = endpoint->presets; l; l = g_slist_next(l)) {
+		struct a2dp_preset *preset = l->data;
+
+		if (check_capabilities(preset, codec,
+					service->length - sizeof(*codec)) == 0)
+			return preset;
+	}
+
+	return NULL;
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
+static int select_configuration(struct a2dp_device *dev,
+				struct a2dp_endpoint *endpoint,
+				struct avdtp_remote_sep *rsep)
+{
+	struct a2dp_preset *preset;
+	struct avdtp_stream *stream;
+	struct avdtp_service_capability *service;
+	struct avdtp_media_codec_capability *codec;
+	GSList *caps;
+	int err;
+
+	preset = select_preset(endpoint, rsep);
+	if (!preset) {
+		error("Unable to select codec preset");
+		return -EINVAL;
+	}
+
+	service = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT, NULL, 0);
+	caps = g_slist_append(NULL, service);
+
+	codec = g_malloc0(sizeof(*codec) + sizeof(preset->len));
+	codec->media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	codec->media_codec_type = endpoint->codec;
+	memcpy(codec->data, preset->data, preset->len);
+
+	service = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, codec,
+						sizeof(*codec) + preset->len);
+	caps = g_slist_append(caps, service);
+
+	err = avdtp_set_configuration(dev->session, rsep, endpoint->sep, caps,
+								&stream);
+	g_slist_free_full(caps, g_free);
+	if (err < 0) {
+		error("avdtp_set_configuration: %s", strerror(-err));
+		return err;
+	}
+
+	setup_add(dev, endpoint, preset, stream);
+
+	return 0;
+}
+
+static void discover_cb(struct avdtp *session, GSList *seps,
+				struct avdtp_error *err, void *user_data)
+{
+	struct a2dp_device *dev = user_data;
+	struct a2dp_endpoint *endpoint = NULL;
+	struct avdtp_remote_sep *rsep = NULL;
+	GSList *l;
+
+	for (l = endpoints; l; l = g_slist_next(l)) {
+		endpoint = l->data;
+
+		rsep = avdtp_find_remote_sep(session, endpoint->sep);
+		if (rsep)
+			break;
+	}
+
+	if (!rsep) {
+		error("Unable to find matching endpoint");
+		goto failed;
+	}
+
+	if (select_configuration(dev, endpoint, rsep) < 0)
+		goto failed;
+
+	return;
+
+failed:
+	avdtp_shutdown(session);
+}
+
 static void signaling_connect_cb(GIOChannel *chan, GError *err,
 							gpointer user_data)
 {
@@ -192,20 +352,17 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 			BT_IO_OPT_OMTU, &omtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
-		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
 		error("%s", gerr->message);
 		g_error_free(gerr);
-		return;
+		goto failed;
 	}
 
 	fd = g_io_channel_unix_get_fd(chan);
 
 	/* FIXME: Add proper version */
 	dev->session = avdtp_new(fd, imtu, omtu, 0x0100);
-	if (!dev->session) {
-		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
-		return;
-	}
+	if (!dev->session)
+		goto failed;
 
 	avdtp_add_disconnect_cb(dev->session, disconnect_cb, dev);
 
@@ -214,7 +371,23 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 		dev->io = NULL;
 	}
 
+	/* Proceed to stream setup if initiator */
+	if (dev->state == HAL_A2DP_STATE_CONNECTING) {
+		int perr;
+
+		perr = avdtp_discover(dev->session, discover_cb, dev);
+		if (perr < 0) {
+			error("avdtp_discover: %s", strerror(-perr));
+			goto failed;
+		}
+	}
+
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
+
+	return;
+
+failed:
+	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
 }
 
 static void bt_a2dp_connect(const void *buf, uint16_t len)
@@ -428,50 +601,11 @@ static gboolean sep_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
-static int sbc_check_config(struct a2dp_endpoint *endpoint,
-						struct a2dp_preset *conf)
-{
-	a2dp_sbc_t *caps, *config;
-
-	if (conf->len != sizeof(a2dp_sbc_t)) {
-		error("SBC: Invalid configuration size (%u)", conf->len);
-		return -EINVAL;
-	}
-
-	caps = endpoint->caps->data;
-	config = conf->data;
-
-	if (!(caps->frequency & config->frequency)) {
-		error("SBC: Unsupported frequency (%u) by endpoint",
-							config->frequency);
-		return -EINVAL;
-	}
-
-	if (!(caps->channel_mode & config->channel_mode)) {
-		error("SBC: Unsupported channel mode (%u) by endpoint",
-							config->channel_mode);
-		return -EINVAL;
-	}
-
-	if (!(caps->block_length & config->block_length)) {
-		error("SBC: Unsupported block length (%u) by endpoint",
-							config->block_length);
-		return -EINVAL;
-	}
-
-	if (!(caps->allocation_method & config->allocation_method)) {
-		error("SBC: Unsupported allocation method (%u) by endpoint",
-							config->block_length);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int check_config(struct a2dp_endpoint *endpoint,
 						struct a2dp_preset *config)
 {
 	GSList *l;
+	struct a2dp_preset *caps;
 
 	for (l = endpoint->presets; l; l = g_slist_next(l)) {
 		struct a2dp_preset *preset = l->data;
@@ -483,10 +617,13 @@ static int check_config(struct a2dp_endpoint *endpoint,
 			return 0;
 	}
 
+	caps = endpoint->caps;
+
 	/* Codec specific */
 	switch (endpoint->codec) {
 	case A2DP_CODEC_SBC:
-		return sbc_check_config(endpoint, config);
+		return sbc_check_config(caps->data, caps->len, config->data,
+								config->len);
 	default:
 		return -EINVAL;
 	}
@@ -520,19 +657,6 @@ static void setup_remove(struct a2dp_setup *setup)
 	setup_free(setup);
 }
 
-static void setup_add(struct a2dp_device *dev, struct a2dp_endpoint *endpoint,
-			struct a2dp_preset *preset, struct avdtp_stream *stream)
-{
-	struct a2dp_setup *setup;
-
-	setup = g_new0(struct a2dp_setup, 1);
-	setup->dev = dev;
-	setup->endpoint = endpoint;
-	setup->preset = preset;
-	setup->stream = stream;
-	setups = g_slist_append(setups, setup);
-}
-
 static gboolean sep_setconf_ind(struct avdtp *session,
 						struct avdtp_local_sep *sep,
 						struct avdtp_stream *stream,
-- 
1.8.4.2

