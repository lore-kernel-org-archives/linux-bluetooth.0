Return-Path: <SRS0=TohX=3J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A05C33CB8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506AF217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gyH/kxkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgATQL0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:11:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36977 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQL0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jan 2020 11:11:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so152192wmf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2020 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KmtQ5vJs04+y7YOuZpyU/tHE9nbTiu1Y147WH5ZpNJg=;
        b=gyH/kxknCFhLDkLUO8LacMslhsaccB2/ahww5W0R7F0igQuTl4IHmIz9LrOB3FlYum
         6iMsJQ0hm+u7BjoZYIsrPl+8whc7FcI9tFBVu89QVlwY0yaIQ7kHaSoTMBEl4LVrqAh6
         gKdKzsG9wYFwweF6o6KNWx+7bKq4KjDzhB8NxXSBn7qTfLuoh805AGYzZviC+YdxoMzR
         rG3dki+6UBHwzA/X7O5vE8un4xc9Z3SQvkhR/MaDtdMcwXdKexLhUQQsr1qeCYvoLgBu
         Q8AzH+h8r59RZklhiJ9WF64vrrjZCRLwCFqs4aQLBYoiUIbxH4ESKoZzK1ZRvpTrq14F
         JMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmtQ5vJs04+y7YOuZpyU/tHE9nbTiu1Y147WH5ZpNJg=;
        b=eORt9tPStmSDETiyuojLlfdw8zkpKeyGPqLWodawpNdr7rbje/MU6Ok5tyA6kpOt1D
         RMPUZW7vEhqlN5ch01c+ainj1XtI1ScIFxA1fbQSVj98SYvVbY2PYIRqVjP0JeBwmgrI
         TBFKoEZd1SRogt85q6do/U3XAexWzTGBRVW1mBAxKQjuVoHUynM2Q39XxEyJI9Tutk+x
         IvmBEHpR4o6e8cp0qs4zlCxcVDjYZ9vkU3lJXMmtyJ0P9VAHLg9b9Ulay2zjCIHwzCYd
         sbdH7iIkWk5JMcwo7lgYRvnaXH0FO08XSZXXxhm4dDLc0I1lpDOGiqPHHISje8nShFyq
         atlA==
X-Gm-Message-State: APjAAAWaL4IATub1o3WaWSdsZAEpkJ98UpZWcNwFq2my6Mxh6nJFSwhO
        Fr4pni0MmnfaFl82f1EoOkCetQCEy3s6JQ==
X-Google-Smtp-Source: APXvYqztJFGtH1QUgPtlXJEnBArLEXLTNlvHM889F5mN9Z2/XELTvw0ASChNAHyJ6sE8L/89WmeRfQ==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr103151wmc.168.1579536684920;
        Mon, 20 Jan 2020 08:11:24 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 16sm22564602wmi.0.2020.01.20.08.11.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:11:24 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] mesh: allow to reattach with new composition data
Date:   Mon, 20 Jan 2020 17:11:14 +0100
Message-Id: <20200120161114.6757-4-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120161114.6757-1-jakub.witowski@silvair.com>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/node.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 6fe70742d..f9a2d5722 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -47,6 +47,12 @@
 
 #define MIN_COMP_SIZE 14
 
+/* Composition data header size contains the length of belows:
+ * CID, PID, VID, CRPL and Feature bits
+ */
+#define COMP_HDR_SIZE 10
+#define COMP_FEATURE_BITS_SIZE 2
+
 #define MESH_NODE_PATH_PREFIX "/node"
 
 /* Default values for a new locally created node */
@@ -1394,15 +1400,39 @@ static bool check_req_node(struct managed_obj_request *req)
 		uint16_t attach_len = node_generate_comp(req->attach,
 					attach_comp, sizeof(attach_comp));
 
-		/* Ignore feature bits in Composition Compare */
-		node_comp[8] = 0;
-		attach_comp[8] = 0;
-
+		/* Ignore CID, VID, PID, CRPL and feature bits
+		 * in Composition Compare
+		 */
 		if (node_len != attach_len ||
-				memcmp(node_comp, attach_comp, node_len)) {
+			memcmp(node_comp + COMP_HDR_SIZE,
+						attach_comp + COMP_HDR_SIZE,
+						node_len - COMP_HDR_SIZE)) {
 			l_debug("Failed to verify app's composition data");
 			return false;
 		}
+
+		/* Compare CID, VID, PID and CRPL */
+		if (!memcmp(node_comp, attach_comp,
+					COMP_HDR_SIZE - COMP_FEATURE_BITS_SIZE))
+			return true;
+
+		l_debug("Composition data update");
+
+		if (!mesh_config_write_comp(req->attach->cfg,
+				req->node->comp.cid, req->node->comp.pid,
+				req->node->comp.vid, req->node->comp.crpl)) {
+
+			l_debug("Failed to update composition data");
+			return false;
+		}
+
+		if (!mesh_config_save(req->attach->cfg, true, NULL, NULL)) {
+			l_debug("Failed to store composition data");
+			return false;
+		}
+
+		memcpy(&req->attach->comp, &req->node->comp,
+					sizeof(struct node_composition));
 	}
 
 	return true;
-- 
2.20.1

