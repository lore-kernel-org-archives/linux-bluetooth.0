Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C394FC4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 09:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9447D205ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 09:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="04SgeJvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF1Ju6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:50:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37760 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF1Ju6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 05:50:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so8349950wme.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2019 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GTR7eS9iTeA1tj1CnLiaE3uJSHNAvbMVnV6SG8zZRo=;
        b=04SgeJvVp0+qXnpRK4QoqHVAA4FLvtRvjOquSEOMYS/c0oyBdM+LkCvU2iK/TKFNX3
         b/5pJPKMChHkN0qyAFoCHeX6jNHMqWWBZO9yfPK7hO0B003JpoSmJe5yX70q8MI6Huns
         M0mkF9cpmS5WFj0pNmMfiJzY1orUd+N3Wdp32eLUHLuVk8ZWBH6y2YAmPt5qOOYvGIuj
         CjzEb+yEEpxnffEH7NzO6FPTj6ZE9KqV2DGpE3AxHiaxuDV2//wYb1Y2tDQXsoYY4gpt
         KsB93Raxlx8k5jTFwkaQ/tPwU2+nSYo4iqMAYs72gcgUADYw0WOJDAI14GZ0DgEepmxS
         cDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GTR7eS9iTeA1tj1CnLiaE3uJSHNAvbMVnV6SG8zZRo=;
        b=DiICuNXYOc506+lOwISo3nbAv2tVBRE0JwAhwHMRZ8ZzexjviMIhN7ztIkkcu8MRva
         3J8OGi22p3zHY0d6WGc8+yPT5NzcQvh/83/0FF7B1DGnjrellFj0InsQHYs+rQkLvhdE
         vk26WFlBQTHhuMu/7J9fXeGS/1dbZd+OZVRa/aBlzaZi9q4q6R/6gIRLoU6pTG0Iu0kD
         z479sQuEOPoED2PbASSRjF0Fcm9jdGP7cfJV1C1drqwyOevj7J3IGtph/eGi3ERUOTPI
         Kne8cBC5Xeyn2cu93hVDW9IGT62BDuSBAnJwuERSKHOr1q1VbIjKI6owR4RXIf0U8SS9
         Xz7Q==
X-Gm-Message-State: APjAAAVeQ52j579xK1Xf7WhRrQJEIZx7gpBNaDHbCYSwMURypnKju0uh
        de62q5QqaX1ydgj4bxejG1fKA5hWs0U=
X-Google-Smtp-Source: APXvYqw4QSG66xPWBlTDgndPnqNNLgIL+J9EXvk53m4vT4g+QeV1lBPnJTvdqycfK8PGDGygebZO6g==
X-Received: by 2002:a1c:4803:: with SMTP id v3mr6757412wma.49.1561715455568;
        Fri, 28 Jun 2019 02:50:55 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r12sm2087106wrt.95.2019.06.28.02.50.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 02:50:54 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH] mesh: Clear nodes queue on get_managed_objects_cb() fails
Date:   Fri, 28 Jun 2019 11:50:49 +0200
Message-Id: <20190628095049.10595-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently when the get_managed_objects_cb() fails it frees
the node resources but the node still remains on the "nodes" queue.

This implementation calls node_remove() instead of
free_node_resources()."
---
 mesh/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/node.c b/mesh/node.c
index 4e35bb3ff..2229aa711 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1601,7 +1601,7 @@ fail:
 	} else {
 		/* Handle failed Join and Create requests */
 		if (node)
-			free_node_resources(node);
+			node_remove(node);
 
 		if (req->type == REQUEST_TYPE_JOIN) {
 			node_join_ready_func_t cb = req->cb;
-- 
2.20.1

