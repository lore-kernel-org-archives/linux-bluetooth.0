Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1DC7618B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0370422BED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="e0vZ6gU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbfGYIOi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:14:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36760 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389116AbfGYIOh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 04:14:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so47148905ljj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4vWZxijFrCIkrmaihouwzhm3/yYh1xKm2hMyiO9HK/0=;
        b=e0vZ6gU7pIxoDU8+Tht5PO5LAd8Y6wr66ys9MUN8Cxt12glnXl1z+49iT83G+pblgw
         sSmCreZzUhimO9drLxcfOu2sFYGcnG0AfpxCeMvxEZmSeGxb7CjhUsVrCmJk+B5uLeUq
         rwbx6nEpuuziuZSLkK5tD2Y6Ih686PQh/457LZQEbUjs18gU/i9C/QGVxQM+2dtbPDvj
         rsKQ6PcCv5CLUpeGxvWsUbBhHQHgvq7h4vo0U7Ydm3Ibidipfw/T4sVkUSN3vw2tIjPx
         MyyeXG+WyJK9TtqdDG/11nDFAjfjED4vDx2iqhLwaiHGp9gj3gwGX+WNEB5/5vApxUkY
         78Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vWZxijFrCIkrmaihouwzhm3/yYh1xKm2hMyiO9HK/0=;
        b=OrFseFhRo4Am6Qw8e1TvGgqblzfFtCyGqe2YX2cu0d2a3CT6ozG7KiqunPGpICqLrs
         6wbCXBUOnRKGmnmQH4T6z4GsWe5w8rIAsA1e8giTgvDnk9X/9eCoBudWwHAsXurlQlNr
         B3tizBbqssv6FRxeRUD40WPO+FEBf+u1Ij/bfO8uS/3eeAtxht6qGB0w7OEjvcecuGiZ
         gqIyQJRBsVGyn2TqmJxTvb2x5B35yWOC5rcFX4J0Y0Dc0hi3X1n4daJZsko6zJR21sPx
         1iuNvmPdM/skVOtsPmBgphVwkcUchdBReSitj+c7okRB6kptVylwY9aWc6mUexHIebrj
         NArg==
X-Gm-Message-State: APjAAAVwCOpJHznpCIoNbSgQZ5pM3qJ5v9mQ573D3hoW222oPI/xxTgU
        zXC83f3R6Onq9m8u/sRpv9Oyyd9xd4c=
X-Google-Smtp-Source: APXvYqzOAiEW9hpsKdPcKFzm/cWwVp2SG0LuaP4wPKL/WXpIUysQbz1n96GEC8BbX9gfS+mA950l7g==
X-Received: by 2002:a2e:9a49:: with SMTP id k9mr44857137ljj.78.1564042475362;
        Thu, 25 Jul 2019 01:14:35 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 199sm9015251ljf.44.2019.07.25.01.14.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 01:14:34 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] mesh: Check that element indexes are consecutive
Date:   Thu, 25 Jul 2019 10:14:23 +0200
Message-Id: <20190725081424.22621-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
References: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 5a1866bea..1b58d9395 100644
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

