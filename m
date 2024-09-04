Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7F1DA63C
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458676; cv=none; b=Z5Em6xOOhW3Chbqf3a8WcGHybgLkAxDUGDtDZ6fS+fwCCoUGY2ei/iAazhHl2lEbCA0MH7iXqdcoALgUrkMbCitsKGyHAPPQ0HJd9ELmhR3pyf33cBaQqYegJ9ZaUTIKbT9B6L4huI/znBQDCUAW7yVY8cWGNr/q6QWyOC1/mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458676; c=relaxed/simple;
	bh=5edzT2HhPV2z306S3tt53NS+bSxL8ndDlX++tzje96E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBudjlEM4MuGgPa/1ieiPehFgeaf6J9ubAXvBSgbKJ7G7DaLYStaJcmfNKB3CLY0U1xWElEAbdR5bl1+gEM+5fxli1X3789hM0xqWjpRdzsmClX0tWZXuJaCB7cLinKIZQXdx2oza55kdRFVzhqj1C0kufdCDNGUO5qPWtUVIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MK6KGtIZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MK6KGtIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725458669;
	bh=5edzT2HhPV2z306S3tt53NS+bSxL8ndDlX++tzje96E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MK6KGtIZTn+gDo2zB7mZEAylJI5zn+kqONN4lSQgKxmEtaPwepKfTlJzEErU08Ovm
	 95u0tLG6FfT+/APxhIaK5gLtgB6NqT6ICpCZT586V07lQSJlTOj8VHaI8XXy1VNqe6
	 mxKL+z93HIynouH7eTsTBIHM5lxLgYw0TA9upMdeYxgwV+XtwHqj0Zw7o+k0yAhbWa
	 yg6Xb0dPokV5FEo+FfUjfOGc+hKyz2KwBErPOhI/O2nR3dhO4OxVfa+ByshtTvSqcm
	 pVV/c18AmOSNZKkz3/NDAaICk7aOVS1TdxynKyFqZt4PvWoSJ3yR++BbNMAOeijIBp
	 QJiJhNACufhHg==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B47517E114D
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 16:04:29 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] obexd: Add GetImageProperties to bip-avrcp
Date: Wed,  4 Sep 2024 16:04:19 +0200
Message-Id: <20240904140421.283166-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904140421.283166-1-frederic.danis@collabora.com>
References: <20240904140421.283166-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This allows to get the different version of the image provided by
the remote device to chose the one to use with GetImage.

This bip-common.[ch] files are based on previous work done by
Jakub Adamek for GSoC 2011, see [1] and [2].

[1] https://www.bluez.org/gsoc-basic-image-profilebip/
[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_final/plugins/bip_util.c
---
 Makefile.obexd            |   1 +
 obexd/client/bip-avrcp.c  | 101 +++++
 obexd/client/bip-common.c | 750 ++++++++++++++++++++++++++++++++++++++
 obexd/client/bip-common.h |  19 +
 4 files changed, 871 insertions(+)
 create mode 100644 obexd/client/bip-common.c
 create mode 100644 obexd/client/bip-common.h

diff --git a/Makefile.obexd b/Makefile.obexd
index cea163ba7..936728984 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -83,6 +83,7 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/client/opp.h obexd/client/opp.c \
 			obexd/client/map.h obexd/client/map.c \
 			obexd/client/bip-avrcp.h obexd/client/bip-avrcp.c \
+			obexd/client/bip-common.h obexd/client/bip-common.c \
 			obexd/client/map-event.h obexd/client/map-event.c \
 			obexd/client/transfer.h obexd/client/transfer.c \
 			obexd/client/transport.h obexd/client/transport.c \
diff --git a/obexd/client/bip-avrcp.c b/obexd/client/bip-avrcp.c
index ca702be5a..fe699cddf 100644
--- a/obexd/client/bip-avrcp.c
+++ b/obexd/client/bip-avrcp.c
@@ -20,6 +20,7 @@
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
+#include "bip-common.h"
 #include "bip-avrcp.h"
 
 #define OBEX_BIP_AVRCP_UUID \
@@ -38,6 +39,102 @@ struct bip_avrcp_data {
 	struct obc_session *session;
 };
 
+static void image_properties_complete_cb(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
+{
+	DBusMessage *message = user_data;
+	DBusMessage *reply = NULL;
+	DBusMessageIter iter;
+	char *contents = NULL;
+	size_t size;
+	int perr;
+	struct prop_object *prop = NULL;
+
+	if (err != NULL) {
+		reply = g_dbus_create_error(message,
+					ERROR_INTERFACE ".Failed",
+					"%s", err->message);
+		goto done;
+	}
+
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
+	if (perr < 0) {
+		reply = g_dbus_create_error(message,
+						ERROR_INTERFACE ".Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		goto done;
+	}
+
+	prop = parse_properties(contents, size, &perr);
+	if (prop == NULL) {
+		reply = g_dbus_create_error(message,
+						ERROR_INTERFACE ".Failed",
+						"Error parsing contents: %s",
+						strerror(-perr));
+		goto done;
+	}
+
+	if (!verify_properties(prop)) {
+		reply = g_dbus_create_error(message,
+						ERROR_INTERFACE ".Failed",
+						"Error verifying contents");
+		goto done;
+	}
+
+	reply = dbus_message_new_method_return(message);
+	dbus_message_iter_init_append(reply, &iter);
+	append_properties(&iter, prop);
+
+done:
+	g_dbus_send_message(conn, reply);
+	g_free(contents);
+	dbus_message_unref(message);
+}
+
+static DBusMessage *get_image_properties(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct bip_avrcp_data *bip_avrcp = user_data;
+	const char *handle = NULL;
+	struct obc_transfer *transfer;
+	GObexHeader *header;
+	DBusMessage *reply = NULL;
+	GError *err = NULL;
+
+	DBG("");
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &handle,
+				DBUS_TYPE_INVALID) == FALSE) {
+		reply = g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+		goto fail;
+	}
+
+	transfer = obc_transfer_get("x-bt/img-properties", NULL, NULL, &err);
+	if (transfer == NULL)
+		goto fail;
+
+	header = g_obex_header_new_unicode(IMG_HANDLE_TAG, handle);
+	obc_transfer_add_header(transfer, header);
+
+	if (!obc_session_queue(bip_avrcp->session, transfer,
+			image_properties_complete_cb, message, &err))
+		goto fail;
+
+	dbus_message_ref(message);
+
+	return NULL;
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_error_free(err);
+	return reply;
+}
+
 static DBusMessage *get_image_thumbnail(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -79,6 +176,10 @@ fail:
 }
 
 static const GDBusMethodTable bip_avrcp_methods[] = {
+	{ GDBUS_ASYNC_METHOD("GetImageProperties",
+		GDBUS_ARGS({ "handle", "s"}),
+		GDBUS_ARGS({ "properties", "aa{ss}" }),
+		get_image_properties) },
 	{ GDBUS_ASYNC_METHOD("GetImageThumbnail",
 		GDBUS_ARGS({ "file", "s" }, { "handle", "s"}),
 		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
diff --git a/obexd/client/bip-common.c b/obexd/client/bip-common.c
new file mode 100644
index 000000000..f1ef39ab8
--- /dev/null
+++ b/obexd/client/bip-common.c
@@ -0,0 +1,750 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2024  Collabora Ltd.
+ *  Based on previous work done by Jakub Adamek for GSoC 2011
+ *
+ */
+
+#define _GNU_SOURCE
+#include <regex.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "gobex/gobex.h"
+
+#include "obexd/src/log.h"
+#include "bip-common.h"
+
+#define HANDLE_LEN 7
+#define HANDLE_LIMIT 10000000
+
+struct encconv_pair {
+	gchar *bip, *im;
+};
+
+struct encconv_pair encconv_table[] = {
+	{ "JPEG", "JPEG" },
+	{ "GIF", "GIF" },
+	{ "WBMP", "WBMP" },
+	{ "PNG", "PNG" },
+	{ "JPEG2000", "JP2" },
+	{ "BMP", "BMP" },
+	{ }
+};
+
+static const gchar *convBIP2IM(const gchar *encoding)
+{
+	struct encconv_pair *et = encconv_table;
+
+	while (et->bip) {
+		if (g_strcmp0(encoding, et->bip) == 0)
+			return et->im;
+		et++;
+	}
+	return NULL;
+}
+
+static gboolean parse_pixel_range(const gchar *dim, unsigned int *lower_ret,
+						unsigned int *upper_ret,
+						gboolean *fixed_ratio_ret)
+{
+	static regex_t no_range;
+	static regex_t range;
+	static regex_t range_fixed;
+	static int regex_initialized;
+	unsigned int lower[2], upper[2];
+	gboolean fixed_ratio = FALSE;
+
+	if (!regex_initialized) {
+		regcomp(&no_range, "^([[:digit:]]{1,5})\\*([[:digit:]]{1,5})$",
+							REG_EXTENDED);
+		regcomp(&range, "^([[:digit:]]{1,5})\\*([[:digit:]]{1,5})"
+				"-([[:digit:]]{1,5})\\*([[:digit:]]{1,5})$",
+							REG_EXTENDED);
+		regcomp(&range_fixed, "^([[:digit:]]{1,5})\\*\\*"
+				"-([[:digit:]]{1,5})\\*([[:digit:]]{1,5})$",
+							REG_EXTENDED);
+		regex_initialized = 1;
+	}
+	if (dim == NULL)
+		return FALSE;
+	if (regexec(&no_range, dim, 0, NULL, 0) == 0) {
+		if (sscanf(dim, "%u*%u", &lower[0], &lower[1]) != 2)
+			return FALSE;
+		upper[0] = lower[0];
+		upper[1] = lower[1];
+		fixed_ratio = FALSE;
+	} else if (regexec(&range, dim, 0, NULL, 0) == 0) {
+		if (sscanf(dim, "%u*%u-%u*%u", &lower[0], &lower[1],
+				&upper[0], &upper[1]) != 4)
+			return FALSE;
+		fixed_ratio = FALSE;
+	} else if (regexec(&range_fixed, dim, 0, NULL, 0) == 0) {
+		if (sscanf(dim, "%u**-%u*%u", &lower[0], &upper[0],
+				&upper[1]) != 3)
+			return FALSE;
+		lower[1] = 0;
+		fixed_ratio = TRUE;
+	} else {
+		return FALSE;
+	}
+	if (lower[0] > 65535 || lower[1] > 65535 ||
+			upper[0] > 65535 || upper[1] > 65535)
+		return FALSE;
+	if (lower_ret == NULL || upper_ret == NULL || fixed_ratio_ret == NULL)
+		return TRUE;
+	if (upper[0] < lower[0] || upper[1] < lower[1])
+		return FALSE;
+	lower_ret[0] = lower[0];
+	lower_ret[1] = lower[1];
+	upper_ret[0] = upper[0];
+	upper_ret[1] = upper[1];
+	*fixed_ratio_ret = fixed_ratio;
+
+	return TRUE;
+}
+
+static gboolean verify_unsignednumber(const char *size)
+{
+	static regex_t unumber;
+	static int regex_initialized;
+
+	if (!regex_initialized) {
+		regcomp(&unumber, "^[[:digit:]]+$", REG_EXTENDED);
+		regex_initialized = 1;
+	}
+	if (regexec(&unumber, size, 0, NULL, 0) != 0)
+		return FALSE;
+
+	return TRUE;
+}
+
+static char *parse_unsignednumber(const char *size)
+{
+	if (!verify_unsignednumber(size))
+		return NULL;
+
+	return g_strdup(size);
+}
+
+char *transforms[] = {
+	"crop",
+	"stretch",
+	"fill",
+	NULL
+};
+
+static gboolean verify_transform(const char *transform)
+{
+	char **str = transforms;
+
+	while (*str != NULL) {
+		if (g_str_equal(transform, *str))
+			return TRUE;
+		str++;
+	}
+	return FALSE;
+}
+
+static char *parse_transform_list(const char *transform)
+{
+	char **args = NULL, **arg = NULL;
+	gboolean used[3] = { FALSE, FALSE, FALSE };
+
+	if (transform == NULL)
+		return NULL;
+	if (strlen(transform) == 0)
+		return NULL;
+	args = g_strsplit(transform, " ", 0);
+	for (arg = args; *arg != NULL; arg++) {
+		char *t = *arg;
+
+		if (!verify_transform(t)) {
+			g_strfreev(args);
+			return NULL;
+		}
+		switch (t[0]) {
+		case 's':
+			if (used[0])
+				goto failure;
+			used[0] = TRUE;
+			break;
+		case 'c':
+			if (used[1])
+				goto failure;
+			used[1] = TRUE;
+			break;
+		case 'f':
+			if (used[2])
+				goto failure;
+			used[2] = TRUE;
+			break;
+		}
+	}
+	g_strfreev(args);
+	return g_strdup(transform);
+failure:
+	g_strfreev(args);
+	return NULL;
+}
+
+static time_t parse_iso8601_bip(const gchar *str, int len)
+{
+	gchar    *tstr;
+	struct tm tm;
+	gint      nr;
+	gchar     tz;
+	time_t    time;
+	time_t    tz_offset = 0;
+
+	if (str == NULL)
+		return -1;
+
+	memset(&tm, 0, sizeof(struct tm));
+
+	/* According to spec the time doesn't have to be null terminated */
+	if (str[len - 1] != '\0') {
+		tstr = g_malloc(len + 1);
+		strncpy(tstr, str, len);
+		tstr[len] = '\0';
+	} else
+		tstr = g_strdup(str);
+
+	nr = sscanf(tstr, "%04u%02u%02uT%02u%02u%02u%c",
+			&tm.tm_year, &tm.tm_mon, &tm.tm_mday,
+			&tm.tm_hour, &tm.tm_min, &tm.tm_sec,
+			&tz);
+
+	g_free(tstr);
+
+	/* Fixup the tm values */
+	tm.tm_year -= 1900;       /* Year since 1900 */
+	tm.tm_mon--;              /* Months since January, values 0-11 */
+	tm.tm_isdst = -1;         /* Daylight savings information not avail */
+
+	if (nr < 6) {
+		/* Invalid time format */
+		return -1;
+	}
+
+	time = mktime(&tm);
+
+#if defined(HAVE_TM_GMTOFF)
+	tz_offset = tm.tm_gmtoff;
+#elif defined(HAVE_TIMEZONE)
+	tz_offset = -timezone;
+	if (tm.tm_isdst > 0)
+		tz_offset += 3600;
+#endif
+
+	if (nr == 7) { /* Date/Time was in localtime (to remote device)
+			* already. Since we don't know anything about the
+			* timezone on that one we won't try to apply UTC offset
+			*/
+		time += tz_offset;
+	}
+
+	return time;
+}
+
+static int parse_handle(const char *data)
+{
+	int handle;
+	char *ptr;
+
+	if (data == NULL)
+		return -1;
+	if (strlen(data) != HANDLE_LEN)
+		return -1;
+	handle = strtol(data, &ptr, 10);
+	if (ptr != data + HANDLE_LEN)
+		return -1;
+	if (handle < 0 || handle >= HANDLE_LIMIT)
+		return -1;
+	return handle;
+}
+
+struct native_prop {
+	char *encoding, *pixel, *size;
+};
+
+struct variant_prop {
+	char *encoding, *pixel, *maxsize, *transform;
+};
+
+struct att_prop {
+	char *content_type, *charset, *name, *size, *ctime, *mtime;
+};
+
+struct prop_object {
+	char *handle, *name;
+	GSList *native, *variant, *att;
+};
+
+static void free_native_prop(struct native_prop *prop)
+{
+	DBG("");
+
+	if (prop == NULL)
+		return;
+	g_free(prop->encoding);
+	g_free(prop->pixel);
+	g_free(prop->size);
+	g_free(prop);
+}
+
+static void free_variant_prop(struct variant_prop *prop)
+{
+	DBG("");
+
+	if (prop == NULL)
+		return;
+	g_free(prop->encoding);
+	g_free(prop->pixel);
+	g_free(prop->maxsize);
+	g_free(prop->transform);
+	g_free(prop);
+}
+
+static void free_att_prop(struct att_prop *prop)
+{
+	DBG("");
+
+	if (prop == NULL)
+		return;
+	g_free(prop->content_type);
+	g_free(prop->charset);
+	g_free(prop->name);
+	g_free(prop->size);
+	g_free(prop->ctime);
+	g_free(prop->mtime);
+	g_free(prop);
+}
+
+static void free_prop_object(struct prop_object *object)
+{
+	GSList *list;
+
+	DBG("");
+
+	if (object == NULL)
+		return;
+	for (list = object->native; list != NULL; list = g_slist_next(list))
+		free_native_prop(list->data);
+	for (list = object->variant; list != NULL; list = g_slist_next(list))
+		free_variant_prop(list->data);
+	for (list = object->att; list != NULL; list = g_slist_next(list))
+		free_att_prop(list->data);
+	g_slist_free(object->native);
+	g_slist_free(object->variant);
+	g_slist_free(object->att);
+	g_free(object->handle);
+	g_free(object->name);
+	g_free(object);
+}
+
+static gboolean parse_attrib_native(struct native_prop *prop, const gchar *key,
+					const gchar *value, GError **gerr)
+{
+	DBG("");
+
+	if (g_str_equal(key, "encoding")) {
+		if (convBIP2IM(value) == NULL)
+			goto invalid;
+		prop->encoding = g_strdup(value);
+	} else if (g_str_equal(key, "pixel")) {
+		if (!parse_pixel_range(value, NULL, NULL, NULL))
+			goto invalid;
+		prop->pixel = g_strdup(value);
+	} else if (g_str_equal(key, "size")) {
+		prop->size = parse_unsignednumber(value);
+		if (prop->size == NULL)
+			goto invalid;
+	} else {
+		g_set_error(gerr, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE, NULL);
+		return FALSE;
+	}
+	return TRUE;
+invalid:
+	g_set_error(gerr, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+			NULL);
+	return FALSE;
+}
+
+static gboolean parse_attrib_variant(struct variant_prop *prop,
+					const gchar *key,
+					const gchar *value, GError **gerr)
+{
+	DBG("");
+
+	if (g_str_equal(key, "encoding")) {
+		if (convBIP2IM(value) == NULL)
+			goto invalid;
+		prop->encoding = g_strdup(value);
+	} else if (g_str_equal(key, "pixel")) {
+		if (!parse_pixel_range(value, NULL, NULL, NULL))
+			goto invalid;
+		prop->pixel = g_strdup(value);
+	} else if (g_str_equal(key, "maxsize")) {
+		prop->maxsize = parse_unsignednumber(value);
+		if (prop->maxsize == NULL)
+			goto invalid;
+	} else if (g_str_equal(key, "transform")) {
+		prop->transform = parse_transform_list(value);
+		if (prop->transform == NULL)
+			goto invalid;
+	} else {
+		g_set_error(gerr, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE, NULL);
+		return FALSE;
+	}
+	return TRUE;
+invalid:
+	g_set_error(gerr, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+			NULL);
+	return FALSE;
+}
+
+static gboolean parse_attrib_att(struct att_prop *prop, const gchar *key,
+					const gchar *value, GError **gerr)
+{
+	DBG("");
+
+	if (g_str_equal(key, "content-type")) {
+		prop->content_type = g_strdup(value);
+	} else if (g_str_equal(key, "charset")) {
+		prop->charset = g_strdup(value);
+	} else if (g_str_equal(key, "name")) {
+		prop->name = g_strdup(value);
+	} else if (g_str_equal(key, "size")) {
+		prop->size = parse_unsignednumber(value);
+		if (prop->size == NULL)
+			goto invalid;
+	} else if (g_str_equal(key, "created")) {
+		if (parse_iso8601_bip(value, strlen(value)) == -1)
+			goto invalid;
+		prop->ctime = g_strdup(value);
+	} else if (g_str_equal(key, "modified")) {
+		if (parse_iso8601_bip(value, strlen(value)) == -1)
+			goto invalid;
+		prop->mtime = g_strdup(value);
+	} else {
+		g_set_error(gerr, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE, NULL);
+		return FALSE;
+	}
+	return TRUE;
+invalid:
+	g_set_error(gerr, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+			NULL);
+	return FALSE;
+}
+
+static struct att_prop *parse_elem_att(const gchar **names,
+					const gchar **values, GError **gerr)
+{
+	gchar **key;
+	struct att_prop *prop = g_new0(struct att_prop, 1);
+
+	DBG("");
+
+	for (key = (gchar **) names; *key; key++, values++) {
+		if (!parse_attrib_att(prop, *key, *values, gerr)) {
+			free_att_prop(prop);
+			return NULL;
+		}
+	}
+	return prop;
+}
+
+static struct variant_prop *parse_elem_variant(const gchar **names,
+					const gchar **values, GError **gerr)
+{
+	gchar **key;
+	struct variant_prop *prop = g_new0(struct variant_prop, 1);
+
+	DBG("");
+
+	for (key = (gchar **) names; *key; key++, values++) {
+		if (!parse_attrib_variant(prop, *key, *values, gerr)) {
+			free_variant_prop(prop);
+			return NULL;
+		}
+	}
+	if (prop->transform == NULL)
+		prop->transform = g_strdup("stretch crop fill");
+	return prop;
+}
+
+static struct native_prop *parse_elem_native(const gchar **names,
+					const gchar **values, GError **gerr)
+{
+	gchar **key;
+	struct native_prop *prop = g_new0(struct native_prop, 1);
+
+	DBG("");
+
+	for (key = (gchar **) names; *key; key++, values++) {
+		if (!parse_attrib_native(prop, *key, *values, gerr)) {
+			free_native_prop(prop);
+			return NULL;
+		}
+	}
+	return prop;
+}
+
+static gboolean parse_attrib_prop(struct prop_object *prop, const gchar *key,
+					const gchar *value, GError **gerr)
+{
+	DBG("");
+
+	if (g_str_equal(key, "handle")) {
+		if (parse_handle(value) < 0)
+			goto invalid;
+		prop->handle = g_strdup(value);
+	} else if (g_str_equal(key, "friendly-name")) {
+		prop->name = g_strdup(value);
+	} else if (g_str_equal(key, "version")) {
+		// pass;
+	} else {
+		g_set_error(gerr, G_MARKUP_ERROR,
+				G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE, NULL);
+		return FALSE;
+	}
+	return TRUE;
+invalid:
+	g_set_error(gerr, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+			NULL);
+	return FALSE;
+}
+
+static struct prop_object *parse_elem_prop(const gchar **names,
+					const gchar **values, GError **gerr)
+{
+	gchar **key;
+	struct prop_object *prop = g_new0(struct prop_object, 1);
+
+	DBG("");
+
+	for (key = (gchar **) names; *key; key++, values++) {
+		if (!parse_attrib_prop(prop, *key, *values, gerr)) {
+			free_prop_object(prop);
+			return NULL;
+		}
+	}
+	return prop;
+}
+
+static void prop_element(GMarkupParseContext *ctxt,
+		const gchar *element,
+		const gchar **names,
+		const gchar **values,
+		gpointer user_data,
+		GError **gerr)
+{
+	struct prop_object **obj = user_data;
+
+	DBG("");
+
+	if (g_str_equal(element, "image-properties")) {
+		if (*obj != NULL) {
+			free_prop_object(*obj);
+			*obj = NULL;
+			goto invalid;
+		}
+		*obj = parse_elem_prop(names, values, gerr);
+	} else if (g_str_equal(element, "native")) {
+		struct native_prop *prop;
+
+		if (*obj == NULL)
+			goto invalid;
+		prop = parse_elem_native(names, values, gerr);
+		(*obj)->native = g_slist_append((*obj)->native, prop);
+	} else if (g_str_equal(element, "variant")) {
+		struct variant_prop *prop;
+
+		if (*obj == NULL)
+			goto invalid;
+		prop = parse_elem_variant(names, values, gerr);
+		(*obj)->variant = g_slist_append((*obj)->variant, prop);
+	} else if (g_str_equal(element, "attachment")) {
+		struct att_prop *prop;
+
+		if (*obj == NULL)
+			goto invalid;
+		prop = parse_elem_att(names, values, gerr);
+		(*obj)->att = g_slist_append((*obj)->att, prop);
+	} else {
+		if (*obj != NULL) {
+			free_prop_object(*obj);
+			*obj = NULL;
+		}
+		goto invalid;
+	}
+
+	return;
+invalid:
+	g_set_error(gerr, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
+			NULL);
+}
+
+static const GMarkupParser properties_parser = {
+	prop_element,
+	NULL,
+	NULL,
+	NULL,
+	NULL
+};
+
+struct prop_object *parse_properties(char *data, unsigned int length,
+							int *err)
+{
+	struct prop_object *prop = NULL;
+	gboolean status;
+	GError *gerr = NULL;
+	GMarkupParseContext *ctxt = g_markup_parse_context_new(
+					&properties_parser, 0, &prop, NULL);
+
+	DBG("");
+
+	if (err != NULL)
+		*err = 0;
+	status = g_markup_parse_context_parse(ctxt, data, length, &gerr);
+	g_markup_parse_context_free(ctxt);
+	if (!status) {
+		if (err != NULL)
+			*err = -EINVAL;
+		free_prop_object(prop);
+		prop = NULL;
+	}
+	return prop;
+}
+
+gboolean verify_properties(struct prop_object *obj)
+{
+	GSList *list;
+
+	if (obj->handle == NULL)
+		return FALSE;
+
+	for (list = obj->native; list != NULL; list = g_slist_next(list)) {
+		struct native_prop *prop = list->data;
+
+		if (prop->encoding == NULL || prop->pixel == NULL)
+			return FALSE;
+	}
+
+	for (list = obj->variant; list != NULL; list = g_slist_next(list)) {
+		struct variant_prop *prop = list->data;
+
+		if (prop->encoding == NULL || prop->pixel == NULL)
+			return FALSE;
+	}
+
+	for (list = obj->att; list != NULL; list = g_slist_next(list)) {
+		struct att_prop *prop = list->data;
+
+		if (prop->content_type == NULL || prop->name == NULL)
+			return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void append_ss_dict_entry(DBusMessageIter *dict, const char *key,
+							const char *val)
+{
+	DBusMessageIter entry;
+
+	if (val == NULL)
+		return;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+					&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &val);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+void append_properties(DBusMessageIter *args, struct prop_object *obj)
+{
+	DBusMessageIter dict, iter;
+	GSList *list;
+
+	dbus_message_iter_open_container(args, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	dbus_message_iter_open_container(&dict, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&iter);
+	append_ss_dict_entry(&iter, "handle", obj->handle);
+	append_ss_dict_entry(&iter, "name", obj->name);
+	dbus_message_iter_close_container(&dict, &iter);
+
+	for (list = obj->native; list != NULL; list = g_slist_next(list)) {
+		struct native_prop *prop = list->data;
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&iter);
+		append_ss_dict_entry(&iter, "type", "native");
+		append_ss_dict_entry(&iter, "encoding", prop->encoding);
+		append_ss_dict_entry(&iter, "pixel", prop->pixel);
+		append_ss_dict_entry(&iter, "size", prop->size);
+		dbus_message_iter_close_container(&dict, &iter);
+	}
+
+	for (list = obj->variant; list != NULL; list = g_slist_next(list)) {
+		struct variant_prop *prop = list->data;
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&iter);
+		append_ss_dict_entry(&iter, "type", "variant");
+		append_ss_dict_entry(&iter, "encoding", prop->encoding);
+		append_ss_dict_entry(&iter, "pixel", prop->pixel);
+		append_ss_dict_entry(&iter, "maxsize", prop->maxsize);
+		append_ss_dict_entry(&iter, "transformation", prop->transform);
+		dbus_message_iter_close_container(&dict, &iter);
+	}
+
+	for (list = obj->att; list != NULL; list = g_slist_next(list)) {
+		struct att_prop *prop = list->data;
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&iter);
+		append_ss_dict_entry(&iter, "type", "attachment");
+		append_ss_dict_entry(&iter, "content-type",
+					prop->content_type);
+		append_ss_dict_entry(&iter, "charset", prop->charset);
+		append_ss_dict_entry(&iter, "name", prop->name);
+		append_ss_dict_entry(&iter, "size", prop->size);
+		append_ss_dict_entry(&iter, "created", prop->ctime);
+		append_ss_dict_entry(&iter, "modified", prop->mtime);
+		dbus_message_iter_close_container(&dict, &iter);
+	}
+
+	dbus_message_iter_close_container(args, &dict);
+}
diff --git a/obexd/client/bip-common.h b/obexd/client/bip-common.h
new file mode 100644
index 000000000..0fee54636
--- /dev/null
+++ b/obexd/client/bip-common.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2024  Collabora Ltd.
+ *
+ *
+ */
+
+#include <glib.h>
+#include "gdbus/gdbus.h"
+
+struct prop_object;
+
+struct prop_object *parse_properties(char *data, unsigned int length,
+							int *err);
+gboolean verify_properties(struct prop_object *obj);
+void append_properties(DBusMessageIter *args, struct prop_object *obj);
-- 
2.34.1

