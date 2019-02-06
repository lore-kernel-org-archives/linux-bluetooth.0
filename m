Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC66C169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 07:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256D8218A1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 07:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBFHbc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:31:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:2236 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFHbc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 02:31:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 23:31:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="131449177"
Received: from ingas-nuc1.sea.intel.com ([10.254.59.164])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2019 23:31:31 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/5] mesh: Separate functions for net key add and update
Date:   Tue,  5 Feb 2019 23:31:11 -0800
Message-Id: <20190206073115.28232-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190206073115.28232-1-inga.stotland@intel.com>
References: <20190206073115.28232-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This splits mesh_net_key_add() into two separate functions:
mesh_net_key_add() and mesh_net_key_update().
mesh_net_key_update() essentially replaces mesh_net_kr_phase_one()
since switching to Key Refresh phase one can only be triggered
by successful network key update.
---
 mesh/cfgmod-server.c |  8 ++++++--
 mesh/net.c           | 24 +++++++-----------------
 mesh/net.h           |  8 ++++----
 mesh/node.c          |  4 ++--
 mesh/storage.c       |  2 +-
 5 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 062bdaaf2..899bdde2e 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -981,8 +981,12 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 		if (size != 18)
 			return true;
 
-		b_res = mesh_net_add_key(net, opcode == OP_NETKEY_UPDATE,
-						l_get_le16(pkt), pkt + 2);
+		net_idx = l_get_le16(pkt);
+
+		if (opcode == OP_NETKEY_ADD)
+			b_res = mesh_net_add_key(net, net_idx, pkt + 2);
+		else
+			b_res = mesh_net_update_key(net, net_idx, pkt + 2);
 
 		l_debug("NetKey Add/Update %s",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail");
diff --git a/mesh/net.c b/mesh/net.c
index 9e509a8ea..bfc1a01bb 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -970,27 +970,13 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_net_add_key(struct mesh_net *net, bool update, uint16_t idx,
-							const void *value)
+int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 {
-	int status;
 	struct mesh_subnet *subnet;
 
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
 
-	if (update) {
-		if (subnet && subnet->kr_phase == KEY_REFRESH_PHASE_NONE) {
-			l_info("Start key refresh");
-			status = mesh_net_kr_phase_one(net, idx, value);
-			if (status == MESH_STATUS_SUCCESS &&
-				!storage_net_key_add(net, idx,
-						value, KEY_REFRESH_PHASE_ONE))
-				return MESH_STATUS_STORAGE_FAIL;
-		} else
-			return MESH_STATUS_CANNOT_UPDATE;
-	}
-
 	if (subnet) {
 		if (net_key_confirm(subnet->net_key_cur, value))
 			return MESH_STATUS_SUCCESS;
@@ -3570,7 +3556,7 @@ uint8_t mesh_net_key_refresh_phase_get(struct mesh_net *net, uint16_t idx,
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_net_kr_phase_one(struct mesh_net *net, uint16_t idx,
+int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 							const uint8_t *value)
 {
 	struct mesh_subnet *subnet;
@@ -3580,7 +3566,8 @@ int mesh_net_kr_phase_one(struct mesh_net *net, uint16_t idx,
 
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
-	if (!subnet)
+
+	if (!subnet || !subnet->kr_phase == KEY_REFRESH_PHASE_NONE)
 		return MESH_STATUS_CANNOT_UPDATE;
 
 	if (subnet->net_key_upd) {
@@ -3606,6 +3593,9 @@ int mesh_net_kr_phase_one(struct mesh_net *net, uint16_t idx,
 
 	l_info("key refresh phase 1: Key ID %d", subnet->net_key_upd);
 
+	if (!storage_net_key_add(net, idx, value, KEY_REFRESH_PHASE_ONE))
+		return MESH_STATUS_STORAGE_FAIL;
+
 	subnet->kr_phase = KEY_REFRESH_PHASE_ONE;
 
 	return MESH_STATUS_SUCCESS;
diff --git a/mesh/net.h b/mesh/net.h
index 0ef01b63e..b27a4e614 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -280,8 +280,10 @@ bool mesh_net_set_relay_mode(struct mesh_net *net, bool enable, uint8_t cnt,
 							uint8_t interval);
 bool mesh_net_set_friend_mode(struct mesh_net *net, bool enable);
 int mesh_net_del_key(struct mesh_net *net, uint16_t net_idx);
-int mesh_net_add_key(struct mesh_net *net, bool update,
-					uint16_t net_idx, const void *key);
+int mesh_net_add_key(struct mesh_net *net, uint16_t net_idx,
+							const uint8_t *key);
+int mesh_net_update_key(struct mesh_net *net, uint16_t net_idx,
+							const uint8_t *key);
 uint32_t mesh_net_get_iv_index(struct mesh_net *net);
 void mesh_net_get_snb_state(struct mesh_net *net,
 					uint8_t *flags, uint32_t *iv_index);
@@ -335,8 +337,6 @@ uint8_t mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t net_idx,
 							uint8_t transition);
 uint8_t mesh_net_key_refresh_phase_get(struct mesh_net *net, uint16_t net_idx,
 							uint8_t *phase);
-int mesh_net_kr_phase_one(struct mesh_net *net, uint16_t net_idx,
-							const uint8_t *key);
 int mesh_net_key_refresh_phase_two(struct mesh_net *net, uint16_t net_idx);
 int mesh_net_key_refresh_finish(struct mesh_net *net, uint16_t net_idx);
 void mesh_net_send_seg(struct mesh_net *net, uint32_t key_id,
diff --git a/mesh/node.c b/mesh/node.c
index e921b72b7..1845f9a32 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1726,8 +1726,8 @@ bool node_add_pending_local(struct mesh_node *node, void *prov_node_info,
 	if (!mesh_db_write_device_key(node->jconfig, info->device_key))
 		return false;
 
-	if (mesh_net_add_key(node->net, kr, info->net_index,
-			info->net_key) != MESH_STATUS_SUCCESS)
+	if (mesh_net_add_key(node->net, info->net_index, info->net_key) !=
+							MESH_STATUS_SUCCESS)
 		return false;
 
 	if (!storage_net_key_add(node->net, info->net_index, info->net_key,
diff --git a/mesh/storage.c b/mesh/storage.c
index 3a6614eb2..1b52000b0 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -120,7 +120,7 @@ static bool read_net_keys_cb(uint16_t idx, uint8_t *key, uint8_t *new_key,
 	if (!net)
 		return false;
 
-	if (mesh_net_add_key(net, false, idx, key) != MESH_STATUS_SUCCESS)
+	if (mesh_net_add_key(net, idx, key) != MESH_STATUS_SUCCESS)
 		return false;
 	/* TODO: handle restoring key refresh phase and new keys */
 
-- 
2.17.2

