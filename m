Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C5CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 21:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E29F6112D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 21:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbhKIVkL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 16:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbhKIVkK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 16:40:10 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A4C061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 13:37:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e65so321094pgc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 13:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xAeCrjPK7LSjN6yULZm/dFdUvkRk2cHGL1Oh+8+6Ciw=;
        b=ON8LxY2KsA5Ltcj3xjgZegl4OkK9+Kq016AVs57EDdVZNtKBeXnQzlmyYo18TkscXw
         +tBpfYLRzsqJpMjE9faoJFcHjADIFe88ZwamuA4Qtv0+CFUNlCxR7qrZxCj8SvWXPmmD
         BI8WWQEIknVY2AZAc5na95rSMO9s3X/gQz/nVblSDz+M/CRE+rAypaU+jrnUV+tFX0en
         2Wy3NX4I654KGIghEUBbdoqv5vPmJ3Wftd3V49fqJ1i9LfcAjzeCw+QH8mLBLG1UfgAP
         V+KTD3XhF1pojGWZV6FHzdBcuHNHeP4EUttBndScpArsEbnBSIH1t+YdejNKDA1EzfrH
         r4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xAeCrjPK7LSjN6yULZm/dFdUvkRk2cHGL1Oh+8+6Ciw=;
        b=B9zVyyCuJAM9RW4LR2thvtH/3iU5w0CTklbDLBe3HWg6Wo5S8KWy7/zCAPUafx2ojX
         1JXfEtSR7oNBi5FAs1Ncar99pd33McDb8rIxn/RMrgHR8VJLczvX9bVQsA0v0SYl1kf2
         gzw3SVUd2RoCqfzL9AaFadehZQrpN8haRCs+XQQ91CIzd9N7GjZG9kP/V0FKC4m7GFEC
         n+tSfn5HfPxb8EiUOIWwkQOInnLdYjaB+hlC0bTuRS1Hi2OG+rjgSfj2lT0QG2XpgV6H
         jU7UNQazpL8Cr1MejtcLNisJM1T7VW6cvwhIRPXCQ0yZnKxbtbxkx7lG2CQLcUUK+Mtz
         jbbw==
X-Gm-Message-State: AOAM531X7PHt+OMgnqjFc8FbqHNBrxpohWvU4EmZ69GDOpGU/cz8HLgY
        9SsmmIOExuwZyysrychzBSThQBkKqfM=
X-Google-Smtp-Source: ABdhPJwJ5tR2XgrxNufVutrT+YXn0mXFWX0qp+rBHEyWf3BC6p2O9iupH6t8A4j2lrYod57uE9GGig==
X-Received: by 2002:a63:fd43:: with SMTP id m3mr8359006pgj.355.1636493843140;
        Tue, 09 Nov 2021 13:37:23 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e15sm473697pfv.131.2021.11.09.13.37.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 13:37:22 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] client/gatt: Fix using atoi
Date:   Tue,  9 Nov 2021 13:37:21 -0800
Message-Id: <20211109213721.1121677-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

atoi doesn't support values entered in hexadecimal (0x...) which is
likely the prefered format for the likes of handles, etc, so this
replaces the uses of atoi with strtoul.
---
 client/gatt.c | 71 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 21fd38ecf..ce13b3341 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -647,22 +647,40 @@ static void read_attribute(GDBusProxy *proxy, uint16_t offset)
 	bt_shell_printf("Attempting to read %s\n", g_dbus_proxy_get_path(proxy));
 }
 
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
 void gatt_read_attribute(GDBusProxy *proxy, int argc, char *argv[])
 {
 	const char *iface;
-	uint16_t offset = 0;
+	int offset = 0;
 
 	iface = g_dbus_proxy_get_interface(proxy);
 	if (!strcmp(iface, "org.bluez.GattCharacteristic1") ||
 				!strcmp(iface, "org.bluez.GattDescriptor1")) {
 
-		if (argc == 2)
-			offset = atoi(argv[1]);
+		if (argc == 2) {
+			offset = parse_offset(argv[1]);
+			if (offset < 0)
+				goto fail;
+		}
 
 		read_attribute(proxy, offset);
 		return;
 	}
 
+fail:
 	bt_shell_printf("Unable to read attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -805,8 +823,15 @@ void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[])
 				!strcmp(iface, "org.bluez.GattDescriptor1")) {
 		data.iov.iov_base = str2bytearray(argv[1], &data.iov.iov_len);
 
-		if (argc > 2)
-			data.offset = atoi(argv[2]);
+		if (argc > 2) {
+			int offset;
+
+			offset = parse_offset(argv[2]);
+			if (offset < 0)
+				goto fail;
+
+			data.offset = offset;
+		}
 
 		if (argc > 3)
 			data.type = argv[3];
@@ -815,6 +840,7 @@ void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[])
 		return;
 	}
 
+fail:
 	bt_shell_printf("Unable to write attribute %s\n",
 						g_dbus_proxy_get_path(proxy));
 
@@ -1469,6 +1495,20 @@ static void service_set_primary(const char *input, void *user_data)
 	}
 }
 
+static uint16_t parse_handle(const char *arg)
+{
+	char *endptr = NULL;
+	unsigned long handle;
+
+	handle = strtoul(arg, &endptr, 0);
+	if (!endptr || *endptr != '\0' || !handle || handle > UINT16_MAX) {
+		bt_shell_printf("Invalid handle: %s", arg);
+		return 0;
+	}
+
+	return handle;
+}
+
 void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 						int argc, char *argv[])
 {
@@ -1482,8 +1522,11 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 					g_list_length(local_services));
 	service->primary = primary;
 
-	if (argc > 2)
-		service->handle = atoi(argv[2]);
+	if (argc > 2) {
+		service->handle = parse_handle(argv[2]);
+		if (!service->handle)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
 	if (g_dbus_register_interface(conn, service->path,
 					SERVICE_INTERFACE, NULL, NULL,
@@ -2574,8 +2617,11 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	chrc->flags = g_strsplit(argv[2], ",", -1);
 	chrc->authorization_req = attr_authorization_flag_exists(chrc->flags);
 
-	if (argc > 3)
-		chrc->handle = atoi(argv[3]);
+	if (argc > 3) {
+		chrc->handle = parse_handle(argv[3]);
+		if (!chrc->handle)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
 	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
 					chrc_methods, NULL, chrc_properties,
@@ -2851,8 +2897,11 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 					g_list_length(desc->chrc->descs));
 	desc->flags = g_strsplit(argv[2], ",", -1);
 
-	if (argc > 3)
-		desc->handle = atoi(argv[3]);
+	if (argc > 3) {
+		desc->handle = parse_handle(argv[3]);
+		if (!desc->handle)
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
 
 	if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
 					desc_methods, NULL, desc_properties,
-- 
2.31.1

