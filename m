Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC32C73C6E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A0E20838
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfGJFKK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:28143 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfGJFKJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050350"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:08 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 8/9] mesh: Switch to using mesh-config routines for storage
Date:   Tue,  9 Jul 2019 22:09:58 -0700
Message-Id: <20190710050959.7321-9-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710050959.7321-1-inga.stotland@intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes the assumptions of the layout of the node configuration
directory from storage.c to allow read/write of persistent node
configuration to be format agnostic.
---
 mesh/mesh.c    |  11 ++-
 mesh/storage.c | 229 +++++++++++++++++--------------------------------
 2 files changed, 87 insertions(+), 153 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 26acfd4dc..bdd79e6bb 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -22,6 +22,8 @@
 #endif
 
 #define _GNU_SOURCE
+#include <dirent.h>
+
 #include <ell/ell.h>
 
 #include "mesh/mesh-io.h"
@@ -143,6 +145,12 @@ bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts)
 	if (mesh.io)
 		return true;
 
+	if (!config_dir)
+		config_dir = MESH_STORAGEDIR;
+
+	if (strlen(config_dir) >= PATH_MAX)
+		return false;
+
 	mesh_model_init();
 	mesh_agent_init();
 
@@ -150,9 +158,6 @@ bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts)
 	mesh.prov_timeout = DEFAULT_PROV_TIMEOUT;
 	mesh.algorithms = DEFAULT_ALGORITHMS;
 
-	if (!config_dir)
-		config_dir = MESH_STORAGEDIR;
-
 	l_info("Loading node configuration from %s", config_dir);
 
 	if (!storage_load_nodes(config_dir))
diff --git a/mesh/storage.c b/mesh/storage.c
index e87b58c59..721b65904 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -47,9 +47,6 @@ struct write_info {
 	mesh_status_func_t cb;
 };
 
-static const char *cfg_name = "/node.json";
-static const char *bak_ext = ".bak";
-static const char *tmp_ext = ".tmp";
 static const char *storage_dir;
 
 static bool read_node_cb(struct mesh_config_node *db_node, void *user_data)
@@ -123,61 +120,21 @@ static bool parse_node(struct mesh_node *node, json_object *jnode)
 	return true;
 }
 
-static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
+static struct mesh_node *parse_config(void *node_cfg,  const uint8_t uuid[16])
 {
-	int fd;
-	char *str;
-	struct stat st;
-	ssize_t sz;
-	json_object *jnode = NULL;
 	bool result = false;
 	struct mesh_node *node;
 
-	l_info("Loading configuration from %s", in_file);
-
-	fd = open(in_file, O_RDONLY);
-	if (fd < 0)
-		return false;
-
-	if (fstat(fd, &st) == -1) {
-		close(fd);
-		return false;
-	}
-
-	str = (char *) l_new(char, st.st_size + 1);
-	if (!str) {
-		close(fd);
-		return false;
-	}
-
-	sz = read(fd, str, st.st_size);
-	if (sz != st.st_size) {
-		l_error("Failed to read configuration file %s", in_file);
-		goto done;
-	}
-
-	jnode = json_tokener_parse(str);
-	if (!jnode)
-		goto done;
-
 	node = node_new(uuid);
 
-	result = parse_node(node, jnode);
+	result = parse_node(node, node_cfg);
 
 	if (!result) {
-		json_object_put(jnode);
 		node_remove(node);
+		return NULL;
 	}
 
-	node_config_set(node, jnode);
-	node_path_set(node, out_dir);
-
-done:
-	close(fd);
-	if (str)
-		l_free(str);
-
-	return result;
+	return node;
 }
 
 bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
@@ -360,54 +317,13 @@ bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 	return true;
 }
 
-static bool save_config(json_object *jnode, const char *config_name)
-{
-	FILE *outfile;
-	const char *str;
-	bool result = false;
-
-	outfile = fopen(config_name, "w");
-	if (!outfile) {
-		l_error("Failed to save configuration to %s", config_name);
-		return false;
-	}
-
-	str = json_object_to_json_string_ext(jnode, JSON_C_TO_STRING_PRETTY);
-
-	if (fwrite(str, sizeof(char), strlen(str), outfile) < strlen(str))
-		l_warn("Incomplete write of mesh configuration");
-	else
-		result = true;
-
-	fclose(outfile);
-
-	return result;
-}
-
 static void idle_save_config(void *user_data)
 {
 	struct write_info *info = user_data;
-	char *tmp, *bak, *cfg;
-	bool result = false;
-
-	cfg = l_strdup_printf("%s%s", info->node_path, cfg_name);
-	tmp = l_strdup_printf("%s%s", cfg, tmp_ext);
-	bak = l_strdup_printf("%s%s", cfg, bak_ext);
-	remove(tmp);
+	bool result;
 
 	l_debug("Storage-Wrote");
-	result = save_config(info->jnode, tmp);
-
-	if (result) {
-		remove(bak);
-		rename(cfg, bak);
-		rename(tmp, cfg);
-	}
-
-	remove(tmp);
-	l_free(tmp);
-	l_free(bak);
-	l_free(cfg);
+	result = mesh_config_save_config(info->node_path, info->jnode);
 
 	if (info->cb)
 		info->cb(info->user_data, result);
@@ -472,7 +388,7 @@ bool storage_load_nodes(const char *dir_name)
 {
 	DIR *dir;
 	struct dirent *entry;
-	size_t path_len = strlen(dir_name) + strlen(cfg_name) + strlen(bak_ext);
+	size_t path_len = strlen(dir_name);
 
 	create_dir(dir_name);
 	dir = opendir(dir_name);
@@ -485,84 +401,53 @@ bool storage_load_nodes(const char *dir_name)
 	storage_dir = dir_name;
 
 	while ((entry = readdir(dir)) != NULL) {
-		char *dir, *cfg, *bak;
+		char *dir;
+		void *config;
 		uint8_t uuid[16];
-		size_t node_len;
+		size_t subdir_len;
+		struct mesh_node *node;
 
 		if (entry->d_type != DT_DIR)
 			continue;
 
 		/* Check path length */
-		node_len = strlen(entry->d_name);
-		if (path_len + node_len + 1 >= PATH_MAX)
+		subdir_len = strlen(entry->d_name);
+		if (path_len + subdir_len + 1 >= PATH_MAX)
 			continue;
 
-		if (!str2hex(entry->d_name, node_len, uuid, sizeof(uuid)))
+		if (!str2hex(entry->d_name, subdir_len, uuid, sizeof(uuid)))
 			continue;
 
 		dir = l_strdup_printf("%s/%s", dir_name, entry->d_name);
-		cfg = l_strdup_printf("%s%s", dir, cfg_name);
-
-		if (!parse_config(cfg, dir, uuid)) {
-
-			/* Fall-back to Backup version */
-			bak = l_strdup_printf("%s%s", cfg, bak_ext);
-
-			if (parse_config(bak, dir, uuid)) {
-				remove(cfg);
-				rename(bak, cfg);
-			}
-			l_free(bak);
-		}
-		l_free(cfg);
-		l_free(dir);
-	}
-
-	return true;
-}
-
-bool storage_create_node_config(struct mesh_node *node, void *data)
-{
-	struct mesh_config_node *db_node = data;
-	char uuid[33];
-	char name_buf[PATH_MAX];
-	json_object *jnode;
-	size_t max_len = strlen(cfg_name) + strlen(bak_ext);
-
-	if (!storage_dir)
-		return false;
-
-	jnode = json_object_new_object();
-
-	if (!mesh_config_add_node(jnode, db_node))
-		return false;
-
-	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
-		goto fail;
+		config = mesh_config_get_config(dir);
+		if (!config)
+			continue;
 
-	snprintf(name_buf, PATH_MAX, "%s/%s", storage_dir, uuid);
+		node = parse_config(config, uuid);
 
-	if (strlen(name_buf) + max_len >= PATH_MAX)
-		goto fail;
+		if (!node) {
+			mesh_config_release_config(config);
 
-	/* Create a new directory and node.json file */
-	if (mkdir(name_buf, 0755) != 0)
-		goto fail;
+			/* Fall-back to Backup version */
+			config = mesh_config_get_config_backup(dir);
 
-	node_path_set(node, name_buf);
+			node = parse_config(config, uuid);
 
-	snprintf(name_buf, PATH_MAX, "%s/%s%s", storage_dir, uuid, cfg_name);
-	l_debug("New node config %s", name_buf);
+			if (node)
+				mesh_config_restore_backup(dir);
+			else
+				mesh_config_release_config(config);
+		}
 
-	if (!save_config(jnode, name_buf))
-		goto fail;
+		if (node) {
+			node_path_set(node, dir);
+			node_config_set(node, config);
+		}
 
-	node_config_set(node, jnode);
+		l_free(dir);
+	}
 
 	return true;
-fail:
-	json_object_put(jnode);
-	return false;
 }
 
 static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
@@ -596,7 +481,7 @@ void storage_remove_node_config(struct mesh_node *node)
 	/* Free the node config json object */
 	jnode = node_config_get(node);
 	if (jnode)
-		json_object_put(jnode);
+		mesh_config_release_config(jnode);
 
 	node_config_set(node, NULL);
 
@@ -614,3 +499,47 @@ void storage_remove_node_config(struct mesh_node *node)
 
 	nftw(node_path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
 }
+
+bool storage_create_node_config(struct mesh_node *node, void *data)
+{
+	struct mesh_config_node *db_node = data;
+	char uuid[33];
+	char node_dir[PATH_MAX];
+	json_object *jnode;
+
+	if (!storage_dir)
+		return false;
+
+	jnode = mesh_config_create_config();
+
+	if (!jnode || !mesh_config_add_node(jnode, db_node))
+		return false;
+
+	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
+		goto fail;
+
+	snprintf(node_dir, PATH_MAX, "%s/%s", storage_dir, uuid);
+
+	if (strlen(node_dir) >= PATH_MAX)
+		goto fail;
+
+	/* Create a new node config directory */
+	if (mkdir(node_dir, 0755) != 0)
+		goto fail;
+
+	if (!mesh_config_save_config(node_dir, jnode)) {
+		nftw(node_dir, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
+		goto fail;
+	}
+
+	l_debug("New node config %s", node_dir);
+	node_path_set(node, node_dir);
+	node_config_set(node, jnode);
+
+	return true;
+fail:
+	mesh_config_release_config(jnode);
+	node_config_set(node, NULL);
+
+	return false;
+}
-- 
2.21.0

