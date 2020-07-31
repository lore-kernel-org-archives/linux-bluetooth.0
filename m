Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2006CC433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 06:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDAB208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 06:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgGaGTo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:19:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:44826 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731359AbgGaGTn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jul 2020 02:19:43 -0400
IronPort-SDR: mDFSXu0C0Z37OFt5RWKP4tPuT1UqmMv5b99wT3cXk5TPuizLjR/CQtudgaGqApv7TYm9EnyJgy
 KEybt3zCPKSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="213269546"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="213269546"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 23:19:37 -0700
IronPort-SDR: IYrhxq1O9BjhIuaiHXwLjFqUIFZifo0woJrNrLQNxhCDEnTqIkb2h6yF/4bsgfsjnEc2eSdbGC
 NwN/OOZXCH8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="329163333"
Received: from wlloyd-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.79.39])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2020 23:19:37 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 01/10] mesh: Clean up handling of config subscription messages
Date:   Thu, 30 Jul 2020 23:19:27 -0700
Message-Id: <20200731061936.56952-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This provides better functional grouping based on whether a group or
a virtual label is used for the subscription address.

Also, use a single point for sending out the composed Config Server
status messages.
---
 mesh/cfgmod-server.c    | 344 +++++++++++++++++-----------------------
 mesh/mesh-config-json.c |  12 +-
 mesh/mesh-config.h      |   6 +-
 mesh/model.c            | 211 ++++++++++++++----------
 mesh/model.h            |  21 ++-
 5 files changed, 296 insertions(+), 298 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 7672ad3b6..cd0e8b94c 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -32,6 +32,10 @@
 #include "mesh/mesh-config.h"
 #include "mesh/cfgmod.h"
 
+#define CFG_SET_ID(vendor, pkt)	((vendor) ?	\
+		(SET_ID(l_get_le16((pkt)), l_get_le16((pkt) + 2))) :	\
+		(SET_ID(SIG_VENDOR, l_get_le16(pkt))))
+
 /* Supported composition pages, sorted high to low */
 /* Only page 0 is currently supported */
 static const uint8_t supported_pages[] = {
@@ -185,237 +189,177 @@ static void config_pub_set(struct mesh_node *node, uint16_t net_idx,
 				idx, cred_flag, ttl, period, retransmit);
 }
 
-static void send_sub_status(struct mesh_node *node, uint16_t net_idx,
-					uint16_t src, uint16_t dst,
-					uint8_t status, uint16_t ele_addr,
-					uint16_t addr, uint32_t id)
+static uint16_t cfg_sub_get_msg(struct mesh_node *node, const uint8_t *pkt,
+								uint16_t size)
 {
-	int n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_STATUS, msg);
-
-	msg[n++] = status;
-	l_put_le16(ele_addr, msg + n);
-	n += 2;
-	l_put_le16(addr, msg + n);
-	n += 2;
-
-	if (IS_VENDOR(id)) {
-		l_put_le16(VENDOR_ID(id), msg + n);
-		l_put_le16(MODEL_ID(id), msg + n + 2);
-		n += 4;
-	} else {
-		l_put_le16(MODEL_ID(id), msg + n);
-		n += 2;
-	}
-
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
-								false, msg, n);
-}
-
-static bool config_sub_get(struct mesh_node *node, uint16_t net_idx,
-					uint16_t src, uint16_t dst,
-					const uint8_t *pkt, uint16_t size)
-{
-	uint16_t ele_addr;
+	uint16_t ele_addr, n, sub_len;
 	uint32_t id;
-	uint16_t n = 0;
-	int status;
-	uint8_t *msg_status;
-	uint16_t buf_size;
+	int opcode;
+	bool vendor = (size == 6);
 
-	/* Incoming message has already been size-checked */
 	ele_addr = l_get_le16(pkt);
+	id = CFG_SET_ID(vendor, pkt + 2);
+	opcode = vendor ? OP_CONFIG_VEND_MODEL_SUB_LIST :
+						OP_CONFIG_MODEL_SUB_LIST;
+	n = mesh_model_opcode_set(opcode, msg);
+	memcpy(msg + n + 1, pkt, size);
 
-	switch (size) {
-	default:
-		l_debug("Bad length %d", size);
-		return false;
-
-	case 4:
-		id = l_get_le16(pkt + 2);
-		n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_LIST, msg);
-		msg_status = msg + n;
-		msg[n++] = 0;
-		l_put_le16(ele_addr, msg + n);
-		n += 2;
-		l_put_le16(id, msg + n);
-		n += 2;
-		id = SET_ID(SIG_VENDOR, id);
-		break;
-
-	case 6:
-		id = SET_ID(l_get_le16(pkt + 2), l_get_le16(pkt + 4));
-		n = mesh_model_opcode_set(OP_CONFIG_VEND_MODEL_SUB_LIST, msg);
-		msg_status = msg + n;
-		msg[n++] = 0;
-		l_put_le16(ele_addr, msg + n);
-		n += 2;
-		l_put_le16(VENDOR_ID(id), msg + n);
-		n += 2;
-		l_put_le16(MODEL_ID(id), msg + n);
-		n += 2;
-		break;
-	}
-
-	buf_size = sizeof(uint16_t) * MAX_GRP_PER_MOD;
-	status = mesh_model_sub_get(node, ele_addr, id, msg + n, buf_size,
-									&size);
-
-	if (status == MESH_STATUS_SUCCESS)
-		n += size;
+	msg[n] = mesh_model_sub_get(node, ele_addr, id, msg + n + 1 + size,
+					MAX_MSG_LEN - (n + 1 + size), &sub_len);
 
-	*msg_status = (uint8_t) status;
+	if (msg[n] == MESH_STATUS_SUCCESS)
+		n += sub_len;
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, net_idx, DEFAULT_TTL,
-								false, msg, n);
-	return true;
+	n += (size + 1);
+	return n;
 }
 
-static bool save_config_sub(struct mesh_node *node, uint16_t ele_addr,
-					uint32_t id, bool vendor,
-					const uint8_t *addr, bool virt,
-					uint16_t grp, uint32_t opcode)
+static bool save_cfg_sub(struct mesh_node *node, uint16_t ele_addr,
+				uint32_t id, bool vendor, const uint8_t *label,
+				bool virt, uint16_t grp, uint32_t opcode)
 {
+	struct mesh_config *cfg = node_config_get(node);
 	struct mesh_config_sub db_sub = {
 				.virt = virt,
-				.src.addr = grp
+				.addr.grp = grp
 				};
 
+	id = (vendor) ? id : MODEL_ID(id);
+
 	if (virt)
-		memcpy(db_sub.src.virt_addr, addr, 16);
+		memcpy(db_sub.addr.label, label, 16);
+
+	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_DELETE &&
+			opcode == OP_CONFIG_MODEL_SUB_DELETE)
+		return mesh_config_model_sub_del(cfg, ele_addr, id, vendor,
+								&db_sub);
 
 	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE ||
 					opcode == OP_CONFIG_MODEL_SUB_OVERWRITE)
-		mesh_config_model_sub_del_all(node_config_get(node), ele_addr,
-						vendor ? id : MODEL_ID(id),
-									vendor);
 
-	if (opcode != OP_CONFIG_MODEL_SUB_VIRT_DELETE &&
-			opcode != OP_CONFIG_MODEL_SUB_DELETE)
-		return mesh_config_model_sub_add(node_config_get(node),
-					ele_addr, vendor ? id : MODEL_ID(id),
-					vendor, &db_sub);
-	else
-		return mesh_config_model_sub_del(node_config_get(node),
-					ele_addr, vendor ? id : MODEL_ID(id),
-					vendor, &db_sub);
+		if (!mesh_config_model_sub_del_all(cfg, ele_addr, id, vendor))
+			return false;
+
+	return mesh_config_model_sub_add(cfg, ele_addr, id, vendor, &db_sub);
 }
 
-static void config_sub_set(struct mesh_node *node, uint16_t net_idx,
-					uint16_t src, uint16_t dst,
-					const uint8_t *pkt, uint16_t size,
-					bool virt, uint32_t opcode)
+static uint16_t cfg_sub_add_msg(struct mesh_node *node, const uint8_t *pkt,
+					bool vendor, uint32_t opcode)
 {
-	uint16_t grp, ele_addr;
+	uint16_t addr, ele_addr, n;
 	uint32_t id;
-	const uint8_t *addr = NULL;
-	int status = MESH_STATUS_SUCCESS;
-	bool vendor = false;
 
-	switch (size) {
-	default:
-		l_error("Bad length: %d", size);
-		return;
-	case 4:
-		if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL)
-			return;
+	addr = l_get_le16(pkt + 2);
 
-		id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 2));
-		break;
-	case 6:
-		if (virt)
-			return;
+	if (!IS_GROUP(addr))
+		return 0;
 
-		if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL) {
-			id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 4));
-		} else {
-			id = SET_ID(l_get_le16(pkt + 2), l_get_le16(pkt + 4));
-			vendor = true;
-		}
+	ele_addr = l_get_le16(pkt);
+	id = CFG_SET_ID(vendor, pkt + 4);
 
-		break;
-	case 8:
-		if (virt)
-			return;
+	n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_STATUS, msg);
 
-		id = SET_ID(l_get_le16(pkt + 4), l_get_le16(pkt + 6));
-		vendor = true;
-		break;
-	case 20:
-		if (!virt)
-			return;
+	if (opcode == OP_CONFIG_MODEL_SUB_OVERWRITE)
+		msg[n] = mesh_model_sub_ovrt(node, ele_addr, id, addr);
+	else if (opcode == OP_CONFIG_MODEL_SUB_ADD)
+		msg[n] = mesh_model_sub_add(node, ele_addr, id, addr);
+	else
+		msg[n] = mesh_model_sub_del(node, ele_addr, id, addr);
 
-		id = SET_ID(SIG_VENDOR, l_get_le16(pkt + 18));
-		break;
-	case 22:
-		if (!virt)
-			return;
+	if (msg[n] == MESH_STATUS_SUCCESS &&
+			!save_cfg_sub(node, ele_addr, id, vendor, NULL, false,
+								addr, opcode))
+		msg[n] = MESH_STATUS_STORAGE_FAIL;
 
-		vendor = true;
-		id = SET_ID(l_get_le16(pkt + 18), l_get_le16(pkt + 20));
-		break;
+	if (vendor) {
+		memcpy(msg + n + 1, pkt, 8);
+		n += 9;
+	} else {
+		memcpy(msg + n + 1, pkt, 6);
+		n += 7;
 	}
 
+	return n;
+}
+
+static uint16_t cfg_virt_sub_add_msg(struct mesh_node *node, const uint8_t *pkt,
+						bool vendor, uint32_t opcode)
+{
+	uint16_t addr, ele_addr, n;
+	uint32_t id;
+	const uint8_t *label;
+
+	n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_STATUS, msg);
+
 	ele_addr = l_get_le16(pkt);
+	label = pkt + 2;
+	id = CFG_SET_ID(vendor, pkt + 18);
+
+	if (opcode == OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE)
+		msg[n] = mesh_model_virt_sub_ovrt(node, ele_addr, id, label,
+									&addr);
+	else if (opcode == OP_CONFIG_MODEL_SUB_VIRT_ADD)
+		msg[n] = mesh_model_virt_sub_add(node, ele_addr, id, label,
+									&addr);
+	else
+		msg[n] = mesh_model_virt_sub_del(node, ele_addr, id, label,
+									&addr);
 
-	if (opcode != OP_CONFIG_MODEL_SUB_DELETE_ALL) {
-		addr = pkt + 2;
-		grp = l_get_le16(addr);
-	} else
-		grp = UNASSIGNED_ADDRESS;
+	if (msg[n] == MESH_STATUS_SUCCESS &&
+				!save_cfg_sub(node, ele_addr, id, vendor,
+						label, true, addr, opcode))
+		msg[n] = MESH_STATUS_STORAGE_FAIL;
 
-	switch (opcode) {
-	default:
-		l_debug("Bad opcode: %x", opcode);
-		return;
+	l_put_le16(ele_addr, msg + n + 1);
+	l_put_le16(addr, msg + n + 3);
 
-	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
-		status = mesh_model_sub_del_all(node, ele_addr, id);
+	if (vendor) {
+		l_put_le16(VENDOR_ID(id), msg + n + 5);
+		l_put_le16(MODEL_ID(id), msg + n + 7);
+		n += 9;
+	} else {
+		l_put_le16(MODEL_ID(id), msg + n + 5);
+		n += 7;
+	}
 
-		if (status == MESH_STATUS_SUCCESS)
-			mesh_config_model_sub_del_all(node_config_get(node),
-					ele_addr, vendor ? id : MODEL_ID(id),
-									vendor);
-		break;
+	return n;
+}
 
-	case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
-		grp = UNASSIGNED_ADDRESS;
-		/* Fall Through */
-	case OP_CONFIG_MODEL_SUB_OVERWRITE:
-		status = mesh_model_sub_ovr(node, ele_addr, id,
-							addr, virt, &grp);
+static uint16_t config_sub_del_all(struct mesh_node *node, const uint8_t *pkt,
+								bool vendor)
+{
+	uint16_t ele_addr, n, grp = UNASSIGNED_ADDRESS;
+	uint32_t id;
 
-		if (status == MESH_STATUS_SUCCESS)
-			save_config_sub(node, ele_addr, id, vendor, addr,
-							virt, grp, opcode);
-		break;
-	case OP_CONFIG_MODEL_SUB_VIRT_ADD:
-		grp = UNASSIGNED_ADDRESS;
-		/* Fall Through */
-	case OP_CONFIG_MODEL_SUB_ADD:
-		status = mesh_model_sub_add(node, ele_addr, id,
-							addr, virt, &grp);
+	n = mesh_model_opcode_set(OP_CONFIG_MODEL_SUB_STATUS, msg);
 
-		if (status == MESH_STATUS_SUCCESS &&
-				!save_config_sub(node, ele_addr, id, vendor,
-						addr, virt, grp, opcode))
-			status = MESH_STATUS_STORAGE_FAIL;
+	ele_addr = l_get_le16(pkt);
+	id = CFG_SET_ID(vendor, pkt + 2);
 
-		break;
-	case OP_CONFIG_MODEL_SUB_VIRT_DELETE:
-		grp = UNASSIGNED_ADDRESS;
-		/* Fall Through */
-	case OP_CONFIG_MODEL_SUB_DELETE:
-		status = mesh_model_sub_del(node, ele_addr, id, addr, virt,
-									&grp);
+	msg[n] = mesh_model_sub_del_all(node, ele_addr, id);
 
-		if (status == MESH_STATUS_SUCCESS)
-			save_config_sub(node, ele_addr, id, vendor, addr,
-							virt, grp, opcode);
+	if (msg[n] == MESH_STATUS_SUCCESS) {
+		struct mesh_config *cfg = node_config_get(node);
 
-		break;
+		if (!mesh_config_model_sub_del_all(cfg, ele_addr,
+						vendor ? id : MODEL_ID(id),
+						vendor))
+			msg[n] = MESH_STATUS_STORAGE_FAIL;
+	}
+
+	l_put_le16(ele_addr, msg + n + 1);
+	l_put_le16(grp, msg + n + 3);
+
+	if (vendor) {
+		l_put_le16(VENDOR_ID(id), msg + n + 5);
+		l_put_le16(MODEL_ID(id), msg + n + 7);
+		n += 9;
+	} else {
+		l_put_le16(MODEL_ID(id), msg + n + 5);
+		n += 7;
 	}
 
-	send_sub_status(node, net_idx, src, dst, status, ele_addr, grp, id);
+	return n;
 }
 
 static void send_model_app_status(struct mesh_node *node, uint16_t net_idx,
@@ -797,28 +741,38 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	case OP_CONFIG_VEND_MODEL_SUB_GET:
 		if (size != 6)
 			return true;
-
-		config_sub_get(node, net_idx, src, dst, pkt, size);
-		break;
+		/* Fall Through */
 
 	case OP_CONFIG_MODEL_SUB_GET:
-		if (size != 4)
+		if (size != 4 && opcode == OP_CONFIG_MODEL_SUB_GET)
 			return true;
 
-		config_sub_get(node, net_idx, src, dst, pkt, size);
+		n = cfg_sub_get_msg(node, pkt, size);
 		break;
 
 	case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
 	case OP_CONFIG_MODEL_SUB_VIRT_DELETE:
 	case OP_CONFIG_MODEL_SUB_VIRT_ADD:
-		virt = true;
-		/* Fall Through */
+		if (size != 20 && size != 22)
+			return true;
+
+		n = cfg_virt_sub_add_msg(node, pkt, size == 22, opcode);
+		break;
+
 	case OP_CONFIG_MODEL_SUB_OVERWRITE:
 	case OP_CONFIG_MODEL_SUB_DELETE:
 	case OP_CONFIG_MODEL_SUB_ADD:
+		if (size != 6 && size != 8)
+			return true;
+
+		n = cfg_sub_add_msg(node, pkt, size == 8, opcode);
+		break;
+
 	case OP_CONFIG_MODEL_SUB_DELETE_ALL:
-		config_sub_set(node, net_idx, src, dst, pkt, size, virt,
-									opcode);
+		if (size != 4 && size != 6)
+			return true;
+
+		n = config_sub_del_all(node, pkt, size == 6);
 		break;
 
 	case OP_CONFIG_RELAY_SET:
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index deb0019f9..a40f92c01 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1069,11 +1069,11 @@ static bool parse_model_subscriptions(json_object *jsubs,
 
 		switch (len) {
 		case 4:
-			if (sscanf(str, "%04hx", &subs[i].src.addr) != 1)
+			if (sscanf(str, "%04hx", &subs[i].addr.grp) != 1)
 				goto fail;
 		break;
 		case 32:
-			if (!str2hex(str, len, subs[i].src.virt_addr, 16))
+			if (!str2hex(str, len, subs[i].addr.label, 16))
 				goto fail;
 			subs[i].virt = true;
 			break;
@@ -2068,10 +2068,10 @@ bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 		return false;
 
 	if (!sub->virt) {
-		snprintf(buf, 5, "%4.4x", sub->src.addr);
+		snprintf(buf, 5, "%4.4x", sub->addr.grp);
 		len = 4;
 	} else {
-		hex2str(sub->src.virt_addr, 16, buf, 33);
+		hex2str(sub->addr.label, 16, buf, 33);
 		len = 32;
 	}
 
@@ -2122,10 +2122,10 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 		return true;
 
 	if (!sub->virt) {
-		snprintf(buf, 5, "%4.4x", sub->src.addr);
+		snprintf(buf, 5, "%4.4x", sub->addr.grp);
 		len = 4;
 	} else {
-		hex2str(sub->src.virt_addr, 16, buf, 33);
+		hex2str(sub->addr.label, 16, buf, 33);
 		len = 32;
 	}
 
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 7dfa9f20c..f15f3f376 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -24,9 +24,9 @@ struct mesh_config;
 struct mesh_config_sub {
 	bool virt;
 	union {
-		uint16_t	addr;
-		uint8_t	virt_addr[16];
-	} src;
+		uint16_t grp;
+		uint8_t	label[16];
+	} addr;
 };
 
 struct mesh_config_pub {
diff --git a/mesh/model.c b/mesh/model.c
index ef7668147..3c9b6577a 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -664,7 +664,7 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 		return MESH_STATUS_SUCCESS;
 	}
 
-	if (l_queue_length(mod->bindings) >= MAX_BINDINGS)
+	if (l_queue_length(mod->bindings) >= MAX_MODEL_BINDINGS)
 		return MESH_STATUS_INSUFF_RESOURCES;
 
 	if (!mesh_config_model_binding_add(node_config_get(node), addr,
@@ -737,7 +737,7 @@ static int set_virt_pub(struct mesh_model *mod, const uint8_t *label,
 }
 
 static int add_virt_sub(struct mesh_net *net, struct mesh_model *mod,
-			     const uint8_t *label, uint16_t *dst)
+				const uint8_t *label, uint16_t *addr)
 {
 	struct mesh_virtual *virt = l_queue_find(mod->virtuals,
 						find_virt_by_label, label);
@@ -745,40 +745,35 @@ static int add_virt_sub(struct mesh_net *net, struct mesh_model *mod,
 	if (!virt) {
 		virt = add_virtual(label);
 		if (!virt)
-			return MESH_STATUS_STORAGE_FAIL;
+			return MESH_STATUS_INSUFF_RESOURCES;
 
 		l_queue_push_head(mod->virtuals, virt);
 		mesh_net_dst_reg(net, virt->addr);
 		l_debug("Added virtual sub addr %4.4x", virt->addr);
 	}
 
-	if (dst)
-		*dst = virt->addr;
+	if (addr)
+		*addr = virt->addr;
 
 	return MESH_STATUS_SUCCESS;
 }
 
 static int add_sub(struct mesh_net *net, struct mesh_model *mod,
-			const uint8_t *group, bool b_virt, uint16_t *dst)
+							uint16_t addr)
 {
-	uint16_t grp;
-
-	if (b_virt)
-		return add_virt_sub(net, mod, group, dst);
-
-	grp = l_get_le16(group);
-	if (dst)
-		*dst = grp;
+	if (!mod->subs)
+		mod->subs = l_queue_new();
 
-	if (!l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(grp))) {
+	if (l_queue_find(mod->subs, simple_match, L_UINT_TO_PTR(addr)))
+		return MESH_STATUS_SUCCESS;
 
-		if (!mod->subs)
-			mod->subs = l_queue_new();
+	if ((l_queue_length(mod->subs) + l_queue_length(mod->virtuals)) >=
+						MAX_MODEL_SUBS)
+		return MESH_STATUS_INSUFF_RESOURCES;
 
-		l_queue_push_tail(mod->subs, L_UINT_TO_PTR(grp));
-		mesh_net_dst_reg(net, grp);
-		l_debug("Added group subscription %4.4x", grp);
-	}
+	l_queue_push_tail(mod->subs, L_UINT_TO_PTR(addr));
+	mesh_net_dst_reg(net, addr);
+	l_debug("Added group subscription %4.4x", addr);
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -1454,8 +1449,8 @@ int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *group, bool is_virt, uint16_t *dst)
+int mesh_model_sub_add(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
+								uint16_t addr)
 {
 	struct mesh_model *mod;
 	int status, ele_idx = node_get_element_idx(node, addr);
@@ -1470,7 +1465,35 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
 
-	status = add_sub(node_get_net(node), mod, group, is_virt, dst);
+	status = add_sub(node_get_net(node), mod, addr);
+	if (status != MESH_STATUS_SUCCESS)
+		return status;
+
+	if (!mod->cbs)
+		/* External models */
+		cfg_update_model_subs(node, ele_idx, mod);
+
+	return MESH_STATUS_SUCCESS;
+}
+
+int mesh_model_virt_sub_add(struct mesh_node *node, uint16_t ele_addr,
+				uint32_t id, const uint8_t *label,
+				uint16_t *pub_addr)
+{
+	struct mesh_model *mod;
+	int status, ele_idx = node_get_element_idx(node, ele_addr);
+
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
+	if (!mod)
+		return MESH_STATUS_INVALID_MODEL;
+
+	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
+		return MESH_STATUS_NOT_SUB_MOD;
+
+	status = add_virt_sub(node_get_net(node), mod, label, pub_addr);
 
 	if (status != MESH_STATUS_SUCCESS)
 		return status;
@@ -1482,12 +1505,11 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *group, bool is_virt, uint16_t *dst)
+int mesh_model_sub_ovrt(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
+								uint16_t addr)
 {
-	struct l_queue *virtuals, *subs;
 	struct mesh_model *mod;
-	int status, ele_idx = node_get_element_idx(node, addr);
+	int ele_idx = node_get_element_idx(node, addr);
 
 	if (ele_idx < 0)
 		return MESH_STATUS_INVALID_ADDRESS;
@@ -1499,36 +1521,39 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
 
-	subs = mod->subs;
-	virtuals = mod->virtuals;
-	mod->subs = l_queue_new();
-	mod->virtuals = l_queue_new();
+	l_queue_clear(mod->subs, NULL);
+	l_queue_clear(mod->virtuals, unref_virt);
 
-	if (!mod->subs || !mod->virtuals)
-		return MESH_STATUS_INSUFF_RESOURCES;
+	add_sub(node_get_net(node), mod, addr);
 
-	status = add_sub(node_get_net(node), mod, group, is_virt, dst);
+	if (!mod->cbs)
+		/* External models */
+		cfg_update_model_subs(node, ele_idx, mod);
 
-	if (status != MESH_STATUS_SUCCESS) {
-		/* Adding new group failed, so revert to old lists */
-		l_queue_destroy(mod->subs, NULL);
-		mod->subs = subs;
-		l_queue_destroy(mod->virtuals, unref_virt);
-		mod->virtuals = virtuals;
-	} else {
-		const struct l_queue_entry *entry;
-		struct mesh_net *net = node_get_net(node);
+	return MESH_STATUS_SUCCESS;
+}
+
+int mesh_model_virt_sub_ovrt(struct mesh_node *node, uint16_t ele_addr,
+					uint32_t id, const uint8_t *label,
+					uint16_t *addr)
+{
+	struct mesh_model *mod;
+	int status, ele_idx = node_get_element_idx(node, ele_addr);
+
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
+	if (!mod)
+		return MESH_STATUS_INVALID_MODEL;
 
-		entry = l_queue_get_entries(subs);
+	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
+		return MESH_STATUS_NOT_SUB_MOD;
 
-		for (; entry; entry = entry->next)
-			mesh_net_dst_unreg(net,
-					(uint16_t) L_PTR_TO_UINT(entry->data));
+	l_queue_clear(mod->subs, NULL);
+	l_queue_clear(mod->virtuals, unref_virt);
 
-		/* Destroy old lists */
-		l_queue_destroy(subs, NULL);
-		l_queue_destroy(virtuals, unref_virt);
-	}
+	status = add_virt_sub(node_get_net(node), mod, label, addr);
 
 	if (!mod->cbs)
 		/* External models */
@@ -1537,10 +1562,9 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 	return status;
 }
 
-int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
-			const uint8_t *group, bool is_virt, uint16_t *dst)
+int mesh_model_sub_del(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
+								uint16_t addr)
 {
-	uint16_t grp;
 	struct mesh_model *mod;
 	int ele_idx = node_get_element_idx(node, addr);
 
@@ -1554,26 +1578,47 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
 		return MESH_STATUS_NOT_SUB_MOD;
 
-	if (is_virt) {
-		struct mesh_virtual *virt;
+	if (l_queue_remove(mod->subs, L_UINT_TO_PTR(addr))) {
+		mesh_net_dst_unreg(node_get_net(node), addr);
 
-		virt = l_queue_find(mod->virtuals, find_virt_by_label, group);
-		if (virt) {
-			l_queue_remove(mod->virtuals, virt);
-			grp = virt->addr;
-			unref_virt(virt);
-		} else {
-			if (!mesh_crypto_virtual_addr(group, &grp))
-				return MESH_STATUS_STORAGE_FAIL;
-		}
-	} else {
-		grp = l_get_le16(group);
+		if (!mod->cbs)
+			/* External models */
+			cfg_update_model_subs(node, ele_idx, mod);
 	}
 
-	*dst = grp;
+	return MESH_STATUS_SUCCESS;
+}
 
-	if (l_queue_remove(mod->subs, L_UINT_TO_PTR(grp))) {
-		mesh_net_dst_unreg(node_get_net(node), grp);
+int mesh_model_virt_sub_del(struct mesh_node *node, uint16_t ele_addr,
+					uint32_t id, const uint8_t *label,
+					uint16_t *addr)
+{
+	struct mesh_model *mod;
+	struct mesh_virtual *virt;
+	int ele_idx = node_get_element_idx(node, ele_addr);
+
+	if (ele_idx < 0)
+		return MESH_STATUS_INVALID_ADDRESS;
+
+	mod = get_model(node, (uint8_t) ele_idx, id);
+	if (!mod)
+		return MESH_STATUS_INVALID_MODEL;
+
+	if (!mod->sub_enabled || (mod->cbs && !(mod->cbs->sub)))
+		return MESH_STATUS_NOT_SUB_MOD;
+
+	virt = l_queue_remove_if(mod->virtuals, find_virt_by_label, label);
+
+	if (virt) {
+		*addr = virt->addr;
+		unref_virt(virt);
+	} else {
+		*addr = UNASSIGNED_ADDRESS;
+		return MESH_STATUS_SUCCESS;
+	}
+
+	if (l_queue_remove(mod->subs, L_UINT_TO_PTR(*addr))) {
+		mesh_net_dst_unreg(node_get_net(node), *addr);
 
 		if (!mod->cbs)
 			/* External models */
@@ -1614,9 +1659,9 @@ static struct mesh_model *model_setup(struct mesh_net *net, uint8_t ele_idx,
 	struct mesh_config_pub *pub = db_mod->pub;
 	uint32_t i;
 
-	if (db_mod->num_bindings > MAX_BINDINGS) {
+	if (db_mod->num_bindings > MAX_MODEL_BINDINGS) {
 		l_warn("Binding list too long %u (max %u)",
-					db_mod->num_bindings, MAX_BINDINGS);
+				db_mod->num_bindings, MAX_MODEL_BINDINGS);
 		return NULL;
 	}
 
@@ -1670,22 +1715,12 @@ static struct mesh_model *model_setup(struct mesh_net *net, uint8_t ele_idx,
 		return mod;
 
 	for (i = 0; i < db_mod->num_subs; i++) {
-		uint16_t group;
-		uint8_t *src;
+		struct mesh_config_sub *sub = &db_mod->subs[i];
 
-		/*
-		 * To keep calculations for virtual label coherent,
-		 * convert to little endian.
-		 */
-		l_put_le16(db_mod->subs[i].src.addr, &group);
-		src = db_mod->subs[i].virt ? db_mod->subs[i].src.virt_addr :
-			(uint8_t *) &group;
-
-		if (add_sub(net, mod, src, db_mod->subs[i].virt, NULL) !=
-							MESH_STATUS_SUCCESS) {
-			mesh_model_free(mod);
-			return NULL;
-		}
+		if (!sub->virt)
+			add_sub(net, mod, sub->addr.grp);
+		else
+			add_virt_sub(net, mod, sub->addr.label, NULL);
 	}
 
 	return mod;
diff --git a/mesh/model.h b/mesh/model.h
index 0d8dddf92..3221379af 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -19,8 +19,8 @@
 
 struct mesh_model;
 
-#define MAX_BINDINGS	10
-#define MAX_GRP_PER_MOD	10
+#define MAX_MODEL_BINDINGS	10
+#define MAX_MODEL_SUBS		10
 
 #define ACTION_ADD	1
 #define ACTION_UPDATE	2
@@ -89,12 +89,21 @@ int mesh_model_get_bindings(struct mesh_node *node, uint16_t ele_addr,
 				uint32_t id, uint8_t *buf, uint16_t buf_sz,
 								uint16_t *len);
 int mesh_model_sub_add(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
-				const uint8_t *grp, bool b_virt, uint16_t *dst);
+								uint16_t grp);
+int mesh_model_virt_sub_add(struct mesh_node *node, uint16_t ele_addr,
+					uint32_t id, const uint8_t *label,
+					uint16_t *addr);
 int mesh_model_sub_del(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
-				const uint8_t *grp, bool b_virt, uint16_t *dst);
+								uint16_t grp);
+int mesh_model_virt_sub_del(struct mesh_node *node, uint16_t ele_addr,
+					uint32_t id, const uint8_t *label,
+					uint16_t *addr);
 int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id);
-int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
-				const uint8_t *grp, bool b_virt, uint16_t *dst);
+int mesh_model_sub_ovrt(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
+								uint16_t addr);
+int mesh_model_virt_sub_ovrt(struct mesh_node *node, uint16_t ele_addr,
+					uint32_t id, const uint8_t *label,
+					uint16_t *addr);
 int mesh_model_sub_get(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size);
 uint16_t mesh_model_cfg_blk(uint8_t *pkt);
-- 
2.26.2

