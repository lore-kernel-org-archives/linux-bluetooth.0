Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510BAC4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 05:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B8620C01
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 05:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfBTFx0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:53:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:18898 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfBTFx0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 00:53:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 21:53:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="144929339"
Received: from ingas-nuc1.sea.intel.com ([10.251.128.60])
  by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2019 21:53:25 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/3] mesh: Cleanup storage save and remove procedures
Date:   Tue, 19 Feb 2019 21:53:19 -0800
Message-Id: <20190220055320.2333-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190220055320.2333-1-inga.stotland@intel.com>
References: <20190220055320.2333-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To remove a node config directory completely, the directory
needs to be empty. Both node.json and node,json.bak files must
are deleted.

Also, change storage_save_config() type to void to avoid
meaningless checks.
---
 mesh/node.c    |  6 ++----
 mesh/storage.c | 26 +++++++++++++++++---------
 mesh/storage.h |  2 +-
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 6c5cd9c39..c3131dce4 100644
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
@@ -1757,8 +1756,7 @@ bool node_add_pending_local(struct mesh_node *node, void *prov_node_info,
 			return false;
 	}
 
-	if (!storage_save_config(node, true, NULL, NULL))
-		return false;
+	storage_save_config(node, true, NULL, NULL);
 
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
diff --git a/mesh/storage.c b/mesh/storage.c
index e79037375..ce1f8f93d 100644
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
@@ -583,15 +578,19 @@ void storage_remove_node_config(struct mesh_node *node)
 	char *cfgname;
 	struct json_object *jnode;
 	const char *dir_name;
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
@@ -599,6 +598,15 @@ void storage_remove_node_config(struct mesh_node *node)
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

