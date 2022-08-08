Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190FDC00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 09:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiHHJWR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbiHHJWQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 05:22:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53542193
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 02:22:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so15491436ejp.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/V9PzHPywRqV11gvt1yEKFWTlH+qvv+ddvqhh1Jl440=;
        b=evp5AX6gaKoWlVPkfCHTji4xKCxm/c1jBAn6VzEW/hEwhMYHg3k0dN3sKkg41vIA9m
         RpicytIX5VoSbWck7dFsNAptyKJg4m4KlMNNMvVGNWLcFdp3kZmSPuq8mQ9Na148llk1
         fbYtKc4zwqcviBMWhLJg8YDrYJU4av7CqinWS4c1yuIs2DJ12JMEY93FUpJn9YBYZba0
         6oazjT3t6DKcnovi+oBCAY+TXwIhu9weO9YHgjqWXOUZcJMRuMNS3Uk0dyfoBND65lsC
         adhcnoVUn6N9peby/ztaGcQNkVr8CzL/vjuXCl43lI0TSmM+uwdZ7ybzhpcIz3T10p5z
         pdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/V9PzHPywRqV11gvt1yEKFWTlH+qvv+ddvqhh1Jl440=;
        b=2YKjUCuGnyXeBIXB+3VA0EPUXIWvVqGBmJp68rA49asyaI2lwjSo2nHYI7JGAHJ1/Y
         W3Yn1sYiAJfy7YPC7rfl/OeowiswaSWbGNhfUPNkXhX0MaL0h9QCgSuD8/+gfQpsBKD2
         p+SQSc0rtaT7ibmtT4VSmevZUqQoxJ/oREPOANFwTwMSP0r887hpRBT31sw8tnKjpwdx
         BlLzDQCk+xaY82Fq5tf72dOve/Q8ZZzTD9mYKeS5KRYAiMExVNcvmSf5S4a9eFbOh5UL
         CRGx9l+dDopelMxbdOPdatJmknTnp87Dhf7EI45tXCIxqP/QP7BH5Jr9WtScM04c2Qko
         v6RA==
X-Gm-Message-State: ACgBeo22dxRoXOrRuxevxMEfkq2EMR8JVlEzpxuFpFvcNW+dcO/YlktW
        ViyiVy5vopdX1FCGtazpaQDCPjN0NKwkZTWt
X-Google-Smtp-Source: AA6agR7X/PcQenRSDuGyDk24Apy8K3zsTFqe70S2gVMrzes21ZdhH5u58IKlctNx5yjegQbvi97XsA==
X-Received: by 2002:a17:907:6e17:b0:731:2426:f606 with SMTP id sd23-20020a1709076e1700b007312426f606mr7125365ejc.162.1659950534086;
        Mon, 08 Aug 2022 02:22:14 -0700 (PDT)
Received: from cati.. (5.186.100.144.dhcp.fibianet.dk. [5.186.100.144])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170907819400b00730cc173c6asm4732856ejc.43.2022.08.08.02.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 02:22:13 -0700 (PDT)
From:   Alicia Boya Garcia <ntrrgc@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alicia Boya Garcia <ntrrgc@gmail.com>
Subject: [PATCH BlueZ] client: Fix uninitialized read in attribute handle
Date:   Mon,  8 Aug 2022 11:22:07 +0200
Message-Id: <20220808092206.153221-1-ntrrgc@gmail.com>
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
 client/gatt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 4c1efaf75..aaad786b2 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -158,6 +158,16 @@ static void print_inc_service(struct service *service, const char *description)
 					service->uuid, text);
 }
 
+static uint16_t handle_from_path(const char *path)
+{
+	const char *number = path + strlen(path) - 4;
+
+	if (number < path)
+		return 0;
+
+	return (uint16_t) strtol(number, NULL, 16);
+}
+
 static void print_service_proxy(GDBusProxy *proxy, const char *description)
 {
 	struct service service;
@@ -179,6 +189,7 @@ static void print_service_proxy(GDBusProxy *proxy, const char *description)
 	service.path = (char *) g_dbus_proxy_get_path(proxy);
 	service.uuid = (char *) uuid;
 	service.primary = primary;
+	service.handle = handle_from_path(service.path);
 
 	print_service(&service, description);
 }
@@ -261,6 +272,7 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 	memset(&chrc, 0, sizeof(chrc));
 	chrc.path = (char *) g_dbus_proxy_get_path(proxy);
 	chrc.uuid = (char *) uuid;
+	chrc.handle = handle_from_path(chrc.path);
 
 	print_chrc(&chrc, description);
 }
@@ -355,6 +367,7 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 	memset(&desc, 0, sizeof(desc));
 	desc.path = (char *) g_dbus_proxy_get_path(proxy);
 	desc.uuid = (char *) uuid;
+	desc.handle = handle_from_path(desc.path);
 
 	print_desc(&desc, description);
 }
-- 
2.37.1

