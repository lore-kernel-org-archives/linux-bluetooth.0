Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E39C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C993220692
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="NsxXtAuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgAHVvX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:51:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39470 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHVvX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:51:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id l2so4935550lja.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tNNFzFVP8WoF7LYFXiLMzWOGMHkZ6icR0XJY9urVvkA=;
        b=NsxXtAuVeXzOMR1bF58oVWkbRyvduLtaTExtQlDTqeu6OhqaUuFXtDx623tYg9ZjiM
         I5/ib+XnWwppD91/c+H61ANddeJKOHjD74aeL//jkDJSv/l7vVx99WdXzeuNnykhFcZw
         vkbLAyU6nRkiBi7aEbP+k6bSVS78ksqtZtt2oOyFVGXP0Bxzqnh3FXYPWzoyC7IUVMDb
         SNp87vwTgKVVzdHWAeEkGpVF2mIf/0yW1orcG5EHS0mUVhlU8Q3f4/n/BGgC2yF7JMFB
         EeBpkyAVYvAv+fYvFoBv4PQJ1tuao+1Kzd9Pf/pFivrJTuhzaHl0tM5Vi5ZNgYes3tV4
         NGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tNNFzFVP8WoF7LYFXiLMzWOGMHkZ6icR0XJY9urVvkA=;
        b=MXR3HQ+4mcwMRtbxm8ekAVTlaPH5ahOaiTqp/NO8LPX1nfiotIQoDmN5NF75x74yJl
         UmsS7WRsXnnf+cA37XrvEaCri4dB1NAkmlsTaK6RtRX6CaIs3+Qij10Pi1tciPFchdfF
         e5vxmPqNeoGDfBAN29ZpbWYhDvlAl5h5TjdVCFwGTUQfOzpnPgtzTVa3YqHGPAl0YRQJ
         psPwzo0Dlpq62wT3VUQVSETg+KPkl9LR0Nn2DGvT3jwpdJq6tpcJ3HnLcIUzMTv1RFEC
         NATnGG6aqNARkS9XhYdCU0ZQzAhA92qVmv1O8HBvdcw7a+YHbAOASV926Kid+sxLpwnU
         goyQ==
X-Gm-Message-State: APjAAAWbkarDNbRxuohOel/yv5QZkgiNf+OzhWv03KUdPT4JH0NlOYWu
        rFEsV7oUrOfkXocJr5izrIItpz7bDNo=
X-Google-Smtp-Source: APXvYqx9fUMX7qcsHNhYXgR/CHvE1HimdbkTcoUB/5AsIzxsTxDFJDNDw2trAjfLSee7ypaYT3ZWiA==
X-Received: by 2002:a2e:8646:: with SMTP id i6mr4187483ljj.122.1578520280658;
        Wed, 08 Jan 2020 13:51:20 -0800 (PST)
Received: from kynes.internet.domowy (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id k5sm2001037lfd.86.2020.01.08.13.51.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:51:19 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix BeaconFlags property type
Date:   Wed,  8 Jan 2020 22:51:14 +0100
Message-Id: <20200108215114.10555-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This property is an uint8, not a boolean.

---
 mesh/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/node.c b/mesh/node.c
index 032216774..13d4d3418 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -2358,7 +2358,7 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 	l_dbus_interface_property(iface, "Features", 0, "a{sv}", features_getter,
 									NULL);
 	l_dbus_interface_property(iface, "Beacon", 0, "b", beacon_getter, NULL);
-	l_dbus_interface_property(iface, "BeaconFlags", 0, "b",
+	l_dbus_interface_property(iface, "BeaconFlags", 0, "y",
 						beaconflags_getter, NULL);
 	l_dbus_interface_property(iface, "IvIndex", 0, "u", ivindex_getter,
 									NULL);
-- 
2.23.0

