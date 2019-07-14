Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653AFC742D2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221C620C01
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfGNXXe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 19:23:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:39750 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfGNXXd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 19:23:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 16:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,492,1557212400"; 
   d="scan'208";a="168805657"
Received: from rreichel-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.24.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2019 16:23:32 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 08/10 v3] mesh: Manage node config directory in mesh-config
Date:   Sun, 14 Jul 2019 16:23:18 -0700
Message-Id: <20190714232320.20921-9-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714232320.20921-1-inga.stotland@intel.com>
References: <20190714232320.20921-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This completely removes storage.c file. Instead, the handling
of mesh node configuration storage is done completely in
mesh-config layer by calling the following API functions:
bool mesh_config_load_nodes(const char *cfg_dir,
                            mesh_config_node_func_t cb,
                            void *user_data)

void mesh_config_release(struct mesh_config *cfg)
void mesh_config_destroy(struct mesh_config *cfg)

bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
                      mesh_config_status_func_t cb, void *user_data)

struct mesh_config *mesh_config_create(const char *cfg_path,
                                       const uint8_t uuid[16],
                                       struct mesh_config_node *node)
---
 Makefile.mesh           |   1 -
 mesh/cfgmod-server.c    |   1 -
 mesh/mesh-config-json.c | 211 +++++++++++++++++++++++++++------
 mesh/mesh-config.h      |   7 +-
 mesh/mesh.c             |  15 ++-
 mesh/mesh.h             |   1 +
 mesh/model.c            |   1 -
 mesh/node.c             |  48 ++++----
 mesh/node.h             |   3 +-
 mesh/storage.c          | 254 ----------------------------------------
 mesh/storage.h          |  27 -----
 mesh/util.c             |  39 +++++-
 mesh/util.h             |   1 +
 13 files changed, 255 insertions(+), 354 deletions(-)
 delete mode 100644 mesh/storage.c
 delete mode 100644 mesh/storage.h

diff --git a/Makefile.mesh b/Makefile.mesh
index 502ba2a47..02b457e46 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -16,7 +16,6 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/error.h mesh/mesh-io-api.h \
 				mesh/mesh-io-generic.h \
 				mesh/mesh-io-generic.c \
-				mesh/storage.h mesh/storage.c \
 				mesh/net.h mesh/net.c \
 				mesh/crypto.h mesh/crypto.c \
 				mesh/friend.h mesh/friend.c \
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 033ab41ea..b256cdd48 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -29,7 +29,6 @@
 #include "mesh/net.h"
 #include "mesh/appkey.h"
 #include "mesh/model.h"
-#include "mesh/storage.h"
 #include "mesh/mesh-config.h"
 #include "mesh/cfgmod.h"
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 62c674afd..75015e607 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -22,7 +22,7 @@
 #endif
 
 #define _GNU_SOURCE
-//#include <dirent.h>
+#include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <ftw.h>
@@ -42,7 +42,7 @@
 
 struct mesh_config {
 	json_object *jnode;
-	char *node_path;
+	char *node_dir_path;
 	uint8_t uuid[16];
 };
 
@@ -52,6 +52,7 @@ struct write_info {
 	mesh_config_status_func_t cb;
 };
 
+static const char *cfg_name = "/node.json";
 static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 
@@ -535,7 +536,7 @@ bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t idx,
 
 	json_object_array_add(jarray, jentry);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 
 fail:
 	if (jentry)
@@ -577,7 +578,7 @@ bool mesh_config_net_key_update(struct mesh_config *cfg, uint16_t idx,
 	json_object_object_add(jentry, "keyRefresh",
 				json_object_new_int(KEY_REFRESH_PHASE_ONE));
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
@@ -601,7 +602,7 @@ bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 		json_object_object_del(jnode, "netKeys");
 		/* TODO: Do we raise an error here? */
 		l_warn("Removing the last network key! Zero keys left.");
-		return save_config(jnode, cfg->node_path);
+		return save_config(jnode, cfg->node_dir_path);
 	}
 
 	/*
@@ -616,7 +617,7 @@ bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 	json_object_object_del(jnode, "netKeys");
 	json_object_object_add(jnode, "netKeys", jarray_new);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key)
@@ -624,7 +625,7 @@ bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key)
 	if (!cfg || !add_key_value(cfg->jnode, "deviceKey", key))
 		return false;
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token)
@@ -632,7 +633,7 @@ bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token)
 	if (!cfg || !add_u64_value(cfg->jnode, "token", token))
 		return false;
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
@@ -684,7 +685,7 @@ bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 
 	json_object_array_add(jarray, jentry);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 
 fail:
 
@@ -726,7 +727,7 @@ bool mesh_config_app_key_update(struct mesh_config *cfg, uint16_t app_idx,
 	if (!add_key_value(jentry, "key", key))
 		return false;
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
@@ -763,7 +764,7 @@ bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
 	json_object_object_del(jnode, "appKeys");
 	json_object_object_add(jnode, "appKeys", jarray_new);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint8_t ele_idx,
@@ -803,7 +804,7 @@ bool mesh_config_model_binding_add(struct mesh_config *cfg, uint8_t ele_idx,
 
 	json_object_array_add(jarray, jstring);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_model_binding_del(struct mesh_config *cfg, uint8_t ele_idx,
@@ -847,7 +848,7 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint8_t ele_idx,
 	json_object_object_del(jmodel, "bind");
 	json_object_object_add(jmodel, "bind", jarray_new);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 static void free_model(void *data)
@@ -1439,7 +1440,7 @@ bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 	if (!cfg || !write_mode(cfg->jnode, keyword, value))
 		return false;
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
 static bool write_relay_mode(json_object *jobj, uint8_t mode,
@@ -1475,7 +1476,7 @@ bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast)
 	if (!cfg || !write_uint16_hex(cfg->jnode, "unicastAddress", unicast))
 		return false;
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
@@ -1485,7 +1486,7 @@ bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 	if (!cfg || !write_relay_mode(cfg->jnode, mode, count, interval))
 		return false;
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
@@ -1511,7 +1512,7 @@ bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 	json_object_object_del(jnode, "retransmit");
 	json_object_object_add(jnode, "retransmit", jretransmit);
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 
 fail:
 	json_object_put(jretransmit);
@@ -1536,7 +1537,7 @@ bool mesh_config_write_iv_index(struct mesh_config *cfg, uint32_t idx,
 	if (!write_int(jnode, "IVupdate", tmp))
 		return false;
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 static void add_model(void *a, void *b)
@@ -1558,9 +1559,9 @@ static void add_model(void *a, void *b)
 }
 
 /* Add unprovisioned node (local) */
-struct mesh_config *mesh_config_create(const char *cfg_path,
-						const uint8_t uuid[16],
-						struct mesh_config_node *node)
+static struct mesh_config *create_config(const char *cfg_path,
+					const uint8_t uuid[16],
+					struct mesh_config_node *node)
 {
 	struct mesh_config_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
@@ -1653,7 +1654,43 @@ struct mesh_config *mesh_config_create(const char *cfg_path,
 
 	cfg->jnode = jnode;
 	memcpy(cfg->uuid, uuid, 16);
-	cfg->node_path = l_strdup(cfg_path);
+	cfg->node_dir_path = l_strdup(cfg_path);
+
+	return cfg;
+}
+
+struct mesh_config *mesh_config_create(const char *cfg_dir,
+		const uint8_t uuid[16], struct mesh_config_node *db_node)
+{
+	char uuid_buf[33];
+	char name_buf[PATH_MAX];
+	struct mesh_config *cfg;
+	size_t max_len = strlen(cfg_name) + strlen(bak_ext);
+
+	if (!hex2str((uint8_t *) uuid, 16, uuid_buf, sizeof(uuid_buf)))
+		return NULL;
+
+	snprintf(name_buf, PATH_MAX, "%s/%s", cfg_dir, uuid_buf);
+
+	if (strlen(name_buf) + max_len >= PATH_MAX)
+		return NULL;
+
+	/* Create a new directory and node.json file */
+	if (mkdir(name_buf, 0755) != 0)
+		return NULL;
+
+	snprintf(name_buf, PATH_MAX, "%s/%s%s", cfg_dir, uuid_buf,
+								cfg_name);
+	l_debug("New node config %s", name_buf);
+
+	cfg = create_config(name_buf, uuid, db_node);
+	if (!cfg)
+		return NULL;
+
+	if (!mesh_config_save(cfg, true, NULL, NULL)) {
+		mesh_config_release(cfg);
+		return NULL;
+	}
 
 	return cfg;
 }
@@ -1714,7 +1751,7 @@ bool mesh_config_net_key_set_phase(struct mesh_config *cfg, uint16_t idx,
 		finish_key_refresh(jnode, idx);
 	}
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t addr,
@@ -1778,7 +1815,7 @@ bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t addr,
 	json_object_object_add(jpub, "retransmit", jretransmit);
 	json_object_object_add(jmodel, "publish", jpub);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 
 fail:
 	json_object_put(jpub);
@@ -1811,7 +1848,7 @@ bool mesh_config_model_pub_del(struct mesh_config *cfg, uint16_t addr,
 								"publish"))
 		return false;
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t addr,
@@ -1862,7 +1899,7 @@ bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t addr,
 
 	json_object_array_add(jarray, jstring);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t addr,
@@ -1917,7 +1954,7 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t addr,
 	json_object_object_del(jmodel, "subscribe");
 	json_object_object_add(jmodel, "subscribe", jarray_new);
 
-	return save_config(jnode, cfg->node_path);
+	return save_config(jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
@@ -1927,7 +1964,7 @@ bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
 								"subscribe"))
 		return false;
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
 bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq)
@@ -1935,7 +1972,7 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq)
 	if (!cfg || !write_int(cfg->jnode, "sequenceNumber", seq))
 		return false;
 
-	mesh_config_save_config(cfg, false, NULL, NULL);
+	mesh_config_save(cfg, false, NULL, NULL);
 	return true;
 }
 
@@ -1944,10 +1981,10 @@ bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl)
 	if (!cfg || !write_int(cfg->jnode, "defaultTTL", ttl))
 		return false;
 
-	return save_config(cfg->jnode, cfg->node_path);
+	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
-bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
+static bool load_node(const char *fname, const uint8_t uuid[16],
 				mesh_config_node_func_t cb, void *user_data)
 {
 	int fd;
@@ -1963,9 +2000,9 @@ bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
 		return false;
 	}
 
-	l_info("Loading configuration from %s", cfg_path);
+	l_info("Loading configuration from %s", fname);
 
-	fd = open(cfg_path, O_RDONLY);
+	fd = open(fname, O_RDONLY);
 	if (fd < 0)
 		return false;
 
@@ -1982,7 +2019,7 @@ bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
 
 	sz = read(fd, str, st.st_size);
 	if (sz != st.st_size) {
-		l_error("Failed to read configuration file %s", cfg_path);
+		l_error("Failed to read configuration file %s", fname);
 		goto done;
 	}
 
@@ -1998,11 +2035,11 @@ bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
 
 		cfg->jnode = jnode;
 		memcpy(cfg->uuid, uuid, 16);
-		cfg->node_path = l_strdup(cfg_path);
+		cfg->node_dir_path = l_strdup(fname);
 		result = cb(&node, uuid, cfg, user_data);
 
 		if (!result) {
-			l_free(cfg->node_path);
+			l_free(cfg->node_dir_path);
 			l_free(cfg);
 		}
 	}
@@ -2028,7 +2065,7 @@ void mesh_config_release(struct mesh_config *cfg)
 	if (!cfg)
 		return;
 
-	l_free(cfg->node_path);
+	l_free(cfg->node_dir_path);
 	json_object_put(cfg->jnode);
 	l_free(cfg);
 }
@@ -2039,7 +2076,7 @@ static void idle_save_config(void *user_data)
 	char *fname_tmp, *fname_bak, *fname_cfg;
 	bool result = false;
 
-	fname_cfg = info->cfg->node_path;
+	fname_cfg = info->cfg->node_dir_path;
 	fname_tmp = l_strdup_printf("%s%s", fname_cfg, tmp_ext);
 	fname_bak = l_strdup_printf("%s%s", fname_cfg, bak_ext);
 	remove(fname_tmp);
@@ -2063,7 +2100,7 @@ static void idle_save_config(void *user_data)
 	l_free(info);
 }
 
-bool mesh_config_save_config(struct mesh_config *cfg, bool no_wait,
+bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
 				mesh_config_status_func_t cb, void *user_data)
 {
 	struct write_info *info;
@@ -2083,3 +2120,99 @@ bool mesh_config_save_config(struct mesh_config *cfg, bool no_wait,
 
 	return true;
 }
+
+bool mesh_config_load_nodes(const char *cfg_dir, mesh_config_node_func_t cb,
+							void *user_data)
+{
+	DIR *dir;
+	struct dirent *entry;
+	size_t path_len = strlen(cfg_dir) + strlen(cfg_name) + strlen(bak_ext);
+
+	create_dir(cfg_dir);
+	dir = opendir(cfg_dir);
+	if (!dir) {
+		l_error("Failed to open mesh node storage directory: %s",
+								cfg_dir);
+		return false;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		char *dir, *fname, *bak;
+		uint8_t uuid[16];
+		size_t node_len;
+
+		if (entry->d_type != DT_DIR)
+			continue;
+
+		/* Check path length */
+		node_len = strlen(entry->d_name);
+		if (path_len + node_len + 1 >= PATH_MAX)
+			continue;
+
+		if (!str2hex(entry->d_name, node_len, uuid, sizeof(uuid)))
+			continue;
+
+		dir = l_strdup_printf("%s/%s", cfg_dir, entry->d_name);
+		fname = l_strdup_printf("%s%s", dir, cfg_name);
+
+		if (!load_node(fname, uuid, cb, user_data)) {
+
+			/* Fall-back to Backup version */
+			bak = l_strdup_printf("%s%s", fname, bak_ext);
+
+			if (load_node(bak, uuid, cb, user_data)) {
+				remove(fname);
+				rename(bak, fname);
+			}
+			l_free(bak);
+		}
+		l_free(fname);
+		l_free(dir);
+	}
+
+	return true;
+}
+
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
+void mesh_config_destroy(struct mesh_config *cfg)
+{
+	char *node_dir, *node_name;
+	char uuid[33];
+
+	if (!cfg)
+		return;
+
+	node_dir = dirname(cfg->node_dir_path);
+	l_debug("Delete node config %s", node_dir);
+
+	if (!hex2str(cfg->uuid, 16, uuid, sizeof(uuid)))
+		return;
+
+	node_name = basename(node_dir);
+
+	/* Make sure path name of node follows expected guidelines */
+	if (strcmp(node_name, uuid))
+		return;
+
+	nftw(node_dir, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
+
+	/* Release node config object */
+	mesh_config_release(cfg);
+}
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 83ba33bf9..44e3b3ad6 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -110,10 +110,11 @@ typedef bool (*mesh_config_node_func_t)(struct mesh_config_node *node,
 							struct mesh_config *cfg,
 							void *user_data);
 
-bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
-				mesh_config_node_func_t cb, void *user_data);
+bool mesh_config_load_nodes(const char *cfg_dir, mesh_config_node_func_t cb,
+							void *user_data);
 void mesh_config_release(struct mesh_config *cfg);
-bool mesh_config_save_config(struct mesh_config *cfg, bool no_wait,
+void mesh_config_destroy(struct mesh_config *cfg);
+bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
 				mesh_config_status_func_t cb, void *user_data);
 struct mesh_config *mesh_config_create(const char *cfg_path,
 						const uint8_t uuid[16],
diff --git a/mesh/mesh.c b/mesh/mesh.c
index b9e3162eb..9c6b9a70e 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -27,7 +27,6 @@
 #include "mesh/mesh-io.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
-#include "mesh/storage.h"
 #include "mesh/provision.h"
 #include "mesh/model.h"
 #include "mesh/dbus.h"
@@ -78,6 +77,8 @@ static struct join_data *join_pending;
 /* Pending method requests */
 static struct l_queue *pending_queue;
 
+static const char *storage_dir;
+
 static bool simple_match(const void *a, const void *b)
 {
 	return a == b;
@@ -150,12 +151,11 @@ bool mesh_init(const char *config_dir, enum mesh_io_type type, void *opts)
 	mesh.prov_timeout = DEFAULT_PROV_TIMEOUT;
 	mesh.algorithms = DEFAULT_ALGORITHMS;
 
-	if (!config_dir)
-		config_dir = MESH_STORAGEDIR;
+	storage_dir = config_dir ? config_dir : MESH_STORAGEDIR;
 
-	l_info("Loading node configuration from %s", config_dir);
+	l_info("Loading node configuration from %s", storage_dir);
 
-	if (!storage_load_nodes(config_dir))
+	if (!node_load_from_storage(storage_dir))
 		return false;
 
 	mesh.io = mesh_io_new(type, opts);
@@ -638,3 +638,8 @@ bool mesh_dbus_init(struct l_dbus *dbus)
 
 	return true;
 }
+
+const char *mesh_get_storage_dir(void)
+{
+	return storage_dir;
+}
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 78d4d4926..e0a3e1b96 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -42,3 +42,4 @@ bool mesh_send_cancel(const uint8_t *filter, uint8_t len);
 bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data);
 void mesh_unreg_prov_rx(prov_rx_cb_t cb);
 const char *mesh_prov_status_str(uint8_t status);
+const char *mesh_get_storage_dir(void);
diff --git a/mesh/model.c b/mesh/model.c
index ef62a223a..785becb5f 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -33,7 +33,6 @@
 #include "mesh/net.h"
 #include "mesh/appkey.h"
 #include "mesh/cfgmod.h"
-#include "mesh/storage.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
 #include "mesh/util.h"
diff --git a/mesh/node.c b/mesh/node.c
index d90ca2ad1..56489a8db 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -33,7 +33,6 @@
 #include "mesh/appkey.h"
 #include "mesh/mesh-config.h"
 #include "mesh/provision.h"
-#include "mesh/storage.h"
 #include "mesh/keyring.h"
 #include "mesh/model.h"
 #include "mesh/cfgmod.h"
@@ -195,7 +194,7 @@ uint8_t *node_uuid_get(struct mesh_node *node)
 	return node->uuid;
 }
 
-struct mesh_node *node_new(const uint8_t uuid[16])
+static struct mesh_node *node_new(const uint8_t uuid[16])
 {
 	struct mesh_node *node;
 
@@ -284,8 +283,8 @@ void node_remove(struct mesh_node *node)
 
 	l_queue_remove(nodes, node);
 
-	if (node->node_path)
-		storage_remove_node_config(node);
+	if (node->cfg)
+		mesh_config_destroy(node->cfg);
 
 	free_node_resources(node);
 }
@@ -393,12 +392,15 @@ static void set_app_key(void *a, void *b)
 						appkey->key, appkey->new_key);
 }
 
-bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
-					struct mesh_config_node *db_node)
+static bool init_from_storage(struct mesh_config_node *db_node,
+			const uint8_t uuid[16], struct mesh_config *cfg,
+			void *user_data)
 {
 	unsigned int num_ele;
 	uint8_t mode;
 
+	struct mesh_node *node = node_new(uuid);
+
 	node->comp = l_new(struct node_composition, 1);
 	node->comp->cid = db_node->cid;
 	node->comp->pid = db_node->pid;
@@ -424,17 +426,17 @@ bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
 
 	num_ele = l_queue_length(db_node->elements);
 	if (num_ele > 0xff)
-		return false;
+		goto fail;
 
 	node->num_ele = num_ele;
 
 	if (num_ele != 0 && !add_elements(node, db_node))
-		return false;
+		goto fail;
 
 	node->primary = db_node->unicast;
 
 	if (!db_node->netkeys)
-		return false;
+		goto fail;
 
 	mesh_net_set_iv_index(node->net, db_node->iv_index, db_node->iv_update);
 
@@ -470,12 +472,17 @@ bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
 
 	if (!IS_UNASSIGNED(node->primary) &&
 		!mesh_net_register_unicast(node->net, node->primary, num_ele))
-		return false;
+		goto fail;
 
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
 
+	node->cfg = cfg;
+
 	return true;
+fail:
+	node_remove(node);
+	return false;
 }
 
 static void cleanup_node(void *data)
@@ -490,7 +497,7 @@ static void cleanup_node(void *data)
 		mesh_config_write_seq_number(node->cfg,
 						mesh_net_get_seq_num(net));
 
-		mesh_config_save_config(node->cfg, true, NULL, NULL);
+		mesh_config_save(node->cfg, true, NULL, NULL);
 	}
 
 	free_node_resources(node);
@@ -1362,10 +1369,11 @@ static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 {
 	struct mesh_config_node db_node;
 	const struct l_queue_entry *entry;
-	bool res;
+	const char *storage_dir;
 
 	convert_node_to_storage(node, &db_node);
-	res = storage_create_node_config(node, uuid, &db_node);
+	storage_dir = mesh_get_storage_dir();
+	node->cfg = mesh_config_create(storage_dir, uuid, &db_node);
 
 	/* Free temporarily allocated resources */
 	entry = l_queue_get_entries(db_node.elements);
@@ -1377,7 +1385,7 @@ static bool create_node_config(struct mesh_node *node, const uint8_t uuid[16])
 
 	l_queue_destroy(db_node.elements, l_free);
 
-	return res;
+	return node->cfg != NULL;
 }
 
 static void set_defaults(struct mesh_node *node)
@@ -1502,7 +1510,7 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 			return false;
 	}
 
-	mesh_config_save_config(node->cfg, true, NULL, NULL);
+	mesh_config_save(node->cfg, true, NULL, NULL);
 
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
@@ -2060,11 +2068,6 @@ bool node_add_pending_local(struct mesh_node *node, void *prov_node_info)
 			info->device_key, info->net_index, info->net_key);
 }
 
-void node_config_set(struct mesh_node *node, struct mesh_config *cfg)
-{
-	node->cfg = cfg;
-}
-
 struct mesh_config *node_config_get(struct mesh_node *node)
 {
 	return node->cfg;
@@ -2098,3 +2101,8 @@ struct mesh_agent *node_get_agent(struct mesh_node *node)
 {
 	return node->agent;
 }
+
+bool node_load_from_storage(const char *storage_dir)
+{
+	return mesh_config_load_nodes(storage_dir, init_from_storage, NULL);
+}
diff --git a/mesh/node.h b/mesh/node.h
index ee62737fc..e387b4d09 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -35,7 +35,6 @@ typedef void (*node_ready_func_t) (void *user_data, int status,
 typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
 
-struct mesh_node *node_new(const uint8_t uuid[16]);
 void node_remove(struct mesh_node *node);
 void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb);
@@ -100,8 +99,8 @@ void node_id_set(struct mesh_node *node, uint16_t node_id);
 uint16_t node_id_get(struct mesh_node *node);
 bool node_dbus_init(struct l_dbus *bus);
 void node_cleanup_all(void);
-void node_config_set(struct mesh_node *node, struct mesh_config *cfg);
 struct mesh_config *node_config_get(struct mesh_node *node);
 void node_path_set(struct mesh_node *node, char *path);
 char *node_path_get(struct mesh_node *node);
 struct mesh_agent *node_get_agent(struct mesh_node *node);
+bool node_load_from_storage(const char *storage_dir);
diff --git a/mesh/storage.c b/mesh/storage.c
deleted file mode 100644
index 6a8766257..000000000
--- a/mesh/storage.c
+++ /dev/null
@@ -1,254 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#define _GNU_SOURCE
-#include <fcntl.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <dirent.h>
-#include <libgen.h>
-#include <ftw.h>
-
-#include <ell/ell.h>
-
-#include "mesh/mesh-defs.h"
-#include "mesh/node.h"
-#include "mesh/net.h"
-#include "mesh/appkey.h"
-#include "mesh/mesh-config.h"
-#include "mesh/util.h"
-#include "mesh/storage.h"
-
-static const char *cfg_name = "/node.json";
-static const char *bak_ext = ".bak";
-static const char *storage_dir;
-
-static bool read_node_cb(struct mesh_config_node *db_node,
-			const uint8_t uuid[16], struct mesh_config *cfg,
-			void *user_data)
-{
-	struct mesh_node *node = user_data;
-
-	if (!node_init_from_storage(node, uuid, db_node)) {
-		node_remove(node);
-		return false;
-	}
-
-	node_config_set(node, cfg);
-	return true;
-}
-
-static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
-{
-	bool result = false;
-	struct mesh_node *node;
-
-	node = node_new(uuid);
-
-	result = mesh_config_load_node(in_file, uuid, read_node_cb, node);
-
-	if (!result)
-		node_remove(node);
-	else
-		node_path_set(node, out_dir);
-
-	return result;
-}
-
-static int create_dir(const char *dir_name)
-{
-	struct stat st;
-	char dir[PATH_MAX + 1], *prev, *next;
-	int err;
-
-	err = stat(dir_name, &st);
-	if (!err && S_ISREG(st.st_mode))
-		return 0;
-
-	memset(dir, 0, PATH_MAX + 1);
-	strcat(dir, "/");
-
-	prev = strchr(dir_name, '/');
-
-	while (prev) {
-		next = strchr(prev + 1, '/');
-		if (!next)
-			break;
-
-		if (next - prev == 1) {
-			prev = next;
-			continue;
-		}
-
-		strncat(dir, prev + 1, next - prev);
-		mkdir(dir, 0755);
-
-		prev = next;
-	}
-
-	mkdir(dir_name, 0755);
-
-	return 0;
-}
-
-bool storage_load_nodes(const char *dir_name)
-{
-	DIR *dir;
-	struct dirent *entry;
-	size_t path_len = strlen(dir_name) + strlen(cfg_name) + strlen(bak_ext);
-
-	create_dir(dir_name);
-	dir = opendir(dir_name);
-	if (!dir) {
-		l_error("Failed to open mesh node storage directory: %s",
-								dir_name);
-		return false;
-	}
-
-	storage_dir = dir_name;
-
-	while ((entry = readdir(dir)) != NULL) {
-		char *dir, *cfg, *bak;
-		uint8_t uuid[16];
-		size_t node_len;
-
-		if (entry->d_type != DT_DIR)
-			continue;
-
-		/* Check path length */
-		node_len = strlen(entry->d_name);
-		if (path_len + node_len + 1 >= PATH_MAX)
-			continue;
-
-		if (!str2hex(entry->d_name, node_len, uuid, sizeof(uuid)))
-			continue;
-
-		dir = l_strdup_printf("%s/%s", dir_name, entry->d_name);
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
-bool storage_create_node_config(struct mesh_node *node, const uint8_t uuid[16],
-					struct mesh_config_node *db_node)
-{
-	char uuid_buf[33];
-	char name_buf[PATH_MAX];
-	struct mesh_config *cfg;
-	size_t max_len = strlen(cfg_name) + strlen(bak_ext);
-
-	if (!storage_dir)
-		return false;
-
-	if (!hex2str((uint8_t *) uuid, 16, uuid_buf, sizeof(uuid_buf)))
-		return false;
-
-	snprintf(name_buf, PATH_MAX, "%s/%s", storage_dir, uuid_buf);
-
-	if (strlen(name_buf) + max_len >= PATH_MAX)
-		return false;
-
-	/* Create a new directory and node.json file */
-	if (mkdir(name_buf, 0755) != 0)
-		return false;
-
-	node_path_set(node, name_buf);
-
-	snprintf(name_buf, PATH_MAX, "%s/%s%s", storage_dir, uuid_buf,
-								cfg_name);
-	l_debug("New node config %s", name_buf);
-
-	cfg = mesh_config_create(name_buf, uuid, db_node);
-	if (!cfg)
-		return false;
-
-	if (!mesh_config_save_config(cfg, true, NULL, NULL)) {
-		mesh_config_release(cfg);
-		return false;
-	}
-
-	node_config_set(node, cfg);
-
-	return true;
-}
-
-static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
-						struct FTW *ftwbuf)
-{
-	switch (typeflag) {
-	case FTW_DP:
-		rmdir(fpath);
-		l_debug("RMDIR %s", fpath);
-		break;
-
-	case FTW_SL:
-	default:
-		remove(fpath);
-		l_debug("RM %s", fpath);
-		break;
-	}
-	return 0;
-}
-
-/* Permanently remove node configuration */
-void storage_remove_node_config(struct mesh_node *node)
-{
-	char *node_path, *node_name;
-	char uuid[33];
-
-	if (!node)
-		return;
-
-	/* Release node config object */
-	mesh_config_release(node_config_get(node));
-	node_config_set(node, NULL);
-
-	node_path = node_path_get(node);
-	l_debug("Delete node config %s", node_path);
-
-	/* Make sure path name of node follows expected guidelines */
-	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
-		return;
-
-	node_name = basename(node_path);
-
-	if (strcmp(node_name, uuid))
-		return;
-
-	nftw(node_path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
-}
diff --git a/mesh/storage.h b/mesh/storage.h
deleted file mode 100644
index 21fd3f5ab..000000000
--- a/mesh/storage.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- */
-
-struct mesh_net;
-struct mesh_node;
-struct mesh_config_node;
-
-bool storage_load_nodes(const char *dir);
-bool storage_create_node_config(struct mesh_node *node, const uint8_t uuid[16],
-					struct mesh_config_node *db_node);
-void storage_remove_node_config(struct mesh_node *node);
diff --git a/mesh/util.c b/mesh/util.c
index 861232266..1455bdec3 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -22,7 +22,8 @@
 #endif
 
 #define _GNU_SOURCE
-
+#include <dirent.h>
+#include <ftw.h>
 #include <stdio.h>
 #include <time.h>
 #include <sys/time.h>
@@ -91,3 +92,39 @@ size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len)
 	out[in_len * 2] = '\0';
 	return i;
 }
+
+int create_dir(const char *dir_name)
+{
+	struct stat st;
+	char dir[PATH_MAX + 1], *prev, *next;
+	int err;
+
+	err = stat(dir_name, &st);
+	if (!err && S_ISREG(st.st_mode))
+		return 0;
+
+	memset(dir, 0, PATH_MAX + 1);
+	strcat(dir, "/");
+
+	prev = strchr(dir_name, '/');
+
+	while (prev) {
+		next = strchr(prev + 1, '/');
+		if (!next)
+			break;
+
+		if (next - prev == 1) {
+			prev = next;
+			continue;
+		}
+
+		strncat(dir, prev + 1, next - prev);
+		mkdir(dir, 0755);
+
+		prev = next;
+	}
+
+	mkdir(dir_name, 0755);
+
+	return 0;
+}
diff --git a/mesh/util.h b/mesh/util.h
index 007ea368e..d1e83b573 100644
--- a/mesh/util.h
+++ b/mesh/util.h
@@ -22,3 +22,4 @@ bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
 							uint16_t out_len);
 size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len);
 void print_packet(const char *label, const void *data, uint16_t size);
+int create_dir(const char *dir_name);
-- 
2.21.0

