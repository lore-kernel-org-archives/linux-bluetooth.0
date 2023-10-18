Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E465FCDB483
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 19:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjJRT5I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 15:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjJRT5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 15:57:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FBD12C
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 12:57:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ca82f015e4so25927375ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697659022; x=1698263822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwt/O4BE9qXnQZw8zoFRGFUPhkxOc2BZrusO3xMXvaQ=;
        b=UNlHfD/XhQP2K7Ijv8e1YjGITOBtXpYn0RRPccyd4juvdlj6GNiTagm/XM+5+1YIEd
         SIiXpJPEXnPoHJ/Jv5efKK4ogLtFn56uRrudv+r9lDmTgKglBYQydbiJcBVlEPDlMvVl
         ectHMoxXvgid5ku9hwJcgCr/bH9hScIthy6YuF2G2GmAjYk98zHJvScUO9QOkOJjB4Ti
         D3548TIV3qN0MxKyB7rPlEIk9oZO3lNK1L5ldEmC9/PdubUfgv319n1YRFd0LPrsvee2
         mot1AI0Ax8AJoHtzyWSfkGaTiJlVAF4RRuMoJ4H3EF/H6E6vT68h93PvE7XXJjhCknlb
         RrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659022; x=1698263822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwt/O4BE9qXnQZw8zoFRGFUPhkxOc2BZrusO3xMXvaQ=;
        b=QT9mjFDJhart92gfT7aqRBjm1pd7FoGaSXFbCdjCPQyNPm2ccHPyfDs7I7dMYrgF3N
         uiKsAMCAUhjMEmn0xNmcDv3I3tiQpaLAFkQYzr20a3cfuXT2s9OtwqQLZ5GdE3Li6hqA
         75sEenbM0l6O15GavhyWcbVQvV7evNK75mWTt9FP+dZWor6WlIu2Jqzu1R+1u6PJV9hL
         Jjl0GysnqpAhGRqfbLiBSDjUwg1j01uwh7xA+pqB/Aw6iFSjqiYI8RhNgmoN5cUG8Lid
         VLu1BAFXf5cTebO5j2hAALemKGeII2mEjHrg2v5/Blj7/Ap3ge4KDm34jW9NnYq87pkA
         agKw==
X-Gm-Message-State: AOJu0YyMHBY5qF77yEeQ9wVJ6DNzzN5uQH5i0C97W0mccxnXRjx68oqO
        Cda79sWLeX7VnV4hkofMW6W91FvJfbrgI8NYz0I=
X-Google-Smtp-Source: AGHT+IEgGdXXrr2qp0x8zPs7WPsU1PPaKI+1cVXsDXdGMb7liBaHaOqZYrIhHnqKSDyloNmqMFNoBw==
X-Received: by 2002:a17:902:e88e:b0:1ca:505:8c86 with SMTP id w14-20020a170902e88e00b001ca05058c86mr435059plg.20.1697659021769;
        Wed, 18 Oct 2023 12:57:01 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id jk8-20020a170903330800b001b3bf8001a9sm329739plb.48.2023.10.18.12.57.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:57:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] client: Make use of bap-debug functions
Date:   Wed, 18 Oct 2023 12:56:53 -0700
Message-ID: <20231018195653.2532882-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018195653.2532882-1-luiz.dentz@gmail.com>
References: <20231018195653.2532882-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of bap-debug functions to decode Capabilities,
Configuration and Metadata.
---
 client/player.c | 124 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 8 deletions(-)

diff --git a/client/player.c b/client/player.c
index d1809f24fd27..603447a9df46 100644
--- a/client/player.c
+++ b/client/player.c
@@ -42,6 +42,7 @@
 #include "src/shared/shell.h"
 #include "src/shared/io.h"
 #include "src/shared/queue.h"
+#include "src/shared/bap-debug.h"
 #include "print.h"
 #include "player.h"
 
@@ -1451,6 +1452,34 @@ static struct codec_preset lc3_presets[] = {
 			LC3_10_UNFRAMED(155u, 13u, 100u, 40000u)),
 };
 
+static void print_ltv(const char *str, void *user_data)
+{
+	const char *label = user_data;
+
+	bt_shell_printf("\t%s.%s\n", label, str);
+}
+
+static void print_lc3_caps(uint8_t *data, int len)
+{
+	const char *label = "Capabilities";
+
+	bt_bap_debug_caps(data, len, print_ltv, (void *)label);
+}
+
+static void print_lc3_cfg(void *data, int len)
+{
+	const char *label = "Configuration";
+
+	bt_bap_debug_config(data, len, print_ltv, (void *)label);
+}
+
+static void print_lc3_meta(void *data, int len)
+{
+	const char *label = "Metadata";
+
+	bt_bap_debug_metadata(data, len, print_ltv, (void *)label);
+}
+
 #define PRESET(_uuid, _codec, _presets, _default_index) \
 	{ \
 		.uuid = _uuid, \
@@ -1941,8 +1970,12 @@ static void append_properties(DBusMessageIter *iter,
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
-	bt_shell_printf("Capabilities: ");
-	bt_shell_hexdump(cfg->caps->iov_base, cfg->caps->iov_len);
+	if (cfg->ep->codec == LC3_ID) {
+		print_lc3_cfg(cfg->caps->iov_base, cfg->caps->iov_len);
+	} else {
+		bt_shell_printf("Capabilities: ");
+		bt_shell_hexdump(cfg->caps->iov_base, cfg->caps->iov_len);
+	}
 
 	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
 					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
@@ -1955,8 +1988,13 @@ static void append_properties(DBusMessageIter *iter,
 				DBUS_TYPE_BYTE, &cfg->meta->iov_base,
 				cfg->meta->iov_len);
 
-		bt_shell_printf("Metadata:\n");
-		bt_shell_hexdump(cfg->meta->iov_base, cfg->meta->iov_len);
+		if (cfg->ep->codec == LC3_ID) {
+			print_lc3_meta(cfg->meta->iov_base, cfg->meta->iov_len);
+		} else {
+			bt_shell_printf("Metadata:\n");
+			bt_shell_hexdump(cfg->meta->iov_base,
+						cfg->meta->iov_len);
+		}
 	}
 
 	append_qos(&dict, cfg);
@@ -2124,6 +2162,42 @@ static struct endpoint *endpoint_find(const char *pattern)
 	return NULL;
 }
 
+static void print_capabilities(GDBusProxy *proxy)
+{
+	DBusMessageIter iter, subiter;
+	uint8_t codec;
+	uint8_t *data;
+	int len;
+
+	if (!g_dbus_proxy_get_property(proxy, "Codec", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &codec);
+
+	if (codec != LC3_ID) {
+		print_property(proxy, "Capabilities");
+		return;
+	}
+
+	if (!g_dbus_proxy_get_property(proxy, "Capabilities", &iter))
+		return;
+
+	dbus_message_iter_recurse(&iter, &subiter);
+
+	dbus_message_iter_get_fixed_array(&subiter, &data, &len);
+
+	print_lc3_caps(data, len);
+
+	if (!g_dbus_proxy_get_property(proxy, "Metadata", &iter))
+		return;
+
+	dbus_message_iter_recurse(&iter, &subiter);
+
+	dbus_message_iter_get_fixed_array(&subiter, &data, &len);
+
+	print_lc3_meta(data, len);
+}
+
 static void cmd_show_endpoint(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -2139,7 +2213,7 @@ static void cmd_show_endpoint(int argc, char *argv[])
 
 	print_property(proxy, "UUID");
 	print_property(proxy, "Codec");
-	print_property(proxy, "Capabilities");
+	print_capabilities(proxy);
 	print_property(proxy, "Device");
 	print_property(proxy, "DelayReporting");
 	print_property(proxy, "Locations");
@@ -3817,6 +3891,42 @@ static void cmd_list_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void print_configuration(GDBusProxy *proxy)
+{
+	DBusMessageIter iter, subiter;
+	uint8_t codec;
+	uint8_t *data;
+	int len;
+
+	if (!g_dbus_proxy_get_property(proxy, "Codec", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &codec);
+
+	if (codec != LC3_ID) {
+		print_property(proxy, "Configuration");
+		return;
+	}
+
+	if (!g_dbus_proxy_get_property(proxy, "Configuration", &iter))
+		return;
+
+	dbus_message_iter_recurse(&iter, &subiter);
+
+	dbus_message_iter_get_fixed_array(&subiter, &data, &len);
+
+	print_lc3_cfg(data, len);
+
+	if (!g_dbus_proxy_get_property(proxy, "Metadata", &iter))
+		return;
+
+	dbus_message_iter_recurse(&iter, &subiter);
+
+	dbus_message_iter_get_fixed_array(&subiter, &data, &len);
+
+	print_lc3_meta(data, len);
+}
+
 static void cmd_show_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -3832,16 +3942,14 @@ static void cmd_show_transport(int argc, char *argv[])
 
 	print_property(proxy, "UUID");
 	print_property(proxy, "Codec");
-	print_property(proxy, "Configuration");
+	print_configuration(proxy);
 	print_property(proxy, "Device");
 	print_property(proxy, "State");
 	print_property(proxy, "Delay");
 	print_property(proxy, "Volume");
 	print_property(proxy, "Endpoint");
-
 	print_property(proxy, "QoS");
 	print_property(proxy, "Location");
-	print_property(proxy, "Metadata");
 	print_property(proxy, "Links");
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-- 
2.41.0

