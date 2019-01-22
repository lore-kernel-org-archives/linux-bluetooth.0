Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1747BC282C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2F921721
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J610XPgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfAVNpf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:45:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32838 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbfAVNpf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 08:45:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so19396445eds.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 05:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=p9VhYg2HUiOCPI6fhYjKLvlU25S7Gt0oUVwEzThri80=;
        b=J610XPgzaOl4olZ2nEstew3mYk7j9ELrfY9SLtyjXw0Eyx38iJMdhawLZNXt+d0eUJ
         IJPXlo0Krxy8sEdnqIgn25oVy8jn0iGSWCayF/efzyPubCsoBM2lCMxVSbvq+2Q9btgs
         TP6aLl/U5NYci4iOCrP8h+nLiLr8BXABl1CCavVqqlJVW9GYeTHJ1cVuGVTaRoxV0SqS
         HN8N++cj6LBINzR3bnMVHaI/jJ4qsy6hsf5DL8vVgqO7gm9EUSWYJ5L9tDielyfoMvve
         FjbzUxdgMCmIZzhgc/WVI5JWjeZbwChW/5oAuywiZh+YVgwk3VP69IRr7kKoBfy7nsFu
         mDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=p9VhYg2HUiOCPI6fhYjKLvlU25S7Gt0oUVwEzThri80=;
        b=SOG40VLaqLw6aVnpWrm8CnyGmi8zWwIXVX4eMKWw97199bTRZzhGVGdU2fu71izuZH
         SeSvtH2E6zQ1mjCYDWp9uULey7bvgN4Kl/jJ7j7ncBIqHDtHBK3xMrZlgKIkh0jhcg9z
         XZ9n5DtI5yQ7YiGaBgr3XkaWT8k1+7esHxitUJZ63zxiNj1Avhp+1dgW1jBPdGTJgV7C
         aIiXJHuwMU7m7Sc1qirKyUlnNIBkdTrSNavsfESRx34PfQ5bo/f9YoFChmxST5GGyO6n
         I9NBMKK0uJxCNR8KAp51Y8ZRWtTNDs36bjqdfGvK+xUTXj4LCs6DRJ3KmIPlw3PxH57J
         A47w==
X-Gm-Message-State: AJcUukd6N5MKFd6TN5xtDmRPfZ9k169mqtRaPtMRuLXQex3k/xE5OkYQ
        Mo6uwvztfhBZyD7aVf58ULfM4H4z
X-Google-Smtp-Source: ALg8bN4Qa13KUgvTYgZvGq0u6eSZaounVC7FYyPuxtYl4MF63XPFMw8mtRu9LwawLehGfFxyDIYv9A==
X-Received: by 2002:a17:906:78cf:: with SMTP id r15mr3630719ejn.96.1548164731927;
        Tue, 22 Jan 2019 05:45:31 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm5319153ejb.53.2019.01.22.05.45.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 05:45:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/9] a2dp: Implement MediaTransport.Endpoint
Date:   Tue, 22 Jan 2019 15:45:19 +0200
Message-Id: <20190122134524.20509-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122134524.20509-1-luiz.dentz@gmail.com>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements MediaTransport.Endpoint property which exposes what
endpoint is being used by the transport.
---
 profiles/audio/a2dp.c      | 91 +++++++++++++++++++++++++++++---------
 profiles/audio/a2dp.h      |  1 +
 profiles/audio/media.c     |  5 ++-
 profiles/audio/transport.c | 28 +++++++++++-
 profiles/audio/transport.h |  1 +
 5 files changed, 102 insertions(+), 24 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 4025776aa..4fa01894a 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -106,7 +106,7 @@ struct a2dp_setup {
 	struct a2dp_channel *chan;
 	struct avdtp *session;
 	struct a2dp_sep *sep;
-	struct avdtp_remote_sep *rsep;
+	struct a2dp_remote_sep *rsep;
 	struct avdtp_stream *stream;
 	struct avdtp_error *err;
 	avdtp_set_configuration_cb setconf_cb;
@@ -1065,6 +1065,24 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	return TRUE;
 }
 
+static bool match_remote_sep(const void *data, const void *user_data)
+{
+	const struct a2dp_remote_sep *sep = data;
+	const struct avdtp_remote_sep *rsep = user_data;
+
+	return sep->sep == rsep;
+}
+
+static struct a2dp_remote_sep *find_remote_sep(struct a2dp_channel *chan,
+						struct a2dp_sep *sep)
+{
+	struct avdtp_remote_sep *rsep;
+
+	rsep = avdtp_find_remote_sep(chan->session, sep->lsep);
+
+	return queue_find(chan->seps, match_remote_sep, rsep);
+}
+
 static gboolean a2dp_reconfigure(gpointer data)
 {
 	struct a2dp_setup *setup = data;
@@ -1074,14 +1092,14 @@ static gboolean a2dp_reconfigure(gpointer data)
 	struct avdtp_service_capability *cap;
 
 	if (setup->rsep) {
-		cap = avdtp_get_codec(setup->rsep);
+		cap = avdtp_get_codec(setup->rsep->sep);
 		rsep_codec = (struct avdtp_media_codec_capability *) cap->data;
 	}
 
 	if (!setup->rsep || sep->codec != rsep_codec->media_codec_type)
-		setup->rsep = avdtp_find_remote_sep(setup->session, sep->lsep);
+		setup->rsep = find_remote_sep(setup->chan, sep);
 
-	posix_err = avdtp_set_configuration(setup->session, setup->rsep,
+	posix_err = avdtp_set_configuration(setup->session, setup->rsep->sep,
 						sep->lsep,
 						setup->caps,
 						&setup->stream);
@@ -1097,6 +1115,16 @@ failed:
 	return FALSE;
 }
 
+static struct a2dp_remote_sep *get_remote_sep(struct a2dp_channel *chan,
+						struct avdtp_stream *stream)
+{
+	struct avdtp_remote_sep *rsep;
+
+	rsep = avdtp_stream_get_remote_sep(stream);
+
+	return queue_find(chan->seps, match_remote_sep, rsep);
+}
+
 static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
@@ -1121,7 +1149,7 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	}
 
 	if (!setup->rsep)
-		setup->rsep = avdtp_stream_get_remote_sep(stream);
+		setup->rsep = get_remote_sep(setup->chan, stream);
 
 	if (setup->reconfigure)
 		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
@@ -1347,10 +1375,23 @@ static struct a2dp_server *find_server(GSList *list, struct btd_adapter *a)
 	return NULL;
 }
 
+static void remote_sep_free(void *data)
+{
+	struct a2dp_remote_sep *sep = data;
+
+	free(sep->path);
+	free(sep);
+}
+
 static void remove_remote_sep(void *data)
 {
 	struct a2dp_remote_sep *sep = data;
 
+	if (!sep->path) {
+		remote_sep_free(sep);
+		return;
+	}
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), sep->path,
 						MEDIA_ENDPOINT_INTERFACE);
 }
@@ -2026,7 +2067,7 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 		return -ENOMEM;
 
 	setup->sep = lsep;
-	setup->rsep = rsep->sep;
+	setup->rsep = rsep;
 
 	setup_add_caps(setup, caps, size);
 
@@ -2054,7 +2095,7 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 		}
 	}
 
-	err = avdtp_set_configuration(setup->session, setup->rsep,
+	err = avdtp_set_configuration(setup->session, setup->rsep->sep,
 						lsep->lsep,
 						setup->caps,
 						&setup->stream);
@@ -2188,14 +2229,6 @@ static const GDBusPropertyTable sep_properties[] = {
 	{ }
 };
 
-static void remote_sep_free(void *data)
-{
-	struct a2dp_remote_sep *sep = data;
-
-	free(sep->path);
-	free(sep);
-}
-
 static void register_remote_sep(void *data, void *user_data)
 {
 	struct avdtp_remote_sep *rsep = data;
@@ -2205,6 +2238,10 @@ static void register_remote_sep(void *data, void *user_data)
 	sep = new0(struct a2dp_remote_sep, 1);
 	sep->chan = setup->chan;
 	sep->sep = rsep;
+
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
+		goto done;
+
 	asprintf(&sep->path, "%s/sep%d", device_get_path(setup->chan->device),
 							avdtp_get_seid(rsep));
 
@@ -2213,9 +2250,13 @@ static void register_remote_sep(void *data, void *user_data)
 				sep_methods, NULL, sep_properties,
 				sep, remote_sep_free) == FALSE) {
 		error("Could not register remote sep %s", sep->path);
-		remote_sep_free(sep);
+		free(sep->path);
+		sep->path = NULL;
 	}
 
+	DBG("Found remote SEP: %s", sep->path);
+
+done:
 	queue_push_tail(setup->chan->seps, sep);
 }
 
@@ -2283,14 +2324,14 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 	cb_data->user_data = user_data;
 
 	setup->sep = sep;
-	setup->rsep = avdtp_find_remote_sep(session, sep->lsep);
+	setup->rsep = find_remote_sep(setup->chan, sep);
 
 	if (setup->rsep == NULL) {
 		error("Could not find remote sep");
 		goto fail;
 	}
 
-	service = avdtp_get_codec(setup->rsep);
+	service = avdtp_get_codec(setup->rsep->sep);
 	codec = (struct avdtp_media_codec_capability *) service->data;
 
 	err = sep->endpoint->select_configuration(sep, codec->data,
@@ -2384,13 +2425,13 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 			break;
 		}
 
-		setup->rsep = avdtp_find_remote_sep(session, sep->lsep);
+		setup->rsep = find_remote_sep(setup->chan, sep);
 		if (setup->rsep == NULL) {
 			error("No matching ACP and INT SEPs found");
 			goto failed;
 		}
 
-		posix_err = avdtp_set_configuration(session, setup->rsep,
+		posix_err = avdtp_set_configuration(session, setup->rsep->sep,
 							sep->lsep, caps,
 							&setup->stream);
 		if (posix_err < 0) {
@@ -2632,6 +2673,16 @@ struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup)
 	return avdtp_get_device(setup->session);
 }
 
+const char *a2dp_setup_remote_path(struct a2dp_setup *setup)
+{
+	if (setup->rsep) {
+		if (setup->rsep->path)
+			return setup->rsep->path;
+	}
+
+	return NULL;
+}
+
 static int a2dp_source_probe(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 7f38c75f3..19466a428 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -91,4 +91,5 @@ gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
 struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep);
 struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup);
+const char *a2dp_setup_remote_path(struct a2dp_setup *setup);
 struct avdtp *a2dp_avdtp_get(struct btd_device *device);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 9d7564cf0..28fa70668 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -430,8 +430,9 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	if (transport != NULL)
 		return FALSE;
 
-	transport = media_transport_create(device, configuration, size,
-								endpoint);
+	transport = media_transport_create(device,
+					a2dp_setup_remote_path(data->setup),
+					configuration, size, endpoint);
 	if (transport == NULL)
 		return FALSE;
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 98f4e1ffd..48fabba9b 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -92,6 +92,7 @@ struct a2dp_transport {
 struct media_transport {
 	char			*path;		/* Transport object path */
 	struct btd_device	*device;	/* Transport device */
+	const char		*remote_endpoint; /* Transport remote SEP */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
 	struct media_owner	*owner;		/* Transport owner */
 	uint8_t			*configuration; /* Transport configuration */
@@ -689,6 +690,24 @@ static void set_volume(const GDBusPropertyTable *property,
 	avrcp_set_volume(transport->device, volume, notify);
 }
 
+static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_transport *transport = data;
+
+	return transport->remote_endpoint != NULL;
+}
+
+static gboolean get_endpoint(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+					&transport->remote_endpoint);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -712,6 +731,8 @@ static const GDBusPropertyTable transport_properties[] = {
 	{ "State", "s", get_state },
 	{ "Delay", "q", get_delay, NULL, delay_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -836,6 +857,7 @@ static int media_transport_init_sink(struct media_transport *transport)
 }
 
 struct media_transport *media_transport_create(struct btd_device *device,
+						const char *remote_endpoint,
 						uint8_t *configuration,
 						size_t size, void *data)
 {
@@ -850,8 +872,10 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	transport->configuration = g_new(uint8_t, size);
 	memcpy(transport->configuration, configuration, size);
 	transport->size = size;
-	transport->path = g_strdup_printf("%s/fd%d", device_get_path(device),
-									fd++);
+	transport->remote_endpoint = remote_endpoint;
+	transport->path = g_strdup_printf("%s/fd%d",
+				remote_endpoint ? remote_endpoint :
+				device_get_path(device), fd++);
 	transport->fd = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 505ad5c54..ac542bf6c 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -25,6 +25,7 @@
 struct media_transport;
 
 struct media_transport *media_transport_create(struct btd_device *device,
+						const char *remote_endpoint,
 						uint8_t *configuration,
 						size_t size, void *data);
 
-- 
2.17.2

