Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FF4C7618B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 06:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C710204EC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 06:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="z+nTl9DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfGZGgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:36:21 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:40237 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfGZGgU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 02:36:20 -0400
Received: by mail-lf1-f41.google.com with SMTP id b17so36302362lff.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 23:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jY9cPgBVsmEXqk8TxGBdZQnZ29jPhA7QyeW9FaYgPzw=;
        b=z+nTl9DC/egyQkVgSIawIp151LFVPB0EFjGlGB5MSKAEjupSTVXUhh22U2su2SY+ed
         Ovq69iXTW1/ZU3DO7lMvYPZFqHKZsye36IAkfJFc/hOx8K9mgeHLNfqrTomfWSf86sY0
         rIlRjGMYYqO9C481zQcNM721NaJIpzLZpQ5FYCMzNsfnVRU/TZNw2QmeHTt73TeJuZ4e
         M5+aFyBfUC/wRHnsZAmMSapEE6IYdOIhbVcJK6ycxlPxhj9bVdQzauuPEp/oVbTJVSXY
         LWdXDrGtTAB/q60zp3njaPf1JpAYHAWISYfn75TpVfZYlScWBYUSD744kzz2KJv/U7QY
         8Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jY9cPgBVsmEXqk8TxGBdZQnZ29jPhA7QyeW9FaYgPzw=;
        b=SzO4/nLznKLcLJT4gDU8WE91I1iPmU5H0yjcue+qL5OoGL2nhQMpL+DE20CMm3RxKo
         IorwSWCYJbN19CQiZWu3R8JCc2rnkb2H2JzRUSp8eWTsSTet5GSosw6xcrDLbl8u3tqJ
         D4yRTVvFfcUgJQFLOO3dpOPu2+aXE3wHdo7mVPqJtO+7hEznpQyqEZWH8ewhBmRGQbNw
         09jF5nLcXg78FZndS58aC9NsU++pGK03bI8YX57tLT0AFN5Gy/+OWYLkAAyrX4nNn3wA
         5yU3JURBnz4H0jSWXn1CLJFV1SjgBf36XJl5azg8ehFiW9/BuMzrEtYzIAU9qH1a+qTw
         E4qg==
X-Gm-Message-State: APjAAAWXPf7cZRJI1L8MI4la1dPATq7tXDnNTlaCsustMZJyyqNRMPLT
        V+vr4QS9AK8bOGY/Wo5NE10+skH/T7w=
X-Google-Smtp-Source: APXvYqyw67YncRIqGfSr+s3jCfl1XVC59H+42n/AmZxZtOLAD+DS2ZSquWqTkZ+AgfMFuMkikpUn/A==
X-Received: by 2002:ac2:4891:: with SMTP id x17mr44734697lfc.60.1564122978199;
        Thu, 25 Jul 2019 23:36:18 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d15sm8039109lfq.76.2019.07.25.23.36.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 23:36:17 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 5/5] mesh: Check that config server is present in primary element
Date:   Fri, 26 Jul 2019 08:36:06 +0200
Message-Id: <20190726063606.19359-6-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
References: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This verifies that Config Server model is supported by element #0, and
is not supported by any other element.
---
 mesh/node.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 4d365156c..579e69892 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -899,6 +899,8 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 {
 	uint16_t n, features;
 	uint16_t num_ele = 0;
+	uint8_t *cfgmod_idx = NULL;
+
 	const struct l_queue_entry *ele_entry;
 
 	if (!node || !node->comp || sz < MIN_COMP_SIZE)
@@ -961,6 +963,9 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 			mod_id = mesh_model_get_model_id(
 					(const struct mesh_model *) mod);
 
+			if (mod_id == CONFIG_SRV_MODEL)
+				cfgmod_idx = &ele->idx;
+
 			if ((mod_id & VENDOR_ID_MASK) == VENDOR_ID_MASK) {
 				if (n + 2 > sz)
 					goto element_done;
@@ -1006,6 +1011,9 @@ element_done:
 	if (!num_ele)
 		return 0;
 
+	if (!cfgmod_idx || *cfgmod_idx != PRIMARY_ELE_IDX)
+		return 0;
+
 	return n;
 }
 
-- 
2.19.1

