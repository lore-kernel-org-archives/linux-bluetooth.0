Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F7C3A5A7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 00:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiLBAvJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiLBAvG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 19:51:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB4CE425
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 16:51:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cm20so3470697pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 16:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTIhg31Aya/7h5Q6jaESOQKvoXVrtlRlWqeM8R6/glY=;
        b=ncaFMW4ElHkz7M7c9SyKrxjVyfVnHxBZ095rbYKDHl6GnZA7voIDhG9Fk2/xex1jib
         txYfJ82lef8ULyifFeF3m82J7ht6vYFbGLfYvzK4bHySFPIx8j7+XlIdltm4vht9j+P8
         j2JwBxI6XM1EDvtImuz88ikBKOb6OVbtG1rFFpDfjqWHVH3qi0AWy+ZPOWu/PiuxzavE
         ik3iBEz3boNM4aqdGNCOu7CuCfyduQqjZyIsKax/9QTsyHexKSpkBl98r6PeF4JEMICG
         +ZPZ9MW1hjwMCRJ78+ZiyiQ0Y/8TFIowySt+hyCU3tBouZ4kBOlqXTtpCsq4sorLCnZ6
         IB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTIhg31Aya/7h5Q6jaESOQKvoXVrtlRlWqeM8R6/glY=;
        b=Ok+NOQHN0VSOEVg0SD0imNoAlrhpomRcEadfran7AkDAzHni+t4VUfoM58ZKEJP7af
         X1lh2mWieejSZYdqtCAJo+N9RLUJ6ICOlmLmOcmZcXQq3XtmA/C1+mIe8zQc9giQXnCx
         Qt/g84lQsWe7NVfyG4Kj4JZkLDH3qwcmV57W3MQ/pL+Udb6u6ZhfGiss9fMYRPpWLytO
         WOAFioWx1ISLtN+N3VH5YbSGlq1E50CVW7H5DgKXUs68b8WgfmKoPS7lfnYpHM6unTSI
         JU6beeA8aO6FCT1WKeFlfUPOp/FLPx7LCu8K3FbeJjWgxR1ekj8zYWDUAFoAzQ9b33E1
         kBXQ==
X-Gm-Message-State: ANoB5pmPdQvxVcpR0k4F2LTFCYHAtrEdmwJIQaPMiYkkKE0YfGq6rw0q
        xX0E8zDIFkIE/bpRzrz2JjkTCeKUZT78QQ==
X-Google-Smtp-Source: AA0mqf4RUCA/OVS+SuEYbQeNGV0Rj/6tZBaCB4C9G4IxoJ+gA11imlBSMfrCiDWHbok/7CyBai46Dw==
X-Received: by 2002:a17:90a:9313:b0:213:2168:1c78 with SMTP id p19-20020a17090a931300b0021321681c78mr74096714pjo.72.1669942262322;
        Thu, 01 Dec 2022 16:51:02 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018971fba556sm4246005pln.139.2022.12.01.16.51.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:51:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/8] client: Move common print_* functions to its own file
Date:   Thu,  1 Dec 2022 16:50:51 -0800
Message-Id: <20221202005051.2401504-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221202005051.2401504-1-luiz.dentz@gmail.com>
References: <20221202005051.2401504-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This move common print_* functions to its own file so they can be
properly reused instead of duplicating the code.
---
 Makefile.tools  |   4 +-
 client/main.c   | 166 +----------------------------------------
 client/player.c |  83 +--------------------
 client/print.c  | 194 ++++++++++++++++++++++++++++++++++++++++++++++++
 client/print.h  |  14 ++++
 5 files changed, 213 insertions(+), 248 deletions(-)
 create mode 100644 client/print.c
 create mode 100644 client/print.h

diff --git a/Makefile.tools b/Makefile.tools
index 4bc355c34b9a..df4cad06589a 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -3,6 +3,7 @@ if CLIENT
 bin_PROGRAMS += client/bluetoothctl
 
 client_bluetoothctl_SOURCES = client/main.c \
+					client/print.h client/print.c \
 					client/display.h client/display.c \
 					client/agent.h client/agent.c \
 					client/advertising.h \
@@ -494,7 +495,8 @@ tools_obex_server_tool_SOURCES = $(gobex_sources) $(btio_sources) \
 tools_obex_server_tool_LDADD = lib/libbluetooth-internal.la \
 			       src/libshared-glib.la $(GLIB_LIBS)
 
-tools_bluetooth_player_SOURCES = tools/bluetooth-player.c client/player.c
+tools_bluetooth_player_SOURCES = tools/bluetooth-player.c client/print.c \
+				client/player.c
 tools_bluetooth_player_LDADD = gdbus/libgdbus-internal.la \
 				src/libshared-glib.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -lreadline
diff --git a/client/main.c b/client/main.c
index 2816e880f151..763f38ac7b0f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -25,6 +25,7 @@
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
 #include "gdbus/gdbus.h"
+#include "print.h"
 #include "agent.h"
 #include "gatt.h"
 #include "advertising.h"
@@ -162,171 +163,6 @@ static void print_device(GDBusProxy *proxy, const char *description)
 				address, name);
 }
 
-static void print_fixed_iter(const char *label, const char *name,
-						DBusMessageIter *iter)
-{
-	dbus_bool_t *valbool;
-	dbus_uint32_t *valu32;
-	dbus_uint16_t *valu16;
-	dbus_int16_t *vals16;
-	unsigned char *byte;
-	int len;
-
-	switch (dbus_message_iter_get_arg_type(iter)) {
-	case DBUS_TYPE_BOOLEAN:
-		dbus_message_iter_get_fixed_array(iter, &valbool, &len);
-
-		if (len <= 0)
-			return;
-
-		bt_shell_printf("%s%s:\n", label, name);
-		bt_shell_hexdump((void *)valbool, len * sizeof(*valbool));
-
-		break;
-	case DBUS_TYPE_UINT32:
-		dbus_message_iter_get_fixed_array(iter, &valu32, &len);
-
-		if (len <= 0)
-			return;
-
-		bt_shell_printf("%s%s:\n", label, name);
-		bt_shell_hexdump((void *)valu32, len * sizeof(*valu32));
-
-		break;
-	case DBUS_TYPE_UINT16:
-		dbus_message_iter_get_fixed_array(iter, &valu16, &len);
-
-		if (len <= 0)
-			return;
-
-		bt_shell_printf("%s%s:\n", label, name);
-		bt_shell_hexdump((void *)valu16, len * sizeof(*valu16));
-
-		break;
-	case DBUS_TYPE_INT16:
-		dbus_message_iter_get_fixed_array(iter, &vals16, &len);
-
-		if (len <= 0)
-			return;
-
-		bt_shell_printf("%s%s:\n", label, name);
-		bt_shell_hexdump((void *)vals16, len * sizeof(*vals16));
-
-		break;
-	case DBUS_TYPE_BYTE:
-		dbus_message_iter_get_fixed_array(iter, &byte, &len);
-
-		if (len <= 0)
-			return;
-
-		bt_shell_printf("%s%s:\n", label, name);
-		bt_shell_hexdump((void *)byte, len * sizeof(*byte));
-
-		break;
-	default:
-		return;
-	};
-}
-
-static void print_iter(const char *label, const char *name,
-						DBusMessageIter *iter)
-{
-	dbus_bool_t valbool;
-	dbus_uint32_t valu32;
-	dbus_uint16_t valu16;
-	dbus_int16_t vals16;
-	unsigned char byte;
-	const char *valstr;
-	DBusMessageIter subiter;
-	char *entry;
-
-	if (iter == NULL) {
-		bt_shell_printf("%s%s is nil\n", label, name);
-		return;
-	}
-
-	switch (dbus_message_iter_get_arg_type(iter)) {
-	case DBUS_TYPE_INVALID:
-		bt_shell_printf("%s%s is invalid\n", label, name);
-		break;
-	case DBUS_TYPE_STRING:
-	case DBUS_TYPE_OBJECT_PATH:
-		dbus_message_iter_get_basic(iter, &valstr);
-		bt_shell_printf("%s%s: %s\n", label, name, valstr);
-		break;
-	case DBUS_TYPE_BOOLEAN:
-		dbus_message_iter_get_basic(iter, &valbool);
-		bt_shell_printf("%s%s: %s\n", label, name,
-					valbool == TRUE ? "yes" : "no");
-		break;
-	case DBUS_TYPE_UINT32:
-		dbus_message_iter_get_basic(iter, &valu32);
-		bt_shell_printf("%s%s: 0x%08x\n", label, name, valu32);
-		break;
-	case DBUS_TYPE_UINT16:
-		dbus_message_iter_get_basic(iter, &valu16);
-		bt_shell_printf("%s%s: 0x%04x\n", label, name, valu16);
-		break;
-	case DBUS_TYPE_INT16:
-		dbus_message_iter_get_basic(iter, &vals16);
-		bt_shell_printf("%s%s: %d\n", label, name, vals16);
-		break;
-	case DBUS_TYPE_BYTE:
-		dbus_message_iter_get_basic(iter, &byte);
-		bt_shell_printf("%s%s: 0x%02x (%d)\n", label, name, byte, byte);
-		break;
-	case DBUS_TYPE_VARIANT:
-		dbus_message_iter_recurse(iter, &subiter);
-		print_iter(label, name, &subiter);
-		break;
-	case DBUS_TYPE_ARRAY:
-		dbus_message_iter_recurse(iter, &subiter);
-
-		if (dbus_type_is_fixed(
-				dbus_message_iter_get_arg_type(&subiter))) {
-			print_fixed_iter(label, name, &subiter);
-			break;
-		}
-
-		while (dbus_message_iter_get_arg_type(&subiter) !=
-							DBUS_TYPE_INVALID) {
-			print_iter(label, name, &subiter);
-			dbus_message_iter_next(&subiter);
-		}
-		break;
-	case DBUS_TYPE_DICT_ENTRY:
-		dbus_message_iter_recurse(iter, &subiter);
-		entry = g_strconcat(name, " Key", NULL);
-		print_iter(label, entry, &subiter);
-		g_free(entry);
-
-		entry = g_strconcat(name, " Value", NULL);
-		dbus_message_iter_next(&subiter);
-		print_iter(label, entry, &subiter);
-		g_free(entry);
-		break;
-	default:
-		bt_shell_printf("%s%s has unsupported type\n", label, name);
-		break;
-	}
-}
-
-static void print_property_with_label(GDBusProxy *proxy, const char *name,
-					const char *label)
-{
-	DBusMessageIter iter;
-
-	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
-		return;
-
-	print_iter("\t", label ? label : name, &iter);
-}
-
-static void print_property(GDBusProxy *proxy, const char *name)
-{
-	print_property_with_label(proxy, name, NULL);
-}
-
 static void print_uuid(const char *label, const char *uuid)
 {
 	const char *text;
diff --git a/client/player.c b/client/player.c
index 92b2b7a47eaf..b857fa649a6b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -39,6 +39,7 @@
 #include "src/shared/shell.h"
 #include "src/shared/io.h"
 #include "src/shared/queue.h"
+#include "print.h"
 #include "player.h"
 
 /* String display constants */
@@ -511,88 +512,6 @@ static char *proxy_description(GDBusProxy *proxy, const char *title,
 					title, path);
 }
 
-static void print_iter(const char *label, const char *name,
-						DBusMessageIter *iter)
-{
-	dbus_bool_t valbool;
-	dbus_uint32_t valu32;
-	dbus_uint16_t valu16;
-	dbus_int16_t vals16;
-	unsigned char byte;
-	const char *valstr;
-	DBusMessageIter subiter;
-
-	if (iter == NULL) {
-		bt_shell_printf("%s%s is nil\n", label, name);
-		return;
-	}
-
-	switch (dbus_message_iter_get_arg_type(iter)) {
-	case DBUS_TYPE_INVALID:
-		bt_shell_printf("%s%s is invalid\n", label, name);
-		break;
-	case DBUS_TYPE_STRING:
-	case DBUS_TYPE_OBJECT_PATH:
-		dbus_message_iter_get_basic(iter, &valstr);
-		bt_shell_printf("%s%s: %s\n", label, name, valstr);
-		break;
-	case DBUS_TYPE_BOOLEAN:
-		dbus_message_iter_get_basic(iter, &valbool);
-		bt_shell_printf("%s%s: %s\n", label, name,
-					valbool == TRUE ? "yes" : "no");
-		break;
-	case DBUS_TYPE_UINT32:
-		dbus_message_iter_get_basic(iter, &valu32);
-		bt_shell_printf("%s%s: 0x%08x (%u)\n", label, name, valu32,
-								valu32);
-		break;
-	case DBUS_TYPE_UINT16:
-		dbus_message_iter_get_basic(iter, &valu16);
-		bt_shell_printf("%s%s: 0x%04x (%u)\n", label, name, valu16,
-								valu16);
-		break;
-	case DBUS_TYPE_INT16:
-		dbus_message_iter_get_basic(iter, &vals16);
-		bt_shell_printf("%s%s: %d\n", label, name, vals16);
-		break;
-	case DBUS_TYPE_BYTE:
-		dbus_message_iter_get_basic(iter, &byte);
-		bt_shell_printf("%s%s: 0x%02x (%d)\n", label, name, byte, byte);
-		break;
-	case DBUS_TYPE_VARIANT:
-		dbus_message_iter_recurse(iter, &subiter);
-		print_iter(label, name, &subiter);
-		break;
-	case DBUS_TYPE_ARRAY:
-		dbus_message_iter_recurse(iter, &subiter);
-		while (dbus_message_iter_get_arg_type(&subiter) !=
-							DBUS_TYPE_INVALID) {
-			print_iter(label, name, &subiter);
-			dbus_message_iter_next(&subiter);
-		}
-		break;
-	case DBUS_TYPE_DICT_ENTRY:
-		dbus_message_iter_recurse(iter, &subiter);
-		dbus_message_iter_get_basic(&subiter, &valstr);
-		dbus_message_iter_next(&subiter);
-		print_iter(label, valstr, &subiter);
-		break;
-	default:
-		bt_shell_printf("%s%s has unsupported type\n", label, name);
-		break;
-	}
-}
-
-static void print_property(GDBusProxy *proxy, const char *name)
-{
-	DBusMessageIter iter;
-
-	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
-		return;
-
-	print_iter("\t", name, &iter);
-}
-
 static void print_media(GDBusProxy *proxy, const char *description)
 {
 	char *str;
diff --git a/client/print.c b/client/print.c
new file mode 100644
index 000000000000..798d22c7e345
--- /dev/null
+++ b/client/print.c
@@ -0,0 +1,194 @@
+
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2020  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <string.h>
+
+#include "gdbus/gdbus.h"
+
+#include "src/shared/util.h"
+#include "src/shared/shell.h"
+#include "print.h"
+
+static void print_fixed_iter(const char *label, const char *name,
+						DBusMessageIter *iter)
+{
+	dbus_bool_t *valbool;
+	dbus_uint32_t *valu32;
+	dbus_uint16_t *valu16;
+	dbus_int16_t *vals16;
+	unsigned char *byte;
+	int len;
+
+	switch (dbus_message_iter_get_arg_type(iter)) {
+	case DBUS_TYPE_BOOLEAN:
+		dbus_message_iter_get_fixed_array(iter, &valbool, &len);
+
+		if (len <= 0)
+			return;
+
+		bt_shell_printf("%s%s:\n", label, name);
+		bt_shell_hexdump((void *)valbool, len * sizeof(*valbool));
+
+		break;
+	case DBUS_TYPE_UINT32:
+		dbus_message_iter_get_fixed_array(iter, &valu32, &len);
+
+		if (len <= 0)
+			return;
+
+		bt_shell_printf("%s%s:\n", label, name);
+		bt_shell_hexdump((void *)valu32, len * sizeof(*valu32));
+
+		break;
+	case DBUS_TYPE_UINT16:
+		dbus_message_iter_get_fixed_array(iter, &valu16, &len);
+
+		if (len <= 0)
+			return;
+
+		bt_shell_printf("%s%s:\n", label, name);
+		bt_shell_hexdump((void *)valu16, len * sizeof(*valu16));
+
+		break;
+	case DBUS_TYPE_INT16:
+		dbus_message_iter_get_fixed_array(iter, &vals16, &len);
+
+		if (len <= 0)
+			return;
+
+		bt_shell_printf("%s%s:\n", label, name);
+		bt_shell_hexdump((void *)vals16, len * sizeof(*vals16));
+
+		break;
+	case DBUS_TYPE_BYTE:
+		dbus_message_iter_get_fixed_array(iter, &byte, &len);
+
+		if (len <= 0)
+			return;
+
+		bt_shell_printf("%s%s:\n", label, name);
+		bt_shell_hexdump((void *)byte, len * sizeof(*byte));
+
+		break;
+	default:
+		return;
+	};
+}
+
+void print_iter(const char *label, const char *name, DBusMessageIter *iter)
+{
+	dbus_bool_t valbool;
+	dbus_uint32_t valu32;
+	dbus_uint16_t valu16;
+	dbus_int16_t vals16;
+	unsigned char byte;
+	const char *valstr;
+	DBusMessageIter subiter;
+	char *entry;
+
+	if (iter == NULL) {
+		bt_shell_printf("%s%s is nil\n", label, name);
+		return;
+	}
+
+	switch (dbus_message_iter_get_arg_type(iter)) {
+	case DBUS_TYPE_INVALID:
+		bt_shell_printf("%s%s is invalid\n", label, name);
+		break;
+	case DBUS_TYPE_STRING:
+	case DBUS_TYPE_OBJECT_PATH:
+		dbus_message_iter_get_basic(iter, &valstr);
+		bt_shell_printf("%s%s: %s\n", label, name, valstr);
+		break;
+	case DBUS_TYPE_BOOLEAN:
+		dbus_message_iter_get_basic(iter, &valbool);
+		bt_shell_printf("%s%s: %s\n", label, name,
+					valbool == TRUE ? "yes" : "no");
+		break;
+	case DBUS_TYPE_UINT32:
+		dbus_message_iter_get_basic(iter, &valu32);
+		bt_shell_printf("%s%s: 0x%08x\n", label, name, valu32);
+		break;
+	case DBUS_TYPE_UINT16:
+		dbus_message_iter_get_basic(iter, &valu16);
+		bt_shell_printf("%s%s: 0x%04x\n", label, name, valu16);
+		break;
+	case DBUS_TYPE_INT16:
+		dbus_message_iter_get_basic(iter, &vals16);
+		bt_shell_printf("%s%s: %d\n", label, name, vals16);
+		break;
+	case DBUS_TYPE_BYTE:
+		dbus_message_iter_get_basic(iter, &byte);
+		bt_shell_printf("%s%s: 0x%02x (%d)\n", label, name, byte, byte);
+		break;
+	case DBUS_TYPE_VARIANT:
+		dbus_message_iter_recurse(iter, &subiter);
+		print_iter(label, name, &subiter);
+		break;
+	case DBUS_TYPE_ARRAY:
+		dbus_message_iter_recurse(iter, &subiter);
+
+		if (dbus_type_is_fixed(
+				dbus_message_iter_get_arg_type(&subiter))) {
+			print_fixed_iter(label, name, &subiter);
+			break;
+		}
+
+		while (dbus_message_iter_get_arg_type(&subiter) !=
+							DBUS_TYPE_INVALID) {
+			print_iter(label, name, &subiter);
+			dbus_message_iter_next(&subiter);
+		}
+		break;
+	case DBUS_TYPE_DICT_ENTRY:
+		dbus_message_iter_recurse(iter, &subiter);
+		entry = g_strconcat(name, " Key", NULL);
+		print_iter(label, entry, &subiter);
+		g_free(entry);
+
+		entry = g_strconcat(name, " Value", NULL);
+		dbus_message_iter_next(&subiter);
+		print_iter(label, entry, &subiter);
+		g_free(entry);
+		break;
+	default:
+		bt_shell_printf("%s%s has unsupported type\n", label, name);
+		break;
+	}
+}
+
+void print_property_with_label(GDBusProxy *proxy, const char *name,
+					const char *label)
+{
+	DBusMessageIter iter;
+
+	if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
+		return;
+
+	print_iter("\t", label ? label : name, &iter);
+}
+
+void print_property(GDBusProxy *proxy, const char *name)
+{
+	print_property_with_label(proxy, name, NULL);
+}
diff --git a/client/print.h b/client/print.h
new file mode 100644
index 000000000000..c0866d06c504
--- /dev/null
+++ b/client/print.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022 Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+void print_property(GDBusProxy *proxy, const char *name);
+void print_property_with_label(GDBusProxy *proxy, const char *name,
+					const char *label);
+void print_iter(const char *label, const char *name, DBusMessageIter *iter);
-- 
2.37.3

