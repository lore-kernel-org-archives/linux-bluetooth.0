Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17103C282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D231220833
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/JT54TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfA3Nyh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:37 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:44701 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbfA3Nyh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:37 -0500
Received: by mail-ed1-f46.google.com with SMTP id y56so19031107edd.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 05:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7QCGEck7aEWIUrdDpft/OFhXiw+BV6IGm1wUhpSVagU=;
        b=p/JT54TMOiBtV0yx8BQ1EC7mxNBzzPtDMi4qMMg4Co5OB97eVdK3OkssNrSzM8nG2d
         UyqvIASE+4ryJ1UOmb7an2F1Sqy19dJbw7BdoftgzuQdaiUKL1IRpCtXxNiBdTYrMuy7
         cw8BXOPYbiA3X40yJiajtTOId6ALGgc1TIFuvgux9qZmUq7eMZNV1wOLh9sDEErqlVMN
         boXagfy6XpEIWG7Z3zPICMJWY4I425qM7UV53mq/4Rp/uyFgQBSAYyl63UbkWKwAUp3M
         +Y9DJ4Aef8jOdiHKSqlEhsHjKdeHiDvOsnX2Wve65HY1jubuQLjVxxWWCpkkINgQMFUj
         H9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7QCGEck7aEWIUrdDpft/OFhXiw+BV6IGm1wUhpSVagU=;
        b=DrotSFtzTcsZdE0yv5648m3RckVGiJaCzjgm5XR6lI/wRaW039cRW/Y8liSKBPDu/G
         upxkSc32h0RBCfC1135P0lADv1GH4sJqoziVHGRQ5XKSmRIlIZTtCay1m1vZRVieLnOM
         zuGog0GIgaxaF8DuiZBTsj4Bc8YTlJlA+1rNTP/EBo4g8uBvdq06LjtBVHtr/SfQj4QJ
         PmQlQWhDX5lEobV90NcgmteZyQBtscA7FM2E7508VZaB6YVGrRjdwps4nh5Z5T0+tHXO
         GLUrtIZFlE6PAAIUZ5hf3CUB+Sa2oAAbyCpU26YIDmKyZUYObq4VGq1tEJ7egNJh9ncx
         41zA==
X-Gm-Message-State: AJcUukciPVNZNIsZZLdxt/BsPrro98U4CwVAbeRCfejlZ+tTZ0V5fxMo
        FnLCVJGCmKxIZaP/fKedmfyUA+uX
X-Google-Smtp-Source: ALg8bN5J7sBc/G5I1olo3ljgibcRgs+45Lqhj0GmgQcCSEFYt75dfg71qiqHkEnOx2MOjVhyrKfnCw==
X-Received: by 2002:a17:906:3e49:: with SMTP id t9mr12152881eji.245.1548856474307;
        Wed, 30 Jan 2019 05:54:34 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s19sm325045eja.52.2019.01.30.05.54.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:54:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/8] client: Enable Handle property for GATT attributes
Date:   Wed, 30 Jan 2019 15:54:21 +0200
Message-Id: <20190130135424.2091-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190130135424.2091-1-luiz.dentz@gmail.com>
References: <20190130135424.2091-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable bluetoothd to write back the actual value of attribute
handles.
---
 client/gatt.c | 140 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 124 insertions(+), 16 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index b6b517bdf..b29e68136 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -62,6 +62,7 @@
 struct desc {
 	struct chrc *chrc;
 	char *path;
+	uint16_t handle;
 	char *uuid;
 	char **flags;
 	int value_len;
@@ -72,6 +73,7 @@ struct desc {
 struct chrc {
 	struct service *service;
 	char *path;
+	uint16_t handle;
 	char *uuid;
 	char **flags;
 	bool notifying;
@@ -88,6 +90,7 @@ struct chrc {
 struct service {
 	DBusConnection *conn;
 	char *path;
+	uint16_t handle;
 	char *uuid;
 	bool primary;
 	GList *chrcs;
@@ -117,21 +120,25 @@ static void print_service(struct service *service, const char *description)
 
 	text = bt_uuidstr_to_str(service->uuid);
 	if (!text)
-		bt_shell_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Service (Handle 0x%04x)\n\t%s\n\t"
+					"%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					service->primary ? "Primary" :
 					"Secondary",
-					service->path, service->uuid);
+					service->handle, service->path,
+					service->uuid);
 	else
-		bt_shell_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Service (Handle 0x%04x)\n\t%s\n\t%s"
+					"\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					service->primary ? "Primary" :
 					"Secondary",
-					service->path, service->uuid, text);
+					service->handle, service->path,
+					service->uuid, text);
 }
 
 static void print_inc_service(struct service *service, const char *description)
@@ -140,21 +147,25 @@ static void print_inc_service(struct service *service, const char *description)
 
 	text = bt_uuidstr_to_str(service->uuid);
 	if (!text)
-		bt_shell_printf("%s%s%s%s Included Service\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Included Service (Handle 0x%04x)\n\t"
+					"%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					service->primary ? "Primary" :
 					"Secondary",
-					service->path, service->uuid);
+					service->handle, service->path,
+					service->uuid);
 	else
-		bt_shell_printf("%s%s%s%s Included Service\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%s%s Included Service (Handle 0x%04x)\n\t"
+					"%s\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
 					service->primary ? "Primary" :
 					"Secondary",
-					service->path, service->uuid, text);
+					service->handle, service->path,
+					service->uuid, text);
 }
 
 static void print_service_proxy(GDBusProxy *proxy, const char *description)
@@ -207,17 +218,20 @@ static void print_chrc(struct chrc *chrc, const char *description)
 
 	text = bt_uuidstr_to_str(chrc->uuid);
 	if (!text)
-		bt_shell_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sCharacteristic (Handle 0x%04x)\n\t%s\n\t"
+					"%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					chrc->path, chrc->uuid);
+					chrc->handle, chrc->path, chrc->uuid);
 	else
-		bt_shell_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sCharacteristic (Handle 0x%04x)\n\t%s\n\t"
+					"%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					chrc->path, chrc->uuid, text);
+					chrc->handle, chrc->path, chrc->uuid,
+					text);
 }
 
 static void print_characteristic(GDBusProxy *proxy, const char *description)
@@ -297,17 +311,20 @@ static void print_desc(struct desc *desc, const char *description)
 
 	text = bt_uuidstr_to_str(desc->uuid);
 	if (!text)
-		bt_shell_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sDescriptor (Handle 0x%04x)\n\t%s\n\t"
+					"%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					desc->path, desc->uuid);
+					desc->handle, desc->path, desc->uuid);
 	else
-		bt_shell_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
+		bt_shell_printf("%s%s%sDescriptor (Handle 0x%04x)\n\t%s\n\t"
+					"%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					desc->path, desc->uuid, text);
+					desc->handle, desc->path, desc->uuid,
+					text);
 }
 
 static void print_descriptor(GDBusProxy *proxy, const char *description)
@@ -1259,6 +1276,36 @@ static void service_free(void *data)
 	g_free(service);
 }
 
+static gboolean service_get_handle(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service *service = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+						&service->handle);
+
+	return TRUE;
+}
+
+static void service_set_handle(const GDBusPropertyTable *property,
+			DBusMessageIter *value, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct service *service = data;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16) {
+		g_dbus_pending_property_error(id, "org.bluez.InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &service->handle);
+
+	print_service(service, COLORED_CHG);
+
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean service_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1326,6 +1373,7 @@ static gboolean service_exist_includes(const GDBusPropertyTable *property,
 
 
 static const GDBusPropertyTable service_properties[] = {
+	{ "Handle", "q", service_get_handle, service_set_handle },
 	{ "UUID", "s", service_get_uuid },
 	{ "Primary", "b", service_get_primary },
 	{ "Includes", "ao", service_get_includes,
@@ -1493,6 +1541,35 @@ void gatt_unregister_include(DBusConnection *conn, GDBusProxy *proxy,
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static gboolean chrc_get_handle(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &chrc->handle);
+
+	return TRUE;
+}
+
+static void chrc_set_handle(const GDBusPropertyTable *property,
+			DBusMessageIter *value, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct chrc *chrc = data;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16) {
+		g_dbus_pending_property_error(id, "org.bluez.InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &chrc->handle);
+
+	print_chrc(chrc, COLORED_CHG);
+
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean chrc_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1616,6 +1693,7 @@ static gboolean chrc_notify_acquired_exists(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable chrc_properties[] = {
+	{ "Handle", "s", chrc_get_handle, chrc_set_handle, NULL },
 	{ "UUID", "s", chrc_get_uuid, NULL, NULL },
 	{ "Service", "o", chrc_get_service, NULL, NULL },
 	{ "Value", "ay", chrc_get_value, NULL, NULL },
@@ -2342,6 +2420,35 @@ static const GDBusMethodTable desc_methods[] = {
 	{ }
 };
 
+static gboolean desc_get_handle(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct desc *desc = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &desc->handle);
+
+	return TRUE;
+}
+
+static void desc_set_handle(const GDBusPropertyTable *property,
+			DBusMessageIter *value, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct desc *desc = data;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16) {
+		g_dbus_pending_property_error(id, "org.bluez.InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &desc->handle);
+
+	print_desc(desc, COLORED_CHG);
+
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean desc_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -2400,6 +2507,7 @@ static gboolean desc_get_flags(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable desc_properties[] = {
+	{ "Handle", "q", desc_get_handle, desc_set_handle, NULL },
 	{ "UUID", "s", desc_get_uuid, NULL, NULL },
 	{ "Characteristic", "o", desc_get_chrc, NULL, NULL },
 	{ "Value", "ay", desc_get_value, NULL, NULL },
-- 
2.17.2

