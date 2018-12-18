Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9313CC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF39218A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeLRWb4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:31:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:60673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbeLRWbz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 17:31:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="101704186"
Received: from bgix-dell-lap.sea.intel.com ([10.241.111.161])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2018 14:31:51 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org
Subject: [PATCH BlueZ v4 17/30] mesh: Multi node Config Server model
Date:   Tue, 18 Dec 2018 14:31:26 -0800
Message-Id: <20181218223139.8041-18-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181218223139.8041-1-brian.gix@intel.com>
References: <20181218223139.8041-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/cfgmod-server.c | 173 ++++++++++++++++++++++++++-------------------------
 1 file changed, 88 insertions(+), 85 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 2c4a02912..6cddb8eac 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -40,7 +40,7 @@
 
 #define CFG_MAX_MSG_LEN 380
 
-static void send_pub_status(struct mesh_net *net, uint16_t src, uint16_t dst,
+static void send_pub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 			uint8_t status, uint16_t ele_addr, uint16_t pub_addr,
 			uint32_t mod_id, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit)
@@ -60,7 +60,7 @@ static void send_pub_status(struct mesh_net *net, uint16_t src, uint16_t dst,
 	msg[n++] = ttl;
 	msg[n++] = period;
 	msg[n++] = retransmit;
-	if (mod_id < 0x10000) {
+	if (mod_id < 0x10000 || mod_id > VENDOR_ID_MASK) {
 		l_put_le16(mod_id, msg + n);
 		n += 2;
 	} else {
@@ -70,12 +70,11 @@ static void send_pub_status(struct mesh_net *net, uint16_t src, uint16_t dst,
 		n += 2;
 	}
 
-	mesh_model_send(net, CONFIG_SRV_MODEL,
-			dst, src,
+	mesh_model_send(node, dst, src,
 			APP_IDX_DEV, DEFAULT_TTL, msg, n);
 }
 
-static bool config_pub_get(struct mesh_net *net, uint16_t src, uint16_t dst,
+static bool config_pub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size)
 {
 	uint32_t mod_id;
@@ -84,33 +83,34 @@ static bool config_pub_get(struct mesh_net *net, uint16_t src, uint16_t dst,
 	struct mesh_model_pub *pub = NULL;
 	int status;
 
-	if (size == 4)
+	if (size == 4) {
 		mod_id = l_get_le16(pkt + 2);
-	else if (size == 6) {
+		mod_id |= VENDOR_ID_MASK;
+	} else if (size == 6) {
 		mod_id = l_get_le16(pkt + 2) << 16;
 		mod_id |= l_get_le16(pkt + 4);
 	} else
 		return false;
 
 	ele_addr = l_get_le16(pkt);
-	ele_idx = node_get_element_idx(mesh_net_local_node_get(net), ele_addr);
+	ele_idx = node_get_element_idx(node, ele_addr);
 
 	if (ele_idx >= 0)
-		pub = mesh_model_pub_get(net, ele_idx, mod_id, &status);
+		pub = mesh_model_pub_get(node, ele_idx, mod_id, &status);
 	else
 		status = MESH_STATUS_INVALID_ADDRESS;
 
 	if (pub && status == MESH_STATUS_SUCCESS)
-		send_pub_status(net, src, dst, status, ele_addr, pub->addr,
+		send_pub_status(node, src, dst, status, ele_addr, pub->addr,
 				mod_id, pub->idx, pub->credential, pub->ttl,
 						pub->period, pub->retransmit);
 	else
-		send_pub_status(net, src, dst, status, ele_addr, 0, mod_id,
+		send_pub_status(node, src, dst, status, ele_addr, 0, mod_id,
 								0, 0, 0, 0, 0);
 	return true;
 }
 
-static bool config_pub_set(struct mesh_net *net, uint16_t src, uint16_t dst,
+static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size,
 					bool unreliable)
 {
@@ -133,6 +133,7 @@ static bool config_pub_set(struct mesh_net *net, uint16_t src, uint16_t dst,
 		period = pkt[7];
 		retransmit = pkt[8];
 		mod_id = l_get_le16(pkt + 9);
+		mod_id |= VENDOR_ID_MASK;
 		break;
 
 	case 13:
@@ -151,6 +152,7 @@ static bool config_pub_set(struct mesh_net *net, uint16_t src, uint16_t dst,
 		period = pkt[21];
 		retransmit = pkt[22];
 		mod_id = l_get_le16(pkt + 23);
+		mod_id |= VENDOR_ID_MASK;
 		break;
 
 	case 27:
@@ -181,24 +183,24 @@ static bool config_pub_set(struct mesh_net *net, uint16_t src, uint16_t dst,
 	if (!b_virt && test_addr > 0x7fff && test_addr < 0xc000)
 		return false;
 
-	status = mesh_model_pub_set(net, ele_addr, mod_id, pub_addr, idx,
+	status = mesh_model_pub_set(node, ele_addr, mod_id, pub_addr, idx,
 					cred_flag, ttl, period, retransmit,
 					b_virt, &ota);
 
-	l_info("pub_set: status %d, ea %4.4x, ota: %4.4x, mod: %x, idx: %3.3x",
+	l_debug("pub_set: status %d, ea %4.4x, ota: %4.4x, mod: %x, idx: %3.3x",
 					status, ele_addr, ota, mod_id, idx);
 
 	if (IS_UNASSIGNED(ota) && !b_virt)
 		ttl = period = idx = 0;
 
 	if (status >= 0 && !unreliable)
-		send_pub_status(net, src, dst, status, ele_addr, ota,
+		send_pub_status(node, src, dst, status, ele_addr, ota,
 				mod_id, idx, cred_flag, ttl, period,
 				retransmit);
 	return true;
 }
 
-static void send_sub_status(struct mesh_net *net, uint16_t src, uint16_t dst,
+static void send_sub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint8_t status, uint16_t ele_addr,
 					uint16_t addr, uint32_t mod)
 {
@@ -210,7 +212,7 @@ static void send_sub_status(struct mesh_net *net, uint16_t src, uint16_t dst,
 	n += 2;
 	l_put_le16(addr, msg + n);
 	n += 2;
-	if (mod >= 0x10000) {
+	if (mod >= 0x10000 && mod < VENDOR_ID_MASK) {
 		l_put_le16(mod >> 16, msg + n);
 		l_put_le16(mod, msg + n + 2);
 		n += 4;
@@ -219,11 +221,10 @@ static void send_sub_status(struct mesh_net *net, uint16_t src, uint16_t dst,
 		n += 2;
 	}
 
-	mesh_model_send(net, CONFIG_SRV_MODEL, dst, src, APP_IDX_DEV,
-							DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
 }
 
-static bool config_sub_get(struct mesh_net *net, uint16_t src, uint16_t dst,
+static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size)
 {
 	uint16_t ele_addr;
@@ -251,6 +252,7 @@ static bool config_sub_get(struct mesh_net *net, uint16_t src, uint16_t dst,
 		n += 2;
 		l_put_le16(mod_id, msg + n);
 		n += 2;
+		mod_id |= VENDOR_ID_MASK;
 		break;
 
 	case 6:
@@ -269,7 +271,7 @@ static bool config_sub_get(struct mesh_net *net, uint16_t src, uint16_t dst,
 	}
 
 	buf_size = sizeof(uint16_t) * MAX_GRP_PER_MOD;
-	ret = mesh_model_sub_get(net, ele_addr, mod_id, msg + n, buf_size,
+	ret = mesh_model_sub_get(node, ele_addr, mod_id, msg + n, buf_size,
 									&size);
 
 	if (!ret)
@@ -277,13 +279,11 @@ static bool config_sub_get(struct mesh_net *net, uint16_t src, uint16_t dst,
 	else if (ret > 0)
 		*status = ret;
 
-	mesh_model_send(net, CONFIG_SRV_MODEL,
-			dst, src, APP_IDX_DEV,
-			DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
 	return true;
 }
 
-static void config_sub_set(struct mesh_net *net, uint16_t src, uint16_t dst,
+static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size,
 					bool virt, uint32_t opcode)
 {
@@ -301,13 +301,15 @@ static void config_sub_set(struct mesh_net *net, uint16_t src, uint16_t dst,
 		if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL)
 			return;
 		mod_id = l_get_le16(pkt + 2);
+		mod_id |= VENDOR_ID_MASK;
 		break;
 	case 6:
 		if (virt)
 			return;
-		if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL)
+		if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL) {
 			mod_id = l_get_le16(pkt + 4);
-		else {
+			mod_id |= VENDOR_ID_MASK;
+		} else {
 			mod_id = l_get_le16(pkt + 2) << 16;
 			mod_id |= l_get_le16(pkt + 4);
 		}
@@ -322,6 +324,7 @@ static void config_sub_set(struct mesh_net *net, uint16_t src, uint16_t dst,
 		if (!virt)
 			return;
 		mod_id = l_get_le16(pkt + 18);
+		mod_id |= VENDOR_ID_MASK;
 		break;
 	case 22:
 		if (!virt)
@@ -341,42 +344,42 @@ static void config_sub_set(struct mesh_net *net, uint16_t src, uint16_t dst,
 	func = opcode & ~OP_UNRELIABLE;
 	switch (func) {
 	default:
-		l_info("Bad opcode: %x", func);
+		l_debug("Bad opcode: %x", func);
 		return;
 
 	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
-		status = mesh_model_sub_del_all(net, ele_addr, mod_id);
+		status = mesh_model_sub_del_all(node, ele_addr, mod_id);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
 		grp = UNASSIGNED_ADDRESS;
 		/* Fall Through */
 	case OP_CONFIG_MODEL_SUB_OVERWRITE:
-		status = mesh_model_sub_ovr(net, ele_addr, mod_id,
+		status = mesh_model_sub_ovr(node, ele_addr, mod_id,
 							addr, virt, &grp);
 		break;
 	case OP_CONFIG_MODEL_SUB_VIRT_ADD:
 		grp = UNASSIGNED_ADDRESS;
 		/* Fall Through */
 	case OP_CONFIG_MODEL_SUB_ADD:
-		status = mesh_model_sub_add(net, ele_addr, mod_id,
+		status = mesh_model_sub_add(node, ele_addr, mod_id,
 							addr, virt, &grp);
 		break;
 	case OP_CONFIG_MODEL_SUB_VIRT_DELETE:
 		grp = UNASSIGNED_ADDRESS;
 		/* Fall Through */
 	case OP_CONFIG_MODEL_SUB_DELETE:
-		status = mesh_model_sub_del(net, ele_addr, mod_id,
+		status = mesh_model_sub_del(node, ele_addr, mod_id,
 							addr, virt, &grp);
 		break;
 	}
 
 	if (!unreliable && status >= 0)
-		send_sub_status(net, src, dst, status, ele_addr, grp, mod_id);
+		send_sub_status(node, src, dst, status, ele_addr, grp, mod_id);
 
 }
 
-static void send_model_app_status(struct mesh_net *net, uint16_t src,
+static void send_model_app_status(struct mesh_node *node, uint16_t src,
 					uint16_t dst, uint8_t status,
 					uint16_t addr, uint32_t id,
 					uint16_t idx)
@@ -389,18 +392,17 @@ static void send_model_app_status(struct mesh_net *net, uint16_t src,
 	n += 2;
 	l_put_le16(idx, msg + n);
 	n += 2;
-	if (id > 0xffff) {
+	if (id >= 0x10000 && id < VENDOR_ID_MASK) {
 		l_put_le16(id >> 16, msg + n);
 		n += 2;
 	}
 	l_put_le16(id, msg + n);
 	n += 2;
 
-	mesh_model_send(net, CONFIG_SRV_MODEL, dst, src, APP_IDX_DEV,
-				DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
 }
 
-static void model_app_list(struct mesh_net *net, uint16_t src, uint16_t dst,
+static void model_app_list(struct mesh_node *node, uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size)
 {
 	uint16_t ele_addr;
@@ -427,6 +429,7 @@ static void model_app_list(struct mesh_net *net, uint16_t src, uint16_t dst,
 		mod_id = l_get_le16(pkt + 2);
 		l_put_le16(ele_addr, msg + 1 + n);
 		l_put_le16(mod_id, msg + 3 + n);
+		mod_id |= VENDOR_ID_MASK;
 		n += 5;
 		break;
 	case 6:
@@ -443,20 +446,20 @@ static void model_app_list(struct mesh_net *net, uint16_t src, uint16_t dst,
 	}
 
 
-	result = mesh_model_get_bindings(net, ele_addr, mod_id, msg + n,
+	result = mesh_model_get_bindings(node, ele_addr, mod_id, msg + n,
 							buf_size, &size);
 	n += size;
 
 	if (result >= 0) {
 		*status = result;
-		mesh_model_send(net, CONFIG_SRV_MODEL, dst, src, APP_IDX_DEV,
-					DEFAULT_TTL, msg, n);
+		mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL,
+								msg, n);
 	}
 
 	l_free(msg);
 }
 
-static bool model_app_bind(struct mesh_net *net, uint16_t src, uint16_t dst,
+static bool model_app_bind(struct mesh_node *node, uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size,
 					bool unbind)
 {
@@ -471,6 +474,7 @@ static bool model_app_bind(struct mesh_net *net, uint16_t src, uint16_t dst,
 
 	case 6:
 		mod_id = l_get_le16(pkt + 4);
+		mod_id |= VENDOR_ID_MASK;
 		break;
 	case 8:
 		mod_id = l_get_le16(pkt + 4) << 16;
@@ -485,11 +489,11 @@ static bool model_app_bind(struct mesh_net *net, uint16_t src, uint16_t dst,
 		return false;
 
 	if (unbind)
-		result = mesh_model_binding_del(net, ele_addr, mod_id, idx);
+		result = mesh_model_binding_del(node, ele_addr, mod_id, idx);
 	else
-		result = mesh_model_binding_add(net, ele_addr, mod_id, idx);
+		result = mesh_model_binding_add(node, ele_addr, mod_id, idx);
 
-	send_model_app_status(net, src, dst, result, ele_addr, mod_id, idx);
+	send_model_app_status(node, src, dst, result, ele_addr, mod_id, idx);
 
 	return true;
 }
@@ -533,7 +537,7 @@ static void hb_sub_timeout_func(struct l_timeout *timeout, void *user_data)
 	struct mesh_net *net = user_data;
 	struct mesh_net_heartbeat *hb = mesh_net_heartbeat_get(net);
 
-	l_info("HB Subscription Ended");
+	l_debug("HB Subscription Ended");
 	l_timeout_remove(hb->sub_timer);
 	hb->sub_timer = NULL;
 	hb->sub_enabled = false;
@@ -639,7 +643,7 @@ static int hb_subscription_set(struct mesh_net *net, uint16_t src,
 
 static void node_reset(struct l_timeout *timeout, void *user_data)
 {
-	l_info("Node Reset");
+	l_debug("Node Reset");
 	l_timeout_remove(timeout);
 	l_main_quit();
 }
@@ -649,7 +653,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 				const uint8_t *data, uint16_t size,
 				uint8_t ttl, const void *user_data)
 {
-	struct mesh_net *net = (struct mesh_net *) user_data;
+	struct mesh_node *node = (struct mesh_node *) user_data;
+	struct mesh_net *net = node_get_net(node);
 	const uint8_t *pkt = data;
 	struct timeval time_now;
 	uint32_t opcode, tmp32;
@@ -663,7 +668,6 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	bool virt = false;
 	uint8_t count;
 	uint16_t interval;
-	struct mesh_node *node;
 	uint16_t n;
 
 	if (idx != APP_IDX_DEV)
@@ -675,10 +679,10 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	} else
 		return false;
 
+	net = node_get_net(node);
 	hb = mesh_net_heartbeat_get(net);
 	l_debug("CONFIG-SRV-opcode 0x%x size %u idx %3.3x", opcode, size, idx);
 
-	node = mesh_net_local_node_get(net);
 	n = 0;
 
 	switch (opcode) {
@@ -691,8 +695,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 		/* Only page 0 is currently supported */
 		if (pkt[0] != 0) {
-			l_info("Unsupported page number %d", pkt[0]);
-			l_info("Returning page number 0");
+			l_debug("Unsupported page number %d", pkt[0]);
+			l_debug("Returning page number 0");
 		}
 		long_msg = l_malloc(CFG_MAX_MSG_LEN);
 		n = mesh_model_opcode_set(OP_DEV_COMP_STATUS, long_msg);
@@ -711,7 +715,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		/* Fall Through */
 
 	case OP_CONFIG_DEFAULT_TTL_GET:
-		l_info("Get/Set Default TTL");
+		l_debug("Get/Set Default TTL");
 
 		n = mesh_model_opcode_set(OP_CONFIG_DEFAULT_TTL_STATUS, msg);
 		msg[n++] = node_default_ttl_get(node);
@@ -721,7 +725,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 25 && size != 27)
 			return true;
 
-		config_pub_set(net, src, unicast, pkt, size,
+		config_pub_set(node, src, unicast, pkt, size,
 				!!(opcode & OP_UNRELIABLE));
 		break;
 
@@ -729,24 +733,24 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 11 && size != 13)
 			return true;
 
-		config_pub_set(net, src, unicast, pkt, size,
+		config_pub_set(node, src, unicast, pkt, size,
 				!!(opcode & OP_UNRELIABLE));
 		break;
 
 	case OP_CONFIG_MODEL_PUB_GET:
-		config_pub_get(net, src, unicast, pkt, size);
+		config_pub_get(node, src, unicast, pkt, size);
 		break;
 
 	case OP_CONFIG_VEND_MODEL_SUB_GET:
 		if (size != 6)
 			return true;
-		config_sub_get(net, src, unicast, pkt, size);
+		config_sub_get(node, src, unicast, pkt, size);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_GET:
 		if (size != 4)
 			return true;
-		config_sub_get(net, src, unicast, pkt, size);
+		config_sub_get(node, src, unicast, pkt, size);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
@@ -758,7 +762,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	case OP_CONFIG_MODEL_SUB_DELETE:
 	case OP_CONFIG_MODEL_SUB_ADD:
 	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
-		config_sub_set(net, src, unicast, pkt, size, virt, opcode);
+		config_sub_set(node, src, unicast, pkt, size, virt, opcode);
 		break;
 
 	case OP_CONFIG_RELAY_SET:
@@ -777,7 +781,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		msg[n++] = node_relay_mode_get(node, &count, &interval);
 		msg[n++] = ((count - 1) << 5) + ((interval/10 - 1) & 0x1f);
 
-		l_info("Get/Set Relay Config (%d)", msg[n-1]);
+		l_debug("Get/Set Relay Config (%d)", msg[n-1]);
 		break;
 
 	case OP_CONFIG_NETWORK_TRANSMIT_SET:
@@ -786,7 +790,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 		count = (pkt[0] >> 5) + 1;
 		interval = ((pkt[0] & 0x1f) + 1) * 10;
-		if (storage_local_set_transmit_params(net, count, interval))
+		if (storage_set_transmit_params(node_jconfig_get(node), count,
+								interval))
 			mesh_net_transmit_params_set(net, count, interval);
 		/* Fall Through */
 
@@ -796,7 +801,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		mesh_net_transmit_params_get(net, &count, &interval);
 		msg[n++] = ((count - 1) << 5) + ((interval/10 - 1) & 0x1f);
 
-		l_info("Get/Set Network Transmit Config");
+		l_debug("Get/Set Network Transmit Config");
 		break;
 
 	case OP_CONFIG_PROXY_SET:
@@ -810,7 +815,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		n = mesh_model_opcode_set(OP_CONFIG_PROXY_STATUS, msg);
 
 		msg[n++] = node_proxy_mode_get(node);
-		l_info("Get/Set Config Proxy (%d)", msg[n-1]);
+		l_debug("Get/Set Config Proxy (%d)", msg[n-1]);
 		break;
 
 	case OP_NODE_IDENTITY_SET:
@@ -845,7 +850,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		n += 2;
 
 		msg[n++] = state;
-		l_info("Get/Set Config Identity (%d)", state);
+		l_debug("Get/Set Config Identity (%d)", state);
 		break;
 
 	case OP_CONFIG_BEACON_SET:
@@ -859,7 +864,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		n = mesh_model_opcode_set(OP_CONFIG_BEACON_STATUS, msg);
 
 		msg[n++] = node_beacon_mode_get(node);
-		l_info("Get/Set Config Beacon (%d)", msg[n-1]);
+		l_debug("Get/Set Config Beacon (%d)", msg[n-1]);
 		break;
 
 	case OP_CONFIG_FRIEND_SET:
@@ -874,7 +879,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		n = mesh_model_opcode_set(OP_CONFIG_FRIEND_STATUS, msg);
 
 		msg[n++] = node_friend_mode_get(node);
-		l_info("Get/Set Friend (%d)", msg[n-1]);
+		l_debug("Get/Set Friend (%d)", msg[n-1]);
 		break;
 
 	case OP_CONFIG_KEY_REFRESH_PHASE_SET:
@@ -908,7 +913,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		n += 2;
 		msg[n++] = phase;
 
-		l_info("Get/Set Key Refresh State (%d)", msg[n-1]);
+		l_debug("Get/Set Key Refresh State (%d)", msg[n-1]);
 		break;
 
 	case OP_APPKEY_ADD:
@@ -921,7 +926,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		b_res = appkey_key_add(net, net_idx, app_idx, pkt + 3,
 						opcode == OP_APPKEY_UPDATE);
 
-		l_info("Add/Update AppKey %s: Net_Idx %3.3x, App_Idx %3.3x",
+		l_debug("Add/Update AppKey %s: Net_Idx %3.3x, App_Idx %3.3x",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail",
 							net_idx, app_idx);
 
@@ -942,9 +947,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		net_idx = l_get_le16(pkt) & 0xfff;
 		app_idx = l_get_le16(pkt + 1) >> 4;
 		b_res = appkey_key_delete(net, net_idx, app_idx);
-		if (b_res == MESH_STATUS_SUCCESS)
-			node_app_key_delete(net, dst, net_idx, app_idx);
-		l_info("Delete AppKey %s Net_Idx %3.3x to App_Idx %3.3x",
+		l_debug("Delete AppKey %s Net_Idx %3.3x to App_Idx %3.3x",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail",
 							net_idx, app_idx);
 
@@ -979,7 +982,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		b_res = mesh_net_add_key(net, opcode == OP_NETKEY_UPDATE,
 						l_get_le16(pkt), pkt + 2);
 
-		l_info("NetKey Add/Update %s",
+		l_debug("NetKey Add/Update %s",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail");
 
 		n = mesh_model_opcode_set(OP_NETKEY_STATUS, msg);
@@ -994,7 +997,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 		b_res = mesh_net_del_key(net, l_get_le16(pkt));
 
-		l_info("NetKey delete %s",
+		l_debug("NetKey delete %s",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail");
 
 		n = mesh_model_opcode_set(OP_NETKEY_STATUS, msg);
@@ -1016,26 +1019,26 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 	case OP_MODEL_APP_BIND:
 	case OP_MODEL_APP_UNBIND:
-		model_app_bind(net, src, unicast, pkt, size,
+		model_app_bind(node, src, unicast, pkt, size,
 				opcode != OP_MODEL_APP_BIND);
 		break;
 
 	case OP_VEND_MODEL_APP_GET:
 		if (size != 6)
 			return true;
-		model_app_list(net, src, unicast, pkt, size);
+		model_app_list(node, src, unicast, pkt, size);
 		break;
 
 	case OP_MODEL_APP_GET:
 		if (size != 4)
 			return true;
-		model_app_list(net, src, unicast, pkt, size);
+		model_app_list(node, src, unicast, pkt, size);
 		break;
 
 	case OP_CONFIG_HEARTBEAT_PUB_SET:
-		l_info("OP_CONFIG_HEARTBEAT_PUB_SET");
+		l_debug("OP_CONFIG_HEARTBEAT_PUB_SET");
 		if (size != 9) {
-			l_info("bad size %d", size);
+			l_debug("bad size %d", size);
 			return true;
 		}
 		if (pkt[2] > 0x11 || pkt[3] > 0x10 || pkt[4] > 0x7f)
@@ -1101,7 +1104,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 5)
 			return true;
 
-		l_info("Set Sub Period (Log %2.2x) %d sec",
+		l_debug("Set Sub Period (Log %2.2x) %d sec",
 				pkt[4], log_to_uint32(pkt[4], 1));
 
 		b_res = hb_subscription_set(net, l_get_le16(pkt),
@@ -1121,7 +1124,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		else
 			time_now.tv_sec = hb->sub_period - time_now.tv_sec;
 
-		l_info("Sub Period (Log %2.2x) %d sec",
+		l_debug("Sub Period (Log %2.2x) %d sec",
 				uint32_to_log(time_now.tv_sec),
 				(int) time_now.tv_sec);
 
@@ -1159,8 +1162,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 	if (n) {
 		/* print_packet("App Tx", long_msg ? long_msg : msg, n); */
-		mesh_model_send(net, CONFIG_SRV_MODEL,
-				unicast, src,
+		mesh_model_send(node, unicast, src,
 				APP_IDX_DEV, DEFAULT_TTL,
 				long_msg ? long_msg : msg, n);
 	}
@@ -1171,7 +1173,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 static void cfgmod_srv_unregister(void *user_data)
 {
-	struct mesh_net *net = user_data;
+	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
 	struct mesh_net_heartbeat *hb = mesh_net_heartbeat_get(net);
 
 	l_timeout_remove(hb->pub_timer);
@@ -1187,8 +1190,8 @@ static const struct mesh_model_ops ops = {
 	.pub = NULL
 };
 
-void mesh_config_srv_init(struct mesh_net *net, uint8_t ele_idx)
+void mesh_config_srv_init(struct mesh_node *node, uint8_t ele_idx)
 {
 	l_debug("%2.2x", ele_idx);
-	mesh_model_register(net, ele_idx, CONFIG_SRV_MODEL, &ops, net);
+	mesh_model_register(node, ele_idx, CONFIG_SRV_MODEL, &ops, node);
 }
-- 
2.14.5

