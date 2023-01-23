Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0935C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 23:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjAWX5P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjAWX5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 18:57:14 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154DE2CFD8
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k13so13161380plg.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJNtVxq/ioUYJB2xV0JeU7c1714UJLue9o9iQTiRSUY=;
        b=C+3t69M6bD6xfRwjGd2JI6Erv47CBz4hFZXzAi7gzF4wBoB4DOnzwyzhJCmt19TqJM
         yTPg1q0H0dHUF/mE1J7nSUfjq086SbUYGYmBT5PxsO0X/RBtxbteCtotELTonfxoXnZ9
         +MIQSnUPaEeEtVfbdBOqjNylmlCkX+iJONymssJxhwnFSEH9a4W5vVaejmehKlWQRKcu
         YaUK5KCCGc3Ex5jzY/A92Hjy2ca2mOYi1ziFcVmx7k277Z7DD5Sei9lubmLdRXQLpkMF
         5+oxLnBhU3TImqsX5oQ08m0lKfcjI30e44NZd1RKDMDu+mDbwt/5xTldC83ZA6u2MMos
         EnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJNtVxq/ioUYJB2xV0JeU7c1714UJLue9o9iQTiRSUY=;
        b=4zN20/lltx8LR94ncKGdM1qGurnDfwfQWYVGlXqrHv7tLr3mq9vK08K5SCLLXyD2Yu
         ky1HeJzrUuaAkM+P0HJ0p86+p0SN8LES/cjnuesYeGQvK8FVT7FTe1EKvm/YZdt7zMvA
         hxggeeAoq9fL+YxjR2fU1FZ6FLAYReXxTL6PVLFAp/DwjjArDlPXOmodMW9xIz5kY6Ky
         5XU4Z2bNrDhVEwbHHhRh18Zgx3PHam1rdxcO70A2QfbyFFcYbsaxsJxK5Zhu1xX6NilT
         2jMaEUTM3jm6GXH/bqygfJuma6Q+GbYgzxdDF3LSYaZQcmH5zwpaoIpB1zOiyPfEu0nw
         SXvA==
X-Gm-Message-State: AFqh2ko3Oz+fTiNC4GTvu2HMe9zPcK8X2q2h3G8jUuaqVfbGCRLVKBDX
        G53unNgbpwiDCt0iViaWQvHN6zMefCE=
X-Google-Smtp-Source: AMrXdXt5LhGosn/8W2bmNr1jS0DyNxxsmqT2vmOHWWjhaBovjwJRZRs2jXRh7PoGYsTTYb5Dm/6DOA==
X-Received: by 2002:a17:902:7c15:b0:189:77c1:b5a7 with SMTP id x21-20020a1709027c1500b0018977c1b5a7mr25767302pll.41.1674518210913;
        Mon, 23 Jan 2023 15:56:50 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902d70e00b001960706141fsm268130ply.149.2023.01.23.15.56.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:56:50 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] profiles: Add Support for Metadata, CID and VID
Date:   Mon, 23 Jan 2023 15:56:45 -0800
Message-Id: <20230123235649.3231488-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>

This adds support for Metadata, Company ID and Vendor Codec ID
---
 profiles/audio/bap.c       |   7 ++-
 profiles/audio/media.c     | 106 +++++++++++++++++++++++++++++++++----
 profiles/audio/transport.c |   4 +-
 3 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8f24117681d2..8695260654e0 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -484,6 +484,9 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
 	ep->msg = dbus_message_ref(msg);
 
+	if (ep->metadata && ep->metadata->iov_len)
+		bt_bap_stream_metadata(ep->stream, ep->metadata, NULL, NULL);
+
 	return NULL;
 }
 
@@ -612,8 +615,10 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 
 	ep->caps = util_iov_dup(caps, 1);
 
-	if (metadata && metadata->iov_base && metadata->iov_len)
+	if (metadata && metadata->iov_base && metadata->iov_len) {
 		ep->metadata = util_iov_dup(metadata, 1);
+		bt_bap_stream_metadata(ep->stream, ep->metadata, NULL, NULL);
+	}
 
 	ep->qos = *qos;
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index fbb350889564..76a378e69401 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -91,10 +91,14 @@ struct media_endpoint {
 	char			*path;		/* Endpoint object path */
 	char			*uuid;		/* Endpoint property UUID */
 	uint8_t			codec;		/* Endpoint codec */
+	uint16_t                cid;            /* Endpoint company ID */
+	uint16_t                vid;            /* Endpoint vendor codec ID */
 	bool			delay_reporting;/* Endpoint delay_reporting */
 	struct bt_bap_pac_qos	qos;		/* Endpoint qos */
 	uint8_t			*capabilities;	/* Endpoint property capabilities */
 	size_t			size;		/* Endpoint capabilities size */
+	uint8_t                 *metadata;      /* Endpoint property metadata */
+	size_t                  metadata_size;  /* Endpoint metadata size */
 	guint			hs_watch;
 	guint			ag_watch;
 	guint			watch;
@@ -178,6 +182,7 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 
 	g_dbus_remove_watch(btd_get_dbus_connection(), endpoint->watch);
 	g_free(endpoint->capabilities);
+	g_free(endpoint->metadata);
 	g_free(endpoint->sender);
 	g_free(endpoint->path);
 	g_free(endpoint->uuid);
@@ -1108,6 +1113,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 	struct btd_gatt_database *database;
 	struct gatt_db *db;
 	struct iovec data;
+	struct iovec *metadata = NULL;
 	char *name;
 
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
@@ -1128,23 +1134,36 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
+	if (!bap_print_cc(endpoint->metadata, endpoint->metadata_size,
+					bap_debug, NULL)) {
+		error("Unable to parse endpoint metadata");
+		return false;
+	}
+
 	db = btd_gatt_database_get_db(database);
 
 	data.iov_base = endpoint->capabilities;
 	data.iov_len = endpoint->size;
 
-	/* TODO: Add support for metadata */
-
 	if (asprintf(&name, "%s:%s", endpoint->sender, endpoint->path) < 0) {
 		error("Could not allocate name for pac %s:%s",
 				endpoint->sender, endpoint->path);
 		return false;
 	}
 
-	endpoint->pac = bt_bap_add_pac(db, name, type, endpoint->codec,
-					&endpoint->qos, &data, NULL);
+	/* TODO: Add support for metadata */
+	if (endpoint->metadata_size) {
+		metadata = g_new0(struct iovec, 1);
+		metadata->iov_base = endpoint->metadata;
+		metadata->iov_len = endpoint->metadata_size;
+	}
+
+	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
+				endpoint->cid, endpoint->vid, &endpoint->qos,
+				&data, metadata);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
+		free(metadata);
 		return false;
 	}
 
@@ -1153,6 +1172,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 	DBG("PAC %s registered", name);
 
 	free(name);
+	free(metadata);
 
 	return true;
 }
@@ -1282,9 +1302,13 @@ media_endpoint_create(struct media_adapter *adapter,
 						const char *uuid,
 						gboolean delay_reporting,
 						uint8_t codec,
+						uint16_t cid,
+						uint16_t vid,
 						struct bt_bap_pac_qos *qos,
 						uint8_t *capabilities,
 						int size,
+						uint8_t *metadata,
+						int metadata_size,
 						int *err)
 {
 	struct media_endpoint *endpoint;
@@ -1297,6 +1321,8 @@ media_endpoint_create(struct media_adapter *adapter,
 	endpoint->path = g_strdup(path);
 	endpoint->uuid = g_strdup(uuid);
 	endpoint->codec = codec;
+	endpoint->cid = cid;
+	endpoint->vid = vid;
 	endpoint->delay_reporting = delay_reporting;
 
 	if (qos)
@@ -1308,6 +1334,12 @@ media_endpoint_create(struct media_adapter *adapter,
 		endpoint->size = size;
 	}
 
+	if (metadata_size > 0) {
+		endpoint->metadata = g_new(uint8_t, metadata_size);
+		memcpy(endpoint->metadata, metadata, metadata_size);
+		endpoint->metadata_size = metadata_size;
+	}
+
 	endpoint->adapter = adapter;
 
 	for (i = 0; i < ARRAY_SIZE(init_table); i++) {
@@ -1349,8 +1381,10 @@ media_endpoint_create(struct media_adapter *adapter,
 
 static int parse_properties(DBusMessageIter *props, const char **uuid,
 				gboolean *delay_reporting, uint8_t *codec,
+				uint16_t *cid, uint16_t *vid,
 				struct bt_bap_pac_qos *qos,
-				uint8_t **capabilities, int *size)
+				uint8_t **capabilities, int *size,
+				uint8_t **metadata, int *metadata_size)
 {
 	gboolean has_uuid = FALSE;
 	gboolean has_codec = FALSE;
@@ -1377,6 +1411,15 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, codec);
 			has_codec = TRUE;
+		} else if (strcasecmp(key, "Vendor") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, cid);
+			dbus_message_iter_next(&value);
+			var = dbus_message_iter_get_arg_type(&value);
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, vid);
 		} else if (strcasecmp(key, "DelayReporting") == 0) {
 			if (var != DBUS_TYPE_BOOLEAN)
 				return -EINVAL;
@@ -1390,6 +1433,15 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			dbus_message_iter_recurse(&value, &array);
 			dbus_message_iter_get_fixed_array(&array, capabilities,
 							size);
+		} else if (strcasecmp(key, "Metadata") == 0) {
+			DBusMessageIter array;
+
+			if (var != DBUS_TYPE_ARRAY)
+				return -EINVAL;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array, metadata,
+							metadata_size);
 		} else if (strcasecmp(key, "Framing") == 0) {
 			if (var != DBUS_TYPE_BYTE)
 				return -EINVAL;
@@ -1434,9 +1486,13 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	const char *sender, *path, *uuid;
 	gboolean delay_reporting = FALSE;
 	uint8_t codec = 0;
+	uint16_t cid = 0;
+	uint16_t vid = 0;
 	struct bt_bap_pac_qos qos = {};
 	uint8_t *capabilities = NULL;
+	uint8_t *metadata = NULL;
 	int size = 0;
+	int metadata_size = 0;
 	int err;
 
 	sender = dbus_message_get_sender(msg);
@@ -1453,12 +1509,14 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
 		return btd_error_invalid_args(msg);
 
-	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &qos,
-						&capabilities, &size) < 0)
+	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &cid,
+			&vid, &qos, &capabilities, &size, &metadata,
+			&metadata_size) < 0)
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
-					codec, &qos, capabilities, size,
+					codec, cid, vid, &qos, capabilities,
+					size, metadata, metadata_size,
 					&err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
@@ -2485,9 +2543,13 @@ static void app_register_endpoint(void *data, void *user_data)
 	const char *uuid;
 	gboolean delay_reporting = FALSE;
 	uint8_t codec;
+	uint16_t cid = 0;
+	uint16_t vid = 0;
 	struct bt_bap_pac_qos qos;
 	uint8_t *capabilities = NULL;
 	int size = 0;
+	uint8_t *metadata = NULL;
+	int metadata_size = 0;
 	DBusMessageIter iter, array;
 	struct media_endpoint *endpoint;
 
@@ -2514,6 +2576,19 @@ static void app_register_endpoint(void *data, void *user_data)
 
 	dbus_message_iter_get_basic(&iter, &codec);
 
+	if (g_dbus_proxy_get_property(proxy, "Vendor", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &cid);
+
+		dbus_message_iter_next(&iter);
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &vid);
+	}
+
 	/* DelayReporting and Capabilities are considered optional */
 	if (g_dbus_proxy_get_property(proxy, "DelayReporting", &iter))	{
 		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
@@ -2530,6 +2605,15 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_fixed_array(&array, &capabilities, &size);
 	}
 
+	if (g_dbus_proxy_get_property(proxy, "Metadata", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+			goto fail;
+
+		dbus_message_iter_recurse(&iter, &array);
+		dbus_message_iter_get_fixed_array(&array, &metadata,
+						&metadata_size);
+	}
+
 	/* Parse QoS preferences */
 	memset(&qos, 0, sizeof(qos));
 	if (g_dbus_proxy_get_property(proxy, "Framing", &iter)) {
@@ -2582,8 +2666,10 @@ static void app_register_endpoint(void *data, void *user_data)
 	}
 
 	endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
-						delay_reporting, codec, &qos,
-						capabilities, size, &app->err);
+						delay_reporting, codec, cid,
+						vid, &qos, capabilities,
+						size, metadata, metadata_size,
+						&app->err);
 	if (!endpoint) {
 		error("Unable to register endpoint %s:%s: %s", app->sender,
 						path, strerror(-app->err));
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 41339da51e17..5e057e2a5c61 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1185,6 +1185,7 @@ static guint resume_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
 	struct bap_transport *bap = transport->data;
+	struct iovec *meta;
 	guint id;
 
 	if (!bap->stream)
@@ -1202,7 +1203,8 @@ static guint resume_bap(struct media_transport *transport,
 		return g_idle_add(resume_complete, transport);
 	}
 
-	id = bt_bap_stream_enable(bap->stream, bap->linked, NULL,
+	meta = bt_bap_stream_get_metadata(bap->stream);
+	id = bt_bap_stream_enable(bap->stream, bap->linked, meta,
 					bap_enable_complete, owner);
 	if (!id)
 		return 0;
-- 
2.37.3

