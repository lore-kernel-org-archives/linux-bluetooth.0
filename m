Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F6157E6B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493314; cv=none; b=rBQcP5ZmMnPrUAe6u2JaMdB53jqK5J/DPT9HRIMQ5s9wTi08mQikXaVr4V+GhZw1mcINr55tiobm5pFawfUWtRff0nkamzx/ycL+Ve1AH7Xowm39p0mqh8HYMBe4t4CzeEEKQjVxTi6jRPthzXpjRNjwOL7DXci1hQtcksC+s4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493314; c=relaxed/simple;
	bh=+Of5tE2yu6nSxIrKUrCHTxJXNCCBaJhc/Haj3FftXuc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuRmpAqKyc8xM1v+m0vKNMrlYVuApWH82dkPkA32eXWBdeC5QRMFsqEu1PDVr3Q4XFnvuheXqjPik4n0mI4kUghX2wk9HHjDrp3SE/PcL6qRC4aXtOvsoLb96jNUFVpsAk8CRdW8c8IDcQUK/yws/T2yTgHDhs5lwIquIS/QZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k45/a0Yg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k45/a0Yg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726493299;
	bh=+Of5tE2yu6nSxIrKUrCHTxJXNCCBaJhc/Haj3FftXuc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k45/a0YgMp1Y5IOBM1X/eOPzxD/gvhK5maYrYajm8iqffOHPOFkRrNBJXqLfJrPA7
	 w3WM+3N6282tuypPxC0WoGtCzN3+skle+IplEbglS2X0EcWPOhaqssIOBSwksPIGAf
	 wxBAnHQQj8avO9bC4a3smK4biPvVUv6cyi5yZrNIVgl3Atl0ERdCTXqngX9FaOrrUY
	 GS+/bce8dIshQaRTeFEptHCHyBSy2dPy08Q1vpZKaGXtOsHBJmjR8TxOg5sq3CyzOg
	 IXb05dQPctqdlDD99+3tGR1qEwQtFfF+gOeoqpJNwrUgHlv5Kz+aeCRxNJdak7LPUj
	 JSdJd8QX13mHg==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CAFE017E35CC
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:28:19 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/9] obexd: Add GetImage to bip-avrcp
Date: Mon, 16 Sep 2024 15:28:11 +0200
Message-Id: <20240916132813.165731-8-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916132813.165731-1-frederic.danis@collabora.com>
References: <20240916132813.165731-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Retrieves the image corresponding to the handle and the description,
as one of the descriptions retrieved by GetImageProperties, and store
it in a local file.

If the "transform" property description exists it should be set
to one of the value listed by GetImageProperties for this
description.
---
 obexd/client/bip-common.c |  21 ++++-
 obexd/client/bip-common.h |   5 ++
 obexd/client/bip.c        | 168 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/obexd/client/bip-common.c b/obexd/client/bip-common.c
index 9e96c81d8..613b52ceb 100644
--- a/obexd/client/bip-common.c
+++ b/obexd/client/bip-common.c
@@ -49,7 +49,7 @@ static const gchar *convBIP2IM(const gchar *encoding)
 	return NULL;
 }
 
-static gboolean parse_pixel_range(const gchar *dim, unsigned int *lower_ret,
+gboolean parse_pixel_range(const gchar *dim, unsigned int *lower_ret,
 						unsigned int *upper_ret,
 						gboolean *fixed_ratio_ret)
 {
@@ -139,6 +139,18 @@ char *transforms[] = {
 	NULL
 };
 
+gboolean verify_encoding(const char *encoding)
+{
+	struct encconv_pair *et = encconv_table;
+
+	while (et->bip) {
+		if (g_strcmp0(encoding, et->bip) == 0)
+			return TRUE;
+		et++;
+	}
+	return FALSE;
+}
+
 static gboolean verify_transform(const char *transform)
 {
 	char **str = transforms;
@@ -151,6 +163,13 @@ static gboolean verify_transform(const char *transform)
 	return FALSE;
 }
 
+char *parse_transform(const char *transform)
+{
+	if (!verify_transform(transform))
+		return NULL;
+	return g_strdup(transform);
+}
+
 static char *parse_transform_list(const char *transform)
 {
 	char **args = NULL, **arg = NULL;
diff --git a/obexd/client/bip-common.h b/obexd/client/bip-common.h
index 0fee54636..6e7aac375 100644
--- a/obexd/client/bip-common.h
+++ b/obexd/client/bip-common.h
@@ -13,6 +13,11 @@
 
 struct prop_object;
 
+gboolean parse_pixel_range(const gchar *dim, unsigned int *lower_ret,
+						unsigned int *upper_ret,
+						gboolean *fixed_ratio_ret);
+gboolean verify_encoding(const char *encoding);
+char *parse_transform(const char *transform);
 struct prop_object *parse_properties(char *data, unsigned int length,
 							int *err);
 gboolean verify_properties(struct prop_object *obj);
diff --git a/obexd/client/bip.c b/obexd/client/bip.c
index 6e1fa642a..86df3f407 100644
--- a/obexd/client/bip.c
+++ b/obexd/client/bip.c
@@ -32,6 +32,14 @@
 #define BIP_AVRCP_UUID "0000111A-0000-1000-8000-00805f9b34fb"
 
 #define IMG_HANDLE_TAG  0x30
+#define IMG_DESC_TAG    0x71
+
+#define EOL_CHARS "\n"
+#define IMG_DESC_BEGIN "<image-descriptor version=\"1.0\">" EOL_CHARS
+#define IMG_BEGIN "<image encoding=\"%s\" pixel=\"%s\""
+#define IMG_TRANSFORM " transformation=\"%s\""
+#define IMG_END "/>" EOL_CHARS
+#define IMG_DESC_END "</image-descriptor>" EOL_CHARS
 
 static DBusConnection *conn;
 
@@ -175,11 +183,171 @@ fail:
 	return reply;
 }
 
+static gboolean parse_get_image_dict(DBusMessage *msg, char **path,
+					char **handle, char **pixel,
+					char **encoding, uint64_t *maxsize,
+							char **transform)
+{
+	DBusMessageIter iter, array;
+
+	DBG("");
+
+	*path = NULL;
+	*handle = NULL;
+	*pixel = NULL;
+	*encoding = NULL;
+	*transform = NULL;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		goto failed;
+	dbus_message_iter_get_basic(&iter, path);
+	*path = g_strdup(*path);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		goto failed;
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_get_basic(&iter, handle);
+	*handle = g_strdup(*handle);
+	dbus_message_iter_next(&iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		goto failed;
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		const char *key, *val;
+
+		dbus_message_iter_recurse(&array, &entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+			return FALSE;
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+		switch (dbus_message_iter_get_arg_type(&value)) {
+		case DBUS_TYPE_STRING:
+			dbus_message_iter_get_basic(&value, &val);
+			if (g_str_equal(key, "pixel")) {
+				if (!parse_pixel_range(val, NULL, NULL, NULL))
+					goto failed;
+				*pixel = g_strdup(val);
+			} else if (g_str_equal(key, "encoding")) {
+				if (!verify_encoding(val))
+					goto failed;
+				*encoding = g_strdup(val);
+				if (*encoding == NULL)
+					goto failed;
+			} else if (g_str_equal(key, "transformation")) {
+				*transform = parse_transform(val);
+				if (*transform == NULL)
+					goto failed;
+			}
+			break;
+		case DBUS_TYPE_UINT64:
+			if (g_str_equal(key, "maxsize") == TRUE) {
+				dbus_message_iter_get_basic(&value, maxsize);
+				if (*maxsize == 0)
+					goto failed;
+			}
+			break;
+		}
+		dbus_message_iter_next(&array);
+	}
+
+	if (*pixel == NULL)
+		*pixel = strdup("");
+	if (*encoding == NULL)
+		*encoding = strdup("");
+
+	DBG("pixel: '%s' encoding: '%s' maxsize: '%lu' transform: '%s'",
+			*pixel, *encoding, *maxsize, *transform
+	);
+
+	return TRUE;
+failed:
+	g_free(*path);
+	g_free(*handle);
+	g_free(*pixel);
+	g_free(*encoding);
+	g_free(*transform);
+	return FALSE;
+}
+
+static DBusMessage *get_image(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct bip_avrcp_data *bip_avrcp = user_data;
+	char *handle = NULL, *image_path = NULL, *transform = NULL,
+		*encoding = NULL, *pixel = NULL;
+	uint64_t maxsize;
+	struct obc_transfer *transfer;
+	GObexHeader *header;
+	DBusMessage *reply = NULL;
+	GString *descriptor = NULL;
+	GError *err = NULL;
+
+	DBG("");
+
+	if (!parse_get_image_dict(message, &image_path, &handle, &pixel,
+					&encoding, &maxsize, &transform))
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	transfer = obc_transfer_get("x-bt/img-img", NULL, image_path, &err);
+	if (transfer == NULL) {
+		reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed",
+						"%s",
+						err->message);
+		g_error_free(err);
+		goto fail;
+	}
+
+	header = g_obex_header_new_unicode(IMG_HANDLE_TAG, handle);
+	obc_transfer_add_header(transfer, header);
+
+	descriptor = g_string_new(IMG_DESC_BEGIN);
+	g_string_append_printf(descriptor, IMG_BEGIN, encoding, pixel);
+	if (transform != NULL)
+		g_string_append_printf(descriptor, IMG_TRANSFORM, transform);
+	g_string_append(descriptor, IMG_END);
+	descriptor = g_string_append(descriptor, IMG_DESC_END);
+	header = g_obex_header_new_bytes(IMG_DESC_TAG, descriptor->str,
+						descriptor->len);
+	obc_transfer_add_header(transfer, header);
+	g_string_free(descriptor, TRUE);
+
+	if (!obc_session_queue(bip_avrcp->session, transfer, NULL, NULL,
+								&err)) {
+		reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed",
+						"%s",
+						err->message);
+		g_error_free(err);
+		goto fail;
+	}
+
+	reply = obc_transfer_create_dbus_reply(transfer, message);
+
+fail:
+	g_free(handle);
+	g_free(image_path);
+	g_free(transform);
+	g_free(encoding);
+	g_free(pixel);
+	return reply;
+}
+
 static const GDBusMethodTable bip_avrcp_methods[] = {
 	{ GDBUS_ASYNC_METHOD("GetImageProperties",
 		GDBUS_ARGS({ "handle", "s"}),
 		GDBUS_ARGS({ "properties", "aa{sv}" }),
 		get_image_properties) },
+	{ GDBUS_ASYNC_METHOD("GetImage",
+		GDBUS_ARGS({ "file", "s" }, { "handle", "s"},
+				{"properties", "a{sv}"}),
+		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
+		get_image) },
 	{ GDBUS_ASYNC_METHOD("GetImageThumbnail",
 		GDBUS_ARGS({ "file", "s" }, { "handle", "s"}),
 		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
-- 
2.34.1

