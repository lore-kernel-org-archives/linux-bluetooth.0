Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCCC74A44
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE446214AE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfGNXXc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 19:23:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:39743 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbfGNXXc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 19:23:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 16:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,492,1557212400"; 
   d="scan'208";a="168805650"
Received: from rreichel-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.24.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2019 16:23:31 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 06/10 v3] mesh: Replace storage_save_config with mesh_config_save_config
Date:   Sun, 14 Jul 2019 16:23:16 -0700
Message-Id: <20190714232320.20921-7-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714232320.20921-1-inga.stotland@intel.com>
References: <20190714232320.20921-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves writing out of node configuration from storage.c down to
mesh-config-<format-specific>.c to allow for more generic storage layout.

New generalized API in mesh-config.h:
mesh_config_save_config(struct mesh_config *cfg, bool no_wait,
				mesh_config_status_func_t cb, void *user_data)

replaces the old one in storage.h:
storage_save_config(struct mesh_node *node, bool no_wait,
					mesh_status_func_t cb, void *user_data)

Currently, only JSON format is supported for storing node configuration:
mesh_config_save_config is implemented in mesh-config-json.c
---
 mesh/mesh-config-json.c | 70 +++++++++++++++++++++++++++++++----
 mesh/mesh-config.h      |  9 +++--
 mesh/node.c             |  6 +--
 mesh/storage.c          | 82 +++++++----------------------------------
 mesh/storage.h          |  2 -
 5 files changed, 84 insertions(+), 85 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 096b93249..57b0d6e7b 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -46,6 +46,15 @@ struct mesh_config {
 	uint8_t uuid[16];
 };
 
+struct write_info {
+	struct mesh_config *cfg;
+	void *user_data;
+	mesh_config_status_func_t cb;
+};
+
+static const char *bak_ext = ".bak";
+static const char *tmp_ext = ".tmp";
+
 static bool get_int(json_object *jobj, const char *keyword, int *value)
 {
 	json_object *jvalue;
@@ -1926,7 +1935,7 @@ bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
 }
 
 bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
-					mesh_config_node_cb cb, void *user_data)
+				mesh_config_node_func_t cb, void *user_data)
 {
 	int fd;
 	char *str;
@@ -2011,23 +2020,19 @@ void mesh_config_release(struct mesh_config *cfg)
 	l_free(cfg);
 }
 
-bool mesh_config_save_config(struct mesh_config *cfg, const char *fname)
+static bool save_config(json_object *jnode, const char *fname)
 {
 	FILE *outfile;
 	const char *str;
 	bool result = false;
 
-	if (!cfg)
-		return false;
-
 	outfile = fopen(fname, "w");
 	if (!outfile) {
 		l_error("Failed to save configuration to %s", fname);
 		return false;
 	}
 
-	str = json_object_to_json_string_ext(cfg->jnode,
-						JSON_C_TO_STRING_PRETTY);
+	str = json_object_to_json_string_ext(jnode, JSON_C_TO_STRING_PRETTY);
 
 	if (fwrite(str, sizeof(char), strlen(str), outfile) < strlen(str))
 		l_warn("Incomplete write of mesh configuration");
@@ -2038,3 +2043,54 @@ bool mesh_config_save_config(struct mesh_config *cfg, const char *fname)
 
 	return result;
 }
+
+static void idle_save_config(void *user_data)
+{
+	struct write_info *info = user_data;
+	char *fname_tmp, *fname_bak, *fname_cfg;
+	bool result = false;
+
+	fname_cfg = info->cfg->node_path;
+	fname_tmp = l_strdup_printf("%s%s", fname_cfg, tmp_ext);
+	fname_bak = l_strdup_printf("%s%s", fname_cfg, bak_ext);
+	remove(fname_tmp);
+
+	result = save_config(info->cfg->jnode, fname_tmp);
+
+	if (result) {
+		remove(fname_bak);
+		rename(fname_cfg, fname_bak);
+		rename(fname_tmp, fname_cfg);
+	}
+
+	remove(fname_tmp);
+
+	l_free(fname_tmp);
+	l_free(fname_bak);
+
+	if (info->cb)
+		info->cb(info->user_data, result);
+
+	l_free(info);
+}
+
+bool mesh_config_save_config(struct mesh_config *cfg, bool no_wait,
+				mesh_config_status_func_t cb, void *user_data)
+{
+	struct write_info *info;
+
+	if (!cfg)
+		return false;
+
+	info = l_new(struct write_info, 1);
+	info->cfg = cfg;
+	info->cb = cb;
+	info->user_data = user_data;
+
+	if (no_wait)
+		idle_save_config(info);
+	else
+		l_idle_oneshot(idle_save_config, info, NULL);
+
+	return true;
+}
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 8d01e760c..5241dde2d 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -104,16 +104,17 @@ struct mesh_config_node {
 	uint8_t dev_key[16];
 	uint8_t token[8];
 };
-
-typedef bool (*mesh_config_node_cb)(struct mesh_config_node *node,
+typedef void (*mesh_config_status_func_t)(void *user_data, bool result);
+typedef bool (*mesh_config_node_func_t)(struct mesh_config_node *node,
 							const uint8_t uuid[16],
 							struct mesh_config *cfg,
 							void *user_data);
 
 bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
-				mesh_config_node_cb cb, void *user_data);
+				mesh_config_node_func_t cb, void *user_data);
 void mesh_config_release(struct mesh_config *cfg);
-bool mesh_config_save_config(struct mesh_config *cfg, const char *fname);
+bool mesh_config_save_config(struct mesh_config *cfg, bool no_wait,
+				mesh_config_status_func_t cb, void *user_data);
 struct mesh_config *mesh_config_create(const char *cfg_path,
 						const uint8_t uuid[16],
 						struct mesh_config_node *node);
diff --git a/mesh/node.c b/mesh/node.c
index 025c7b59d..5f4f95cc4 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -484,12 +484,12 @@ static void cleanup_node(void *data)
 	struct mesh_net *net = node->net;
 
 	/* Save local node configuration */
-	if (node->node_path) {
+	if (node->cfg) {
 
 		/* Preserve the last sequence number */
 		storage_write_sequence_number(net, mesh_net_get_seq_num(net));
 
-		storage_save_config(node, true, NULL, NULL);
+		mesh_config_save_config(node->cfg, true, NULL, NULL);
 	}
 
 	free_node_resources(node);
@@ -1501,7 +1501,7 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 			return false;
 	}
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(node->cfg, true, NULL, NULL);
 
 	/* Initialize configuration server model */
 	mesh_config_srv_init(node, PRIMARY_ELE_IDX);
diff --git a/mesh/storage.c b/mesh/storage.c
index 869c6d70e..15077cb5d 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -39,16 +39,8 @@
 #include "mesh/util.h"
 #include "mesh/storage.h"
 
-struct write_info {
-	struct mesh_config *cfg;
-	const char *node_path;
-	void *user_data;
-	mesh_status_func_t cb;
-};
-
 static const char *cfg_name = "/node.json";
 static const char *bak_ext = ".bak";
-static const char *tmp_ext = ".tmp";
 static const char *storage_dir;
 
 static bool read_node_cb(struct mesh_config_node *db_node,
@@ -88,7 +80,7 @@ bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 	if (!mesh_config_write_int(node_config_get(node), "defaultTTL", ttl))
 		return false;
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(node_config_get(node), true, NULL, NULL);
 	return true;
 }
 
@@ -99,7 +91,7 @@ bool storage_set_relay(struct mesh_node *node, bool enable,
 								interval))
 		return false;
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(node_config_get(node), true, NULL, NULL);
 	return true;
 }
 
@@ -110,7 +102,7 @@ bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 								interval))
 		return false;
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(node_config_get(node), true, NULL, NULL);
 	return true;
 }
 
@@ -120,7 +112,7 @@ bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 	if (!mesh_config_write_mode(node_config_get(node), mode_name, mode))
 		return false;
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(node_config_get(node), true, NULL, NULL);
 	return true;
 }
 
@@ -145,7 +137,7 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 							mod_id, app_idx);
 
 	if (stored)
-		storage_save_config(node, true, NULL, NULL);
+		mesh_config_save_config(cfg, true, NULL, NULL);
 
 	return stored;
 }
@@ -165,7 +157,7 @@ bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 		stored = mesh_config_app_key_add(cfg, net_idx, app_idx, key);
 
 	if (stored)
-		storage_save_config(node, true, NULL, NULL);
+		mesh_config_save_config(cfg, true, NULL, NULL);
 
 	return stored;
 }
@@ -181,7 +173,7 @@ bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 	if (!mesh_config_app_key_del(cfg, net_idx, app_idx))
 		return false;
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(cfg, true, NULL, NULL);
 	return true;
 }
 
@@ -198,7 +190,7 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 		stored = mesh_config_net_key_update(cfg, net_idx, key);
 
 	if (stored)
-		storage_save_config(node, true, NULL, NULL);
+		mesh_config_save_config(cfg, true, NULL, NULL);
 
 	return stored;
 }
@@ -211,7 +203,7 @@ bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
 	if (!mesh_config_net_key_del(cfg, net_idx))
 		return false;
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(cfg, true, NULL, NULL);
 	return true;
 }
 
@@ -224,7 +216,7 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 	if (!mesh_config_write_iv_index(cfg, iv_index, update))
 		return false;
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(cfg, true, NULL, NULL);
 	return true;
 }
 
@@ -237,7 +229,7 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 	if (!mesh_config_net_key_set_phase(cfg, net_idx, phase))
 		return false;
 
-	storage_save_config(node, true, NULL, NULL);
+	mesh_config_save_config(cfg, true, NULL, NULL);
 	return true;
 }
 
@@ -249,58 +241,10 @@ bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 	if (!mesh_config_write_int(cfg, "sequenceNumber", seq))
 		return false;
 
-	storage_save_config(node, false, NULL, NULL);
+	mesh_config_save_config(cfg, false, NULL, NULL);
 	return true;
 }
 
-static void idle_save_config(void *user_data)
-{
-	struct write_info *info = user_data;
-	char *tmp, *bak, *cfg;
-	bool result = false;
-
-	cfg = l_strdup_printf("%s%s", info->node_path, cfg_name);
-	tmp = l_strdup_printf("%s%s", cfg, tmp_ext);
-	bak = l_strdup_printf("%s%s", cfg, bak_ext);
-	remove(tmp);
-
-	l_debug("Storage-Wrote");
-	result = mesh_config_save_config(info->cfg, tmp);
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
-
-	if (info->cb)
-		info->cb(info->user_data, result);
-
-	l_free(info);
-}
-
-void storage_save_config(struct mesh_node *node, bool no_wait,
-					mesh_status_func_t cb, void *user_data)
-{
-	struct write_info *info;
-
-	info = l_new(struct write_info, 1);
-	info->cfg = node_config_get(node);
-	info->node_path = node_path_get(node);
-	info->cb = cb;
-	info->user_data = user_data;
-
-	if (no_wait)
-		idle_save_config(info);
-	else
-		l_idle_oneshot(idle_save_config, info, NULL);
-}
-
 static int create_dir(const char *dir_name)
 {
 	struct stat st;
@@ -423,7 +367,7 @@ bool storage_create_node_config(struct mesh_node *node, const uint8_t uuid[16],
 	if (!cfg)
 		return false;
 
-	if (!mesh_config_save_config(cfg, name_buf)) {
+	if (!mesh_config_save_config(cfg, true, NULL, NULL)) {
 		mesh_config_release(cfg);
 		return false;
 	}
diff --git a/mesh/storage.h b/mesh/storage.h
index 1fa48ad7a..f70544ad6 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -25,8 +25,6 @@ bool storage_load_nodes(const char *dir);
 bool storage_create_node_config(struct mesh_node *node, const uint8_t uuid[16],
 					struct mesh_config_node *db_node);
 void storage_remove_node_config(struct mesh_node *node);
-void storage_save_config(struct mesh_node *node, bool no_wait,
-					mesh_status_func_t cb, void *user_data);
 bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx, bool unbind);
 
-- 
2.21.0

