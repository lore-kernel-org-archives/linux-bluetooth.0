Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmHCNatJ"
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9586D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:25:22 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d9e0f0cba9so2931995a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702329920; x=1702934720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xI02yPghBkjpykjQpjQ26/QiBrrzYlFW6gK4jkWREA=;
        b=DmHCNatJ+fwJHBb+lBsX4UeWUd+1pqGK78QmeoKBZazXrRnW120QaUtt3TdCR8AGqA
         hE45NtJ4Xl6AboY0CEXmBuO3FcXGtUEbwvZ0MG637b0PyyI5HZ64m1i3oRw8gofloLgR
         BExaVgwJ2lvgEMXNx+XJuToE9Zu4EsflRaymfrGTJbo1cix564OyTr7Fx3FkCd8J13YJ
         3rT9mBUpgY8GqAL+4msmh/y+1O9r5tdWBbBlH0t1dt6EOCBRFHx8oD0uu2zD9ijI0QKj
         myVcZCdXdMoWcP+b/y/sQmPC0G2unA7eT2jlZqncP7kzpYhznfiGF7HlQZsphQGMExTW
         wunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329920; x=1702934720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xI02yPghBkjpykjQpjQ26/QiBrrzYlFW6gK4jkWREA=;
        b=WVFB/3FrHpeHAv1rtTYyKPQZRo1s/3xuYVqp8VvK4upISDCgX73j/JEzIZjPLsL9NK
         1+3WAXklalBkIWldovxTHjds6Erz3VEHwFIERqS3/kUt3PBH+oMWVaSnBAtxt88yHy6R
         oWEioToqx1QCqZ04jR0F+9/XXsRjeSdL76+jQcpEX0mqFG/gadT9h5Ix7AWH6NpzaSpX
         trcUMX9mSQYwI4GrQbX44Jgxu/rljUQWvb1D0e3DtN7iQElGIuhIi2SBtXk5iGzPMsjU
         +m7jm8en/wDG2i6PIcLFciaXyTzLe2DrPO2hq9rrb28CYf9h2HT1OwhftwNF17+Rup4M
         inaA==
X-Gm-Message-State: AOJu0YxiPNfJBIw0Z1SpHB9XkcdAeIDGQ7Cdp5E2NWA2P/x7omPf6wt2
	dc5LdqPl99S0TwK4z5ByPMBA3lSWIoY=
X-Google-Smtp-Source: AGHT+IHqmo3QHnFBagj+7GGM+i3YBNIYHYqobRS3klLlSbZvBCzdVo11BGbL85eOXLfJ6fSA2MZFhw==
X-Received: by 2002:a9d:7dd7:0:b0:6d8:74e2:6354 with SMTP id k23-20020a9d7dd7000000b006d874e26354mr4844515otn.46.1702329919496;
        Mon, 11 Dec 2023 13:25:19 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id s38-20020a0568302aa600b006da11489f70sm873757otu.44.2023.12.11.13.25.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:25:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/6] bap: Allow setup of multiple stream per endpoint
Date: Mon, 11 Dec 2023 16:25:11 -0500
Message-ID: <20231211212516.577426-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Remote endpoints actually represents PAC records of the same codec and
their capabilities are merged together thus is should be possible to
create multiple streams depending on the AC configuration.
---
 profiles/audio/bap.c | 613 ++++++++++++++++++++++++-------------------
 1 file changed, 344 insertions(+), 269 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c530799915f3..38eaea055ed2 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -62,22 +62,27 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_INTERFACE "org.bluez.Media1"
 
-struct bap_ep {
-	char *path;
-	struct bap_data *data;
-	struct bt_bap_pac *lpac;
-	struct bt_bap_pac *rpac;
+struct bap_setup {
+	struct bap_ep *ep;
 	struct bt_bap_stream *stream;
+	struct bt_bap_qos qos;
 	GIOChannel *io;
 	unsigned int io_id;
 	bool recreate;
 	bool cig_active;
 	struct iovec *caps;
 	struct iovec *metadata;
-	struct bt_bap_qos qos;
 	unsigned int id;
-	DBusMessage *msg;
 	struct iovec *base;
+	DBusMessage *msg;
+};
+
+struct bap_ep {
+	char *path;
+	struct bap_data *data;
+	struct bt_bap_pac *lpac;
+	struct bt_bap_pac *rpac;
+	struct queue *setups;
 };
 
 struct bap_data {
@@ -728,84 +733,131 @@ fail:
 static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 					void *user_data)
 {
-	struct bap_ep *ep = user_data;
+	struct bap_setup *setup = user_data;
 	DBusMessage *reply;
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
-	ep->id = 0;
+	setup->id = 0;
 
-	if (!ep->msg)
+	if (!setup->msg)
 		return;
 
 	if (!code)
-		reply = dbus_message_new_method_return(ep->msg);
+		reply = dbus_message_new_method_return(setup->msg);
 	else
-		reply = btd_error_failed(ep->msg, "Unable to configure");
+		reply = btd_error_failed(setup->msg, "Unable to configure");
 
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 
-	dbus_message_unref(ep->msg);
-	ep->msg = NULL;
+	dbus_message_unref(setup->msg);
+	setup->msg = NULL;
 }
 
 static void config_cb(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
 {
-	struct bap_ep *ep = user_data;
+	struct bap_setup *setup = user_data;
 	DBusMessage *reply;
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
-	ep->id = 0;
+	setup->id = 0;
 
 	if (!code)
 		return;
 
-	if (!ep->msg)
+	if (!setup->msg)
 		return;
 
-	reply = btd_error_failed(ep->msg, "Unable to configure");
+	reply = btd_error_failed(setup->msg, "Unable to configure");
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 
-	dbus_message_unref(ep->msg);
-	ep->msg = NULL;
+	dbus_message_unref(setup->msg);
+	setup->msg = NULL;
 }
 
-static void bap_io_close(struct bap_ep *ep)
+static void setup_io_close(void *data, void *user_data)
 {
+	struct bap_setup *setup = data;
 	int fd;
 
-	if (ep->io_id) {
-		g_source_remove(ep->io_id);
-		ep->io_id = 0;
+	if (setup->io_id) {
+		g_source_remove(setup->io_id);
+		setup->io_id = 0;
 	}
 
-	if (!ep->io)
+	if (!setup->io)
 		return;
 
 
-	DBG("ep %p", ep);
+	DBG("setup %p", setup);
 
-	fd = g_io_channel_unix_get_fd(ep->io);
+	fd = g_io_channel_unix_get_fd(setup->io);
 	close(fd);
 
-	g_io_channel_unref(ep->io);
-	ep->io = NULL;
-	ep->cig_active = false;
+	g_io_channel_unref(setup->io);
+	setup->io = NULL;
+	setup->cig_active = false;
+
+	bt_bap_stream_io_connecting(setup->stream, -1);
+}
+
+static void ep_close(struct bap_ep *ep)
+{
+	if (!ep)
+		return;
+
+	queue_foreach(ep->setups, setup_io_close, NULL);
+}
+
+static struct bap_setup *setup_new(struct bap_ep *ep)
+{
+	struct bap_setup *setup;
+
+	setup = new0(struct bap_setup, 1);
+	setup->ep = ep;
+
+	if (!ep->setups)
+		ep->setups = queue_new();
+
+	queue_push_tail(ep->setups, setup);
+
+	DBG("ep %p setup %p", ep, setup);
+
+	return setup;
+}
+
+static void setup_free(void *data)
+{
+	struct bap_setup *setup = data;
+
+	DBG("%p", setup);
+
+	if (setup->ep)
+		queue_remove(setup->ep->setups, setup);
+
+	setup_io_close(setup, NULL);
+
+	util_iov_free(setup->caps, 1);
+	util_iov_free(setup->metadata, 1);
+	util_iov_free(setup->base, 1);
+
+	if (bt_bap_stream_get_type(setup->stream) == BT_BAP_STREAM_TYPE_BCAST)
+		util_iov_free(setup->qos.bcast.bcode, 1);
+
+	free(setup);
 }
 
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct bap_ep *ep = data;
+	struct bap_setup *setup;
 	const char *path;
 	DBusMessageIter args, props;
 
-	if (ep->msg)
-		return btd_error_busy(msg);
-
 	dbus_message_iter_init(msg, &args);
 
 	dbus_message_iter_get_basic(&args, &path);
@@ -815,59 +867,55 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
 		return btd_error_invalid_args(msg);
 
-	/* Disconnect IO if connecting since QoS is going to be reconfigured */
-	if (bt_bap_stream_io_is_connecting(ep->stream, NULL)) {
-		bap_io_close(ep);
-		bt_bap_stream_io_connecting(ep->stream, -1);
-	}
+	/* Disconnect IOs if connecting since QoS is going to be reconfigured */
+	ep_close(ep);
+
+	setup = setup_new(ep);
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
 		/* Mark BIG and BIS to be auto assigned */
-		ep->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
-		ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+		setup->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
+		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
 	} else {
 		/* Mark CIG and CIS to be auto assigned */
-		ep->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
-		ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
+		setup->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+		setup->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 	}
 
-	if (parse_configuration(&props, &ep->caps, &ep->metadata,
-				&ep->base, &ep->qos) < 0) {
+	if (parse_configuration(&props, &setup->caps, &setup->metadata,
+				&setup->base, &setup->qos) < 0) {
 		DBG("Unable to parse configuration");
+		setup_free(setup);
 		return btd_error_invalid_args(msg);
 	}
 
-	/* TODO: Check if stream capabilities match add support for Latency
-	 * and PHY.
-	 */
-	if (!ep->stream)
-		ep->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
-						ep->rpac, &ep->qos, ep->caps);
+	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
+						&setup->qos, setup->caps);
 
-	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
-						config_cb, ep);
-	if (!ep->id) {
+	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
+						setup->caps, config_cb, ep);
+	if (!setup->id) {
 		DBG("Unable to config stream");
-		free(ep->caps);
-		ep->caps = NULL;
+		setup_free(setup);
 		return btd_error_invalid_args(msg);
 	}
 
-	bt_bap_stream_set_user_data(ep->stream, ep->path);
+	bt_bap_stream_set_user_data(setup->stream, ep->path);
 
-	if (ep->metadata && ep->metadata->iov_len)
-		bt_bap_stream_metadata(ep->stream, ep->metadata, NULL, NULL);
+	if (setup->metadata && setup->metadata->iov_len)
+		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
+								NULL);
 
-	switch (bt_bap_stream_get_type(ep->stream)) {
+	switch (bt_bap_stream_get_type(setup->stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
-		ep->msg = dbus_message_ref(msg);
+		setup->msg = dbus_message_ref(msg);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* No message sent over the air for broadcast */
 		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
-			ep->msg = dbus_message_ref(msg);
+			setup->msg = dbus_message_ref(msg);
 		else
-			ep->id = 0;
+			setup->id = 0;
 
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
@@ -901,20 +949,14 @@ static void update_bcast_qos(struct bt_iso_qos *qos,
 		sizeof(qos->bcast.bcode));
 }
 
-static bool match_ep_type(const void *data, const void *user_data)
-{
-	const struct bap_ep *ep = data;
-
-	return (bt_bap_pac_get_type(ep->lpac) == PTR_TO_INT(user_data));
-}
-
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
-	struct bap_data *data = user_data;
+	struct bap_setup *setup = user_data;
+	struct bap_ep *ep = setup->ep;
+	struct bap_data *data = ep->data;
 	struct bt_iso_qos qos;
 	struct bt_iso_base base;
 	char address[18];
-	struct bap_ep *ep;
 	int fd;
 	struct iovec *base_io;
 	uint32_t presDelay;
@@ -938,32 +980,28 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
 					address, qos.bcast.big, qos.bcast.bis);
 
-	ep = queue_find(data->bcast, match_ep_type,
-			INT_TO_PTR(BT_BAP_BCAST_SINK));
-	if (!ep)
-		return;
-
-	update_bcast_qos(&qos, &ep->qos);
+	update_bcast_qos(&qos, &setup->qos);
 
 	base_io = new0(struct iovec, 1);
 	util_iov_memcpy(base_io, base.base, base.base_len);
 
 	parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
 			&presDelay, &numSubgroups, &numBis,
-			&codec, &ep->caps, &ep->metadata);
+			&codec, &setup->caps, &setup->metadata);
 
 	/* Update pac with BASE information */
-	bt_bap_update_bcast_source(ep->rpac, &codec, ep->caps, ep->metadata);
-	ep->id = bt_bap_stream_config(ep->stream, &ep->qos,
-					ep->caps, NULL, NULL);
+	bt_bap_update_bcast_source(ep->rpac, &codec, setup->caps,
+					setup->metadata);
+	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
+					setup->caps, NULL, NULL);
 	data->listen_io = io;
 
-	bt_bap_stream_set_user_data(ep->stream, ep->path);
+	bt_bap_stream_set_user_data(setup->stream, ep->path);
 
 	fd = g_io_channel_unix_get_fd(io);
 
-	if (bt_bap_stream_set_io(ep->stream, fd)) {
-		bt_bap_stream_enable(ep->stream, true, NULL, NULL, NULL);
+	if (bt_bap_stream_set_io(setup->stream, fd)) {
+		bt_bap_stream_enable(setup->stream, true, NULL, NULL, NULL);
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
@@ -1008,16 +1046,10 @@ static const GDBusMethodTable ep_methods[] = {
 static void ep_free(void *data)
 {
 	struct bap_ep *ep = data;
+	struct queue *setups = ep->setups;
 
-	if (ep->id)
-		bt_bap_stream_cancel(ep->stream, ep->id);
-
-	bap_io_close(ep);
-
-	util_iov_free(ep->caps, 1);
-	util_iov_free(ep->metadata, 1);
-	if (bt_bap_stream_get_type(ep->stream) == BT_BAP_STREAM_TYPE_BCAST)
-		util_iov_free(ep->qos.bcast.bcode, 1);
+	ep->setups = NULL;
+	queue_destroy(setups, setup_free);
 	free(ep->path);
 	free(ep);
 }
@@ -1077,12 +1109,10 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				adapter_get_path(adapter), suffix, i);
-		ep->base = new0(struct iovec, 1);
 		break;
 	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
-		ep->base = new0(struct iovec, 1);
 		break;
 	}
 
@@ -1181,33 +1211,38 @@ static struct bap_ep *ep_register(struct btd_service *service,
 	return ep;
 }
 
-static void bap_config(void *data, void *user_data)
+static void setup_config(void *data, void *user_data)
 {
-	struct bap_ep *ep = data;
+	struct bap_setup *setup = data;
+	struct bap_ep *ep = setup->ep;
 
-	DBG("ep %p caps %p metadata %p", ep, ep->caps, ep->metadata);
-
-	if (!ep->caps)
-		return;
+	DBG("setup %p caps %p metadata %p", setup, setup->caps,
+						setup->metadata);
 
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
 	 */
-	if (!ep->stream)
-		ep->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
-						ep->rpac, &ep->qos, ep->caps);
+	if (!setup->stream)
+		setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
+						ep->rpac, &setup->qos,
+						setup->caps);
 
-	ep->id = bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
-						config_cb, ep);
-	if (!ep->id) {
+	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
+						setup->caps, config_cb, setup);
+	if (!setup->id) {
 		DBG("Unable to config stream");
-		util_iov_free(ep->caps, 1);
-		ep->caps = NULL;
-		util_iov_free(ep->metadata, 1);
-		ep->metadata = NULL;
+		setup_free(setup);
+		return;
 	}
 
-	bt_bap_stream_set_user_data(ep->stream, ep->path);
+	bt_bap_stream_set_user_data(setup->stream, ep->path);
+}
+
+static void bap_config(void *data, void *user_data)
+{
+	struct bap_ep *ep = data;
+
+	queue_foreach(ep->setups, setup_config, NULL);
 }
 
 static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
@@ -1215,6 +1250,7 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 				void *user_data)
 {
 	struct bap_ep *ep = user_data;
+	struct bap_setup *setup;
 
 	if (err) {
 		error("err %d", err);
@@ -1222,15 +1258,10 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 		goto done;
 	}
 
-	util_iov_free(ep->caps, 1);
-	ep->caps = util_iov_dup(caps, 1);
-
-	if (metadata && metadata->iov_base && metadata->iov_len) {
-		ep->metadata = util_iov_dup(metadata, 1);
-		bt_bap_stream_metadata(ep->stream, ep->metadata, NULL, NULL);
-	}
-
-	ep->qos = *qos;
+	setup = setup_new(ep);
+	setup->caps = util_iov_dup(caps, 1);
+	setup->metadata = util_iov_dup(metadata, 1);
+	setup->qos = *qos;
 
 	DBG("selecting %d", ep->data->selecting);
 	ep->data->selecting--;
@@ -1293,28 +1324,41 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_found, service);
 }
 
-static bool match_ep_by_stream(const void *data, const void *user_data)
+static bool match_setup_stream(const void *data, const void *user_data)
+{
+	const struct bap_setup *setup = data;
+	const struct bt_bap_stream *stream = user_data;
+
+	return setup->stream == stream;
+}
+
+static bool match_ep_stream(const void *data, const void *user_data)
 {
 	const struct bap_ep *ep = data;
 	const struct bt_bap_stream *stream = user_data;
 
-	return ep->stream == stream;
+	return queue_find(ep->setups, match_setup_stream, stream);
 }
 
-static struct bap_ep *bap_find_ep_by_stream(struct bap_data *data,
+static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
 					struct bt_bap_stream *stream)
 {
 	struct bap_ep *ep;
 
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
-		ep = queue_find(data->snks, match_ep_by_stream, stream);
+		ep = queue_find(data->snks, match_ep_stream, stream);
 		if (ep)
-			return ep;
+			return queue_find(ep->setups, match_setup_stream,
+								stream);
 
-		return queue_find(data->srcs, match_ep_by_stream, stream);
+		ep = queue_find(data->srcs, match_ep_stream, stream);
+		if (ep)
+			return queue_find(ep->setups, match_setup_stream,
+								stream);
+		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		return queue_find(data->bcast, match_ep_by_stream, stream);
+		return queue_find(data->bcast, match_ep_stream, stream);
 	}
 
 	return NULL;
@@ -1435,8 +1479,9 @@ drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
 }
 
-static void bap_accept_io(struct bap_ep *ep, struct bt_bap_stream *stream,
-							int fd, int defer)
+static void setup_accept_io(struct bap_setup *setup,
+				struct bt_bap_stream *stream,
+				int fd, int defer)
 {
 	char c;
 	struct pollfd pfd;
@@ -1472,7 +1517,7 @@ static void bap_accept_io(struct bap_ep *ep, struct bt_bap_stream *stream,
 		}
 	}
 
-	ep->cig_active = true;
+	setup->cig_active = true;
 
 	return;
 
@@ -1485,12 +1530,20 @@ struct cig_busy_data {
 	uint8_t cig;
 };
 
+static bool match_cig_active(const void *data, const void *match_data)
+{
+	const struct bap_setup *setup = data;
+	const struct cig_busy_data *info = match_data;
+
+	return (setup->qos.ucast.cig_id == info->cig) && setup->cig_active;
+}
+
 static bool cig_busy_ep(const void *data, const void *match_data)
 {
 	const struct bap_ep *ep = data;
 	const struct cig_busy_data *info = match_data;
 
-	return (ep->qos.ucast.cig_id == info->cig) && ep->cig_active;
+	return queue_find(ep->setups, match_cig_active, info);
 }
 
 static bool cig_busy_session(const void *data, const void *match_data)
@@ -1518,32 +1571,40 @@ static bool is_cig_busy(struct bap_data *data, uint8_t cig)
 	return queue_find(sessions, cig_busy_session, &info);
 }
 
-static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
+static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
 				struct bt_bap_stream *stream, int defer);
 
-static gboolean bap_io_recreate(void *user_data)
+static gboolean setup_io_recreate(void *user_data)
 {
-	struct bap_ep *ep = user_data;
+	struct bap_setup *setup = user_data;
 
-	DBG("ep %p", ep);
+	DBG("%p", setup);
 
-	ep->io_id = 0;
+	setup->io_id = 0;
 
-	bap_create_io(ep->data, ep, ep->stream, true);
+	setup_create_io(setup->ep->data, setup, setup->stream, true);
 
 	return FALSE;
 }
 
-static void recreate_cig_ep(void *data, void *match_data)
+static void setup_recreate(void *data, void *match_data)
 {
-	struct bap_ep *ep = (struct bap_ep *)data;
+	struct bap_setup *setup = data;
 	struct cig_busy_data *info = match_data;
 
-	if (ep->qos.ucast.cig_id != info->cig || !ep->recreate || ep->io_id)
+	if (setup->qos.ucast.cig_id != info->cig || !setup->recreate ||
+						setup->io_id)
 		return;
 
-	ep->recreate = false;
-	ep->io_id = g_idle_add(bap_io_recreate, ep);
+	setup->recreate = false;
+	setup->io_id = g_idle_add(setup_io_recreate, setup);
+}
+
+static void recreate_cig_ep(void *data, void *match_data)
+{
+	struct bap_ep *ep = data;
+
+	queue_foreach(ep->setups, setup_recreate, match_data);
 }
 
 static void recreate_cig_session(void *data, void *match_data)
@@ -1558,38 +1619,39 @@ static void recreate_cig_session(void *data, void *match_data)
 	queue_foreach(session->srcs, recreate_cig_ep, match_data);
 }
 
-static void recreate_cig(struct bap_ep *ep)
+static void recreate_cig(struct bap_setup *setup)
 {
-	struct bap_data *data = ep->data;
+	struct bap_data *data = setup->ep->data;
 	struct cig_busy_data info;
 
 	info.adapter = device_get_adapter(data->device);
-	info.cig = ep->qos.ucast.cig_id;
+	info.cig = setup->qos.ucast.cig_id;
 
-	DBG("adapter %p ep %p recreate CIG %d", info.adapter, ep, info.cig);
+	DBG("adapter %p setup %p recreate CIG %d", info.adapter, setup,
+							info.cig);
 
-	if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET) {
-		recreate_cig_ep(ep, &info);
+	if (setup->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET) {
+		recreate_cig_ep(setup->ep, &info);
 		return;
 	}
 
 	queue_foreach(sessions, recreate_cig_session, &info);
 }
 
-static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
+static gboolean setup_io_disconnected(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	struct bap_ep *ep = user_data;
+	struct bap_setup *setup = user_data;
 
-	DBG("ep %p recreate %s", ep, ep->recreate ? "true" : "false");
+	DBG("%p recreate %s", setup, setup->recreate ? "true" : "false");
 
-	ep->io_id = 0;
+	setup->io_id = 0;
 
-	bap_io_close(ep);
+	setup_io_close(setup, NULL);
 
 	/* Check if connecting recreate IO */
-	if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
-		recreate_cig(ep);
+	if (!is_cig_busy(setup->ep->data, setup->qos.ucast.cig_id))
+		recreate_cig(setup);
 
 	return FALSE;
 }
@@ -1597,25 +1659,25 @@ static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
 					gpointer user_data)
 {
-	struct bap_ep *ep = user_data;
+	struct bap_setup *setup = user_data;
 
-	if (!ep->stream)
+	if (!setup->stream)
 		return;
 
-	iso_connect_bcast_cb(chan, err, ep->stream);
+	iso_connect_bcast_cb(chan, err, setup->stream);
 }
 
 static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
-	struct bap_ep *ep = user_data;
+	struct bap_setup *setup = user_data;
 
-	if (!ep->stream)
+	if (!setup->stream)
 		return;
 
-	iso_connect_cb(chan, err, ep->stream);
+	iso_connect_cb(chan, err, setup->stream);
 }
 
-static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
+static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 				struct bt_bap_stream *stream,
 				struct bt_iso_qos *qos, int defer)
 {
@@ -1626,39 +1688,40 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 
 	/* If IO already set skip creating it again */
 	if (bt_bap_stream_get_io(stream)) {
-		DBG("ep %p stream %p has existing io", ep, stream);
+		DBG("setup %p stream %p has existing io", setup, stream);
 		return;
 	}
 
 	if (bt_bap_stream_io_is_connecting(stream, &fd)) {
-		bap_accept_io(ep, stream, fd, defer);
+		setup_accept_io(setup, stream, fd, defer);
 		return;
 	}
 
 	/* If IO channel still up or CIG is busy, wait for it to be
 	 * disconnected and then recreate.
 	 */
-	if (ep->io || is_cig_busy(data, ep->qos.ucast.cig_id)) {
-		DBG("ep %p stream %p defer %s wait recreate", ep, stream,
+	if (setup->io || is_cig_busy(data, setup->qos.ucast.cig_id)) {
+		DBG("setup %p stream %p defer %s wait recreate", setup, stream,
 						defer ? "true" : "false");
-		ep->recreate = true;
+		setup->recreate = true;
 		return;
 	}
 
-	if (ep->io_id) {
-		g_source_remove(ep->io_id);
-		ep->io_id = 0;
+	if (setup->io_id) {
+		g_source_remove(setup->io_id);
+		setup->io_id = 0;
 	}
 
-	DBG("ep %p stream %p defer %s", ep, stream, defer ? "true" : "false");
+	DBG("setup %p stream %p defer %s", setup, stream,
+				defer ? "true" : "false");
 
-	io = bt_io_connect(bap_connect_io_cb, ep, NULL, &err,
+	io = bt_io_connect(bap_connect_io_cb, setup, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(adapter),
 				BT_IO_OPT_DEST_BDADDR,
-				device_get_address(ep->data->device),
+				device_get_address(data->device),
 				BT_IO_OPT_DEST_TYPE,
-				device_get_le_address_type(ep->data->device),
+				device_get_le_address_type(data->device),
 				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 				BT_IO_OPT_QOS, qos,
 				BT_IO_OPT_DEFER_TIMEOUT, defer,
@@ -1669,18 +1732,19 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 		return;
 	}
 
-	ep->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						bap_io_disconnected, ep);
+	setup->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						setup_io_disconnected, setup);
 
-	ep->io = io;
-	ep->cig_active = !defer;
+	setup->io = io;
+	setup->cig_active = !defer;
 
 	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
 }
 
-static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
-				struct bt_bap_stream *stream,
-				struct bt_iso_qos *qos)
+static void setup_connect_io_broadcast(struct bap_data *data,
+					struct bap_setup *setup,
+					struct bt_bap_stream *stream,
+					struct bt_iso_qos *qos)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1695,18 +1759,19 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	if (bt_bap_stream_get_io(stream))
 		return;
 
-	if (ep->io_id) {
-		g_source_remove(ep->io_id);
-		ep->io_id = 0;
+	if (setup->io_id) {
+		g_source_remove(setup->io_id);
+		setup->io_id = 0;
 	}
-	base.base_len = ep->base->iov_len;
+	base.base_len = setup->base->iov_len;
 
 	memset(base.base, 0, 248);
-	memcpy(base.base, ep->base->iov_base, ep->base->iov_len);
-	DBG("ep %p stream %p ", ep, stream);
+	memcpy(base.base, setup->base->iov_base, setup->base->iov_len);
 	ba2str(btd_adapter_get_address(adapter), addr);
 
-	io = bt_io_connect(bap_connect_bcast_io_cb, ep, NULL, &err,
+	DBG("setup %p stream %p", setup, stream);
+
+	io = bt_io_connect(bap_connect_bcast_io_cb, setup, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(adapter),
 			BT_IO_OPT_DEST_BDADDR,
@@ -1725,15 +1790,15 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		return;
 	}
 
-	ep->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-			bap_io_disconnected, ep);
+	setup->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					setup_io_disconnected, setup);
 
-	ep->io = io;
+	setup->io = io;
 
 	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
 }
 
-static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
+static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 						struct bt_iso_qos *qos)
 {
 	struct btd_adapter *adapter = device_get_adapter(data->device);
@@ -1765,8 +1830,10 @@ static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 	data->listen_io = io;
 }
 
-static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
-			struct bt_bap_stream *stream, struct bt_iso_qos *qos)
+static void setup_listen_io_broadcast(struct bap_data *data,
+					struct bap_setup *setup,
+					struct bt_bap_stream *stream,
+					struct bt_iso_qos *qos)
 {
 	GIOChannel *io;
 	GError *err = NULL;
@@ -1784,9 +1851,9 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	if (bt_bap_stream_get_io(stream) || data->listen_io)
 		return;
 
-	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, setup, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(ep->data->adapter),
+			btd_adapter_get_address(data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
 			device_get_address(data->device),
 			BT_IO_OPT_DEST_TYPE,
@@ -1800,12 +1867,14 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		error("%s", err->message);
 		g_error_free(err);
 	}
-	ep->io = io;
-	ep->data->listen_io = io;
+	setup->io = io;
+	data->listen_io = io;
 
 }
-static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep,
-				struct bt_bap_stream *stream, int defer)
+static void setup_create_ucast_io(struct bap_data *data,
+					struct bap_setup *setup,
+					struct bt_bap_stream *stream,
+					int defer)
 {
 	struct bt_bap_qos *qos[2] = {};
 	struct bt_iso_qos iso_qos;
@@ -1825,14 +1894,15 @@ static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep,
 	bap_iso_qos(qos[0], &iso_qos.ucast.in);
 	bap_iso_qos(qos[1], &iso_qos.ucast.out);
 
-	if (ep)
-		bap_connect_io(data, ep, stream, &iso_qos, defer);
+	if (setup)
+		setup_connect_io(data, setup, stream, &iso_qos, defer);
 	else
-		bap_listen_io(data, stream, &iso_qos);
+		setup_listen_io(data, stream, &iso_qos);
 }
 
-static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
-				struct bt_bap_stream *stream, int defer)
+static void setup_create_bcast_io(struct bap_data *data,
+					struct bap_setup *setup,
+					struct bt_bap_stream *stream, int defer)
 {
 	struct bt_iso_qos iso_qos;
 
@@ -1841,33 +1911,35 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 	if (!defer)
 		goto done;
 
-	iso_qos.bcast.big = ep->qos.bcast.big;
-	iso_qos.bcast.bis = ep->qos.bcast.bis;
-	iso_qos.bcast.sync_factor = ep->qos.bcast.sync_factor;
-	iso_qos.bcast.packing = ep->qos.bcast.packing;
-	iso_qos.bcast.framing = ep->qos.bcast.framing;
-	iso_qos.bcast.encryption = ep->qos.bcast.encryption;
-	if (ep->qos.bcast.bcode)
-		memcpy(iso_qos.bcast.bcode, ep->qos.bcast.bcode->iov_base, 16);
-	iso_qos.bcast.options = ep->qos.bcast.options;
-	iso_qos.bcast.skip = ep->qos.bcast.skip;
-	iso_qos.bcast.sync_timeout = ep->qos.bcast.sync_timeout;
-	iso_qos.bcast.sync_cte_type = ep->qos.bcast.sync_cte_type;
-	iso_qos.bcast.mse = ep->qos.bcast.mse;
-	iso_qos.bcast.timeout = ep->qos.bcast.timeout;
-	memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
+	iso_qos.bcast.big = setup->qos.bcast.big;
+	iso_qos.bcast.bis = setup->qos.bcast.bis;
+	iso_qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
+	iso_qos.bcast.packing = setup->qos.bcast.packing;
+	iso_qos.bcast.framing = setup->qos.bcast.framing;
+	iso_qos.bcast.encryption = setup->qos.bcast.encryption;
+	if (setup->qos.bcast.bcode)
+		memcpy(iso_qos.bcast.bcode, setup->qos.bcast.bcode->iov_base,
+									16);
+	iso_qos.bcast.options = setup->qos.bcast.options;
+	iso_qos.bcast.skip = setup->qos.bcast.skip;
+	iso_qos.bcast.sync_timeout = setup->qos.bcast.sync_timeout;
+	iso_qos.bcast.sync_cte_type = setup->qos.bcast.sync_cte_type;
+	iso_qos.bcast.mse = setup->qos.bcast.mse;
+	iso_qos.bcast.timeout = setup->qos.bcast.timeout;
+	memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
 done:
-	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		bap_connect_io_broadcast(data, ep, stream, &iso_qos);
+	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
+		setup_connect_io_broadcast(data, setup, stream, &iso_qos);
 	else
-		bap_listen_io_broadcast(data, ep, stream, &iso_qos);
+		setup_listen_io_broadcast(data, setup, stream, &iso_qos);
 }
 
-static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
+static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
 				struct bt_bap_stream *stream, int defer)
 {
-	DBG("ep %p stream %p defer %s", ep, stream, defer ? "true" : "false");
+	DBG("setup %p stream %p defer %s", setup, stream,
+				defer ? "true" : "false");
 
 	if (!data->streams)
 		data->streams = queue_new();
@@ -1877,10 +1949,10 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
-		bap_create_ucast_io(data, ep, stream, defer);
+		setup_create_ucast_io(data, setup, stream, defer);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		bap_create_bcast_io(data, ep, stream, defer);
+		setup_create_bcast_io(data, setup, stream, defer);
 		break;
 	}
 }
@@ -1889,7 +1961,7 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct bap_data *data = user_data;
-	struct bap_ep *ep;
+	struct bap_setup *setup;
 
 	DBG("stream %p: %s(%u) -> %s(%u)", stream,
 			bt_bap_stream_statestr(old_state), old_state,
@@ -1902,21 +1974,20 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	if (new_state == old_state && new_state != BT_BAP_STREAM_STATE_CONFIG)
 		return;
 
-	ep = bap_find_ep_by_stream(data, stream);
+	setup = bap_find_setup_by_stream(data, stream);
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_IDLE:
 		/* Release stream if idle */
-		if (ep) {
-			bap_io_close(ep);
-			ep->stream = NULL;
-		} else
+		if (setup)
+			setup_free(setup);
+		else
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (ep && !ep->id) {
-			bap_create_io(data, ep, stream, true);
-			if (!ep->io) {
+		if (setup && !setup->id) {
+			setup_create_io(data, setup, stream, true);
+			if (!setup->io) {
 				error("Unable to create io");
 				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
 					bt_bap_stream_release(stream, NULL,
@@ -1927,9 +1998,10 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
 				/* Wait QoS response to respond */
-				ep->id = bt_bap_stream_qos(stream, &ep->qos,
-								qos_cb,	ep);
-				if (!ep->id) {
+				setup->id = bt_bap_stream_qos(stream,
+								&setup->qos,
+								qos_cb,	setup);
+				if (!setup->id) {
 					error("Failed to Configure QoS");
 					bt_bap_stream_release(stream,
 								NULL, NULL);
@@ -1940,12 +2012,12 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_QOS:
 		if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
-			bap_create_io(data, ep, stream, true);
+			setup_create_io(data, setup, stream, true);
 		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
-		if (ep)
-			bap_create_io(data, ep, stream, false);
+		if (setup)
+			setup_create_io(data, setup, stream, false);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
 		break;
@@ -2117,66 +2189,69 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 							void *user_data)
 {
 	struct bap_data *data = user_data;
-	struct bap_ep *ep;
+	struct bap_setup *setup;
+	struct bt_bap_qos *qos;
 	GIOChannel *io;
 
 	if (!state)
 		return;
 
-	ep = bap_find_ep_by_stream(data, stream);
-	if (!ep)
+	setup = bap_find_setup_by_stream(data, stream);
+	if (!setup)
 		return;
 
-	ep->recreate = false;
+	setup->recreate = false;
+	qos = &setup->qos;
 
-	if (!ep->io) {
+	if (!setup->io) {
 		io = g_io_channel_unix_new(fd);
-		ep->io_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						bap_io_disconnected, ep);
-		ep->io = io;
+		setup->io_id = g_io_add_watch(io,
+					      G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					      setup_io_disconnected, setup);
+		setup->io = io;
 	} else
-		io = ep->io;
+		io = setup->io;
 
 	g_io_channel_set_close_on_unref(io, FALSE);
 
-	switch (bt_bap_stream_get_type(ep->stream)) {
+	switch (bt_bap_stream_get_type(setup->stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
 		/* Attempt to get CIG/CIS if they have not been set */
-		if (ep->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
-				ep->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
-			struct bt_iso_qos qos;
+		if (qos->ucast.cig_id == BT_ISO_QOS_CIG_UNSET ||
+				qos->ucast.cis_id == BT_ISO_QOS_CIS_UNSET) {
+			struct bt_iso_qos iso_qos;
 
-			if (!io_get_qos(io, &qos)) {
+			if (!io_get_qos(io, &iso_qos)) {
 				g_io_channel_unref(io);
 				return;
 			}
 
-			ep->qos.ucast.cig_id = qos.ucast.cig;
-			ep->qos.ucast.cis_id = qos.ucast.cis;
+			qos->ucast.cig_id = iso_qos.ucast.cig;
+			qos->ucast.cis_id = iso_qos.ucast.cis;
 		}
 
 		DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
-				ep->qos.ucast.cig_id, ep->qos.ucast.cis_id);
+				qos->ucast.cig_id, qos->ucast.cis_id);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* Attempt to get BIG/BIS if they have not been set */
-		if (ep->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
-				ep->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
-			struct bt_iso_qos qos;
+		if (setup->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
+				setup->qos.bcast.bis == BT_ISO_QOS_BIS_UNSET) {
+			struct bt_iso_qos iso_qos;
 
-			if (!io_get_qos(io, &qos)) {
+			if (!io_get_qos(io, &iso_qos)) {
 				g_io_channel_unref(io);
 				return;
 			}
 
-			ep->qos.bcast.big = qos.bcast.big;
-			ep->qos.bcast.bis = qos.bcast.bis;
-			bt_bap_stream_config(ep->stream, &ep->qos,
-					ep->caps, NULL, NULL);
+			qos->bcast.big = iso_qos.bcast.big;
+			qos->bcast.bis = iso_qos.bcast.bis;
+			bt_bap_stream_config(setup->stream, qos, setup->caps,
+								NULL, NULL);
 		}
 
 		DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-					ep->qos.bcast.big, ep->qos.bcast.bis);
+				qos->bcast.big, qos->bcast.bis);
 	}
 }
 
-- 
2.43.0

