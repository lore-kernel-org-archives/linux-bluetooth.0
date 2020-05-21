Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D77C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A15207FB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P4TQsLj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgEUSBX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgEUSBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 14:01:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3997C061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:01:22 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a13so3141945pls.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MFO+E2oPIKbUN1g/6GJpK5+R9fJDP4WX5hJngZf8lr4=;
        b=P4TQsLj135jzfjxhtahY1DB3XLGHr3C8lrmyWCh7QkvdL4d++UF0DJr3tzlhHznGId
         gdPPqX3/K8VFNVJsOVX9uOMfR6J8X2BIDjVdXDDGItkkBJxiBJMIE9O/+bmGUhhhFje9
         7YQ7NDW+6DAxS8F2l0f0Bl9exHUtqiZUgLBd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MFO+E2oPIKbUN1g/6GJpK5+R9fJDP4WX5hJngZf8lr4=;
        b=dRe8bb1HC17IEl1VkJ8hwkuzx4/JCU23rLNO0uo5VcUh1icnSrXWZSKlkHLdojz0hz
         GkenWyL50YBT65tlqNn7LdYT1x6nssyqKLRfACe8Eh3DxrvbVrovyo6sG6p6sHmlrre2
         SaU7RC4m8WW4JokHylNOutbFoXrwbY3tamUXtmb7u/J/7qt7Y4BENil1pWhHTVjx8bvU
         KS/MhlaiNb9EiEd1lec5wGs5huqo8bDtGGuF6+0CX2Txo+NUPQbTqe6nXje4t/Iuaqv0
         YGjLSf4efsIjpB1HrB9E0BLRYKaL+MeIuKMessm1xZvO0yQCwR4Vz46Ihdmfh4AmluI3
         sXAQ==
X-Gm-Message-State: AOAM5328naDDJrTNLIQI9+IJfTpBZOrmDdJKQOiR+qQDAjrdyIp27Z2Z
        rEMEhfy2ZC9ihOaaKJtB9MGyfBWyQOw=
X-Google-Smtp-Source: ABdhPJwMVhLMtUqunRLnVo18ls/dW2cdYfdW16jnj4Ws6y9qS/CytKjlpv0g9KL1bZ077ZLLImKcug==
X-Received: by 2002:a17:902:7281:: with SMTP id d1mr11172693pll.78.1590084081233;
        Thu, 21 May 2020 11:01:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id h4sm4845975pfo.3.2020.05.21.11.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:01:20 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Eric Caruso <ejcaruso@chromium.org>
Subject: [PATCH v3 1/3] device: Add device type property
Date:   Thu, 21 May 2020 11:00:59 -0700
Message-Id: <20200521180101.8223-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Eric Caruso <ejcaruso@chromium.org>

This allows us to gather information about whether a device
supports BR/EDR, BLE, or both. It appears as DBus Property
"Types" on the org.bluez.Device1 interface.
---
 src/device.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/device.c b/src/device.c
index 7b0eb256e..2b5a7f2e8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -745,6 +745,32 @@ static gboolean property_get_address_type(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_types(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *type;
+
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	if (device->bredr) {
+		type = "bredr";
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &type);
+	}
+
+	if (device->le) {
+		type = "le";
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &type);
+	}
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_name(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -2759,6 +2785,7 @@ static const GDBusMethodTable device_methods[] = {
 static const GDBusPropertyTable device_properties[] = {
 	{ "Address", "s", dev_property_get_address },
 	{ "AddressType", "s", property_get_address_type },
+	{ "Types", "as", dev_property_get_types, NULL, NULL },
 	{ "Name", "s", dev_property_get_name, NULL, dev_property_exists_name },
 	{ "Alias", "s", dev_property_get_alias, dev_property_set_alias },
 	{ "Class", "u", dev_property_get_class, NULL,
-- 
2.17.1

