Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30914C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Aug 2022 19:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiHGTUl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Aug 2022 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiHGTUk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Aug 2022 15:20:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42010EB1
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Aug 2022 12:20:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f22so9025454edc.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Aug 2022 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=T29rPU2g6z6jMw1hF0iao34JCtGnL9boIFn0X+u5O5k=;
        b=pMUhwikt3Vys0Ae3p+4LpgUvvqJzPFReLV9u4P3pgcKj5vA/NYz1NpBD5lCH4PO01s
         282ySXHNWIXbVvG5AKrWcQcXTec/VtYghKYeCau+vwt0NpE3ZkY+KA3+aKgdfAoST0m+
         RI7XmJ6QSRqT6aX/I9xfWBEnuFUiJXk+DQS5b20l5ejFeNtShqoD1qgLYaQ0XNARyZzE
         O1C5XO/Q+jNWTOrYbERw6/lGr3wa4245F4j1RT+1VxaY8iTkNmks5MB8elTu7JqYXibR
         R/rqbEKmJcBs9MMhHqtJGnP9p4KY9RFH1eLSCk2xq927m9v25er6/ZjKq7S/UsnwHnuZ
         /+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=T29rPU2g6z6jMw1hF0iao34JCtGnL9boIFn0X+u5O5k=;
        b=NiNLYOyEt7MyvfiC3NPe3XcfjGjQsPqiV3s/KdI0zvAYMvgTMYQctgUgMD9D4e96Ou
         Zf9YEkLY8sHeZ2dl7h+N3HWwBpWh+09bIK5Ke/LZthmALntBGGjRHX0iCoLQw+aGfmW0
         ommR4SGctHC0v7E2j1vxBL+bxwyDFI4KyTzqZVMi3yX2EK9PP1MIThh88lO15i2wrkWZ
         YqSbHeHMtm9E7ssfLfRv6B6CVVl7pZ54jJIViViFMl+tdlDTSqoTadk3jcpKNknIJbV3
         7HNBElZiKCbdvejSmY3M8A+4aTPdF7wLTQlDQR8EbOPyzEpMG1izw4q+B/qgxRTHMYjS
         T2MQ==
X-Gm-Message-State: ACgBeo1mP3sQ66cPhzNF/vy5xU3ZlxZP02b8WLuZJmwTAhplIKKRKcxS
        gUIH2GpTUeOo+LPvuLaQ7BE4P2PkkA2rDXqN
X-Google-Smtp-Source: AA6agR7BkZCASAfIoUJDa+Z3DkFDdp4O/M47mycKQwceoamXU5waerqr5U9V0fO5jVLfaMkz5AC6Jw==
X-Received: by 2002:a05:6402:2714:b0:43d:ca4f:d2a2 with SMTP id y20-20020a056402271400b0043dca4fd2a2mr15683024edd.185.1659900035515;
        Sun, 07 Aug 2022 12:20:35 -0700 (PDT)
Received: from cati.. (5.186.100.144.dhcp.fibianet.dk. [5.186.100.144])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090630ca00b00730bbd81646sm4082890ejb.87.2022.08.07.12.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 12:20:34 -0700 (PDT)
From:   Alicia Boya Garcia <ntrrgc@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alicia Boya Garcia <ntrrgc@gmail.com>
Subject: [PATCH BlueZ] client: Fix uninitialized read in attribute handle
Date:   Sun,  7 Aug 2022 21:20:14 +0200
Message-Id: <20220807192013.74195-1-ntrrgc@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When services, characteristics and descriptors were parsed from DBus
proxies the client code was calling the print code without initializing
the `handle` field, which the print functions use.

This resulted in semi-random or zero handles in all attributes when
using gatt.list-attributes in bluetoothctl, depending on compilation
flags.

This patch fixes the problem by parsing the handle from the DBus proxy
path.
---
 client/gatt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 21fd38ecf..4c074706c 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -158,6 +158,15 @@ static void print_inc_service(struct service *service, const char *description)
 					service->uuid, text);
 }
 
+static uint16_t handle_from_path(const char *path)
+{
+	const char *number = path + strlen(path) - 4;
+	if (number < path)
+		return 0;
+
+	return (uint16_t) strtol(number, NULL, 16);
+}
+
 static void print_service_proxy(GDBusProxy *proxy, const char *description)
 {
 	struct service service;
@@ -178,6 +187,7 @@ static void print_service_proxy(GDBusProxy *proxy, const char *description)
 	service.path = (char *) g_dbus_proxy_get_path(proxy);
 	service.uuid = (char *) uuid;
 	service.primary = primary;
+	service.handle = handle_from_path(service.path);
 
 	print_service(&service, description);
 }
@@ -259,6 +269,7 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 
 	chrc.path = (char *) g_dbus_proxy_get_path(proxy);
 	chrc.uuid = (char *) uuid;
+	chrc.handle = handle_from_path(chrc.path);
 
 	print_chrc(&chrc, description);
 }
@@ -352,6 +363,7 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 
 	desc.path = (char *) g_dbus_proxy_get_path(proxy);
 	desc.uuid = (char *) uuid;
+	desc.handle = handle_from_path(desc.path);
 
 	print_desc(&desc, description);
 }
-- 
2.37.1

