Return-Path: <SRS0=bMpm=VU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2FDC7618B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jul 2019 10:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732BD223BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jul 2019 10:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="naHeW1DS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbfGWKGl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:06:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46021 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfGWKGh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jul 2019 06:06:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so40394311lje.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2019 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BnIf+ZgYdmO2D7WkXt5x3wzW/Af9phA5gGRMDubhoqw=;
        b=naHeW1DSFLQqMQmolwSFyGld7lRrqdjH04gIEd1gj+nUl3eEk3YxUj9kH1ueyL8G/e
         Q3JRjH1FT7aksTj637cwCx48iyJb9kPOzAAwUokBuGtH1iU/8s+eO5UOEPZCrsGZJJG7
         nR4UtryrUCHD5w26haJZj1Q/82cZ3I95gPDt5SIPMt97dS+DY29b+tjc2PEtKVqn186y
         7Guztyb44zs9oJ7d33c2cpkcNsgH4yf38/s8t98wlTowIMOyy6xJmTLDOzr9NCBVrmWW
         xPnpk/h/REjyVA0oZb3m1dxCIV4h60qhrAzSAKb0Gzw8mwmZCKfroN4oLbGd0Oz8/e09
         +F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnIf+ZgYdmO2D7WkXt5x3wzW/Af9phA5gGRMDubhoqw=;
        b=pfVAafwZqA1XD7Exz1Z/X5MhjXJBGYK6hgiL2Xp9IbgodBIMv0phigaSlOwC9qhQpF
         xxZgz8+dHgBCDrY71xrxW3v4HS/dkveIzkxTmc4Z30AxbbxRWhGdAlHZ53HUKF55yi9i
         Dn0UtlPPbkw8c4t852x2Pyu5dLt+0/7DPM+DixZB9pYldE6xJWCBfF/0zCzr4AAFIOys
         +9Zsh2wD4Hypu5yaSAfK+rSFafKVfw2iiFV5WJ21MpQPWrMwYJLEK6uZ/tXYkr1lW1Um
         ACQKH4jxYXFczJqLmjq6oQzX4K9W4vu5AJ9Et/tzrKxTfv+QFjXS+8JFPpA4ir14m4z4
         WkiQ==
X-Gm-Message-State: APjAAAXM4ET9qo7g2ZxzZvUai7jIocgY8eEs8Ph6pH6SBqWrDDFehyuG
        y0tdinnQ5XelbAYRfwhw8MI5v2FdSsk=
X-Google-Smtp-Source: APXvYqzqHx1+Mo96fOdEUliP7jHXA3LhKcxzHj4e5a5F0mut4lZGyANS31HGkM13JIF1DIKebrdS1g==
X-Received: by 2002:a2e:88d3:: with SMTP id a19mr39661174ljk.32.1563876395542;
        Tue, 23 Jul 2019 03:06:35 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h129sm6395260lfd.74.2019.07.23.03.06.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:06:34 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] mesh: Check that element indexes are consecutive
Date:   Tue, 23 Jul 2019 12:06:22 +0200
Message-Id: <20190723100623.6957-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
References: <20190723100623.6957-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch checks that application does not omit element indexes.

---
 mesh/node.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index bfb0dc5b4..8ff75c110 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -898,6 +898,7 @@ uint8_t node_friend_mode_get(struct mesh_node *node)
 uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 {
 	uint16_t n, features;
+	uint16_t num_ele = 0;
 	const struct l_queue_entry *ele_entry;
 
 	if (!node || !node->comp || sz < MIN_COMP_SIZE)
@@ -935,6 +936,11 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
 		uint8_t num_s = 0, num_v = 0;
 		uint8_t *mod_buf;
 
+		if (ele->idx != num_ele)
+			return 0;
+
+		num_ele++;
+
 		/* At least fit location and zeros for number of models */
 		if ((n + 4) > sz)
 			return n;
@@ -997,6 +1003,9 @@ element_done:
 
 	}
 
+	if (!num_ele)
+		return 0;
+
 	return n;
 }
 
-- 
2.19.1

