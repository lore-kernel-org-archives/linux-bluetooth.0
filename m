Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF93C73C6D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D26620844
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGJFKL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:28143 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfGJFKK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050355"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:09 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 9/9] mesh: Make storage.c json-c agnostic
Date:   Tue,  9 Jul 2019 22:09:59 -0700
Message-Id: <20190710050959.7321-10-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710050959.7321-1-inga.stotland@intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes all the references to json-c constructs from storage.c
All the storage operations are now interfacing through mesh-config APIs.
---
 mesh/storage.c | 122 ++++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/mesh/storage.c b/mesh/storage.c
index 721b65904..a4131404e 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -29,7 +29,6 @@
 #include <libgen.h>
 #include <ftw.h>
 
-#include <json-c/json.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
@@ -41,8 +40,8 @@
 #include "mesh/storage.h"
 
 struct write_info {
-	json_object *jnode;
-	const char *node_path;
+	void *node_cfg;
+	const char *node_dir;
 	void *user_data;
 	mesh_status_func_t cb;
 };
@@ -83,7 +82,7 @@ static bool read_app_keys_cb(uint16_t net_idx, uint16_t app_idx, uint8_t *key,
 	return appkey_key_init(net, net_idx, app_idx, key, new_key);
 }
 
-static bool parse_node(struct mesh_node *node, json_object *jnode)
+static bool parse_node(struct mesh_node *node, void *node_cfg)
 {
 	bool bvalue;
 	uint32_t iv_index;
@@ -92,30 +91,30 @@ static bool parse_node(struct mesh_node *node, json_object *jnode)
 	uint16_t interval;
 	struct mesh_net *net = node_get_net(node);
 
-	if (mesh_config_read_iv_index(jnode, &iv_index, &bvalue))
+	if (mesh_config_read_iv_index(node_cfg, &iv_index, &bvalue))
 		mesh_net_set_iv_index(net, iv_index, bvalue);
 
-	if (mesh_config_read_net_transmit(jnode, &cnt, &interval))
+	if (mesh_config_read_net_transmit(node_cfg, &cnt, &interval))
 		mesh_net_transmit_params_set(net, cnt, interval);
 
 	/* Node composition/configuration info */
-	if (!mesh_config_read_node(jnode, read_node_cb, node))
+	if (!mesh_config_read_node(node_cfg, read_node_cb, node))
 		return false;
 
-	if (!mesh_config_read_net_keys(jnode, read_net_keys_cb, net))
+	if (!mesh_config_read_net_keys(node_cfg, read_net_keys_cb, net))
 		return false;
 
-	if (!mesh_config_read_token(jnode, key_buf))
+	if (!mesh_config_read_token(node_cfg, key_buf))
 		return false;
 
 	node_set_token(node, key_buf);
 
-	if (!mesh_config_read_device_key(jnode, key_buf))
+	if (!mesh_config_read_device_key(node_cfg, key_buf))
 		return false;
 
 	node_set_device_key(node, key_buf);
 
-	mesh_config_read_app_keys(jnode, read_app_keys_cb, net);
+	mesh_config_read_app_keys(node_cfg, read_app_keys_cb, net);
 
 	return true;
 }
@@ -139,9 +138,9 @@ static struct mesh_node *parse_config(void *node_cfg,  const uint8_t uuid[16])
 
 bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 {
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 
-	if (!mesh_config_write_int(jnode, "defaultTTL", ttl))
+	if (!mesh_config_write_int(node_cfg, "defaultTTL", ttl))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -151,9 +150,9 @@ bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
 bool storage_set_relay(struct mesh_node *node, bool enable,
 				uint8_t count, uint8_t interval)
 {
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 
-	if (!mesh_config_write_relay_mode(jnode, enable, count, interval))
+	if (!mesh_config_write_relay_mode(node_cfg, enable, count, interval))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -163,9 +162,9 @@ bool storage_set_relay(struct mesh_node *node, bool enable,
 bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 							uint8_t interval)
 {
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 
-	if (!mesh_config_write_net_transmit(jnode, count, interval))
+	if (!mesh_config_write_net_transmit(node_cfg, count, interval))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -175,9 +174,9 @@ bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
 bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 						const char *mode_name)
 {
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 
-	if (!mesh_config_write_mode(jnode, mode_name, mode))
+	if (!mesh_config_write_mode(node_cfg, mode_name, mode))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -187,7 +186,7 @@ bool storage_set_mode(struct mesh_node *node, uint8_t mode,
 bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 				uint16_t app_idx, bool unbind)
 {
-	json_object *jnode;
+	void *node_cfg;
 	int ele_idx;
 	bool stored, is_vendor = (mod_id > 0xffff);
 
@@ -195,13 +194,13 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 	if (ele_idx < 0)
 		return false;
 
-	jnode = node_config_get(node);
+	node_cfg = node_config_get(node);
 
 	if (unbind)
-		stored = mesh_config_model_binding_del(jnode, ele_idx,
+		stored = mesh_config_model_binding_del(node_cfg, ele_idx,
 						is_vendor, mod_id, app_idx);
 	else
-		stored = mesh_config_model_binding_add(jnode, ele_idx,
+		stored = mesh_config_model_binding_add(node_cfg, ele_idx,
 						is_vendor, mod_id, app_idx);
 
 	if (stored)
@@ -213,18 +212,19 @@ bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
 bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 			uint16_t app_idx, const uint8_t key[16], bool update)
 {
-	json_object *jnode;
+	void *node_cfg;
 	struct mesh_node *node = mesh_net_node_get(net);
 	bool stored;
 
-	jnode = node_config_get(node);
-	if (!jnode)
+	node_cfg = node_config_get(node);
+	if (!node_cfg)
 		return false;
 
 	if (update)
-		stored = mesh_config_app_key_update(jnode, app_idx, key);
+		stored = mesh_config_app_key_update(node_cfg, app_idx, key);
 	else
-		stored = mesh_config_app_key_add(jnode, net_idx, app_idx, key);
+		stored = mesh_config_app_key_add(node_cfg, net_idx, app_idx,
+									key);
 
 	if (stored)
 		storage_save_config(node, true, NULL, NULL);
@@ -235,14 +235,14 @@ bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 					uint16_t app_idx)
 {
-	json_object *jnode;
+	void *node_cfg;
 	struct mesh_node *node = mesh_net_node_get(net);
 
-	jnode = node_config_get(node);
-	if (!jnode)
+	node_cfg = node_config_get(node);
+	if (!node_cfg)
 		return false;
 
-	if (!mesh_config_app_key_del(jnode, net_idx, app_idx))
+	if (!mesh_config_app_key_del(node_cfg, net_idx, app_idx))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -253,13 +253,13 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 					const uint8_t key[16], bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 	bool stored;
 
 	if (!update)
-		stored = mesh_config_net_key_add(jnode, net_idx, key);
+		stored = mesh_config_net_key_add(node_cfg, net_idx, key);
 	else
-		stored = mesh_config_net_key_update(jnode, net_idx, key);
+		stored = mesh_config_net_key_update(node_cfg, net_idx, key);
 
 	if (stored)
 		storage_save_config(node, true, NULL, NULL);
@@ -270,9 +270,9 @@ bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
 bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 
-	if (!mesh_config_net_key_del(jnode, net_idx))
+	if (!mesh_config_net_key_del(node_cfg, net_idx))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -283,9 +283,9 @@ bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
 								bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 
-	if (!mesh_config_write_iv_index(jnode, iv_index, update))
+	if (!mesh_config_write_iv_index(node_cfg, iv_index, update))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -296,9 +296,9 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 								uint8_t phase)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 
-	if (!mesh_config_net_key_set_phase(jnode, net_idx, phase))
+	if (!mesh_config_net_key_set_phase(node_cfg, net_idx, phase))
 		return false;
 
 	storage_save_config(node, true, NULL, NULL);
@@ -308,9 +308,9 @@ bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
 bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
-	json_object *jnode = node_config_get(node);
+	void *node_cfg = node_config_get(node);
 
-	if (!mesh_config_write_int(jnode, "sequenceNumber", seq))
+	if (!mesh_config_write_int(node_cfg, "sequenceNumber", seq))
 		return false;
 
 	storage_save_config(node, false, NULL, NULL);
@@ -323,7 +323,7 @@ static void idle_save_config(void *user_data)
 	bool result;
 
 	l_debug("Storage-Wrote");
-	result = mesh_config_save_config(info->node_path, info->jnode);
+	result = mesh_config_save_config(info->node_dir, info->node_cfg);
 
 	if (info->cb)
 		info->cb(info->user_data, result);
@@ -337,8 +337,8 @@ void storage_save_config(struct mesh_node *node, bool no_wait,
 	struct write_info *info;
 
 	info = l_new(struct write_info, 1);
-	info->jnode = node_config_get(node);
-	info->node_path = node_path_get(node);
+	info->node_cfg = node_config_get(node);
+	info->node_dir = node_path_get(node);
 	info->cb = cb;
 	info->user_data = user_data;
 
@@ -471,33 +471,33 @@ static int del_fobject(const char *fpath, const struct stat *sb, int typeflag,
 /* Permanently remove node configuration */
 void storage_remove_node_config(struct mesh_node *node)
 {
-	char *node_path, *node_name;
+	char *node_dir, *node_name;
 	char uuid[33];
-	struct json_object *jnode;
+	void *node_cfg;
 
 	if (!node)
 		return;
 
 	/* Free the node config json object */
-	jnode = node_config_get(node);
-	if (jnode)
-		mesh_config_release_config(jnode);
+	node_cfg = node_config_get(node);
+	if (node_cfg)
+		mesh_config_release_config(node_cfg);
 
 	node_config_set(node, NULL);
 
-	node_path = node_path_get(node);
-	l_debug("Delete node config %s", node_path);
+	node_dir = node_path_get(node);
+	l_debug("Delete node config %s", node_dir);
 
 	/* Make sure path name of node follows expected guidelines */
 	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
 		return;
 
-	node_name = basename(node_path);
+	node_name = basename(node_dir);
 
 	if (strcmp(node_name, uuid))
 		return;
 
-	nftw(node_path, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
+	nftw(node_dir, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
 }
 
 bool storage_create_node_config(struct mesh_node *node, void *data)
@@ -505,14 +505,14 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	struct mesh_config_node *db_node = data;
 	char uuid[33];
 	char node_dir[PATH_MAX];
-	json_object *jnode;
+	void *node_cfg;
 
 	if (!storage_dir)
 		return false;
 
-	jnode = mesh_config_create_config();
+	node_cfg = mesh_config_create_config();
 
-	if (!jnode || !mesh_config_add_node(jnode, db_node))
+	if (!node_cfg || !mesh_config_add_node(node_cfg, db_node))
 		return false;
 
 	if (!hex2str(node_uuid_get(node), 16, uuid, sizeof(uuid)))
@@ -527,18 +527,18 @@ bool storage_create_node_config(struct mesh_node *node, void *data)
 	if (mkdir(node_dir, 0755) != 0)
 		goto fail;
 
-	if (!mesh_config_save_config(node_dir, jnode)) {
+	if (!mesh_config_save_config(node_dir, node_cfg)) {
 		nftw(node_dir, del_fobject, 5, FTW_DEPTH | FTW_PHYS);
 		goto fail;
 	}
 
 	l_debug("New node config %s", node_dir);
 	node_path_set(node, node_dir);
-	node_config_set(node, jnode);
+	node_config_set(node, node_cfg);
 
 	return true;
 fail:
-	mesh_config_release_config(jnode);
+	mesh_config_release_config(node_cfg);
 	node_config_set(node, NULL);
 
 	return false;
-- 
2.21.0

