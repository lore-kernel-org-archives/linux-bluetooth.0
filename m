Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D1C43612
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A4A20866
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oje+TX/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfAOOMb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:12:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46996 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfAOOMa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 09:12:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so1561809qkf.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jan 2019 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=d/rnhqjqCtRKGcfOjn41Yq4JW7h0VbUfH2Gz9lInaYc=;
        b=oje+TX/RL5v3wDQCnQPz5zHb5vrRyA4scfkzBjpvyR4zZqQI+rJJKBV+St8+gWxNJ+
         yovHdLtwNyecxA8Kv7fkL/ZZE5ffeO08t8fbjDk0Eo4aoVyLrTN0IGAEPCgxr3r56C3y
         yh9SuDa5W0kKUZNDvfLD+o1G/kRinU5tdZF17NcaF0dW3xAtKhzYwkBhGny6ECZtPT1B
         7u4JUbd4HoaBBAPrDjHdQrCYC1+Jbqy1WiRPVGL3IKOFHp+aeuX0Fmqarqc8hKCt52bM
         SRviVGhq0iquyWF4Flkc5dWRRrWKjhgyLfmKUwjITWcuyjeBfoxNH3U9BulXzejT8tDg
         kCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=d/rnhqjqCtRKGcfOjn41Yq4JW7h0VbUfH2Gz9lInaYc=;
        b=surHoFnr9NeSh2KVWtjLo58YB/NSpmoKZSOwhjQ1GfZZNE7ca3nwYmL7KqwaVZEYdO
         wxgUGK7ulehOl5SxP9NrkMqruaJfRnzIGTrtMkqz4i8mjsZwPDENcNff4eoDOMP50X4o
         0VNx5nmOidIyQYHrhouRjWvsGggpywTNZcMhnWPZqKTZLOMSFDtotZlsU0EXTm7U5dAC
         hh5c3b2tvbeXMRzyIFA9e9n1NNMjMGu3wqJQppXFiMb35+dVhqnO/3MLmsQ0DoDPP5KZ
         OTCdJRlYmCiJ/TPUQ2Z1ca/5WhmtBZy+uPyUcPTF3h/vvA9Imw9cbODuSsbgua+0+7y0
         UzbQ==
X-Gm-Message-State: AJcUukcAQVzQB/rhPz5AQ3mR2z7/aST9k1rS1VnimsMRrl7XI8NdNqg3
        ryh8mT9+SaI/0qYNHy2nDZtJKwYme68=
X-Google-Smtp-Source: ALg8bN4sg4/hJeXoAheuKlVErFG/nRhlwYpqkhuyhQBEyQNzN9qi/SQSBoiWrA/Bz9mjWBYWaBEzxQ==
X-Received: by 2002:a37:5107:: with SMTP id f7mr2977735qkb.124.1547561548543;
        Tue, 15 Jan 2019 06:12:28 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id l95sm10572580qkh.37.2019.01.15.06.12.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:12:28 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/8] a2dp: Expose remote SEP
Date:   Tue, 15 Jan 2019 11:10:17 -0300
Message-Id: <20190115141023.353-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190115141023.353-1-luiz.dentz@gmail.com>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements MediaEndpoint for remote SEP which can be used by
clients to switch configuration on demand.
---
 profiles/audio/a2dp.c  | 351 ++++++++++++++++++++++++++++++++++++++++-
 profiles/audio/a2dp.h  |   1 +
 profiles/audio/avdtp.c |  10 ++
 profiles/audio/avdtp.h |   4 +
 profiles/audio/media.c |   8 +
 5 files changed, 367 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 344459332..4025776aa 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -27,7 +27,10 @@
 #include <config.h>
 #endif
 
+#define _GNU_SOURCE
+
 #include <stdlib.h>
+#include <stdio.h>
 #include <errno.h>
 
 #include <dbus/dbus.h>
@@ -38,14 +41,19 @@
 #include "lib/sdp_lib.h"
 #include "lib/uuid.h"
 
+#include "gdbus/gdbus.h"
+
 #include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/device.h"
+#include "src/dbus-common.h"
+#include "src/error.h"
 #include "src/profile.h"
 #include "src/service.h"
 #include "src/log.h"
 #include "src/sdpd.h"
 #include "src/shared/queue.h"
+#include "src/shared/util.h"
 
 #include "btio/btio.h"
 
@@ -63,6 +71,8 @@
 
 #define AVDTP_PSM 25
 
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
+
 struct a2dp_sep {
 	struct a2dp_server *server;
 	struct a2dp_endpoint *endpoint;
@@ -93,6 +103,7 @@ struct a2dp_setup_cb {
 };
 
 struct a2dp_setup {
+	struct a2dp_channel *chan;
 	struct avdtp *session;
 	struct a2dp_sep *sep;
 	struct avdtp_remote_sep *rsep;
@@ -121,6 +132,12 @@ struct a2dp_server {
 	struct queue *channels;
 };
 
+struct a2dp_remote_sep {
+	struct a2dp_channel *chan;
+	char *path;
+	struct avdtp_remote_sep *sep;
+};
+
 struct a2dp_channel {
 	struct a2dp_server *server;
 	struct btd_device *device;
@@ -129,6 +146,7 @@ struct a2dp_channel {
 	unsigned int state_id;
 	unsigned int auth_id;
 	struct avdtp *session;
+	struct queue *seps;
 };
 
 static GSList *servers = NULL;
@@ -144,12 +162,42 @@ static struct a2dp_setup *setup_ref(struct a2dp_setup *setup)
 	return setup;
 }
 
+static bool match_by_session(const void *data, const void *user_data)
+{
+	const struct a2dp_channel *chan = data;
+	const struct avdtp *session = user_data;
+
+	return chan->session == session;
+}
+
+static struct a2dp_channel *find_channel(struct avdtp *session)
+{
+	GSList *l;
+
+	for (l = servers; l; l = g_slist_next(l)) {
+		struct a2dp_server *server = l->data;
+		struct a2dp_channel *chan;
+
+		chan = queue_find(server->channels, match_by_session, session);
+		if (chan)
+			return chan;
+	}
+
+	return NULL;
+}
+
 static struct a2dp_setup *setup_new(struct avdtp *session)
 {
 	struct a2dp_setup *setup;
+	struct a2dp_channel *chan;
+
+	chan = find_channel(session);
+	if (!chan)
+		return NULL;
 
 	setup = g_new0(struct a2dp_setup, 1);
 	setup->session = avdtp_ref(session);
+	setup->chan = find_channel(session);
 	setups = g_slist_append(setups, setup);
 
 	return setup;
@@ -1299,6 +1347,14 @@ static struct a2dp_server *find_server(GSList *list, struct btd_adapter *a)
 	return NULL;
 }
 
+static void remove_remote_sep(void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), sep->path,
+						MEDIA_ENDPOINT_INTERFACE);
+}
+
 static void channel_free(void *data)
 {
 	struct a2dp_channel *chan = data;
@@ -1316,6 +1372,7 @@ static void channel_free(void *data)
 
 	avdtp_remove_state_cb(chan->state_id);
 
+	queue_destroy(chan->seps, remove_remote_sep);
 	g_free(chan);
 }
 
@@ -1371,6 +1428,7 @@ static struct a2dp_channel *channel_new(struct a2dp_server *server,
 	chan = g_new0(struct a2dp_channel, 1);
 	chan->server = server;
 	chan->device = device;
+	chan->seps = queue_new();
 	chan->state_id = avdtp_add_state_cb(device, avdtp_state_cb, chan);
 
 	if (!queue_push_tail(server->channels, chan)) {
@@ -1805,16 +1863,11 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 	a2dp_unregister_sep(sep);
 }
 
-static void select_cb(struct a2dp_setup *setup, void *ret, int size)
+static void setup_add_caps(struct a2dp_setup *setup, uint8_t *caps, size_t size)
 {
 	struct avdtp_service_capability *media_transport, *media_codec;
 	struct avdtp_media_codec_capability *cap;
 
-	if (size < 0) {
-		DBG("Endpoint replied an invalid configuration");
-		goto done;
-	}
-
 	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
 						NULL, 0);
 
@@ -1823,13 +1876,23 @@ static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 	cap = g_malloc0(sizeof(*cap) + size);
 	cap->media_type = AVDTP_MEDIA_TYPE_AUDIO;
 	cap->media_codec_type = setup->sep->codec;
-	memcpy(cap->data, ret, size);
+	memcpy(cap->data, caps, size);
 
 	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, cap,
 						sizeof(*cap) + size);
 
 	setup->caps = g_slist_append(setup->caps, media_codec);
 	g_free(cap);
+}
+
+static void select_cb(struct a2dp_setup *setup, void *ret, int size)
+{
+	if (size < 0) {
+		DBG("Endpoint replied an invalid configuration");
+		goto done;
+	}
+
+	setup_add_caps(setup, ret, size);
 
 done:
 	finalize_select(setup);
@@ -1885,6 +1948,277 @@ static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
 	return a2dp_find_sep(session, l, NULL);
 }
 
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
+static struct a2dp_sep *find_sep(struct a2dp_server *server, const char *sender,
+							const char *path)
+{
+	GSList *l;
+	struct client client = { sender, path };
+
+	l = g_slist_find_custom(server->sources, &client, match_client);
+	if (l)
+		return l->data;
+
+	l = g_slist_find_custom(server->sinks, &client, match_client);
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
+static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
+			struct a2dp_sep *lsep, struct a2dp_remote_sep *rsep,
+			uint8_t *caps, int size)
+{
+	struct a2dp_setup *setup;
+	const struct queue_entry *entry;
+	int err;
+
+	setup = a2dp_setup_get(chan->session);
+	if (!setup)
+		return -ENOMEM;
+
+	setup->sep = lsep;
+	setup->rsep = rsep->sep;
+
+	setup_add_caps(setup, caps, size);
+
+	/* Check for existing stream and close it */
+	for (entry = queue_get_entries(chan->server->seps); entry;
+						entry = entry->next) {
+		struct a2dp_sep *tmp = entry->data;
+
+		/* Attempt to reconfigure if a stream already exists */
+		if (tmp->stream) {
+			/* Only allow switching sep from the same sender */
+			if (strcmp(sender, tmp->endpoint->get_name(tmp,
+							tmp->user_data)))
+				return -EPERM;
+
+			err = avdtp_close(chan->session, tmp->stream, FALSE);
+			if (err < 0) {
+				error("avdtp_close: %s", strerror(-err));
+				return err;
+			}
+
+			setup->reconfigure = TRUE;
+
+			return 0;
+		}
+	}
+
+	err = avdtp_set_configuration(setup->session, setup->rsep,
+						lsep->lsep,
+						setup->caps,
+						&setup->stream);
+	if (err < 0) {
+		error("avdtp_set_configuration: %s", strerror(-err));
+		return err;
+	}
+
+	return 0;
+}
+
+static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct a2dp_remote_sep *rsep = data;
+	struct a2dp_channel *chan = rsep->chan;
+	struct a2dp_sep *lsep;
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
+	lsep = find_sep(chan->server, sender, path);
+	if (!lsep)
+		return btd_error_invalid_args(msg);
+
+	/* Check if SEPs are no the same role */
+	if (avdtp_get_type(rsep->sep) == lsep->type)
+		return btd_error_invalid_args(msg);
+
+	service = avdtp_get_codec(rsep->sep);
+	codec = (struct avdtp_media_codec_capability *) service->data;
+
+	/* Check if codec match */
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
+	err = a2dp_reconfig(chan, sender, lsep, rsep, caps, size);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
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
+static void remote_sep_free(void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+
+	free(sep->path);
+	free(sep);
+}
+
+static void register_remote_sep(void *data, void *user_data)
+{
+	struct avdtp_remote_sep *rsep = data;
+	struct a2dp_setup *setup = user_data;
+	struct a2dp_remote_sep *sep;
+
+	sep = new0(struct a2dp_remote_sep, 1);
+	sep->chan = setup->chan;
+	sep->sep = rsep;
+	asprintf(&sep->path, "%s/sep%d", device_get_path(setup->chan->device),
+							avdtp_get_seid(rsep));
+
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				sep->path, MEDIA_ENDPOINT_INTERFACE,
+				sep_methods, NULL, sep_properties,
+				sep, remote_sep_free) == FALSE) {
+		error("Could not register remote sep %s", sep->path);
+		remote_sep_free(sep);
+	}
+
+	queue_push_tail(setup->chan->seps, sep);
+}
+
 static void discover_cb(struct avdtp *session, GSList *seps,
 				struct avdtp_error *err, void *user_data)
 {
@@ -1895,6 +2229,9 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 	setup->seps = seps;
 	setup->err = err;
 
+	if (!err && queue_isempty(setup->chan->seps))
+		g_slist_foreach(seps, register_remote_sep, setup);
+
 	finalize_discover(setup);
 }
 
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 2c388bb68..7f38c75f3 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -32,6 +32,7 @@ typedef void (*a2dp_endpoint_config_t) (struct a2dp_setup *setup, gboolean ret);
 
 struct a2dp_endpoint {
 	const char *(*get_name) (struct a2dp_sep *sep, void *user_data);
+	const char *(*get_path) (struct a2dp_sep *sep, void *user_data);
 	size_t (*get_capabilities) (struct a2dp_sep *sep,
 						uint8_t **capabilities,
 						void *user_data);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 2cb3c8a00..cc4322d10 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3161,6 +3161,16 @@ static int process_queue(struct avdtp *session)
 	return send_req(session, FALSE, req);
 }
 
+uint8_t avdtp_get_seid(struct avdtp_remote_sep *sep)
+{
+	return sep->seid;
+}
+
+uint8_t avdtp_get_type(struct avdtp_remote_sep *sep)
+{
+	return sep->type;
+}
+
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep)
 {
 	return sep->codec;
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 621a6e3cf..e5fc40c89 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -223,6 +223,10 @@ struct avdtp *avdtp_ref(struct avdtp *session);
 struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 							void *data, int size);
 
+uint8_t avdtp_get_seid(struct avdtp_remote_sep *sep);
+
+uint8_t avdtp_get_type(struct avdtp_remote_sep *sep);
+
 struct avdtp_service_capability *avdtp_get_codec(struct avdtp_remote_sep *sep);
 
 int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index e2a447e56..9d7564cf0 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -489,6 +489,13 @@ static const char *get_name(struct a2dp_sep *sep, void *user_data)
 	return endpoint->sender;
 }
 
+static const char *get_path(struct a2dp_sep *sep, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+
+	return endpoint->path;
+}
+
 static size_t get_capabilities(struct a2dp_sep *sep, uint8_t **capabilities,
 							void *user_data)
 {
@@ -579,6 +586,7 @@ static void set_delay(struct a2dp_sep *sep, uint16_t delay, void *user_data)
 
 static struct a2dp_endpoint a2dp_endpoint = {
 	.get_name = get_name,
+	.get_path = get_path,
 	.get_capabilities = get_capabilities,
 	.select_configuration = select_config,
 	.set_configuration = set_config,
-- 
2.17.2

