Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91986C35240
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68017214D8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="hkXuyBfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgA3Oeh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:34:37 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:46625 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgA3Oeh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 09:34:37 -0500
Received: by mail-wr1-f49.google.com with SMTP id z7so4232709wrl.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=llKE6xq/cgQVAnARAsbQbpWNPADx/DTs2fqp+Ih+bgk=;
        b=hkXuyBfp2RcwyVT0l/392ss/w78Ga/VchfYTHySHU1ylLQgM7xigWNrzYciqBsId94
         YPl3yDw6H4ztFzg0/z51yrPdURoMBMm9ZXJGgsNhOlErvRaRcusZ5H8eERycd7yN8UKr
         CTJrNoMMCDYwgSRLU+QJQRPNNjcSnd3TqpExbSbvlbWyhzaPbi6QytRgRZwa0SGbFrYf
         htP1x+INfiZQ5MHim+dUuMTQkU1zUBLx2bsIQBkaLFsXKWKs4sWWUiVVQpZfML+vWqZY
         rzjia1O5SEEKn11YFUt/TASTNnYRV6bhyUqsvE9QpBB5lytMos6z32nTIydNl4r21vzU
         qyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llKE6xq/cgQVAnARAsbQbpWNPADx/DTs2fqp+Ih+bgk=;
        b=KAqizHnOpK38nxZIyNk0KIdXONqgVB0qUZG7CuxfZUNYhgJzFDw+oG1vlUi14dwv3V
         2BIzgJwfEtawRMTlfRM2DvVEKMws7E+TEc8vLrXXJDsjj8B2M1mIh536cSx1CjRg8gqv
         fwkcfvz32QvVX7XI2tK6Dr2Co3qeCcmhfRxur9Hm1NZNXhyNFZMA/to3GHjiiS0rGkUE
         tfb8QhtEL3ouFBn2SzLMbS5gPk/LhMiwmtIt2bMVnzqPA5LZdSMCasX5lqh5U/3nPYUg
         zOnXWJb35rGv7zRmUrP3SW0X3m2M7TxZinaqhOs0w5Q6YIe9L6Q77XJszg/j1naaiN8W
         jGCQ==
X-Gm-Message-State: APjAAAVu5TArbFLJEzK0HJ0I08VvfBy3MSqplnaBaerZmnnEssVAUtx0
        rkp7AlADsBahVyxl+8XHdBYHwI0TtUHt2A==
X-Google-Smtp-Source: APXvYqwHqhNVsH02Jdo2kcNyghRPvWkQZdIaUZTVitkffq245s4epXS/DnZ38eaUo4zvjKNJjlcsvw==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr5890078wru.318.1580394874306;
        Thu, 30 Jan 2020 06:34:34 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x10sm7353310wrv.60.2020.01.30.06.34.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:34:33 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] mesh: remove unused node_set_device_key()
Date:   Thu, 30 Jan 2020 15:34:24 +0100
Message-Id: <20200130143425.5844-4-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130143425.5844-1-jakub.witowski@silvair.com>
References: <20200130143425.5844-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch removes node_set_device_key() function,
because it is unused.
---
 mesh/node.c | 5 -----
 mesh/node.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 6fe70742d..d4be070fa 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -628,11 +628,6 @@ uint16_t node_get_primary(struct mesh_node *node)
 		return node->primary;
 }
 
-void node_set_device_key(struct mesh_node *node, uint8_t key[16])
-{
-	memcpy(node->dev_key, key, 16);
-}
-
 const uint8_t *node_get_device_key(struct mesh_node *node)
 {
 	if (!node)
diff --git a/mesh/node.h b/mesh/node.h
index a6bc4a2a6..38aea138f 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -46,7 +46,6 @@ uint16_t node_get_primary(struct mesh_node *node);
 uint16_t node_get_primary_net_idx(struct mesh_node *node);
 void node_set_token(struct mesh_node *node, uint8_t token[8]);
 const uint8_t *node_get_token(struct mesh_node *node);
-void node_set_device_key(struct mesh_node *node, uint8_t key[16]);
 const uint8_t *node_get_device_key(struct mesh_node *node);
 void node_set_num_elements(struct mesh_node *node, uint8_t num_ele);
 uint8_t node_get_num_elements(struct mesh_node *node);
-- 
2.20.1

