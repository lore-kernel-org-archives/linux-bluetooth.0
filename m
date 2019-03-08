Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36CCC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9E206DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCHW61 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:58:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:23713 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfCHW61 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 17:58:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 14:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="120994298"
Received: from ingas-nuc1.sea.intel.com ([10.251.144.43])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2019 14:58:26 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/3] mesh: Save model subscription updates to config file
Date:   Fri,  8 Mar 2019 14:58:19 -0800
Message-Id: <20190308225820.20561-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190308225820.20561-1-inga.stotland@intel.com>
References: <20190308225820.20561-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds functionality in Config Server model to save changes in
node configuration file when model subscriptions are added, deleted or
overwritten.
---
 mesh/cfgmod-server.c | 60 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 9dc82eef6..df2614529 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -37,6 +37,7 @@
 #include "mesh/appkey.h"
 #include "mesh/model.h"
 #include "mesh/storage.h"
+#include "mesh/mesh-db.h"
 
 #include "mesh/cfgmod.h"
 
@@ -195,7 +196,7 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	if (IS_UNASSIGNED(ota) && !b_virt)
 		ttl = period = idx = 0;
 
-	if (status >= 0 && !unreliable)
+	if (!unreliable)
 		send_pub_status(node, src, dst, status, ele_addr, ota,
 				mod_id, idx, cred_flag, ttl, period,
 				retransmit);
@@ -285,6 +286,38 @@ static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 	return true;
 }
 
+static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
+					uint32_t mod_id, bool vendor,
+					const uint8_t *addr, bool virt,
+					uint16_t grp, uint32_t opcode)
+{
+	struct mesh_db_sub db_sub = {
+				.virt = virt,
+				.src.addr = grp
+				};
+
+	if (virt)
+		memcpy(db_sub.src.virt_addr, addr, 16);
+
+	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE ||
+					opcode == OP_CONFIG_MODEL_SUB_OVERWRITE)
+		mesh_db_model_sub_del_all(node_jconfig_get(node),
+				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
+									vendor);
+
+	if (opcode != OP_CONFIG_MODEL_SUB_VIRT_DELETE &&
+			opcode != OP_CONFIG_MODEL_SUB_DELETE)
+		return mesh_db_model_sub_add(node_jconfig_get(node),
+					ele_addr,
+					vendor ? mod_id : mod_id & 0x0000ffff,
+					vendor, &db_sub);
+	else
+		return mesh_db_model_sub_del(node_jconfig_get(node),
+					ele_addr,
+					vendor ? mod_id : mod_id & 0x0000ffff,
+					vendor, &db_sub);
+}
+
 static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size,
 					bool virt, uint32_t opcode)
@@ -294,6 +327,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	uint32_t mod_id, func;
 	const uint8_t *addr = NULL;
 	int status = 0;
+	bool vendor = false;
 
 	switch (size) {
 	default:
@@ -314,6 +348,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 		} else {
 			mod_id = l_get_le16(pkt + 2) << 16;
 			mod_id |= l_get_le16(pkt + 4);
+			vendor = true;
 		}
 		break;
 	case 8:
@@ -321,6 +356,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 			return;
 		mod_id = l_get_le16(pkt + 4) << 16;
 		mod_id |= l_get_le16(pkt + 6);
+		vendor = true;
 		break;
 	case 20:
 		if (!virt)
@@ -351,6 +387,11 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
 		status = mesh_model_sub_del_all(node, ele_addr, mod_id);
+
+		if (status == MESH_STATUS_SUCCESS)
+			mesh_db_model_sub_del_all(node_jconfig_get(node),
+				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
+									vendor);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
@@ -359,6 +400,10 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	case OP_CONFIG_MODEL_SUB_OVERWRITE:
 		status = mesh_model_sub_ovr(node, ele_addr, mod_id,
 							addr, virt, &grp);
+
+		if (status == MESH_STATUS_SUCCESS)
+			save_config_sub(node, ele_addr, mod_id, vendor, addr,
+							virt, grp, opcode);
 		break;
 	case OP_CONFIG_MODEL_SUB_VIRT_ADD:
 		grp = UNASSIGNED_ADDRESS;
@@ -366,6 +411,12 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	case OP_CONFIG_MODEL_SUB_ADD:
 		status = mesh_model_sub_add(node, ele_addr, mod_id,
 							addr, virt, &grp);
+
+		if (status == MESH_STATUS_SUCCESS &&
+				!save_config_sub(node, ele_addr, mod_id, vendor,
+						addr, virt, grp, opcode))
+			status = MESH_STATUS_STORAGE_FAIL;
+
 		break;
 	case OP_CONFIG_MODEL_SUB_VIRT_DELETE:
 		grp = UNASSIGNED_ADDRESS;
@@ -373,10 +424,15 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	case OP_CONFIG_MODEL_SUB_DELETE:
 		status = mesh_model_sub_del(node, ele_addr, mod_id,
 							addr, virt, &grp);
+
+		if (status == MESH_STATUS_SUCCESS)
+			save_config_sub(node, ele_addr, mod_id, vendor, addr,
+							virt, grp, opcode);
+
 		break;
 	}
 
-	if (!unreliable && status >= 0)
+	if (!unreliable)
 		send_sub_status(node, src, dst, status, ele_addr, grp, mod_id);
 
 }
-- 
2.17.2

