Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6DEC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGYIrU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGYIql (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:46:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D29F4214
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so871777866b.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274697; x=1690879497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj/GqzGX2IAih0jbhznhLXDcANwV3FRZT+cStd1a3/o=;
        b=rsCGCj70CF289K3uXYWqWvnYVXb597zi4h+6s4vzo+SCELqK1eZ+uTCaQ5yI7cv+R9
         3KEJmSzkRMr1TmGd3+eChfYcp9NNlO72W1gO5oYv8gLtPRtsuO5s81FbZcfvrsdN4FOk
         uxrc9egPS8OwNpXrr1OU/ks4I00whIU3hPbO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274697; x=1690879497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj/GqzGX2IAih0jbhznhLXDcANwV3FRZT+cStd1a3/o=;
        b=DW1LZWduk0wPcKpHynZdqEm5wwjyAvODGCnp3Xg7TU6XUQcapCEaxK6YsYMkbeSbl1
         pmWsdhyPGd8JAisipZP7zCVztS99NxsbWijsuw9UEpJCo/LAa9OqxKtKyBQIzuf9Nw0P
         1eggqt9BIyBfu0Pd4Vd4YpQLqIMUpKvOqmqQTZH8v7O1AGLEPH2XPJHKl+qRGaWS9DRW
         5zfeXgsqzBv//y+ezF3FqDwnivPNewtBScuegqLB8D/fjt9ZE0G9vE+kjZwVkkE2c7/j
         przomk/a45dlLnkP6dX/v3xIIvDmoclzdyoOg2TfC2MG2V6RjlrUsG/JGEF/+ew5b6BB
         tbMQ==
X-Gm-Message-State: ABy/qLYce1YtL/CCiWB88muf32Mt4n5TgxkQ2S3yV0KbEKmm8NQx02Mr
        t+kazDAujPmRU06eSVhsec05mg/fD1ms3LArJow=
X-Google-Smtp-Source: APBJJlHZoEkpltNz80tQB3p8GfkuV1jdb7ipHZCpiY0YzxpKy6EchlqlddwQjefc2nhMeFGm61BDyA==
X-Received: by 2002:a17:907:7616:b0:965:9602:1f07 with SMTP id jx22-20020a170907761600b0096596021f07mr10907773ejc.39.1690274696964;
        Tue, 25 Jul 2023 01:44:56 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:56 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 7/8] gatt-client: Add read-only handles to dbus
Date:   Tue, 25 Jul 2023 10:44:30 +0200
Message-Id: <20230725084431.640332-8-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
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

