Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E6FC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DD420656
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fsp1MTso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfAOOMd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:12:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40151 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfAOOMd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 09:12:33 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so1587072qki.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jan 2019 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=p9VhYg2HUiOCPI6fhYjKLvlU25S7Gt0oUVwEzThri80=;
        b=Fsp1MTso/baUUcFCTJPhWvq0khgZtRV7hGLMN4HN/aergFDoXHrqqkxIU3KsydpTJD
         Mk3apKbHQU9CHjJe1a9mxpSp68XG87dMFDmFNCAH9g3keKBB+WBUnYNRintL1ow3Xnlw
         CG6VYwAgJhFH3mhBlknSvDH5tLZbwL1l029Ik1GzOMwwet7Wfg8O7NlfQ6jZ6WhlVg0J
         UJKPkiXSrzHK068qXqVjn42GvKbc7GP9O/Sr3Gh8fJ6uVA1AzhH2HXrbnxWL2yY1pDXs
         PoAnsTC444WBAIpXhmabSXC3PcRayGGTCau9K3Ge41CnXoQT2kLIa8NR1UBw48lw8CjV
         3yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=p9VhYg2HUiOCPI6fhYjKLvlU25S7Gt0oUVwEzThri80=;
        b=AiQlfgJnZPhtl7tcd5x6iWTmTtaz47aKp6ZmusxX3xPkh8jKvGqc8smH8Vdl1Kaf/b
         DSsjGiVsDw67F9IYM6xfAKO9X8jP/5lb23GOSCxea1ftt8EEzMeElfwgaVkTc1R3WL06
         qmtlx3OkvmE0/PpFhoTojH2tCrPWwZIJ/fllRgtqUh7CeCWe1MobuLsod2GHCOPpm1Mg
         g7GHG05Ilztz/1jbS2nZ+MxFwO9qDMtmyYiCrGVAUVGvwm2l67v8R7zgcvoJjj0jTLuK
         4UgMtf9Onh+f1pxOPw/d2viG4+6CfO7zJpUzDHFPNk4/CJ7/Ko83yDczpjVmjQTbJs2V
         SbRw==
X-Gm-Message-State: AJcUukdkMkl65kqqpF10IMxdQJWdMbN+Ouxt21TTqAYVmKjOjsQo/a+v
        uA/4iIRfROMfSimzLlPUVuuH6DkjpdI=
X-Google-Smtp-Source: ALg8bN5mmmDRUZxlKhi57HF+EpxgHhc9xoJTjjz9XyKmYU3vDfLicHSZvuTgBt5v/Bi4+yzWg7M2MQ==
X-Received: by 2002:a37:a904:: with SMTP id s4mr2933493qke.237.1547561551381;
        Tue, 15 Jan 2019 06:12:31 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id l95sm10572580qkh.37.2019.01.15.06.12.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:12:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/8] a2dp: Implement MediaTransport.Endpoint
Date:   Tue, 15 Jan 2019 11:10:19 -0300
Message-Id: <20190115141023.353-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190115141023.353-1-luiz.dentz@gmail.com>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
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

