Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C555AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 22:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F24920684
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 22:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGWW02 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:26:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:50824 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgGWW01 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 18:26:27 -0400
IronPort-SDR: KgyFU5Owulk3GVml5kC/TvZqvo/Js3MpVFWbePdr81sjTSEZGKm1qJl6qrUGuPAdynCDmRQX/0
 PW+tB4FDyf5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="130703914"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="130703914"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 15:00:23 -0700
IronPort-SDR: XxJNZD5VawdcHW8W68dPSLh3KmQcC8aCwn2hT24NtCu/I3U1w//7AT5550hFrAWaT5oVkl0Vp9
 obHYMcKQ0oow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="463012199"
Received: from ncpatra-mobl2.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.73])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2020 15:00:22 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v4] mesh: Move model functionality out of node.c to model.c
Date:   Thu, 23 Jul 2020 15:00:21 -0700
Message-Id: <20200723220021.370600-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves the model related code out of node.c to model.c providing
for better functional separation of modules.

Also, use the value of 0xFFFF for internal representation of vendor ID
for BT SIG defined models. This allows to maintain a single internal
vendor ID / model ID space.
---
 mesh/cfgmod-server.c    | 172 ++++++-------
 mesh/cfgmod.h           |   4 +-
 mesh/mesh-config-json.c |   5 +-
 mesh/model.c            | 544 +++++++++++++++++++++++++++-------------
 mesh/model.h            |  74 +++---
 mesh/node.c             | 319 ++++-------------------
 mesh/node.h             |   4 +-
 7 files changed, 544 insertions(+), 578 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 9046a1ad9..7672ad3b6 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2020  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -42,7 +42,7 @@ static uint8_t msg[MAX_MSG_LEN];
 
 static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 			uint16_t src, uint16_t dst,
-			uint8_t status, uint16_t ele_addr, uint32_t mod_id,
+			uint8_t status, uint16_t ele_addr, uint32_t id,
 			uint16_t pub_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit)
 {
@@ -59,12 +59,12 @@ static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 	msg[n++] = period;
 	msg[n++] = retransmit;
 
-	if (mod_id >= VENDOR_ID_MASK) {
-		l_put_le16(mod_id, msg + n);
+	if (!IS_VENDOR(id)) {
+		l_put_le16(MODEL_ID(id), msg + n);
 		n += 2;
 	} else {
-		l_put_le16(mod_id >> 16, msg + n);
-		l_put_le16(mod_id, msg + n + 2);
+		l_put_le16(VENDOR_ID(id), msg + n);
+		l_put_le16(MODEL_ID(id), msg + n + 2);
 		n += 4;
 	}
 
@@ -76,37 +76,35 @@ static void config_pub_get(struct mesh_node *node, uint16_t net_idx,
 					uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size)
 {
-	uint32_t mod_id;
+	uint32_t id;
 	uint16_t ele_addr;
 	struct mesh_model_pub *pub;
 	int status;
 
 	if (size == 4) {
-		mod_id = l_get_le16(pkt + 2);
-		mod_id |= VENDOR_ID_MASK;
+		id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 2));
 	} else if (size == 6) {
-		mod_id = l_get_le16(pkt + 2) << 16;
-		mod_id |= l_get_le16(pkt + 4);
+		id = SET_ID(l_get_le16(pkt + 2), l_get_le16(pkt + 4));
 	} else
 		return;
 
 	ele_addr = l_get_le16(pkt);
-	pub = mesh_model_pub_get(node, ele_addr, mod_id, &status);
+	pub = mesh_model_pub_get(node, ele_addr, id, &status);
 
 	if (pub && status == MESH_STATUS_SUCCESS)
 		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-				mod_id, pub->addr, pub->idx, pub->credential,
+				id, pub->addr, pub->idx, pub->credential,
 				pub->ttl, pub->period, pub->retransmit);
 	else
 		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-				mod_id, 0, 0, 0, 0, 0, 0);
+				id, 0, 0, 0, 0, 0, 0);
 }
 
 static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 				uint16_t src, uint16_t dst,
 				const uint8_t *pkt, bool virt, bool vendor)
 {
-	uint32_t mod_id;
+	uint32_t id;
 	uint16_t ele_addr, idx, ota = UNASSIGNED_ADDRESS;
 	const uint8_t *pub_addr;
 	uint16_t test_addr;
@@ -124,12 +122,12 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 	ttl = pkt[6];
 	period = pkt[7];
 	retransmit = pkt[8];
-	mod_id = l_get_le16(pkt + 9);
+	id = l_get_le16(pkt + 9);
 
 	if (!vendor)
-		mod_id |= VENDOR_ID_MASK;
+		id = SET_ID(SIG_VENDOR, id);
 	else
-		mod_id = (mod_id << 16) | l_get_le16(pkt + 11);
+		id = SET_ID(id, l_get_le16(pkt + 11));
 
 	/* Don't accept virtual seeming addresses */
 	test_addr = l_get_le16(pub_addr);
@@ -139,16 +137,16 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 	cred_flag = !!(CREDFLAG_MASK & idx);
 	idx &= APP_IDX_MASK;
 
-	status = mesh_model_pub_set(node, ele_addr, mod_id, pub_addr, idx,
+	status = mesh_model_pub_set(node, ele_addr, id, pub_addr, idx,
 					cred_flag, ttl, period, retransmit,
 					virt, &ota);
 
 	l_debug("pub_set: status %d, ea %4.4x, ota: %4.4x, mod: %x, idx: %3.3x",
-					status, ele_addr, ota, mod_id, idx);
+					status, ele_addr, ota, id, idx);
 
 	if (status != MESH_STATUS_SUCCESS) {
 		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-						mod_id, 0, 0, 0, 0, 0, 0);
+						id, 0, 0, 0, 0, 0, 0);
 
 		return;
 	}
@@ -158,7 +156,7 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 
 		/* Remove model publication from config file */
 		if (!mesh_config_model_pub_del(node_config_get(node), ele_addr,
-				vendor ? mod_id : mod_id & ~VENDOR_ID_MASK,
+						vendor ? id : MODEL_ID(id),
 									vendor))
 			status = MESH_STATUS_STORAGE_FAIL;
 	} else {
@@ -178,19 +176,19 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 
 		/* Save model publication to config file */
 		if (!mesh_config_model_pub_add(node_config_get(node), ele_addr,
-				vendor ? mod_id : mod_id & ~VENDOR_ID_MASK,
-					vendor, &db_pub))
+						vendor ? id : MODEL_ID(id),
+							vendor, &db_pub))
 			status = MESH_STATUS_STORAGE_FAIL;
 	}
 
-	send_pub_status(node, net_idx, src, dst, status, ele_addr, mod_id, ota,
+	send_pub_status(node, net_idx, src, dst, status, ele_addr, id, ota,
 				idx, cred_flag, ttl, period, retransmit);
 }
 
 static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
 					uint16_t src, uint16_t dst,
 					uint8_t status, uint16_t ele_addr,
-					uint16_t addr, uint32_t mod)
+					uint16_t addr, uint32_t id)
 {
 	int n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_STATUS, msg);
 
@@ -199,12 +197,13 @@ static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
 	n += 2;
 	l_put_le16(addr, msg + n);
 	n += 2;
-	if (mod >= 0x10000 && mod < VENDOR_ID_MASK) {
-		l_put_le16(mod >> 16, msg + n);
-		l_put_le16(mod, msg + n + 2);
+
+	if (IS_VENDOR(id)) {
+		l_put_le16(VENDOR_ID(id), msg + n);
+		l_put_le16(MODEL_ID(id), msg + n + 2);
 		n += 4;
 	} else {
-		l_put_le16(mod, msg + n);
+		l_put_le16(MODEL_ID(id), msg + n);
 		n += 2;
 	}
 
@@ -217,7 +216,7 @@ static bool config_sub_get(struct mesh_node *node, uint16_t net_idx,
 					const uint8_t *pkt, uint16_t size)
 {
 	uint16_t ele_addr;
-	uint32_t mod_id;
+	uint32_t id;
 	uint16_t n = 0;
 	int status;
 	uint8_t *msg_status;
@@ -232,34 +231,33 @@ static bool config_sub_get(struct mesh_node *node, uint16_t net_idx,
 		return false;
 
 	case 4:
-		mod_id = l_get_le16(pkt + 2);
+		id = l_get_le16(pkt + 2);
 		n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_LIST, msg);
 		msg_status = msg + n;
 		msg[n++] = 0;
 		l_put_le16(ele_addr, msg + n);
 		n += 2;
-		l_put_le16(mod_id, msg + n);
+		l_put_le16(id, msg + n);
 		n += 2;
-		mod_id |= VENDOR_ID_MASK;
+		id = SET_ID(SIG_VENDOR, id);
 		break;
 
 	case 6:
-		mod_id = l_get_le16(pkt + 2) << 16;
-		mod_id |= l_get_le16(pkt + 4);
+		id = SET_ID(l_get_le16(pkt + 2), l_get_le16(pkt + 4));
 		n = mesh_model_opcode_set(OP_CONFIG_VEND_MODEL_SUB_LIST, msg);
 		msg_status = msg + n;
 		msg[n++] = 0;
 		l_put_le16(ele_addr, msg + n);
 		n += 2;
-		l_put_le16(mod_id >> 16, msg + n);
+		l_put_le16(VENDOR_ID(id), msg + n);
 		n += 2;
-		l_put_le16(mod_id, msg + n);
+		l_put_le16(MODEL_ID(id), msg + n);
 		n += 2;
 		break;
 	}
 
 	buf_size = sizeof(uint16_t) * MAX_GRP_PER_MOD;
-	status = mesh_model_sub_get(node, ele_addr, mod_id, msg + n, buf_size,
+	status = mesh_model_sub_get(node, ele_addr, id, msg + n, buf_size,
 									&size);
 
 	if (status == MESH_STATUS_SUCCESS)
@@ -273,7 +271,7 @@ static bool config_sub_get(struct mesh_node *node, uint16_t net_idx,
 }
 
 static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
-					uint32_t mod_id, bool vendor,
+					uint32_t id, bool vendor,
 					const uint8_t *addr, bool virt,
 					uint16_t grp, uint32_t opcode)
 {
@@ -287,20 +285,18 @@ static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
 
 	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE ||
 					opcode == OP_CONFIG_MODEL_SUB_OVERWRITE)
-		mesh_config_model_sub_del_all(node_config_get(node),
-				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
+		mesh_config_model_sub_del_all(node_config_get(node), ele_addr,
+						vendor ? id : MODEL_ID(id),
 									vendor);
 
 	if (opcode != OP_CONFIG_MODEL_SUB_VIRT_DELETE &&
 			opcode != OP_CONFIG_MODEL_SUB_DELETE)
 		return mesh_config_model_sub_add(node_config_get(node),
-					ele_addr,
-					vendor ? mod_id : mod_id & 0x0000ffff,
+					ele_addr, vendor ? id : MODEL_ID(id),
 					vendor, &db_sub);
 	else
 		return mesh_config_model_sub_del(node_config_get(node),
-					ele_addr,
-					vendor ? mod_id : mod_id & 0x0000ffff,
+					ele_addr, vendor ? id : MODEL_ID(id),
 					vendor, &db_sub);
 }
 
@@ -310,7 +306,7 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 					bool virt, uint32_t opcode)
 {
 	uint16_t grp, ele_addr;
-	uint32_t mod_id;
+	uint32_t id;
 	const uint8_t *addr = NULL;
 	int status = MESH_STATUS_SUCCESS;
 	bool vendor = false;
@@ -322,40 +318,40 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 	case 4:
 		if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL)
 			return;
-		mod_id = l_get_le16(pkt + 2);
-		mod_id |= VENDOR_ID_MASK;
+
+		id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 2));
 		break;
 	case 6:
 		if (virt)
 			return;
+
 		if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL) {
-			mod_id = l_get_le16(pkt + 4);
-			mod_id |= VENDOR_ID_MASK;
+			id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 4));
 		} else {
-			mod_id = l_get_le16(pkt + 2) << 16;
-			mod_id |= l_get_le16(pkt + 4);
+			id = SET_ID(l_get_le16(pkt + 2), l_get_le16(pkt + 4));
 			vendor = true;
 		}
+
 		break;
 	case 8:
 		if (virt)
 			return;
-		mod_id = l_get_le16(pkt + 4) << 16;
-		mod_id |= l_get_le16(pkt + 6);
+
+		id = SET_ID(l_get_le16(pkt + 4), l_get_le16(pkt + 6));
 		vendor = true;
 		break;
 	case 20:
 		if (!virt)
 			return;
-		mod_id = l_get_le16(pkt + 18);
-		mod_id |= VENDOR_ID_MASK;
+
+		id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 18));
 		break;
 	case 22:
 		if (!virt)
 			return;
+
 		vendor = true;
-		mod_id = l_get_le16(pkt + 18) << 16;
-		mod_id |= l_get_le16(pkt + 20);
+		id = SET_ID(l_get_le16(pkt + 18), l_get_le16(pkt + 20));
 		break;
 	}
 
@@ -373,11 +369,11 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 		return;
 
 	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
-		status = mesh_model_sub_del_all(node, ele_addr, mod_id);
+		status = mesh_model_sub_del_all(node, ele_addr, id);
 
 		if (status == MESH_STATUS_SUCCESS)
 			mesh_config_model_sub_del_all(node_config_get(node),
-				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
+					ele_addr, vendor ? id : MODEL_ID(id),
 									vendor);
 		break;
 
@@ -385,22 +381,22 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 		grp = UNASSIGNED_ADDRESS;
 		/* Fall Through */
 	case OP_CONFIG_MODEL_SUB_OVERWRITE:
-		status = mesh_model_sub_ovr(node, ele_addr, mod_id,
+		status = mesh_model_sub_ovr(node, ele_addr, id,
 							addr, virt, &grp);
 
 		if (status == MESH_STATUS_SUCCESS)
-			save_config_sub(node, ele_addr, mod_id, vendor, addr,
+			save_config_sub(node, ele_addr, id, vendor, addr,
 							virt, grp, opcode);
 		break;
 	case OP_CONFIG_MODEL_SUB_VIRT_ADD:
 		grp = UNASSIGNED_ADDRESS;
 		/* Fall Through */
 	case OP_CONFIG_MODEL_SUB_ADD:
-		status = mesh_model_sub_add(node, ele_addr, mod_id,
+		status = mesh_model_sub_add(node, ele_addr, id,
 							addr, virt, &grp);
 
 		if (status == MESH_STATUS_SUCCESS &&
-				!save_config_sub(node, ele_addr, mod_id, vendor,
+				!save_config_sub(node, ele_addr, id, vendor,
 						addr, virt, grp, opcode))
 			status = MESH_STATUS_STORAGE_FAIL;
 
@@ -409,17 +405,17 @@ static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
 		grp = UNASSIGNED_ADDRESS;
 		/* Fall Through */
 	case OP_CONFIG_MODEL_SUB_DELETE:
-		status = mesh_model_sub_del(node, ele_addr, mod_id, addr, virt,
+		status = mesh_model_sub_del(node, ele_addr, id, addr, virt,
 									&grp);
 
 		if (status == MESH_STATUS_SUCCESS)
-			save_config_sub(node, ele_addr, mod_id, vendor, addr,
+			save_config_sub(node, ele_addr, id, vendor, addr,
 							virt, grp, opcode);
 
 		break;
 	}
 
-	send_sub_status(node, net_idx, src, dst, status, ele_addr, grp, mod_id);
+	send_sub_status(node, net_idx, src, dst, status, ele_addr, grp, id);
 }
 
 static void send_model_app_status(struct mesh_node *node, uint16_t net_idx,
@@ -434,11 +430,13 @@ static void send_model_app_status(struct mesh_node *node, uint16_t net_idx,
 	n += 2;
 	l_put_le16(idx, msg + n);
 	n += 2;
-	if (id >= 0x10000 && id < VENDOR_ID_MASK) {
-		l_put_le16(id >> 16, msg + n);
+
+	if (IS_VENDOR(id)) {
+		l_put_le16(VENDOR_ID(id), msg + n);
 		n += 2;
 	}
-	l_put_le16(id, msg + n);
+
+	l_put_le16(MODEL_ID(id), msg + n);
 	n += 2;
 
 	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
@@ -450,7 +448,7 @@ static void model_app_list(struct mesh_node *node, uint16_t net_idx,
 					const uint8_t *pkt, uint16_t size)
 {
 	uint16_t ele_addr;
-	uint32_t mod_id = 0xffff;
+	uint32_t id;
 	uint8_t *status;
 	uint16_t n;
 	int result;
@@ -463,27 +461,25 @@ static void model_app_list(struct mesh_node *node, uint16_t net_idx,
 	case 4:
 		n = mesh_model_opcode_set(OP_MODEL_APP_LIST, msg);
 		status = msg + n;
-		mod_id = l_get_le16(pkt + 2);
+		id = l_get_le16(pkt + 2);
 		l_put_le16(ele_addr, msg + 1 + n);
-		l_put_le16(mod_id, msg + 3 + n);
-		mod_id |= VENDOR_ID_MASK;
+		l_put_le16((uint16_t) id, msg + 3 + n);
+		id = SET_ID(SIG_VENDOR, id);
 		n += 5;
 		break;
 	case 6:
 		n = mesh_model_opcode_set(OP_VEND_MODEL_APP_LIST, msg);
 		status = msg + n;
-		mod_id = l_get_le16(pkt + 2) << 16;
-		mod_id |= l_get_le16(pkt + 4);
+		id = SET_ID(l_get_le16(pkt + 2), l_get_le16(pkt + 4));
 
 		l_put_le16(ele_addr, msg + 1 + n);
-		l_put_le16(mod_id >> 16, msg + 3 + n);
-		l_put_le16(mod_id, msg + 5 + n);
+		l_put_le16((uint16_t) VENDOR_ID(id), msg + 3 + n);
+		l_put_le16((uint16_t) MODEL_ID(id), msg + 5 + n);
 		n += 7;
 		break;
 	}
 
-
-	result = mesh_model_get_bindings(node, ele_addr, mod_id, msg + n,
+	result = mesh_model_get_bindings(node, ele_addr, id, msg + n,
 						MAX_MSG_LEN - n, &size);
 	n += size;
 
@@ -500,7 +496,7 @@ static bool model_app_bind(struct mesh_node *node, uint16_t net_idx,
 					bool unbind)
 {
 	uint16_t ele_addr;
-	uint32_t mod_id;
+	uint32_t id;
 	uint16_t idx;
 	int result;
 
@@ -509,12 +505,10 @@ static bool model_app_bind(struct mesh_node *node, uint16_t net_idx,
 		return false;
 
 	case 6:
-		mod_id = l_get_le16(pkt + 4);
-		mod_id |= VENDOR_ID_MASK;
+		id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 4));
 		break;
 	case 8:
-		mod_id = l_get_le16(pkt + 4) << 16;
-		mod_id |= l_get_le16(pkt + 6);
+		id = SET_ID(l_get_le16(pkt + 4), l_get_le16(pkt + 6));
 		break;
 	}
 
@@ -525,12 +519,12 @@ static bool model_app_bind(struct mesh_node *node, uint16_t net_idx,
 		return false;
 
 	if (unbind)
-		result = mesh_model_binding_del(node, ele_addr, mod_id, idx);
+		result = mesh_model_binding_del(node, ele_addr, id, idx);
 	else
-		result = mesh_model_binding_add(node, ele_addr, mod_id, idx);
+		result = mesh_model_binding_add(node, ele_addr, id, idx);
 
 	send_model_app_status(node, net_idx, src, dst, result, ele_addr,
-								mod_id, idx);
+								id, idx);
 
 	return true;
 }
diff --git a/mesh/cfgmod.h b/mesh/cfgmod.h
index 383fdbf6b..7b6a95807 100644
--- a/mesh/cfgmod.h
+++ b/mesh/cfgmod.h
@@ -17,8 +17,8 @@
  *
  */
 
-#define CONFIG_SRV_MODEL	(VENDOR_ID_MASK | 0x0000)
-#define CONFIG_CLI_MODEL	(VENDOR_ID_MASK | 0x0001)
+#define CONFIG_SRV_MODEL	SET_ID(SIG_VENDOR, 0x0000)
+#define CONFIG_CLI_MODEL	SET_ID(SIG_VENDOR, 0x0001)
 
 /* New List */
 #define OP_APPKEY_ADD				0x00
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 88f715fc1..deb0019f9 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1126,18 +1126,15 @@ static bool parse_models(json_object *jmodels, struct mesh_config_element *ele)
 			if (sscanf(str, "%04x", &id) != 1)
 				goto fail;
 
-			id |= VENDOR_ID_MASK;
 		} else if (len == 8) {
 			if (sscanf(str, "%08x", &id) != 1)
 				goto fail;
+			mod->vendor = true;
 		} else
 			goto fail;
 
 		mod->id = id;
 
-		if (len == 8)
-			mod->vendor = true;
-
 		if (json_object_object_get_ex(jmodel, "bind", &jarray)) {
 			if (json_object_get_type(jarray) != json_type_array ||
 					!parse_bindings(jarray, mod))
diff --git a/mesh/model.c b/mesh/model.c
index afac6ec69..31197b363 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2020  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -54,7 +54,6 @@ struct mesh_model {
 	bool sub_enabled;
 	bool pub_enabled;
 	uint32_t id;
-	uint8_t ele_idx;
 };
 
 struct mesh_virtual {
@@ -131,44 +130,42 @@ static bool find_virt_by_label(const void *a, const void *b)
 
 static bool match_model_id(const void *a, const void *b)
 {
-	const struct mesh_model *model = a;
+	const struct mesh_model *mod = a;
 	uint32_t id = L_PTR_TO_UINT(b);
 
-	return (mesh_model_get_model_id(model) == id);
+	return (mod->id == id);
 }
 
-static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
-						uint32_t id, int *status)
+static int compare_model_id(const void *a, const void *b, void *user_data)
 {
-	struct l_queue *models;
-	struct mesh_model *model;
+	const struct mesh_model *mod_a = a;
+	const struct mesh_model *mod_b = b;
 
-	models = node_get_element_models(node, ele_idx, status);
-	if (!models) {
-		*status = MESH_STATUS_INVALID_MODEL;
-		return NULL;
-	}
-
-	model = l_queue_find(models, match_model_id, L_UINT_TO_PTR(id));
+	if (mod_a->id < mod_b->id)
+		return -1;
 
-	*status = (model) ? MESH_STATUS_SUCCESS : MESH_STATUS_INVALID_MODEL;
+	if (mod_a->id > mod_b->id)
+		return 1;
 
-	return model;
+	return 0;
 }
 
-static struct mesh_model *find_model(struct mesh_node *node, uint16_t addr,
-						uint32_t mod_id, int *status)
+static struct mesh_model *get_model(struct mesh_node *node, uint8_t ele_idx,
+								uint32_t id)
 {
-	int ele_idx;
-
-	ele_idx = node_get_element_idx(node, addr);
+	struct l_queue *mods;
+	struct mesh_model *mod;
 
-	if (ele_idx < 0) {
-		*status = MESH_STATUS_INVALID_ADDRESS;
+	mods = node_get_element_models(node, ele_idx);
+	if (!mods)
 		return NULL;
-	}
 
-	return get_model(node, (uint8_t) ele_idx, mod_id, status);
+	mod = l_queue_find(mods, match_model_id, L_UINT_TO_PTR(id));
+
+	if (!mod)
+		l_debug("Model not found");
+
+	return mod;
 }
 
 static uint32_t pub_period_to_ms(uint8_t pub_period)
@@ -212,15 +209,17 @@ static struct l_dbus_message *create_config_update_msg(struct mesh_node *node,
 
 	*builder = l_dbus_message_builder_new(msg);
 
-	model_id = (uint16_t) id;
+	model_id = (uint16_t) MODEL_ID(id);
 
 	l_dbus_message_builder_append_basic(*builder, 'q', &model_id);
 
 	l_dbus_message_builder_enter_array(*builder, "{sv}");
 
-	if ((id & VENDOR_ID_MASK) != VENDOR_ID_MASK) {
-		uint16_t vendor = id >> 16;
-		dbus_append_dict_entry_basic(*builder, "Vendor", "q", &vendor);
+	if (IS_VENDOR(id)) {
+		uint16_t vendor_id = (uint16_t) VENDOR_ID(id);
+
+		dbus_append_dict_entry_basic(*builder, "Vendor", "q",
+								&vendor_id);
 	}
 
 	return msg;
@@ -268,15 +267,14 @@ static void append_dict_uint16_array(struct l_dbus_message_builder *builder,
 	l_dbus_message_builder_leave_dict(builder);
 }
 
-static void config_update_model_bindings(struct mesh_node *node,
+static void cfg_update_mod_bindings(struct mesh_node *node, uint16_t ele_idx,
 							struct mesh_model *mod)
 {
 	struct l_dbus *dbus = dbus_get_bus();
 	struct l_dbus_message *msg;
 	struct l_dbus_message_builder *builder;
 
-	msg = create_config_update_msg(node, mod->ele_idx, mod->id,
-								&builder);
+	msg = create_config_update_msg(node, ele_idx, mod->id, &builder);
 	if (!msg)
 		return;
 
@@ -331,15 +329,14 @@ done:
 	l_dbus_message_builder_leave_dict(builder);
 }
 
-static void config_update_model_subscriptions(struct mesh_node *node,
+static void cfg_update_model_subs(struct mesh_node *node, uint16_t ele_idx,
 							struct mesh_model *mod)
 {
 	struct l_dbus *dbus = dbus_get_bus();
 	struct l_dbus_message *msg;
 	struct l_dbus_message_builder *builder;
 
-	msg = create_config_update_msg(node, mod->ele_idx, mod->id,
-								&builder);
+	msg = create_config_update_msg(node, ele_idx, mod->id, &builder);
 	if (!msg)
 		return;
 
@@ -572,7 +569,8 @@ done:
 	return ret;
 }
 
-static void remove_pub(struct mesh_node *node, struct mesh_model *mod)
+static void remove_pub(struct mesh_node *node, uint16_t ele_idx,
+							struct mesh_model *mod)
 {
 	if (mod->pub) {
 		if (mod->pub->virt)
@@ -584,31 +582,31 @@ static void remove_pub(struct mesh_node *node, struct mesh_model *mod)
 
 	if (!mod->cbs)
 		/* External models */
-		config_update_model_pub_period(node, mod->ele_idx, mod->id, 0);
+		config_update_model_pub_period(node, ele_idx, mod->id, 0);
 	else if (mod->cbs && mod->cbs->pub)
 		/* Internal models */
 		mod->cbs->pub(NULL);
 }
 
-static void model_unbind_idx(struct mesh_node *node, struct mesh_model *mod,
-								uint16_t idx)
+static void model_unbind_idx(struct mesh_node *node, uint16_t ele_idx,
+					struct mesh_model *mod, uint16_t idx)
 {
 	l_queue_remove(mod->bindings, L_UINT_TO_PTR(idx));
 
 	if (!mod->cbs)
 		/* External model */
-		config_update_model_bindings(node, mod);
+		cfg_update_mod_bindings(node, ele_idx, mod);
 	else if (mod->cbs->bind)
 		/* Internal model */
 		mod->cbs->bind(idx, ACTION_DELETE);
 
 	/* Remove model publication if the publication key is unbound */
 	if (mod->pub && idx == mod->pub->idx)
-		remove_pub(node, mod);
+		remove_pub(node, ele_idx, mod);
 }
 
-static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
-								uint16_t idx)
+static void model_bind_idx(struct mesh_node *node, uint16_t ele_idx,
+					struct mesh_model *mod, uint16_t idx)
 {
 	if (!mod->bindings)
 		mod->bindings = l_queue_new();
@@ -619,7 +617,7 @@ static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
 
 	if (!mod->cbs)
 		/* External model */
-		config_update_model_bindings(node, mod);
+		cfg_update_mod_bindings(node, ele_idx, mod);
 	else if (mod->cbs->bind)
 		/* Internal model */
 		mod->cbs->bind(idx, ACTION_ADD);
@@ -628,19 +626,18 @@ static void model_bind_idx(struct mesh_node *node, struct mesh_model *mod,
 static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx, bool unbind)
 {
-	int status;
 	struct mesh_model *mod;
-	bool is_present, is_vendor;
+	bool is_present;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod) {
-		l_debug("Model not found");
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 	}
 
-	is_vendor = id < VENDOR_ID_MASK && id > 0xffff;
-	id = !is_vendor ? (id & 0xffff) : id;
-
 	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
 		return MESH_STATUS_INVALID_MODEL;
 
@@ -656,9 +653,10 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 		return MESH_STATUS_SUCCESS;
 
 	if (unbind) {
-		model_unbind_idx(node, mod, app_idx);
+		model_unbind_idx(node, ele_idx, mod, app_idx);
 		if (!mesh_config_model_binding_del(node_config_get(node),
-					addr, is_vendor, id, app_idx))
+							addr, IS_VENDOR(id),
+							id, app_idx))
 			return MESH_STATUS_STORAGE_FAIL;
 
 		l_debug("Unbind key %4.4x to model %8.8x", app_idx, mod->id);
@@ -668,11 +666,11 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (l_queue_length(mod->bindings) >= MAX_BINDINGS)
 		return MESH_STATUS_INSUFF_RESOURCES;
 
-	if (!mesh_config_model_binding_add(node_config_get(node),
-					addr, is_vendor, id, app_idx))
+	if (!mesh_config_model_binding_add(node_config_get(node), addr,
+						IS_VENDOR(id), id, app_idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
-	model_bind_idx(node, mod, app_idx);
+	model_bind_idx(node, ele_idx, mod, app_idx);
 
 	return MESH_STATUS_SUCCESS;
 
@@ -964,7 +962,6 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 
 	is_subscription = !(IS_UNICAST(dst));
 
-
 	for (i = 0; i < num_ele; i++) {
 		struct l_queue *models;
 
@@ -974,7 +971,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		forward.unicast = addr + i;
 		forward.has_dst = false;
 
-		models = node_get_element_models(node, i, NULL);
+		models = node_get_element_models(node, i);
 
 		/* Internal models */
 		l_queue_foreach(models, forward_model, &forward);
@@ -1023,16 +1020,15 @@ done:
 	return result;
 }
 
-int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
-				uint16_t src, uint8_t ttl,
-				const void *msg, uint16_t msg_len)
+int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
+				uint8_t ttl, const void *msg, uint16_t msg_len)
 {
 	struct mesh_net *net = node_get_net(node);
 	struct mesh_model *mod;
 	uint8_t *label = NULL;
 	uint16_t net_idx;
 	bool result;
-	int status;
+	int ele_idx;
 
 	if (!net || msg_len > 380)
 		return MESH_ERROR_INVALID_ARGS;
@@ -1041,14 +1037,16 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	if (src == 0)
 		src = mesh_net_get_address(net);
 
-	mod = find_model(node, src, mod_id, &status);
-	if (!mod) {
-		l_debug("model %x not found", mod_id);
+	ele_idx = node_get_element_idx(node, src);
+	if (ele_idx < 0)
+		return MESH_ERROR_NOT_FOUND;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
+	if (!mod)
 		return MESH_ERROR_NOT_FOUND;
-	}
 
 	if (!mod->pub) {
-		l_debug("publication doesn't exist (model %x)", mod_id);
+		l_debug("publication doesn't exist (model %x)", id);
 		return MESH_ERROR_DOES_NOT_EXIST;
 	}
 
@@ -1093,11 +1091,14 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			bool is_virt, uint16_t *dst)
 {
 	struct mesh_model *mod;
-	int status;
+	int status, ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->pub_enabled || (mod->cbs && !(mod->cbs->pub)))
 		return MESH_STATUS_INVALID_PUB_PARAM;
@@ -1110,7 +1111,7 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	 * remove the publication
 	 */
 	if (!is_virt && IS_UNASSIGNED(l_get_le16(pub_addr))) {
-		remove_pub(node, mod);
+		remove_pub(node, ele_idx, mod);
 		return MESH_STATUS_SUCCESS;
 	}
 
@@ -1134,7 +1135,7 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 	if (!mod->cbs)
 		/* External model */
-		config_update_model_pub_period(node, mod->ele_idx, id,
+		config_update_model_pub_period(node, ele_idx, id,
 						pub_period_to_ms(period));
 	else {
 		/* Internal model, call registered callbacks */
@@ -1149,10 +1150,18 @@ struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node, uint16_t addr,
 						uint32_t mod_id, int *status)
 {
 	struct mesh_model *mod;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, mod_id, status);
-	if (!mod)
+	if (ele_idx < 0) {
+		*status = MESH_STATUS_INVALID_ADDRESS;
+		return NULL;
+	}
+
+	mod = get_model(node, (uint8_t) ele_idx, mod_id);
+	if (!mod) {
+		*status = MESH_STATUS_INVALID_MODEL;
 		return NULL;
+	}
 
 	if (!mod->pub_enabled || (mod->cbs && !(mod->cbs->pub)))
 		*status = MESH_STATUS_INVALID_PUB_PARAM;
@@ -1173,12 +1182,25 @@ void mesh_model_free(void *data)
 	l_free(mod);
 }
 
-struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t id)
+static void remove_subs(struct mesh_node *node, struct mesh_model *mod)
+{
+	const struct l_queue_entry *entry;
+	struct mesh_net *net = node_get_net(node);
+
+	entry = l_queue_get_entries(mod->subs);
+
+	for (; entry; entry = entry->next)
+		mesh_net_dst_unreg(net, (uint16_t) L_PTR_TO_UINT(entry->data));
+
+	l_queue_clear(mod->subs, NULL);
+	l_queue_clear(mod->virtuals, unref_virt);
+}
+
+static struct mesh_model *model_new(uint32_t id)
 {
 	struct mesh_model *mod = l_new(struct mesh_model, 1);
 
 	mod->id = id;
-	mod->ele_idx = ele_idx;
 	mod->virtuals = l_queue_new();
 
 	/*
@@ -1190,6 +1212,75 @@ struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t id)
 	return mod;
 }
 
+static void model_enable_pub(struct mesh_model *mod, bool enable)
+{
+	mod->pub_enabled = enable;
+
+	if (!mod->pub_enabled && mod->pub) {
+		if (mod->pub->virt)
+			unref_virt(mod->pub->virt);
+
+		l_free(mod->pub);
+		mod->pub = NULL;
+	}
+}
+
+static void model_enable_sub(struct mesh_node *node, struct mesh_model *mod,
+								bool enable)
+{
+	mod->sub_enabled = enable;
+
+	if (!mod->sub_enabled)
+		remove_subs(node, mod);
+}
+
+static bool get_model_options(struct mesh_model *mod,
+					struct l_dbus_message_iter *opts)
+{
+	const char *key;
+	struct l_dbus_message_iter var;
+	bool opt;
+
+	while (l_dbus_message_iter_next_entry(opts, &key, &var)) {
+
+		if (!strcmp(key, "Publish")) {
+			if (!l_dbus_message_iter_get_variant(&var, "b", &opt))
+				return false;
+
+			mod->pub_enabled = opt;
+		} else if (!strcmp(key, "Subscribe")) {
+			if (!l_dbus_message_iter_get_variant(&var, "b", &opt))
+				return false;
+
+			mod->sub_enabled = opt;
+		} else
+			return false;
+	}
+
+	return true;
+}
+
+bool mesh_model_add(struct mesh_node *node, struct l_queue *mods,
+			uint32_t id, struct l_dbus_message_iter *opts)
+{
+	struct mesh_model *mod;
+
+	/* Disallow duplicates */
+	mod = l_queue_find(mods, match_model_id, L_UINT_TO_PTR(id));
+	if (mod)
+		return false;
+
+	mod = model_new(id);
+
+	if (opts && !get_model_options(mod, opts)) {
+		mesh_model_free(mod);
+		return false;
+	}
+
+	l_queue_insert(mods, mod, compare_model_id, NULL);
+	return true;
+}
+
 /* Internal models only */
 static void restore_model_state(struct mesh_model *mod)
 {
@@ -1213,26 +1304,16 @@ static void restore_model_state(struct mesh_model *mod)
 
 }
 
-uint32_t mesh_model_get_model_id(const struct mesh_model *model)
-{
-	return model->id;
-}
-
 /* This registers an internal model, i.e. implemented within meshd */
-bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
-					uint32_t mod_id,
+bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx, uint32_t id,
 					const struct mesh_model_ops *cbs,
 					void *user_data)
 {
 	struct mesh_model *mod;
-	int status;
-
-	/* Internal models are always SIG models */
-	mod_id = VENDOR_ID_MASK | mod_id;
 
-	mod = get_model(node, ele_idx, mod_id, &status);
+	mod = get_model(node, ele_idx, id);
 	if (!mod)
-		return false;
+		return MESH_STATUS_INVALID_MODEL;
 
 	mod->cbs = cbs;
 	mod->user_data = user_data;
@@ -1242,15 +1323,15 @@ bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
 	return true;
 }
 
-void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
-							uint16_t app_idx)
+void mesh_model_app_key_delete(struct mesh_node *node, uint16_t ele_idx,
+				struct l_queue *models, uint16_t app_idx)
 {
 	const struct l_queue_entry *entry = l_queue_get_entries(models);
 
 	for (; entry; entry = entry->next) {
-		struct mesh_model *model = entry->data;
+		struct mesh_model *mod = entry->data;
 
-		model_unbind_idx(node, model, app_idx);
+		model_unbind_idx(node, ele_idx, mod, app_idx);
 	}
 }
 
@@ -1269,18 +1350,20 @@ int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
 				uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
-	int status;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
 	uint16_t n;
 	uint32_t idx_pair;
-	int i;
+	int i, ele_idx = node_get_element_idx(node, addr);
+
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
 
-	mod = find_model(node, addr, id, &status);
+	mod = get_model(node, (uint8_t) ele_idx, id);
 
 	if (!mod) {
 		*size = 0;
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 	}
 
 	entry = l_queue_get_entries(mod->bindings);
@@ -1325,14 +1408,17 @@ done:
 int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
-	int status;
 	int16_t n;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1370,12 +1456,15 @@ int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
-	int status;
 	struct mesh_model *mod;
+	int status, ele_idx = node_get_element_idx(node, addr);
+
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
 
-	mod = find_model(node, addr, id, &status);
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1387,7 +1476,7 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 	if (!mod->cbs)
 		/* External models */
-		config_update_model_subscriptions(node, mod);
+		cfg_update_model_subs(node, ele_idx, mod);
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -1395,13 +1484,16 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
-	int status;
 	struct l_queue *virtuals, *subs;
 	struct mesh_model *mod;
+	int status, ele_idx = node_get_element_idx(node, addr);
+
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
 
-	mod = find_model(node, addr, id, &status);
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1439,7 +1531,7 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 	if (!mod->cbs)
 		/* External models */
-		config_update_model_subscriptions(node, mod);
+		cfg_update_model_subs(node, ele_idx, mod);
 
 	return status;
 }
@@ -1447,13 +1539,16 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *group, bool is_virt, uint16_t *dst)
 {
-	int status;
 	uint16_t grp;
 	struct mesh_model *mod;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1481,34 +1576,23 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 		if (!mod->cbs)
 			/* External models */
-			config_update_model_subscriptions(node, mod);
+			cfg_update_model_subs(node, ele_idx, mod);
 	}
 
 	return MESH_STATUS_SUCCESS;
 }
 
-static void remove_subs(struct mesh_node *node, struct mesh_model *mod)
-{
-	const struct l_queue_entry *entry;
-	struct mesh_net *net = node_get_net(node);
-
-	entry = l_queue_get_entries(mod->subs);
-
-	for (; entry; entry = entry->next)
-		mesh_net_dst_unreg(net, (uint16_t) L_PTR_TO_UINT(entry->data));
-
-	l_queue_clear(mod->subs, NULL);
-	l_queue_clear(mod->virtuals, unref_virt);
-}
-
 int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 {
-	int status;
 	struct mesh_model *mod;
+	int ele_idx = node_get_element_idx(node, addr);
 
-	mod = find_model(node, addr, id, &status);
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
 	if (!mod)
-		return status;
+		return MESH_STATUS_INVALID_MODEL;
 
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
@@ -1517,17 +1601,15 @@ int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 
 	if (!mod->cbs)
 		/* External models */
-		config_update_model_subscriptions(node, mod);
+		cfg_update_model_subs(node, ele_idx, mod);
 
 	return MESH_STATUS_SUCCESS;
 }
 
-struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
-								void *data)
+static struct mesh_model *model_setup(struct mesh_net *net, uint8_t ele_idx,
+					struct mesh_config_model *db_mod)
 {
-	struct mesh_config_model *db_mod = data;
 	struct mesh_model *mod;
-	struct mesh_net *net;
 	struct mesh_config_pub *pub = db_mod->pub;
 	uint32_t i;
 
@@ -1537,8 +1619,8 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 		return NULL;
 	}
 
-	mod = mesh_model_new(ele_idx, db_mod->vendor ? db_mod->id :
-						db_mod->id | VENDOR_ID_MASK);
+	mod = model_new(db_mod->vendor ? db_mod->id :
+						SET_ID(SIG_VENDOR, db_mod->id));
 
 	/* Implicitly bind config server model to device key */
 	if (db_mod->id == CONFIG_SRV_MODEL) {
@@ -1557,17 +1639,18 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 		return mod;
 	}
 
-	net = node_get_net(node);
-
 	/* Add application key bindings if present */
 	if (db_mod->bindings) {
 		mod->bindings = l_queue_new();
 		for (i = 0; i < db_mod->num_bindings; i++)
-			model_bind_idx(node, mod, db_mod->bindings[i]);
+			l_queue_push_tail(mod->bindings,
+					L_UINT_TO_PTR(db_mod->bindings[i]));
 	}
 
-	/* Add publication if present */
-	if (pub) {
+	mod->pub_enabled = db_mod->pub_enabled;
+
+	/* Add publication if enabled and present */
+	if (mod->pub_enabled && pub) {
 		uint8_t retransmit = pub->count +
 					((pub->interval / 50 - 1) << 3);
 		if (pub->virt)
@@ -1579,8 +1662,10 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 				pub->ttl, pub->period, retransmit);
 	}
 
-	/* Add subscriptions if present */
-	if (!db_mod->subs)
+	mod->sub_enabled = db_mod->sub_enabled;
+
+	/* Add subscriptions if enabled and present */
+	if (!db_mod->subs || !mod->sub_enabled)
 		return mod;
 
 	for (i = 0; i < db_mod->num_subs; i++) {
@@ -1605,6 +1690,60 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 	return mod;
 }
 
+bool mesh_model_add_from_storage(struct mesh_node *node, uint8_t ele_idx,
+				struct l_queue *mods, struct l_queue *db_mods)
+{
+	struct mesh_net *net = node_get_net(node);
+	const struct l_queue_entry *entry;
+
+	/* Allow empty elements */
+	if (!db_mods)
+		return true;
+
+	entry = l_queue_get_entries(db_mods);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod;
+		struct mesh_config_model *db_mod;
+		uint32_t id;
+
+		db_mod = entry->data;
+
+		id = db_mod->vendor ? db_mod->id :
+						SET_ID(SIG_VENDOR, db_mod->id);
+
+		if (l_queue_find(mods, match_model_id, L_UINT_TO_PTR(id)))
+			return false;
+
+		mod = model_setup(net, ele_idx, db_mod);
+		if (!mod)
+			return false;
+
+		l_queue_insert(mods, mod, compare_model_id, NULL);
+	}
+
+	return true;
+}
+
+void mesh_model_convert_to_storage(struct l_queue *db_mods,
+							struct l_queue *mods)
+{
+
+	const struct l_queue_entry *entry = l_queue_get_entries(mods);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod = entry->data;
+		struct mesh_config_model *db_mod;
+
+		db_mod = l_new(struct mesh_config_model, 1);
+		db_mod->id = mod->id;
+		db_mod->vendor = IS_VENDOR(mod->id);
+		db_mod->pub_enabled = mod->pub_enabled;
+		db_mod->sub_enabled = mod->sub_enabled;
+		l_queue_push_tail(db_mods, db_mod);
+	}
+}
+
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf)
 {
 	if (opcode <= 0x7e) {
@@ -1669,7 +1808,7 @@ bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size,
 	return true;
 }
 
-void model_build_config(void *model, void *msg_builder)
+void mesh_model_build_config(void *model, void *msg_builder)
 {
 	struct l_dbus_message_builder *builder = msg_builder;
 	struct mesh_model *mod = model;
@@ -1685,14 +1824,14 @@ void model_build_config(void *model, void *msg_builder)
 	l_dbus_message_builder_enter_struct(builder, "qa{sv}");
 
 	/* Model id */
-	id = mod->id & 0xffff;
+	id = MODEL_ID(mod->id);
 	l_dbus_message_builder_append_basic(builder, 'q', &id);
 
 	l_dbus_message_builder_enter_array(builder, "{sv}");
 
 	/* For vendor models, add vendor id */
-	if ((mod->id & VENDOR_ID_MASK) != VENDOR_ID_MASK) {
-		uint16_t vendor = mod->id >> 16;
+	if (IS_VENDOR(mod->id)) {
+		uint16_t vendor = VENDOR_ID(mod->id);
 		dbus_append_dict_entry_basic(builder, "Vendor", "q", &vendor);
 	}
 
@@ -1715,36 +1854,101 @@ void model_build_config(void *model, void *msg_builder)
 	l_dbus_message_builder_leave_struct(builder);
 }
 
-void mesh_model_enable_pub(struct mesh_model *mod, bool enable)
+void mesh_model_update_opts(struct mesh_node *node, uint8_t ele_idx,
+				struct l_queue *curr, struct l_queue *updated)
 {
-	mod->pub_enabled = enable;
+	uint16_t primary;
+	const struct l_queue_entry *entry;
 
-	if (!mod->pub_enabled && mod->pub) {
-		if (mod->pub->virt)
-			unref_virt(mod->pub->virt);
+	primary = node_get_primary(node);
+	entry = l_queue_get_entries(curr);
 
-		l_free(mod->pub);
-		mod->pub = NULL;
-	}
-}
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod, *updated_mod = entry->data;
+		uint32_t id = updated_mod->id;
+		bool updated_opt, vendor = IS_VENDOR(id);
 
-bool mesh_model_is_pub_enabled(struct mesh_model *mod)
-{
-	return mod->pub_enabled;
-}
+		mod = l_queue_find(curr, match_model_id, L_UINT_TO_PTR(id));
+		if (!mod)
+			continue;
 
-void mesh_model_enable_sub(struct mesh_node *node, struct mesh_model *mod,
-								bool enable)
-{
-	mod->sub_enabled = enable;
+		if (!vendor)
+			id = MODEL_ID(id);
 
-	if (!mod->sub_enabled)
-		remove_subs(node, mod);
+		updated_opt = updated_mod->pub_enabled;
+		if (mod->pub_enabled != updated_opt) {
+			model_enable_pub(mod, updated_opt);
+			mesh_config_model_pub_enable(node_config_get(node),
+							primary + ele_idx, id,
+							vendor, updated_opt);
+		}
+
+		updated_opt = updated_mod->sub_enabled;
+
+		if (mod->pub_enabled != updated_opt) {
+			model_enable_sub(node, mod, updated_opt);
+			mesh_config_model_sub_enable(node_config_get(node),
+							primary + ele_idx, id,
+							vendor, updated_opt);
+			}
+		}
 }
 
-bool mesh_model_is_sub_enabled(struct mesh_model *mod)
+/* Populate composition buffer with model IDs */
+uint16_t mesh_model_generate_composition(struct l_queue *mods, uint16_t buf_sz,
+								uint8_t *buf)
 {
-	return mod->sub_enabled;
+	const struct l_queue_entry *entry;
+	uint8_t num_s = 0, num_v = 0;
+	uint8_t *mod_buf;
+	uint16_t n;
+
+	/* Store models IDs, store num_s and num_v later */
+	mod_buf = buf;
+	n = 2;
+
+	entry = l_queue_get_entries(mods);
+
+	/* Get SIG models */
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod = entry->data;
+
+		if (n + 2 > buf_sz)
+			goto done;
+
+		if (IS_VENDOR(mod->id))
+			continue;
+
+		l_put_le16((uint16_t) (MODEL_ID(mod->id)), buf + n);
+		n += 2;
+		num_s++;
+	}
+
+	/* Get vendor models */
+	entry = l_queue_get_entries(mods);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod = entry->data;
+		uint16_t vendor_id;
+
+		if (n + 4 > buf_sz)
+			goto done;
+
+		if (!IS_VENDOR(mod->id))
+			continue;
+
+		vendor_id = (uint16_t) (VENDOR_ID(mod->id));
+		l_put_le16(vendor_id, buf + n);
+		n += 2;
+		l_put_le16((uint16_t) (MODEL_ID(mod->id)), buf + n);
+		n += 2;
+		num_v++;
+	}
+
+done:
+	mod_buf[0] = num_s;
+	mod_buf[1] = num_v;
+	return n;
 }
 
 void mesh_model_init(void)
diff --git a/mesh/model.h b/mesh/model.h
index 0377d3fdd..0d8dddf92 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2020  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -22,14 +22,17 @@ struct mesh_model;
 #define MAX_BINDINGS	10
 #define MAX_GRP_PER_MOD	10
 
-#define OP_MODEL_TEST			0x8000fffe
-#define OP_MODEL_INVALID		0x8000ffff
+#define ACTION_ADD	1
+#define ACTION_UPDATE	2
+#define ACTION_DELETE	3
 
-#define USE_PUB_VALUE			0x00
+/* For internal representation of SIG defined models */
+#define SIG_VENDOR	0xFFFF
 
-#define ACTION_ADD		1
-#define ACTION_UPDATE		2
-#define ACTION_DELETE		3
+#define IS_VENDOR(x)	((x) < ((uint32_t)(SIG_VENDOR) << 16))
+#define SET_ID(v, m)	((((uint32_t) (v)) << 16) | (m))
+#define MODEL_ID(x)	((x) & ~VENDOR_ID_MASK)
+#define VENDOR_ID(x)	((x) >> 16)
 
 struct mesh_virtual;
 
@@ -60,61 +63,62 @@ struct mesh_model_ops {
 	mesh_model_sub_cb sub;
 };
 
-struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t mod_id);
+bool mesh_model_add(struct mesh_node *node, struct l_queue *mods,
+			uint32_t id, struct l_dbus_message_iter *opts);
 void mesh_model_free(void *data);
-uint32_t mesh_model_get_model_id(const struct mesh_model *model);
 bool mesh_model_register(struct mesh_node *node, uint8_t ele_idx,
-			uint32_t mod_id, const struct mesh_model_ops *cbs,
+			uint32_t id, const struct mesh_model_ops *cbs,
 							void *user_data);
-struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
-								void *data);
+bool mesh_model_add_from_storage(struct mesh_node *node, uint8_t ele_idx,
+				struct l_queue *mods, struct l_queue *db_mods);
+void mesh_model_convert_to_storage(struct l_queue *db_mods,
+							struct l_queue *mods);
 struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
-				uint16_t addr, uint32_t mod_id, int *status);
-int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *pub_addr, uint16_t idx, bool cred_flag,
+						uint16_t ele_addr,
+						uint32_t id, int *status);
+int mesh_model_pub_set(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
+			const uint8_t *addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit,
 			bool is_virt, uint16_t *dst);
 
-int mesh_model_binding_add(struct mesh_node *node, uint16_t addr, uint32_t id,
-								uint16_t idx);
-int mesh_model_binding_del(struct mesh_node *node, uint16_t addr, uint32_t id,
-								uint16_t idx);
-int mesh_model_get_bindings(struct mesh_node *node, uint16_t addr, uint32_t id,
-				uint8_t *buf, uint16_t buf_len, uint16_t *size);
-int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
+int mesh_model_binding_add(struct mesh_node *node, uint16_t ele_addr,
+						uint32_t id, uint16_t idx);
+int mesh_model_binding_del(struct mesh_node *node, uint16_t ele_addr,
+						uint32_t id, uint16_t idx);
+int mesh_model_get_bindings(struct mesh_node *node, uint16_t ele_addr,
+				uint32_t id, uint8_t *buf, uint16_t buf_sz,
+								uint16_t *len);
+int mesh_model_sub_add(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 				const uint8_t *grp, bool b_virt, uint16_t *dst);
-int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
+int mesh_model_sub_del(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 				const uint8_t *grp, bool b_virt, uint16_t *dst);
 int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id);
 int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 				const uint8_t *grp, bool b_virt, uint16_t *dst);
-int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
+int mesh_model_sub_get(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size);
 uint16_t mesh_model_cfg_blk(uint8_t *pkt);
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint16_t app_idx, uint16_t net_idx,
 					uint8_t ttl, bool segmented,
 					const void *msg, uint16_t msg_len);
-int mesh_model_publish(struct mesh_node *node, uint32_t mod_id, uint16_t src,
+int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
 				uint8_t ttl, const void *msg, uint16_t msg_len);
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint16_t net_idx,
 			uint16_t src, uint16_t dst, uint8_t key_aid,
 			const uint8_t *data, uint16_t size);
 void mesh_model_app_key_generate_new(struct mesh_node *node, uint16_t net_idx);
-void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
-								uint16_t idx);
+void mesh_model_app_key_delete(struct mesh_node *node, uint16_t ele_idx,
+				struct l_queue *models, uint16_t app_idx);
 struct l_queue *mesh_model_get_appkeys(struct mesh_node *node);
 uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf);
 bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size, uint32_t *opcode,
 								uint16_t *n);
-void model_build_config(void *model, void *msg_builder);
-
-void mesh_model_enable_pub(struct mesh_model *mod, bool enable);
-bool mesh_model_is_pub_enabled(struct mesh_model *mod);
-void mesh_model_enable_sub(struct mesh_node *node, struct mesh_model *mod,
-								bool enable);
-bool mesh_model_is_sub_enabled(struct mesh_model *mod);
-
+void mesh_model_build_config(void *model, void *msg_builder);
+void mesh_model_update_opts(struct mesh_node *node, uint8_t ele_idx,
+				struct l_queue *curr, struct l_queue *updated);
+uint16_t mesh_model_generate_composition(struct l_queue *mods, uint16_t buf_sz,
+								uint8_t *buf);
 void mesh_model_init(void);
 void mesh_model_cleanup(void);
diff --git a/mesh/node.c b/mesh/node.c
index 9b97aa927..3dca73cef 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2020  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -186,28 +186,6 @@ static bool match_element_path(const void *a, const void *b)
 	return (!strcmp(element->path, path));
 }
 
-static bool match_model_id(const void *a, const void *b)
-{
-	const struct mesh_model *mod = a;
-	uint32_t mod_id = L_PTR_TO_UINT(b);
-
-	return mesh_model_get_model_id(mod) == mod_id;
-}
-
-static int compare_model_id(const void *a, const void *b, void *user_data)
-{
-	uint32_t a_id = mesh_model_get_model_id(a);
-	uint32_t b_id = mesh_model_get_model_id(b);
-
-	if (a_id < b_id)
-		return -1;
-
-	if (a_id > b_id)
-		return 1;
-
-	return 0;
-}
-
 struct mesh_node *node_find_by_uuid(uint8_t uuid[16])
 {
 	return l_queue_find(nodes, match_device_uuid, uuid);
@@ -225,25 +203,6 @@ uint8_t *node_uuid_get(struct mesh_node *node)
 	return node->uuid;
 }
 
-static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
-								uint8_t ele_idx)
-{
-	struct node_element *ele;
-	struct mesh_model *mod;
-
-	ele = l_queue_find(node->elements, match_element_idx,
-							L_UINT_TO_PTR(ele_idx));
-	if (!ele)
-		return;
-
-	if (l_queue_find(ele->models, match_model_id, L_UINT_TO_PTR(mod_id)))
-		return;
-
-	mod = mesh_model_new(ele_idx, mod_id);
-
-	l_queue_insert(ele->models, mod, compare_model_id, NULL);
-}
-
 static void set_defaults(struct mesh_node *node)
 {
 	node->lpn = MESH_MODE_UNSUPPORTED;
@@ -359,46 +318,6 @@ void node_remove(struct mesh_node *node)
 	free_node_resources(node);
 }
 
-static bool add_models_from_storage(struct mesh_node *node,
-					struct node_element *ele,
-					struct mesh_config_element *db_ele)
-{
-	const struct l_queue_entry *entry;
-
-	if (!ele->models)
-		ele->models = l_queue_new();
-
-	entry = l_queue_get_entries(db_ele->models);
-
-	for (; entry; entry = entry->next) {
-		struct mesh_model *mod;
-		struct mesh_config_model *db_mod;
-		uint32_t id;
-
-		db_mod = entry->data;
-
-		id = db_mod->vendor ? db_mod->id : db_mod->id | VENDOR_ID_MASK;
-
-		if (l_queue_find(ele->models, match_model_id,
-							L_UINT_TO_PTR(id)))
-			return false;
-
-		mod = mesh_model_setup(node, ele->idx, db_mod);
-		if (!mod)
-			return false;
-
-		if (!db_mod->pub_enabled)
-			mesh_model_enable_pub(mod, false);
-
-		if (!db_mod->sub_enabled)
-			mesh_model_enable_sub(node, mod, false);
-
-		l_queue_insert(ele->models, mod, compare_model_id, NULL);
-	}
-
-	return true;
-}
-
 static bool add_element_from_storage(struct mesh_node *node,
 					struct mesh_config_element *db_ele)
 {
@@ -411,7 +330,12 @@ static bool add_element_from_storage(struct mesh_node *node,
 	ele->idx = db_ele->index;
 	ele->location = db_ele->location;
 
-	if (!db_ele->models || !add_models_from_storage(node, ele, db_ele))
+
+	if (!ele->models)
+		ele->models = l_queue_new();
+
+	if (!mesh_model_add_from_storage(node, ele->idx, ele->models,
+							db_ele->models))
 		return false;
 
 	l_queue_push_tail(node->elements, ele);
@@ -424,12 +348,13 @@ static bool add_elements_from_storage(struct mesh_node *node,
 	const struct l_queue_entry *entry;
 
 	entry = l_queue_get_entries(db_node->elements);
+
 	for (; entry; entry = entry->next)
 		if (!add_element_from_storage(node, entry->data))
 			return false;
 
 	/* Add configuration server model on the primary element */
-	add_internal_model(node, CONFIG_SRV_MODEL, PRIMARY_ELE_IDX);
+	mesh_model_add(node, PRIMARY_ELE_IDX, CONFIG_SRV_MODEL, NULL);
 
 	return true;
 }
@@ -628,7 +553,7 @@ void node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
 	for (; entry; entry = entry->next) {
 		struct node_element *ele = entry->data;
 
-		mesh_model_app_key_delete(node, ele->models, app_idx);
+		mesh_model_app_key_delete(node, ele->idx, ele->models, app_idx);
 	}
 }
 
@@ -666,27 +591,17 @@ uint8_t node_get_num_elements(struct mesh_node *node)
 	return node->num_ele;
 }
 
-struct l_queue *node_get_element_models(struct mesh_node *node,
-						uint8_t ele_idx, int *status)
+struct l_queue *node_get_element_models(struct mesh_node *node, uint8_t ele_idx)
 {
 	struct node_element *ele;
 
-	if (!node) {
-		if (status)
-			*status = MESH_STATUS_INVALID_ADDRESS;
+	if (!node)
 		return NULL;
-	}
 
 	ele = l_queue_find(node->elements, match_element_idx,
 							L_UINT_TO_PTR(ele_idx));
-	if (!ele) {
-		if (status)
-			*status = MESH_STATUS_INVALID_ADDRESS;
+	if (!ele)
 		return NULL;
-	}
-
-	if (status)
-		*status = MESH_STATUS_SUCCESS;
 
 	return ele->models;
 }
@@ -888,9 +803,8 @@ uint8_t node_friend_mode_get(struct mesh_node *node)
 static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
 								uint16_t sz)
 {
-	uint16_t n, features;
-	uint16_t num_ele = 0;
-	const struct l_queue_entry *ele_entry;
+	uint16_t n, features, num_ele = 0;
+	const struct l_queue_entry *entry;
 
 	if (!node || sz < MIN_COMP_SIZE)
 		return 0;
@@ -920,12 +834,10 @@ static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
 	l_put_le16(features, buf + n);
 	n += 2;
 
-	ele_entry = l_queue_get_entries(node->elements);
-	for (; ele_entry; ele_entry = ele_entry->next) {
-		struct node_element *ele = ele_entry->data;
-		const struct l_queue_entry *mod_entry;
-		uint8_t num_s = 0, num_v = 0;
-		uint8_t *mod_buf;
+	entry = l_queue_get_entries(node->elements);
+
+	for (; entry; entry = entry->next) {
+		struct node_element *ele = entry->data;
 
 		if (ele->idx != num_ele)
 			return 0;
@@ -939,59 +851,8 @@ static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
 		l_put_le16(ele->location, buf + n);
 		n += 2;
 
-		/* Store models IDs, store num_s and num_v later */
-		mod_buf = buf + n;
-		n += 2;
-
-		/* Get SIG models */
-		mod_entry = l_queue_get_entries(ele->models);
-		for (; mod_entry; mod_entry = mod_entry->next) {
-			struct mesh_model *mod = mod_entry->data;
-			uint32_t mod_id;
-
-			mod_id = mesh_model_get_model_id(
-					(const struct mesh_model *) mod);
-
-			if ((mod_id & VENDOR_ID_MASK) == VENDOR_ID_MASK) {
-				if (n + 2 > sz)
-					goto element_done;
-
-				l_put_le16((uint16_t) (mod_id & 0xffff),
-								buf + n);
-				n += 2;
-				num_s++;
-			}
-		}
-
-		/* Get vendor models */
-		mod_entry = l_queue_get_entries(ele->models);
-		for (; mod_entry; mod_entry = mod_entry->next) {
-			struct mesh_model *mod = mod_entry->data;
-			uint32_t mod_id;
-			uint16_t vendor;
-
-			mod_id = mesh_model_get_model_id(
-					(const struct mesh_model *) mod);
-
-			vendor = (uint16_t) (mod_id >> 16);
-			if (vendor != 0xffff) {
-				if (n + 4 > sz)
-					goto element_done;
-
-				l_put_le16(vendor, buf + n);
-				n += 2;
-				l_put_le16((uint16_t) (mod_id & 0xffff),
+		n += mesh_model_generate_composition(ele->models, sz - n,
 								buf + n);
-				n += 2;
-				num_v++;
-			}
-
-		}
-
-element_done:
-		mod_buf[0] = num_s;
-		mod_buf[1] = num_v;
-
 	}
 
 	if (!num_ele)
@@ -1128,52 +989,6 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	free_node_dbus_resources(node);
 }
 
-static bool get_model_options(struct mesh_node *node, struct mesh_model *mod,
-					struct l_dbus_message_iter *opts)
-{
-	const char *key;
-	struct l_dbus_message_iter var;
-	bool opt;
-
-	while (l_dbus_message_iter_next_entry(opts, &key, &var)) {
-
-		if (!strcmp(key, "Publish")) {
-			if (!l_dbus_message_iter_get_variant(&var, "b", &opt))
-				return false;
-			mesh_model_enable_pub(mod, opt);
-		} else if (!strcmp(key, "Subscribe")) {
-			if (!l_dbus_message_iter_get_variant(&var, "b", &opt))
-				return false;
-			mesh_model_enable_sub(node, mod, opt);
-		} else
-			return false;
-	}
-
-	return true;
-}
-
-static bool generate_model(struct mesh_node *node, struct node_element *ele,
-				uint32_t id, struct l_dbus_message_iter *opts)
-{
-	struct mesh_model *mod;
-
-	/* Disallow duplicates */
-	if (l_queue_find(ele->models, match_model_id,
-			 L_UINT_TO_PTR(id)))
-		return false;
-
-	mod = mesh_model_new(ele->idx, id);
-
-	if (!get_model_options(node, mod, opts)) {
-		l_free(mod);
-		return false;
-	}
-
-	l_queue_insert(ele->models, mod, compare_model_id, NULL);
-
-	return true;
-}
-
 static bool get_sig_models_from_properties(struct mesh_node *node,
 					struct node_element *ele,
 					struct l_dbus_message_iter *property)
@@ -1189,13 +1004,13 @@ static bool get_sig_models_from_properties(struct mesh_node *node,
 
 	/* Bluetooth SIG defined models */
 	while (l_dbus_message_iter_next_entry(&mods, &m_id, &var)) {
-		uint32_t id = m_id | VENDOR_ID_MASK;
+		uint32_t id = SET_ID(SIG_VENDOR, m_id);
 
 		/* Allow Config Server Model only on the primary element */
 		if (ele->idx != PRIMARY_ELE_IDX && id == CONFIG_SRV_MODEL)
 			return false;
 
-		if (!generate_model(node, ele, id, &var))
+		if (!mesh_model_add(node, ele->models, id, &var))
 			return false;
 	}
 
@@ -1217,9 +1032,9 @@ static bool get_vendor_models_from_properties(struct mesh_node *node,
 
 	/* Vendor defined models */
 	while (l_dbus_message_iter_next_entry(&mods, &v_id, &m_id, &var)) {
-		uint32_t id = m_id | (v_id << 16);
+		uint32_t id = SET_ID(v_id, m_id);
 
-		if (!generate_model(node, ele, id, &var))
+		if (!mesh_model_add(node, ele->models, id, &var))
 			return false;
 	}
 
@@ -1295,7 +1110,7 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 	 * the operation below will be a "no-op".
 	 */
 	if (ele->idx == PRIMARY_ELE_IDX)
-		add_internal_model(node, CONFIG_SRV_MODEL, PRIMARY_ELE_IDX);
+		mesh_model_add(node, ele->models, CONFIG_SRV_MODEL, NULL);
 
 	return true;
 fail:
@@ -1332,7 +1147,6 @@ static void convert_node_to_storage(struct mesh_node *node,
 	for (; entry; entry = entry->next) {
 		struct node_element *ele = entry->data;
 		struct mesh_config_element *db_ele;
-		const struct l_queue_entry *mod_entry;
 
 		db_ele = l_new(struct mesh_config_element, 1);
 
@@ -1340,21 +1154,8 @@ static void convert_node_to_storage(struct mesh_node *node,
 		db_ele->location = ele->location;
 		db_ele->models = l_queue_new();
 
-		mod_entry = l_queue_get_entries(ele->models);
-
-		for (; mod_entry; mod_entry = mod_entry->next) {
-			struct mesh_model *mod = mod_entry->data;
-			struct mesh_config_model *db_mod;
-			uint32_t mod_id = mesh_model_get_model_id(mod);
+		mesh_model_convert_to_storage(db_ele->models, ele->models);
 
-			db_mod = l_new(struct mesh_config_model, 1);
-			db_mod->id = mod_id;
-			db_mod->vendor = ((mod_id & VENDOR_ID_MASK)
-							!= VENDOR_ID_MASK);
-			db_mod->pub_enabled = mesh_model_is_pub_enabled(mod);
-			db_mod->sub_enabled = mesh_model_is_sub_enabled(mod);
-			l_queue_push_tail(db_ele->models, db_mod);
-		}
 		l_queue_push_tail(db_node->elements, db_ele);
 	}
 
@@ -1375,6 +1176,7 @@ static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 
 	/* Free temporarily allocated resources */
 	entry = l_queue_get_entries(db_node.elements);
+
 	for (; entry; entry = entry->next) {
 		struct mesh_config_element *db_ele = entry->data;
 
@@ -1517,7 +1319,6 @@ static void update_model_options(struct mesh_node *node,
 	len = l_queue_length(node->elements);
 
 	for (i = 0; i < len; i++) {
-		const struct l_queue_entry *entry;
 
 		ele = l_queue_find(node->elements, match_element_idx,
 							L_UINT_TO_PTR(i));
@@ -1526,42 +1327,8 @@ static void update_model_options(struct mesh_node *node,
 		if (!ele || !ele_attach)
 			continue;
 
-		entry = l_queue_get_entries(ele->models);
-
-		for (; entry; entry = entry->next) {
-			struct mesh_model *mod, *updated_mod = entry->data;
-			uint32_t id = mesh_model_get_model_id(updated_mod);
-			bool opt, updated_opt;
-			bool vendor = id < VENDOR_ID_MASK;
-
-			mod = l_queue_find(ele_attach->models, match_model_id,
-							L_UINT_TO_PTR(id));
-			if (!mod)
-				continue;
-
-			if (!vendor)
-				id &= ~VENDOR_ID_MASK;
-
-			opt = mesh_model_is_pub_enabled(mod);
-			updated_opt = mesh_model_is_pub_enabled(updated_mod);
-
-			if (updated_opt != opt) {
-				mesh_model_enable_pub(mod, updated_opt);
-				mesh_config_model_pub_enable(attach->cfg,
-							attach->primary + i, id,
-							vendor, updated_opt);
-			}
-
-			opt = mesh_model_is_sub_enabled(mod);
-			updated_opt = mesh_model_is_sub_enabled(updated_mod);
-
-			if (updated_opt != opt) {
-				mesh_model_enable_sub(node, mod, updated_opt);
-				mesh_config_model_sub_enable(attach->cfg,
-							attach->primary + i, id,
-							vendor, updated_opt);
-			}
-		}
+		mesh_model_update_opts(node, ele->idx, ele_attach->models,
+								ele->models);
 	}
 }
 
@@ -1964,7 +1731,7 @@ static void build_element_config(void *a, void *b)
 	l_dbus_message_builder_enter_array(builder, "(qa{sv})");
 
 	/* Iterate over models */
-	l_queue_foreach(ele->models, model_build_config, builder);
+	l_queue_foreach(ele->models, mesh_model_build_config, builder);
 
 	l_dbus_message_builder_leave_array(builder);
 
@@ -2216,8 +1983,8 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 	struct l_dbus_message_iter iter_data;
 	uint16_t mod_id, src;
 	struct node_element *ele;
-	uint8_t *data;
-	uint32_t len;
+	uint8_t *data, ttl;
+	uint32_t len, id;
 	int result;
 
 	l_debug("Publish");
@@ -2243,8 +2010,10 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	result = mesh_model_publish(node, VENDOR_ID_MASK | mod_id, src,
-				mesh_net_get_default_ttl(node->net), data, len);
+	ttl = mesh_net_get_default_ttl(node->net);
+
+	id = SET_ID(SIG_VENDOR, mod_id);
+	result = mesh_model_publish(node, id, src, ttl, data, len);
 
 	if (result != MESH_ERROR_NONE)
 		return dbus_error(msg, result, NULL);
@@ -2259,11 +2028,9 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	struct mesh_node *node = user_data;
 	const char *sender, *ele_path;
 	struct l_dbus_message_iter iter_data;
-	uint16_t src;
-	uint16_t model_id, vendor;
-	uint32_t vendor_mod_id;
+	uint16_t src, mod_id, vendor_id;
 	struct node_element *ele;
-	uint8_t *data = NULL;
+	uint8_t ttl, *data = NULL;
 	uint32_t len;
 	int result;
 
@@ -2274,8 +2041,8 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	if (strcmp(sender, node->owner))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &vendor,
-							&model_id, &iter_data))
+	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &vendor_id,
+							&mod_id, &iter_data))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	ele = l_queue_find(node->elements, match_element_path, ele_path);
@@ -2290,9 +2057,9 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	vendor_mod_id = (vendor << 16) | model_id;
-	result = mesh_model_publish(node, vendor_mod_id, src,
-				mesh_net_get_default_ttl(node->net), data, len);
+	ttl = mesh_net_get_default_ttl(node->net);
+	result = mesh_model_publish(node, SET_ID(vendor_id, mod_id), src, ttl,
+								data, len);
 
 	if (result != MESH_ERROR_NONE)
 		return dbus_error(msg, result, NULL);
diff --git a/mesh/node.h b/mesh/node.h
index df058458a..47c998530 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -58,8 +58,8 @@ bool node_default_ttl_set(struct mesh_node *node, uint8_t ttl);
 bool node_set_sequence_number(struct mesh_node *node, uint32_t seq);
 uint32_t node_get_sequence_number(struct mesh_node *node);
 int node_get_element_idx(struct mesh_node *node, uint16_t ele_addr);
-struct l_queue *node_get_element_models(struct mesh_node *node, uint8_t ele_idx,
-								int *status);
+struct l_queue *node_get_element_models(struct mesh_node *node,
+							uint8_t ele_idx);
 uint16_t node_get_crpl(struct mesh_node *node);
 bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
 					struct mesh_config_node *db_node);
-- 
2.26.2

