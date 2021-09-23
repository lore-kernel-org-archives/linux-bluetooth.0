Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E54DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E792E61038
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhIWD2s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:16373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239042AbhIWD2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555910"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555910"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072356"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:55 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 08/20] tools/mesh-cfgclient: Store remote node's model subs
Date:   Wed, 22 Sep 2021 20:25:51 -0700
Message-Id: <20210923032603.50536-9-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update remote node's model subscriptions after a successful completion
of "sub-add", "sub-del", "sub-wrt" and "sub-del_all" commands.
---
 tools/mesh/cfgcli.c  |  68 +++++++++++++----
 tools/mesh/mesh-db.c | 178 +++++++++++++++++++++++++++++++++++++++++++
 tools/mesh/mesh-db.h |  17 +++++
 3 files changed, 250 insertions(+), 13 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index c3241a9b7..71bf2e706 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -387,14 +387,21 @@ static void print_appkey_list(uint16_t len, uint8_t *data)
 	}
 }
 
+static bool match_group_addr(const void *a, const void *b)
+{
+	const struct mesh_group *grp = a;
+	uint16_t addr = L_PTR_TO_UINT(b);
+
+	return grp->addr == addr;
+}
+
 static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 							uint16_t len)
 {
-	uint32_t opcode;
+	uint32_t opcode, mod_id;
 	const struct cfg_cmd *cmd;
-	uint16_t app_idx, net_idx, addr;
-	uint16_t ele_addr;
-	uint32_t mod_id;
+	uint16_t app_idx, net_idx, addr, ele_addr;
+	struct mesh_group *grp;
 	struct model_pub pub;
 	int n;
 	struct pending_req *req;
@@ -664,10 +671,53 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 		addr = get_le16(data + 3);
 		bt_shell_printf("Element Addr\t%4.4x\n", ele_addr);
 
-		print_mod_id(data + 5, len == 9, "");
+		mod_id = print_mod_id(data + 5, len == 9, "");
 
 		bt_shell_printf("Subscr Addr\t%4.4x\n", addr);
 
+		grp = l_queue_find(groups, match_group_addr,
+							L_UINT_TO_PTR(addr));
+
+		if (data[0] != MESH_STATUS_SUCCESS || !cmd)
+			return true;
+
+		switch (cmd->opcode) {
+		default:
+			return true;
+		case OP_CONFIG_MODEL_SUB_ADD:
+			mesh_db_node_model_add_sub(src, ele_addr, len == 9,
+								mod_id, addr);
+			break;
+		case OP_CONFIG_MODEL_SUB_DELETE:
+			mesh_db_node_model_del_sub(src, ele_addr, len == 9,
+								mod_id, addr);
+			break;
+		case OP_CONFIG_MODEL_SUB_OVERWRITE:
+			mesh_db_node_model_overwrt_sub(src, ele_addr, len == 9,
+								mod_id, addr);
+			break;
+		case OP_CONFIG_MODEL_SUB_DELETE_ALL:
+			mesh_db_node_model_del_sub_all(src, ele_addr, len == 9,
+									mod_id);
+			break;
+		case OP_CONFIG_MODEL_SUB_VIRT_ADD:
+			if (grp)
+				mesh_db_node_model_add_sub_virt(src, ele_addr,
+						len == 9, mod_id, grp->label);
+			break;
+		case OP_CONFIG_MODEL_SUB_VIRT_DELETE:
+			if (grp)
+				mesh_db_node_model_del_sub_virt(src, ele_addr,
+						len == 9, mod_id, grp->label);
+			break;
+		case OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE:
+			if (grp)
+				mesh_db_node_model_overwrt_sub_virt(src,
+							ele_addr, len == 9,
+							mod_id, grp->label);
+			break;
+		}
+
 		break;
 
 	/* Per Mesh Profile 4.3.2.27 */
@@ -820,14 +870,6 @@ static uint32_t read_input_parameters(int argc, char *argv[])
 	return i;
 }
 
-static bool match_group_addr(const void *a, const void *b)
-{
-	const struct mesh_group *grp = a;
-	uint16_t addr = L_PTR_TO_UINT(b);
-
-	return grp->addr == addr;
-}
-
 static int compare_group_addr(const void *a, const void *b, void *user_data)
 {
 	const struct mesh_group *grp0 = a;
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index da5817acf..1b03e2d90 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -814,6 +814,178 @@ bool mesh_db_node_model_unbind(uint16_t unicast, uint16_t ele_addr, bool vendor,
 						(int) app_idx, "bind", false);
 }
 
+static void jarray_string_del(json_object *jarray, const char *str, size_t len)
+{
+	int i, sz = json_object_array_length(jarray);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry;
+		char *str_entry;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		str_entry = (char *)json_object_get_string(jentry);
+
+		if (str_entry && (strlen(str_entry) == len) &&
+						!strncmp(str, str_entry, len)) {
+			json_object_array_del_idx(jarray, i, 1);
+			return;
+		}
+	}
+}
+
+static bool update_model_string_array(uint16_t unicast, uint16_t ele_addr,
+						bool vendor, uint32_t mod_id,
+						const char *str, uint32_t len,
+						const char *keyword, bool add)
+{
+	json_object *jarray, *jmod, *jstring;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jmod = get_model(unicast, ele_addr, mod_id, vendor);
+	if (!jmod)
+		return false;
+
+	if (!json_object_object_get_ex(jmod, keyword, &jarray))
+		return false;
+
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	jarray_string_del(jarray, str, len);
+
+	if (!add)
+		return true;
+
+	jstring = json_object_new_string(str);
+	if (!jstring)
+		return false;
+
+	json_object_array_add(jarray, jstring);
+
+	return save_config();
+}
+
+bool mesh_db_node_model_add_sub(uint16_t unicast, uint16_t ele, bool vendor,
+						uint32_t mod_id, uint16_t addr)
+{
+	char buf[5];
+
+	snprintf(buf, 5, "%4.4x", addr);
+
+	return update_model_string_array(unicast, ele, vendor, mod_id, buf, 4,
+							"subscribe", true);
+}
+
+bool mesh_db_node_model_del_sub(uint16_t unicast, uint16_t ele, bool vendor,
+						uint32_t mod_id, uint16_t addr)
+{
+	char buf[5];
+
+	snprintf(buf, 5, "%4.4x", addr);
+
+	return update_model_string_array(unicast, ele, vendor, mod_id, buf, 4,
+							"subscribe", false);
+}
+
+bool mesh_db_node_model_add_sub_virt(uint16_t unicast, uint16_t ele,
+						bool vendor, uint32_t mod_id,
+								uint8_t *label)
+{
+	char buf[33];
+
+	hex2str(label, 16, buf, sizeof(buf));
+
+	return update_model_string_array(unicast, ele, vendor, mod_id, buf, 32,
+							"subscribe", true);
+
+}
+
+bool mesh_db_node_model_del_sub_virt(uint16_t unicast, uint16_t ele,
+						bool vendor, uint32_t mod_id,
+								uint8_t *label)
+{
+	char buf[33];
+
+	hex2str(label, 16, buf, sizeof(buf));
+
+	return update_model_string_array(unicast, ele, vendor, mod_id, buf, 32,
+							"subscribe", false);
+}
+
+static json_object *delete_subs(uint16_t unicast, uint16_t ele, bool vendor,
+								uint32_t mod_id)
+{
+	json_object *jarray, *jmod;
+
+	if (!cfg || !cfg->jcfg)
+		return NULL;
+
+	jmod = get_model(unicast, ele, mod_id, vendor);
+	if (!jmod)
+		return NULL;
+
+	json_object_object_del(jmod, "subscribe");
+
+	jarray = json_object_new_array();
+	if (!jarray)
+		return NULL;
+
+	json_object_object_add(jmod, "subscribe", jarray);
+
+	return jarray;
+}
+
+bool mesh_db_node_model_del_sub_all(uint16_t unicast, uint16_t ele, bool vendor,
+								uint32_t mod_id)
+{
+
+	if (!delete_subs(unicast, ele, vendor, mod_id))
+		return false;
+
+	return save_config();
+}
+
+static bool sub_overwrite(uint16_t unicast, uint16_t ele, bool vendor,
+						uint32_t mod_id, char *buf)
+{
+	json_object *jarray, *jstring;
+
+	jarray = delete_subs(unicast, ele, vendor, mod_id);
+	if (!jarray)
+		return false;
+
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		return false;
+
+	json_object_array_add(jarray, jstring);
+
+	return save_config();
+}
+
+bool mesh_db_node_model_overwrt_sub(uint16_t unicast, uint16_t ele, bool vendor,
+						uint32_t mod_id, uint16_t addr)
+{
+	char buf[5];
+
+	snprintf(buf, 5, "%4.4x", addr);
+
+	return sub_overwrite(unicast, ele, vendor, mod_id, buf);
+}
+
+bool mesh_db_node_model_overwrt_sub_virt(uint16_t unicast, uint16_t ele,
+						bool vendor, uint32_t mod_id,
+								uint8_t *label)
+{
+	char buf[33];
+
+	hex2str(label, 16, buf, sizeof(buf));
+
+	return sub_overwrite(unicast, ele, vendor, mod_id, buf);
+}
+
 static void jarray_key_del(json_object *jarray, int16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
@@ -1340,6 +1512,9 @@ static json_object *init_model(uint16_t mod_id)
 	jarray = json_object_new_array();
 	json_object_object_add(jmod, "bind", jarray);
 
+	jarray = json_object_new_array();
+	json_object_object_add(jmod, "subscribe", jarray);
+
 	return jmod;
 }
 
@@ -1357,6 +1532,9 @@ static json_object *init_vendor_model(uint32_t mod_id)
 	jarray = json_object_new_array();
 	json_object_object_add(jmod, "bind", jarray);
 
+	jarray = json_object_new_array();
+	json_object_object_add(jmod, "subscribe", jarray);
+
 	return jmod;
 }
 
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index c3ee81457..384376cbd 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -48,6 +48,23 @@ bool mesh_db_node_model_bind(uint16_t unicast, uint16_t ele_addr, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
 bool mesh_db_node_model_unbind(uint16_t unicast, uint16_t ele_addr, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
+bool mesh_db_node_model_add_sub(uint16_t unicast, uint16_t ele, bool vendor,
+						uint32_t mod_id, uint16_t addr);
+bool mesh_db_node_model_del_sub(uint16_t unicast, uint16_t ele, bool vendor,
+						uint32_t mod_id, uint16_t addr);
+bool mesh_db_node_model_overwrt_sub(uint16_t unicast, uint16_t ele, bool vendor,
+						uint32_t mod_id, uint16_t addr);
+bool mesh_db_node_model_add_sub_virt(uint16_t unicast, uint16_t ele,
+						bool vendor, uint32_t mod_id,
+								uint8_t *label);
+bool mesh_db_node_model_del_sub_virt(uint16_t unicast, uint16_t ele,
+						bool vendor, uint32_t mod_id,
+								uint8_t *label);
+bool mesh_db_node_model_overwrt_sub_virt(uint16_t unicast, uint16_t ele,
+						bool vendor, uint32_t mod_id,
+								uint8_t *label);
+bool mesh_db_node_model_del_sub_all(uint16_t unicast, uint16_t ele, bool vendor,
+							uint32_t mod_id);
 struct l_queue *mesh_db_load_groups(void);
 bool mesh_db_add_group(struct mesh_group *grp);
 bool mesh_db_add_rejected_addr(uint16_t unicast, uint32_t iv_index);
-- 
2.31.1

