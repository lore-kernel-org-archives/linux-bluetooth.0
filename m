Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCADC169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEAF20881
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 12:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqxG/yoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfA2MEM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:04:12 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:38594 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbfA2LnL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:11 -0500
Received: by mail-ed1-f48.google.com with SMTP id h50so15697589ede.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 03:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=uCrgjMZdblQN0jE4WyGEMLbxT2ooDpygwgVxa5jsAlw=;
        b=MqxG/yoexkmsZFjYFH1Hma07gE6m0wEI8+mXh5JPRsG1EP+xNj72qrEu49+xcZNol1
         4v8+TbXGafhamAmcr0x0JKSkDPqZlGs9YA2Bl4LgOIsKrsqqlgH5ohJELkevdeU9f+Mx
         a9FeN6k4AiHheC35cFv15x/hLpFvkJbTf3FSc49eBQrnQ9rFTQTKb3iv5b0Z9+RHU65K
         oD5wJH11FzmmdarbOLbzlp0XlBvtb1N4d+s23MK0oMCr414htcT4J9AXzAJzITOLlbnZ
         zD2bxuy221xUEUMZUik+5Z29g9Ocxi4OPcrKDq1TbvlXV9bPf4ZZ82f6vULD5VKmwLvh
         xYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=uCrgjMZdblQN0jE4WyGEMLbxT2ooDpygwgVxa5jsAlw=;
        b=dNo6mCd9MSofuYQeFzpsv//3zqW1es+AYT+vnyPpWAMvWhAVItrsXQ2UmsXtywdkha
         A91x9Y6A/izhdRWEg+TNt7lSSWDPDuVCFh4CRtpx3Grol+cWeMhzN0nuh2cZz6SLJPmr
         cjf4PhlE7J2sY03nSxnJ+HolTDuLsOgttU4hD1K+5xrrvx2RKgqo3Apa74m19oQmX9qO
         DM/2q0CguTvKIFF+f4ANVw8f4laVJAl04IhCKTgpP+Zf1HkqAhpA/VJOEaO50AL2M9hb
         zpcg4XwVfabKgI7AiYn+Uzye7QeZL/oEouYY2d8jV8rS8714K5x581O50l11Dfhzqxa9
         NjNQ==
X-Gm-Message-State: AJcUukeba4H530ANM9byftE6vczN1EAXNBUio7muhfCM6wwN8DfAGzsb
        VbX6kUJ29A5/qaF8WBeRj7adAE42
X-Google-Smtp-Source: ALg8bN6RGPNQvPxA0OIHdGl/yfiz/mDeQgSQAGUzaLwHMbZbsBaERmEnZLAzh1i8LHGGvcjpJ26O1g==
X-Received: by 2002:a50:aa9b:: with SMTP id q27mr25130267edc.93.1548762188172;
        Tue, 29 Jan 2019 03:43:08 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id d56sm14675692ede.76.2019.01.29.03.43.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 03:43:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] client: Enable Handle property for GATT attributes
Date:   Tue, 29 Jan 2019 13:42:57 +0200
Message-Id: <20190129114258.20945-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129114258.20945-1-luiz.dentz@gmail.com>
References: <20190129114258.20945-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable bluetoothd to write back the actual value of attribute
handles.
---
 client/gatt.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index b6b517bdf..0137aa9e5 100644
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
@@ -1259,6 +1262,34 @@ static void service_free(void *data)
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
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean service_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1326,6 +1357,7 @@ static gboolean service_exist_includes(const GDBusPropertyTable *property,
 
 
 static const GDBusPropertyTable service_properties[] = {
+	{ "Handle", "q", service_get_handle, service_set_handle },
 	{ "UUID", "s", service_get_uuid },
 	{ "Primary", "b", service_get_primary },
 	{ "Includes", "ao", service_get_includes,
@@ -1493,6 +1525,33 @@ void gatt_unregister_include(DBusConnection *conn, GDBusProxy *proxy,
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
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean chrc_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1616,6 +1675,7 @@ static gboolean chrc_notify_acquired_exists(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable chrc_properties[] = {
+	{ "Handle", "s", chrc_get_handle, chrc_set_handle, NULL },
 	{ "UUID", "s", chrc_get_uuid, NULL, NULL },
 	{ "Service", "o", chrc_get_service, NULL, NULL },
 	{ "Value", "ay", chrc_get_value, NULL, NULL },
@@ -2342,6 +2402,33 @@ static const GDBusMethodTable desc_methods[] = {
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
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean desc_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -2400,6 +2487,7 @@ static gboolean desc_get_flags(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable desc_properties[] = {
+	{ "Handle", "q", desc_get_handle, desc_set_handle, NULL },
 	{ "UUID", "s", desc_get_uuid, NULL, NULL },
 	{ "Characteristic", "o", desc_get_chrc, NULL, NULL },
 	{ "Value", "ay", desc_get_value, NULL, NULL },
-- 
2.17.2

