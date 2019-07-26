Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CDEC76194
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 06:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D67A218DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 06:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="HN+H/IuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfGZGgT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:36:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44031 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfGZGgT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 02:36:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so36277053lfm.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 23:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=o97sqGkDAEwhjEYoCU+oHuhePt458+zyh1IQTY8CTZM=;
        b=HN+H/IuEoMJwUeMd1K6rAItn7sYVCx7Nat+PRyQLR6LXyL5YhNbRjJaOAa/B23k+hg
         1I3AWr1T+Q0pph3neWQH1pdeAABYhWaB+xlLhNVvbvq+dN5kTd6DfZqWNi6X7rl4vd+J
         uRSlEJFclr5dvwOs3KKBrWj/YyBhnZG2KrC4K5O6vyQJI3H8eC7nvEQ5m/UW5INuXR3J
         wLuGtftsSnyGjaozxz22w6pwwT/4v5sKeJG+bLwDWaeolmnCcqXeGGnvh/dkIdf2mtMj
         BXnJLo3TyXEh7ntBee7kt+EJGSR+TPDoKU2wSb9TR/0Ga7WM/6kf7XkUWqP47yrX5fNk
         +Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o97sqGkDAEwhjEYoCU+oHuhePt458+zyh1IQTY8CTZM=;
        b=I3m+vX4/eEPXcF7pzB2U5d+IwNl3lfDOaflnr04nA4i/kanBuZB75TzaGQmrH+PcLS
         ISeidiB10v1IjuEeaskxpvRekoKYamAMSKEBlZ7mpy7JE1PeDJYKeeVcVxXmJX1e9twb
         9+u4yykaGqrEMtW2rVVq0fTFt9nohwxwicn/5EF5pFMy4i7HqZ9q/DKxFgVWWn+93Ohh
         7msU4bpeeqkKzeDHlb3rI+ghUFf/YsIgynLRjAY2ZHvB4wTf+YTnHL6S0sIdj1jDYTwY
         yY70mu9RNOHxDYk+FkE0YtxkduYcWtBkSeo/71r1cXSEH+UWjjPrdvqCcQzkaHJu+3q4
         8Eqw==
X-Gm-Message-State: APjAAAV/K/xRELCC7aIctNlEnn7jw338iIZbA4ZVWnrT3dHaVw/9GV1s
        mPejr4ven4tVQv5GgSHMbvCspAH3Y0s=
X-Google-Smtp-Source: APXvYqxfsAxpHpLRoIcvyHzVRIj144IktguprVjPSEm+3rS5J0O+VIC4LOQ2QSA5zNnjsebkRGTOLg==
X-Received: by 2002:ac2:418f:: with SMTP id z15mr41250631lfh.177.1564122977296;
        Thu, 25 Jul 2019 23:36:17 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id d15sm8039109lfq.76.2019.07.25.23.36.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 23:36:16 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 4/5] mesh: Check that element indexes are consecutive
Date:   Fri, 26 Jul 2019 08:36:05 +0200
Message-Id: <20190726063606.19359-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
References: <20190726063606.19359-1-michal.lowas-rzechonek@silvair.com>
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
index 5eb2e6665..4d365156c 100644
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

