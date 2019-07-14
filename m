Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A2C74A4B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E6920C01
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 23:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfGNXXd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 19:23:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:39750 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbfGNXXd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 19:23:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2019 16:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,492,1557212400"; 
   d="scan'208";a="168805654"
Received: from rreichel-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.24.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2019 16:23:31 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 07/10 v3] mesh: Use mesh_config APIs to store node configuration
Date:   Sun, 14 Jul 2019 16:23:17 -0700
Message-Id: <20190714232320.20921-8-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714232320.20921-1-inga.stotland@intel.com>
References: <20190714232320.20921-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This eliminates storage_set...() routines as an intermediate
layer between mesh_config layer and the rest of the daemon when
storing updated node configuration values.
For the JSON based implementation, each call to mesh_config_write...()
routines results in writing to the node configuration file.
---
 mesh/appkey.c           |  19 +++-
 mesh/cfgmod-server.c    |   4 +-
 mesh/mesh-config-json.c | 203 +++++++++++++++++++---------------------
 mesh/mesh-config.h      |  11 +--
 mesh/model.c            |  15 ++-
 mesh/net.c              |  26 +++--
 mesh/node.c             |  23 ++---
 mesh/storage.c          | 170 ---------------------------------
 mesh/storage.h          |  24 -----
 9 files changed, 155 insertions(+), 340 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 412a2c48c..286a77e98 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -31,7 +31,7 @@
 #include "mesh/crypto.h"
 #include "mesh/util.h"
 #include "mesh/model.h"
-#include "mesh/storage.h"
+#include "mesh/mesh-config.h"
 #include "mesh/appkey.h"
 
 struct mesh_app_key {
@@ -368,6 +368,7 @@ int appkey_key_update(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 	struct mesh_app_key *key;
 	struct l_queue *app_keys;
 	uint8_t phase = KEY_REFRESH_PHASE_NONE;
+	struct mesh_node *node;
 
 	app_keys = mesh_net_get_app_keys(net);
 	if (!app_keys)
@@ -395,7 +396,10 @@ int appkey_key_update(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 	if (!set_key(key, app_idx, new_key, true))
 		return MESH_STATUS_INSUFF_RESOURCES;
 
-	if (!storage_app_key_add(net, net_idx, app_idx, new_key, true))
+	node = mesh_net_node_get(net);
+
+	if (!mesh_config_app_key_update(node_config_get(node), app_idx,
+								new_key))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	return MESH_STATUS_SUCCESS;
@@ -406,6 +410,7 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 {
 	struct mesh_app_key *key;
 	struct l_queue *app_keys;
+	struct mesh_node *node;
 
 	app_keys = mesh_net_get_app_keys(net);
 	if (!app_keys)
@@ -432,7 +437,10 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 		return MESH_STATUS_INSUFF_RESOURCES;
 	}
 
-	if (!storage_app_key_add(net, net_idx, app_idx, new_key, false)) {
+	node = mesh_net_node_get(net);
+
+	if (!mesh_config_app_key_add(node_config_get(node), net_idx, app_idx,
+								new_key)) {
 		appkey_key_free(key);
 		return MESH_STATUS_STORAGE_FAIL;
 	}
@@ -451,6 +459,7 @@ int appkey_key_delete(struct mesh_net *net, uint16_t net_idx,
 {
 	struct mesh_app_key *key;
 	struct l_queue *app_keys;
+	struct mesh_node *node;
 
 	app_keys = mesh_net_get_app_keys(net);
 	if (!app_keys)
@@ -469,7 +478,9 @@ int appkey_key_delete(struct mesh_net *net, uint16_t net_idx,
 	l_queue_remove(app_keys, key);
 	appkey_key_free(key);
 
-	if (!storage_app_key_del(net, net_idx, app_idx))
+	node = mesh_net_node_get(net);
+
+	if (!mesh_config_app_key_del(node_config_get(node), net_idx, app_idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	return MESH_STATUS_SUCCESS;
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index c73e63b4e..033ab41ea 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -876,7 +876,9 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 		count = (pkt[0] >> 5) + 1;
 		interval = ((pkt[0] & 0x1f) + 1) * 10;
-		if (storage_set_transmit_params(node, count, interval))
+
+		if (mesh_config_write_net_transmit(node_config_get(node), count,
+								interval))
 			mesh_net_transmit_params_set(net, count, interval);
 		/* Fall Through */
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 57b0d6e7b..62c674afd 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -55,6 +55,30 @@ struct write_info {
 static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
 
+static bool save_config(json_object *jnode, const char *fname)
+{
+	FILE *outfile;
+	const char *str;
+	bool result = false;
+
+	outfile = fopen(fname, "w");
+	if (!outfile) {
+		l_error("Failed to save configuration to %s", fname);
+		return false;
+	}
+
+	str = json_object_to_json_string_ext(jnode, JSON_C_TO_STRING_PRETTY);
+
+	if (fwrite(str, sizeof(char), strlen(str), outfile) < strlen(str))
+		l_warn("Incomplete write of mesh configuration");
+	else
+		result = true;
+
+	fclose(outfile);
+
+	return result;
+}
+
 static bool get_int(json_object *jobj, const char *keyword, int *value)
 {
 	json_object *jvalue;
@@ -511,7 +535,8 @@ bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t idx,
 
 	json_object_array_add(jarray, jentry);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
+
 fail:
 	if (jentry)
 		json_object_put(jentry);
@@ -552,7 +577,7 @@ bool mesh_config_net_key_update(struct mesh_config *cfg, uint16_t idx,
 	json_object_object_add(jentry, "keyRefresh",
 				json_object_new_int(KEY_REFRESH_PHASE_ONE));
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
@@ -564,6 +589,7 @@ bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 
 	jnode = cfg->jnode;
 
+	/* TODO: Decide if we treat this as an error: no network keys??? */
 	if (!json_object_object_get_ex(jnode, "netKeys", &jarray))
 		return true;
 
@@ -573,7 +599,9 @@ bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 
 	if (json_object_array_length(jarray) == 1) {
 		json_object_object_del(jnode, "netKeys");
-		return true;
+		/* TODO: Do we raise an error here? */
+		l_warn("Removing the last network key! Zero keys left.");
+		return save_config(jnode, cfg->node_path);
 	}
 
 	/*
@@ -588,23 +616,23 @@ bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 	json_object_object_del(jnode, "netKeys");
 	json_object_object_add(jnode, "netKeys", jarray_new);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 bool mesh_config_write_device_key(struct mesh_config *cfg, uint8_t *key)
 {
-	if (!cfg)
+	if (!cfg || !add_key_value(cfg->jnode, "deviceKey", key))
 		return false;
 
-	return add_key_value(cfg->jnode, "deviceKey", key);
+	return save_config(cfg->jnode, cfg->node_path);
 }
 
 bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token)
 {
-	if (!cfg)
+	if (!cfg || !add_u64_value(cfg->jnode, "token", token))
 		return false;
 
-	return add_u64_value(cfg->jnode, "token", token);
+	return save_config(cfg->jnode, cfg->node_path);
 }
 
 bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
@@ -656,7 +684,8 @@ bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 
 	json_object_array_add(jarray, jentry);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
+
 fail:
 
 	if (jentry)
@@ -690,9 +719,14 @@ bool mesh_config_app_key_update(struct mesh_config *cfg, uint16_t app_idx,
 	str = json_object_get_string(jstring);
 	jstring = json_object_new_string(str);
 	json_object_object_add(jentry, "oldKey", jstring);
+
 	json_object_object_del(jentry, "key");
 
-	return add_key_value(jentry, "key", key);
+	/* TODO: "Rewind" if add_key_value fails */
+	if (!add_key_value(jentry, "key", key))
+		return false;
+
+	return save_config(jnode, cfg->node_path);
 }
 
 bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
@@ -729,7 +763,7 @@ bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
 	json_object_object_del(jnode, "appKeys");
 	json_object_object_add(jnode, "appKeys", jarray_new);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint8_t ele_idx,
@@ -769,7 +803,7 @@ bool mesh_config_model_binding_add(struct mesh_config *cfg, uint8_t ele_idx,
 
 	json_object_array_add(jarray, jstring);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 bool mesh_config_model_binding_del(struct mesh_config *cfg, uint8_t ele_idx,
@@ -813,7 +847,7 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint8_t ele_idx,
 	json_object_object_del(jmodel, "bind");
 	json_object_object_add(jmodel, "bind", jarray_new);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 static void free_model(void *data)
@@ -1345,22 +1379,12 @@ static bool write_uint16_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_config_write_uint16_hex(struct mesh_config *cfg, const char *desc,
-								uint16_t value)
-{
-	if (!cfg)
-		return false;
-
-	return write_uint16_hex(cfg->jnode, desc, value);
-}
-
-static bool write_uint32_hex(json_object *jobj, const char *desc,
-								uint32_t value)
+static bool write_uint32_hex(json_object *jobj, const char *desc, uint32_t val)
 {
 	json_object *jstring;
 	char buf[9];
 
-	snprintf(buf, 9, "%8.8x", value);
+	snprintf(buf, 9, "%8.8x", val);
 	jstring = json_object_new_string(buf);
 	if (!jstring)
 		return false;
@@ -1369,22 +1393,13 @@ static bool write_uint32_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_config_write_uint32_hex(struct mesh_config *cfg, const char *desc,
-								uint32_t value)
-{
-	if (!cfg)
-		return false;
-
-	return write_uint32_hex(cfg->jnode, desc, value);
-}
-
-static bool write_int(json_object *jobj, const char *keyword, int value)
+static bool write_int(json_object *jobj, const char *keyword, int val)
 {
 	json_object *jvalue;
 
 	json_object_object_del(jobj, keyword);
 
-	jvalue = json_object_new_int(value);
+	jvalue = json_object_new_int(val);
 	if (!jvalue)
 		return false;
 
@@ -1392,35 +1407,6 @@ static bool write_int(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_config_write_int(struct mesh_config *cfg, const char *keyword,
-								int value)
-{
-	if (!cfg)
-		return false;
-
-	return write_int(cfg->jnode, keyword, value);
-}
-
-bool mesh_config_write_bool(struct mesh_config *cfg, const char *keyword,
-								bool value)
-{
-	json_object *jnode, *jvalue;
-
-	if (!cfg)
-		return false;
-
-	jnode = cfg->jnode;
-
-	json_object_object_del(jnode, keyword);
-
-	jvalue = json_object_new_boolean(value);
-	if (!jvalue)
-		return false;
-
-	json_object_object_add(jnode, keyword, jvalue);
-	return true;
-}
-
 static const char *mode_to_string(int mode)
 {
 	switch (mode) {
@@ -1450,10 +1436,10 @@ static bool write_mode(json_object *jobj, const char *keyword, int value)
 bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value)
 {
-	if (!cfg)
+	if (!cfg || !write_mode(cfg->jnode, keyword, value))
 		return false;
 
-	return write_mode(cfg->jnode, keyword, value);
+	return save_config(cfg->jnode, cfg->node_path);
 }
 
 static bool write_relay_mode(json_object *jobj, uint8_t mode,
@@ -1484,14 +1470,22 @@ fail:
 	return false;
 }
 
+bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast)
+{
+	if (!cfg || !write_uint16_hex(cfg->jnode, "unicastAddress", unicast))
+		return false;
+
+	return save_config(cfg->jnode, cfg->node_path);
+}
+
 bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 					uint8_t count, uint16_t interval)
 {
 
-	if (!cfg)
+	if (!cfg || !write_relay_mode(cfg->jnode, mode, count, interval))
 		return false;
 
-	return write_relay_mode(cfg->jnode, mode, count, interval);
+	return save_config(cfg->jnode, cfg->node_path);
 }
 
 bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
@@ -1501,9 +1495,8 @@ bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 
 	if (!cfg)
 		return false;
-	jnode = cfg->jnode;
 
-	json_object_object_del(jnode, "retransmit");
+	jnode = cfg->jnode;
 
 	jretransmit = json_object_new_object();
 	if (jretransmit)
@@ -1515,9 +1508,11 @@ bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 	if (!write_int(jretransmit, "interval", interval))
 		goto fail;
 
+	json_object_object_del(jnode, "retransmit");
 	json_object_object_add(jnode, "retransmit", jretransmit);
 
-	return true;
+	return save_config(cfg->jnode, cfg->node_path);
+
 fail:
 	json_object_put(jretransmit);
 	return false;
@@ -1541,7 +1536,7 @@ bool mesh_config_write_iv_index(struct mesh_config *cfg, uint32_t idx,
 	if (!write_int(jnode, "IVupdate", tmp))
 		return false;
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 static void add_model(void *a, void *b)
@@ -1719,7 +1714,7 @@ bool mesh_config_net_key_set_phase(struct mesh_config *cfg, uint16_t idx,
 		finish_key_refresh(jnode, idx);
 	}
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t addr,
@@ -1783,7 +1778,8 @@ bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t addr,
 	json_object_object_add(jpub, "retransmit", jretransmit);
 	json_object_object_add(jmodel, "publish", jpub);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
+
 fail:
 	json_object_put(jpub);
 	return false;
@@ -1811,11 +1807,11 @@ static bool delete_model_property(json_object *jnode, uint16_t addr,
 bool mesh_config_model_pub_del(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor)
 {
-	if (!cfg)
+	if (!cfg || !delete_model_property(cfg->jnode, addr, mod_id, vendor,
+								"publish"))
 		return false;
 
-	return delete_model_property(cfg->jnode, addr, mod_id, vendor,
-								"publish");
+	return save_config(cfg->jnode, cfg->node_path);
 }
 
 bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t addr,
@@ -1866,7 +1862,7 @@ bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t addr,
 
 	json_object_array_add(jarray, jstring);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t addr,
@@ -1921,17 +1917,34 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t addr,
 	json_object_object_del(jmodel, "subscribe");
 	json_object_object_add(jmodel, "subscribe", jarray_new);
 
-	return true;
+	return save_config(jnode, cfg->node_path);
 }
 
 bool mesh_config_model_sub_del_all(struct mesh_config *cfg, uint16_t addr,
 						uint32_t mod_id, bool vendor)
 {
-	if (!cfg)
+	if (!cfg || !delete_model_property(cfg->jnode, addr, mod_id, vendor,
+								"subscribe"))
 		return false;
 
-	return delete_model_property(cfg->jnode, addr, mod_id, vendor,
-								"subscribe");
+	return save_config(cfg->jnode, cfg->node_path);
+}
+
+bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq)
+{
+	if (!cfg || !write_int(cfg->jnode, "sequenceNumber", seq))
+		return false;
+
+	mesh_config_save_config(cfg, false, NULL, NULL);
+	return true;
+}
+
+bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl)
+{
+	if (!cfg || !write_int(cfg->jnode, "defaultTTL", ttl))
+		return false;
+
+	return save_config(cfg->jnode, cfg->node_path);
 }
 
 bool mesh_config_load_node(const char *cfg_path, const uint8_t uuid[16],
@@ -2020,30 +2033,6 @@ void mesh_config_release(struct mesh_config *cfg)
 	l_free(cfg);
 }
 
-static bool save_config(json_object *jnode, const char *fname)
-{
-	FILE *outfile;
-	const char *str;
-	bool result = false;
-
-	outfile = fopen(fname, "w");
-	if (!outfile) {
-		l_error("Failed to save configuration to %s", fname);
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
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 5241dde2d..83ba33bf9 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -127,16 +127,11 @@ bool mesh_config_write_network_key(struct mesh_config *cfg, uint16_t idx,
 				uint8_t *key, uint8_t *new_key, int phase);
 bool mesh_config_write_app_key(struct mesh_config *cfg, uint16_t net_idx,
 			uint16_t app_idx, uint8_t *key, uint8_t *new_key);
-bool mesh_config_write_int(struct mesh_config *cfg,
-						const char *keyword, int value);
-bool mesh_config_write_uint16_hex(struct mesh_config *cfg, const char *desc,
-								uint16_t value);
-bool mesh_config_write_uint32_hex(struct mesh_config *cfg, const char *desc,
-								uint32_t value);
-bool mesh_config_write_bool(struct mesh_config *cfg, const char *keyword,
-								bool value);
+bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq);
+bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast);
 bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 					uint8_t count, uint16_t interval);
+bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl);
 bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value);
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint8_t ele_idx,
diff --git a/mesh/model.c b/mesh/model.c
index 0f10727b4..ef62a223a 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -532,7 +532,8 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 {
 	int status;
 	struct mesh_model *mod;
-	bool is_present;
+	bool is_present, is_vendor;
+	uint8_t ele_idx;
 
 	mod = find_model(node, addr, id, &status);
 	if (!mod) {
@@ -540,7 +541,8 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 		return status;
 	}
 
-	id = (id >= VENDOR_ID_MASK) ? (id & 0xffff) : id;
+	is_vendor = id < VENDOR_ID_MASK && id > 0xffff;
+	id = !is_vendor ? (id & 0xffff) : id;
 
 	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
 		return MESH_STATUS_INVALID_MODEL;
@@ -556,10 +558,12 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (is_present && !unbind)
 		return MESH_STATUS_SUCCESS;
 
+	ele_idx = (uint8_t) node_get_element_idx(node, addr);
+
 	if (unbind) {
 		model_unbind_idx(node, mod, app_idx);
-
-		if (!storage_model_bind(node, addr, id, app_idx, true))
+		if (!mesh_config_model_binding_del(node_config_get(node),
+					ele_idx, is_vendor, id, app_idx))
 			return MESH_STATUS_STORAGE_FAIL;
 
 		return MESH_STATUS_SUCCESS;
@@ -568,7 +572,8 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (l_queue_length(mod->bindings) >= MAX_BINDINGS)
 		return MESH_STATUS_INSUFF_RESOURCES;
 
-	if (!storage_model_bind(node, addr, id, app_idx, false))
+	if (!mesh_config_model_binding_add(node_config_get(node),
+					ele_idx, is_vendor, id, app_idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	model_bind_idx(node, mod, app_idx);
diff --git a/mesh/net.c b/mesh/net.c
index a5693f154..f7f37675b 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -33,7 +33,7 @@
 #include "mesh/net.h"
 #include "mesh/mesh-io.h"
 #include "mesh/friend.h"
-#include "mesh/storage.h"
+#include "mesh/mesh-config.h"
 #include "mesh/model.h"
 #include "mesh/appkey.h"
 
@@ -971,7 +971,7 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	l_queue_remove(net->subnets, subnet);
 	subnet_free(subnet);
 
-	if (!storage_net_key_del(net, idx))
+	if (!mesh_config_net_key_del(node_config_get(net->node), idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	return MESH_STATUS_SUCCESS;
@@ -1024,7 +1024,7 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 	if (!subnet)
 		return MESH_STATUS_INSUFF_RESOURCES;
 
-	if (!storage_net_key_add(net, idx, value, false)) {
+	if (!mesh_config_net_key_add(node_config_get(net->node), idx, value)) {
 		l_queue_remove(net->subnets, subnet);
 		subnet_free(subnet);
 		return MESH_STATUS_STORAGE_FAIL;
@@ -2662,7 +2662,8 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	else
 		l_queue_foreach(net->friends, frnd_kr_phase2, net);
 
-	storage_set_key_refresh_phase(net, idx, KEY_REFRESH_PHASE_TWO);
+	mesh_config_net_key_set_phase(node_config_get(net->node), idx,
+						KEY_REFRESH_PHASE_TWO);
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -2697,7 +2698,8 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	else
 		l_queue_foreach(net->friends, frnd_kr_phase3, net);
 
-	storage_set_key_refresh_phase(net, idx, KEY_REFRESH_PHASE_NONE);
+	mesh_config_net_key_set_phase(node_config_get(net->node), idx,
+							KEY_REFRESH_PHASE_NONE);
 
 	return MESH_STATUS_SUCCESS;
 }
@@ -2749,7 +2751,8 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 			net->iv_upd_state = IV_UPD_NORMAL;
 		}
 
-		storage_set_iv_index(net, iv_index, net->iv_upd_state);
+		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
+							net->iv_upd_state);
 
 		/* Figure out the key refresh phase */
 		if (kr_transition) {
@@ -2771,7 +2774,8 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 		net->iv_upd_state = IV_UPD_UPDATING;
 		net->iv_update_timeout = l_timeout_create(IV_IDX_UPD_MIN,
 							iv_upd_to, net, NULL);
-		storage_set_iv_index(net, iv_index, net->iv_upd_state);
+		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
+							net->iv_upd_state);
 	} else if (iv_update && iv_index != net->iv_index) {
 		l_error("Update attempted too soon (iv idx already updated)");
 		return;
@@ -2784,7 +2788,8 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 	if (iv_index > net->iv_index) {
 		l_queue_clear(net->msg_cache, mesh_msg_free);
 		net->iv_index = iv_index;
-		storage_set_iv_index(net, iv_index, net->iv_upd_state);
+		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
+							net->iv_upd_state);
 	}
 
 	/* Figure out the key refresh phase */
@@ -3122,7 +3127,8 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 	mesh_net_flush_msg_queues(net);
 	net->iv_upd_state = IV_UPD_UPDATING;
 	net->iv_index++;
-	if (!storage_set_iv_index(net, net->iv_index, IV_UPD_UPDATING))
+	if (!mesh_config_write_iv_index(node_config_get(net->node),
+					net->iv_index, IV_UPD_UPDATING))
 		return false;
 
 	l_queue_foreach(net->subnets, set_network_beacon, net);
@@ -3739,7 +3745,7 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 
 	l_info("key refresh phase 1: Key ID %d", subnet->net_key_upd);
 
-	if (!storage_net_key_add(net, idx, value, true))
+	if (!mesh_config_net_key_update(node_config_get(net->node), idx, value))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	subnet->kr_phase = KEY_REFRESH_PHASE_ONE;
diff --git a/mesh/node.c b/mesh/node.c
index 5f4f95cc4..d90ca2ad1 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -487,7 +487,8 @@ static void cleanup_node(void *data)
 	if (node->cfg) {
 
 		/* Preserve the last sequence number */
-		storage_write_sequence_number(net, mesh_net_get_seq_num(net));
+		mesh_config_write_seq_number(node->cfg,
+						mesh_net_get_seq_num(net));
 
 		mesh_config_save_config(node->cfg, true, NULL, NULL);
 	}
@@ -532,7 +533,8 @@ bool node_app_key_delete(struct mesh_net *net, uint16_t addr,
 
 		mesh_model_app_key_delete(node, ele->models, app_idx);
 	}
-	return true;
+
+	return mesh_config_app_key_del(node->cfg, net_idx, app_idx);
 }
 
 uint16_t node_get_primary(struct mesh_node *node)
@@ -613,7 +615,7 @@ bool node_default_ttl_set(struct mesh_node *node, uint8_t ttl)
 	if (!node)
 		return false;
 
-	res = storage_set_ttl(node, ttl);
+	res = mesh_config_write_ttl(node->cfg, ttl);
 
 	if (res) {
 		node->ttl = ttl;
@@ -660,7 +662,7 @@ bool node_set_sequence_number(struct mesh_node *node, uint32_t seq)
 
 	node->upd_sec = write_time.tv_sec;
 
-	return storage_write_sequence_number(node->net, seq);
+	return mesh_config_write_seq_number(node->cfg, seq);
 }
 
 uint32_t node_get_sequence_number(struct mesh_node *node)
@@ -737,7 +739,7 @@ bool node_relay_mode_set(struct mesh_node *node, bool enable, uint8_t cnt,
 	if (!node || node->relay.mode == MESH_MODE_UNSUPPORTED)
 		return false;
 
-	res = storage_set_relay(node, enable, cnt, interval);
+	res = mesh_config_write_relay_mode(node->cfg, enable, cnt, interval);
 
 	if (res) {
 		node->relay.mode = enable ? MESH_MODE_ENABLED :
@@ -759,7 +761,7 @@ bool node_proxy_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	proxy = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node, proxy, "proxy");
+	res = mesh_config_write_mode(node->cfg, "proxy", proxy);
 
 	if (res) {
 		node->proxy = proxy;
@@ -786,7 +788,7 @@ bool node_beacon_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	beacon = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node, beacon, "beacon");
+	res = mesh_config_write_mode(node->cfg, "beacon", beacon);
 
 	if (res) {
 		node->beacon = beacon;
@@ -813,7 +815,7 @@ bool node_friend_mode_set(struct mesh_node *node, bool enable)
 		return false;
 
 	friend = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
-	res = storage_set_mode(node, friend, "friend");
+	res = mesh_config_write_mode(node->cfg, "friend", friend);
 
 	if (res) {
 		node->friend = friend;
@@ -1466,13 +1468,12 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 
 	l_queue_push_tail(nodes, node);
 
-	if (!storage_set_iv_index(node->net, iv_idx, ivu))
+	if (!mesh_config_write_iv_index(node->cfg, iv_idx, ivu))
 		return false;
 
 	mesh_net_set_iv_index(node->net, iv_idx, ivu);
 
-	if (!mesh_config_write_uint16_hex(node->cfg, "unicastAddress",
-								unicast))
+	if (!mesh_config_write_unicast(node->cfg, unicast))
 		return false;
 
 	l_getrandom(node->token, sizeof(node->token));
diff --git a/mesh/storage.c b/mesh/storage.c
index 15077cb5d..6a8766257 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -75,176 +75,6 @@ static bool parse_config(char *in_file, char *out_dir, const uint8_t uuid[16])
 	return result;
 }
 
-bool storage_set_ttl(struct mesh_node *node, uint8_t ttl)
-{
-	if (!mesh_config_write_int(node_config_get(node), "defaultTTL", ttl))
-		return false;
-
-	mesh_config_save_config(node_config_get(node), true, NULL, NULL);
-	return true;
-}
-
-bool storage_set_relay(struct mesh_node *node, bool enable,
-				uint8_t count, uint8_t interval)
-{
-	if (!mesh_config_write_relay_mode(node_config_get(node), enable, count,
-								interval))
-		return false;
-
-	mesh_config_save_config(node_config_get(node), true, NULL, NULL);
-	return true;
-}
-
-bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
-							uint8_t interval)
-{
-	if (!mesh_config_write_net_transmit(node_config_get(node), count,
-								interval))
-		return false;
-
-	mesh_config_save_config(node_config_get(node), true, NULL, NULL);
-	return true;
-}
-
-bool storage_set_mode(struct mesh_node *node, uint8_t mode,
-						const char *mode_name)
-{
-	if (!mesh_config_write_mode(node_config_get(node), mode_name, mode))
-		return false;
-
-	mesh_config_save_config(node_config_get(node), true, NULL, NULL);
-	return true;
-}
-
-bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t mod_id,
-				uint16_t app_idx, bool unbind)
-{
-	struct mesh_config *cfg;
-	int ele_idx;
-	bool stored, is_vendor = (mod_id > 0xffff);
-
-	ele_idx = node_get_element_idx(node, addr);
-	if (ele_idx < 0)
-		return false;
-
-	cfg = node_config_get(node);
-
-	if (unbind)
-		stored = mesh_config_model_binding_del(cfg, ele_idx, is_vendor,
-							mod_id, app_idx);
-	else
-		stored = mesh_config_model_binding_add(cfg, ele_idx, is_vendor,
-							mod_id, app_idx);
-
-	if (stored)
-		mesh_config_save_config(cfg, true, NULL, NULL);
-
-	return stored;
-}
-
-bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
-			uint16_t app_idx, const uint8_t key[16], bool update)
-{
-	struct mesh_config *cfg;
-	struct mesh_node *node = mesh_net_node_get(net);
-	bool stored;
-
-	cfg = node_config_get(node);
-
-	if (update)
-		stored = mesh_config_app_key_update(cfg, app_idx, key);
-	else
-		stored = mesh_config_app_key_add(cfg, net_idx, app_idx, key);
-
-	if (stored)
-		mesh_config_save_config(cfg, true, NULL, NULL);
-
-	return stored;
-}
-
-bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
-					uint16_t app_idx)
-{
-	struct mesh_config *cfg;
-	struct mesh_node *node = mesh_net_node_get(net);
-
-	cfg = node_config_get(node);
-
-	if (!mesh_config_app_key_del(cfg, net_idx, app_idx))
-		return false;
-
-	mesh_config_save_config(cfg, true, NULL, NULL);
-	return true;
-}
-
-bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
-					const uint8_t key[16], bool update)
-{
-	struct mesh_node *node = mesh_net_node_get(net);
-	struct mesh_config *cfg = node_config_get(node);
-	bool stored;
-
-	if (!update)
-		stored = mesh_config_net_key_add(cfg, net_idx, key);
-	else
-		stored = mesh_config_net_key_update(cfg, net_idx, key);
-
-	if (stored)
-		mesh_config_save_config(cfg, true, NULL, NULL);
-
-	return stored;
-}
-
-bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
-{
-	struct mesh_node *node = mesh_net_node_get(net);
-	struct mesh_config *cfg = node_config_get(node);
-
-	if (!mesh_config_net_key_del(cfg, net_idx))
-		return false;
-
-	mesh_config_save_config(cfg, true, NULL, NULL);
-	return true;
-}
-
-bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
-								bool update)
-{
-	struct mesh_node *node = mesh_net_node_get(net);
-	struct mesh_config *cfg = node_config_get(node);
-
-	if (!mesh_config_write_iv_index(cfg, iv_index, update))
-		return false;
-
-	mesh_config_save_config(cfg, true, NULL, NULL);
-	return true;
-}
-
-bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
-								uint8_t phase)
-{
-	struct mesh_node *node = mesh_net_node_get(net);
-	struct mesh_config *cfg = node_config_get(node);
-
-	if (!mesh_config_net_key_set_phase(cfg, net_idx, phase))
-		return false;
-
-	mesh_config_save_config(cfg, true, NULL, NULL);
-	return true;
-}
-
-bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq)
-{
-	struct mesh_node *node = mesh_net_node_get(net);
-	struct mesh_config *cfg = node_config_get(node);
-
-	if (!mesh_config_write_int(cfg, "sequenceNumber", seq))
-		return false;
-
-	mesh_config_save_config(cfg, false, NULL, NULL);
-	return true;
-}
-
 static int create_dir(const char *dir_name)
 {
 	struct stat st;
diff --git a/mesh/storage.h b/mesh/storage.h
index f70544ad6..21fd3f5ab 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -25,27 +25,3 @@ bool storage_load_nodes(const char *dir);
 bool storage_create_node_config(struct mesh_node *node, const uint8_t uuid[16],
 					struct mesh_config_node *db_node);
 void storage_remove_node_config(struct mesh_node *node);
-bool storage_model_bind(struct mesh_node *node, uint16_t addr, uint32_t id,
-						uint16_t app_idx, bool unbind);
-
-bool storage_set_ttl(struct mesh_node *node, uint8_t ttl);
-bool storage_set_relay(struct mesh_node *node, bool enable, uint8_t count,
-							uint8_t interval);
-bool storage_set_transmit_params(struct mesh_node *node, uint8_t count,
-							uint8_t interval);
-bool storage_set_mode(struct mesh_node *node, uint8_t mode,
-						const char *mode_name);
-bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
-					const uint8_t key[16], bool update);
-bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx);
-bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
-			uint16_t app_idx, const uint8_t key[16], bool update);
-bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
-							uint16_t app_idx);
-bool storage_write_sequence_number(struct mesh_net *net, uint32_t seq);
-bool storage_set_iv_index(struct mesh_net *net, uint32_t iv_index,
-								bool update);
-bool storage_set_device_key(struct mesh_node *node, uint8_t dev_key[16]);
-bool storage_set_unicast(struct mesh_node *node, uint16_t unicast);
-bool storage_set_key_refresh_phase(struct mesh_net *net, uint16_t net_idx,
-								uint8_t phase);
-- 
2.21.0

