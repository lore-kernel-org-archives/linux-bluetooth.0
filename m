Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C25C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D0820678
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="OzkWayPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgA3Oej (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:34:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38218 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgA3Oei (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 09:34:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so4478215wmj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 06:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1JONOnTp+j8P+u1SKuer0eDRKjS3RD/D691AgdZxP7A=;
        b=OzkWayPvGukx0tkOa2yBy8Af90McUfqK85yQHw7ynLFkIB3pejLnZjiyXb/1IaxBcd
         rcAOlJLPzltovzvlIvalrlL4RF6CRRVAhdq4h+rUk7mRoin/p0NmylLnhrptruzdI3al
         HlCE3+wnU7U9LfYjfd0/ruFN/cogp+C6g2JqxSZd1rw6eBQg6mF8SBqEUW+X08A765rQ
         uwJxQ4FmQTRyc7vFvh2Pfo3Lxuz4ker+ySeEIkAMRFgSCFN5SuKIUuJiSH11zDKKxEBC
         oAtYV6eR6O3IcLJJUMF4QHHkBPCMtKfkv/tVbiK2rhDl6nFnDE8+S4RKIVcmiixJQkMe
         AJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JONOnTp+j8P+u1SKuer0eDRKjS3RD/D691AgdZxP7A=;
        b=EGOcdPKWdCzUNQ5BCJnzTO3BgzjUYXv0WHWTh/z9rdWl9cPmMyFiTEqGW5iwFLAZzl
         F/CL5MQtE3Fjlzh4o8NEdS2+BPj3iCyTACr8hqJu2WtrGGw1KtpLVzLNeV0qbhJvKWpQ
         9E3/5BO46krct8E1XzRalm8AQVkd3gwUvl6Gxtj1nq3U9BHznuD1+YNYFELd/w4ELnx/
         KkTVAntjf/9wD/3hVqlaqGwudJeA2RqKzq1Y9F4nqJZRMNN8mg6EIlHBADb0IW/DWxyA
         TdhyXmqVAZUb8xR/tg30dWOcriPsQUAkNMLqaO6TzJTXRRIhe9YPaNZ8r2pxiqJiVmFH
         4pWQ==
X-Gm-Message-State: APjAAAXHupXT4LTrsL9u+Q1TFkxH/iJF2IK45ci1xLtLDaPlD6yX9b1o
        HIF2EaHDXxzFEmck/fKTMaf8OopNl8kk8Q==
X-Google-Smtp-Source: APXvYqwlAn1zKoNYKIND31ouZKtq39tsv1kPXOCnlRRl0Ug6doYFt/N9JsRKPF1J4k5mrvSiNHtakg==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr5812619wmj.57.1580394875776;
        Thu, 30 Jan 2020 06:34:35 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x10sm7353310wrv.60.2020.01.30.06.34.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:34:35 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] mesh: allow to reattach with new composition data
Date:   Thu, 30 Jan 2020 15:34:25 +0100
Message-Id: <20200130143425.5844-5-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130143425.5844-1-jakub.witowski@silvair.com>
References: <20200130143425.5844-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch allows to change the CIP/PID/VID data when
reattaching. Additionally the device key is verified
during those change.
---
 mesh/node.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mesh/node.c b/mesh/node.c
index d4be070fa..86102d1da 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -47,6 +47,9 @@
 
 #define MIN_COMP_SIZE 14
 
+/* COMP_ID_SIZE consists of length of the CID, PID and VID */
+#define COMP_ID_SIZE 6
+
 #define MESH_NODE_PATH_PREFIX "/node"
 
 /* Default values for a new locally created node */
@@ -1389,15 +1392,49 @@ static bool check_req_node(struct managed_obj_request *req)
 		uint16_t attach_len = node_generate_comp(req->attach,
 					attach_comp, sizeof(attach_comp));
 
+		uint8_t keyring_dev_key[16];
+
 		/* Ignore feature bits in Composition Compare */
 		node_comp[8] = 0;
 		attach_comp[8] = 0;
 
+		/* Ignore CID, PID, VID in Composition Compare */
 		if (node_len != attach_len ||
-				memcmp(node_comp, attach_comp, node_len)) {
+					memcmp(node_comp + COMP_ID_SIZE,
+						attach_comp + COMP_ID_SIZE,
+						node_len - COMP_ID_SIZE)) {
 			l_debug("Failed to verify app's composition data");
 			return false;
 		}
+
+		/* Compare CID, VID and PID */
+		if (!memcmp(node_comp, attach_comp, COMP_ID_SIZE))
+			return true;
+
+		/* Verify the device key */
+		keyring_get_remote_dev_key(req->attach, req->attach->primary,
+							keyring_dev_key);
+
+		if (memcmp(keyring_dev_key,
+					node_get_device_key(req->attach), 16))
+			return false;
+
+		if (!mesh_config_write_comp_id(req->attach->cfg,
+							req->node->comp.cid,
+							req->node->comp.pid,
+							req->node->comp.vid)) {
+			l_debug("Failed to update comp id data");
+			return false;
+		}
+
+		if (!mesh_config_save(req->attach->cfg, true, NULL, NULL)) {
+			l_debug("Failed to store comp id");
+			return false;
+		}
+
+		memcpy(&req->attach->comp, &req->node->comp,
+					sizeof(struct node_composition) -
+						sizeof(req->node->comp.crpl));
 	}
 
 	return true;
-- 
2.20.1

