Return-Path: <SRS0=25t8=VJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4597BC742C7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACF521019
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmnzX8kR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGLPNh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:13:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42089 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfGLPNh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jul 2019 11:13:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so9685105lje.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2019 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OiE7bKNtMMGI+aknU3KEMaiHazWbZYVmEv7aNXVX0do=;
        b=YmnzX8kRLT+JwycUIbG9KzmWpaHI++0WAkU7eC2h8Kh0FuP5PM+w6KD1Ed9TTEfM9U
         2AehpVICcGNayRu3cIUU8PxtXD9uD80R17+dyjNwbuJNFscTqpRR9iAT8ku1XibkE85R
         EbBlAgz/R9AxUEwHN9GDV2yY4RYxB5yDXKUYK87Q7O4ZzmDC7QDkvpwWJOb3+Vf06Atd
         8tEV1JnHHCD3NM59mfkennOD270OiGSHqRbO95ZjfveCzWaDuOPaxrmJjlKxgRO8IesE
         kWNrZM+buFC7yXZgPdCFk8mKk6S5VVCrOAeum1IsRlGTuod+c8slTMPHmgg9joNQAXjn
         NKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OiE7bKNtMMGI+aknU3KEMaiHazWbZYVmEv7aNXVX0do=;
        b=jNNBy3coGRRCKLYNYHuQQScSt7bjigdytFcCLBOa76WZweKJJug+O3b8HO4rSfk9i5
         0cJqv5NoPDzYHqwCaehQVI+fLqO5YMYp5oU4BctBSynEhKFpJ8KB7iH4hT4wnAEoYjae
         yIqVfwwfKRcvtNOHZOV++GLBPOMGg6jgQg9WtMKC3A9FGUBNsl0bw+6QFEcJNLLPeEZU
         4wxZsj8//0MJEbGCkAsc3vnpI8V4lEAKOMhYq9v6ZJsi0/TfzXIIGqYtofKa5f4yi/Om
         nfNHGA5BFXjDZsXNNS5yB7SB2ouYadWKML0rMxaIP8cfIEXwU10ufxVHOVHZe+tldsoG
         cKpA==
X-Gm-Message-State: APjAAAU17Ao3B/uekeev6Vm59kkHkqAkZfpgXNNk2iNBBWzPG6F9xpJi
        kR285DWuJ8eFdkyKq1tr7hfw5O7vqTE=
X-Google-Smtp-Source: APXvYqwrcCNvP2lzKCZfG0+JANThlfy/P0YJN2DABr+Mb6YMOA8AYEyIhSK5R+nr1ixkVtizYP36dQ==
X-Received: by 2002:a2e:9048:: with SMTP id n8mr6297907ljg.37.1562944413513;
        Fri, 12 Jul 2019 08:13:33 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id y18sm1478970ljh.1.2019.07.12.08.13.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 08:13:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] media: Add implementation of RegisterApplication
Date:   Fri, 12 Jul 2019 18:13:27 +0300
Message-Id: <20190712151329.11333-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712151329.11333-1-luiz.dentz@gmail.com>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements RegisterApplication registering any proxy which does
implement either MediaEndpoint or MediaPlayer.
---
 profiles/audio/media.c | 485 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 482 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 28fa70668..993ecb3b3 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -48,6 +48,7 @@
 #include "src/uuid-helper.h"
 #include "src/log.h"
 #include "src/error.h"
+#include "src/shared/util.h"
 #include "src/shared/queue.h"
 
 #include "avdtp.h"
@@ -62,8 +63,21 @@
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
+struct media_app {
+	struct media_adapter	*adapter;
+	GDBusClient		*client;
+	DBusMessage		*reg;
+	char			*sender;	/* Application bus id */
+	char			*path;		/* Application object path */
+	struct queue		*proxies;	/* Application proxies */
+	struct queue		*endpoints;	/* Application endpoints */
+	struct queue		*players;	/* Application players */
+	int			err;
+};
+
 struct media_adapter {
 	struct btd_adapter	*btd_adapter;
+	struct queue		*apps;		/* Application list */
 	GSList			*endpoints;	/* Endpoints list */
 	GSList			*players;	/* Players list */
 };
@@ -194,8 +208,9 @@ static struct media_endpoint *media_adapter_find_endpoint(
 	return NULL;
 }
 
-static void media_endpoint_remove(struct media_endpoint *endpoint)
+static void media_endpoint_remove(void *data)
 {
+	struct media_endpoint *endpoint = data;
 	struct media_adapter *adapter = endpoint->adapter;
 
 	if (endpoint->sep) {
@@ -996,8 +1011,10 @@ static void media_player_destroy(struct media_player *mp)
 	media_player_free(mp);
 }
 
-static void media_player_remove(struct media_player *mp)
+static void media_player_remove(void *data)
 {
+	struct media_player *mp = data;
+
 	info("Player unregistered: sender=%s path=%s", mp->sender, mp->path);
 
 	media_player_destroy(mp);
@@ -1341,7 +1358,7 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	const char *status;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT64)
-			return FALSE;
+		return FALSE;
 
 	dbus_message_iter_get_basic(iter, &value);
 
@@ -1870,6 +1887,461 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static void app_free(void *data)
+{
+	struct media_app *app = data;
+
+	queue_destroy(app->endpoints, media_endpoint_remove);
+	queue_destroy(app->players, media_player_remove);
+
+	if (app->client) {
+		g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
+		g_dbus_client_set_proxy_handlers(app->client, NULL, NULL,
+								NULL, NULL);
+		g_dbus_client_set_ready_watch(app->client, NULL, NULL);
+		g_dbus_client_unref(app->client);
+	}
+
+	if (app->reg)
+		dbus_message_unref(app->reg);
+
+	g_free(app->sender);
+	g_free(app->path);
+
+	free(app);
+}
+
+static void client_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct media_app *app = user_data;
+	struct media_adapter *adapter = app->adapter;
+
+	DBG("Client disconnected");
+
+	if (queue_remove(adapter->apps, app))
+		app_free(app);
+}
+
+static void app_register_endpoint(void *data, void *user_data)
+{
+	struct media_app *app = user_data;
+	GDBusProxy *proxy = data;
+	const char *iface = g_dbus_proxy_get_interface(proxy);
+	const char *path = g_dbus_proxy_get_path(proxy);
+	const char *uuid;
+	gboolean delay_reporting = FALSE;
+	uint8_t codec;
+	uint8_t *capabilities = NULL;
+	int size = 0;
+	DBusMessageIter iter, array;
+	struct media_endpoint *endpoint;
+
+	if (app->err)
+		return;
+
+	if (strcmp(iface, MEDIA_ENDPOINT_INTERFACE))
+		return;
+
+	/* Parse properties */
+	if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
+		goto fail;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		goto fail;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	if (!g_dbus_proxy_get_property(proxy, "Codec", &iter))
+		goto fail;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
+		goto fail;
+
+	dbus_message_iter_get_basic(&iter, &codec);
+
+	/* DelayReporting and Capabilities are considered optional */
+	if (g_dbus_proxy_get_property(proxy, "DelayReporting", &iter))	{
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &delay_reporting);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Capabilities", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+			goto fail;
+
+		dbus_message_iter_recurse(&iter, &array);
+		dbus_message_iter_get_fixed_array(&array, &capabilities, &size);
+	}
+
+	endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
+					delay_reporting, codec, capabilities,
+					size, &app->err);
+	if (!endpoint) {
+		error("Unable to register endpoint %s:%s: %s", app->sender,
+						path, strerror(-app->err));
+		return;
+	}
+
+	queue_push_tail(app->endpoints, endpoint);
+
+	return;
+
+fail:
+	app->err = -EINVAL;
+}
+
+static void app_register_player(void *data, void *user_data)
+{
+	struct media_app *app = user_data;
+	GDBusProxy *proxy = data;
+	const char *iface = g_dbus_proxy_get_interface(proxy);
+	const char *path = g_dbus_proxy_get_path(proxy);
+	struct media_player *player;
+	DBusMessageIter iter;
+
+	if (app->err)
+		return;
+
+	if (strcmp(iface, MEDIA_PLAYER_INTERFACE))
+		return;
+
+	player = media_player_create(app->adapter, app->sender, path,
+							&app->err);
+	if (!player)
+		return;
+
+	if (g_dbus_proxy_get_property(proxy, "PlaybackStatus", &iter)) {
+		if (!set_status(player, &iter))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Position", &iter)) {
+		if (!set_position(player, &iter))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Metadata", &iter)) {
+		if (!parse_player_metadata(player, &iter))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Shuffle", &iter)) {
+		if (!set_shuffle(player, &iter))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "LoopStatus", &iter)) {
+		if (!set_repeat(player, &iter))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "CanPlay", &iter)) {
+		if (!set_flag(player, &iter, &player->play))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "CanPause", &iter)) {
+		if (!set_flag(player, &iter, &player->pause))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "CanGoNext", &iter)) {
+		if (!set_flag(player, &iter, &player->next))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "CanGoPrevious", &iter)) {
+		if (!set_flag(player, &iter, &player->previous))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "CanControl", &iter)) {
+		if (!set_flag(player, &iter, &player->control))
+			goto fail;
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "Identity", &iter)) {
+		if (!set_name(player, &iter))
+			goto fail;
+	}
+
+	queue_push_tail(app->players, player);
+
+	return;
+fail:
+	app->err = -EINVAL;
+	error("Unable to register player %s:%s: %s", app->sender, path,
+							strerror(-app->err));
+	media_player_destroy(player);
+}
+
+static void remove_app(void *data)
+{
+	struct media_app *app = data;
+
+	/*
+	 * Set callback to NULL to avoid potential race condition
+	 * when calling remove_app and GDBusClient unref.
+	 */
+	g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
+
+	/*
+	 * Set proxy handlers to NULL, so that this gets called only once when
+	 * the first proxy that belongs to this service gets removed.
+	 */
+	g_dbus_client_set_proxy_handlers(app->client, NULL, NULL, NULL, NULL);
+
+
+	queue_remove(app->adapter->apps, app);
+
+	app_free(app);
+}
+
+static void client_ready_cb(GDBusClient *client, void *user_data)
+{
+	struct media_app *app = user_data;
+	DBusMessage *reply;
+	bool fail = false;
+
+	/*
+	 * Process received objects
+	 */
+	if (queue_isempty(app->proxies)) {
+		error("No object received");
+		fail = true;
+		reply = btd_error_failed(app->reg, "No object received");
+		goto reply;
+	}
+
+	queue_foreach(app->proxies, app_register_endpoint, app);
+	queue_foreach(app->proxies, app_register_player, app);
+
+	if (app->err) {
+		if (app->err == -EPROTONOSUPPORT)
+			reply = btd_error_not_supported(app->reg);
+		else
+			reply = btd_error_invalid_args(app->reg);
+		goto reply;
+	}
+
+	if ((queue_isempty(app->endpoints) && queue_isempty(app->players))) {
+		error("No valid external Media objects found");
+		fail = true;
+		reply = btd_error_failed(app->reg,
+					"No valid media object found");
+		goto reply;
+	}
+
+	DBG("Media application registered: %s:%s", app->sender, app->path);
+
+	reply = dbus_message_new_method_return(app->reg);
+
+reply:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(app->reg);
+	app->reg = NULL;
+
+	if (fail)
+		remove_app(app);
+}
+
+static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct media_app *app = user_data;
+	const char *iface, *path;
+
+	if (app->err)
+		return;
+
+	queue_push_tail(app->proxies, proxy);
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	DBG("Proxy added: %s, iface: %s", path, iface);
+}
+
+static bool match_endpoint_by_path(const void *a, const void *b)
+{
+	const struct media_endpoint *endpoint = a;
+	const char *path = b;
+
+	return !strcmp(endpoint->path, path);
+}
+
+static bool match_player_by_path(const void *a, const void *b)
+{
+	const struct media_player *player = a;
+	const char *path = b;
+
+	return !strcmp(player->path, path);
+}
+
+static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
+{
+	struct media_app *app = user_data;
+	struct media_endpoint *endpoint;
+	struct media_player *player;
+	const char *iface, *path;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	if (!strcmp(iface, MEDIA_ENDPOINT_INTERFACE)) {
+		endpoint = queue_remove_if(app->endpoints,
+						match_endpoint_by_path,
+						(void *) path);
+		if (!endpoint)
+			return;
+
+		if (!g_slist_find(app->adapter->endpoints, endpoint))
+			return;
+
+		DBG("Proxy removed - removing endpoint: %s", endpoint->path);
+
+		media_endpoint_remove(endpoint);
+	} else if (!strcmp(iface, MEDIA_PLAYER_INTERFACE)) {
+		player = queue_remove_if(app->players, match_player_by_path,
+						(void *) path);
+		if (!player)
+			return;
+
+		if (!g_slist_find(app->adapter->players, player))
+			return;
+
+		DBG("Proxy removed - removing player: %s", player->path);
+
+		media_player_remove(player);
+	}
+}
+
+static struct media_app *create_app(DBusConnection *conn, DBusMessage *msg,
+							const char *path)
+{
+	struct media_app *app;
+	const char *sender = dbus_message_get_sender(msg);
+
+	if (!path || !g_str_has_prefix(path, "/"))
+		return NULL;
+
+	app = new0(struct media_app, 1);
+
+	app->client = g_dbus_client_new_full(conn, sender, path, path);
+	if (!app->client)
+		goto fail;
+
+	app->sender = g_strdup(sender);
+	if (!app->sender)
+		goto fail;
+
+	app->path = g_strdup(path);
+	if (!app->path)
+		goto fail;
+
+	app->proxies = queue_new();
+	app->endpoints = queue_new();
+	app->players = queue_new();
+	app->reg = dbus_message_ref(msg);
+
+	g_dbus_client_set_disconnect_watch(app->client, client_disconnect_cb,
+									app);
+	g_dbus_client_set_proxy_handlers(app->client, proxy_added_cb,
+					proxy_removed_cb, NULL, app);
+	g_dbus_client_set_ready_watch(app->client, client_ready_cb, app);
+
+	return app;
+
+fail:
+	app_free(app);
+	return NULL;
+}
+
+struct match_data {
+	const char *path;
+	const char *sender;
+};
+
+static bool match_app(const void *a, const void *b)
+{
+	const struct media_app *app = a;
+	const struct match_data *data = b;
+
+	return g_strcmp0(app->path, data->path) == 0 &&
+				g_strcmp0(app->sender, data->sender) == 0;
+}
+
+static DBusMessage *register_app(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct media_adapter *adapter = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	DBusMessageIter args;
+	const char *path;
+	struct media_app *app;
+	struct match_data match_data;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	match_data.path = path;
+	match_data.sender = sender;
+
+	if (queue_find(adapter->apps, match_app, &match_data))
+		return btd_error_already_exists(msg);
+
+	dbus_message_iter_next(&args);
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
+		return btd_error_invalid_args(msg);
+
+	app = create_app(conn, msg, path);
+	if (!app)
+		return btd_error_failed(msg, "Failed to register application");
+
+	DBG("Registering application: %s:%s", sender, path);
+
+	app->adapter = adapter;
+	queue_push_tail(adapter->apps, app);
+
+	return NULL;
+}
+
+static DBusMessage *unregister_app(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct media_adapter *adapter = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	const char *path;
+	DBusMessageIter args;
+	struct media_app *app;
+	struct match_data match_data;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&args, &path);
+
+	match_data.path = path;
+	match_data.sender = sender;
+
+	app = queue_remove_if(adapter->apps, match_app, &match_data);
+	if (!app)
+		return btd_error_does_not_exist(msg);
+
+	app_free(app);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable media_methods[] = {
 	{ GDBUS_METHOD("RegisterEndpoint",
 		GDBUS_ARGS({ "endpoint", "o" }, { "properties", "a{sv}" }),
@@ -1881,6 +2353,13 @@ static const GDBusMethodTable media_methods[] = {
 		NULL, register_player) },
 	{ GDBUS_METHOD("UnregisterPlayer",
 		GDBUS_ARGS({ "player", "o" }), NULL, unregister_player) },
+	{ GDBUS_ASYNC_METHOD("RegisterApplication",
+					GDBUS_ARGS({ "application", "o" },
+						{ "options", "a{sv}" }),
+					NULL, register_app) },
+	{ GDBUS_ASYNC_METHOD("UnregisterApplication",
+					GDBUS_ARGS({ "application", "o" }),
+					NULL, unregister_app) },
 	{ },
 };
 
-- 
2.21.0

