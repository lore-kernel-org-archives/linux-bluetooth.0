Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DCDC38A02
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 16:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ2Qpz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJ2Qpy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 12:45:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8410B5A3FB
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667061951; x=1698597951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U6U1cWRYeO4HUFuilDoiasEkbCoO9PtzsolOS5T1Djo=;
  b=jc//UHwsOcnKcCx1FVtB4u7k/HDFPFvBbLVO8R5krrOaQGEuH3D7oIO0
   3n6H8AkyIyi1IzL2Pu9btpAUrAVK1S+njDW8tEsi+aM8/ZzY3x/JKf8Ov
   L4tHvczCp6wmsAbSKJC/lpDYug0zwcT2x/p34o7CSQkQcq4Z+/PFJb1Ic
   rQ+hHMeMGklvKQi4qJwwwJMr848YPJw5bdBM6H/nTnxDUl4OxvtdFsMZr
   7rdhokdpekEWEhssppZ3ZiiEn0eJorYv3c9AiYRVohyEn6g2Ma14TSEUO
   sZuFm8RUysen2ZSA4xxmSQ0Ur8dmuHogZ13BtKliaSROfM8Y5B0SyxAoc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="289074311"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="289074311"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 09:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="666399487"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="666399487"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2022 09:45:48 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 3/5] profiles: Add Support for Metadata, CID and VID
Date:   Sat, 29 Oct 2022 22:34:06 +0530
Message-Id: <20221029170408.175533-4-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>

This adds support for Metadata, Company ID and Vendor Codec ID
---
 profiles/audio/bap.c       |  20 ++++++++
 profiles/audio/media.c     | 100 +++++++++++++++++++++++++++++++++----
 profiles/audio/transport.c |   4 +-
 3 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 67aba3bd7..401af796c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -481,6 +481,16 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
 	ep->msg = dbus_message_ref(msg);
 
+	if (ep->metadata && ep->metadata->iov_len) {
+		struct iovec *meta;
+
+		meta = new0(struct iovec, 1);
+		meta->iov_base = new0(uint8_t, ep->metadata->iov_len);
+		meta->iov_len = ep->metadata->iov_len;
+		memcpy(meta->iov_base, ep->metadata->iov_base, meta->iov_len);
+		bt_bap_stream_set_metadata(ep->stream, meta);
+	}
+
 	return NULL;
 }
 
@@ -597,6 +607,16 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 	}
 
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
+
+	if (metadata && metadata->iov_len) {
+		struct iovec *meta;
+
+		meta = new0(struct iovec, 1);
+		meta->iov_base = new0(uint8_t, metadata->iov_len);
+		meta->iov_len = metadata->iov_len;
+		memcpy(meta->iov_base, metadata->iov_base, meta->iov_len);
+		bt_bap_stream_set_metadata(ep->stream, meta);
+	}
 }
 
 static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index c9328ab9b..62f91bea3 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -91,10 +91,14 @@ struct media_endpoint {
 	char			*path;		/* Endpoint object path */
 	char			*uuid;		/* Endpoint property UUID */
 	uint8_t			codec;		/* Endpoint codec */
+	uint16_t		cid;		/* Endpoint company ID */
+	uint16_t		vid;		/* Endpoint vendor codec ID */
 	bool			delay_reporting;/* Endpoint delay_reporting */
 	struct bt_bap_pac_qos	qos;		/* Endpoint qos */
 	uint8_t			*capabilities;	/* Endpoint property capabilities */
 	size_t			size;		/* Endpoint capabilities size */
+	uint8_t			*metadata;	/* Endpoint property metadata */
+	size_t			metadata_size;  /* Endpoint metadata size */
 	guint			hs_watch;
 	guint			ag_watch;
 	guint			watch;
@@ -1113,6 +1117,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 	struct btd_gatt_database *database;
 	struct gatt_db *db;
 	struct iovec data;
+	struct iovec *metadata = NULL;
 	char *name;
 
 	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
@@ -1133,12 +1138,22 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
+	if (!bap_print_cc(endpoint->metadata, endpoint->metadata_size,
+							bap_debug, NULL)) {
+		error("Unable to parse endpoint metadata");
+		return false;
+	}
+
 	db = btd_gatt_database_get_db(database);
 
 	data.iov_base = endpoint->capabilities;
 	data.iov_len = endpoint->size;
 
-	/* TODO: Add support for metadata */
+	if (endpoint->metadata_size) {
+		metadata = g_new0(struct iovec, 1);
+		metadata->iov_base = endpoint->metadata;
+		metadata->iov_len = endpoint->metadata_size;
+	}
 
 	if (asprintf(&name, "%s:%s", endpoint->sender, endpoint->path) < 0) {
 		error("Could not allocate name for pac %s:%s",
@@ -1146,8 +1161,9 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
-	endpoint->pac = bt_bap_add_pac(db, name, type, endpoint->codec,
-					&endpoint->qos, &data, NULL);
+	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
+				endpoint->cid, endpoint->vid, &endpoint->qos,
+				&data, metadata);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
 		return false;
@@ -1287,9 +1303,13 @@ media_endpoint_create(struct media_adapter *adapter,
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
@@ -1302,6 +1322,8 @@ media_endpoint_create(struct media_adapter *adapter,
 	endpoint->path = g_strdup(path);
 	endpoint->uuid = g_strdup(uuid);
 	endpoint->codec = codec;
+	endpoint->cid = cid;
+	endpoint->vid = vid;
 	endpoint->delay_reporting = delay_reporting;
 
 	if (qos)
@@ -1313,6 +1335,12 @@ media_endpoint_create(struct media_adapter *adapter,
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
@@ -1354,8 +1382,10 @@ media_endpoint_create(struct media_adapter *adapter,
 
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
@@ -1382,6 +1412,14 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, codec);
 			has_codec = TRUE;
+		} else if (strcasecmp(key, "CompanyID") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, cid);
+		} else if (strcasecmp(key, "VendorCodecID") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, vid);
 		} else if (strcasecmp(key, "DelayReporting") == 0) {
 			if (var != DBUS_TYPE_BOOLEAN)
 				return -EINVAL;
@@ -1395,6 +1433,15 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
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
@@ -1439,9 +1486,13 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
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
@@ -1458,12 +1509,14 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
 		return btd_error_invalid_args(msg);
 
-	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &qos,
-						&capabilities, &size) < 0)
+	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &cid,
+				&vid, &qos, &capabilities, &size, &metadata,
+				&metadata_size) < 0)
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
-					codec, &qos, capabilities, size,
+					codec, cid, vid, &qos, capabilities,
+					size, metadata, metadata_size,
 					&err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
@@ -2490,9 +2543,13 @@ static void app_register_endpoint(void *data, void *user_data)
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
 
@@ -2519,6 +2576,20 @@ static void app_register_endpoint(void *data, void *user_data)
 
 	dbus_message_iter_get_basic(&iter, &codec);
 
+	if (g_dbus_proxy_get_property(proxy, "CompanyID", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &cid);
+	}
+
+	if (g_dbus_proxy_get_property(proxy, "VendorCodecID", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+			goto fail;
+
+		dbus_message_iter_get_basic(&iter, &vid);
+	}
+
 	/* DelayReporting and Capabilities are considered optional */
 	if (g_dbus_proxy_get_property(proxy, "DelayReporting", &iter))	{
 		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BOOLEAN)
@@ -2535,6 +2606,15 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_fixed_array(&array, &capabilities, &size);
 	}
 
+	if (g_dbus_proxy_get_property(proxy, "Metadata", &iter)) {
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+			goto fail;
+
+		dbus_message_iter_recurse(&iter, &array);
+		dbus_message_iter_get_fixed_array(&array, &metadata,
+							&metadata_size);
+	}
+
 	/* Parse QoS preferences */
 	memset(&qos, 0, sizeof(qos));
 	if (g_dbus_proxy_get_property(proxy, "Framing", &iter)) {
@@ -2587,8 +2667,10 @@ static void app_register_endpoint(void *data, void *user_data)
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
index 41339da51..5e057e2a5 100644
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
2.25.1

