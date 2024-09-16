Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA833156F3B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493312; cv=none; b=quLN6/oL7GHTkJQm2/xgJmpIXzaf9L6be2ZQSKHEN0/++vQG810HTKj+IySkNFVHCwwD2GFXKkZw8/xxb7PI75hIyLuseEbJYMhN/c2oTpT8+AHPW9dw9W3ERgulS59gNlBhKQNEUDyviaMZ+xRLTb/VT+NlXR0HaN3sA9YZJAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493312; c=relaxed/simple;
	bh=cTm5eZankIaOE/lK3yF6Ozx2145lzl3z7Bc8RYCtlL4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faffx7ZCXfAWI1u43J7yk/gWYv/Q14Y/S8AOXj09DEHZ9JgLq8FBCr2X9C1pEolsEpZsRMxGeeH4tVoC5AMLV+yojqH+v6sZVxX2rj0/FE47RceNbksuVgskVfYYjtrsUS5TEYZcHgljzBrV1Vo/7U5st5LLsku8kQiqucYBMcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cObyMRKo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cObyMRKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726493299;
	bh=cTm5eZankIaOE/lK3yF6Ozx2145lzl3z7Bc8RYCtlL4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cObyMRKoGv1wsTCHWlxxwutAiAbkdh8Vq26brh81JHrisjJCeAJUcVbrV9E9FQF0e
	 UEm+BB1zxmPUTluIPmLEOLw+yEJm+OGIwcKjgVd6pfp2DyPHM0DHbWcA7puXCrOp1C
	 IEcLTPXZZkruRHMg1m4vjpXBv2ohvYf1qVpO3Wc57ghPr6oe0vbT5GYq3ozgJy3ub8
	 PGHKFzpuFrznCmDi3hCSC7jV7Pr/1+VldXVvczd/ik1SWj4mteBK3upodQfsP4esSZ
	 vYV9H/U8TD1qB9kcS0WZEeJzyjrp+9ik/DdmD+JSJH013vP43i3ZnBDucCauzZY6nP
	 XjN6GL7Cg9mKQ==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8614317E35CB
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:28:19 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/9] obexd: Add GetImageProperties to bip-avrcp
Date: Mon, 16 Sep 2024 15:28:10 +0200
Message-Id: <20240916132813.165731-7-frederic.danis@collabora.com>
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

This allows to get the different version of the image provided by
the remote device to chose the one to use with GetImage.

This bip-common.[ch] files are based on previous work done by
Jakub Adamek for GSoC 2011, see [1] and [2].

[1] https://www.bluez.org/gsoc-basic-image-profilebip/
[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_final/plugins/bip_util.c
---
 Makefile.obexd            |   1 +
 obexd/client/bip-common.c | 781 ++++++++++++++++++++++++++++++++++++++
 obexd/client/bip-common.h |  19 +
 obexd/client/bip.c        | 101 +++++
 4 files changed, 902 insertions(+)
 create mode 100644 obexd/client/bip-common.c
 create mode 100644 obexd/client/bip-common.h

diff --git a/Makefile.obexd b/Makefile.obexd
index 866147dd1..74dd977a0 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -82,6 +82,7 @@ obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			obexd/client/opp.h obexd/client/opp.c \
 			obexd/client/map.h obexd/client/map.c \
 			obexd/client/bip.h obexd/client/bip.c \
+			obexd/client/bip-common.h obexd/client/bip-common.c \
 			obexd/client/map-event.h obexd/client/map-event.c \
 			obexd/client/transfer.h obexd/client/transfer.c \
 			obexd/client/transport.h obexd/client/transport.c \
diff --git a/obexd/client/bip-common.c b/obexd/client/bip-common.c
new file mode 100644
index 000000000..9e96c81d8
--- /dev/null
+++ b/obexd/client/bip-common.c
@@ -0,0 +1,781 @@
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
+#include <errno.h>
+#include <regex.h>
+#include <stdint.h>
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
+static uint64_t parse_unsignednumber(const char *size)
+{
+	if (!verify_unsignednumber(size))
+		return 0;
+
+	return g_ascii_strtoll(size, NULL, 10);
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
+	char *encoding, *pixel;
+	uint64_t size;
+};
+
+struct variant_prop {
+	char *encoding, *pixel, *transform;
+	uint64_t maxsize;
+};
+
+struct att_prop {
+	char *content_type, *charset, *name;
+	uint64_t size;
+	time_t ctime, mtime;
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
+		if (prop->size == 0)
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
+		if (prop->maxsize == 0)
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
+		if (prop->size == 0)
+			goto invalid;
+	} else if (g_str_equal(key, "created")) {
+		prop->ctime = parse_iso8601_bip(value, strlen(value));
+		if (prop->ctime == -1)
+			goto invalid;
+	} else if (g_str_equal(key, "modified")) {
+		prop->mtime = parse_iso8601_bip(value, strlen(value));
+		if (prop->mtime == -1)
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
+void append_properties(DBusMessageIter *args, struct prop_object *obj)
+{
+	DBusMessageIter dict, iter;
+	GSList *list;
+
+	dbus_message_iter_open_container(args, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	dbus_message_iter_open_container(&dict, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&iter);
+	g_dbus_dict_append_entry(&iter, "handle", DBUS_TYPE_STRING,
+					&obj->handle);
+	g_dbus_dict_append_entry(&iter, "name", DBUS_TYPE_STRING, &obj->name);
+	dbus_message_iter_close_container(&dict, &iter);
+
+	for (list = obj->native; list != NULL; list = g_slist_next(list)) {
+		struct native_prop *prop = list->data;
+		static char *native_str = "native";
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&iter);
+		g_dbus_dict_append_entry(&iter, "type", DBUS_TYPE_STRING,
+						&native_str);
+		if (prop->encoding)
+			g_dbus_dict_append_entry(&iter, "encoding",
+							DBUS_TYPE_STRING,
+							&prop->encoding);
+		if (prop->pixel)
+			g_dbus_dict_append_entry(&iter, "pixel",
+							DBUS_TYPE_STRING,
+							&prop->pixel);
+		if (prop->size)
+			g_dbus_dict_append_entry(&iter, "size",
+							DBUS_TYPE_UINT64,
+							&prop->size);
+		dbus_message_iter_close_container(&dict, &iter);
+	}
+
+	for (list = obj->variant; list != NULL; list = g_slist_next(list)) {
+		struct variant_prop *prop = list->data;
+		static char *variant_str = "variant";
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&iter);
+		g_dbus_dict_append_entry(&iter, "type", DBUS_TYPE_STRING,
+						&variant_str);
+		if (prop->encoding)
+			g_dbus_dict_append_entry(&iter, "encoding",
+							DBUS_TYPE_STRING,
+							&prop->encoding);
+		if (prop->pixel)
+			g_dbus_dict_append_entry(&iter, "pixel",
+							DBUS_TYPE_STRING,
+							&prop->pixel);
+		if (prop->maxsize)
+			g_dbus_dict_append_entry(&iter, "maxsize",
+							DBUS_TYPE_UINT64,
+							&prop->maxsize);
+		if (prop->transform)
+			g_dbus_dict_append_entry(&iter, "transformation",
+							DBUS_TYPE_STRING,
+							&prop->transform);
+		dbus_message_iter_close_container(&dict, &iter);
+	}
+
+	for (list = obj->att; list != NULL; list = g_slist_next(list)) {
+		struct att_prop *prop = list->data;
+		static char *attachment_str = "attachment";
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&iter);
+		g_dbus_dict_append_entry(&iter, "type", DBUS_TYPE_STRING,
+						&attachment_str);
+		if (prop->content_type)
+			g_dbus_dict_append_entry(&iter, "content-type",
+							DBUS_TYPE_STRING,
+							&prop->content_type);
+		if (prop->charset)
+			g_dbus_dict_append_entry(&iter, "charset",
+							DBUS_TYPE_STRING,
+							&prop->charset);
+		if (prop->name)
+			g_dbus_dict_append_entry(&iter, "name",
+							DBUS_TYPE_STRING,
+							&prop->name);
+		if (prop->size)
+			g_dbus_dict_append_entry(&iter, "size",
+							DBUS_TYPE_UINT64,
+							&prop->size);
+		if (prop->ctime)
+			g_dbus_dict_append_entry(&iter, "ctime",
+							DBUS_TYPE_UINT64,
+							&prop->ctime);
+		if (prop->mtime)
+			g_dbus_dict_append_entry(&iter, "mtime",
+							DBUS_TYPE_UINT64,
+							&prop->mtime);
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
diff --git a/obexd/client/bip.c b/obexd/client/bip.c
index f4af2834b..6e1fa642a 100644
--- a/obexd/client/bip.c
+++ b/obexd/client/bip.c
@@ -20,6 +20,7 @@
 #include "transfer.h"
 #include "session.h"
 #include "driver.h"
+#include "bip-common.h"
 #include "bip.h"
 
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
+		return reply;
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
+		GDBUS_ARGS({ "properties", "aa{sv}" }),
+		get_image_properties) },
 	{ GDBUS_ASYNC_METHOD("GetImageThumbnail",
 		GDBUS_ARGS({ "file", "s" }, { "handle", "s"}),
 		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
-- 
2.34.1

