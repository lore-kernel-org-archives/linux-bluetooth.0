Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8801FC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 06:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E90020818
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 06:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfBVGch (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:32:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:62023 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfBVGcg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Feb 2019 01:32:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 22:32:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,398,1544515200"; 
   d="scan'208";a="301674875"
Received: from ingas-nuc1.sea.intel.com ([10.251.136.115])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2019 22:32:28 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/3 v2] mesh: Cleanup storage save and remove procedures
Date:   Thu, 21 Feb 2019 22:31:47 -0800
Message-Id: <20190222063148.4995-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190222063148.4995-1-inga.stotland@intel.com>
References: <20190222063148.4995-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To remove a node config directory completely, the directory
needs to be empty. Both node.json and node,json.bak files must
are deleted.

Also, change storage_save_config() type to void to eliminate
meaningless checks.
---
 mesh/node.c    | 14 ++++++++++----
 mesh/node.h    |  1 +
 mesh/storage.c | 34 ++++++++++++++++++++++++----------
 mesh/storage.h |  2 +-
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 6c5cd9c39..6a7b4a260 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -392,8 +392,7 @@ static void cleanup_node(void *data)
 		/* Preserve the last sequence number */
 		storage_write_sequence_number(net, mesh_net_get_seq_num(net));
 
-		if (storage_save_config(node, true, NULL, NULL))
-			l_info("Saved final config to %s", node->cfg_file);
+		storage_save_config(node, true, NULL, NULL);
 	}
 
 	free_node_resources(node);
@@ -958,6 +957,14 @@ void node_id_set(struct mesh_node *node, uint16_t id)
 		node->id = id;
 }
 
+uint16_t node_id_get(struct mesh_node *node)
+{
+	if (!node)
+		return 0;
+
+	return node->id;
+}
+
 static void attach_io(void *a, void *b)
 {
 	struct mesh_node *node = a;
@@ -1757,8 +1764,7 @@ bool node_add_pending_local(struct mesh_node *node, void *prov_node_info,
 			return false;
 	}
 
-	if (!storage_save_config(node, true, NULL, NULL))
-		return false;
+	storage_save_config(node, true, NULL, NULL);
 
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
diff --git a/mesh/node.h b/mesh/node.h
index ee1d4a600..954dfca75 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -87,6 +87,7 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 						node_attach_ready_func_t cb);
 void node_build_attach_reply(struct l_dbus_message *reply, uint64_t token);
 void node_id_set(struct mesh_node *node, uint16_t node_id);
+uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
 void node_cleanup_all(void);
 void node_jconfig_set(struct mesh_node *node, void *jconfig);
diff --git a/mesh/storage.c b/mesh/storage.c
index e79037375..fe3102fba 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -341,14 +341,14 @@ bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 	bool result;
-	l_debug("");
+
 	result = mesh_db_write_int(jnode, "sequenceNumber", seq);
 	if (!result)
 		return false;
 
-	result = storage_save_config(node, false, NULL, NULL);
+	storage_save_config(node, false, NULL, NULL);
 
-	return result;
+	return true;
 }
 
 static bool save_config(json_object *jnode, const char *config_name)
@@ -408,15 +408,12 @@ static void idle_save_config(void *user_data)
 	l_free(info);
 }
 
-bool storage_save_config(struct mesh_node *node, bool no_wait,
+void storage_save_config(struct mesh_node *node, bool no_wait,
 					mesh_status_func_t cb, void *user_data)
 {
 	struct write_info *info;
 
 	info = l_new(struct write_info, 1);
-	if (!info)
-		return false;
-	l_debug("");
 	info->jnode = node_jconfig_get(node);
 	info->config_name = node_cfg_file_get(node);
 	info->cb = cb;
@@ -426,8 +423,6 @@ bool storage_save_config(struct mesh_node *node, bool no_wait,
 		idle_save_config(info);
 	else
 		l_idle_oneshot(idle_save_config, info, NULL);
-
-	return true;
 }
 
 static int create_dir(const char *dirname)
@@ -543,7 +538,7 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 
 	do {
 		l_getrandom(&node_id, 2);
-		if (!l_queue_find(node_ids, simple_match,
+		if (node_id && !l_queue_find(node_ids, simple_match,
 						L_UINT_TO_PTR(node_id)))
 			break;
 	} while (++num_tries < 10);
@@ -571,6 +566,8 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	node_jconfig_set(node, jnode);
 	node_cfg_file_set(node, filename);
 
+	l_queue_push_tail(node_ids, L_UINT_TO_PTR(node_id));
+
 	return true;
 fail:
 	json_object_put(jnode);
@@ -583,15 +580,20 @@ void storage_remove_node_config(struct mesh_node *node)
 	char *cfgname;
 	struct json_object *jnode;
 	const char *dir_name;
+	uint16_t node_id;
+	size_t len;
+	char *bak;
 
 	if (!node)
 		return;
 
+	/* Free the node config json object */
 	jnode = node_jconfig_get(node);
 	if (jnode)
 		json_object_put(jnode);
 	node_jconfig_set(node, NULL);
 
+	/* Delete node configuration file */
 	cfgname = (char *) node_cfg_file_get(node);
 	if (!cfgname)
 		return;
@@ -599,6 +601,15 @@ void storage_remove_node_config(struct mesh_node *node)
 	l_debug("Delete node config file %s", cfgname);
 	remove(cfgname);
 
+	/* Delete the backup file */
+	len = strlen(cfgname) + 5;
+	bak = l_malloc(len);
+	strncpy(bak, cfgname, len);
+	bak = strncat(bak, ".bak", 5);
+	remove(bak);
+	l_free(bak);
+
+	/* Delete the node directory */
 	dir_name = dirname(cfgname);
 
 	l_debug("Delete directory %s", dir_name);
@@ -606,4 +617,7 @@ void storage_remove_node_config(struct mesh_node *node)
 
 	l_free(cfgname);
 	node_cfg_file_set(node, NULL);
+
+	node_id = node_id_get(node);
+	l_queue_remove(node_ids, L_UINT_TO_PTR(node_id));
 }
diff --git a/mesh/storage.h b/mesh/storage.h
index 85f7899bc..8b14c8e8e 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -23,7 +23,7 @@ struct mesh_node;
 bool storage_load_nodes(const char *dir);
 bool storage_create_node_config(struct mesh_node *node, void *db_node);
 void storage_remove_node_config(struct mesh_node *node);
-bool storage_save_config(struct mesh_node *node, bool no_wait,
+void storage_save_config(struct mesh_node *node, bool no_wait,
 					mesh_status_func_t cb, void *user_data);
 bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx, bool unbind);
-- 
2.17.2

