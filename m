Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBADC00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 08:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiHHI0m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 04:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiHHI0k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 04:26:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2182A13E38
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 01:26:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y13so15144563ejp.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=edMOfYMdCtvC4J7YTp5fJyrkommSuPuxjJ8I4P+ayLA=;
        b=nj5/f48qEO/rM1DfEMGdZYKEBEsVLdCmGNAx1yZvOgjD8bfurkO8rmDl1g/f/zCsqU
         60yYhDWxxU+CkuC9lsaj0LV5dBdkCRyevD1n3AtRp5jnmJej3zmmRJLny3GR8zIToGbs
         WDgP4HECMwucZCcPBPwIE7y/dW4BBUl1xEqGjXfJEY3uqWrcr9D1I97qBMOQ1Lsm8bcB
         /kohG9bVVwZ1a64nnrrQaPFrxJ6XCIdhFmEd98QaHYO8zDUzstiqiHprDyZb48FBe9ph
         stxdNHkCuLeF/rA2VXPZHq0YhZug5CG2j9I6+IxC5/OtAntWDcO1Mc1GBbQtGfgBJwLy
         QEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=edMOfYMdCtvC4J7YTp5fJyrkommSuPuxjJ8I4P+ayLA=;
        b=sTZ0lGPs3i/kqGFHA8FIQLUCaYLl40wZZoSqOv7ICLbsM0MV01SHN+YiF+MByZ6JSb
         px98oiDxe202v53HKa+XYwbN9YMaVfDfYWwdeKqywg1x9mys541wGOtwnGKL5LMgJn4b
         21GANJZsnArQ4+MYrEpdUEgsQsHRFPmP+ZdH2vr3JULVMw+6brhCLooJACdvShfXmf+W
         emn2lrrIJ77o18j38L/ZqKnFMPepQNT8H1E3AUXdjQCZQ3q7LhCiHqw8t7l3551xzQb2
         m0CjwbuIc3QMLKUjocOUidnPH6pqGGU9ctJp9+BDKS2RZiae4lf+FESDyOhqjXt1R68W
         y9BA==
X-Gm-Message-State: ACgBeo0ly0SDeUc5sb6jhRSxoayKl27pd9kovMSxQHThCz8SuHdLFAx7
        AHLW2SqqlkMdRTlAUCv4wemR7lvjOWYiwHZC
X-Google-Smtp-Source: AA6agR5q5yEJo3DcXO8FTxx1Vdsoe4n7FyqQhSag9lGMIPwOiqXfEbS4z6TYc9XzvVjw6DMJ8+Gyjw==
X-Received: by 2002:a17:907:6e1e:b0:730:a923:421d with SMTP id sd30-20020a1709076e1e00b00730a923421dmr13186650ejc.118.1659947198283;
        Mon, 08 Aug 2022 01:26:38 -0700 (PDT)
Received: from cati.. (5.186.100.144.dhcp.fibianet.dk. [5.186.100.144])
        by smtp.gmail.com with ESMTPSA id ky6-20020a170907778600b007307d099ed7sm4716228ejc.121.2022.08.08.01.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 01:26:37 -0700 (PDT)
From:   Alicia Boya Garcia <ntrrgc@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alicia Boya Garcia <ntrrgc@gmail.com>
Subject: [PATCH BlueZ 1/1] client: Fix uninitialized read in attribute handle
Date:   Mon,  8 Aug 2022 10:26:25 +0200
Message-Id: <20220808082624.146995-2-ntrrgc@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808082624.146995-1-ntrrgc@gmail.com>
References: <20220808082624.146995-1-ntrrgc@gmail.com>
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
index 4c1efaf75..07a024605 100644
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
@@ -179,6 +188,7 @@ static void print_service_proxy(GDBusProxy *proxy, const char *description)
 	service.path = (char *) g_dbus_proxy_get_path(proxy);
 	service.uuid = (char *) uuid;
 	service.primary = primary;
+	service.handle = handle_from_path(service.path);
 
 	print_service(&service, description);
 }
@@ -261,6 +271,7 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 	memset(&chrc, 0, sizeof(chrc));
 	chrc.path = (char *) g_dbus_proxy_get_path(proxy);
 	chrc.uuid = (char *) uuid;
+	chrc.handle = handle_from_path(chrc.path);
 
 	print_chrc(&chrc, description);
 }
@@ -355,6 +366,7 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 	memset(&desc, 0, sizeof(desc));
 	desc.path = (char *) g_dbus_proxy_get_path(proxy);
 	desc.uuid = (char *) uuid;
+	desc.handle = handle_from_path(desc.path);
 
 	print_desc(&desc, description);
 }
-- 
2.37.1

