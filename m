Return-Path: <SRS0=vuCz=AH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF385C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 21:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D1A20FC3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 21:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgFZV7J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:59:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:8698 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgFZV7J (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jun 2020 17:59:09 -0400
IronPort-SDR: amwbMCzkKlOsE2Gg8rzVXuQuTzM+t8vs8qlEPpf/st61V5k+YUKdq6gUFkfABZ9JX3TiYJFJcP
 V6dRUaRm0jGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="133848062"
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="133848062"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 14:59:08 -0700
IronPort-SDR: 5SwvpHVd61PIOjgRpkUOm4z+bzjjrCQHgJC3l0e+cw0zw/q/NBons5kJzxDkwpgBRk8GZ6LRR8
 4BoCLwcGyZ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="453499799"
Received: from bathomso-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.230.165])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2020 14:59:08 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Clean up config model publication set
Date:   Fri, 26 Jun 2020 14:59:07 -0700
Message-Id: <20200626215907.201532-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

No functioal changes. Make code more readable, plus style fixes.
---
 mesh/cfgmod-server.c | 77 +++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 902228ae0..c525d9d24 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -46,12 +46,10 @@ static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 	n = mesh_model_opcode_set(OP_CONFIG_MODEL_PUB_STATUS, msg);
 	msg[n++] = status;
 	l_put_le16(ele_addr, msg + n);
-	n += 2;
-	l_put_le16(pub_addr, msg + n);
-	n += 2;
+	l_put_le16(pub_addr, msg + n + 2);
 	idx |= cred_flag ? CREDFLAG_MASK : 0;
-	l_put_le16(idx, msg + n);
-	n += 2;
+	l_put_le16(idx, msg + n + 4);
+	n += 6;
 	msg[n++] = ttl;
 	msg[n++] = period;
 	msg[n++] = retransmit;
@@ -61,16 +59,15 @@ static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 		n += 2;
 	} else {
 		l_put_le16(mod_id >> 16, msg + n);
-		n += 2;
-		l_put_le16(mod_id, msg + n);
-		n += 2;
+		l_put_le16(mod_id, msg + n + 2);
+		n += 4;
 	}
 
 	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
 								false, msg, n);
 }
 
-static bool config_pub_get(struct mesh_node *node, uint16_t net_idx,
+static void config_pub_get(struct mesh_node *node, uint16_t net_idx,
 					uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size)
 {
@@ -86,7 +83,7 @@ static bool config_pub_get(struct mesh_node *node, uint16_t net_idx,
 		mod_id = l_get_le16(pkt + 2) << 16;
 		mod_id |= l_get_le16(pkt + 4);
 	} else
-		return false;
+		return;
 
 	ele_addr = l_get_le16(pkt);
 	pub = mesh_model_pub_get(node, ele_addr, mod_id, &status);
@@ -98,16 +95,15 @@ static bool config_pub_get(struct mesh_node *node, uint16_t net_idx,
 	else
 		send_pub_status(node, net_idx, src, dst, status, ele_addr,
 				mod_id, 0, 0, 0, 0, 0, 0);
-	return true;
 }
 
 static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 					uint16_t src, uint16_t dst,
-					const uint8_t *pkt, uint8_t virt_offset,
+					const uint8_t *pkt, bool virt,
 					bool vendor, bool unreliable)
 {
 	uint32_t mod_id;
-	uint16_t ele_addr, idx, ota = 0;
+	uint16_t ele_addr, idx, ota = UNASSIGNED_ADDRESS;
 	const uint8_t *pub_addr;
 	uint16_t test_addr;
 	uint8_t ttl, period;
@@ -115,34 +111,33 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 	int status;
 	bool cred_flag;
 
-	idx = l_get_le16(pkt + 4 + virt_offset);
-	ttl = pkt[6 + virt_offset];
-	period = pkt[7 + virt_offset];
-	retransmit = pkt[8 + virt_offset];
-	mod_id = l_get_le16(pkt + 9 + virt_offset);
+	ele_addr = l_get_le16(pkt);
+	pub_addr = pkt + 2;
+
+	pkt += (virt ? 14 : 0);
+
+	idx = l_get_le16(pkt + 4);
+	ttl = pkt[6];
+	period = pkt[7];
+	retransmit = pkt[8];
+	mod_id = l_get_le16(pkt + 9);
 
 	if (!vendor)
 		mod_id |= VENDOR_ID_MASK;
 	else
-		mod_id = (mod_id << 16) | l_get_le16(pkt + 11 + virt_offset);
-
-	ele_addr = l_get_le16(pkt);
-	pub_addr = pkt + 2;
+		mod_id = (mod_id << 16) | l_get_le16(pkt + 11);
 
-	/* Doesn't accept virtual seeming addresses */
+	/* Don't accept virtual seeming addresses */
 	test_addr = l_get_le16(pub_addr);
-	if (!virt_offset && IS_VIRTUAL(test_addr))
+	if (!virt && IS_VIRTUAL(test_addr))
 		return;
 
-	/* Get cred_flag */
 	cred_flag = !!(CREDFLAG_MASK & idx);
-
-	/* Get AppKey index */
 	idx &= APP_IDX_MASK;
 
 	status = mesh_model_pub_set(node, ele_addr, mod_id, pub_addr, idx,
 					cred_flag, ttl, period, retransmit,
-					virt_offset != 0, &ota);
+					virt, &ota);
 
 	l_debug("pub_set: status %d, ea %4.4x, ota: %4.4x, mod: %x, idx: %3.3x",
 					status, ele_addr, ota, mod_id, idx);
@@ -155,16 +150,17 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 		return;
 	}
 
-	if (IS_UNASSIGNED(ota) && !virt_offset) {
+	if (IS_UNASSIGNED(test_addr) && !virt) {
 		ttl = period = idx = 0;
 
 		/* Remove model publication from config file */
-		mesh_config_model_pub_del(node_config_get(node), ele_addr,
+		if (!mesh_config_model_pub_del(node_config_get(node), ele_addr,
 				vendor ? mod_id : mod_id & ~VENDOR_ID_MASK,
-								vendor);
+									vendor))
+			status = MESH_STATUS_STORAGE_FAIL;
 	} else {
 		struct mesh_config_pub db_pub = {
-			.virt = (virt_offset != 0),
+			.virt = virt,
 			.addr = ota,
 			.idx = idx,
 			.ttl = ttl,
@@ -174,7 +170,7 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 			.interval = ((retransmit >> 3) + 1) * 50
 		};
 
-		if (virt_offset)
+		if (virt)
 			memcpy(db_pub.virt_addr, pub_addr, 16);
 
 		/* Save model publication to config file */
@@ -186,7 +182,8 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 
 	if (!unreliable)
 		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-			mod_id, ota, idx, cred_flag, ttl, period, retransmit);
+					mod_id, ota, idx, cred_flag, ttl,
+					period, retransmit);
 }
 
 static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
@@ -781,16 +778,16 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		if (size != 25 && size != 27)
 			return true;
 
-		config_pub_set(node, net_idx, src, dst, pkt, 14, size == 27,
-				!!(opcode & OP_UNRELIABLE));
-		break;
+		virt = true;
+		/* Fall Through */
 
 	case OP_CONFIG_MODEL_PUB_SET:
-		if (size != 11 && size != 13)
+		if (!virt && (size != 11 && size != 13))
 			return true;
 
-		config_pub_set(node, net_idx, src, dst, pkt, 0, size == 13,
-				!!(opcode & OP_UNRELIABLE));
+		config_pub_set(node, net_idx, src, dst, pkt, virt,
+						size == 13 || size == 27,
+						!!(opcode & OP_UNRELIABLE));
 		break;
 
 	case OP_CONFIG_MODEL_PUB_GET:
-- 
2.26.2

