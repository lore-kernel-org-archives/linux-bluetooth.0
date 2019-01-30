Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD41C282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484F218A3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxTb59QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfA3Nyj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41131 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfA3Nyj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:39 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so19034274edc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 05:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=LNayJgeEB3bij6sxv2ejHjHeB4U8gc3vyi4a0lzR/Mw=;
        b=nxTb59QE3bmZ/HcB5ah31Qia1k+BZmeTaXo/xw3ZkpMCxe4DM//qUB8bl74iUdzo3T
         R5kx2zBXr0nIArhVSJZffHWPQkCakqVvUAQFeDJxDyDOFoL4hFbiImj0FpCq8zS7CTmq
         JRGE8owXpvQPqEKm7C0BZyCoZrya/QaJl+TpQG/ctvJ4XXt1ErDm5f70MSnTFv785hZp
         apYerqWeaQuM7MpF20huUDfQLK+maoq7ajLWKVA2FAhPHZ/gmT5JQS6M4zZSQPABxQ6D
         lmH9yyFU+hRDtbSp2ucHFcsk1CZ+BTcv+IsKQ3g0BldsJUWZnCGKToRCjlQFBOi53EAc
         tZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=LNayJgeEB3bij6sxv2ejHjHeB4U8gc3vyi4a0lzR/Mw=;
        b=mBXaVpGkT/N2w37PC9yc3gvKKiwdheeylF9Enc/D9m8jLWRE+u3fpmP5iihloAQWCL
         pRDTHmzdm53POZ0462pUAlOfYc+/qwOZiy9c1HU38vWV2+iBo3aMUKBhwb0f90ptqogy
         QxlPjV3y4KivO9QmJ19qqMPevYN8izgsjohyzngBLTeDqMkUcPdntWhwcYRmdOe/xv1u
         V6FalR6M3n/bOnZbXVCDG/zwtEOFQl/YpDLDtRHglbEO0Hd8k0SHF+vXmAXLG9fFk5+r
         LjUndw5X2m4ttGdbLy6O9O2D5I4nJqY37CRdyjKeeVEZG0HcZePHJB2ZKR4eMvApK7OU
         vEOQ==
X-Gm-Message-State: AJcUukfsVAK27sIDV4lj6SCTejVbf8WD7tKfEIKW2z9YkFBOfk3cHB4o
        CBPU9ijPiPVp+WNmY/9BS9RHckkM
X-Google-Smtp-Source: ALg8bN529iOLU1KjIEVRlgt5aJpq2qHitlQwuHcSeOGaF57LlLNeVOUazB22ONwQUJzptcVfiUSy8g==
X-Received: by 2002:a50:89e1:: with SMTP id h30mr30539229edh.28.1548856475743;
        Wed, 30 Jan 2019 05:54:35 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s19sm325045eja.52.2019.01.30.05.54.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:54:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/8] client: Enable setting attribute handles
Date:   Wed, 30 Jan 2019 15:54:22 +0200
Message-Id: <20190130135424.2091-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190130135424.2091-1-luiz.dentz@gmail.com>
References: <20190130135424.2091-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This emulates application setting their attribute handles.
---
 client/gatt.c       | 11 ++++++++++-
 client/main.c       | 13 +++++++------
 src/gatt-database.c | 24 +++++++++++++++++++-----
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index b29e68136..42fe795d7 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1410,6 +1410,9 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 	service->path = g_strdup_printf("%s/service%p", APP_PATH, service);
 	service->primary = primary;
 
+	if (argc > 2)
+		service->handle = atoi(argv[2]);
+
 	if (g_dbus_register_interface(conn, service->path,
 					SERVICE_INTERFACE, NULL, NULL,
 					service_properties, service,
@@ -1693,7 +1696,7 @@ static gboolean chrc_notify_acquired_exists(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable chrc_properties[] = {
-	{ "Handle", "s", chrc_get_handle, chrc_set_handle, NULL },
+	{ "Handle", "q", chrc_get_handle, chrc_set_handle, NULL },
 	{ "UUID", "s", chrc_get_uuid, NULL, NULL },
 	{ "Service", "o", chrc_get_service, NULL, NULL },
 	{ "Value", "ay", chrc_get_value, NULL, NULL },
@@ -2289,6 +2292,9 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	chrc->flags = g_strsplit(argv[2], ",", -1);
 	chrc->authorization_req = attr_authorization_flag_exists(chrc->flags);
 
+	if (argc > 3)
+		chrc->handle = atoi(argv[3]);
+
 	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
 					chrc_methods, NULL, chrc_properties,
 					chrc, chrc_free) == FALSE) {
@@ -2555,6 +2561,9 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
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

