Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A81C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 23:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607172072A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 23:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="hYiKRVOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgAGXFO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:05:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37327 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgAGXFO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 18:05:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so988571lfc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 15:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lG/GaTIK/OKRxoPQJkSOMPYLJXzFj86o8TkaS6IM3mo=;
        b=hYiKRVOaM8WCym5sEN/UIzHTnDVVRHwOOj9GRJMJx99PZVV76Yc2GNww6U921iztxv
         JZTYP29Ogf2l70aHLhNJFrzWxrIt+g4vaIcXVgqOeMBLwRmS4nIdhDnHXltKHthurMGQ
         qZwUR5XEjM4xplVDS9X01+FhgqzWINh0EEM22pGjFMzRa+Frsh6ZRPpJqz88RmUTNHLF
         blcM4Vn4viShpdxqftrnqBijqeV6mHoAMKrAMsyg4mV249dHbrvTH7bHiAMacDkZ88QC
         2yDSdlvkd1bMRf6r/SwciUHrQdJMUYXtR8UIktqHXcq7puVKsVJ1CrklzyqKArCpeADH
         81mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lG/GaTIK/OKRxoPQJkSOMPYLJXzFj86o8TkaS6IM3mo=;
        b=NSWUidEESnHmIhzc1BdDUlbfk/Ph0mRGjML+wGhWyAIrRtpgzZOOdpwA6cJgcO7ouJ
         IR9z0aEOfaZ4mBK3YtO/5yBYyJdeesPMhuPiqlVpUkyC55541p7BdXbOOmVirPSEpzVS
         xnHXPuXQYh+tYUTnWb2UUT/56NDnh6k19B4ASk61BnxZ8Sr11rHFXSNKAKbj57cWcqbu
         qMyBLi6MWkgt9YcMvcBptiq4JWk1KBe9GcZ0q9mH/P6+Yd11Dz56v3K7lzjioSl4T9Rh
         eQnPTTOfZM1oEQEDNLNBwa2eZnJWfmXWtW8h2of78tk+QU45SRm6WUFD4YaFRmgrP08P
         3r+g==
X-Gm-Message-State: APjAAAV3MnwafENOvlRVLmJQO6VerrLZ/p84U6sD2pJsVc8NPRbQea/v
        KlxQRW/duIdpQ0tiAD0V3LKAXPXXhcs=
X-Google-Smtp-Source: APXvYqyWBazC9b2Dlr/Aa/K2FfozMSerOIq0GYY+FwVRbvDHwqTwo+rG8ZRqNwFhbS38a/6dZ66BSw==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr1001449lfp.162.1578438312242;
        Tue, 07 Jan 2020 15:05:12 -0800 (PST)
Received: from kynes.internet.domowy (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id e9sm385136ljp.75.2020.01.07.15.05.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:05:11 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix node reset
Date:   Wed,  8 Jan 2020 00:05:05 +0100
Message-Id: <20200107230505.8087-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of stopping the daemon, just remove the node.

---
 mesh/cfgmod-server.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 8acde95b9..bb43f01a0 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -740,9 +740,11 @@ static int hb_subscription_set(struct mesh_net *net, uint16_t src,
 
 static void node_reset(struct l_timeout *timeout, void *user_data)
 {
+	struct mesh_node *node = user_data;
+
 	l_debug("Node Reset");
 	l_timeout_remove(timeout);
-	l_main_quit();
+	node_remove(node);
 }
 
 static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
@@ -1265,7 +1267,11 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 
 	case OP_NODE_RESET:
 		n = mesh_model_opcode_set(OP_NODE_RESET_STATUS, msg);
-		l_timeout_create(1, node_reset, net, NULL);
+		/*
+		 * delay node removal to give it a chance to send back the
+		 * status
+		 */
+		l_timeout_create(1, node_reset, node, NULL);
 		break;
 	}
 
-- 
2.23.0

