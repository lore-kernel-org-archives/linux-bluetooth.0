Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE466C4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 12:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F63208C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 12:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="F//+a8Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF1MwS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:52:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37095 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfF1MwR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 08:52:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so6183551wrr.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2019 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5UZNcOToqPjV/Nl+fzaJPtkYB09btJYTifD+u4/q8Q=;
        b=F//+a8AchrMrRySk3H7Vgpfo+qWvfJGPRcDvvf7hpOjWIgF/ArhSZRIaHFvrDXpbmN
         Nw4mLe2nFZ3/dKmW4rLop5suNgR+7xWGsPbZlJZLs4x+e+5X4mfBPt598E++TTrbEEB6
         urpEyTyCNAool0kLev45wID3nQuQb1wHpgW8EMaVYJapiAqLLlTY5/RnBmtDdNkJ9MhC
         8iCa7pL/lY/Sieg/UpKdkzRAeEX1Kg88xSRN+n731jxqFR85mCow61ZCqgVAAy9K9xHk
         080h8xrgR9F4+3ozjT0yLzcUftFfr8cXG5Fx5JfE6mBZHbFN5A5GV7NX0K8HvbRwPBsA
         BaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5UZNcOToqPjV/Nl+fzaJPtkYB09btJYTifD+u4/q8Q=;
        b=agSDCGWtKn7FrQSWBl+UkXS2C/gwCBuJ7pYBfX+RiCZ0Vs/EDkxXFOOl44JYE5K9DL
         e+gXzD0Ie/I+OaXJPOX57hb+hjQJI7mNfoEcrodTRJUP5T58VRooB3ItEg2VTZycLdf0
         GCg82tMUv18tn2BMcJRf/txf+f1bY8VrkqImwKvYule76NCdU9rqpToDgG2u2erEkEMc
         VdaKOEWMUaVjX7JW7kzTX5ZAm7zUiXsmdy321D7BGmzVS+j9mgfQwIVUyrnvNbAW2iNw
         jBIsEknkJzZpCsyiBV+LUeqhkjHCCKo8E0xwVk/FfDf80tx3OyLsU/sXNrOdQaM4dAHw
         +nHA==
X-Gm-Message-State: APjAAAXRkIer1kEb6n61wtEWk/4gJvPu8OlICp5Kqafz8YOq4Eh7yFKi
        HbUTeoNx8YN3eUfjEsB4LzpVuDNwrqM=
X-Google-Smtp-Source: APXvYqzPHLi79Oac36jbVgcFtn6emPpFFzGCvUf9z80QjHYCEABww1mHyvot/RTnIOGWuWThmqG1oQ==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr7804134wrx.191.1561726335405;
        Fri, 28 Jun 2019 05:52:15 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y6sm2226484wmd.16.2019.06.28.05.52.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 05:52:14 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Jakub Witowski <jakub.witowski@silvair.com>
Subject: [PATCH BlueZ 3/3] mesh: Handle messages encrypted with a remote dev key
Date:   Fri, 28 Jun 2019 14:52:05 +0200
Message-Id: <20190628125205.21411-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
References: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/model.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index f46cce7c1..324d75dd9 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -39,6 +39,7 @@
 #include "mesh/dbus.h"
 #include "mesh/util.h"
 #include "mesh/model.h"
+#include "mesh/keyring.h"
 
 /* Divide and round to ceiling (up) to calculate segment count */
 #define CEILDIV(val, div) (((val) + (div) - 1) / (div))
@@ -369,6 +370,14 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 					dst, key_id, seq, iv_idx, out, key))
 		return APP_IDX_DEV_LOCAL;
 
+	if (!keyring_get_remote_dev_key(node, src, dev_key))
+		return -1;
+
+	key = dev_key;
+	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
+					dst, key_id, seq, iv_idx, out, key))
+		return APP_IDX_DEV_REMOTE;
+
 	return -1;
 }
 
@@ -852,7 +861,10 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		models = node_get_element_models(node, i, NULL);
 
 		/* Internal models */
-		l_queue_foreach(models, forward_model, &forward);
+		if (decrypt_idx != APP_IDX_DEV_REMOTE)
+			l_queue_foreach(models, forward_model, &forward);
+		else
+			forward.has_dst = true;
 
 		/*
 		 * Cycle through external models if the message has not been
-- 
2.19.1

