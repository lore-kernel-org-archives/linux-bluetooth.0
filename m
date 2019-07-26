Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3915CC7618F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 04:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1197721951
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 04:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="lf+9Q60m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGZEaw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 00:30:52 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:46512 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfGZEaw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 00:30:52 -0400
Received: by mail-lf1-f48.google.com with SMTP id z15so31834632lfh.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 21:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PTFzoPOLDPs2mblMT1MJJ9hLSqUVRizwjGmTKckHTNE=;
        b=lf+9Q60mFb3ob3foKGzHao2qCXIln7YMAdTlEHUfefwml9QleSAenBkyv9SsuRtpv6
         h20B9NTIA2LJQvYupmpiTwlluFbY5RCGiMjqx5lsDgn4siRYp54827d7VjiSXY3hbM1o
         I/fdrJswdZLehpZ/E2G9mEDXqY+Clti0LDw0ZYu/RPy1VNYfAMUTHigQAhSevfcvgcJC
         M2lxTsnSQlQ/CdW52S9ylM0ETAqOcwL7UnHRcXbRggk0h0MBsF/iUrFBF2GIobqNZ6HZ
         BUk+Vwyog+XfXdnpWT81vCYABElF/pbfwW7R99IJUaJS6MasK0j0N16BTKZsP9J6s5M4
         QFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTFzoPOLDPs2mblMT1MJJ9hLSqUVRizwjGmTKckHTNE=;
        b=ZFslQbtU/BSKtII3UL/USruM7pTnUcrwLQxCiXXY6o0oF3u3pgUSmW80YBClPlTw29
         McEC6RCeZTWmcUad8agShNA7diPxPenkvA80QhhHBRdu1bynMJ/wJXJgsD/JJe2KN4ZM
         Z1HByrWsthHuq/DxevMhSXiVEHv+2gByWDKvTrE0mDzCpt6tITq5ia2gXomDb9j7qR6X
         dFbbRWZ8Cj2yP8l2PBK9c0CX2WOfK2RM9AxnPrg0yqMiLGq6XGI9/FLgjQA8pY/OAtkt
         4ZZaD6PlRL5pYnJ3gmnQ7/5ATLR/v3AH5g9tz+pYprzfDEvmgkhAKSHDR1bnFB3SqOXQ
         X2Eg==
X-Gm-Message-State: APjAAAVnUOJJgBq6PRNEoVd27qKKXNQPx9UoTzNkQGTArjYhog25zNog
        MFpdy3W+S8UzLOiWtUQRyBCM74aiFBw=
X-Google-Smtp-Source: APXvYqwJHaejwSTCMOcsj+sfdhjvmKM61WoXDvmyVa7DsxNaif6fIgSdwZYdJ3d6htquAR2YCamTdw==
X-Received: by 2002:ac2:5609:: with SMTP id v9mr41163802lfd.27.1564115450157;
        Thu, 25 Jul 2019 21:30:50 -0700 (PDT)
Received: from kynes.internet.domowy (apn-95-40-32-72.dynamic.gprs.plus.pl. [95.40.32.72])
        by smtp.gmail.com with ESMTPSA id g5sm9792735ljj.69.2019.07.25.21.30.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 21:30:49 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 5/5] mesh: Check that config server is present in primary element
Date:   Fri, 26 Jul 2019 06:30:35 +0200
Message-Id: <20190726043035.9417-6-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726043035.9417-1-michal.lowas-rzechonek@silvair.com>
References: <20190726043035.9417-1-michal.lowas-rzechonek@silvair.com>
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
index f937fe361..e0f1bbde2 100644
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
2.22.0

