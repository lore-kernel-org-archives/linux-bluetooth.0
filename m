Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C7DC4708C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 22:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiLEW0X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 17:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiLEW0V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 17:26:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6BEDFCF
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 14:26:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so12929049pjo.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsAr3fT4JUssVwccAQWTpYtuQ1vtymqHjTz5s8SorMA=;
        b=PE1oeLYIv2rhCCn3L6Zem60LxnvX7LzXiH7+pCvdTYUKZjI6qAzpn8QyAh+VOyIypc
         5CVvCHl3iPbjteQtXSQMe+9MVTZZgiTIrh3gus97/uMerZPo81CixZa05a4pLVkKuHu8
         bgmR7RBqLA230fRVy3rZrqq4fXR4p0TENyYumjQfkt/3Z6R+pZnYssw+H+3FcsTs9HYt
         Hp1LU6a/srBk04ms9BGrWFibItWw+YRUE7sTWw4msUm3QNe53x1c0xizAQtbbPYtZk7H
         IGr0Q587uI+6z/yxwjRAD6jgxgCMNhfCD/ugzOYXPnKEgy2K3UKRZjnBR4OXvZp21R66
         QxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsAr3fT4JUssVwccAQWTpYtuQ1vtymqHjTz5s8SorMA=;
        b=xEHj5MvvA2yWH3Rvej4IhB9IQmH6wVX8/YnHWxqTW0TO7RaNtTPr9RD5kRedzkdIKY
         /FlZkK1MOBY7xc3R8dCZ88+89a2urp80I6VOEOpBN4/+QwlCAleRnxZqew2XO5nBYBz2
         yeexzEQpO5uE+1n8hEqXIakR0ETM+I2H2E9pOSETdFzkck9lvVTadQUHkMEnSfcLAo/t
         5DH0RyLdGQPcxSUnx6v0+kxUAfthtaULKTSj5dQSmTPFNif4TdLVtiV6eIJ8WSHE3VjK
         B+m/D7mxGGY5YI82nrBAvAB/MQweElYmNswuVmPUL+XIUPEVPp5uUJ8tEVO7fBKa5W8V
         mOlg==
X-Gm-Message-State: ANoB5pnj9+PDJ06zUXWCoeWediAKK1eO5csX7C0YtdegVTWvOeceWcmR
        dDH6kt+zY5ysi12YbsFqJpK/sfo5eJt8q3LA
X-Google-Smtp-Source: AA0mqf5HNZsKA8+k+AKygTEsKCjOOdwZ2fh2070O0VlZtFBAop3cmr88ykWIhqnMJdb9koEhruh3Tw==
X-Received: by 2002:a17:90b:3709:b0:219:ac07:473e with SMTP id mg9-20020a17090b370900b00219ac07473emr13141640pjb.191.1670279178774;
        Mon, 05 Dec 2022 14:26:18 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090341cd00b00186f81bb3f0sm11154076ple.122.2022.12.05.14.26.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:26:18 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Allow gatt.select-attribute to work with local attributes
Date:   Mon,  5 Dec 2022 14:26:17 -0800
Message-Id: <20221205222617.3580784-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This allows gatt.select-attribute local to select from the registered
attributes:

[bluetooth]# gatt.select-attribute local /org/bluez/app/service0/chrc0
[/org/bluez/app/service0/chrc0]# gatt.write 0x01
[CHG] Attribute /org/bluez/app/service0/chrc0 (%UUID) written
[/org/bluez/app/service0/chrc0]# gatt.read
01                                               .
[/org/bluez/app/service0/chrc0]# gatt.select-attribute local
 /org/bluez/app/service0/chrc1
[/org/bluez/app/service0/chrc1]# gatt.write 0x01
[CHG] Attribute /org/bluez/app/service0/chrc1 (%UUID) written
[/org/bluez/app/service0/chrc1]# gatt.read
01                                               .
[/org/bluez/app/service0/chrc1]#
---
 client/gatt.c | 298 +++++++++++++++++++++++++++++++++++++++-----------
 client/gatt.h |   4 +
 client/main.c |  48 +++++++-
 3 files changed, 285 insertions(+), 65 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 8f2920269118..f03fc1526af4 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -554,6 +554,241 @@ GDBusProxy *gatt_select_attribute(GDBusProxy *parent, const char *arg)
 	return select_attribute_by_uuid(NULL, arg);
 }
 
+static char *find_local_attribute(const char *arg,
+					struct service **service,
+					struct chrc **chrc, struct desc **desc)
+{
+	GList *l;
+
+	for (l = local_services; l; l = g_list_next(l)) {
+		struct service *s = l->data;
+		GList *cl;
+
+		if (!strcmp(arg, s->path)) {
+			if (service)
+				*service = s;
+			return s->path;
+		}
+
+		if (!strcmp(arg, s->uuid)) {
+			if (service)
+				*service = s;
+			return s->path;
+		}
+
+		for (cl = s->chrcs; cl; cl = g_list_next(cl)) {
+			struct chrc *c = cl->data;
+			GList *dl;
+
+			if (!strcmp(arg, c->path)) {
+				if (chrc)
+					*chrc = c;
+				return c->path;
+			}
+
+			if (!strcmp(arg, c->uuid)) {
+				if (chrc)
+					*chrc = c;
+				return c->path;
+			}
+
+			for (dl = c->descs; dl; dl = g_list_next(dl)) {
+				struct desc *d = dl->data;
+
+				if (!strcmp(arg, d->path)) {
+					if (desc)
+						*desc = d;
+					return d->path;
+				}
+
+				if (!strcmp(arg, d->uuid)) {
+					if (desc)
+						*desc = d;
+					return d->path;
+				}
+			}
+		}
+	}
+
+	return NULL;
+}
+
+char *gatt_select_local_attribute(const char *arg)
+{
+	return find_local_attribute(arg, NULL, NULL, NULL);
+}
+
+static int parse_offset(const char *arg)
+{
+	char *endptr = NULL;
+	unsigned long offset;
+
+	offset = strtoul(arg, &endptr, 0);
+	if (!endptr || *endptr != '\0' || offset > UINT16_MAX) {
+		bt_shell_printf("Invalid offload: %s", arg);
+		return -EINVAL;
+	}
+
+	return offset;
+}
+
+void gatt_read_local_attribute(char *data, int argc, char *argv[])
+{
+	int offset = 0;
+	struct service *s = NULL;
+	struct chrc *c = NULL;
+	struct desc *d = NULL;
+
+	if (!find_local_attribute(data, &s, &c, &d)) {
+		bt_shell_printf("Unable to find local attribute %s\n", data);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (argc > 1) {
+		offset = parse_offset(argv[1]);
+		if (offset < 0)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (s) {
+		bt_shell_printf("UUID %s", s->uuid);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (c) {
+		if ((size_t)offset >= c->value_len) {
+			bt_shell_printf("Invalid offset: %d >= %zd", offset,
+								c->value_len);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+		bt_shell_hexdump(&c->value[offset], c->value_len - offset);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (d) {
+		if ((size_t)offset >= d->value_len) {
+			bt_shell_printf("Invalid offset: %d >= %zd", offset,
+								d->value_len);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+		bt_shell_hexdump(&d->value[offset], d->value_len - offset);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+}
+
+static uint8_t *str2bytearray(char *arg, size_t *val_len)
+{
+	uint8_t value[MAX_ATTR_VAL_LEN];
+	char *entry;
+	unsigned int i;
+
+	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
+		long val;
+		char *endptr = NULL;
+
+		if (*entry == '\0')
+			continue;
+
+		if (i >= G_N_ELEMENTS(value)) {
+			bt_shell_printf("Too much data\n");
+			return NULL;
+		}
+
+		val = strtol(entry, &endptr, 0);
+		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
+			bt_shell_printf("Invalid value at index %d\n", i);
+			return NULL;
+		}
+
+		value[i] = val;
+	}
+
+	*val_len = i;
+
+	return util_memdup(value, i);
+}
+
+static int write_value(size_t *dst_len, uint8_t **dst_value, uint8_t *src_val,
+			size_t src_len, uint16_t offset, uint16_t max_len)
+{
+	if ((offset + src_len) > max_len)
+		return -EOVERFLOW;
+
+	if ((offset + src_len) != *dst_len) {
+		*dst_len = offset + src_len;
+		*dst_value = g_realloc(*dst_value, *dst_len);
+	}
+
+	if (src_val && src_len)
+		memcpy(*dst_value + offset, src_val, src_len);
+
+	return 0;
+}
+
+void gatt_write_local_attribute(char *data, int argc, char *argv[])
+{
+	int offset = 0;
+	struct service *s = NULL;
+	struct chrc *c = NULL;
+	struct desc *d = NULL;
+	uint8_t *value;
+	size_t value_len;
+
+	if (!find_local_attribute(data, &s, &c, &d)) {
+		bt_shell_printf("Unable to find local attribute %s\n", data);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	value = str2bytearray(argv[1], &value_len);
+	if (!value)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (argc > 2) {
+		offset = parse_offset(argv[2]);
+		if (offset < 0)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (s) {
+		bt_shell_printf("Unable to overwrite local service %s\n", data);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (c) {
+		if (write_value(&c->value_len, &c->value,
+					value, value_len,
+					offset, c->max_val_len)) {
+			bt_shell_printf("Unable to write local attribute %s\n",
+									data);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		bt_shell_printf("[" COLORED_CHG "] Attribute %s (%s) written\n",
+				c->path, bt_uuidstr_to_str(c->uuid));
+
+		g_dbus_emit_property_changed(c->service->conn, c->path,
+					     CHRC_INTERFACE, "Value");
+	}
+
+	if (d) {
+		if (write_value(&d->value_len, &d->value,
+					value, value_len,
+					offset, d->max_val_len)) {
+			bt_shell_printf("Unable to write local attribute %s\n",
+									data);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		bt_shell_printf("[" COLORED_CHG "] Attribute %s (%s) written\n",
+				d->path, bt_uuidstr_to_str(d->uuid));
+
+		g_dbus_emit_property_changed(d->chrc->service->conn, d->path,
+					     DESC_INTERFACE, "Value");
+	}
+
+	free(value);
+}
+
 static char *attribute_generator(const char *text, int state, GList *source)
 {
 	static int index;
@@ -650,20 +885,6 @@ static void read_attribute(GDBusProxy *proxy, uint16_t offset)
 	bt_shell_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
 }
 
-static int parse_offset(const char *arg)
-{
-	char *endptr = NULL;
-	unsigned long offset;
-
-	offset = strtoul(arg, &endptr, 0);
-	if (!endptr || *endptr != '\0' || offset > UINT16_MAX) {
-		bt_shell_printf("Invalid offload: %s", arg);
-		return -EINVAL;
-	}
-
-	return offset;
-}
-
 void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[])
 {
 	const char *iface;
@@ -782,38 +1003,6 @@ static void write_attribute(GDBusProxy *proxy,
 					g_dbus_proxy_get_path(proxy));
 }
 
-static uint8_t *str2bytearray(char *arg, size_t *val_len)
-{
-	uint8_t value[MAX_ATTR_VAL_LEN];
-	char *entry;
-	unsigned int i;
-
-	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
-		long int val;
-		char *endptr = NULL;
-
-		if (*entry == '\0')
-			continue;
-
-		if (i >= G_N_ELEMENTS(value)) {
-			bt_shell_printf("Too much data\n");
-			return NULL;
-		}
-
-		val = strtol(entry, &endptr, 0);
-		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
-			bt_shell_printf("Invalid value at index %d\n", i);
-			return NULL;
-		}
-
-		value[i] = val;
-	}
-
-	*val_len = i;
-
-	return util_memdup(value, i);
-}
-
 void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[])
 {
 	const char *iface;
@@ -2132,23 +2321,6 @@ static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
 	return 0;
 }
 
-static int write_value(size_t *dst_len, uint8_t **dst_value, uint8_t *src_val,
-			size_t src_len, uint16_t offset, uint16_t max_len)
-{
-	if ((offset + src_len) > max_len)
-		return -EOVERFLOW;
-
-	if ((offset + src_len) != *dst_len) {
-		*dst_len = offset + src_len;
-		*dst_value = g_realloc(*dst_value, *dst_len);
-	}
-
-	if (src_val && src_len)
-		memcpy(*dst_value + offset, src_val, src_len);
-
-	return 0;
-}
-
 static void authorize_write_response(const char *input, void *user_data)
 {
 	struct authorize_attribute_data *aad = user_data;
diff --git a/client/gatt.h b/client/gatt.h
index fc2b8a8a643c..bed9d3a68ba6 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -32,6 +32,10 @@ void gatt_release_write(GDBusProxy *proxy, const char *arg);
 void gatt_acquire_notify(GDBusProxy *proxy, const char *arg);
 void gatt_release_notify(GDBusProxy *proxy, const char *arg);
 
+char *gatt_select_local_attribute(const char *arg);
+void gatt_read_local_attribute(char *data, int argc, char *argv[]);
+void gatt_write_local_attribute(char *data, int argc, char *argv[]);
+
 void gatt_add_manager(GDBusProxy *proxy);
 void gatt_remove_manager(GDBusProxy *proxy);
 
diff --git a/client/main.c b/client/main.c
index 763f38ac7b0f..e5cf1e203ed1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -55,6 +55,7 @@ struct adapter {
 
 static struct adapter *default_ctrl;
 static GDBusProxy *default_dev;
+static char *default_local_attr;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
 static GList *battery_proxies;
@@ -440,6 +441,7 @@ static void set_default_attribute(GDBusProxy *proxy)
 {
 	const char *path;
 
+	default_local_attr = NULL;
 	default_attr = proxy;
 
 	path = g_dbus_proxy_get_path(proxy);
@@ -1982,10 +1984,41 @@ static void cmd_set_alias(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void set_default_local_attribute(char *attr)
+{
+	char *desc = NULL;
+
+	default_local_attr = attr;
+	default_attr = NULL;
+
+	desc = g_strdup_printf(COLOR_BLUE "[%s]" COLOR_OFF "# ", attr);
+
+	bt_shell_set_prompt(desc);
+	free(desc);
+}
+
 static void cmd_select_attribute(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
+	if (!strcasecmp("local", argv[1])) {
+		char *attr;
+
+		if (argc < 2) {
+			bt_shell_printf("attribute/UUID required\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		attr = gatt_select_local_attribute(argv[2]);
+		if (!attr) {
+			bt_shell_printf("Unable to find %s\n", argv[2]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		set_default_local_attribute(attr);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
 	if (!default_dev) {
 		bt_shell_printf("No device connected\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -2070,6 +2103,11 @@ static void cmd_attribute_info(int argc, char *argv[])
 
 static void cmd_read(int argc, char *argv[])
 {
+	if (default_local_attr) {
+		gatt_read_local_attribute(default_local_attr, argc, argv);
+		return;
+	}
+
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -2080,6 +2118,11 @@ static void cmd_read(int argc, char *argv[])
 
 static void cmd_write(int argc, char *argv[])
 {
+	if (default_local_attr) {
+		gatt_write_local_attribute(default_local_attr, argc, argv);
+		return;
+	}
+
 	if (!default_attr) {
 		bt_shell_printf("No attribute selected\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -2837,8 +2880,9 @@ static const struct bt_shell_menu gatt_menu = {
 	.entries = {
 	{ "list-attributes", "[dev/local]", cmd_list_attributes,
 				"List attributes", dev_generator },
-	{ "select-attribute", "<attribute/UUID>",  cmd_select_attribute,
-				"Select attribute", attribute_generator },
+	{ "select-attribute", "<attribute/UUID/local> [attribute/UUID]",
+				cmd_select_attribute, "Select attribute",
+				attribute_generator },
 	{ "attribute-info", "[attribute/UUID]",  cmd_attribute_info,
 				"Select attribute", attribute_generator },
 	{ "read", "[offset]", cmd_read, "Read attribute value" },
-- 
2.37.3

