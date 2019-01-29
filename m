Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C421C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3234020881
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkoPpOe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfA2LnM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:12 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44781 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfA2LnM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:12 -0500
Received: by mail-ed1-f44.google.com with SMTP id y56so15687859edd.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 03:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=K+xsR5h0keCNwqKqwl7gE1gl0upf9Z8Irve7X8ll5no=;
        b=nkoPpOe87M1JcKQkUwvHs1KO+8FVW/1ZGw5ZV2VSLqOfm75/IK1dVdyQa1kO1RZWkt
         NXGzxDZNsm+0yxf1T5xQkguOAZE+//un2eiuJuBJW4raw6u3SoSTXDY9qvK1G1j90awu
         6KI3dZ2bYdXaw8d7JpElwuZBDIPLmVs88xJWV5ApOcgeNei3/6lCnvc3N191K7M2fEn9
         eTMm1GT3pOHQ+k71maXJN0U5oVgMqwftBJGgv26u/SLIj++gIvZePRjxp++jMqWGYn/V
         X4xd50E20bDz4r/i27jwJZUpYU63JGv0G+BVPF9YnfgEuy8WA8FE2Ua0KeflGYAZ4gPZ
         T9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=K+xsR5h0keCNwqKqwl7gE1gl0upf9Z8Irve7X8ll5no=;
        b=EAuJj3YEs4BvLD0cAKD7eEjGUPIBTtZPoxR32Twkac5r3WLcPhHNmw1ABkS+c/IVZ0
         mLy78gInyDe3q3thd35cIZFM7coU2HwJmwUd1Gy4YFMDKnyGdQ8pYqLiVqxySxq+vQwf
         d2C/8O5lN8wQ+RNZOZNiZsXAycKvxvxsTcGeIUBkkEFhjZWwyPorUUy5vW3SKAdNnyIq
         OllVVvr8APhKmZILsWkT+dhNHTWwVWp2c4gdIbewMUZ3ZB2d+e7u7mnD0QINpXO22qiq
         sRojewTXqrQPyiuELfDvT5QE/x2YGSkTbXe2+Vr3U7t7D1bdv0zUX+uNcWldqRnTIEOZ
         D0Ag==
X-Gm-Message-State: AJcUukc7RP78d660u8UgX67HbtB0+Y/B/chpCuAyRT5FhcpDEarEBKf/
        kprvyjrDlh4/cY6nseZhrK0oGSzR
X-Google-Smtp-Source: ALg8bN5BtfJcHcC5E0YtKTSAWZdo/hfwhgoFg/5Oos94GPEu+hPjBbDIsSUxhv7wQ7ZrpbHx7M7IMQ==
X-Received: by 2002:a50:b85d:: with SMTP id k29mr25118991ede.86.1548762189627;
        Tue, 29 Jan 2019 03:43:09 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id d56sm14675692ede.76.2019.01.29.03.43.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 03:43:08 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] client: Enable setting attribute handles
Date:   Tue, 29 Jan 2019 13:42:58 +0200
Message-Id: <20190129114258.20945-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129114258.20945-1-luiz.dentz@gmail.com>
References: <20190129114258.20945-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This emulates application setting their attribute handles.
---
 client/gatt.c       | 53 +++++++++++++++++++++++++++++++--------------
 client/main.c       | 13 ++++++-----
 src/gatt-database.c | 24 +++++++++++++++-----
 3 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 0137aa9e5..16ba2e306 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -120,21 +120,24 @@ static void print_service(struct service *service, const char *description)
 
 	text = bt_uuidstr_to_str(service->uuid);
 	if (!text)
-		bt_shell_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Service\n\t%s\n\tHandle %u\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					service->primary ? "Primary" :
 					"Secondary",
-					service->path, service->uuid);
+					service->path, service->handle,
+					service->uuid);
 	else
-		bt_shell_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Service\n\t%s\n\tHandle %u\n\t%s\n\t"
+					"%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					service->primary ? "Primary" :
 					"Secondary",
-					service->path, service->uuid, text);
+					service->path, service->handle,
+					service->uuid, text);
 }
 
 static void print_inc_service(struct service *service, const char *description)
@@ -143,21 +146,25 @@ static void print_inc_service(struct service *service, const char *description)
 
 	text = bt_uuidstr_to_str(service->uuid);
 	if (!text)
-		bt_shell_printf("%s%s%s%s Included Service\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Included Service\n\t%s\n\tHandle %u"
+					"\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					service->primary ? "Primary" :
 					"Secondary",
-					service->path, service->uuid);
+					service->path, service->handle,
+					service->uuid);
 	else
-		bt_shell_printf("%s%s%s%s Included Service\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Included Service\n\t%s\n\tHandle %u"
+					"\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					service->primary ? "Primary" :
 					"Secondary",
-					service->path, service->uuid, text);
+					service->path, service->handle,
+					service->uuid, text);
 }
 
 static void print_service_proxy(GDBusProxy *proxy, const char *description)
@@ -210,17 +217,20 @@ static void print_chrc(struct chrc *chrc, const char *description)
 
 	text = bt_uuidstr_to_str(chrc->uuid);
 	if (!text)
-		bt_shell_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sCharacteristic\n\t%s\n\tHandle %u\n\t"
+					"%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					chrc->path, chrc->uuid);
+					chrc->path, chrc->handle, chrc->uuid);
 	else
-		bt_shell_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sCharacteristic\n\t%s\n\tHandle %u\n\t"
+					"%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					chrc->path, chrc->uuid, text);
+					chrc->path, chrc->handle, chrc->uuid,
+					text);
 }
 
 static void print_characteristic(GDBusProxy *proxy, const char *description)
@@ -300,17 +310,19 @@ static void print_desc(struct desc *desc, const char *description)
 
 	text = bt_uuidstr_to_str(desc->uuid);
 	if (!text)
-		bt_shell_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sDescriptor\n\t%s\n\tHandle %u\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					desc->path, desc->uuid);
+					desc->path, desc->handle, desc->uuid);
 	else
-		bt_shell_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sDescriptor\n\t%s\n\tHandle %u\n\t%s\n\t"
+					"%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					desc->path, desc->uuid, text);
+					desc->path, desc->handle, desc->uuid,
+					text);
 }
 
 static void print_descriptor(GDBusProxy *proxy, const char *description)
@@ -1394,6 +1406,9 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 	service->path = g_strdup_printf("%s/service%p", APP_PATH, service);
 	service->primary = primary;
 
+	if (argc > 2)
+		service->handle = atoi(argv[2]);
+
 	if (g_dbus_register_interface(conn, service->path,
 					SERVICE_INTERFACE, NULL, NULL,
 					service_properties, service,
@@ -2271,6 +2286,9 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	chrc->flags = g_strsplit(argv[2], ",", -1);
 	chrc->authorization_req = attr_authorization_flag_exists(chrc->flags);
 
+	if (argc > 3)
+		chrc->handle = atoi(argv[3]);
+
 	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
 					chrc_methods, NULL, chrc_properties,
 					chrc, chrc_free) == FALSE) {
@@ -2535,6 +2553,9 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 	desc->path = g_strdup_printf("%s/desc%p", desc->chrc->path, desc);
 	desc->flags = g_strsplit(argv[2], ",", -1);
 
+	if (argc > 3)
+		desc->handle = atoi(argv[3]);
+
 	if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
 					desc_methods, NULL, desc_properties,
 					desc, desc_free) == FALSE) {
diff --git a/client/main.c b/client/main.c
index a4647f334..07c8ec008 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2619,22 +2619,23 @@ static const struct bt_shell_menu gatt_menu = {
 						"Register profile to connect" },
 	{ "unregister-application", NULL, cmd_unregister_app,
 						"Unregister profile" },
-	{ "register-service", "<UUID>", cmd_register_service,
+	{ "register-service", "<UUID> [handle]", cmd_register_service,
 					"Register application service."  },
 	{ "unregister-service", "<UUID/object>", cmd_unregister_service,
 					"Unregister application service" },
-	{ "register-includes", "<UUID>", cmd_register_includes,
+	{ "register-includes", "<UUID> [handle]", cmd_register_includes,
 					"Register as Included service in." },
 	{ "unregister-includes", "<Service-UUID><Inc-UUID>",
 			cmd_unregister_includes,
 				 "Unregister Included service." },
-	{ "register-characteristic", "<UUID> <Flags=read,write,notify...> "
-					, cmd_register_characteristic,
-					"Register application characteristic" },
+	{ "register-characteristic",
+			"<UUID> <Flags=read,write,notify...> [handle]",
+			cmd_register_characteristic,
+			"Register application characteristic" },
 	{ "unregister-characteristic", "<UUID/object>",
 				cmd_unregister_characteristic,
 				"Unregister application characteristic" },
-	{ "register-descriptor", "<UUID> <Flags=read,write...>",
+	{ "register-descriptor", "<UUID> <Flags=read,write...> [handle]",
 					cmd_register_descriptor,
 					"Register application descriptor" },
 	{ "unregister-descriptor", "<UUID/object>",
diff --git a/src/gatt-database.c b/src/gatt-database.c
index b159786ea..cca70c947 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1843,17 +1843,16 @@ static bool parse_handle(GDBusProxy *proxy, uint16_t *handle)
 {
 	DBusMessageIter iter;
 
+	*handle = 0;
+
 	/* Handle property is optional */
-	if (!g_dbus_proxy_get_property(proxy, "Handle", &iter)) {
-		*handle = 0;
+	if (!g_dbus_proxy_get_property(proxy, "Handle", &iter))
 		return true;
-	}
-
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
 		return false;
 
-	dbus_message_iter_get_basic(&iter, &handle);
+	dbus_message_iter_get_basic(&iter, handle);
 
 	return true;
 }
@@ -2634,6 +2633,7 @@ static bool database_add_desc(struct external_service *service,
 {
 	uint16_t handle;
 	bt_uuid_t uuid;
+	char str[MAX_LEN_UUID_STR];
 
 	if (!parse_handle(desc->proxy, &handle)) {
 		error("Failed to read \"Handle\" property of descriptor");
@@ -2662,6 +2662,10 @@ static bool database_add_desc(struct external_service *service,
 		write_handle(desc->proxy, handle);
 	}
 
+	bt_uuid_to_string(&uuid, str, sizeof(str));
+
+	DBG("handle 0x%04x UUID %s", handle, str);
+
 	return true;
 }
 
@@ -2795,6 +2799,7 @@ static bool database_add_chrc(struct external_service *service,
 {
 	uint16_t handle;
 	bt_uuid_t uuid;
+	char str[MAX_LEN_UUID_STR];
 	const struct queue_entry *entry;
 
 	if (!parse_handle(chrc->proxy, &handle)) {
@@ -2832,6 +2837,10 @@ static bool database_add_chrc(struct external_service *service,
 		write_handle(chrc->proxy, handle);
 	}
 
+	bt_uuid_to_string(&uuid, str, sizeof(str));
+
+	DBG("handle 0x%04x UUID %s", handle, str);
+
 	/* Handle the descriptors that belong to this characteristic. */
 	for (entry = queue_get_entries(service->descs); entry;
 							entry = entry->next) {
@@ -2863,6 +2872,7 @@ static bool database_add_service(struct external_service *service)
 	bool primary;
 	uint16_t handle;
 	const struct queue_entry *entry;
+	char str[MAX_LEN_UUID_STR];
 
 	if (!parse_uuid(service->proxy, &uuid)) {
 		error("Failed to read \"UUID\" property of service");
@@ -2895,6 +2905,10 @@ static bool database_add_service(struct external_service *service)
 		write_handle(service->proxy, handle);
 	}
 
+	bt_uuid_to_string(&uuid, str, sizeof(str));
+
+	DBG("handle 0x%04x UUID %s", handle, str);
+
 	database_add_includes(service);
 
 	entry = queue_get_entries(service->chrcs);
-- 
2.17.2

