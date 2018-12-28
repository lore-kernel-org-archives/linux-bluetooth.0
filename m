Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7311DC43612
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390DA217F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 22:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeL1WIN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:08:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:19949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbeL1WHy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 17:07:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 14:07:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,411,1539673200"; 
   d="scan'208";a="113968690"
Received: from bgix-dell-lap.sea.intel.com ([10.252.140.14])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 14:07:53 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v6 04/26] mesh: Rewrite storage for Multiple Nodes
Date:   Fri, 28 Dec 2018 14:07:23 -0800
Message-Id: <20181228220745.25147-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181228220745.25147-1-brian.gix@intel.com>
References: <20181228220745.25147-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

Node storage now occurs in a privileged location, in the (default:
/var/lib/bluetooth/mesh) and is stored so that multiple nodes may
be handled by a single instance of the daemon. The node storage
files must be priviledged access only, to prevent unauthorized
access to the security material entrusted to each node.
---
 mesh/storage.c | 571 +++++++++++++++++++++++++--------------------------------
 mesh/storage.h |  38 ++--
 2 files changed, 267 insertions(+), 342 deletions(-)

diff --git a/mesh/storage.c b/mesh/storage.c
index 1f3b25886..57ae88b34 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -15,7 +15,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  Lesser General Public License for more details.
  *
- *
  */
 
 #ifdef HAVE_CONFIG_H
@@ -27,6 +26,8 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <dirent.h>
+#include <libgen.h>
 
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -42,39 +43,43 @@
 #include "mesh/net.h"
 #include "mesh/appkey.h"
 #include "mesh/model.h"
+#include "mesh/mesh-db.h"
 #include "mesh/storage.h"
 
-/*
- * TODO: figure out naming convention to store alternative nodes
- * Mesh storage dir wil be in configure.ac
- */
-#define DEVICE_COMPOSITION_FILE "../config/composition.json"
-#define NODE_CONGIGURATION_FILE "../config/configuration.json"
+struct write_info {
+	json_object *jnode;
+	const char *config_name;
+	void *user_data;
+	mesh_status_func_t cb;
+};
+
+static const char *storage_dir;
+static struct l_queue *node_ids;
 
-static bool read_local_node_cb(struct mesh_db_node *db_node, void *user_data)
+static bool simple_match(const void *a, const void *b)
 {
-	struct mesh_net *net = user_data;
-	struct mesh_node *node;
+	return a == b;
+}
+
+static bool read_node_cb(struct mesh_db_node *db_node, void *user_data)
+{
+	struct mesh_node *node = user_data;
+	struct mesh_net *net;
 	uint32_t seq_number;
-	uint16_t crpl;
 	uint8_t ttl, mode, cnt, num_ele;
 	uint16_t unicast, interval;
 	uint8_t *uuid;
 
-	if (!net)
-		return false;
-
-	node = node_create_from_storage(net, db_node, true);
-	if (!node)
+	if (!node_init_from_storage(node, db_node)) {
+		node_free(node);
 		return false;
+	}
 
-	mesh_net_local_node_set(net, node, db_node->provisioner);
+	net = node_get_net(node);
 	seq_number = node_get_sequence_number(node);
 	mesh_net_set_seq_num(net, seq_number);
 	ttl = node_default_ttl_get(node);
 	mesh_net_set_default_ttl(net, ttl);
-	crpl = node_get_crpl(node);
-	mesh_net_set_crpl(net, crpl);
 
 	mode = node_proxy_mode_get(node);
 	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
@@ -103,6 +108,7 @@ static bool read_local_node_cb(struct mesh_db_node *db_node, void *user_data)
 	uuid = node_uuid_get(node);
 	if (uuid)
 		mesh_net_id_uuid_set(net, uuid);
+
 	return true;
 }
 
@@ -132,13 +138,14 @@ static bool read_app_keys_cb(uint16_t net_idx, uint16_t app_idx, uint8_t *key,
 	return appkey_key_init(net, net_idx, app_idx, key, new_key);
 }
 
-static bool parse_local_node(struct mesh_net *net, json_object *jnode)
+static bool parse_node(struct mesh_node *node, json_object *jnode)
 {
 	bool bvalue;
 	uint32_t iv_index;
 	uint8_t key_buf[16];
 	uint8_t cnt;
 	uint16_t interval;
+	struct mesh_net *net = node_get_net(node);
 
 	if (mesh_db_read_iv_index(jnode, &iv_index, &bvalue))
 		mesh_net_set_iv_index(net, iv_index, bvalue);
@@ -147,97 +154,35 @@ static bool parse_local_node(struct mesh_net *net, json_object *jnode)
 		mesh_net_transmit_params_set(net, cnt, interval);
 
 	/* Node composition/configuration info */
-	if (!mesh_db_read_node(jnode, read_local_node_cb, net))
+	if (!mesh_db_read_node(jnode, read_node_cb, node))
 		return false;
 
 	if (!mesh_db_read_net_keys(jnode, read_net_keys_cb, net))
 		return false;
 
-	/* TODO: use the actual "primary" network index for this node */
-	if (mesh_db_read_device_key(jnode, key_buf) &&
-		!node_set_device_key(mesh_net_local_node_get(net), key_buf))
+	if (!mesh_db_read_device_key(jnode, key_buf))
 		return false;
 
-	mesh_db_read_app_keys(jnode, read_app_keys_cb, net);
-
-	return true;
-}
-
-static bool read_unprov_device_cb(struct mesh_db_node *db_node, void *user_data)
-{
-	struct mesh_net *net = user_data;
-	struct mesh_node *node;
-	uint16_t crpl;
-	uint8_t *uuid;
+	node_set_device_key(node, key_buf);
 
-	if (!net)
-		return false;
-
-	node = node_create_from_storage(net, db_node, true);
-
-	if (!node)
-		return false;
-
-	mesh_net_local_node_set(net, node, db_node->provisioner);
-	crpl = node_get_crpl(node);
-	mesh_net_set_crpl(net, crpl);
-
-	uuid = node_uuid_get(node);
-	if (uuid)
-		mesh_net_id_uuid_set(net, uuid);
+	mesh_db_read_app_keys(jnode, read_app_keys_cb, net);
 
 	return true;
 }
 
-static bool parse_unprovisioned_device(struct mesh_net *net, json_object *jnode)
-{
-	struct mesh_db_prov prov;
-	struct mesh_net_prov_caps *caps;
-	struct mesh_node *node;
-
-	/* Node composition/configuration info */
-	if (!mesh_db_read_unprovisioned_device(jnode,
-					read_unprov_device_cb, net))
-		return false;
-
-	if (!mesh_db_read_prov_info(jnode, &prov))
-		return false;
-
-	caps = mesh_net_prov_caps_get(net);
-	if (!caps)
-		return false;
-
-	node = mesh_net_local_node_get(net);
-	if (!node)
-		return false;
-
-	caps->num_ele = node_get_num_elements(node);
-	l_put_le16(prov.algorithm, &caps->algorithms);
-	caps->pub_type = prov.pub_type;
-	caps->static_type = prov.static_type;
-	caps->output_size = prov.output_oob.size;
-	l_put_le16(prov.output_oob.actions, &caps->output_action);
-	caps->input_size = prov.input_oob.size;
-	l_put_le16(prov.input_oob.actions, &caps->input_action);
-
-	return mesh_net_priv_key_set(net, prov.priv_key);
-}
-
-static bool parse_config(struct mesh_net *net, const char *config_name,
-							bool unprovisioned)
+static bool parse_config(char *in_file, char *out_file, uint16_t node_id)
 {
 	int fd;
 	char *str;
-	const char *out;
 	struct stat st;
 	ssize_t sz;
 	json_object *jnode = NULL;
 	bool result = false;
+	struct mesh_node *node;
 
-	if (!config_name)
-		return false;
+	l_info("Loading configuration from %s", in_file);
 
-	fd = open(config_name, O_RDONLY);
+	fd = open(in_file, O_RDONLY);
 	if (!fd)
 		return false;
 
@@ -254,7 +199,7 @@ static bool parse_config(struct mesh_net *net, const char *config_name,
 
 	sz = read(fd, str, st.st_size);
 	if (sz != st.st_size) {
-		l_error("Failed to read configuration file");
+		l_error("Failed to read configuration file %s", in_file);
 		goto done;
 	}
 
@@ -262,22 +207,19 @@ static bool parse_config(struct mesh_net *net, const char *config_name,
 	if (!jnode)
 		goto done;
 
-	mesh_net_jconfig_set(net, jnode);
+	node = node_new();
 
-	if (!unprovisioned)
-		result = parse_local_node(net, jnode);
-	else
-		result = parse_unprovisioned_device(net, jnode);
+	node_jconfig_set(node, jnode);
+	node_cfg_file_set(node, out_file);
+	node_id_set(node, node_id);
+
+	result = parse_node(node, jnode);
 
 	if (!result) {
-		storage_release(net);
-		goto done;
+		json_object_put(jnode);
+		node_free(node);
 	}
 
-	mesh_net_cfg_file_get(net, &out);
-	if (!out)
-		mesh_net_cfg_file_set(net, !unprovisioned ?
-					config_name : NODE_CONGIGURATION_FILE);
 done:
 	close(fd);
 	if (str)
@@ -286,166 +228,70 @@ done:
 	return result;
 }
 
-bool storage_parse_config(struct mesh_net *net, const char *config_name)
+bool storage_set_ttl(json_object *jnode, uint8_t ttl)
 {
-	bool result = false;
-	bool unprovisioned = !config_name;
-
-	if (unprovisioned) {
-		result = parse_config(net, DEVICE_COMPOSITION_FILE, true);
-		goto done;
-	}
-
-	result = parse_config(net, config_name, false);
-
-	if (!result) {
-		size_t len = strlen(config_name) + 5;
-		char *bak = l_malloc(len);
-
-		/* Fall-back to Backup version */
-		strncpy(bak, config_name, len);
-		bak = strncat(bak, ".bak", 5);
-
-		remove(config_name);
-		rename(bak, config_name);
-
-		result = parse_config(net, config_name, false);
-
-		l_free(bak);
-	}
-
-	/* If configuration read fails, try as unprovisioned device */
-	if (!result) {
-		l_info("Parse configuration failed, trying unprovisioned");
-		unprovisioned = true;
-		result = parse_config(net, DEVICE_COMPOSITION_FILE, true);
-	}
-
-done:
-	if (result)
-		mesh_net_provisioned_set(net, !unprovisioned);
-
-	return result;
-}
-
-bool storage_local_set_ttl(struct mesh_net *net, uint8_t ttl)
-{
-	json_object *jnode;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
-
 	return mesh_db_write_int(jnode, "defaultTTL", ttl);
 }
 
-bool storage_local_set_relay(struct mesh_net *net, bool enable,
+bool storage_set_relay(json_object *jnode, bool enable,
 				uint8_t count, uint8_t interval)
 {
-	json_object *jnode;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
-
 	return mesh_db_write_relay_mode(jnode, enable, count, interval);
 }
 
-bool storage_local_set_transmit_params(struct mesh_net *net, uint8_t count,
+bool storage_set_transmit_params(json_object *jnode, uint8_t count,
 							uint8_t interval)
 {
-	json_object *jnode;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
-
 	return mesh_db_write_net_transmit(jnode, count, interval);
 }
 
-bool storage_local_set_mode(struct mesh_net *net, uint8_t mode,
+bool storage_set_mode(json_object *jnode, uint8_t mode,
 						const char *mode_name)
 {
-	json_object *jnode;
-
-	if (!net || !mode_name)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
-
 	return mesh_db_write_mode(jnode, mode_name, mode);
 }
 
-bool storage_model_bind(struct mesh_net *net, uint16_t addr, uint32_t mod_id,
+bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 				uint16_t app_idx, bool unbind)
 {
 	json_object *jnode;
-	bool is_local;
+	int ele_idx;
+	bool is_vendor = (mod_id > 0xffff);
 
-	if (!net)
+	ele_idx = node_get_element_idx(node, addr);
+	if (ele_idx < 0)
 		return false;
 
-	is_local = mesh_net_is_local_address(net, addr);
-	if (is_local) {
-		int ele_idx;
-		bool is_vendor = (mod_id > 0xffff);
-
-		ele_idx = node_get_element_idx(mesh_net_local_node_get(net),
-									addr);
-		if (ele_idx < 0)
-			return false;
-
-		jnode = mesh_net_jconfig_get(net);
-		if (!jnode)
-			return false;
-
-		if (unbind)
-			return mesh_db_model_binding_del(jnode, ele_idx,
-						is_vendor, mod_id, app_idx);
-		else
-			return mesh_db_model_binding_add(jnode, ele_idx,
-						is_vendor, mod_id, app_idx);
-	}
+	jnode = node_jconfig_get(node);
 
-	/* TODO: write remote node bindings to provisioner DB */
-	return false;
+	if (unbind)
+		return mesh_db_model_binding_del(jnode, ele_idx, is_vendor,
+							mod_id, app_idx);
+	else
+		return mesh_db_model_binding_add(jnode, ele_idx, is_vendor,
+							mod_id, app_idx);
 }
 
-bool storage_local_app_key_add(struct mesh_net *net, uint16_t net_idx,
+bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 			uint16_t app_idx, const uint8_t key[16], bool update)
 {
 	json_object *jnode;
+	struct mesh_node *node = mesh_net_node_get(net);
 
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
+	jnode = node_jconfig_get(node);
 	if (!jnode)
 		return false;
 
 	return mesh_db_app_key_add(jnode, net_idx, app_idx, key, update);
 }
 
-bool storage_local_app_key_del(struct mesh_net *net, uint16_t net_idx,
+bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 					uint16_t app_idx)
 {
 	json_object *jnode;
+	struct mesh_node *node = mesh_net_node_get(net);
 
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
+	jnode = node_jconfig_get(node);
 	if (!jnode)
 		return false;
 
@@ -453,116 +299,53 @@ bool storage_local_app_key_del(struct mesh_net *net, uint16_t net_idx,
 
 }
 
-bool storage_local_net_key_add(struct mesh_net *net, uint16_t net_idx,
+bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 					const uint8_t key[16], int phase)
 {
-	json_object *jnode;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
+	struct mesh_node *node = mesh_net_node_get(net);
+	json_object *jnode = node_jconfig_get(node);
 
 	return mesh_db_net_key_add(jnode, net_idx, key, phase);
 }
 
-bool storage_local_net_key_del(struct mesh_net *net, uint16_t net_idx)
+bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
 {
-	json_object *jnode;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
+	struct mesh_node *node = mesh_net_node_get(net);
+	json_object *jnode = node_jconfig_get(node);
 
 	return mesh_db_net_key_del(jnode, net_idx);
 }
 
-bool storage_local_set_iv_index(struct mesh_net *net, uint32_t iv_index,
+bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 								bool update)
 {
-	json_object *jnode;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
+	struct mesh_node *node = mesh_net_node_get(net);
+	json_object *jnode = node_jconfig_get(node);
 
 	return mesh_db_write_iv_index(jnode, iv_index, update);
 }
 
-bool storage_local_set_device_key(struct mesh_net *net, uint8_t dev_key[16])
-{
-	json_object *jnode;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
-
-	return mesh_db_write_device_key(jnode, dev_key);
-}
-
-bool storage_local_set_unicast(struct mesh_net *net, uint16_t unicast)
-{
-	json_object *jnode;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
-
-	return mesh_db_write_uint16_hex(jnode, "unicastAddress", unicast);
-}
-
-bool storage_local_write_sequence_number(struct mesh_net *net, uint32_t seq)
+bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 {
-	json_object *jnode;
-	const char *cfg_file;
+	struct mesh_node *node = mesh_net_node_get(net);
+	json_object *jnode = node_jconfig_get(node);
 	bool result;
-
-	if (!net)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
-
+	l_debug("");
 	result = mesh_db_write_int(jnode, "sequenceNumber", seq);
 	if (!result)
 		return false;
 
-	result = mesh_net_cfg_file_get(net, &cfg_file);
-	if (result && cfg_file)
-		result = storage_save_config(net, cfg_file, false, NULL, NULL);
+	result = storage_save_config(node, false, NULL, NULL);
 
 	return result;
 }
 
-static bool save_config(struct mesh_net *net, const char *config_name)
+static bool save_config(json_object *jnode, const char *config_name)
 {
 	FILE *outfile;
 	const char *str;
-	json_object *jnode;
 	bool result = false;
 
-	if (!net || !config_name)
-		return false;
-
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
-		return false;
-
 	outfile = fopen(config_name, "w");
 	if (!outfile) {
 		l_error("Failed to save configuration to %s", config_name);
@@ -581,13 +364,6 @@ static bool save_config(struct mesh_net *net, const char *config_name)
 	return result;
 }
 
-struct write_info {
-	const char *config_name;
-	struct mesh_net *net;
-	void *user_data;
-	mesh_status_func_t cb;
-};
-
 static void idle_save_config(void *user_data)
 {
 	struct write_info *info = user_data;
@@ -603,7 +379,7 @@ static void idle_save_config(void *user_data)
 	remove(tmp);
 
 	l_debug("Storage-Wrote");
-	result = save_config(info->net, tmp);
+	result = save_config(info->jnode, tmp);
 
 	if (result) {
 		remove(bak);
@@ -621,48 +397,199 @@ static void idle_save_config(void *user_data)
 	l_free(info);
 }
 
-bool storage_save_config(struct mesh_net *net, const char *config_name,
-			bool no_wait, mesh_status_func_t cb, void *user_data)
+bool storage_save_config(struct mesh_node *node, bool no_wait,
+					mesh_status_func_t cb, void *user_data)
 {
 	struct write_info *info;
 
 	info = l_new(struct write_info, 1);
 	if (!info)
 		return false;
-
-	info->net = net;
-	info->config_name = config_name;
+	l_debug("");
+	info->jnode = node_jconfig_get(node);
+	info->config_name = node_cfg_file_get(node);
 	info->cb = cb;
 	info->user_data = user_data;
 
 	if (no_wait)
 		idle_save_config(info);
-	l_idle_oneshot(idle_save_config, info, NULL);
+	else
+		l_idle_oneshot(idle_save_config, info, NULL);
 
 	return true;
 }
 
-bool storage_save_new_config(struct mesh_net *net, const char *config_name,
-					mesh_status_func_t cb, void *user_data)
+static int create_dir(const char *dirname)
 {
-	json_object *jnode;
+	struct stat st;
+	char dir[PATH_MAX + 1], *prev, *next;
+	int err;
 
-	jnode = mesh_net_jconfig_get(net);
-	if (!jnode)
+	err = stat(dirname, &st);
+	if (!err && S_ISREG(st.st_mode))
+		return 0;
+
+	memset(dir, 0, PATH_MAX + 1);
+	strcat(dir, "/");
+
+	prev = strchr(dirname, '/');
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
+	mkdir(dirname, 0755);
+
+	return 0;
+}
+
+bool storage_load_nodes(const char *dir_name)
+{
+	DIR *dir;
+	struct dirent *entry;
+
+	create_dir(dir_name);
+	dir = opendir(dir_name);
+	if (!dir) {
+		l_error("Failed to open mesh node storage directory: %s",
+								dir_name);
 		return false;
+	}
+
+	storage_dir = dir_name;
+	node_ids = l_queue_new();
+
+	while ((entry = readdir(dir)) != NULL) {
+		char name_buf[PATH_MAX];
+		char *filename;
+		uint32_t node_id;
+		size_t len;
+
+		if (entry->d_type != DT_DIR)
+			continue;
+
+		if (sscanf(entry->d_name, "%04x", &node_id) != 1)
+			continue;
+
+		snprintf(name_buf, PATH_MAX, "%s/%s/node.json", dir_name,
+								entry->d_name);
+
+		l_queue_push_tail(node_ids, L_UINT_TO_PTR(node_id));
+
+		len = strlen(name_buf);
+		filename = l_malloc(len + 1);
 
-	mesh_db_remove_property(jnode, "provision");
+		strncpy(filename, name_buf, len + 1);
 
-	return storage_save_config(net, config_name, false, cb, user_data);
+		if (parse_config(name_buf, filename, node_id))
+			continue;
+
+		/* Fall-back to Backup version */
+		snprintf(name_buf, PATH_MAX, "%s/%s/node.json.bak", dir_name,
+								entry->d_name);
+
+		if (parse_config(name_buf, filename, node_id)) {
+			remove(filename);
+			rename(name_buf, filename);
+			continue;
+		}
+
+		l_free(filename);
+	}
+
+	return true;
 }
 
-void storage_release(struct mesh_net *net)
+bool storage_create_node_config(struct mesh_node *node, void *data)
 {
+	struct mesh_db_node *db_node = data;
+	uint16_t node_id;
+	uint8_t num_tries = 0;
+	char name_buf[PATH_MAX];
+	char *filename;
 	json_object *jnode;
+	size_t len;
+
+	if (!storage_dir)
+		return false;
+
+	jnode = json_object_new_object();
+
+	if (!mesh_db_add_node(jnode, db_node))
+		return false;
+
+	do {
+		l_getrandom(&node_id, 2);
+		if (!l_queue_find(node_ids, simple_match,
+						L_UINT_TO_PTR(node_id)))
+			break;
+	} while (++num_tries < 10);
+
+	if (num_tries == 10)
+		l_error("Failed to generate unique node ID");
+
+	snprintf(name_buf, PATH_MAX, "%s/%04x", storage_dir, node_id);
+
+	/* Create a new directory and node.json file */
+	if (mkdir(name_buf, 0755) != 0)
+		goto fail;
 
-	jnode = mesh_net_jconfig_get(net);
+	len = strlen(name_buf) + strlen("/node.json") + 1;
+	filename = l_malloc(len);
+
+	snprintf(filename, len, "%s/node.json", name_buf);
+	l_debug("New node config %s", filename);
+
+	if (!save_config(jnode, filename)) {
+		l_free(filename);
+		goto fail;
+	}
+
+	node_jconfig_set(node, jnode);
+	node_cfg_file_set(node, filename);
+
+	return true;
+fail:
+	json_object_put(jnode);
+	return false;
+}
+
+/* Permanently remove node configuration */
+void storage_remove_node_config(struct mesh_node *node)
+{
+	char *cfgname;
+	struct json_object *jnode;
+	const char *dir_name;
+
+	jnode = node_jconfig_get(node);
 	if (jnode)
 		json_object_put(jnode);
+	node_jconfig_set(node, NULL);
+
+	cfgname = (char *) node_cfg_file_get(node);
+	if (!cfgname)
+		return;
+
+	l_debug("Delete node config file %s", cfgname);
+	remove(cfgname);
+
+	dir_name = dirname(cfgname);
+
+	l_debug("Delete directory %s", dir_name);
+	rmdir(dir_name);
 
-	mesh_net_jconfig_set(net, NULL);
+	l_free(cfgname);
+	node_cfg_file_set(node, NULL);
 }
diff --git a/mesh/storage.h b/mesh/storage.h
index 341932dba..91299f0a8 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -15,37 +15,35 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  *  Lesser General Public License for more details.
  *
- *
  */
 
 struct mesh_net;
+struct mesh_node;
 
-bool storage_parse_config(struct mesh_net *net, const char *config_name);
-bool storage_save_config(struct mesh_net *net, const char *config_name,
-			bool no_wait, mesh_status_func_t cb, void *user_data);
-bool storage_save_new_config(struct mesh_net *net, const char *config_name,
+bool storage_load_nodes(const char *dir);
+bool storage_create_node_config(struct mesh_node *node, void *db_node);
+void storage_remove_node_config(struct mesh_node *node);
+bool storage_save_config(struct mesh_node *node, bool no_wait,
 					mesh_status_func_t cb, void *user_data);
-void storage_release(struct mesh_net *net);
-
-bool storage_model_bind(struct mesh_net *net, uint16_t addr, uint32_t id,
+bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t id,
 						uint16_t app_idx, bool unbind);
 
-bool storage_local_set_ttl(struct mesh_net *net, uint8_t ttl);
-bool storage_local_set_relay(struct mesh_net *net, bool enable, uint8_t count,
+bool storage_set_ttl(json_object *jnode, uint8_t ttl);
+bool storage_set_relay(json_object *jnode, bool enable, uint8_t count,
 							uint8_t interval);
-bool storage_local_set_transmit_params(struct mesh_net *net, uint8_t count,
+bool storage_set_transmit_params(json_object *jnode, uint8_t count,
 							uint8_t interval);
-bool storage_local_set_mode(struct mesh_net *net, uint8_t mode,
+bool storage_set_mode(json_object *jnode, uint8_t mode,
 							const char *mode_name);
-bool storage_local_net_key_add(struct mesh_net *net, uint16_t net_idx,
+bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 					const uint8_t key[16], int phase);
-bool storage_local_net_key_del(struct mesh_net *net, uint16_t net_idx);
-bool storage_local_app_key_add(struct mesh_net *net, uint16_t net_idx,
+bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx);
+bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 			uint16_t app_idx, const uint8_t key[16], bool update);
-bool storage_local_app_key_del(struct mesh_net *net, uint16_t net_idx,
+bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 							uint16_t app_idx);
-bool storage_local_write_sequence_number(struct mesh_net *net, uint32_t seq);
-bool storage_local_set_iv_index(struct mesh_net *net, uint32_t iv_index,
+bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq);
+bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 								bool update);
-bool storage_local_set_device_key(struct mesh_net *net, uint8_t dev_key[16]);
-bool storage_local_set_unicast(struct mesh_net *net, uint16_t unicast);
+bool storage_set_device_key(struct mesh_node *node, uint8_t dev_key[16]);
+bool storage_set_unicast(struct mesh_node *node, uint16_t unicast);
-- 
2.14.5

