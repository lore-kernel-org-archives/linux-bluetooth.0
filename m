Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC08E71D2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 13:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjI2NG4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjI2NGz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 09:06:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC511A4
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 06:06:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf3f59905so1868718366b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695992811; x=1696597611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4cXG9GUHshc9MmICiDCLZeSp6wrATCb1MedDKQCIpw=;
        b=dg6jS/yF1zKlKjzLWHfTQk6aGWvIZjoeECi4sbAUaftB1cwhYwAd01dYnt6v7UTYeM
         jL337gktqoJ1Ppgg8Gq8HA/VHQjFqbzImY2GBPsjCW4em/3xcQ5BS8JOLKTkaTv5cYsF
         cGeRO8LSFedfbWh/RM4QQ1Jaf0+KxXCQLXYG8eyBG+BI0we+pl3/beEAzGYD5blVltjZ
         atAh6v2Ob7zyNyNuZL2nxUhVEE53+psvbysUj5MhtH7VMllPm80sJsKdcIivpNFXkVpa
         mMss5cZj4rmE3O9IhbrMXWGDfLlFq+f2JNykAnAnpAQumrU2yVJfbLqr8isKvIWp6U7y
         w6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992811; x=1696597611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4cXG9GUHshc9MmICiDCLZeSp6wrATCb1MedDKQCIpw=;
        b=nvGlrXy6EePRVxroseEPSNDktGTuHBmt9+Yw12TZReQJZp0VKCYHz5/OFXl+buoA1I
         1i+jnihZjVkPu2C4e1a6O1I6BT7LIY8oXHxoWSRQlsZdZQ3poamdaVVQ1EKRnXTXIdCg
         kXTSKQgDrYPdHk2hg7U9FDwZ2azKXrKXGeY04k92xd4TGeD690c6yzQCYtDkLt6/AgrB
         scMS/5BrOqkObmrkmZlQgN5A8/m2naGO57w+jCzpUA4/t+6w1QI7JGN9LYDrXiPVBQah
         Zb/PnjMpjGYbvjo44NSfLOTildPZz7Cy52Nh4o43o7qb6e8gzv/xpioh+qXmAfjofptB
         n4og==
X-Gm-Message-State: AOJu0YypQWPH2/iLkAIsF3GSYykvgXCwX0+63pBMpA4e1KAGr+Puh9ov
        x9qRXvmXEpYdLtRr+Z4gIABIpx+lH2LAVg==
X-Google-Smtp-Source: AGHT+IHrK55KuYLYKnNi0V6Trd/ecBUhsMB4rfy3bOXwK3aL+fWmb0hirZEbsd/2yGWB2Uv7dl9iNw==
X-Received: by 2002:a17:906:8a64:b0:9a1:ff2f:28f1 with SMTP id hy4-20020a1709068a6400b009a1ff2f28f1mr4193663ejc.40.1695992811486;
        Fri, 29 Sep 2023 06:06:51 -0700 (PDT)
Received: from vibhavp-vivobook.lan ([2401:4900:1c53:793f:bf1d:92a:6f4f:5e80])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b00992b2c55c67sm12422199ejb.156.2023.09.29.06.06.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:06:50 -0700 (PDT)
From:   Vibhav Pant <vibhavp@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1.
Date:   Fri, 29 Sep 2023 18:35:52 +0530
Message-ID: <20230929130622.146306-2-vibhavp@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows DBus clients to find an adapter's version and
manufacturer company code without querying the management API.
---
 src/adapter.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 8a7c53a9e..8c267d418 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -260,6 +260,7 @@ struct btd_adapter {
 
 	bdaddr_t bdaddr;		/* controller Bluetooth address */
 	uint8_t bdaddr_type;		/* address type */
+	uint8_t version;                /* controller core spec version */
 	uint32_t dev_class;		/* controller class of device */
 	char *name;			/* controller device name */
 	char *short_name;		/* controller short name */
@@ -3540,6 +3541,29 @@ static gboolean property_experimental_exists(const GDBusPropertyTable *property,
 	return !queue_isempty(adapter->exps);
 }
 
+static gboolean property_get_manufacturer(const GDBusPropertyTable *property,
+					  DBusMessageIter *iter,
+					  void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	dbus_uint16_t val = adapter->manufacturer;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &val);
+
+	return TRUE;
+}
+
+static gboolean property_get_version(const GDBusPropertyTable *property,
+				     DBusMessageIter *iter, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t val = adapter->version;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &val);
+
+	return TRUE;
+}
+
 static DBusMessage *remove_device(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -3898,6 +3922,8 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Roles", "as", property_get_roles },
 	{ "ExperimentalFeatures", "as", property_get_experimental, NULL,
 					property_experimental_exists },
+	{ "Manufacturer", "q", property_get_manufacturer },
+	{ "Version", "y", property_get_version },
 	{ }
 };
 
@@ -10164,6 +10190,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	adapter->supported_settings = btohl(rp->supported_settings);
 	adapter->current_settings = btohl(rp->current_settings);
 
+	adapter->version = rp->version;
+
 	clear_uuids(adapter);
 	clear_devices(adapter);
 
-- 
2.42.0

