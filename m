Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4ABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4327461038
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhIWD2s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:16377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239054AbhIWD2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555905"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555905"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072352"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:26:55 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 07/20] tools/mesh-cfgclient: Store remote node's model bindings
Date:   Wed, 22 Sep 2021 20:25:50 -0700
Message-Id: <20210923032603.50536-8-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update remote node's model binding after a successful completion
of "bind" or "unbind" commands.
---
 tools/mesh/cfgcli.c  |  14 +++-
 tools/mesh/mesh-db.c | 166 ++++++++++++++++++++++++++++++++++++++++++-
 tools/mesh/mesh-db.h |   4 +-
 3 files changed, 178 insertions(+), 6 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 485d13b5a..c3241a9b7 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -340,7 +340,7 @@ static void print_pub(uint16_t ele_addr, uint32_t mod_id,
 		bt_shell_printf("\tModel: %8.8x\n", mod_id);
 	else
 		bt_shell_printf("\tModel: %4.4x\n",
-				(uint16_t) (mod_id & 0xffff));
+					(uint16_t) (mod_id & ~VENDOR_ID_MASK));
 
 	bt_shell_printf("\tApp Key Idx: %u (0x%3.3x)\n", pub->app_idx,
 								pub->app_idx);
@@ -552,10 +552,20 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		bt_shell_printf("Element Addr\t%4.4x\n", addr);
 
-		print_mod_id(data + 5, len == 9, "");
+		mod_id = print_mod_id(data + 5, len == 9, "");
 
 		bt_shell_printf("AppIdx\t\t%u (0x%3.3x)\n ", app_idx, app_idx);
 
+		if (data[0] != MESH_STATUS_SUCCESS || !cmd)
+			break;
+
+		if (cmd->opcode == OP_MODEL_APP_BIND)
+			mesh_db_node_model_bind(src, addr, len == 9, mod_id,
+								app_idx);
+		else
+			mesh_db_node_model_unbind(src, addr, len == 9, mod_id,
+								app_idx);
+
 		break;
 
 	case OP_NODE_IDENTITY_STATUS:
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index f0e0aeb71..da5817acf 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -658,6 +658,162 @@ bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl)
 	return save_config();
 }
 
+static json_object *get_element(uint16_t unicast, uint16_t ele_addr)
+{
+	json_object *jnode, *jarray;
+	int i, ele_cnt;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	if (!json_object_object_get_ex(jnode, "elements", &jarray))
+		return NULL;
+
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return NULL;
+
+	ele_cnt = json_object_array_length(jarray);
+
+	for (i = 0; i < ele_cnt; ++i) {
+		json_object *jentry, *jval;
+		int32_t index;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		if (!json_object_object_get_ex(jentry, "index", &jval))
+			return NULL;
+
+		index = json_object_get_int(jval);
+		if (index > 0xff)
+			return NULL;
+
+		if (ele_addr == unicast + index)
+			return jentry;
+	}
+
+	return NULL;
+}
+
+static json_object *get_model(uint16_t unicast, uint16_t ele_addr,
+						uint32_t mod_id, bool vendor)
+{
+	json_object *jelement, *jarray;
+	int i, sz;
+
+	jelement = get_element(unicast, ele_addr);
+	if (!jelement)
+		return false;
+
+	if (!json_object_object_get_ex(jelement, "models", &jarray))
+		return NULL;
+
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return NULL;
+
+	if (!vendor)
+		mod_id = mod_id & ~VENDOR_ID_MASK;
+
+	sz = json_object_array_length(jarray);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry, *jval;
+		uint32_t id, len;
+		const char *str;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		if (!json_object_object_get_ex(jentry, "modelId",
+								&jval))
+			return NULL;
+
+		str = json_object_get_string(jval);
+		len = strlen(str);
+		if (len != 4 && len != 8)
+			return NULL;
+
+		if ((len == 4 && vendor) || (len == 8 && !vendor))
+			continue;
+
+		if (sscanf(str, "%08x", &id) != 1)
+			return NULL;
+
+		if (id == mod_id)
+			return jentry;
+	}
+
+	return NULL;
+}
+
+static void jarray_int_del(json_object *jarray, int val)
+{
+	int i, sz = json_object_array_length(jarray);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry;
+
+		jentry = json_object_array_get_idx(jarray, i);
+
+		if (val == json_object_get_int(jentry)) {
+			json_object_array_del_idx(jarray, i, 1);
+			return;
+		}
+	}
+}
+
+static bool update_model_int_array(uint16_t unicast, uint16_t ele_addr,
+					bool vendor, uint32_t mod_id,
+					int val, const char *keyword, bool add)
+{
+	json_object *jarray, *jmod, *jvalue;
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
+	jarray_int_del(jarray, val);
+
+	if (!add)
+		return true;
+
+	jvalue = json_object_new_int(val);
+	if (!jvalue)
+		return false;
+
+	json_object_array_add(jarray, jvalue);
+
+	return save_config();
+}
+
+bool mesh_db_node_model_bind(uint16_t unicast, uint16_t ele_addr, bool vendor,
+					uint32_t mod_id, uint16_t app_idx)
+{
+	char buf[5];
+
+	snprintf(buf, 5, "%4.4x", app_idx);
+
+	return update_model_int_array(unicast, ele_addr, vendor, mod_id,
+						(int) app_idx, "bind", true);
+}
+
+bool mesh_db_node_model_unbind(uint16_t unicast, uint16_t ele_addr, bool vendor,
+					uint32_t mod_id, uint16_t app_idx)
+{
+	char buf[5];
+
+	snprintf(buf, 5, "%4.4x", app_idx);
+
+	return update_model_int_array(unicast, ele_addr, vendor, mod_id,
+						(int) app_idx, "bind", false);
+}
+
 static void jarray_key_del(json_object *jarray, int16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
@@ -1172,7 +1328,7 @@ bool mesh_db_del_node(uint16_t unicast)
 
 static json_object *init_model(uint16_t mod_id)
 {
-	json_object *jmod;
+	json_object *jmod, *jarray;
 
 	jmod = json_object_new_object();
 
@@ -1181,12 +1337,15 @@ static json_object *init_model(uint16_t mod_id)
 		return NULL;
 	}
 
+	jarray = json_object_new_array();
+	json_object_object_add(jmod, "bind", jarray);
+
 	return jmod;
 }
 
 static json_object *init_vendor_model(uint32_t mod_id)
 {
-	json_object *jmod;
+	json_object *jmod, *jarray;
 
 	jmod = json_object_new_object();
 
@@ -1195,6 +1354,9 @@ static json_object *init_vendor_model(uint32_t mod_id)
 		return NULL;
 	}
 
+	jarray = json_object_new_array();
+	json_object_object_add(jmod, "bind", jarray);
+
 	return jmod;
 }
 
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index c1bcb3ae6..c3ee81457 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -44,9 +44,9 @@ bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx);
 bool mesh_db_node_app_key_update(uint16_t unicast, uint16_t idx, bool updated);
 bool mesh_db_node_ttl_set(uint16_t unicast, uint8_t ttl);
 bool mesh_db_node_write_mode(uint16_t unicast, const char *keyword, int value);
-bool mesh_db_node_model_binding_add(uint16_t unicast, uint8_t ele, bool vendor,
+bool mesh_db_node_model_bind(uint16_t unicast, uint16_t ele_addr, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
-bool mesh_db_node_model_binding_del(uint16_t unicast, uint8_t ele, bool vendor,
+bool mesh_db_node_model_unbind(uint16_t unicast, uint16_t ele_addr, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
 struct l_queue *mesh_db_load_groups(void);
 bool mesh_db_add_group(struct mesh_group *grp);
-- 
2.31.1

