Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0DE20759
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 17:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DveW9sRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgEUR4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEUR4K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 13:56:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C8C061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 10:56:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s69so3453448pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MFO+E2oPIKbUN1g/6GJpK5+R9fJDP4WX5hJngZf8lr4=;
        b=DveW9sRLz/phr8VwN/gRQ3taKZclG3hRRTbbvg371FgkivwF8znzKxmfXwq6qVSI2Y
         n/+I8htDqzMKG3tCCpRI0l7MmAOwDYyMRtXa0gwwUWuKZgbUJIge/gSZX7RMl66Kw6SZ
         h0I7BwcUQfM5GbYER+e5Ua+kRpfpa10jMByjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MFO+E2oPIKbUN1g/6GJpK5+R9fJDP4WX5hJngZf8lr4=;
        b=hxi68qhq4awbzNl7QaLf45aT/zCYh3Yv8/s+2hXDc4EfJuk6P4LDEkJrDBZNVgo92n
         v+vvqJBMOehT0XuPHqqFogj8HTIQAlw60+b7a4N+5Zc93KOdS5CQjhZaF4XDDSiaidpn
         JzB5TtUYz3Wf0MhLodiVHJ9du4W9UtJJGvmk8h9838ngeBndpLNWtztvL53j9f3425NB
         8MAM5BxVflHg8hyojG7gOLe5YBTWxeKn2pFmbEUh3m0EAwsBkx/FZRQ9lVpb7B8UckT9
         jlCg0gOYZX+x8uGzRT0ypIM3P9/uuivqPhahQV9MwqoMSTh8B/y6iHdpaPWL5Sajr5WN
         EAnw==
X-Gm-Message-State: AOAM531AMbKJxMQHW9YEsIOxTYlZ/mD4MVwq7KKTv2jCHyUrz7bIHUr6
        z4Emxn/j8BO5umAz06q2rwsqfsG8T3k=
X-Google-Smtp-Source: ABdhPJyCmtWaGvUIeLgp9zWVtEzlLLaf8n8TDXIcXGs/Kl/KWj7zncfwiuW9jQKb8vs+MovAx5aWog==
X-Received: by 2002:a17:902:b187:: with SMTP id s7mr11024512plr.60.1590083768465;
        Thu, 21 May 2020 10:56:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id a16sm4881910pjs.23.2020.05.21.10.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:56:07 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Eric Caruso <ejcaruso@chromium.org>
Subject: [PATCH v2 1/3] device: Add device type property
Date:   Thu, 21 May 2020 10:55:41 -0700
Message-Id: <20200521175543.7923-1-sonnysasaka@chromium.org>
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

