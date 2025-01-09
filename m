Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1A77102
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456708; cv=none; b=q+wluBkynTqo79mgcom3XMA8bm1A4CBlFnLvS5+woSny3mPXEx4Td7beN/ISaowj5K5kjrjXBxnrBa9hetfYs6NHmP5is/F4k+zrPZGOn4DLKDSdE+3kZU6nWEMz6Vn6lunvEfjWB0QQljqegzA2BYZl28SCFs/MNYXUipFfJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456708; c=relaxed/simple;
	bh=NjeFymtLYkivZdcUbVa5v4kIyYlkEAIG/FJfPhhfSqg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ja2aUpp1EA35Tztm1pTEb+imUuL9EtXK6Qetbpyk7puZVg4Q5SOJ00NGyWp6lZ7aM9umtzk23m1ilPDphN5NApLEORioHy4+8C1gQV/obeOmFF04xJzffUpshgjJ/k1cDV1UvR5NqzYycVC+AGWhNRVSJoocCqzRLzzEoadiiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyLHqbBD; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyLHqbBD"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afe6a8d2e1so742100137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2025 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736456704; x=1737061504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ly54I4iFhdsgxSSp4NgrrUpudgxPLFHS54K8cNQCJuE=;
        b=RyLHqbBDwQjD8o8QIMOhmIbsvftjXnP7LwESjWEMK+OYXHODshVg2tecy44LM4RHm0
         b3Vkzr7xClJO2SF3iHha7DDWz9WGK1rQOnEoJ0Y3Kagf8b1b6QiOLj7XT+O5JJIPDgVu
         aReMEoX3Gy6PXu56EAabeM5d/tifB+6saPqR13tVEa4FcjcMFekQ/1QftE+EBonVTf8U
         J53Lu/BOlG86L271iPITAko46FpWzsayt4TOS8d+GRBYWaFUX4zybZ/ay95WBBzVyNN8
         3nq7WKdgs6oZ4Etq4W8XvyBjX081m8kMris7Ry+OpjVpnQJUCT+6uqN7TQsI1qBRz+Pj
         TTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736456704; x=1737061504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ly54I4iFhdsgxSSp4NgrrUpudgxPLFHS54K8cNQCJuE=;
        b=BRJm1ZuUrWyfXpReujbZMVePnF1z2LvmMbKRnEvqyn7rg9swLpjk1m9kb51ypOGZHk
         Ps+2xCtjQwev8PO+BjNjrKhtmOBmgd4xRf3h3ADF3U7Nrr9RGxy9BZEEPwEzXvbvCfUG
         TKMmVVJILnGNpKZQE71DXReXCXHQV73HI8iC1wZUecCb678durft1u78PLr+17yuixVE
         7pOQUJTmf7XGq2yjvkK+KywmvfCRiCtXvDEKzfhiRTaLZKe+nfCW51SneFMd7pYE7fXz
         EdXBNHz0H1hW5Ze/N4U2oKs3Wwh5/tU0x2Vhghkgd3QfP0nmtuT0Gi0WWfItsUdyV92l
         PnBw==
X-Gm-Message-State: AOJu0Yy7ivP4kmyU8Z//IZRxA1T/cMCZHBdxAs/JjvGbEgIbuVbkAHdG
	IoAGLtgH0t6JC5b/SyAb6wQvfhKklOV0QLnLAWCEg8irOEbKG1nbb5ohJvkQ
X-Gm-Gg: ASbGncsCQ5Uug3Bl2QMj4k9PVy6rrBC2ZQJxU+TRi0p6dQo3EB4Bd6uJxi93Ongh5WB
	giPm3L6saa3J1ohlmMYCniDoeHaTqjVj8L24M1GqjPL0Y/avqaOMSsKbJrQLWk/dOXsJj3Vup7m
	6eLI5wTpP76oz3HbSvpokp3ilVZF833PcY1kVGaI/1MCf66vYV4zBodSrbpECWFxCyUX8LHkM+J
	0X12ee0DeZRsQ23ZbNWjm49TzlqMI4WLrOg7ekkyqpNmYMLMu6ZLz2DajTuuAFYtLGv/x8x+Ciy
	l6yfUppmBBDOb4LqLDgmnAOStP3p
X-Google-Smtp-Source: AGHT+IHgRWfkVQSar/H4vyYVhPoDXsh6MDyUeZlY6sGpT55ZE+B5uItXyhVYfiCAxgQXLct+68Rz6w==
X-Received: by 2002:a05:6102:3b13:b0:4af:f1c6:af04 with SMTP id ada2fe7eead31-4b5807e0023mr3764416137.8.1736456703715;
        Thu, 09 Jan 2025 13:05:03 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f86d6fsm1530802137.17.2025.01.09.13.05.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 13:05:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] build: Fix --disable-avrcp
Date: Thu,  9 Jan 2025 16:04:59 -0500
Message-ID: <20250109210500.2324501-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes --disable-avrcp causing build errors.

Fixes: https://github.com/bluez/bluez/issues/1061
---
 Makefile.plugins           |  9 +++++----
 configure.ac               |  3 +++
 profiles/audio/media.c     | 38 +++++++++++++++++++++++++++++++++++++-
 profiles/audio/transport.c | 10 ++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 7644041b3b6d..97335d643028 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -8,6 +8,10 @@ builtin_sources += plugins/autopair.c
 builtin_modules += policy
 builtin_sources += plugins/policy.c
 
+builtin_sources += profiles/audio/media.h profiles/audio/media.c \
+			profiles/audio/transport.h profiles/audio/transport.c \
+			profiles/audio/player.h profiles/audio/player.c
+
 if ADMIN
 builtin_modules += admin
 builtin_sources += plugins/admin.c
@@ -32,8 +36,6 @@ builtin_sources += profiles/audio/source.h profiles/audio/source.c \
 			profiles/audio/sink.h profiles/audio/sink.c \
 			profiles/audio/a2dp.h profiles/audio/a2dp.c \
 			profiles/audio/avdtp.h profiles/audio/avdtp.c \
-			profiles/audio/media.h profiles/audio/media.c \
-			profiles/audio/transport.h profiles/audio/transport.c \
 			profiles/audio/a2dp-codecs.h
 endif
 
@@ -42,8 +44,7 @@ if AVRCP
 builtin_modules += avrcp
 builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 			profiles/audio/avctp.h profiles/audio/avctp.c \
-			profiles/audio/avrcp.h profiles/audio/avrcp.c \
-			profiles/audio/player.h profiles/audio/player.c
+			profiles/audio/avrcp.h profiles/audio/avrcp.c
 endif
 
 if NETWORK
diff --git a/configure.ac b/configure.ac
index 01f0f2ba04c0..964206bf17f0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -180,6 +180,9 @@ AM_CONDITIONAL(A2DP, test "${enable_a2dp}" != "no")
 AC_ARG_ENABLE(avrcp, AS_HELP_STRING([--disable-avrcp],
 		[disable AVRCP profile]), [enable_avrcp=${enableval}])
 AM_CONDITIONAL(AVRCP, test "${enable_avrcp}" != "no")
+if test "${enable_avrcp}" != "no"; then
+	AC_DEFINE(HAVE_AVRCP, 1, [Define to 1 if you have AVRCP support.])
+fi
 
 AC_ARG_ENABLE(network, AS_HELP_STRING([--disable-network],
 		[disable network profiles]), [enable_network=${enableval}])
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 062475e56c49..69c6dc67135b 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -49,7 +49,10 @@
 #include "media.h"
 #include "transport.h"
 #include "a2dp.h"
+
+#ifdef HAVE_AVRCP
 #include "avrcp.h"
+#endif
 
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
@@ -65,7 +68,9 @@ struct media_app {
 	char			*path;		/* Application object path */
 	struct queue		*proxies;	/* Application proxies */
 	struct queue		*endpoints;	/* Application endpoints */
+#ifdef HAVE_AVRCP
 	struct queue		*players;	/* Application players */
+#endif
 	int			err;
 };
 
@@ -73,7 +78,9 @@ struct media_adapter {
 	struct btd_adapter	*btd_adapter;
 	struct queue		*apps;		/* Application list */
 	GSList			*endpoints;	/* Endpoints list */
+#ifdef HAVE_AVRCP
 	GSList			*players;	/* Players list */
+#endif
 };
 
 struct endpoint_request {
@@ -482,6 +489,7 @@ struct a2dp_config_data {
 
 int8_t media_player_get_device_volume(struct btd_device *device)
 {
+#ifdef HAVE_AVRCP
 	struct avrcp_player *target_player;
 	struct media_adapter *adapter;
 	GSList *l;
@@ -505,6 +513,7 @@ int8_t media_player_get_device_volume(struct btd_device *device)
 	}
 
 done:
+#endif /* HAVE_AVRCP */
 	/* If media_player doesn't exists use device_volume */
 	return btd_device_get_volume(device);
 }
@@ -1760,6 +1769,7 @@ static DBusMessage *unregister_endpoint(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+#ifdef HAVE_AVRCP
 static struct media_player *media_adapter_find_player(
 						struct media_adapter *adapter,
 						const char *sender,
@@ -2649,10 +2659,12 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 
 	return mp;
 }
+#endif /* HAVE_AVRCP */
 
 static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
+#ifdef HAVE_AVRCP
 	struct media_adapter *adapter = data;
 	struct media_player *mp;
 	DBusMessageIter args;
@@ -2683,11 +2695,15 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+#else
+	return btd_error_not_supported(msg);
+#endif
 }
 
 static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
+#ifdef HAVE_AVRCP
 	struct media_adapter *adapter = data;
 	struct media_player *player;
 	const char *sender, *path;
@@ -2706,6 +2722,9 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	media_player_remove(player);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+#else
+	return btd_error_not_supported(msg);
+#endif
 }
 
 static void app_free(void *data)
@@ -2714,7 +2733,9 @@ static void app_free(void *data)
 
 	queue_destroy(app->proxies, NULL);
 	queue_destroy(app->endpoints, media_endpoint_remove);
+#ifdef HAVE_AVRCP
 	queue_destroy(app->players, media_player_remove);
+#endif
 
 	if (app->client) {
 		g_dbus_client_set_disconnect_watch(app->client, NULL, NULL);
@@ -2913,6 +2934,7 @@ fail:
 
 static void app_register_player(void *data, void *user_data)
 {
+#ifdef HAVE_AVRCP
 	struct media_app *app = user_data;
 	GDBusProxy *proxy = data;
 	const char *iface = g_dbus_proxy_get_interface(proxy);
@@ -2994,6 +3016,7 @@ fail:
 	error("Unable to register player %s:%s: %s", app->sender, path,
 							strerror(-app->err));
 	media_player_destroy(player);
+#endif /* HAVE_AVRCP */
 }
 
 static void remove_app(void *data)
@@ -3042,7 +3065,11 @@ static void client_ready_cb(GDBusClient *client, void *user_data)
 		goto reply;
 	}
 
+#ifdef HAVE_AVRCP
 	if ((queue_isempty(app->endpoints) && queue_isempty(app->players))) {
+#else
+	if (queue_isempty(app->endpoints)) {
+#endif
 		error("No valid external Media objects found");
 		fail = true;
 		reply = btd_error_failed(app->reg,
@@ -3091,6 +3118,7 @@ static bool match_endpoint_by_path(const void *a, const void *b)
 	return !strcmp(endpoint->path, path);
 }
 
+#ifdef HAVE_AVRCP
 static bool match_player_by_path(const void *a, const void *b)
 {
 	const struct media_player *player = a;
@@ -3098,12 +3126,12 @@ static bool match_player_by_path(const void *a, const void *b)
 
 	return !strcmp(player->path, path);
 }
+#endif
 
 static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 {
 	struct media_app *app = user_data;
 	struct media_endpoint *endpoint;
-	struct media_player *player;
 	const char *iface, *path;
 
 	iface = g_dbus_proxy_get_interface(proxy);
@@ -3122,7 +3150,10 @@ static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 		DBG("Proxy removed - removing endpoint: %s", endpoint->path);
 
 		media_endpoint_remove(endpoint);
+#ifdef HAVE_AVRCP
 	} else if (!strcmp(iface, MEDIA_PLAYER_INTERFACE)) {
+		struct media_player *player;
+
 		player = queue_remove_if(app->players, match_player_by_path,
 						(void *) path);
 		if (!player)
@@ -3134,6 +3165,7 @@ static void proxy_removed_cb(GDBusProxy *proxy, void *user_data)
 		DBG("Proxy removed - removing player: %s", player->path);
 
 		media_player_remove(player);
+#endif
 	}
 }
 
@@ -3162,7 +3194,9 @@ static struct media_app *create_app(DBusConnection *conn, DBusMessage *msg,
 
 	app->proxies = queue_new();
 	app->endpoints = queue_new();
+#ifdef HAVE_AVRCP
 	app->players = queue_new();
+#endif
 	app->reg = dbus_message_ref(msg);
 
 	g_dbus_client_set_disconnect_watch(app->client, client_disconnect_cb,
@@ -3326,6 +3360,7 @@ static void path_free(void *data)
 		release_endpoint(endpoint);
 	}
 
+#ifdef HAVE_AVRCP
 	for (l = adapter->players; l;) {
 		struct media_player *mp = l->data;
 
@@ -3333,6 +3368,7 @@ static void path_free(void *data)
 
 		media_player_destroy(mp);
 	}
+#endif
 
 	adapters = g_slist_remove(adapters, adapter);
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index dbebb1ea5fa0..1b9c66e4940d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -612,6 +612,7 @@ static int8_t transport_a2dp_get_volume(struct media_transport *transport)
 	return a2dp->volume;
 }
 
+#ifdef HAVE_AVRCP
 static int transport_a2dp_src_set_volume(struct media_transport *transport,
 					int8_t level)
 {
@@ -643,6 +644,7 @@ static int transport_a2dp_snk_set_volume(struct media_transport *transport,
 
 	return avrcp_set_volume(transport->device, level, notify);
 }
+#endif
 
 static int transport_a2dp_snk_set_delay(struct media_transport *transport,
 					uint16_t delay)
@@ -2409,11 +2411,19 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 
 static const struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
+#ifdef HAVE_AVRCP
 			transport_a2dp_src_set_volume,
+#else
+			NULL,
+#endif
 			NULL,
 			transport_a2dp_src_destroy),
 	A2DP_OPS(A2DP_SINK_UUID, transport_a2dp_snk_init,
+#ifdef HAVE_AVRCP
 			transport_a2dp_snk_set_volume,
+#else
+			NULL,
+#endif
 			transport_a2dp_snk_set_delay,
 			transport_a2dp_snk_destroy),
 	BAP_UC_OPS(PAC_SOURCE_UUID),
-- 
2.47.1

