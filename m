Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 16:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF812073E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 16:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGGQot (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:44:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:62900 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgGGQot (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 12:44:49 -0400
IronPort-SDR: 4MMHdr2gbIQbT9W2XLLV/MwOsyUhWBDfncWD7lA76htGQRnumqNBb2PQZ5TcQZAmTfVd+XfqsU
 eakmiqgQslwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147657525"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="147657525"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 09:44:40 -0700
IronPort-SDR: JLP6Xz/YBRmEUso3fbskmMKTEYHUoAE+f0LEAY67oo4ZRwa8GmEF64m2AzHmQrkO2paptUhRI8
 cXIwwojdTClw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="323592430"
Received: from jdlachim-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.230.123])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2020 09:44:40 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] mesh: Get rid of "unreliable opcodes" in config server
Date:   Tue,  7 Jul 2020 09:44:38 -0700
Message-Id: <20200707164439.24146-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes an old notion of unreliable opcodes in config server
model , i.e., a correctly formatted acknowledged message always
gets a response.
---
 mesh/cfgmod-server.c | 31 +++++++++++--------------------
 mesh/model.h         |  2 --
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index c525d9d24..8ba9bc6ec 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -98,9 +98,8 @@ static void config_pub_get(struct mesh_node *node, uint16_t net_idx,
 }
 
 static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
-					uint16_t src, uint16_t dst,
-					const uint8_t *pkt, bool virt,
-					bool vendor, bool unreliable)
+				uint16_t src, uint16_t dst,
+				const uint8_t *pkt, bool virt, bool vendor)
 {
 	uint32_t mod_id;
 	uint16_t ele_addr, idx, ota = UNASSIGNED_ADDRESS;
@@ -143,9 +142,8 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 					status, ele_addr, ota, mod_id, idx);
 
 	if (status != MESH_STATUS_SUCCESS) {
-		if (!unreliable)
-			send_pub_status(node, net_idx, src, dst, status,
-					ele_addr, mod_id, 0, 0, 0, 0, 0, 0);
+		send_pub_status(node, net_idx, src, dst, status, ele_addr,
+						mod_id, 0, 0, 0, 0, 0, 0);
 
 		return;
 	}
@@ -180,10 +178,8 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 			status = MESH_STATUS_STORAGE_FAIL;
 	}
 
-	if (!unreliable)
-		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-					mod_id, ota, idx, cred_flag, ttl,
-					period, retransmit);
+	send_pub_status(node, net_idx, src, dst, status, ele_addr, mod_id, ota,
+				idx, cred_flag, ttl, period, retransmit);
 }
 
 static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
@@ -311,7 +307,6 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 					bool virt, uint32_t opcode)
 {
 	uint16_t grp, ele_addr;
-	bool unreliable = !!(opcode & OP_UNRELIABLE);
 	uint32_t mod_id;
 	const uint8_t *addr = NULL;
 	int status = MESH_STATUS_SUCCESS;
@@ -369,7 +364,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 	} else
 		grp = UNASSIGNED_ADDRESS;
 
-	switch (opcode & ~OP_UNRELIABLE) {
+	switch (opcode) {
 	default:
 		l_debug("Bad opcode: %x", opcode);
 		return;
@@ -411,8 +406,8 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 		grp = UNASSIGNED_ADDRESS;
 		/* Fall Through */
 	case OP_CONFIG_MODEL_SUB_DELETE:
-		status = mesh_model_sub_del(node, ele_addr, mod_id,
-							addr, virt, &grp);
+		status = mesh_model_sub_del(node, ele_addr, mod_id, addr, virt,
+									&grp);
 
 		if (status == MESH_STATUS_SUCCESS)
 			save_config_sub(node, ele_addr, mod_id, vendor, addr,
@@ -421,10 +416,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 		break;
 	}
 
-	if (!unreliable)
-		send_sub_status(node, net_idx, src, dst, status, ele_addr,
-								grp, mod_id);
-
+	send_sub_status(node, net_idx, src, dst, status, ele_addr, grp, mod_id);
 }
 
 static void send_model_app_status(struct mesh_node *node, uint16_t net_idx,
@@ -786,8 +778,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 			return true;
 
 		config_pub_set(node, net_idx, src, dst, pkt, virt,
-						size == 13 || size == 27,
-						!!(opcode & OP_UNRELIABLE));
+						size == 13 || size == 27);
 		break;
 
 	case OP_CONFIG_MODEL_PUB_GET:
diff --git a/mesh/model.h b/mesh/model.h
index f717fb00c..0377d3fdd 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -19,8 +19,6 @@
 
 struct mesh_model;
 
-#define OP_UNRELIABLE			0x0100
-
 #define MAX_BINDINGS	10
 #define MAX_GRP_PER_MOD	10
 
-- 
2.26.2

