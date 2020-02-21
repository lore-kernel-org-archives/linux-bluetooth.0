Return-Path: <SRS0=Dxuj=4J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7890C11D00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 02:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF4D20722
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 02:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgBUCST (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:18:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:20563 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgBUCST (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Feb 2020 21:18:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 18:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,466,1574150400"; 
   d="scan'208";a="230313331"
Received: from ingas-nuc1.sea.intel.com ([10.254.187.96])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2020 18:18:17 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4] mesh: Clean up handling config model publication message
Date:   Thu, 20 Feb 2020 18:18:11 -0800
Message-Id: <20200221021811.30408-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221021811.30408-1-inga.stotland@intel.com>
References: <20200221021811.30408-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This tightens up the Config Server code that handles the processing of
Config Model Publication Set and Config Model Publication Get messages.
---
 mesh/cfgmod-server.c | 131 +++++++++++++++----------------------------
 1 file changed, 44 insertions(+), 87 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 7111411c7..3eb7316fc 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -36,8 +36,8 @@
 
 static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 			uint16_t src, uint16_t dst,
-			uint8_t status, uint16_t ele_addr, uint16_t pub_addr,
-			uint32_t mod_id, uint16_t idx, bool cred_flag,
+			uint8_t status, uint16_t ele_addr, uint32_t mod_id,
+			uint16_t pub_addr, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit)
 {
 	uint8_t msg[16];
@@ -56,7 +56,7 @@ static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 	msg[n++] = period;
 	msg[n++] = retransmit;
 
-	if (mod_id < 0x10000 || mod_id > VENDOR_ID_MASK) {
+	if (mod_id >= VENDOR_ID_MASK) {
 		l_put_le16(mod_id, msg + n);
 		n += 2;
 	} else {
@@ -76,8 +76,7 @@ static bool config_pub_get(struct mesh_node *node, uint16_t net_idx,
 {
 	uint32_t mod_id;
 	uint16_t ele_addr;
-	int ele_idx;
-	struct mesh_model_pub *pub = NULL;
+	struct mesh_model_pub *pub;
 	int status;
 
 	if (size == 4) {
@@ -90,27 +89,22 @@ static bool config_pub_get(struct mesh_node *node, uint16_t net_idx,
 		return false;
 
 	ele_addr = l_get_le16(pkt);
-	ele_idx = node_get_element_idx(node, ele_addr);
-
-	if (ele_idx >= 0)
-		pub = mesh_model_pub_get(node, ele_addr, mod_id, &status);
-	else
-		status = MESH_STATUS_INVALID_ADDRESS;
+	pub = mesh_model_pub_get(node, ele_addr, mod_id, &status);
 
 	if (pub && status == MESH_STATUS_SUCCESS)
 		send_pub_status(node, net_idx, src, dst, status, ele_addr,
-				pub->addr, mod_id, pub->idx, pub->credential,
+				mod_id, pub->addr, pub->idx, pub->credential,
 				pub->ttl, pub->period, pub->retransmit);
 	else
-		send_pub_status(node, net_idx, src, dst, status, ele_addr, 0,
-							mod_id, 0, 0, 0, 0, 0);
+		send_pub_status(node, net_idx, src, dst, status, ele_addr,
+				mod_id, 0, 0, 0, 0, 0, 0);
 	return true;
 }
 
-static bool config_pub_set(struct mesh_node *node, uint16_t net_idx,
+static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 					uint16_t src, uint16_t dst,
-					const uint8_t *pkt, uint16_t size,
-					bool unreliable)
+					const uint8_t *pkt, uint8_t virt_offset,
+					bool vendor, bool unreliable)
 {
 	uint32_t mod_id;
 	uint16_t ele_addr, idx, ota = 0;
@@ -119,93 +113,58 @@ static bool config_pub_set(struct mesh_node *node, uint16_t net_idx,
 	uint8_t ttl, period;
 	uint8_t retransmit;
 	int status;
-	bool cred_flag, b_virt = false;
-	bool vendor = false;
-
-	switch (size) {
-	default:
-		return false;
-
-	case 11:
-		idx = l_get_le16(pkt + 4);
-		ttl = pkt[6];
-		period = pkt[7];
-		retransmit = pkt[8];
-		mod_id = l_get_le16(pkt + 9);
-		mod_id |= VENDOR_ID_MASK;
-		break;
+	bool cred_flag;
 
-	case 13:
-		idx = l_get_le16(pkt + 4);
-		ttl = pkt[6];
-		period = pkt[7];
-		retransmit = pkt[8];
-		mod_id = l_get_le16(pkt + 9) << 16;
-		mod_id |= l_get_le16(pkt + 11);
-		vendor = true;
-		break;
+	idx = l_get_le16(pkt + 4 + virt_offset);
+	ttl = pkt[6 + virt_offset];
+	period = pkt[7 + virt_offset];
+	retransmit = pkt[8 + virt_offset];
+	mod_id = l_get_le16(pkt + 9 + virt_offset);
 
-	case 25:
-		b_virt = true;
-		idx = l_get_le16(pkt + 18);
-		ttl = pkt[20];
-		period = pkt[21];
-		retransmit = pkt[22];
-		mod_id = l_get_le16(pkt + 23);
+	if (!vendor)
 		mod_id |= VENDOR_ID_MASK;
-		break;
-
-	case 27:
-		b_virt = true;
-		idx = l_get_le16(pkt + 18);
-		ttl = pkt[20];
-		period = pkt[21];
-		retransmit = pkt[22];
-		mod_id = l_get_le16(pkt + 23) << 16;
-		mod_id |= l_get_le16(pkt + 25);
-		vendor = true;
-		break;
-	}
+	else
+		mod_id |= l_get_le16(pkt + 11 + virt_offset);
 
 	ele_addr = l_get_le16(pkt);
 	pub_addr = pkt + 2;
 
-	/* Doesn't accept out-of-range TTLs */
-	if (ttl > TTL_MASK && ttl != DEFAULT_TTL)
-		return false;
+	/* Doesn't accept virtual seeming addresses */
+	test_addr = l_get_le16(pub_addr);
+	if (!virt_offset && IS_VIRTUAL(test_addr))
+		return;
 
 	/* Get cred_flag */
 	cred_flag = !!(CREDFLAG_MASK & idx);
 
-	/* Ignore non-IDX bits */
+	/* Get AppKey index */
 	idx &= APP_IDX_MASK;
 
-	/* Doesn't accept virtual seeming addresses */
-	test_addr = l_get_le16(pub_addr);
-	if (!b_virt && test_addr > 0x7fff && test_addr < 0xc000)
-		return false;
-
 	status = mesh_model_pub_set(node, ele_addr, mod_id, pub_addr, idx,
 					cred_flag, ttl, period, retransmit,
-					b_virt, &ota);
+					virt_offset != 0, &ota);
 
 	l_debug("pub_set: status %d, ea %4.4x, ota: %4.4x, mod: %x, idx: %3.3x",
 					status, ele_addr, ota, mod_id, idx);
 
-	if (IS_UNASSIGNED(ota) && !b_virt) {
-		ttl = period = idx = 0;
+	if (status != MESH_STATUS_SUCCESS) {
+		if (!unreliable)
+			send_pub_status(node, net_idx, src, dst, status,
+					ele_addr, mod_id, 0, 0, 0, 0, 0, 0);
 
-		/* Remove model publication from config file */
-		if (status == MESH_STATUS_SUCCESS)
-			mesh_config_model_pub_del(node_config_get(node),
-				ele_addr, vendor ? mod_id : mod_id & 0x0000ffff,
-									vendor);
-		goto done;
+		return;
 	}
 
-	if (status == MESH_STATUS_SUCCESS) {
+	if (IS_UNASSIGNED(ota) && !virt_offset) {
+		ttl = period = idx = 0;
+
+		/* Remove model publication from config file */
+		mesh_config_model_pub_del(node_config_get(node), ele_addr,
+				vendor ? mod_id : mod_id & ~VENDOR_ID_MASK,
+								vendor);
+	} else {
 		struct mesh_config_pub db_pub = {
-			.virt = b_virt,
+			.virt = (virt_offset != 0),
 			.addr = ota,
 			.idx = idx,
 			.ttl = ttl,
@@ -215,21 +174,19 @@ static bool config_pub_set(struct mesh_node *node, uint16_t net_idx,
 			.interval = ((retransmit >> 3) + 1) * 50
 		};
 
-		if (b_virt)
+		if (virt_offset)
 			memcpy(db_pub.virt_addr, pub_addr, 16);
 
 		/* Save model publication to config file */
 		if (!mesh_config_model_pub_add(node_config_get(node), ele_addr,
-					vendor ? mod_id : mod_id & 0x0000ffff,
+				vendor ? mod_id : mod_id & ~VENDOR_ID_MASK,
 					vendor, &db_pub))
 			status = MESH_STATUS_STORAGE_FAIL;
 	}
 
-done:
 	if (!unreliable)
 		send_pub_status(node, net_idx, src, dst, status, ele_addr, ota,
 			mod_id, idx, cred_flag, ttl, period, retransmit);
-	return true;
 }
 
 static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
@@ -825,7 +782,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		if (size != 25 && size != 27)
 			return true;
 
-		config_pub_set(node, net_idx, src, unicast, pkt, size,
+		config_pub_set(node, net_idx, src, unicast, pkt, 14, size == 27,
 				!!(opcode & OP_UNRELIABLE));
 		break;
 
@@ -833,7 +790,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 		if (size != 11 && size != 13)
 			return true;
 
-		config_pub_set(node, net_idx, src, unicast, pkt, size,
+		config_pub_set(node, net_idx, src, unicast, pkt, 0, size == 13,
 				!!(opcode & OP_UNRELIABLE));
 		break;
 
-- 
2.21.1

