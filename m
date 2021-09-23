Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E3C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FDC61038
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbhIWD2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:16373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239058AbhIWD2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555921"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555921"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072372"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:57 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 11/20] tools/mesh-cfgclient: Check the result of config save
Date:   Wed, 22 Sep 2021 20:25:54 -0700
Message-Id: <20210923032603.50536-12-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After successful completion of configuration commands that change
configuration state of network, the updates are expected to be
recorded in configuration file. If for the results are not saved,
print a warning message.
---
 tools/mesh/cfgcli.c | 119 +++++++++++++++++++++++---------------------
 tools/mesh/remote.c |  10 ++--
 tools/mesh/remote.h |   2 +-
 3 files changed, 70 insertions(+), 61 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 2766d47ca..9399228c8 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -405,6 +405,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	struct model_pub pub;
 	int n;
 	struct pending_req *req;
+	bool saved = false;
 
 	if (mesh_opcode_get(data, len, &opcode, &n)) {
 		len -= n;
@@ -428,20 +429,19 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	case OP_DEV_COMP_STATUS:
 		if (len < MIN_COMPOSITION_LEN)
-			break;
+			return true;
 
 		print_composition(data, len);
 
-		if (!mesh_db_node_set_composition(src, data, len))
-			bt_shell_printf("Failed to save node composition!\n");
-		else
+		saved = mesh_db_node_set_composition(src, data, len);
+		if (saved)
 			remote_set_composition(src, true);
 
 		break;
 
 	case OP_APPKEY_STATUS:
 		if (len != 4)
-			break;
+			return true;
 
 		bt_shell_printf("Node %4.4x AppKey status %s\n", src,
 						mesh_status_str(data[0]));
@@ -452,23 +452,22 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("AppKey\t%u (0x%3.3x)\n", app_idx, app_idx);
 
 		if (data[0] != MESH_STATUS_SUCCESS)
-			break;
+			return true;
 
 		if (!cmd)
-			break;
+			return true;
 
 		if (cmd->opcode == OP_APPKEY_ADD)
-			remote_add_app_key(src, app_idx, true);
+			saved = remote_add_app_key(src, app_idx, true);
 		else if (cmd->opcode == OP_APPKEY_DELETE)
-			remote_del_app_key(src, app_idx);
+			saved = remote_del_app_key(src, app_idx);
 		else if (cmd->opcode == OP_APPKEY_UPDATE)
-			remote_update_app_key(src, app_idx, true, true);
-
+			saved = remote_update_app_key(src, app_idx, true, true);
 		break;
 
 	case OP_APPKEY_LIST:
 		if (len < 3)
-			break;
+			return true;
 
 		bt_shell_printf("AppKey List (node %4.4x) Status %s\n",
 						src, mesh_status_str(data[0]));
@@ -478,16 +477,16 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		len -= 3;
 
 		if (data[0] != MESH_STATUS_SUCCESS)
-			break;
+			return true;
 
 		data += 3;
 		print_appkey_list(len, data);
 
-		break;
+		return true;
 
 	case OP_NETKEY_STATUS:
 		if (len != 3)
-			break;
+			return true;
 
 		bt_shell_printf("Node %4.4x NetKey status %s\n", src,
 						mesh_status_str(data[0]));
@@ -496,23 +495,23 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("\tNetKey %u (0x%3.3x)\n", net_idx, net_idx);
 
 		if (data[0] != MESH_STATUS_SUCCESS)
-			break;
+			return true;
 
 		if (!cmd)
-			break;
+			return true;
 
 		if (cmd->opcode == OP_NETKEY_ADD)
-			remote_add_net_key(src, net_idx, true);
+			saved = remote_add_net_key(src, net_idx, true);
 		else if (cmd->opcode == OP_NETKEY_DELETE)
-			remote_del_net_key(src, net_idx);
+			saved = remote_del_net_key(src, net_idx);
 		else if (cmd->opcode == OP_NETKEY_UPDATE)
-			remote_update_net_key(src, net_idx, true, true);
+			saved = remote_update_net_key(src, net_idx, true, true);
 
 		break;
 
 	case OP_NETKEY_LIST:
 		if (len < 2)
-			break;
+			return true;
 
 		bt_shell_printf("NetKey List (node %4.4x):\n", src);
 
@@ -530,11 +529,11 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 			bt_shell_printf("\t %u (0x%3.3x)\n", net_idx, net_idx);
 		}
 
-		break;
+		return true;
 
 	case OP_CONFIG_KEY_REFRESH_PHASE_STATUS:
 		if (len != 4)
-			break;
+			return true;
 
 		bt_shell_printf("Node %4.4x Key Refresh Phase status %s\n", src,
 						mesh_status_str(data[0]));
@@ -546,14 +545,16 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		if (data[0] != MESH_STATUS_SUCCESS)
 			return true;
 
-		if (data[3] == KEY_REFRESH_PHASE_NONE)
-			remote_finish_key_refresh(src, net_idx);
+		if (data[3] != KEY_REFRESH_PHASE_NONE)
+			return true;
+
+		saved = remote_finish_key_refresh(src, net_idx);
 
 		break;
 
 	case OP_MODEL_APP_STATUS:
 		if (len != 7 && len != 9)
-			break;
+			return true;
 
 		bt_shell_printf("Node %4.4x: Model App status %s\n", src,
 						mesh_status_str(data[0]));
@@ -567,14 +568,14 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("AppIdx\t\t%u (0x%3.3x)\n ", app_idx, app_idx);
 
 		if (data[0] != MESH_STATUS_SUCCESS || !cmd)
-			break;
+			return true;
 
 		if (cmd->opcode == OP_MODEL_APP_BIND)
-			mesh_db_node_model_bind(src, addr, len == 9, mod_id,
-								app_idx);
+			saved = mesh_db_node_model_bind(src, addr, len == 9,
+							mod_id, app_idx);
 		else
-			mesh_db_node_model_unbind(src, addr, len == 9, mod_id,
-								app_idx);
+			saved = mesh_db_node_model_unbind(src, addr, len == 9,
+							mod_id, app_idx);
 
 		break;
 
@@ -585,7 +586,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("NetIdx %4.4x, NodeIdState 0x%02x, status %s\n",
 				get_le16(data + 1), data[3],
 				mesh_status_str(data[0]));
-		break;
+		return true;
 
 	case OP_CONFIG_BEACON_STATUS:
 		if (len != 1)
@@ -616,7 +617,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 			return true;
 
 		bt_shell_printf("Node %4.4x Default TTL %d\n", src, data[0]);
-		mesh_db_node_ttl_set(src, data[0]);
+		saved = mesh_db_node_ttl_set(src, data[0]);
 
 		break;
 
@@ -670,15 +671,18 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		if (IS_VIRTUAL(pub.u.addr)) {
 			grp = l_queue_find(groups, match_group_addr,
 						L_UINT_TO_PTR(pub.u.addr));
-			if (!grp)
+			if (!grp) {
+				bt_shell_printf("Unknown virtual group\n");
 				return true;
+			}
 
 			memcpy(pub.u.label, grp->label, sizeof(pub.u.label));
 
 		}
 
-		mesh_db_node_model_set_pub(src, ele_addr, len == 14, mod_id,
-						&pub, IS_VIRTUAL(pub.u.addr));
+		saved = mesh_db_node_model_set_pub(src, ele_addr, len == 14,
+							mod_id, &pub,
+							IS_VIRTUAL(pub.u.addr));
 
 		break;
 
@@ -708,34 +712,36 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		default:
 			return true;
 		case OP_CONFIG_MODEL_SUB_ADD:
-			mesh_db_node_model_add_sub(src, ele_addr, len == 9,
-								mod_id, addr);
+			saved = mesh_db_node_model_add_sub(src, ele_addr,
+							len == 9, mod_id, addr);
 			break;
 		case OP_CONFIG_MODEL_SUB_DELETE:
-			mesh_db_node_model_del_sub(src, ele_addr, len == 9,
-								mod_id, addr);
+			saved = mesh_db_node_model_del_sub(src, ele_addr,
+							len == 9, mod_id, addr);
 			break;
 		case OP_CONFIG_MODEL_SUB_OVERWRITE:
-			mesh_db_node_model_overwrt_sub(src, ele_addr, len == 9,
-								mod_id, addr);
+			saved = mesh_db_node_model_overwrt_sub(src, ele_addr,
+							len == 9, mod_id, addr);
 			break;
 		case OP_CONFIG_MODEL_SUB_DELETE_ALL:
-			mesh_db_node_model_del_sub_all(src, ele_addr, len == 9,
-									mod_id);
+			saved = mesh_db_node_model_del_sub_all(src, ele_addr,
+							len == 9, mod_id);
 			break;
 		case OP_CONFIG_MODEL_SUB_VIRT_ADD:
 			if (grp)
-				mesh_db_node_model_add_sub_virt(src, ele_addr,
-						len == 9, mod_id, grp->label);
+				saved = mesh_db_node_model_add_sub_virt(src,
+							ele_addr, len == 9,
+							mod_id, grp->label);
 			break;
 		case OP_CONFIG_MODEL_SUB_VIRT_DELETE:
 			if (grp)
-				mesh_db_node_model_del_sub_virt(src, ele_addr,
-						len == 9, mod_id, grp->label);
+				saved = mesh_db_node_model_del_sub_virt(src,
+							ele_addr, len == 9,
+							mod_id, grp->label);
 			break;
 		case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
 			if (grp)
-				mesh_db_node_model_overwrt_sub_virt(src,
+				saved = mesh_db_node_model_overwrt_sub_virt(src,
 							ele_addr, len == 9,
 							mod_id, grp->label);
 			break;
@@ -749,14 +755,14 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 			return true;
 
 		print_sub_list(src, false, data, len);
-		break;
+		return true;
 
 	case OP_CONFIG_VEND_MODEL_SUB_LIST:
 		if (len < 7)
 			return true;
 
 		print_sub_list(src, true, data, len);
-		break;
+		return true;
 
 	/* Per Mesh Profile 4.3.2.50 */
 	case OP_MODEL_APP_LIST:
@@ -772,8 +778,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		data += 5;
 		len -= 5;
 		print_appkey_list(len, data);
-
-		break;
+		return true;
 
 	case OP_VEND_MODEL_APP_LIST:
 		if (len < 7)
@@ -791,8 +796,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		data += 7;
 		len -= 7;
 		print_appkey_list(len, data);
-
-		break;
+		return true;
 
 	/* Per Mesh Profile 4.3.2.63 */
 	case OP_CONFIG_HEARTBEAT_PUB_STATUS:
@@ -842,7 +846,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		bt_shell_printf("Node %4.4x is reset\n", src);
 		reset_remote_node(src);
 
-		break;
+		return true;
 
 	/* Per Mesh Profile 4.3.2.57 */
 	case OP_CONFIG_FRIEND_STATUS:
@@ -854,6 +858,9 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		break;
 	}
 
+	if (!saved)
+		bt_shell_printf("Warning: Configuration not updated\n");
+
 	return true;
 }
 
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 2f8493f8a..dd294fe4d 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -351,18 +351,19 @@ bool remote_update_app_key(uint16_t addr, uint16_t app_idx, bool update,
 		return true;
 }
 
-void remote_finish_key_refresh(uint16_t addr, uint16_t net_idx)
+bool remote_finish_key_refresh(uint16_t addr, uint16_t net_idx)
 {
 	struct remote_node *rmt;
 	struct remote_key *key;
 	const struct l_queue_entry *l;
+	bool res = true;
 
 	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
 	if (!rmt)
-		return;
+		return false;
 
 	if (!remote_update_net_key(addr, net_idx, false, true))
-		return;
+		return false;
 
 	l = l_queue_get_entries(rmt->app_keys);
 
@@ -374,9 +375,10 @@ void remote_finish_key_refresh(uint16_t addr, uint16_t net_idx)
 
 		key->updated = false;
 
-		mesh_db_node_app_key_update(addr, key->idx, false);
+		res &= mesh_db_node_app_key_update(addr, key->idx, false);
 	}
 
+	return res;
 }
 
 uint16_t remote_get_subnet_idx(uint16_t addr)
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index 2fb0d83ce..66457237e 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -24,7 +24,7 @@ bool remote_add_app_key(uint16_t addr, uint16_t app_idx, bool save);
 bool remote_del_app_key(uint16_t addr, uint16_t app_idx);
 bool remote_update_app_key(uint16_t addr, uint16_t app_idx, bool update,
 								bool save);
-void remote_finish_key_refresh(uint16_t addr, uint16_t net_idx);
+bool remote_finish_key_refresh(uint16_t addr, uint16_t net_idx);
 void remote_set_composition(uint16_t addr, bool comp);
 bool remote_has_composition(uint16_t addr);
 uint16_t remote_get_subnet_idx(uint16_t addr);
-- 
2.31.1

