Return-Path: <SRS0=Q31N=TJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FF9C04AB1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 17:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E12A2085A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 17:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEIR6L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 May 2019 13:58:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:23990 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfEIR6L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 May 2019 13:58:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 10:58:11 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.251.10.18])
  by fmsmga004.fm.intel.com with ESMTP; 09 May 2019 10:58:10 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v5 1/2] mesh: Reconfigure node storage tree
Date:   Thu,  9 May 2019 10:57:38 -0700
Message-Id: <20190509175739.16891-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190509175739.16891-1-brian.gix@intel.com>
References: <20190509175739.16891-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a tree structure to a nodes data storage, in order to safely handle
Replay Protection list, Refactor local Sequence Numbers, and add Key
storage for Config Client nodes.
---
 mesh/README    |  34 +++++++++++++-
 mesh/node.c    |  16 ++++---
 mesh/node.h    |   4 +-
 mesh/storage.c | 144 ++++++++++++++++++++++++++++++++++-----------------------
 4 files changed, 131 insertions(+), 67 deletions(-)

diff --git a/mesh/README b/mesh/README
index ca223a6d8..82fd5a017 100644
--- a/mesh/README
+++ b/mesh/README
@@ -36,8 +36,40 @@ Each subdirectory contains the following files:
 		provisioner/configuration client
 	- node.json.bak:
 		a backup that the last known good node configuration.
+	- seq_num:
+		File containing next sequence number to use
+	- seq_num.bak:
+		Backup of the sequence number. This may be larger than the
+		actual sequence number being used at runtime, to prevent re-use
+		of sequence numbers in the event of an unexpected restart.
+	- ./rpl/:
+		Directory to store the sequence numbers of remote nodes, as
+		required by Replay Protection List (RPL) parameters.
+		- xxxx:
+			Files named for remote Unicast addresses, and contain
+			last received iv_index + seq_num from each SRC address.
+	- ./dev_keys/:
+		Directory to store remote Device keys. This is only created/used
+		by Configuration Client (Network administration) nodes.
+		- xxxx:
+			Files named for remote Unicast addresses, and contains
+			16 octet key.
+	- ./net_keys/:
+		Directory to store network subnet keys. This is only
+		created/used by Configuration Client (Network administration)
+		nodes.
+		- xxx:
+			Files named for subnet index, and contains key refresh
+			phase, and old/new versions of the key.
+	- ./app_keys/:
+		Directory to store application keys. This is only created/used
+		by Configuration Client (Network administration) nodes.
+		- xxx:
+			Files named for application index, and contains bound
+			subnet index, and old/new versions of the key.
 
-The files are in JSON format.
+The node.json and node.json.bak are in JSON format. All other files are stored
+in little endian binary format.
 
 Information
 ===========
diff --git a/mesh/node.c b/mesh/node.c
index 5904b116c..6f95c8d1c 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -79,7 +79,7 @@ struct mesh_node {
 	char *owner;
 	char *path;
 	void *jconfig;
-	char *cfg_file;
+	char *node_path;
 	uint32_t disc_watch;
 	time_t upd_sec;
 	uint32_t seq_number;
@@ -236,6 +236,7 @@ static void free_node_resources(void *data)
 	l_free(node->comp);
 	l_free(node->app_path);
 	l_free(node->owner);
+	l_free(node->node_path);
 
 	if (node->disc_watch)
 		l_dbus_remove_watch(dbus_get_bus(), node->disc_watch);
@@ -259,7 +260,7 @@ void node_remove(struct mesh_node *node)
 
 	l_queue_remove(nodes, node);
 
-	if (node->cfg_file)
+	if (node->node_path)
 		storage_remove_node_config(node);
 
 	free_node_resources(node);
@@ -395,7 +396,7 @@ static void cleanup_node(void *data)
 	struct mesh_net *net = node->net;
 
 	/* Save local node configuration */
-	if (node->cfg_file) {
+	if (node->node_path) {
 
 		/* Preserve the last sequence number */
 		storage_write_sequence_number(net, mesh_net_get_seq_num(net));
@@ -1859,14 +1860,15 @@ void *node_jconfig_get(struct mesh_node *node)
 	return node->jconfig;
 }
 
-void node_cfg_file_set(struct mesh_node *node, char *cfg)
+void node_path_set(struct mesh_node *node, char *path)
 {
-	node->cfg_file = cfg;
+	l_free(node->node_path);
+	node->node_path = l_strdup(path);
 }
 
-char *node_cfg_file_get(struct mesh_node *node)
+char *node_path_get(struct mesh_node *node)
 {
-	return node->cfg_file;
+	return node->node_path;
 }
 
 struct mesh_net *node_get_net(struct mesh_node *node)
diff --git a/mesh/node.h b/mesh/node.h
index 1be4de1da..1194ff837 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -95,5 +95,5 @@ bool node_dbus_init(struct l_dbus *bus);
 void node_cleanup_all(void);
 void node_jconfig_set(struct mesh_node *node, void *jconfig);
 void *node_jconfig_get(struct mesh_node *node);
-void node_cfg_file_set(struct mesh_node *node, char *cfg);
-char *node_cfg_file_get(struct mesh_node *node);
+void node_path_set(struct mesh_node *node, char *path);
+char *node_path_get(struct mesh_node *node);
diff --git a/mesh/storage.c b/mesh/storage.c
index 2580cbe7f..f4e23bf49 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <dirent.h>
 #include <libgen.h>
+#include <ftw.h>
 
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -49,13 +50,30 @@
 
 struct write_info {
 	json_object *jnode;
-	const char *config_name;
+	const char *node_path;
 	void *user_data;
 	mesh_status_func_t cb;
 };
 
+static const char *cfg_name = "/node.json";
+static const char *bak_ext = ".bak";
+static const char *tmp_ext = ".tmp";
 static const char *storage_dir;
 
+/* This is a thread-safe always malloced version of dirname which will work
+ * regardless of which underlying dirname() implementation is used.
+ */
+static char *alloc_dirname(const char *path)
+{
+	char *tmp = l_strdup(path);
+	char *dir;
+
+	dir = dirname(tmp);
+	strncpy(tmp, dir, strlen(path) + 1);
+
+	return tmp;
+}
+
 static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
 {
 	struct mesh_node *node = user_data;
@@ -166,7 +184,7 @@ static bool parse_node(struct mesh_node *node, json_object *jnode)
 	return true;
 }
 
-static bool parse_config(char *in_file, char *out_file, const uint8_t uuid[16])
+static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
 {
 	int fd;
 	char *str;
@@ -213,7 +231,7 @@ static bool parse_config(char *in_file, char *out_file, const uint8_t uuid[16])
 	}
 
 	node_jconfig_set(node, jnode);
-	node_cfg_file_set(node, out_file);
+	node_path_set(node, out_dir);
 
 done:
 	close(fd);
@@ -430,15 +448,12 @@ static bool save_config(json_object *jnode, const char *config_name)
 static void idle_save_config(void *user_data)
 {
 	struct write_info *info = user_data;
-	size_t len = strlen(info->config_name) + 5;
-	char *tmp = l_malloc(len);
-	char *bak = l_malloc(len);
+	char *tmp, *bak, *cfg;
 	bool result = false;
 
-	strncpy(tmp, info->config_name, len);
-	strncpy(bak, info->config_name, len);
-	tmp = strncat(tmp, ".tmp", 5);
-	bak = strncat(bak, ".bak", 5);
+	cfg = l_strdup_printf("%s%s", info->node_path, cfg_name);
+	tmp = l_strdup_printf("%s%s", cfg, tmp_ext);
+	bak = l_strdup_printf("%s%s", cfg, bak_ext);
 	remove(tmp);
 
 	l_debug("Storage-Wrote");
@@ -446,13 +461,14 @@ static void idle_save_config(void *user_data)
 
 	if (result) {
 		remove(bak);
-		rename(info->config_name, bak);
-		rename(tmp, info->config_name);
+		rename(cfg, bak);
+		rename(tmp, cfg);
 	}
 
 	remove(tmp);
 	l_free(tmp);
 	l_free(bak);
+	l_free(cfg);
 
 	if (info->cb)
 		info->cb(info->user_data, result);
@@ -467,7 +483,7 @@ void storage_save_config(struct mesh_node *node, bool no_wait,
 
 	info = l_new(struct write_info, 1);
 	info->jnode = node_jconfig_get(node);
-	info->config_name = node_cfg_file_get(node);
+	info->node_path = node_path_get(node);
 	info->cb = cb;
 	info->user_data = user_data;
 
@@ -517,6 +533,7 @@ bool storage_load_nodes(const char *dir_name)
 {
 	DIR *dir;
 	struct dirent *entry;
+	size_t path_len = strlen(dir_name) + strlen(cfg_name) + strlen(bak_ext);
 
 	create_dir(dir_name);
 	dir = opendir(dir_name);
@@ -529,33 +546,37 @@ bool storage_load_nodes(const char *dir_name)
 	storage_dir = dir_name;
 
 	while ((entry = readdir(dir)) != NULL) {
-		char *cfg;
-		char *bak;
+		char *dir, *cfg, *bak;
 		uint8_t uuid[16];
+		size_t node_len;
 
 		if (entry->d_type != DT_DIR)
 			continue;
 
-		if (!str2hex(entry->d_name, strlen(entry->d_name), uuid, sizeof(uuid)))
+		/* Check path length */
+		node_len = strlen(entry->d_name);
+		if (path_len + node_len + 1 >= PATH_MAX)
 			continue;
 
-		cfg = l_strdup_printf("%s/%s/node.json", dir_name, entry->d_name);
-
-		if (parse_config(cfg, cfg, uuid))
+		if (!str2hex(entry->d_name, node_len, uuid, sizeof(uuid)))
 			continue;
 
-		/* Fall-back to Backup version */
-		bak = l_strdup_printf("%s/%s/node.json.bak", dir_name, entry->d_name);
+		dir = l_strdup_printf("%s/%s", dir_name, entry->d_name);
+		cfg = l_strdup_printf("%s%s", dir, cfg_name);
 
-		if (parse_config(bak, cfg, uuid)) {
-			remove(cfg);
-			rename(bak, cfg);
-			l_free(cfg);
-			continue;
-		}
+		if (!parse_config(cfg, dir, uuid)) {
 
+			/* Fall-back to Backup version */
+			bak = l_strdup_printf("%s%s", cfg, bak_ext);
+
+			if (parse_config(bak, dir, uuid)) {
+				remove(cfg);
+				rename(bak, cfg);
+			}
+			l_free(bak);
+		}
 		l_free(cfg);
-		l_free(bak);
+		l_free(dir);
 	}
 
 	return true;
@@ -566,8 +587,8 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	struct mesh_db_node *db_node = data;
 	char uuid[33];
 	char name_buf[PATH_MAX];
-	char *filename;
 	json_object *jnode;
+	size_t max_len = strlen(cfg_name) + strlen(bak_ext);
 
 	if (!storage_dir)
 		return false;
@@ -578,25 +599,26 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 		return false;
 
 	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
-		return false;
+		goto fail;
 
 	snprintf(name_buf, PATH_MAX, "%s/%s", storage_dir, uuid);
 
+	if (strlen(name_buf) + max_len >= PATH_MAX)
+		goto fail;
+
 	/* Create a new directory and node.json file */
 	if (mkdir(name_buf, 0755) != 0)
 		goto fail;
 
-	filename = l_strdup_printf("%s/node.json", name_buf);
+	node_path_set(node, name_buf);
 
-	l_debug("New node config %s", filename);
+	snprintf(name_buf, PATH_MAX, "%s/%s%s", storage_dir, uuid, cfg_name);
+	l_debug("New node config %s", name_buf);
 
-	if (!save_config(jnode, filename)) {
-		l_free(filename);
+	if (!save_config(jnode, name_buf))
 		goto fail;
-	}
 
 	node_jconfig_set(node, jnode);
-	node_cfg_file_set(node, filename);
 
 	return true;
 fail:
@@ -604,13 +626,29 @@ fail:
 	return false;
 }
 
+static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
+						struct FTW *ftwbuf)
+{
+	switch (typeflag) {
+	case FTW_DP:
+		rmdir(fpath);
+		l_debug("RMDIR %s", fpath);
+		break;
+
+	case FTW_SL:
+	default:
+		remove(fpath);
+		l_debug("RM %s", fpath);
+		break;
+	}
+	return 0;
+}
+
 /* Permanently remove node configuration */
 void storage_remove_node_config(struct mesh_node *node)
 {
-	char *cfg;
+	char *node_path, *mesh_path, *mesh_name;
 	struct json_object *jnode;
-	const char *dir_name;
-	char *bak;
 
 	if (!node)
 		return;
@@ -621,25 +659,17 @@ void storage_remove_node_config(struct mesh_node *node)
 		json_object_put(jnode);
 	node_jconfig_set(node, NULL);
 
-	/* Delete node configuration file */
-	cfg = node_cfg_file_get(node);
-	if (!cfg)
-		return;
-
-	l_debug("Delete node config file %s", cfg);
-	remove(cfg);
-
-	/* Delete the backup file */
-	bak = l_strdup_printf("%s.bak", cfg);
-	remove(bak);
-	l_free(bak);
+	node_path = node_path_get(node);
+	l_debug("Delete node config %s", node_path);
 
-	/* Delete the node directory */
-	dir_name = dirname(cfg);
+	/* Make sure path name of node follows expected guidelines */
+	mesh_path = alloc_dirname(node_path);
+	mesh_name = basename(mesh_path);
+	if (strcmp(mesh_name, "mesh"))
+		goto done;
 
-	l_debug("Delete directory %s", dir_name);
-	rmdir(dir_name);
+	nftw(node_path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
 
-	l_free(cfg);
-	node_cfg_file_set(node, NULL);
+done:
+	l_free(mesh_path);
 }
-- 
2.14.5

