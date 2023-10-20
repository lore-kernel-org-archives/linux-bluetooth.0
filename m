Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33159C0032E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 18:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377970AbjJTSIs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJTSIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 14:08:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41942D57
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 11:08:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27cfb8bc7eeso891018a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 11:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697825322; x=1698430122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwt/O4BE9qXnQZw8zoFRGFUPhkxOc2BZrusO3xMXvaQ=;
        b=jClA7HcbjhWha4S9rvfb37MyHBWwN0DpuEgYjIVozDmcn7aVhm101IWQ0afLxbYJJs
         ARN+L5JbQBTMofFSE4wa928OpSxxfiRaAUA14HYg2SOApmh31A7446eFpO0QiuDmS1pH
         PqADD470UpIczeM4bMb5fKDjWRevoUdJoU6W0qOP95VSbhDxzKvRQJY8cnPcTqahxS8N
         Zl41n5VrvF3/DLTbIu88YbKmzKv6+cAAgJu2/zPMECKTsPIeCY57jlJwpnWop4FlStFy
         9OB8W8ADk/ilE5NwGjBaFwU3F32QdCu/48JnklVEzEvj5goWSyTzVIQQWWD9bCpYqpjV
         tWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697825322; x=1698430122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwt/O4BE9qXnQZw8zoFRGFUPhkxOc2BZrusO3xMXvaQ=;
        b=lgFcSJtRJytgM6KejmyDvAH9diy41WlftoFJbhvRJoaCB7tiPw/v3lxUGO5oGm26MM
         XZaIqA4F//aTiwb3Kn+2vnz1BHLygA5u+qPZAvs55nz1BDENhSGZ9163uY0dKJjJupUw
         LGVv7dbtJB007iEiFWl5mJo2/N+Net2CUFa9bCa0bYZdGYSByb859HOjsSpMKBKfP0Ty
         iY3jNWQ/ywRQnCkh973e0GvK4RrLP3hVulVET4TX/EQ0gtyJJFT8PFXHHm3cQP1CaXpH
         3YGmU1e685CodQ1EYP4vbAMeMsTJCXLBo5xAvCWgTtXSUwFGHLfqNOhBNbZ9wiBa3c6e
         x/Cg==
X-Gm-Message-State: AOJu0YwXKoKelXe4f2DGvkhNunsYiPmrAHgg0n4BCcWr1gNsc3lW0/Cv
        5lprLB8r1myZRfI6NEeBVH9zx4UAH7K5I5Vh0Yo=
X-Google-Smtp-Source: AGHT+IFCYxxjePkeE8GhnAVSn9MY3MpHvbpsrrjHYO8437dJ8I2/58AMNF/Ik2UXJugM7yWVdMuUJA==
X-Received: by 2002:a17:90b:2890:b0:27d:63ae:f376 with SMTP id qc16-20020a17090b289000b0027d63aef376mr2906266pjb.38.1697825321849;
        Fri, 20 Oct 2023 11:08:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090ad34400b00263b9e75aecsm1729800pjx.41.2023.10.20.11.08.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:08:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] client: Make use of bap-debug functions
Date:   Fri, 20 Oct 2023 11:08:34 -0700
Message-ID: <20231020180834.3010421-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020180834.3010421-1-luiz.dentz@gmail.com>
References: <20231020180834.3010421-1-luiz.dentz@gmail.com>
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

