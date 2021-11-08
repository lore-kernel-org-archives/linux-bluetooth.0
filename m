Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84641C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 19:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621E9617E4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 19:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhKHTUj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhKHTUi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Nov 2021 14:20:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207CC061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Nov 2021 11:17:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h24so7780418pjq.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Nov 2021 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0CC5A2DRcBB1LqP28NkgRfky2KgWTkZ+NSz3pqnvq8=;
        b=bho3AgXwL+IdhrxVxFprz/yf8RAG5y/fuuZtuMgfjmePGOueghSdXGXPNV4eEr7oLw
         Ttia38Jh8tj98HHpWJc1y3znAGblenapQYaTQe3VQCktu3zPFP1o3nUSdagfth/zF25l
         DfD8hI5f0EP5Ro9hYH03pUq7JHDkWb4j3nqC4gErOeR5fYuD1y/jKLXJV1hSuG5U3KnA
         CVIRfFjceFXhfugX6XAoLlfmAi1WXw8X8WFJCPCUDHRVjXpeENamivfV88YdF1E/xtcX
         ojxg7HCoen56EejUtuizURuofkZOx4WeV9wECWoo8NoA4+0WjopbsS1vUJrifZWbff+8
         gRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0CC5A2DRcBB1LqP28NkgRfky2KgWTkZ+NSz3pqnvq8=;
        b=wEA8xjF0xYv/AZyF56kzU7A2AC7mirRRpCr54qCfW80/8OnoeOnT5xE3utREyjFCwC
         UasOr0Cx1uYq3pErsu8YSPPQK6R1djyezy9x3zM29BnE3o/05Ndi9/MkdVtgOWjbyDiL
         n9a1hYX4gGNlbbw9fT6YnGdA3Xjoo6Iwl5eyfUfnjNp8HD99utJsA+wWPsyQTLA8O0H8
         P/J0c+xlbsb068KT+Pt3zX7YWH34U/vqOColA03dMdq0I6nD37qKiifr23jSmp28s7fi
         0xTg2aTj/uFM8TQk6IzlNrHCvTE8F9hj7vHrql7Bc/nMR1zSWWz3t1nFeyXggmCqw2mL
         Moog==
X-Gm-Message-State: AOAM533ffH6w/TZtFiB62fml3k3b2p+9XuHGXujsimeAJhZhWe98RB6I
        jrQVDkGKfCyk5eAWFUkXhghHDhJKBfY=
X-Google-Smtp-Source: ABdhPJz3+uByTWFTvNItQt/W1gsYrtv5vpavAqTEuvSeaomTnCsA92+2blBVaQtuQ5UD2nxcz1TYAw==
X-Received: by 2002:a17:902:e302:b0:141:ba08:2e44 with SMTP id q2-20020a170902e30200b00141ba082e44mr1282452plc.81.1636399073176;
        Mon, 08 Nov 2021 11:17:53 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c8sm118902pjr.38.2021.11.08.11.17.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 11:17:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/gatt: Fix using atoi
Date:   Mon,  8 Nov 2021 11:17:52 -0800
Message-Id: <20211108191752.895782-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

atoi doesn't support values entered in hexadecimal (0x...) which is
likely the prefered format for the likes of handles, etc, so this
replaces the uses of atoi with strtol.
---
 client/gatt.c | 71 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 21fd38ecf..12e213d0f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -650,19 +650,27 @@ static void read_attribute(GDBusProxy *proxy, uint16_t offset)
 void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[])
 {
 	const char *iface;
-	uint16_t offset = 0;
+	long offset = 0;
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	if (!strcmp(iface, "org.bluez.GattCharacteristic1") ||
 				!strcmp(iface, "org.bluez.GattDescriptor1")) {
 
-		if (argc == 2)
-			offset = atoi(argv[1]);
+		if (argc == 2) {
+			char *endptr = NULL;
+
+			offset = strtol(argv[1], &endptr, 0);
+			if (!endptr || *endptr != '\0' || offset > UINT16_MAX) {
+				bt_shell_printf("Invalid offload: %s", argv[1]);
+				goto done;
+			}
+		}
 
 		read_attribute(proxy, offset);
 		return;
 	}
 
+done:
 	bt_shell_printf("Unable to read attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -805,8 +813,18 @@ void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[])
 				!strcmp(iface, "org.bluez.GattDescriptor1")) {
 		data.iov.iov_base = str2bytearray(argv[1], &data.iov.iov_len);
 
-		if (argc > 2)
-			data.offset = atoi(argv[2]);
+		if (argc > 2) {
+			char *endptr = NULL;
+			long offset;
+
+			offset = strtol(argv[1], &endptr, 0);
+			if (!endptr || *endptr != '\0' || offset > UINT16_MAX) {
+				bt_shell_printf("Invalid offload: %s", argv[1]);
+				goto fail;
+			}
+
+			data.offset = offset;
+		}
 
 		if (argc > 3)
 			data.type = argv[3];
@@ -815,6 +833,7 @@ void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[])
 		return;
 	}
 
+fail:
 	bt_shell_printf("Unable to write attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 
@@ -1482,8 +1501,18 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 					g_list_length(local_services));
 	service->primary = primary;
 
-	if (argc > 2)
-		service->handle = atoi(argv[2]);
+	if (argc > 2) {
+		char *endptr = NULL;
+		long handle;
+
+		handle = strtol(argv[2], &endptr, 0);
+		if (!endptr || *endptr != '\0' || handle > UINT16_MAX) {
+			bt_shell_printf("Invalid handle: %s", argv[2]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		service->handle = handle;
+	}
 
 	if (g_dbus_register_interface(conn, service->path,
 					SERVICE_INTERFACE, NULL, NULL,
@@ -2574,8 +2603,18 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	chrc->flags = g_strsplit(argv[2], ",", -1);
 	chrc->authorization_req = attr_authorization_flag_exists(chrc->flags);
 
-	if (argc > 3)
-		chrc->handle = atoi(argv[3]);
+	if (argc > 3) {
+		char *endptr = NULL;
+		long handle;
+
+		handle = strtol(argv[3], &endptr, 0);
+		if (!endptr || *endptr != '\0' || handle > UINT16_MAX) {
+			bt_shell_printf("Invalid handle: %s", argv[3]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		chrc->handle = handle;
+	}
 
 	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
 					chrc_methods, NULL, chrc_properties,
@@ -2851,8 +2890,18 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 					g_list_length(desc->chrc->descs));
 	desc->flags = g_strsplit(argv[2], ",", -1);
 
-	if (argc > 3)
-		desc->handle = atoi(argv[3]);
+	if (argc > 3) {
+		char *endptr = NULL;
+		long handle;
+
+		handle = strtol(argv[3], &endptr, 0);
+		if (!endptr || *endptr != '\0' || handle > UINT16_MAX) {
+			bt_shell_printf("Invalid handle: %s", argv[3]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		desc->handle = handle;
+	}
 
 	if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
 					desc_methods, NULL, desc_properties,
-- 
2.31.1

