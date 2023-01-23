Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E14C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 23:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjAWX5Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWX5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 18:57:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F35A30190
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso16857772pjg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vdqUAl2gOIPgCHnq/4ur3vqxgMO5fNyrawOAWTo2Jw=;
        b=PbG3nAWHfTDA2hcIGHVsUDnmzUvM7bzFFvj/fwrNK20yM5TkOzbkYMN+L23Hmy0Kct
         FrxjPWZIWrq+UO1jadLtvWZo+HA6u+C0vUZj1WmRcr+EN2ktAOWk41bhr5ApY1gKn6Pr
         I0Yjt1AizDMHW+UeFc4F8+/qUP5XlSYtXT8ZgvfHBBbEe2b0w4+oQK0lyEWlpfy8UAoX
         BGT/2uVTxrGuTHLfsX+C85I5zJaVFOh7j+ts2rckYJsd+B+uk+OOr/DylcoSfFyNODei
         xAeLquSQprJWaghWU8AQFnqJJ6i/lXCU0pj+Twqbk3UD/r4PpykxlnSuPrbVMDibh267
         NmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vdqUAl2gOIPgCHnq/4ur3vqxgMO5fNyrawOAWTo2Jw=;
        b=N8+Tw/P3vyU5/iemehSP8x2NWC7j9nOPgrGDdkiycuNJkEik0KI3zWUVRwRt2H2hTh
         KoBBMXlXGfV/g1pg9xeVz0Nw7/Ebn3cU2Fmqj4XsdGE0juDClb8zbyeZJdpaRB96YpSE
         6ZPkU+mnUp05Yj7mCw+MH6RpecCayvxygwvzZd7BH1TNnb/CbRYNMLFe36wd1RWmg1xz
         qq87KzMJ6wtWEKrgPY/cnM2goBWNw3ILVTfcjv4C2U7Vclx/3l0zi8pLTRGMnU9T4sIZ
         5AW+v54Z5k0FykjMeRLVy9IYN14jStHcAP8/8MqtP2gjiWjC+vSpbiv/HcPKMGKapgVl
         9aaQ==
X-Gm-Message-State: AFqh2kpkd37O8YtTfeYw8AgSi3Q+MJWavztLWm5KB5RuI7NO8MVhwthT
        vo8+292yan5q7i54Y1wa4rmQCdkYYyA=
X-Google-Smtp-Source: AMrXdXsNPIoEf9XGZJLVTHR284qf6xLdXjTQ9XrKsj0JJkzlnkw1TTCLj7Ave72uXZyfHnSGN60xQQ==
X-Received: by 2002:a17:902:e9cd:b0:194:6627:d7ab with SMTP id 13-20020a170902e9cd00b001946627d7abmr28011730plk.12.1674518212227;
        Mon, 23 Jan 2023 15:56:52 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902d70e00b001960706141fsm268130ply.149.2023.01.23.15.56.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:56:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] client/player: Add support for Company ID, Vendor ID
Date:   Mon, 23 Jan 2023 15:56:46 -0800
Message-Id: <20230123235649.3231488-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230123235649.3231488-1-luiz.dentz@gmail.com>
References: <20230123235649.3231488-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>

This adds support for Company ID and Vendor Codec ID in  BAP profile.
This also adds handling of Vendor Specific Coding format for BAP
Profile.

Now it allows to enter zero codec capabilities for vendor codec.
In order to register zero codec capabilities, 0 shall be
entered when prompted.
---
 client/player.c | 61 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index eba233329276..bab563eec592 100644
--- a/client/player.c
+++ b/client/player.c
@@ -66,6 +66,8 @@ struct endpoint {
 	char *path;
 	char *uuid;
 	uint8_t codec;
+	uint16_t cid;
+	uint16_t vid;
 	struct iovec *caps;
 	bool auto_accept;
 	bool acquiring;
@@ -1815,7 +1817,8 @@ static void endpoint_free(void *data)
 	struct endpoint *ep = data;
 
 	if (ep->caps) {
-		g_free(ep->caps->iov_base);
+		if (ep->caps->iov_base)
+			g_free(ep->caps->iov_base);
 		g_free(ep->caps);
 	}
 
@@ -1865,10 +1868,30 @@ static gboolean endpoint_get_capabilities(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean endpoint_get_vendor(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->cid);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->vid);
+
+	return TRUE;
+}
+
+static gboolean endpoint_vendor_exists(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct endpoint *ep = data;
+
+	return ep->cid && ep->vid;
+}
+
 static const GDBusPropertyTable endpoint_properties[] = {
 	{ "UUID", "s", endpoint_get_uuid, NULL, NULL },
 	{ "Codec", "y", endpoint_get_codec, NULL, NULL },
 	{ "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
+	{ "Vendor", "qq", endpoint_get_vendor, NULL, endpoint_vendor_exists },
 	{ }
 };
 
@@ -1886,12 +1909,14 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 
 	g_dbus_dict_append_entry(&dict, "Codec", DBUS_TYPE_BYTE, &ep->codec);
 
-	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+	if (ep->caps->iov_len) {
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
 					DBUS_TYPE_BYTE, &ep->caps->iov_base,
 					ep->caps->iov_len);
 
-	bt_shell_printf("Capabilities:\n");
-	bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
+		bt_shell_printf("Capabilities:\n");
+		bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
+	}
 
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -2014,13 +2039,21 @@ static void endpoint_set_capabilities(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (ep->caps)
+	if (ep->caps && ep->caps->iov_base) {
 		g_free(ep->caps->iov_base);
-	else
+		ep->caps = g_new0(struct iovec, 1);
+	} else
 		ep->caps = g_new0(struct iovec, 1);
 
 	ep->caps->iov_base = str2bytearray((char *) input, &ep->caps->iov_len);
 
+	if (ep->caps->iov_len == 0x01 &&
+			(*(uint8_t *)(ep->caps->iov_base)) == 0x00) {
+		g_free(ep->caps->iov_base);
+		ep->caps->iov_base = NULL;
+		ep->caps->iov_len = 0x00;
+	}
+
 	bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
 						endpoint_auto_accept, ep);
 }
@@ -2069,14 +2102,28 @@ static void cmd_register_endpoint(int argc, char *argv[])
 {
 	struct endpoint *ep;
 	char *endptr = NULL;
+	char **list;
 
 	ep = g_new0(struct endpoint, 1);
 	ep->uuid = g_strdup(argv[1]);
 	ep->codec = strtol(argv[2], &endptr, 0);
+	ep->cid = 0x0000;
+	ep->vid = 0x0000;
 	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
 					g_list_length(local_endpoints));
 	local_endpoints = g_list_append(local_endpoints, ep);
 
+	if (g_strstr_len(argv[2], -1, ":")) {
+		bt_shell_printf("Found split\r\n");
+
+		list = g_strsplit(argv[2], ":", 2);
+
+		ep->codec = 0xff;
+		ep->vid = strtol(list[0], &endptr, 0);
+		endptr = NULL;
+		ep->cid = strtol(list[1], &endptr, 0);
+	}
+
 	if (argc > 3)
 		endpoint_set_capabilities(argv[3], ep);
 	else {
@@ -2638,7 +2685,7 @@ static const struct bt_shell_menu endpoint_menu = {
 	{ "show",         "<endpoint>", cmd_show_endpoint,
 						"Endpoint information",
 						endpoint_generator },
-	{ "register",     "<UUID> <codec> [capabilities...]",
+	{ "register",     "<UUID> <codec[:company]> [capabilities...]",
 						cmd_register_endpoint,
 						"Register Endpoint",
 						uuid_generator },
-- 
2.37.3

