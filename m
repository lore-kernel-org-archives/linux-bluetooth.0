Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D55C35E0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1911821744
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 18:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbgBYSoW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:44:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:29706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbgBYSoW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 13:44:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 10:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,485,1574150400"; 
   d="scan'208";a="231546547"
Received: from ingas-nuc1.sea.intel.com ([10.254.39.252])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2020 10:44:21 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 3/6] tools/mesh-cfgclient: Save and restore group addresses
Date:   Tue, 25 Feb 2020 10:44:15 -0800
Message-Id: <20200225184418.12660-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225184418.12660-1-inga.stotland@intel.com>
References: <20200225184418.12660-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows to save created virtual labels and group addresses
in configuration file. The stored values can be restored upon
the tool start up.
---
 tools/mesh/cfgcli.c  |  11 ++--
 tools/mesh/cfgcli.h  |   5 ++
 tools/mesh/mesh-db.c | 128 +++++++++++++++++++++++++++++++++++++++++++
 tools/mesh/mesh-db.h |   4 ++
 4 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 0c9f69e36..5c990d2e8 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -60,11 +60,6 @@ struct pending_req {
 	uint16_t addr;
 };
 
-struct mesh_group {
-	uint16_t addr;
-	uint8_t label[16];
-};
-
 static struct l_queue *requests;
 static struct l_queue *groups;
 
@@ -818,6 +813,8 @@ static struct mesh_group *add_group(uint16_t addr)
 	grp->addr = addr;
 	l_queue_insert(groups, grp, compare_group_addr, NULL);
 
+	mesh_db_add_group(grp);
+
 	return grp;
 }
 
@@ -1685,6 +1682,7 @@ retry:
 	if (!tmp) {
 		l_queue_insert(groups, grp, compare_group_addr, NULL);
 		print_group(grp, NULL);
+		mesh_db_add_group(grp);
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
@@ -1829,8 +1827,7 @@ struct model_info *cfgcli_init(key_send_func_t key_send, void *user_data)
 	send_key_msg = key_send;
 	key_data = user_data;
 	requests = l_queue_new();
-	groups = l_queue_new();
-
+	groups = mesh_db_load_groups();
 	bt_shell_add_submenu(&cfg_menu);
 
 	return &cli_info;
diff --git a/tools/mesh/cfgcli.h b/tools/mesh/cfgcli.h
index 16d2e0a61..9b283d9d5 100644
--- a/tools/mesh/cfgcli.h
+++ b/tools/mesh/cfgcli.h
@@ -18,6 +18,11 @@
  *
  */
 
+struct mesh_group {
+	uint16_t addr;
+	uint8_t label[16];
+};
+
 typedef bool (*key_send_func_t) (void *user_data, uint16_t dst,
 				 uint16_t idx, bool is_appkey, bool update);
 
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 5dbb91440..41114f40f 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -41,6 +41,7 @@
 
 #include "tools/mesh/keys.h"
 #include "tools/mesh/remote.h"
+#include "tools/mesh/cfgcli.h"
 #include "tools/mesh/mesh-db.h"
 
 #define KEY_IDX_INVALID NET_IDX_INVALID
@@ -254,6 +255,20 @@ static uint16_t node_parse_key(json_object *jarray, int i)
 	return idx;
 }
 
+static int compare_group_addr(const void *a, const void *b, void *user_data)
+{
+	const struct mesh_group *grp0 = a;
+	const struct mesh_group *grp1 = b;
+
+	if (grp0->addr < grp1->addr)
+		return -1;
+
+	if (grp0->addr > grp1->addr)
+		return 1;
+
+	return 0;
+}
+
 static void load_remotes(json_object *jcfg)
 {
 	json_object *jnodes;
@@ -632,6 +647,112 @@ bool mesh_db_app_key_del(uint16_t app_idx)
 	return delete_key(cfg->jcfg, "appKeys", app_idx);
 }
 
+bool mesh_db_add_group(struct mesh_group *grp)
+{
+	json_object *jgroup, *jgroups, *jval;
+	char buf[16];
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	if (!json_object_object_get_ex(cfg->jcfg, "groups", &jgroups))
+		return false;
+
+	jgroup = json_object_new_object();
+	if (!jgroup)
+		return false;
+
+	snprintf(buf, 11, "Group_%4.4x", grp->addr);
+	jval = json_object_new_string(buf);
+	json_object_object_add(jgroup, "name", jval);
+
+	if (IS_VIRTUAL(grp->addr)) {
+		if (!add_u8_16(jgroup, grp->label, "address"))
+			goto fail;
+	} else {
+		snprintf(buf, 5, "%4.4x", grp->addr);
+		jval = json_object_new_string(buf);
+		if (!jval)
+			goto fail;
+		json_object_object_add(jgroup, "address", jval);
+	}
+
+	json_object_array_add(jgroups, jgroup);
+
+	return mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL);
+
+fail:
+	json_object_put(jgroup);
+	return false;
+}
+
+struct l_queue *mesh_db_load_groups(void)
+{
+	json_object *jgroups;
+	struct l_queue *groups;
+	int i, sz;
+
+	if (!cfg || !cfg->jcfg)
+		return NULL;
+
+	if (!json_object_object_get_ex(cfg->jcfg, "groups", &jgroups)) {
+		jgroups = json_object_new_array();
+		if (!jgroups)
+			return NULL;
+
+		json_object_object_add(cfg->jcfg, "groups", jgroups);
+	}
+
+	groups = l_queue_new();
+
+	sz = json_object_array_length(jgroups);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jgroup, *jval;
+		struct mesh_group *grp;
+		uint16_t addr, addr_len;
+		const char *str;
+
+		jgroup = json_object_array_get_idx(jgroups, i);
+		if (!jgroup)
+			continue;
+
+		if (!json_object_object_get_ex(jgroup, "name", &jval))
+			continue;
+
+		str = json_object_get_string(jval);
+		if (strlen(str) != 10)
+			continue;
+
+		if (sscanf(str + 6, "%04hx", &addr) != 1)
+			continue;
+
+		if (!json_object_object_get_ex(jgroup, "address", &jval))
+			continue;
+
+		str = json_object_get_string(jval);
+		addr_len = strlen(str);
+		if (addr_len != 4 && addr_len != 32)
+			continue;
+
+		if (addr_len == 32 && !IS_VIRTUAL(addr))
+			continue;
+
+		grp = l_new(struct mesh_group, 1);
+
+		if (addr_len == 4)
+			sscanf(str, "%04hx", &grp->addr);
+		else {
+			str2hex(str, 32, grp->label, 16);
+			grp->addr = addr;
+		}
+
+		l_queue_insert(groups, grp, compare_group_addr, NULL);
+	}
+
+	return groups;
+}
+
 bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 							uint16_t net_idx)
 {
@@ -802,6 +923,13 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 		goto fail;
 
 	json_object_object_add(jcfg, "appKeys", jarray);
+#if 0
+	jarray = json_object_new_array();
+	if (!jarray)
+		goto fail;
+
+	json_object_object_add(jcfg, "groups", jarray);
+#endif
 
 	if (!mesh_config_save((struct mesh_config *) cfg, true, NULL, NULL))
 		goto fail;
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 4a7b16ab4..80dc4ed53 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -19,6 +19,8 @@
 
 #include "mesh/mesh-config.h"
 
+struct mesh_group;
+
 bool mesh_db_create(const char *fname, const uint8_t token[8],
 							const char *name);
 bool mesh_db_load(const char *fname);
@@ -52,3 +54,5 @@ bool mesh_db_node_model_binding_add(uint16_t unicast, uint8_t ele, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
 bool mesh_db_node_model_binding_del(uint16_t unicast, uint8_t ele, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
+struct l_queue *mesh_db_load_groups(void);
+bool mesh_db_add_group(struct mesh_group *grp);
-- 
2.21.1

