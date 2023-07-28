Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15246C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 04:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjG1Euw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 00:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjG1Eu2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 00:50:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72713AB9
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 21:49:50 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992dcae74e0so237846866b.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 21:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690519788; x=1691124588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pj/GqzGX2IAih0jbhznhLXDcANwV3FRZT+cStd1a3/o=;
        b=K7m3F+DK6U4pxOYM+UZha12xGAsy3cFdMd22nshh467MBV/Yjvrb+EhhusLlYoZlwn
         bJHGrTsLKelFKDPRIUTulIer7wYA/pz6VCue0NrmOtgD3z7JkOErV9uSkrhLXQWtbhb5
         hkZEyk3rurYVIsIedeW315flrI5UQo2YZyy5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690519788; x=1691124588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pj/GqzGX2IAih0jbhznhLXDcANwV3FRZT+cStd1a3/o=;
        b=dPV7FpIOLuGBFQu71sp/KhWjGqgoWIvusS/4xQoWZjR0Q99Enkj1SbjpItumjil9EA
         /sTDHe3/XOqKCWKt9E8EgYPjf20ck9zsAXMMMRZgXe7ijqNUCjMshoK+yZ+YDjdirOUO
         +vq0lswfhqEfqA6UnGpvXJfMPLAzPW+085gemWc2hTQAlSD7RvaFdcWehaAKAF083SAs
         R4bwKnANKtl+N1vCPftpBSoKzatUKQ62nk6ILClJPi8Xk4MuSaykrvL7MFfFM/3VoTDR
         +crPGyeoe/YYFjHVmNvjtv7UqO7YLy7ktvoNXc4NuC6qovqRels002NYsfMummpl0Gvo
         5Wpg==
X-Gm-Message-State: ABy/qLbhEBRFsLLh3L5D54bNpGLiOUZjCkIsLcwwIrChzEKREkDUcW7X
        dYdG/W3cCCY1VZgtpH5EWbCIbErMywdmMe1yVOs=
X-Google-Smtp-Source: APBJJlHpQLmsO62E1HDLMUQl/+4tlWslL54dhtQJUOs62oGY3gSPJLx8cQGsPNzSK1oFA+Z1Eg0M6A==
X-Received: by 2002:a17:907:a0c6:b0:99b:c985:cf7e with SMTP id hw6-20020a170907a0c600b0099bc985cf7emr1176037ejc.54.1690519788514;
        Thu, 27 Jul 2023 21:49:48 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:45e3:52d2:7d93:f842])
        by smtp.gmail.com with ESMTPSA id ov38-20020a170906fc2600b009929ab17bdfsm1554270ejb.168.2023.07.27.21.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 21:49:48 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] gatt-client: Add read-only handles to dbus
Date:   Fri, 28 Jul 2023 06:49:44 +0200
Message-Id: <20230728044944.576220-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This can be usefull when mapping names for services and characteristics
to their handle numbers.
---
 doc/gatt-api.txt  |  3 +++
 src/gatt-client.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 5042c5470..f29308aec 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -51,6 +51,7 @@ Properties	string UUID [read-only]
 			services of this service.
 
 		uint16 Handle [read-write, optional] (Server Only)
+		              [read-only] (Client Only)
 
 			Service handle. When available in the server it
 			would attempt to use to allocate into the database
@@ -291,6 +292,7 @@ Properties	string UUID [read-only]
 				"authorize"
 
 		uint16 Handle [read-write, optional] (Server Only)
+		              [read-only] (Client Only)
 
 			Characteristic handle. When available in the server it
 			would attempt to use to allocate into the database
@@ -380,6 +382,7 @@ Properties	string UUID [read-only]
 				"authorize"
 
 		uint16 Handle [read-write, optional] (Server Only)
+		              [read-only] (Client Only)
 
 			Characteristic handle. When available in the server it
 			would attempt to use to allocate into the database
diff --git a/src/gatt-client.c b/src/gatt-client.c
index a54d65e30..60a21e3f6 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -137,6 +137,17 @@ static bool uuid_cmp(const bt_uuid_t *uuid, uint16_t u16)
 	return bt_uuid_cmp(uuid, &uuid16) == 0;
 }
 
+static gboolean descriptor_get_handle(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service *desc = data;
+	uint16_t handle = desc->start_handle;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &handle);
+
+	return TRUE;
+}
+
 static gboolean descriptor_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -635,6 +646,7 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 }
 
 static const GDBusPropertyTable descriptor_properties[] = {
+	{ "Handle", "q", descriptor_get_handle },
 	{ "UUID", "s", descriptor_get_uuid },
 	{ "Characteristic", "o", descriptor_get_characteristic, },
 	{ "Value", "ay", descriptor_get_value, NULL, descriptor_value_exists },
@@ -713,6 +725,17 @@ static void unregister_descriptor(void *data)
 							GATT_DESCRIPTOR_IFACE);
 }
 
+static gboolean characteristic_get_handle(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct characteristic *chrc = data;
+	uint16_t handle = chrc->handle;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &handle);
+
+	return TRUE;
+}
+
 static gboolean characteristic_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1660,6 +1683,7 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
 }
 
 static const GDBusPropertyTable characteristic_properties[] = {
+	{ "Handle", "q", characteristic_get_handle },
 	{ "UUID", "s", characteristic_get_uuid, NULL, NULL },
 	{ "Service", "o", characteristic_get_service, NULL, NULL },
 	{ "Value", "ay", characteristic_get_value, NULL,
@@ -1821,6 +1845,17 @@ static void unregister_characteristic(void *data)
 						GATT_CHARACTERISTIC_IFACE);
 }
 
+static gboolean service_get_handle(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct service *service = data;
+	uint16_t handle = service->start_handle;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &handle);
+
+	return TRUE;
+}
+
 static gboolean service_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1884,6 +1919,7 @@ static gboolean service_get_includes(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable service_properties[] = {
+	{ "Handle", "q", service_get_handle },
 	{ "UUID", "s", service_get_uuid },
 	{ "Device", "o", service_get_device },
 	{ "Primary", "b", service_get_primary },
-- 
2.34.1

