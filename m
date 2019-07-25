Return-Path: <SRS0=LIv6=VW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB4AC76194
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8169422BED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jul 2019 08:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ND5FzI8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbfGYIOi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:14:38 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:32784 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbfGYIOi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 04:14:38 -0400
Received: by mail-lj1-f178.google.com with SMTP id h10so47142303ljg.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2019 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vt87WHBQva0gCRcE7qsjoztNx6zM5sPwlH5gKqtshNg=;
        b=ND5FzI8/EzZuSoNJFkRLaBYqRLq9ACsX+FyIaExGIIvUX8Rwp9GzS1qk2sUcWrjvkc
         fGwu1WO5YMJ8yp7gzVnKvPRxxwB152VXPOJaSb2kS15uMjl4xJBzhl1An81LjoW2mc0l
         rC48ZNfUeN3SqFM3WMVgZ4d+f3xz64b/heiC9OyqH9xULmOuO5x4AUzwDpFjZikXrt2q
         iCJIfRDpn9Ep+BiNF/DfJpgD3DXXpxlzZpuMnGDX/QpFgYgYoVM/m65o9JQiGw4Rfq/s
         E8m02PDlKfSMY4+mVfC/sUG3sRnndrSlyxBA8f9RhxbTCbbA3tmieoGPRLIUiqf5zv1n
         XCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vt87WHBQva0gCRcE7qsjoztNx6zM5sPwlH5gKqtshNg=;
        b=n7RLADhgb4ZvY2TSGdEReEIuDFiGwYjyFnf13GM6SzXBUhXbteTGK94ewM7H6gmWrK
         JQRbq9NAM+UELhQCudI2oPpLJ81vk9o43zv8CQxRnkiNOTM/odsxsEHXtQEXgAxHvTAs
         bI2DAKKelzHZyN6vrwUrXo27rZhNjrkpy0dI2nFjp6LSuvxa3Zgtg9tzi4qf6vzZu4RT
         cAAHTpslwzUOZKhU5YEfdkvTjrSDB/i0QZAsVqFN31/IgQPnrIk0iYEeIt6/Ys7+V9qY
         NqEYnGfKV9ote9rkUajWJCmQ6JGaxSvzhpT21RnI54d4bsY4QxLbmGtWzb98CwPc0VnP
         tCiA==
X-Gm-Message-State: APjAAAV1y9PmodDqkbYD+C2Y2srBy3KQ6pX7/DfF0Th7HNPqFFBLim4e
        tAaixOaNw5l5VWn86XPacmx/NNF2OaU=
X-Google-Smtp-Source: APXvYqzM69QHKyfayX6V23TGvR+yHbnrzgBBiz0IeMSWKI373qqZorLLnAxgJ02aH5utNIu1/HB+fg==
X-Received: by 2002:a2e:25a:: with SMTP id 87mr45989279ljc.183.1564042476280;
        Thu, 25 Jul 2019 01:14:36 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 199sm9015251ljf.44.2019.07.25.01.14.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 01:14:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] mesh: Check that config server is present in primary element
Date:   Thu, 25 Jul 2019 10:14:24 +0200
Message-Id: <20190725081424.22621-6-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
References: <20190725081424.22621-1-michal.lowas-rzechonek@silvair.com>
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
index 1b58d9395..012838d24 100644
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

