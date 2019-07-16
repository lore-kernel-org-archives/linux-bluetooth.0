Return-Path: <SRS0=iTYz=VN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9756FC76192
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 22:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEAB2173B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 22:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbfGPW4w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:56:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:2095 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731273AbfGPW4w (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jul 2019 18:56:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 15:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,271,1559545200"; 
   d="scan'208";a="170073276"
Received: from bgix-dell-lap.sea.intel.com ([10.251.137.82])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2019 15:56:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ 3/3] mesh: Propagate Net Index up Rx message chain
Date:   Tue, 16 Jul 2019 15:56:44 -0700
Message-Id: <20190716225644.11449-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190716225644.11449-1-brian.gix@intel.com>
References: <20190716225644.11449-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a model receives a message, it is required by the spec
to respond using the same credentials. When an App Key is used,
this is trivial because App keys are bound to Net keys, so only
the App Index is required.  Messages received on a Device key
however, need the Net Index preserved from original message for
re-use during the response.
---
 mesh/cfgmod-server.c | 154 ++++++++++++++++++++++++++++-----------------------
 mesh/model.c         | 129 +++++++++++++++++++++---------------------
 mesh/model.h         |  10 ++--
 mesh/net.c           |  92 +++++++++++++++++-------------
 mesh/net.h           |   6 +-
 mesh/node.c          |  10 ++--
 6 files changed, 214 insertions(+), 187 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index a19ddc72e..420cac6ed 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -38,7 +38,8 @@
 
 #define CFG_MAX_MSG_LEN 380
 
-static void send_pub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
+static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
+			uint16_t src, uint16_t dst,
 			uint8_t status, uint16_t ele_addr, uint16_t pub_addr,
 			uint32_t mod_id, uint16_t idx, bool cred_flag,
 			uint8_t ttl, uint8_t period, uint8_t retransmit)
@@ -69,11 +70,12 @@ static void send_pub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 		n += 2;
 	}
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL,
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
 								msg, n);
 }
 
-static bool config_pub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
+static bool config_pub_get(struct mesh_node *node, uint16_t net_idx,
+					uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size)
 {
 	uint32_t mod_id;
@@ -100,16 +102,17 @@ static bool config_pub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 		status = MESH_STATUS_INVALID_ADDRESS;
 
 	if (pub && status == MESH_STATUS_SUCCESS)
-		send_pub_status(node, src, dst, status, ele_addr, pub->addr,
-				mod_id, pub->idx, pub->credential, pub->ttl,
-						pub->period, pub->retransmit);
+		send_pub_status(node, net_idx, src, dst, status, ele_addr,
+				pub->addr, mod_id, pub->idx, pub->credential,
+				pub->ttl, pub->period, pub->retransmit);
 	else
-		send_pub_status(node, src, dst, status, ele_addr, 0, mod_id,
-								0, 0, 0, 0, 0);
+		send_pub_status(node, net_idx, src, dst, status, ele_addr, 0,
+							mod_id, 0, 0, 0, 0, 0);
 	return true;
 }
 
-static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
+static bool config_pub_set(struct mesh_node *node, uint16_t net_idx,
+					uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size,
 					bool unreliable)
 {
@@ -228,13 +231,13 @@ static bool config_pub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 done:
 	if (!unreliable)
-		send_pub_status(node, src, dst, status, ele_addr, ota,
-				mod_id, idx, cred_flag, ttl, period,
-				retransmit);
+		send_pub_status(node, net_idx, src, dst, status, ele_addr, ota,
+			mod_id, idx, cred_flag, ttl, period, retransmit);
 	return true;
 }
 
-static void send_sub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
+static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
+					uint16_t src, uint16_t dst,
 					uint8_t status, uint16_t ele_addr,
 					uint16_t addr, uint32_t mod)
 {
@@ -255,10 +258,12 @@ static void send_sub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 		n += 2;
 	}
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
+							DEFAULT_TTL, msg, n);
 }
 
-static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
+static bool config_sub_get(struct mesh_node *node, uint16_t net_idx,
+					uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size)
 {
 	uint16_t ele_addr;
@@ -313,7 +318,8 @@ static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 	*msg_status = (uint8_t) status;
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
+									msg, n);
 	return true;
 }
 
@@ -349,7 +355,8 @@ static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
 					vendor, &db_sub);
 }
 
-static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
+static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
+					uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size,
 					bool virt, uint32_t opcode)
 {
@@ -464,14 +471,15 @@ static void config_sub_set(struct mesh_node *node, uint16_t src, uint16_t dst,
 	}
 
 	if (!unreliable)
-		send_sub_status(node, src, dst, status, ele_addr, grp, mod_id);
+		send_sub_status(node, net_idx, src, dst, status, ele_addr,
+								grp, mod_id);
 
 }
 
-static void send_model_app_status(struct mesh_node *node, uint16_t src,
-					uint16_t dst, uint8_t status,
-					uint16_t addr, uint32_t id,
-					uint16_t idx)
+static void send_model_app_status(struct mesh_node *node, uint16_t net_idx,
+					uint16_t src, uint16_t dst,
+					uint8_t status, uint16_t addr,
+					uint32_t id, uint16_t idx)
 {
 	uint8_t msg[12];
 	size_t n = mesh_model_opcode_set(OP_MODEL_APP_STATUS, msg);
@@ -488,10 +496,12 @@ static void send_model_app_status(struct mesh_node *node, uint16_t src,
 	l_put_le16(id, msg + n);
 	n += 2;
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
+									msg, n);
 }
 
-static void model_app_list(struct mesh_node *node, uint16_t src, uint16_t dst,
+static void model_app_list(struct mesh_node *node, uint16_t net_idx,
+					uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size)
 {
 	uint16_t ele_addr;
@@ -541,14 +551,15 @@ static void model_app_list(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 	if (result >= 0) {
 		*status = result;
-		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL,
-								msg, n);
+		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx,
+							DEFAULT_TTL, msg, n);
 	}
 
 	l_free(msg);
 }
 
-static bool model_app_bind(struct mesh_node *node, uint16_t src, uint16_t dst,
+static bool model_app_bind(struct mesh_node *node, uint16_t net_idx,
+					uint16_t src, uint16_t dst,
 					const uint8_t *pkt, uint16_t size,
 					bool unbind)
 {
@@ -582,7 +593,8 @@ static bool model_app_bind(struct mesh_node *node, uint16_t src, uint16_t dst,
 	else
 		result = mesh_model_binding_add(node, ele_addr, mod_id, idx);
 
-	send_model_app_status(node, src, dst, result, ele_addr, mod_id, idx);
+	send_model_app_status(node, net_idx, src, dst, result, ele_addr,
+								mod_id, idx);
 
 	return true;
 }
@@ -737,8 +749,8 @@ static void node_reset(struct l_timeout *timeout, void *user_data)
 	l_main_quit();
 }
 
-static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
-				uint16_t unicast, uint16_t idx,
+static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
+				uint16_t app_idx, uint16_t net_idx,
 				const uint8_t *data, uint16_t size,
 				uint8_t ttl, const void *user_data)
 {
@@ -751,7 +763,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	uint8_t msg[11];
 	uint8_t *long_msg = NULL;
 	struct mesh_net_heartbeat *hb;
-	uint16_t net_idx, app_idx;
+	uint16_t n_idx, a_idx;
 	uint8_t state, status;
 	uint8_t phase;
 	bool virt = false;
@@ -759,7 +771,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	uint16_t interval;
 	uint16_t n;
 
-	if (idx != APP_IDX_DEV_LOCAL)
+	if (app_idx != APP_IDX_DEV_LOCAL)
 		return false;
 
 	if (mesh_model_opcode_get(pkt, size, &opcode, &n)) {
@@ -770,7 +782,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 	net = node_get_net(node);
 	hb = mesh_net_heartbeat_get(net);
-	l_debug("CONFIG-SRV-opcode 0x%x size %u idx %3.3x", opcode, size, idx);
+	l_debug("CONFIG-SRV-opcode 0x%x size %u idx %3.3x", opcode, size,
+								net_idx);
 
 	n = 0;
 
@@ -814,7 +827,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 25 && size != 27)
 			return true;
 
-		config_pub_set(node, src, unicast, pkt, size,
+		config_pub_set(node, net_idx, src, unicast, pkt, size,
 				!!(opcode & OP_UNRELIABLE));
 		break;
 
@@ -822,24 +835,26 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 11 && size != 13)
 			return true;
 
-		config_pub_set(node, src, unicast, pkt, size,
+		config_pub_set(node, net_idx, src, unicast, pkt, size,
 				!!(opcode & OP_UNRELIABLE));
 		break;
 
 	case OP_CONFIG_MODEL_PUB_GET:
-		config_pub_get(node, src, unicast, pkt, size);
+		config_pub_get(node, net_idx, src, unicast, pkt, size);
 		break;
 
 	case OP_CONFIG_VEND_MODEL_SUB_GET:
 		if (size != 6)
 			return true;
-		config_sub_get(node, src, unicast, pkt, size);
+
+		config_sub_get(node, net_idx, src, unicast, pkt, size);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_GET:
 		if (size != 4)
 			return true;
-		config_sub_get(node, src, unicast, pkt, size);
+
+		config_sub_get(node, net_idx, src, unicast, pkt, size);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
@@ -851,7 +866,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	case OP_CONFIG_MODEL_SUB_DELETE:
 	case OP_CONFIG_MODEL_SUB_ADD:
 	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
-		config_sub_set(node, src, unicast, pkt, size, virt, opcode);
+		config_sub_set(node, net_idx, src, unicast, pkt, size, virt,
+									opcode);
 		break;
 
 	case OP_CONFIG_RELAY_SET:
@@ -911,8 +927,8 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 3 || pkt[2] > 0x01)
 			return true;
 
-		net_idx = l_get_le16(pkt);
-		if (net_idx > 0xfff)
+		n_idx = l_get_le16(pkt);
+		if (n_idx > 0xfff)
 			return true;
 
 		/*
@@ -925,17 +941,17 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size < 2)
 			return true;
 
-		net_idx = l_get_le16(pkt);
-		if (net_idx > 0xfff)
+		n_idx = l_get_le16(pkt);
+		if (n_idx > 0xfff)
 			return true;
 
 		n = mesh_model_opcode_set(OP_NODE_IDENTITY_STATUS, msg);
 
-		status = mesh_net_get_identity_mode(net, net_idx, &state);
+		status = mesh_net_get_identity_mode(net, n_idx, &state);
 
 		msg[n++] = status;
 
-		l_put_le16(net_idx, msg + n);
+		l_put_le16(n_idx, msg + n);
 		n += 2;
 
 		msg[n++] = state;
@@ -984,13 +1000,13 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 2)
 			return true;
 
-		net_idx = l_get_le16(pkt);
+		n_idx = l_get_le16(pkt);
 
 		n = mesh_model_opcode_set(OP_CONFIG_KEY_REFRESH_PHASE_STATUS,
 						msg);
 
 		/* State: 0x00-0x03 phase of key refresh */
-		status = mesh_net_key_refresh_phase_get(net, net_idx,
+		status = mesh_net_key_refresh_phase_get(net, n_idx,
 							&phase);
 		if (status != MESH_STATUS_SUCCESS) {
 			b_res = status;
@@ -998,7 +1014,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		}
 
 		msg[n++] = b_res;
-		l_put_le16(net_idx, msg + n);
+		l_put_le16(n_idx, msg + n);
 		n += 2;
 		msg[n++] = phase;
 
@@ -1010,18 +1026,18 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 19)
 			return true;
 
-		net_idx = l_get_le16(pkt) & 0xfff;
-		app_idx = l_get_le16(pkt + 1) >> 4;
+		n_idx = l_get_le16(pkt) & 0xfff;
+		a_idx = l_get_le16(pkt + 1) >> 4;
 
 		if (opcode == OP_APPKEY_ADD)
-			b_res = appkey_key_add(net, net_idx, app_idx, pkt + 3);
+			b_res = appkey_key_add(net, n_idx, a_idx, pkt + 3);
 		else
-			b_res = appkey_key_update(net, net_idx, app_idx,
+			b_res = appkey_key_update(net, n_idx, a_idx,
 								pkt + 3);
 
 		l_debug("Add/Update AppKey %s: Net_Idx %3.3x, App_Idx %3.3x",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail",
-							net_idx, app_idx);
+							n_idx, a_idx);
 
 
 		n = mesh_model_opcode_set(OP_APPKEY_STATUS, msg);
@@ -1034,15 +1050,14 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 	case OP_APPKEY_DELETE:
 		if (size != 3)
-			return
-				true;
+			return true;
 
-		net_idx = l_get_le16(pkt) & 0xfff;
-		app_idx = l_get_le16(pkt + 1) >> 4;
-		b_res = appkey_key_delete(net, net_idx, app_idx);
+		n_idx = l_get_le16(pkt) & 0xfff;
+		a_idx = l_get_le16(pkt + 1) >> 4;
+		b_res = appkey_key_delete(net, n_idx, a_idx);
 		l_debug("Delete AppKey %s Net_Idx %3.3x to App_Idx %3.3x",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail",
-							net_idx, app_idx);
+							n_idx, a_idx);
 
 		n = mesh_model_opcode_set(OP_APPKEY_STATUS, msg);
 		msg[n++] = b_res;
@@ -1054,16 +1069,17 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	case OP_APPKEY_GET:
 		if (size != 2)
 			return true;
-		net_idx = l_get_le16(pkt);
+
+		n_idx = l_get_le16(pkt);
 
 		long_msg = l_malloc(CFG_MAX_MSG_LEN);
 		n = mesh_model_opcode_set(OP_APPKEY_LIST, long_msg);
 
-		status = appkey_list(net, net_idx, long_msg + n + 3,
+		status = appkey_list(net, n_idx, long_msg + n + 3,
 						CFG_MAX_MSG_LEN - n - 3, &size);
 
 		long_msg[n] = status;
-		l_put_le16(net_idx, long_msg + n + 1);
+		l_put_le16(n_idx, long_msg + n + 1);
 		n += (size + 3);
 		break;
 
@@ -1072,12 +1088,12 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 18)
 			return true;
 
-		net_idx = l_get_le16(pkt);
+		n_idx = l_get_le16(pkt);
 
 		if (opcode == OP_NETKEY_ADD)
-			b_res = mesh_net_add_key(net, net_idx, pkt + 2);
+			b_res = mesh_net_add_key(net, n_idx, pkt + 2);
 		else
-			b_res = mesh_net_update_key(net, net_idx, pkt + 2);
+			b_res = mesh_net_update_key(net, n_idx, pkt + 2);
 
 		l_debug("NetKey Add/Update %s",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail");
@@ -1116,20 +1132,20 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 	case OP_MODEL_APP_BIND:
 	case OP_MODEL_APP_UNBIND:
-		model_app_bind(node, src, unicast, pkt, size,
+		model_app_bind(node, net_idx, src, unicast, pkt, size,
 				opcode != OP_MODEL_APP_BIND);
 		break;
 
 	case OP_VEND_MODEL_APP_GET:
 		if (size != 6)
 			return true;
-		model_app_list(node, src, unicast, pkt, size);
+		model_app_list(node, net_idx, src, unicast, pkt, size);
 		break;
 
 	case OP_MODEL_APP_GET:
 		if (size != 4)
 			return true;
-		model_app_list(node, src, unicast, pkt, size);
+		model_app_list(node, net_idx, src, unicast, pkt, size);
 		break;
 
 	case OP_CONFIG_HEARTBEAT_PUB_SET:
@@ -1260,7 +1276,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	if (n) {
 		/* print_packet("App Tx", long_msg ? long_msg : msg, n); */
 		mesh_model_send(node, unicast, src,
-				APP_IDX_DEV_LOCAL, DEFAULT_TTL,
+				APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
 				long_msg ? long_msg : msg, n);
 	}
 	l_free(long_msg);
diff --git a/mesh/model.c b/mesh/model.c
index e08f95b71..bfd179b52 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -69,7 +69,8 @@ struct mod_forward {
 	uint16_t src;
 	uint16_t dst;
 	uint16_t unicast;
-	uint16_t idx;
+	uint16_t app_idx;
+	uint16_t net_idx;
 	uint16_t size;
 	uint8_t ttl;
 	int8_t rssi;
@@ -304,10 +305,11 @@ static void forward_model(void *a, void *b)
 	uint32_t dst;
 	bool result;
 
-	l_debug("model %8.8x with idx %3.3x", mod->id, fwd->idx);
+	l_debug("model %8.8x with idx %3.3x", mod->id, fwd->app_idx);
 
-	if (fwd->idx != APP_IDX_DEV_LOCAL && fwd->idx != APP_IDX_DEV_REMOTE &&
-					!has_binding(mod->bindings, fwd->idx))
+	if (fwd->app_idx != APP_IDX_DEV_LOCAL &&
+				fwd->app_idx != APP_IDX_DEV_REMOTE &&
+				!has_binding(mod->bindings, fwd->app_idx))
 		return;
 
 	dst = fwd->dst;
@@ -345,7 +347,8 @@ static void forward_model(void *a, void *b)
 	result = false;
 
 	if (mod->cbs->recv)
-		result = mod->cbs->recv(fwd->src, dst, fwd->unicast, fwd->idx,
+		result = mod->cbs->recv(fwd->src, dst, fwd->unicast,
+				fwd->app_idx, fwd->net_idx,
 				fwd->data, fwd->size, fwd->ttl, mod->user_data);
 
 	if (dst == fwd->unicast && result)
@@ -439,13 +442,17 @@ static void cmplt(uint16_t remote, uint8_t status,
 }
 
 static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
-		uint32_t dst, uint8_t key_id, const uint8_t *key,
-		uint8_t *label, uint8_t ttl, const void *msg, uint16_t msg_len)
+		uint32_t dst, uint16_t app_idx, uint16_t net_idx,
+		uint8_t *label, uint8_t ttl,
+		const void *msg, uint16_t msg_len)
 {
-	bool ret = false;
+	uint8_t dev_key[16];
 	uint32_t iv_index, seq_num;
+	const uint8_t *key;
 	uint8_t *out;
+	uint8_t key_aid = APP_AID_DEV;
 	bool szmic = false;
+	bool ret = false;
 	uint16_t out_len = msg_len + sizeof(uint32_t);
 	struct mesh_net *net = node_get_net(node);
 
@@ -457,22 +464,44 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		}
 	}
 
+	if (app_idx == APP_IDX_DEV_LOCAL) {
+		key = node_get_device_key(node);
+		if (!key)
+			return false;
+	} else if (app_idx == APP_IDX_DEV_REMOTE) {
+		if (!keyring_get_remote_dev_key(node, dst, dev_key))
+			return false;
+
+		key = dev_key;
+	} else {
+		key = appkey_get_key(node_get_net(node), app_idx, &key_aid);
+		if (!key) {
+			l_debug("no app key for (%x)", app_idx);
+			return false;
+		}
+
+		net_idx = appkey_net_idx(node_get_net(node), app_idx);
+	}
+
+	l_debug("(%x) %p", app_idx, key);
+	l_debug("net_idx %x", net_idx);
+
 	out = l_malloc(out_len);
 
 	iv_index = mesh_net_get_iv_index(net);
 
 	seq_num = mesh_net_get_seq_num(net);
 	if (!mesh_crypto_payload_encrypt(label, msg, out, msg_len, src, dst,
-				key_id, seq_num, iv_index, szmic, key)) {
+				key_aid, seq_num, iv_index, szmic, key)) {
 		l_error("Failed to Encrypt Payload");
 		goto done;
 	}
 
 	/* print_packet("Encrypted with", key, 16); */
 
-	ret = mesh_net_app_send(net, credential, src, dst, key_id, ttl,
-					seq_num, iv_index, szmic, out, out_len,
-								cmplt, NULL);
+	ret = mesh_net_app_send(net, credential, src, dst, key_aid, net_idx,
+					ttl, seq_num, iv_index, szmic, out,
+					out_len, cmplt, NULL);
 done:
 	l_free(out);
 	return ret;
@@ -770,8 +799,8 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint8_t ttl,
-			uint16_t src, uint16_t dst, uint8_t key_id,
-			const uint8_t *data, uint16_t size)
+			uint16_t net_idx, uint16_t src, uint16_t dst,
+			uint8_t key_aid, const uint8_t *data, uint16_t size)
 {
 	uint8_t *clear_text;
 	struct mod_forward forward = {
@@ -790,7 +819,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 	bool result = false;
 	bool is_subscription;
 
-	l_debug("iv_index %8.8x key_id = %2.2x", iv_index, key_id);
+	l_debug("iv_index %8.8x key_aid = %2.2x", iv_index, key_aid);
 	if (!dst)
 		return false;
 
@@ -808,21 +837,21 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 
 	/*
 	 * The packet needs to be decoded by the correct key which
-	 * is hinted by key_id, but is not necessarily definitive
+	 * is hinted by key_aid, but is not necessarily definitive
 	 */
-	if (key_id == APP_ID_DEV || mesh_net_provisioner_mode_get(net))
+	if (key_aid == APP_AID_DEV || mesh_net_provisioner_mode_get(net))
 		decrypt_idx = dev_packet_decrypt(node, data, size, szmict, src,
-						dst, key_id, seq0, iv_index,
+						dst, key_aid, seq0, iv_index,
 						clear_text);
 	else if ((dst & 0xc000) == 0x8000)
 		decrypt_idx = virt_packet_decrypt(net, data, size, szmict, src,
-							dst, key_id, seq0,
+							dst, key_aid, seq0,
 							iv_index, clear_text,
 							&decrypt_virt);
 	else
 		decrypt_idx = appkey_packet_decrypt(net, szmict, seq0,
 							iv_index, src, dst,
-							NULL, 0, key_id, data,
+							NULL, 0, key_aid, data,
 							size, clear_text);
 
 	if (decrypt_idx < 0) {
@@ -833,7 +862,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 
 	/* print_packet("Clr Rx (pre-cache-check)", clear_text, size - 4); */
 
-	if (key_id != APP_ID_DEV) {
+	if (key_aid != APP_AID_DEV) {
 		uint16_t crpl = node_get_crpl(node);
 
 		if (appkey_msg_in_replay_cache(net, (uint16_t) decrypt_idx, src,
@@ -846,7 +875,8 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 	print_packet("Clr Rx", clear_text, size - (szmict ? 8 : 4));
 
 	forward.virt = decrypt_virt;
-	forward.idx = decrypt_idx;
+	forward.app_idx = decrypt_idx;
+	forward.net_idx = net_idx;
 	num_ele = node_get_num_elements(node);
 	addr = node_get_primary(node);
 
@@ -876,7 +906,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 		if (forward.has_dst && !forward.done) {
 			if ((decrypt_idx & APP_IDX_MASK) == decrypt_idx)
 				send_msg_rcvd(node, i, is_subscription, src,
-						forward.idx, forward.size,
+						forward.app_idx, forward.size,
 						forward.data);
 			else if (decrypt_idx == APP_IDX_DEV_REMOTE ||
 				(decrypt_idx == APP_IDX_DEV_LOCAL &&
@@ -910,8 +940,7 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 	uint32_t target;
 	uint8_t *label = NULL;
 	uint16_t dst;
-	uint8_t key_id;
-	const uint8_t *key;
+	uint16_t net_idx;
 	bool result;
 	int status;
 
@@ -958,30 +987,21 @@ int mesh_model_publish(struct mesh_node *node, uint32_t mod_id,
 
 	l_debug("publish dst=%x", dst);
 
-	key = appkey_get_key(net, mod->pub->idx, &key_id);
-	if (!key) {
-		l_debug("no app key for (%x)", mod->pub->idx);
-		return false;
-	}
-
-	l_debug("(%x) %p", mod->pub->idx, key);
-	l_debug("key_id %x", key_id);
+	net_idx = appkey_net_idx(net, mod->pub->idx);
 
 	result = msg_send(node, mod->pub->credential != 0, src,
-				dst, key_id, key, label, ttl, msg, msg_len);
+				dst, mod->pub->idx, net_idx, label, ttl,
+				msg, msg_len);
 
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
 
 }
 
-bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
-					uint16_t app_idx, uint8_t ttl,
+bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
+					uint16_t app_idx, uint16_t net_idx,
+					uint8_t ttl,
 					const void *msg, uint16_t msg_len)
 {
-	uint8_t key_id;
-	uint8_t dev_key[16];
-	const uint8_t *key;
-
 	/* print_packet("Mod Tx", msg, msg_len); */
 
 	/* If SRC is 0, use the Primary Element */
@@ -990,34 +1010,11 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 
 	gettimeofday(&tx_start, NULL);
 
-	if (IS_UNASSIGNED(target))
+	if (IS_UNASSIGNED(dst))
 		return false;
 
-	if (app_idx == APP_IDX_DEV_LOCAL) {
-		key = node_get_device_key(node);
-		if (!key)
-			return false;
-
-		key_id = APP_ID_DEV;
-	} else if (app_idx == APP_IDX_DEV_REMOTE) {
-		if (!keyring_get_remote_dev_key(node, target, dev_key))
-			return false;
-
-		key = dev_key;
-		key_id = APP_ID_DEV;
-	} else {
-		key = appkey_get_key(node_get_net(node), app_idx, &key_id);
-		if (!key) {
-			l_debug("no app key for (%x)", app_idx);
-			return false;
-		}
-
-		l_debug("(%x) %p", app_idx, key);
-		l_debug("key_id %x", key_id);
-	}
-
-	return msg_send(node, false, src, target, key_id, key, NULL, ttl,
-			msg, msg_len);
+	return msg_send(node, false, src, dst, app_idx, net_idx,
+						NULL, ttl, msg, msg_len);
 }
 
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
diff --git a/mesh/model.h b/mesh/model.h
index a6951293f..fa031f598 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -67,7 +67,8 @@ struct mesh_model_pub {
 
 typedef void (*mesh_model_unregister)(void *user_data);
 typedef bool (*mesh_model_recv_cb)(uint16_t src, uint32_t dst, uint16_t unicast,
-					uint16_t app_idx, const uint8_t *data,
+					uint16_t app_idx, uint16_t net_idx,
+					const uint8_t *data,
 					uint16_t len, uint8_t ttl,
 					const void *user_data);
 typedef int (*mesh_model_bind_cb)(uint16_t app_idx, int action);
@@ -116,14 +117,15 @@ int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size);
 uint16_t mesh_model_cfg_blk(uint8_t *pkt);
 bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
-					uint16_t app_idx, uint8_t ttl,
+					uint16_t app_idx, uint16_t net_idx,
+					uint8_t ttl,
 					const void *msg, uint16_t msg_len);
 int mesh_model_publish(struct mesh_node *node, uint32_t mod_id, uint16_t src,
 				uint8_t ttl, const void *msg, uint16_t msg_len);
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 			uint32_t seq, uint32_t iv_index, uint8_t ttl,
-			uint16_t src, uint16_t dst, uint8_t key_id,
-			const uint8_t *data, uint16_t size);
+			uint16_t net_idx, uint16_t src, uint16_t dst,
+			uint8_t key_aid, const uint8_t *data, uint16_t size);
 void mesh_model_app_key_generate_new(struct mesh_node *node, uint16_t net_idx);
 void mesh_model_app_key_delete(struct mesh_node *node, struct l_queue *models,
 								uint16_t idx);
diff --git a/mesh/net.c b/mesh/net.c
index a5693f154..ba52867c4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -119,7 +119,6 @@ struct mesh_net {
 	unsigned int pkt_id;
 	unsigned int bea_id;
 	unsigned int beacon_id;
-	unsigned int key_id_next;
 	unsigned int sar_id_next;
 
 	bool friend_enable;
@@ -203,7 +202,7 @@ struct mesh_sar {
 	bool frnd_cred;
 	uint8_t ttl;
 	uint8_t last_seg;
-	uint8_t key_id;
+	uint8_t key_aid;
 	uint8_t buf[4]; /* Large enough for ACK-Flags and MIC */
 };
 
@@ -225,7 +224,7 @@ struct msg_rx {
 	union {
 		struct {
 			uint16_t app_idx;
-			uint8_t key_id;
+			uint8_t key_aid;
 		} m;
 		struct {
 			uint16_t seq0;
@@ -668,7 +667,6 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	net->node = node;
 	net->pkt_id = 0;
 	net->bea_id = 0;
-	net->key_id_next = 0;
 
 	net->beacon_enable = true;
 	net->proxy_enable = false;
@@ -676,7 +674,7 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 
 	net->seq_num = 0x000000;
 	net->src_addr = 0x0000;
-	net->default_ttl = 0x00;
+	net->default_ttl = 0x7f;
 
 	net->provisioner = false;
 
@@ -1764,12 +1762,11 @@ static void outseg_to(struct l_timeout *seg_timeout, void *user_data)
 	}
 }
 
-static bool msg_rxed(struct mesh_net *net, bool frnd,
-					uint32_t iv_index,
-					uint8_t ttl,
-					uint32_t seq,
+static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
+					uint8_t ttl, uint32_t seq,
+					uint16_t net_idx,
 					uint16_t src, uint16_t dst,
-					uint8_t key_id,
+					uint8_t key_aid,
 					bool szmic, uint16_t seqZero,
 					const uint8_t *data, uint16_t size)
 {
@@ -1781,7 +1778,7 @@ static bool msg_rxed(struct mesh_net *net, bool frnd,
 
 	/* Save un-decrypted messages for our friends */
 	if (!frnd && l_queue_length(net->friends)) {
-		uint32_t hdr = key_id << KEY_HDR_SHIFT;
+		uint32_t hdr = key_aid << KEY_HDR_SHIFT;
 		uint8_t frnd_ttl = ttl;
 
 		/* If not from us, decrement for our hop */
@@ -1806,8 +1803,8 @@ static bool msg_rxed(struct mesh_net *net, bool frnd,
 	}
 
 not_for_friend:
-	return mesh_model_rx(net->node, szmic, seqAuth, seq, iv_index,
-					ttl, src, dst, key_id, data, size);
+	return mesh_model_rx(net->node, szmic, seqAuth, seq, iv_index, ttl,
+					net_idx, src, dst, key_aid, data, size);
 }
 
 static bool match_frnd_sar_dst(const void *a, const void *b)
@@ -1915,12 +1912,11 @@ static void friend_seg_rxed(struct mesh_net *net,
 	frnd_msg->cnt_in++;
 }
 
-static bool seg_rxed(struct mesh_net *net, bool frnd,
-					uint32_t iv_index,
-					uint8_t ttl,
-					uint32_t seq,
+static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
+					uint8_t ttl, uint32_t seq,
+					uint16_t net_idx,
 					uint16_t src, uint16_t dst,
-					uint8_t key_id,
+					uint8_t key_aid,
 					bool szmic, uint16_t seqZero,
 					uint8_t segO, uint8_t segN,
 					const uint8_t *data, uint8_t size)
@@ -1967,7 +1963,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd,
 					seqZero, seq, size, segO, segN);
 		/* Sanity Check--> certain things must match */
 		if (SEG_MAX(sar_in->len) != segN ||
-				sar_in->key_id != key_id)
+				sar_in->key_aid != key_aid)
 			return false;
 
 		if (sar_in->flags == expected) {
@@ -1988,7 +1984,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd,
 		sar_in->src = dst;
 		sar_in->remote = src;
 		sar_in->seqZero = seqZero;
-		sar_in->key_id = key_id;
+		sar_in->key_aid = key_aid;
 		sar_in->len = len;
 		sar_in->last_seg = 0xff;
 		if (!net->friend_addr)
@@ -2022,12 +2018,9 @@ static bool seg_rxed(struct mesh_net *net, bool frnd,
 		if (!net->friend_addr)
 			send_net_ack(net, sar_in, expected);
 
-		msg_rxed(net, frnd,
-				iv_index,
-				ttl,
-				seq,
+		msg_rxed(net, frnd, iv_index, ttl, seq, net_idx,
 				sar_in->remote, dst,
-				key_id,
+				key_aid,
 				szmic, sar_in->seqZero,
 				sar_in->buf, sar_in->len);
 
@@ -2300,6 +2293,22 @@ static void send_msg_pkt(struct mesh_net *net, uint8_t *packet, uint8_t size)
 	mesh_io_send(io, &info, packet, size);
 }
 
+static uint16_t key_id_to_net_idx(struct mesh_net *net, uint32_t key_id)
+{
+	struct mesh_subnet *subnet;
+
+	if (!net)
+		return NET_IDX_INVALID;
+
+	subnet = l_queue_find(net->subnets, match_key_id,
+						L_UINT_TO_PTR(key_id));
+
+	if (subnet)
+		return subnet->idx;
+	else
+		return NET_IDX_INVALID;
+}
+
 static enum _relay_advice packet_received(void *user_data,
 				uint32_t key_id, uint32_t iv_index,
 				const void *data, uint8_t size, int8_t rssi)
@@ -2310,6 +2319,7 @@ static enum _relay_advice packet_received(void *user_data,
 	uint8_t net_ttl, net_key_id, net_segO, net_segN, net_opcode;
 	uint32_t net_seq, cache_cookie;
 	uint16_t net_src, net_dst, net_seqZero;
+	uint16_t net_idx;
 	uint8_t packet[31];
 	bool net_ctl, net_segmented, net_szmic, net_relay;
 	struct mesh_friend *net_frnd = NULL;
@@ -2325,6 +2335,10 @@ static enum _relay_advice packet_received(void *user_data,
 	if (!drop)
 		print_packet("RX: Network [clr] :", packet + 2, size);
 
+	net_idx = key_id_to_net_idx(net, key_id);
+	if (net_idx == NET_IDX_INVALID)
+		return RELAY_NONE;
+
 	if (!mesh_crypto_packet_parse(packet + 2, size,
 					&net_ctl, &net_ttl,
 					&net_seq,
@@ -2433,10 +2447,8 @@ static enum _relay_advice packet_received(void *user_data,
 						msg, app_msg_len);
 				}
 			} else {
-				seg_rxed(net, net_frnd,
-						iv_index,
-						net_ttl,
-						net_seq,
+				seg_rxed(net, net_frnd, iv_index, net_ttl,
+						net_seq, net_idx,
 						net_src, net_dst,
 						net_key_id,
 						net_szmic, net_seqZero,
@@ -2449,6 +2461,7 @@ static enum _relay_advice packet_received(void *user_data,
 						iv_index,
 						net_ttl,
 						net_seq,
+						net_idx,
 						net_src, net_dst,
 						net_key_id,
 						false, net_seq & SEQ_ZERO_MASK,
@@ -3291,7 +3304,7 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 					seq_num,
 					msg->src, msg->remote,
 					0,
-					segN ? true : false, msg->key_id,
+					segN ? true : false, msg->key_aid,
 					msg->szmic, false, msg->seqZero,
 					segO, segN,
 					msg->buf + seg_off, seg_len,
@@ -3389,9 +3402,9 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 }
 
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
-				uint16_t dst, uint8_t key_id, uint8_t ttl,
-				uint32_t seq, uint32_t iv_index, bool szmic,
-				const void *msg, uint16_t msg_len,
+				uint16_t dst, uint8_t key_aid, uint16_t net_idx,
+				uint8_t ttl, uint32_t seq, uint32_t iv_index,
+				bool szmic, const void *msg, uint16_t msg_len,
 				mesh_net_status_func_t status_func,
 				void *user_data)
 {
@@ -3408,18 +3421,17 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	if (!src || !dst)
 		return false;
 
-	if (ttl == 0xff)
+	if (ttl == DEFAULT_TTL)
 		ttl = net->default_ttl;
 
 	seg_max = SEG_MAX(msg_len);
 
 	/* First enqueue to any Friends and internal models */
-	result = msg_rxed(net, false,
-				iv_index,
-				ttl,
+	result = msg_rxed(net, false, iv_index, ttl,
 				seq + seg_max,
+				net_idx,
 				src, dst,
-				key_id,
+				key_aid,
 				szmic, seq & SEQ_ZERO_MASK,
 				msg, msg_len);
 
@@ -3450,7 +3462,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	payload->ttl = ttl;
 	payload->szmic = szmic;
 	payload->frnd_cred = frnd_cred;
-	payload->key_id = key_id;
+	payload->key_aid = key_aid;
 	if (seg_max) {
 		payload->flags = 0xffffffff >> (31 - seg_max);
 		payload->seqZero = seq & SEQ_ZERO_MASK;
@@ -3561,7 +3573,7 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 	if (src == dst)
 		return;
 
-	if (ttl == 0xff)
+	if (ttl == DEFAULT_TTL)
 		ttl = net->default_ttl;
 
 	/* Range check the Opcode and msg length*/
diff --git a/mesh/net.h b/mesh/net.h
index 7b0733578..834a7351a 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -300,9 +300,9 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 				const uint8_t *msg, uint16_t msg_len);
 
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
-				uint16_t dst, uint8_t key_id, uint8_t ttl,
-				uint32_t seq, uint32_t iv_index, bool szmic,
-				const void *msg, uint16_t msg_len,
+				uint16_t dst, uint8_t key_id, uint16_t net_idx,
+				uint8_t ttl, uint32_t seq, uint32_t iv_index,
+				bool szmic, const void *msg, uint16_t msg_len,
 				mesh_net_status_func_t status_func,
 				void *user_data);
 void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
diff --git a/mesh/node.c b/mesh/node.c
index 27235ef34..40d103327 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1790,12 +1790,12 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	if ((app_idx & APP_IDX_MASK) != app_idx)
+	if (app_idx & ~APP_IDX_MASK)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 						"Invalid key_index");
 
-	if (!mesh_model_send(node, src, dst, app_idx & APP_IDX_MASK,
-				mesh_net_get_default_ttl(node->net), data, len))
+	if (!mesh_model_send(node, src, dst, app_idx, 0, DEFAULT_TTL,
+								data, len))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
 	return l_dbus_message_new_method_return(msg);
@@ -1837,8 +1837,8 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 							"Incorrect data");
 
 	/* TODO: use net_idx */
-	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE,
-				mesh_net_get_default_ttl(node->net), data, len))
+	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE, net_idx,
+							DEFAULT_TTL, data, len))
 		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
 
 	return l_dbus_message_new_method_return(msg);
-- 
2.14.5

