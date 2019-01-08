Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBE1C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 15:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1AF21019
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 15:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmFWVZOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfAHPuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:50:06 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:33164 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfAHPuG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 10:50:06 -0500
Received: by mail-pg1-f175.google.com with SMTP id z11so1917735pgu.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=OnIkJzVMSZ7vYsF9nzThDGEZ2rNOcbGcvRDclxiHESQ=;
        b=jmFWVZOH0q7fyhhGZm7ySELNIiSlRcjPJhgErWDFVSNfrHYS7JpK4XJgoo1/f6LvK6
         NRqnNjMwGohhSlkR4Qns/PZfPKn2MvfPmFdIVE9IOxmBgZsT3NPBQmpCEpFyyDgbpRIx
         K4VBrTugNuasXk/CZ1IyIbReBbgAI9GCq2+t7xdpKbwRlFTgOd5HQ4MHalKTAUTwEoZR
         2T4cypWuuFPNU7Zy8qjqHbolAi/47Uxnvqm7v9Dhq5HiEPY0ByRdmaSVeBNsO1nhb/58
         THKkD287vyu3FDfBIgWDF3jb8nUJg+V/Xh+SO9BxZMpk00jFOSfSSE4A/Ke3konaVi5r
         nE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=OnIkJzVMSZ7vYsF9nzThDGEZ2rNOcbGcvRDclxiHESQ=;
        b=OhEIdakRjn010Dxw/XzKk23Ii9xHTRYE4CB57jN8Z7+loeRthc4F7F/OuiUbC7hIdP
         T2M0NZ4fYAru2nxG5CPGK/g+5L4YY1Rp8H/ewOX3WlGA/oqcyBBQxcJWxWldsCnFkcrj
         oFLO+Suo4mu+1qqt2781s8k/mrkF+V6O5MvxIqitif3h2ShbTaUU1DtS87aWosPGib6f
         8gXTcULeEhO08TPU4F7QTOxtUqjMGUbQdpqyFrJNaJRUaPGq1+PB3EIRXnJTaQbY+Q5E
         Pnb4R8lvUNAzVxZxlBHTS6FXOiPDTWKddY2aFvRagceZJYYHVE6t0W5/eU0M60CmC4Yt
         DjDA==
X-Gm-Message-State: AJcUukdkm17+dcLAAi4Sci38DH3mU6U/d2RAVGMwDfZHff1th19KogG4
        U9ctIgK/ZCMWO/2m8/U7fzxjkntGKU8=
X-Google-Smtp-Source: ALg8bN6xvMl+hfmxrL9hKh3lQe8d+QveNkrfVUKq3UhPYuYr7GXIDxv4D6s+3e38b8m5JtEsFlnSCg==
X-Received: by 2002:a65:5a4c:: with SMTP id z12mr1965376pgs.188.1546962603980;
        Tue, 08 Jan 2019 07:50:03 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2804:14c:8782:823b::1002])
        by smtp.gmail.com with ESMTPSA id 196sm275082811pfc.77.2019.01.08.07.50.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 07:50:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] a2dp: Cache remote endpoints
Date:   Tue,  8 Jan 2019 12:49:50 -0300
Message-Id: <20190108154950.8534-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190108154950.8534-1-luiz.dentz@gmail.com>
References: <20190108154950.8534-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order to always have the Endpoint interface available the remote
endpoints needs to be cached since the remote stack may config a stream
on its own there may not be a chance to discover the endpoits available
which would make it impossible to switch endpoints.
---
 profiles/audio/a2dp.c  | 725 +++++++++++++++++++++++++----------------
 profiles/audio/avdtp.c |  46 ++-
 profiles/audio/avdtp.h |   5 +
 3 files changed, 492 insertions(+), 284 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 2ceb73617..cda2b6c64 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1441,6 +1441,410 @@ static gboolean disconnect_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 	return FALSE;
 }
 
+static void caps_add_codec(GSList **l, uint8_t codec, uint8_t *caps,
+							size_t size)
+{
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct avdtp_media_codec_capability *cap;
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	*l = g_slist_append(*l, media_transport);
+
+	cap = g_malloc0(sizeof(*cap) + size);
+	cap->media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	cap->media_codec_type = codec;
+	memcpy(cap->data, caps, size);
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, cap,
+						sizeof(*cap) + size);
+
+	*l = g_slist_append(*l, media_codec);
+	g_free(cap);
+}
+
+struct client {
+	const char *sender;
+	const char *path;
+};
+
+static int match_client(const void *data, const void *user_data)
+{
+	struct a2dp_sep *sep = (void *) data;
+	const struct a2dp_endpoint *endpoint = sep->endpoint;
+	const struct client *client = user_data;
+
+	if (strcmp(client->sender, endpoint->get_name(sep, sep->user_data)))
+		return -1;
+
+	return strcmp(client->path, endpoint->get_path(sep, sep->user_data));
+}
+
+static struct a2dp_sep *find_sep(struct a2dp_server *server, uint8_t type,
+					const char *sender, const char *path)
+{
+	GSList *l;
+	struct client client = { sender, path };
+
+	l = type == AVDTP_SEP_TYPE_SINK ? server->sources : server->sinks;
+
+	l = g_slist_find_custom(l, &client, match_client);
+	if (l)
+		return l->data;
+
+	return NULL;
+}
+
+static int parse_properties(DBusMessageIter *props, uint8_t **caps, int *size)
+{
+	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "Capabilities") == 0) {
+			DBusMessageIter array;
+
+			if (var != DBUS_TYPE_ARRAY)
+				return -EINVAL;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array, caps, size);
+			return 0;
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return -EINVAL;
+}
+
+static void reconfig_cb(struct avdtp *session, struct a2dp_sep *sep,
+			struct avdtp_stream *stream, int err, void *user_data)
+{
+	DBusMessage *msg = user_data;
+
+	if (err)
+		g_dbus_send_message(btd_get_dbus_connection(),
+					btd_error_failed(msg, strerror(-err)));
+	else
+		g_dbus_send_reply(btd_get_dbus_connection(), msg,
+					DBUS_TYPE_INVALID);
+
+	dbus_message_unref(msg);
+}
+
+static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
+			struct a2dp_sep *lsep, struct a2dp_remote_sep *rsep,
+			uint8_t *caps, int size, void *user_data)
+{
+	struct a2dp_setup *setup;
+	struct a2dp_setup_cb *cb_data;
+	GSList *l;
+	int err;
+
+	setup = a2dp_setup_get(chan->session);
+	if (!setup)
+		return -ENOMEM;
+
+	cb_data = setup_cb_new(setup);
+	cb_data->config_cb = reconfig_cb;
+	cb_data->user_data = user_data;
+
+	setup->sep = lsep;
+	setup->rsep = rsep;
+
+	caps_add_codec(&setup->caps, setup->sep->codec, caps, size);
+
+	l = avdtp_get_type(rsep->sep) == AVDTP_SEP_TYPE_SINK ?
+					chan->server->sources :
+					chan->server->sinks;
+
+	/* Check for existing stream and close it */
+	for (; l; l = g_slist_next(l)) {
+		struct a2dp_sep *tmp = l->data;
+
+		/* Attempt to reconfigure if a stream already exists */
+		if (tmp->stream) {
+			/* Only allow switching sep from the same sender */
+			if (strcmp(sender, lsep->endpoint->get_name(tmp,
+							tmp->user_data)))
+				return -EPERM;
+
+			err = avdtp_close(chan->session, tmp->stream, FALSE);
+			if (err < 0) {
+				error("avdtp_close: %s", strerror(-err));
+				goto fail;
+			}
+
+			setup->reconfigure = TRUE;
+
+			return 0;
+		}
+	}
+
+	err = avdtp_set_configuration(setup->session, setup->rsep->sep,
+						lsep->lsep,
+						setup->caps,
+						&setup->stream);
+	if (err < 0) {
+		error("avdtp_set_configuration: %s", strerror(-err));
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	setup_unref(setup);
+	return err;
+}
+
+static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct a2dp_remote_sep *rsep = data;
+	struct a2dp_channel *chan = rsep->chan;
+	struct a2dp_sep *lsep = NULL;
+	struct avdtp_service_capability *service;
+	struct avdtp_media_codec_capability *codec;
+	DBusMessageIter args, props;
+	const char *sender, *path;
+	uint8_t *caps;
+	int err, size = 0;
+
+	sender = dbus_message_get_sender(msg);
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_next(&args);
+
+	lsep = find_sep(chan->server, avdtp_get_type(rsep->sep), sender, path);
+	if (!lsep)
+		return btd_error_invalid_args(msg);
+
+	service = avdtp_get_codec(rsep->sep);
+	codec = (struct avdtp_media_codec_capability *) service->data;
+
+	/* Check if codec really matches */
+	if (!endpoint_match_codec_ind(chan->session, codec, lsep))
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	if (parse_properties(&props, &caps, &size) < 0)
+		return btd_error_invalid_args(msg);
+
+	err = a2dp_reconfig(chan, sender, lsep, rsep, caps, size,
+					dbus_message_ref(msg));
+	if (err < 0) {
+		dbus_message_unref(msg);
+		return btd_error_failed(msg, strerror(-err));
+	}
+
+	return NULL;
+}
+
+static const GDBusMethodTable sep_methods[] = {
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
+					GDBUS_ARGS({ "endpoint", "o" },
+						{ "properties", "a{sv}" } ),
+					NULL, set_configuration) },
+	{ },
+};
+
+static gboolean get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+	const char *uuid;
+
+	switch (avdtp_get_type(sep->sep)) {
+	case AVDTP_SEP_TYPE_SOURCE:
+		uuid = A2DP_SOURCE_UUID;
+		break;
+	case AVDTP_SEP_TYPE_SINK:
+		uuid = A2DP_SOURCE_UUID;
+		break;
+	default:
+		uuid = "";
+	}
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+
+	return TRUE;
+}
+
+static gboolean get_codec(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+	struct avdtp_service_capability *cap = avdtp_get_codec(sep->sep);
+	struct avdtp_media_codec_capability *codec = (void *) cap->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+						&codec->media_codec_type);
+
+	return TRUE;
+}
+
+static gboolean get_capabilities(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
+	struct avdtp_media_codec_capability *codec = (void *) service->data;
+	uint8_t *caps = codec->data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE, &caps,
+					service->length - sizeof(*codec));
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable sep_properties[] = {
+	{ "UUID", "s", get_uuid, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Codec", "y", get_codec, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Capabilities", "ay", get_capabilities, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
+};
+
+static void register_remote_sep(void *data, void *user_data)
+{
+	struct avdtp_remote_sep *rsep = data;
+	struct a2dp_channel *chan = user_data;
+	struct a2dp_remote_sep *sep;
+
+	sep = queue_find(chan->seps, match_remote_sep, rsep);
+	if (sep)
+		return;
+
+	sep = new0(struct a2dp_remote_sep, 1);
+	sep->chan = chan;
+	sep->sep = rsep;
+
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
+		goto done;
+
+	asprintf(&sep->path, "%s/sep%d", device_get_path(chan->device),
+							avdtp_get_seid(rsep));
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				sep->path, MEDIA_ENDPOINT_INTERFACE,
+				sep_methods, NULL, sep_properties,
+				sep, remote_sep_free) == FALSE) {
+		error("Could not register remote sep %s", sep->path);
+		free(sep->path);
+		sep->path = NULL;
+		goto done;
+	}
+
+	DBG("Found remote SEP: %s", sep->path);
+
+done:
+	queue_push_tail(chan->seps, sep);
+}
+
+static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
+								char **seids)
+{
+	struct avdtp_remote_sep *sep;
+
+	if (!seids)
+		return;
+
+	for (; *seids; seids++) {
+		uint8_t seid;
+		uint8_t type;
+		uint8_t codec;
+		char *value, caps[256];
+		uint8_t data[128];
+		int i, size;
+		GSList *l = NULL;
+
+		if (sscanf(*seids, "%02hhx", &seid) != 1)
+			continue;
+
+		value = g_key_file_get_string(key_file, "Endpoints", *seids,
+								NULL);
+		if (!value)
+			continue;
+
+		if (sscanf(value, "%02hhx:%02hhx:%s", &type, &codec,
+								caps) != 3) {
+			warn("Unable to load Endpoint: seid %u", seid);
+			g_free(value);
+			continue;
+		}
+
+		for (i = 0, size = strlen(caps); i < size; i += 2) {
+			uint8_t *tmp = data + i / 2;
+
+			if (sscanf(caps + i, "%02hhx", tmp) != 1) {
+				warn("Unable to load Endpoint: seid %u", seid);
+				break;
+			}
+		}
+
+		g_free(value);
+
+		if (i != size)
+			continue;
+
+		caps_add_codec(&l, codec, data, size / 2);
+
+		sep = avdtp_register_remote_sep(chan->session, seid, type, l);
+		if (!sep) {
+			warn("Unable to register Endpoint: seid %u", seid);
+			continue;
+		}
+
+		register_remote_sep(sep, chan);
+	}
+}
+
+static void load_remote_seps(struct a2dp_channel *chan)
+{
+	struct btd_device *device = chan->device;
+	char filename[PATH_MAX];
+	char dst_addr[18];
+	char **keys;
+	GKeyFile *key_file;
+
+	ba2str(device_get_address(device), dst_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+			btd_adapter_get_storage_dir(device_get_adapter(device)),
+			dst_addr);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	keys = g_key_file_get_keys(key_file, "Endpoints", NULL, NULL);
+
+	load_remote_sep(chan, key_file, keys);
+
+	g_strfreev(keys);
+	g_key_file_free(key_file);
+}
+
 static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
 					avdtp_session_state_t old_state,
 					avdtp_session_state_t new_state,
@@ -1456,6 +1860,9 @@ static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
 	case AVDTP_SESSION_STATE_CONNECTING:
 		break;
 	case AVDTP_SESSION_STATE_CONNECTED:
+		if (!chan->session)
+			chan->session = session;
+		load_remote_seps(chan);
 		break;
 	}
 }
@@ -1904,28 +2311,6 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 	a2dp_unregister_sep(sep);
 }
 
-static void setup_add_caps(struct a2dp_setup *setup, uint8_t *caps, size_t size)
-{
-	struct avdtp_service_capability *media_transport, *media_codec;
-	struct avdtp_media_codec_capability *cap;
-
-	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
-						NULL, 0);
-
-	setup->caps = g_slist_append(setup->caps, media_transport);
-
-	cap = g_malloc0(sizeof(*cap) + size);
-	cap->media_type = AVDTP_MEDIA_TYPE_AUDIO;
-	cap->media_codec_type = setup->sep->codec;
-	memcpy(cap->data, caps, size);
-
-	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, cap,
-						sizeof(*cap) + size);
-
-	setup->caps = g_slist_append(setup->caps, media_codec);
-	g_free(cap);
-}
-
 static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 {
 	if (size < 0) {
@@ -1933,7 +2318,7 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 		goto done;
 	}
 
-	setup_add_caps(setup, ret, size);
+	caps_add_codec(&setup->caps, setup->sep->codec, ret, size);
 
 done:
 	finalize_select(setup);
@@ -1989,276 +2374,58 @@ static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
 	return a2dp_find_sep(session, l, NULL);
 }
 
-struct client {
-	const char *sender;
-	const char *path;
-};
-
-static int match_client(const void *data, const void *user_data)
-{
-	struct a2dp_sep *sep = (void *) data;
-	const struct a2dp_endpoint *endpoint = sep->endpoint;
-	const struct client *client = user_data;
-
-	if (strcmp(client->sender, endpoint->get_name(sep, sep->user_data)))
-		return -1;
-
-	return strcmp(client->path, endpoint->get_path(sep, sep->user_data));
-}
-
-static struct a2dp_sep *find_sep(struct a2dp_server *server, const char *sender,
-							const char *path)
-{
-	GSList *l;
-	struct client client = { sender, path };
-
-	l = g_slist_find_custom(server->sources, &client, match_client);
-	if (l)
-		return l->data;
-
-	l = g_slist_find_custom(server->sinks, &client, match_client);
-	if (l)
-		return l->data;
-
-	return NULL;
-}
-
-static int parse_properties(DBusMessageIter *props, uint8_t **caps, int *size)
-{
-	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
-		const char *key;
-		DBusMessageIter value, entry;
-		int var;
-
-		dbus_message_iter_recurse(props, &entry);
-		dbus_message_iter_get_basic(&entry, &key);
-
-		dbus_message_iter_next(&entry);
-		dbus_message_iter_recurse(&entry, &value);
-
-		var = dbus_message_iter_get_arg_type(&value);
-		if (strcasecmp(key, "Capabilities") == 0) {
-			DBusMessageIter array;
-
-			if (var != DBUS_TYPE_ARRAY)
-				return -EINVAL;
-
-			dbus_message_iter_recurse(&value, &array);
-			dbus_message_iter_get_fixed_array(&array, caps, size);
-			return 0;
-		}
-
-		dbus_message_iter_next(props);
-	}
-
-	return -EINVAL;
-}
-
-static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
-			struct a2dp_sep *lsep, struct a2dp_remote_sep *rsep,
-			uint8_t *caps, int size)
-{
-	struct a2dp_setup *setup;
-	const struct queue_entry *entry;
-	int err;
-
-	setup = a2dp_setup_get(chan->session);
-	if (!setup)
-		return -ENOMEM;
-
-	setup->sep = lsep;
-	setup->rsep = rsep;
-
-	setup_add_caps(setup, caps, size);
-
-	/* Check for existing stream and close it */
-	for (entry = queue_get_entries(chan->server->seps); entry;
-						entry = entry->next) {
-		struct a2dp_sep *tmp = entry->data;
-
-		/* Attempt to reconfigure if a stream already exists */
-		if (tmp->stream) {
-			/* Only allow switching sep from the same sender
-			if (strcmp(sender, sep->endpoint->get_name(tmp,
-							tmp->user_data)))
-				return btd_error_not_authorized(msg);
-			*/
-
-			err = avdtp_close(chan->session, tmp->stream, FALSE);
-			if (err < 0) {
-				error("avdtp_close: %s", strerror(-err));
-				return err;
-			}
-
-			setup->reconfigure = TRUE;
-
-			return 0;
-		}
-	}
-
-	err = avdtp_set_configuration(setup->session, setup->rsep->sep,
-						lsep->lsep,
-						setup->caps,
-						&setup->stream);
-	if (err < 0) {
-		error("avdtp_set_configuration: %s", strerror(-err));
-		return err;
-	}
-
-	return 0;
-}
-
-static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
-								void *data)
-{
-	struct a2dp_remote_sep *rsep = data;
-	struct a2dp_channel *chan = rsep->chan;
-	struct a2dp_sep *lsep;
-	struct avdtp_service_capability *service;
-	struct avdtp_media_codec_capability *codec;
-	DBusMessageIter args, props;
-	const char *sender, *path;
-	uint8_t *caps;
-	int err, size = 0;
-
-	sender = dbus_message_get_sender(msg);
-
-	dbus_message_iter_init(msg, &args);
-
-	dbus_message_iter_get_basic(&args, &path);
-	dbus_message_iter_next(&args);
-
-	lsep = find_sep(chan->server, sender, path);
-	if (!lsep)
-		return btd_error_invalid_args(msg);
-
-	/* Check if SEPs are no the same role */
-	if (avdtp_get_type(rsep->sep) == lsep->type)
-		return btd_error_invalid_args(msg);
-
-	service = avdtp_get_codec(rsep->sep);
-	codec = (struct avdtp_media_codec_capability *) service->data;
-
-	/* Check if codec match */
-	if (!endpoint_match_codec_ind(chan->session, codec, lsep))
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_recurse(&args, &props);
-	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
-		return btd_error_invalid_args(msg);
-
-	if (parse_properties(&props, &caps, &size) < 0)
-		return btd_error_invalid_args(msg);
-
-	err = a2dp_reconfig(chan, sender, lsep, rsep, caps, size);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-}
-
-static const GDBusMethodTable sep_methods[] = {
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
-					GDBUS_ARGS({ "endpoint", "o" },
-						{ "properties", "a{sv}" } ),
-					NULL, set_configuration) },
-	{ },
-};
-
-static gboolean get_uuid(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct a2dp_remote_sep *sep = data;
-	const char *uuid;
-
-	switch (avdtp_get_type(sep->sep)) {
-	case AVDTP_SEP_TYPE_SOURCE:
-		uuid = A2DP_SOURCE_UUID;
-		break;
-	case AVDTP_SEP_TYPE_SINK:
-		uuid = A2DP_SOURCE_UUID;
-		break;
-	default:
-		uuid = "";
-	}
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
-
-	return TRUE;
-}
-
-static gboolean get_codec(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct a2dp_remote_sep *sep = data;
-	struct avdtp_service_capability *cap = avdtp_get_codec(sep->sep);
-	struct avdtp_media_codec_capability *codec = (void *) cap->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-						&codec->media_codec_type);
-
-	return TRUE;
-}
-
-static gboolean get_capabilities(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
+static void store_remote_sep(void *data, void *user_data)
 {
 	struct a2dp_remote_sep *sep = data;
+	GKeyFile *key_file = (void *) user_data;
+	char seid[4], value[256];
 	struct avdtp_service_capability *service = avdtp_get_codec(sep->sep);
 	struct avdtp_media_codec_capability *codec = (void *) service->data;
-	uint8_t *caps = codec->data;
-	DBusMessageIter array;
+	unsigned int i;
+	ssize_t offset;
 
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-					DBUS_TYPE_BYTE_AS_STRING, &array);
+	sprintf(seid, "%02hhx", avdtp_get_seid(sep->sep));
 
-	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE, &caps,
-					service->length - sizeof(*codec));
+	offset = sprintf(value, "%02hhx:%02hhx:", avdtp_get_type(sep->sep),
+						codec->media_codec_type);
 
-	dbus_message_iter_close_container(iter, &array);
+	for (i = 0; i < service->length - sizeof(*codec); i++)
+		offset += sprintf(value + offset, "%02hhx", codec->data[i]);
 
-	return TRUE;
-}
 
-static const GDBusPropertyTable sep_properties[] = {
-	{ "UUID", "s", get_uuid, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Codec", "y", get_codec, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Capabilities", "ay", get_capabilities, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ }
-};
+	g_key_file_set_string(key_file, "Endpoints", seid, value);
+}
 
-static void register_remote_sep(void *data, void *user_data)
+static void store_remote_seps(struct a2dp_channel *chan)
 {
-	struct avdtp_remote_sep *rsep = data;
-	struct a2dp_setup *setup = user_data;
-	struct a2dp_remote_sep *sep;
+	struct btd_device *device = chan->device;
+	char filename[PATH_MAX];
+	char dst_addr[18];
+	GKeyFile *key_file;
+	char *data;
+	gsize length = 0;
 
-	sep = new0(struct a2dp_remote_sep, 1);
-	sep->chan = setup->chan;
-	sep->sep = rsep;
+	if (queue_isempty(chan->seps))
+		return;
 
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
-		goto done;
+	ba2str(device_get_address(device), dst_addr);
 
-	asprintf(&sep->path, "%s/sep%d", device_get_path(setup->chan->device),
-							avdtp_get_seid(rsep));
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+			btd_adapter_get_storage_dir(device_get_adapter(device)),
+			dst_addr);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	if (g_dbus_register_interface(btd_get_dbus_connection(),
-				sep->path, MEDIA_ENDPOINT_INTERFACE,
-				sep_methods, NULL, sep_properties,
-				sep, remote_sep_free) == FALSE) {
-		error("Could not register remote sep %s", sep->path);
-		free(sep->path);
-		sep->path = NULL;
-	}
+	/* Remove current endpoints since it might have changed */
+	g_key_file_remove_group(key_file, "Endpoints", NULL);
 
-	DBG("Found remote SEP: %s", sep->path);
+	queue_foreach(chan->seps, store_remote_sep, key_file);
 
-done:
-	queue_push_tail(setup->chan->seps, sep);
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, data, length, NULL);
+
+	g_free(data);
+	g_key_file_free(key_file);
 }
 
 static void discover_cb(struct avdtp *session, GSList *seps,
@@ -2271,8 +2438,10 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 	setup->seps = seps;
 	setup->err = err;
 
-	if (!err && queue_isempty(setup->chan->seps))
-		g_slist_foreach(seps, register_remote_sep, setup);
+	if (!err) {
+		g_slist_foreach(seps, register_remote_sep, setup->chan);
+		store_remote_seps(setup->chan);
+	}
 
 	finalize_discover(setup);
 }
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index cc4322d10..4f964feb5 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2638,12 +2638,15 @@ static gboolean avdtp_discover_resp(struct avdtp *session,
 		stream = find_stream_by_rseid(session, resp->seps[i].seid);
 
 		sep = find_remote_sep(session->seps, resp->seps[i].seid);
-		if (!sep) {
-			if (resp->seps[i].inuse && !stream)
-				continue;
-			sep = g_new0(struct avdtp_remote_sep, 1);
-			session->seps = g_slist_append(session->seps, sep);
-		}
+		if (sep && sep->type == resp->seps[i].type &&
+				sep->media_type == resp->seps[i].media_type)
+			continue;
+
+		if (resp->seps[i].inuse && !stream)
+			continue;
+
+		sep = g_new0(struct avdtp_remote_sep, 1);
+		session->seps = g_slist_append(session->seps, sep);
 
 		sep->stream = stream;
 		sep->seid = resp->seps[i].seid;
@@ -3192,6 +3195,37 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 	return cap;
 }
 
+struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
+							uint8_t seid,
+							uint8_t type,
+							GSList *caps)
+{
+	struct avdtp_remote_sep *sep;
+	GSList *l;
+
+	sep = find_remote_sep(session->seps, seid);
+	if (sep)
+		return sep;
+
+	sep = g_new0(struct avdtp_remote_sep, 1);
+	session->seps = g_slist_append(session->seps, sep);
+	sep->seid = seid;
+	sep->type = type;
+	sep->media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	sep->caps = caps;
+
+	for (l = caps; l; l = g_slist_next(l)) {
+		struct avdtp_service_capability *cap = l->data;
+
+		if (cap->category == AVDTP_MEDIA_CODEC)
+			sep->codec = cap;
+	}
+
+	DBG("seid %d type %d media %d", sep->seid, sep->type, sep->media_type);
+
+	return sep;
+}
+
 static gboolean process_discover(gpointer data)
 {
 	struct avdtp *session = data;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index e5fc40c89..b03ca9030 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -223,6 +223,11 @@ struct avdtp *avdtp_ref(struct avdtp *session);
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 							void *data, int size);
 
+struct avdtp_remote_sep *avdtp_register_remote_sep(struct avdtp *session,
+							uint8_t seid,
+							uint8_t type,
+							GSList *caps);
+
 uint8_t avdtp_get_seid(struct avdtp_remote_sep *sep);
 
 uint8_t avdtp_get_type(struct avdtp_remote_sep *sep);
-- 
2.17.2

