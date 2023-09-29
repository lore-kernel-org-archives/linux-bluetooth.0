Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455AE71D2B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjI2NIH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjI2NIH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 09:08:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B195B7
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 06:08:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so39252355e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695992883; x=1696597683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxc4agaIOHDfdQGAhSf2b1+Pi5vZPV6mJGvc4RbSvv4=;
        b=iHmqtN3VD4fANclurlBzoVtOv7sXxS/+p49C92DWRNjbtfIlw/3qpJvlFpKHwYnwfo
         yK8e1Hc/F/g2mDfiWmUv7jwhvs/CxFrDHjyB6kaYYoXbTJAmUFnI5U3s8KGDKN4NIMSC
         zpeiW2UYPmH+x3Jyu5H+1s+A2q+KvA1BQzF5XZLkFX7ApL6U3LmipEBfd1n77iwvbNW8
         34zAtXqsWN4GI2dbWzs9QVsL42rLGL4tzjVvP6+d6oKd1rcqxD0b6m/6wUUHIrKC3Ft2
         KXL4XOoAutVnW/voo9uK5V4LuZe/csT/97s9jhGsSLqkceNWSS4wOcajJlj9F+4tu5DH
         00OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992883; x=1696597683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sxc4agaIOHDfdQGAhSf2b1+Pi5vZPV6mJGvc4RbSvv4=;
        b=JbUtTc23ZuaN85jS4cacjf3QIFdR+1NEVq56dTDyN0Ozc2t05s1PfiuKo5CUAy98Sm
         1a91DHJKtPg1b8yQgjbBRcwPamM70tLGUX1PwP0trE9ZSpRpGKOgVyWDKYNPOhHlHAZr
         hGOFRYQgBR980PdRO6dxWhuzH5JaRWNXkj/yRHFBHSGsbeR90GoHSvs7nUii1fvMVsY3
         Dy5RxM0tR6rMMm714PUc18d/E5/IYIhAXg19gy9rDI+Oa7Lqz3T1ArJgtW6CrSz7Zric
         UAJ2ya6WJN0xvFRl+u1Drw9s+xiYmEkxB1Q9Pby1vMJYWSjl5c+kXPzU/ey17mc0Aybo
         T+nw==
X-Gm-Message-State: AOJu0YxYFUMQ9qERQ7xYieIWJo2A4FCI/e9KuDYCC4ldJ2t8vau3oCCS
        aPf0vcsjD53e8Q6HjkuDiZJ13G9u0KNleQ==
X-Google-Smtp-Source: AGHT+IHLc4o8vBrhiPxdHyqb3umeeiKJrMbn9rCVVrJpZCVvczrNJRhifRm8hfnAZQT6LVOWIDRKyg==
X-Received: by 2002:a7b:ce8b:0:b0:402:98cd:a3e9 with SMTP id q11-20020a7bce8b000000b0040298cda3e9mr3887186wmj.32.1695992882014;
        Fri, 29 Sep 2023 06:08:02 -0700 (PDT)
Received: from vibhavp-vivobook.lan ([2401:4900:1c53:793f:bf1d:92a:6f4f:5e80])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c224600b00403b63e87f2sm1409099wmm.32.2023.09.29.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:08:01 -0700 (PDT)
From:   vibhavp@gmail.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ v2 1/2] adapter: Add Version and Manufacturer props to org.bluez.Adapter1.
Date:   Fri, 29 Sep 2023 18:37:24 +0530
Message-ID: <20230929130742.146571-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Vibhav Pant <vibhavp@gmail.com>

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

