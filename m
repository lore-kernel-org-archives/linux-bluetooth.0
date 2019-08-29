Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1847C3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 20:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96042189D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 20:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH2UWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:22:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:7849 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfH2UWz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 16:22:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 13:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="356567086"
Received: from ingas-nuc1.sea.intel.com ([10.254.179.141])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2019 13:22:54 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add closedir() of config directory after opendir()
Date:   Thu, 29 Aug 2019 13:22:45 -0700
Message-Id: <20190829202245.11308-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds missing closedir() call to accompany opendir() in
mesh_config_load_nodes().
Also, fixes confusing mix of variable names.
---
 mesh/mesh-config-json.c | 46 +++++++++++++++++++++++------------------
 mesh/mesh-config.h      |  4 ++--
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 036ec9017..cafa2fdd7 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -61,7 +61,7 @@ struct write_info {
 	mesh_config_status_func_t cb;
 };
 
-static const char *cfg_name = "/node.json";
+static const char *cfgnode_name = "/node.json";
 static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 
@@ -1723,18 +1723,18 @@ static struct mesh_config *create_config(const char *cfg_path,
 	return cfg;
 }
 
-struct mesh_config *mesh_config_create(const char *cfg_dir,
+struct mesh_config *mesh_config_create(const char *cfgdir_name,
 		const uint8_t uuid[16], struct mesh_config_node *db_node)
 {
 	char uuid_buf[33];
 	char name_buf[PATH_MAX];
 	struct mesh_config *cfg;
-	size_t max_len = strlen(cfg_name) + strlen(bak_ext);
+	size_t max_len = strlen(cfgnode_name) + strlen(bak_ext);
 
 	if (!hex2str((uint8_t *) uuid, 16, uuid_buf, sizeof(uuid_buf)))
 		return NULL;
 
-	snprintf(name_buf, PATH_MAX, "%s/%s", cfg_dir, uuid_buf);
+	snprintf(name_buf, PATH_MAX, "%s/%s", cfgdir_name, uuid_buf);
 
 	if (strlen(name_buf) + max_len >= PATH_MAX)
 		return NULL;
@@ -1743,8 +1743,8 @@ struct mesh_config *mesh_config_create(const char *cfg_dir,
 	if (mkdir(name_buf, 0755) != 0)
 		return NULL;
 
-	snprintf(name_buf, PATH_MAX, "%s/%s%s", cfg_dir, uuid_buf,
-								cfg_name);
+	snprintf(name_buf, PATH_MAX, "%s/%s%s", cfgdir_name, uuid_buf,
+								cfgnode_name);
 	l_debug("New node config %s", name_buf);
 
 	cfg = create_config(name_buf, uuid, db_node);
@@ -2042,7 +2042,7 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 
 	if (!cache) {
 		if (!write_int(cfg->jnode, "sequenceNumber", seq))
-		    return false;
+			return false;
 
 		return mesh_config_save(cfg, true, NULL, NULL);
 	}
@@ -2238,23 +2238,24 @@ bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
 	return true;
 }
 
-bool mesh_config_load_nodes(const char *cfg_dir, mesh_config_node_func_t cb,
-							void *user_data)
+bool mesh_config_load_nodes(const char *cfgdir_name, mesh_config_node_func_t cb,
+								void *user_data)
 {
-	DIR *dir;
+	DIR *cfgdir;
 	struct dirent *entry;
-	size_t path_len = strlen(cfg_dir) + strlen(cfg_name) + strlen(bak_ext);
+	size_t path_len = strlen(cfgdir_name) + strlen(cfgnode_name) +
+								strlen(bak_ext);
 
-	create_dir(cfg_dir);
-	dir = opendir(cfg_dir);
-	if (!dir) {
+	create_dir(cfgdir_name);
+	cfgdir = opendir(cfgdir_name);
+	if (!cfgdir) {
 		l_error("Failed to open mesh node storage directory: %s",
-								cfg_dir);
+								cfgdir_name);
 		return false;
 	}
 
-	while ((entry = readdir(dir)) != NULL) {
-		char *dir, *fname, *bak;
+	while ((entry = readdir(cfgdir)) != NULL) {
+		char *dirname, *fname, *bak;
 		uint8_t uuid[16];
 		size_t node_len;
 
@@ -2263,14 +2264,15 @@ bool mesh_config_load_nodes(const char *cfg_dir, mesh_config_node_func_t cb,
 
 		/* Check path length */
 		node_len = strlen(entry->d_name);
+
 		if (path_len + node_len + 1 >= PATH_MAX)
 			continue;
 
 		if (!str2hex(entry->d_name, node_len, uuid, sizeof(uuid)))
 			continue;
 
-		dir = l_strdup_printf("%s/%s", cfg_dir, entry->d_name);
-		fname = l_strdup_printf("%s%s", dir, cfg_name);
+		dirname = l_strdup_printf("%s/%s", cfgdir_name, entry->d_name);
+		fname = l_strdup_printf("%s%s", dirname, cfgnode_name);
 
 		if (!load_node(fname, uuid, cb, user_data)) {
 
@@ -2281,12 +2283,16 @@ bool mesh_config_load_nodes(const char *cfg_dir, mesh_config_node_func_t cb,
 				remove(fname);
 				rename(bak, fname);
 			}
+
 			l_free(bak);
 		}
+
 		l_free(fname);
-		l_free(dir);
+		l_free(dirname);
 	}
 
+	closedir(cfgdir);
+
 	return true;
 }
 
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 4172e794b..cf1f8b299 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -110,13 +110,13 @@ typedef bool (*mesh_config_node_func_t)(struct mesh_config_node *node,
 							struct mesh_config *cfg,
 							void *user_data);
 
-bool mesh_config_load_nodes(const char *cfg_dir, mesh_config_node_func_t cb,
+bool mesh_config_load_nodes(const char *cfgdir_name, mesh_config_node_func_t cb,
 							void *user_data);
 void mesh_config_release(struct mesh_config *cfg);
 void mesh_config_destroy(struct mesh_config *cfg);
 bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
 				mesh_config_status_func_t cb, void *user_data);
-struct mesh_config *mesh_config_create(const char *cfg_path,
+struct mesh_config *mesh_config_create(const char *cfgdir_name,
 						const uint8_t uuid[16],
 						struct mesh_config_node *node);
 
-- 
2.21.0

