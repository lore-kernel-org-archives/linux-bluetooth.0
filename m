Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB8AC73C6D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B031120838
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfGJFKH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:28142 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGJFKH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050317"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:05 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/9] mesh: Generalize mesh-config APIs
Date:   Tue,  9 Jul 2019 22:09:54 -0700
Message-Id: <20190710050959.7321-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710050959.7321-1-inga.stotland@intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This changes argument for each mesh-config API to use void* as
a pointer to a node configuration object. This makes usage of JSON
opaque for the rest of the code and allows to plug in a non-JSON
configuration storage implementation.
---
 mesh/mesh-config-json.c | 228 +++++++++++++++++++++++-----------------
 mesh/mesh-config.h      | 107 +++++++++----------
 2 files changed, 180 insertions(+), 155 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 8fcb8afe3..5ca086ad0 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -252,10 +252,14 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
-bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
+bool mesh_config_read_iv_index(void *cfg, uint32_t *idx, bool *update)
 {
+	json_object *jobj = cfg;
 	int tmp;
 
+	if (!jobj)
+		return false;
+
 	/* IV index */
 	if (!get_int(jobj, "IVindex", &tmp))
 		return false;
@@ -270,12 +274,12 @@ bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 	return true;
 }
 
-bool mesh_config_read_token(json_object *jobj, uint8_t token[8])
+bool mesh_config_read_token(void *cfg, uint8_t token[8])
 {
-	json_object *jvalue;
+	json_object *jobj = cfg, *jvalue;
 	char *str;
 
-	if (!token)
+	if (!token || !jobj)
 		return false;
 
 	if (!json_object_object_get_ex(jobj, "token", &jvalue))
@@ -288,12 +292,12 @@ bool mesh_config_read_token(json_object *jobj, uint8_t token[8])
 	return true;
 }
 
-bool mesh_config_read_device_key(json_object *jobj, uint8_t key_buf[16])
+bool mesh_config_read_device_key(void *cfg, uint8_t key_buf[16])
 {
-	json_object *jvalue;
+	json_object *jvalue, *jobj = cfg;
 	char *str;
 
-	if (!key_buf)
+	if (!key_buf || !jobj)
 		return false;
 
 	if (!json_object_object_get_ex(jobj, "deviceKey", &jvalue))
@@ -306,15 +310,15 @@ bool mesh_config_read_device_key(json_object *jobj, uint8_t key_buf[16])
 	return true;
 }
 
-bool mesh_config_read_app_keys(json_object *jobj, mesh_config_app_key_cb cb,
+bool mesh_config_read_app_keys(void *cfg, mesh_config_app_key_cb cb,
 							void *user_data)
 {
-	json_object *jarray;
+	json_object *jarray, *jobj = cfg;
 	int len;
 	int i;
 
-	if (!cb)
-		return true;
+	if (!jobj || !cb)
+		return false;
 
 	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
 		return false;
@@ -368,15 +372,15 @@ bool mesh_config_read_app_keys(json_object *jobj, mesh_config_app_key_cb cb,
 	return true;
 }
 
-bool mesh_config_read_net_keys(json_object *jobj, mesh_config_net_key_cb cb,
+bool mesh_config_read_net_keys(void *cfg, mesh_config_net_key_cb cb,
 								void *user_data)
 {
-	json_object *jarray;
+	json_object *jarray, *jobj = cfg;
 	int len;
 	int i;
 
-	if (!cb)
-		return true;
+	if (!cb || !jobj)
+		return false;
 
 	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
 		return false;
@@ -431,12 +435,14 @@ bool mesh_config_read_net_keys(json_object *jobj, mesh_config_net_key_cb cb,
 	return true;
 }
 
-bool mesh_config_net_key_add(json_object *jobj, uint16_t idx,
-							const uint8_t key[16])
+bool mesh_config_net_key_add(void *cfg, uint16_t idx, const uint8_t key[16])
 {
-	json_object *jarray = NULL, *jentry = NULL, *jstring;
+	json_object *jarray = NULL, *jentry = NULL, *jstring, *jobj = cfg;
 	char buf[5];
 
+	if (!jobj)
+		return false;
+
 	json_object_object_get_ex(jobj, "netKeys", &jarray);
 	if (jarray)
 		jentry = get_key_object(jarray, idx);
@@ -479,12 +485,14 @@ fail:
 	return false;
 }
 
-bool mesh_config_net_key_update(json_object *jobj, uint16_t idx,
-							const uint8_t key[16])
+bool mesh_config_net_key_update(void *cfg, uint16_t idx, const uint8_t key[16])
 {
-	json_object *jarray, *jentry, *jstring;
+	json_object *jarray, *jentry, *jstring, *jobj = cfg;
 	const char *str;
 
+	if (!jobj)
+		return false;
+
 	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
 		return false;
 
@@ -510,9 +518,12 @@ bool mesh_config_net_key_update(json_object *jobj, uint16_t idx,
 	return true;
 }
 
-bool mesh_config_net_key_del(json_object *jobj, uint16_t idx)
+bool mesh_config_net_key_del(void *cfg, uint16_t idx)
 {
-	json_object *jarray, *jarray_new;
+	json_object *jarray, *jarray_new, *jobj = cfg;
+
+	if (!jobj)
+		return false;
 
 	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
 		return true;
@@ -541,21 +552,35 @@ bool mesh_config_net_key_del(json_object *jobj, uint16_t idx)
 	return true;
 }
 
-bool mesh_config_write_device_key(json_object *jnode, uint8_t *key)
+bool mesh_config_write_device_key(void *cfg, uint8_t *key)
 {
-	return add_key_value(jnode, "deviceKey", key);
+	json_object *jobj = cfg;
+
+	if (!jobj)
+		return false;
+
+	return add_key_value(jobj, "deviceKey", key);
 }
 
-bool mesh_config_write_token(json_object *jnode, uint8_t *token)
+bool mesh_config_write_token(void *cfg, uint8_t *token)
 {
-	return add_u64_value(jnode, "token", token);
+	json_object *jobj = cfg;
+
+	if (!jobj)
+		return false;
+
+	return add_u64_value(jobj, "token", token);
 }
 
-bool mesh_config_app_key_add(json_object *jobj, uint16_t net_idx,
+bool mesh_config_app_key_add(void *cfg, uint16_t net_idx,
 					uint16_t app_idx, const uint8_t key[16])
 {
 	json_object *jarray = NULL, *jentry = NULL, *jstring = NULL;
 	char buf[5];
+	json_object *jobj = cfg;
+
+	if (!jobj)
+		return false;
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
 	if (jarray)
@@ -604,11 +629,15 @@ fail:
 	return false;
 }
 
-bool mesh_config_app_key_update(json_object *jobj, uint16_t app_idx,
+bool mesh_config_app_key_update(void *cfg, uint16_t app_idx,
 							const uint8_t key[16])
 {
 	json_object *jarray, *jentry = NULL, *jstring = NULL;
 	const char *str;
+	json_object *jobj = cfg;
+
+	if (!jobj)
+		return false;
 
 	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
 		return false;
@@ -629,9 +658,13 @@ bool mesh_config_app_key_update(json_object *jobj, uint16_t app_idx,
 	return add_key_value(jentry, "key", key);
 }
 
-bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
+bool mesh_config_app_key_del(void *cfg, uint16_t net_idx, uint16_t idx)
 {
 	json_object *jarray, *jarray_new;
+	json_object *jobj = cfg;
+
+	if (!jobj)
+		return false;
 
 	if (!json_object_object_get_ex(jobj, "appKeys", &jarray))
 		return true;
@@ -660,14 +693,17 @@ bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 	return true;
 }
 
-bool mesh_config_model_binding_add(json_object *jnode, uint8_t ele_idx,
-					bool vendor, uint32_t mod_id,
-							uint16_t app_idx)
+bool mesh_config_model_binding_add(void *cfg, uint8_t ele_idx, bool vendor,
+					uint32_t mod_id, uint16_t app_idx)
 {
 	json_object *jmodel, *jstring, *jarray = NULL;
 	char buf[5];
+	json_object *jobj = cfg;
 
-	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
+	if (!jobj)
+		return false;
+
+	jmodel = get_element_model(jobj, ele_idx, mod_id, vendor);
 	if (!jmodel)
 		return false;
 
@@ -695,14 +731,16 @@ bool mesh_config_model_binding_add(json_object *jnode, uint8_t ele_idx,
 	return true;
 }
 
-bool mesh_config_model_binding_del(json_object *jnode, uint8_t ele_idx,
-					bool vendor, uint32_t mod_id,
-							uint16_t app_idx)
+bool mesh_config_model_binding_del(void *cfg, uint8_t ele_idx, bool vendor,
+					uint32_t mod_id, uint16_t app_idx)
 {
-	json_object *jmodel, *jarray, *jarray_new;
+	json_object *jmodel, *jarray, *jarray_new, *jobj = cfg;
 	char buf[5];
 
-	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
+	if (!jobj)
+		return false;
+
+	jmodel = get_element_model(jobj, ele_idx, mod_id, vendor);
 	if (!jmodel)
 		return false;
 
@@ -1162,14 +1200,13 @@ static bool parse_composition(json_object *jcomp, struct mesh_config_node *node)
 	return true;
 }
 
-bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
-							void *user_data)
+bool mesh_config_read_node(void *cfg, mesh_config_node_cb cb, void *user_data)
 {
 	struct mesh_config_node node;
-	json_object *jvalue;
+	json_object *jvalue, *jobj = cfg;
 	char *str;
 
-	if (!jnode)
+	if (!jobj)
 		return false;
 
 	if (!cb) {
@@ -1179,14 +1216,14 @@ bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 
 	memset(&node, 0, sizeof(node));
 
-	if (!parse_composition(jnode, &node)) {
+	if (!parse_composition(jobj, &node)) {
 		l_info("Failed to parse local node composition");
 		return false;
 	}
 
-	parse_features(jnode, &node);
+	parse_features(jobj, &node);
 
-	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue)) {
+	if (!json_object_object_get_ex(jobj, "unicastAddress", &jvalue)) {
 		l_info("Bad config: Unicast address must be present");
 		return false;
 	}
@@ -1195,7 +1232,7 @@ bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 	if (sscanf(str, "%04hx", &node.unicast) != 1)
 		return false;
 
-	if (json_object_object_get_ex(jnode, "defaultTTL", &jvalue)) {
+	if (json_object_object_get_ex(jobj, "defaultTTL", &jvalue)) {
 		int ttl = json_object_get_int(jvalue);
 
 		if (ttl < 0 || ttl == 1 || ttl > DEFAULT_TTL)
@@ -1203,11 +1240,11 @@ bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 		node.ttl = (uint8_t) ttl;
 	}
 
-	if (json_object_object_get_ex(jnode, "sequenceNumber", &jvalue))
+	if (json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
 		node.seq_number = json_object_get_int(jvalue);
 
 	/* Check for required "elements" property */
-	if (!json_object_object_get_ex(jnode, "elements", &jvalue))
+	if (!json_object_object_get_ex(jobj, "elements", &jvalue))
 		return false;
 
 	if (!parse_elements(jvalue, &node))
@@ -1216,10 +1253,9 @@ bool mesh_config_read_node(json_object *jnode, mesh_config_node_cb cb,
 	return cb(&node, user_data);
 }
 
-bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
-								uint16_t value)
+bool mesh_config_write_uint16_hex(void *cfg, const char *desc, uint16_t value)
 {
-	json_object *jstring;
+	json_object *jstring, *jobj = cfg;
 	char buf[5];
 
 	if (!jobj)
@@ -1234,10 +1270,9 @@ bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_config_write_uint32_hex(json_object *jobj, const char *desc,
-								uint32_t value)
+bool mesh_config_write_uint32_hex(void *cfg, const char *desc, uint32_t value)
 {
-	json_object *jstring;
+	json_object *jstring, *jobj = cfg;
 	char buf[9];
 
 	if (!jobj)
@@ -1252,9 +1287,9 @@ bool mesh_config_write_uint32_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
-bool mesh_config_write_int(json_object *jobj, const char *keyword, int value)
+bool mesh_config_write_int(void *cfg, const char *keyword, int value)
 {
-	json_object *jvalue;
+	json_object *jvalue, *jobj = cfg;
 
 	if (!jobj)
 		return false;
@@ -1269,9 +1304,9 @@ bool mesh_config_write_int(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_config_write_bool(json_object *jobj, const char *keyword, bool value)
+bool mesh_config_write_bool(void *cfg, const char *keyword, bool value)
 {
-	json_object *jvalue;
+	json_object *jvalue, *jobj = cfg;
 
 	if (!jobj)
 		return false;
@@ -1298,9 +1333,9 @@ static const char *mode_to_string(int mode)
 	}
 }
 
-bool mesh_config_write_mode(json_object *jobj, const char *keyword, int value)
+bool mesh_config_write_mode(void *cfg, const char *keyword, int value)
 {
-	json_object *jstring;
+	json_object *jstring, *jobj = cfg;
 
 	if (!jobj)
 		return false;
@@ -1315,15 +1350,15 @@ bool mesh_config_write_mode(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
-bool mesh_config_write_relay_mode(json_object *jnode, uint8_t mode,
-					uint8_t count, uint16_t interval)
+bool mesh_config_write_relay_mode(void *cfg, uint8_t mode, uint8_t count,
+							uint16_t interval)
 {
-	json_object *jrelay;
+	json_object *jrelay, *jobj = cfg;
 
-	if (!jnode)
+	if (!jobj)
 		return false;
 
-	json_object_object_del(jnode, "relay");
+	json_object_object_del(jobj, "relay");
 
 	jrelay = json_object_new_object();
 	if (!jrelay)
@@ -1338,7 +1373,7 @@ bool mesh_config_write_relay_mode(json_object *jnode, uint8_t mode,
 	if (!mesh_config_write_int(jrelay, "interval", interval))
 		goto fail;
 
-	json_object_object_add(jnode, "relay", jrelay);
+	json_object_object_add(jobj, "relay", jrelay);
 
 	return true;
 fail:
@@ -1346,10 +1381,9 @@ fail:
 	return false;
 }
 
-bool mesh_config_read_net_transmit(json_object *jobj, uint8_t *cnt,
-							uint16_t *interval)
+bool mesh_config_read_net_transmit(void *cfg, uint8_t *cnt, uint16_t *interval)
 {
-	json_object *jretransmit, *jvalue;
+	json_object *jretransmit, *jvalue, *jobj = cfg;
 
 	if (!jobj)
 		return false;
@@ -1370,10 +1404,9 @@ bool mesh_config_read_net_transmit(json_object *jobj, uint8_t *cnt,
 	return true;
 }
 
-bool mesh_config_write_net_transmit(json_object *jobj, uint8_t cnt,
-							uint16_t interval)
+bool mesh_config_write_net_transmit(void *cfg, uint8_t cnt, uint16_t interval)
 {
-	json_object *jretransmit;
+	json_object *jretransmit, *jobj = cfg;
 
 	if (!jobj)
 		return false;
@@ -1399,8 +1432,9 @@ fail:
 
 }
 
-bool mesh_config_write_iv_index(json_object *jobj, uint32_t idx, bool update)
+bool mesh_config_write_iv_index(void *cfg, uint32_t idx, bool update)
 {
+	json_object *jobj = cfg;
 	int tmp = update ? 1 : 0;
 
 	if (!jobj)
@@ -1415,8 +1449,10 @@ bool mesh_config_write_iv_index(json_object *jobj, uint32_t idx, bool update)
 	return true;
 }
 
-void mesh_config_remove_property(json_object *jobj, const char *desc)
+void mesh_config_remove_property(void *cfg, const char *desc)
 {
+	json_object *jobj = cfg;
+
 	if (jobj)
 		json_object_object_del(jobj, desc);
 }
@@ -1440,11 +1476,11 @@ static void add_model(void *a, void *b)
 }
 
 /* Add unprovisioned node (local) */
-bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node)
+bool mesh_config_add_node(void *cfg, struct mesh_config_node *node)
 {
 	struct mesh_config_modes *modes = &node->modes;
 	const struct l_queue_entry *entry;
-	json_object *jelems;
+	json_object *jelems, *jnode = cfg;
 
 	if (!jnode)
 		return false;
@@ -1562,10 +1598,9 @@ static void finish_key_refresh(json_object *jobj, uint16_t net_idx)
 
 }
 
-bool mesh_config_net_key_set_phase(json_object *jobj, uint16_t idx,
-								uint8_t phase)
+bool mesh_config_net_key_set_phase(void *cfg, uint16_t idx, uint8_t phase)
 {
-	json_object *jarray, *jentry = NULL;
+	json_object *jobj = cfg, *jarray, *jentry = NULL;
 
 	if (!jobj)
 		return false;
@@ -1588,11 +1623,10 @@ bool mesh_config_net_key_set_phase(json_object *jobj, uint16_t idx,
 	return true;
 }
 
-bool mesh_config_model_pub_add(json_object *jnode, uint16_t addr,
-					uint32_t mod_id, bool vendor,
-					struct mesh_config_pub *pub)
+bool mesh_config_model_pub_add(void *cfg, uint16_t addr, uint32_t mod_id,
+				bool vendor, struct mesh_config_pub *pub)
 {
-	json_object *jmodel, *jpub, *jretransmit;
+	json_object *jnode = cfg, *jmodel, *jpub, *jretransmit;
 	bool res;
 	int ele_idx;
 
@@ -1672,20 +1706,21 @@ static bool delete_model_property(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_config_model_pub_del(json_object *jnode, uint16_t addr,
-						uint32_t mod_id, bool vendor)
+bool mesh_config_model_pub_del(void *cfg, uint16_t addr, uint32_t mod_id,
+								bool vendor)
 {
+	json_object *jnode = cfg;
+
 	if (!jnode)
 		return false;
 
 	return delete_model_property(jnode, addr, mod_id, vendor, "publish");
 }
 
-bool mesh_config_model_sub_add(json_object *jnode, uint16_t addr,
-						uint32_t mod_id, bool vendor,
-						struct mesh_config_sub *sub)
+bool mesh_config_model_sub_add(void *cfg, uint16_t addr, uint32_t mod_id,
+				bool vendor, struct mesh_config_sub *sub)
 {
-	json_object *jmodel, *jstring, *jarray = NULL;
+	json_object *jnode = cfg, *jmodel, *jstring, *jarray = NULL;
 	int ele_idx, len;
 	char buf[33];
 
@@ -1730,11 +1765,10 @@ bool mesh_config_model_sub_add(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_config_model_sub_del(json_object *jnode, uint16_t addr,
-						uint32_t mod_id, bool vendor,
-						struct mesh_config_sub *sub)
+bool mesh_config_model_sub_del(void *cfg, uint16_t addr, uint32_t mod_id,
+				bool vendor, struct mesh_config_sub *sub)
 {
-	json_object *jmodel, *jarray, *jarray_new;
+	json_object *jnode = cfg, *jmodel, *jarray, *jarray_new;
 	char buf[33];
 	int len, ele_idx;
 
@@ -1783,9 +1817,11 @@ bool mesh_config_model_sub_del(json_object *jnode, uint16_t addr,
 	return true;
 }
 
-bool mesh_config_model_sub_del_all(json_object *jnode, uint16_t addr,
-						uint32_t mod_id, bool vendor)
+bool mesh_config_model_sub_del_all(void *cfg, uint16_t addr, uint32_t mod_id,
+								bool vendor)
 {
+	json_object *jnode = cfg;
+
 	if (!jnode)
 		return false;
 
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index f60ae18cd..ab101a331 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -21,7 +21,7 @@ struct mesh_config_sub {
 	bool virt;
 	union {
 		uint16_t addr;
-		uint8_t	virt_addr[16];
+		uint8_t virt_addr[16];
 	} src;
 };
 
@@ -100,66 +100,55 @@ typedef bool (*mesh_config_app_key_cb)(uint16_t idx, uint16_t net_idx,
 typedef bool (*mesh_config_node_cb)(struct mesh_config_node *node,
 							void *user_data);
 
-bool mesh_config_read_node(json_object *jobj, mesh_config_node_cb cb,
+bool mesh_config_read_node(void *cfg, mesh_config_node_cb cb, void *user_data);
+bool mesh_config_add_node(void *cfg, struct mesh_config_node *node);
+bool mesh_config_read_iv_index(void *cfg, uint32_t *idx, bool *update);
+bool mesh_config_read_device_key(void *cfg, uint8_t key_buf[16]);
+bool mesh_config_read_token(void *cfg, uint8_t token[8]);
+bool mesh_config_read_net_transmit(void *cfg, uint8_t *cnt, uint16_t *interval);
+bool mesh_config_write_net_transmit(void *cfg, uint8_t cnt, uint16_t interval);
+bool mesh_config_read_net_keys(void *cfg, mesh_config_net_key_cb cb,
 							void *user_data);
-bool mesh_config_add_node(json_object *jnode, struct mesh_config_node *node);
-bool mesh_config_read_iv_index(json_object *jobj, uint32_t *idx, bool *update);
-bool mesh_config_read_device_key(json_object *jobj, uint8_t key_buf[16]);
-bool mesh_config_read_token(json_object *jobj, uint8_t token[8]);
-bool mesh_config_read_net_transmit(json_object *jobj, uint8_t *cnt,
-							uint16_t *interval);
-bool mesh_config_write_net_transmit(json_object *jobj, uint8_t cnt,
-							uint16_t interval);
-bool mesh_config_read_net_keys(json_object *jobj, mesh_config_net_key_cb cb,
-							void *user_data);
-bool mesh_config_read_app_keys(json_object *jobj, mesh_config_app_key_cb cb,
+bool mesh_config_read_app_keys(void *cfg, mesh_config_app_key_cb cb,
 							void *user_data);
-bool mesh_config_write_device_key(json_object *jobj, uint8_t *key);
-bool mesh_config_write_token(json_object *jobj, uint8_t *token);
-bool mesh_config_write_network_key(json_object *jobj, uint16_t idx,
-				uint8_t *key, uint8_t *new_key, int phase);
-bool mesh_config_write_app_key(json_object *jobj, uint16_t net_idx,
-			uint16_t app_idx, uint8_t *key, uint8_t *new_key);
-bool mesh_config_write_int(json_object *jobj, const char *keyword, int value);
-bool mesh_config_write_uint16_hex(json_object *jobj, const char *desc,
-								uint16_t value);
-bool mesh_config_write_uint32_hex(json_object *jobj, const char *desc,
-								uint32_t value);
-bool mesh_config_write_bool(json_object *jobj, const char *keyword, bool value);
-bool mesh_config_write_relay_mode(json_object *jnode, uint8_t mode,
-					uint8_t count, uint16_t interval);
-bool mesh_config_write_mode(json_object *jobj, const char *keyword, int value);
-bool mesh_config_model_binding_add(json_object *jnode, uint8_t ele_idx,
-						bool vendor, uint32_t mod_id,
-							uint16_t app_idx);
-bool mesh_config_model_binding_del(json_object *jnode, uint8_t ele_idx,
-						bool vendor, uint32_t mod_id,
-							uint16_t app_idx);
-bool mesh_config_model_pub_add(json_object *jnode, uint16_t ele_addr,
-						uint32_t mod_id, bool vendor,
-						struct mesh_config_pub *pub);
-bool mesh_config_model_pub_del(json_object *jnode, uint16_t ele_addr,
-						uint32_t mod_id, bool vendor);
-bool mesh_config_model_sub_add(json_object *jnode, uint16_t addr,
-						uint32_t mod_id, bool vendor,
-						struct mesh_config_sub *sub);
-bool mesh_config_model_sub_del(json_object *jnode, uint16_t addr,
-						uint32_t mod_id, bool vendor,
-						struct mesh_config_sub *sub);
-bool mesh_config_model_sub_del_all(json_object *jnode, uint16_t addr,
-						uint32_t mod_id, bool vendor);
-bool mesh_config_app_key_add(json_object *jnode, uint16_t net_idx,
-				uint16_t app_idx, const uint8_t key[16]);
-bool mesh_config_app_key_update(json_object *jobj, uint16_t app_idx,
+bool mesh_config_write_device_key(void *cfg, uint8_t *key);
+bool mesh_config_write_token(void *cfg, uint8_t *token);
+bool mesh_config_write_network_key(void *cfg, uint16_t net_idx, uint8_t *key,
+						uint8_t *new_key, int phase);
+bool mesh_config_write_app_key(void *cfg, uint16_t net_idx, uint16_t app_idx,
+						uint8_t *key, uint8_t *new_key);
+bool mesh_config_write_int(void *cfg, const char *keyword, int value);
+bool mesh_config_write_uint16_hex(void *cfg, const char *desc, uint16_t value);
+bool mesh_config_write_uint32_hex(void *cfg, const char *desc, uint32_t value);
+bool mesh_config_write_bool(void *cfg, const char *keyword, bool value);
+bool mesh_config_write_relay_mode(void *cfg, uint8_t mode, uint8_t count,
+							uint16_t interval);
+bool mesh_config_write_mode(void *cfg, const char *keyword, int value);
+bool mesh_config_model_binding_add(void *cfg, uint8_t ele_idx, bool vendor,
+					uint32_t mod_id, uint16_t app_idx);
+bool mesh_config_model_binding_del(void *cfg, uint8_t ele_idx, bool vendor,
+					uint32_t mod_id, uint16_t app_idx);
+bool mesh_config_model_pub_add(void *cfg, uint16_t ele_addr, uint32_t mod_id,
+				bool vendor, struct mesh_config_pub *pub);
+bool mesh_config_model_pub_del(void *cfg, uint16_t ele_addr, uint32_t mod_id,
+								bool vendor);
+bool mesh_config_model_sub_add(void *cfg, uint16_t addr, uint32_t mod_id,
+				bool vendor, struct mesh_config_sub *sub);
+bool mesh_config_model_sub_del(void *cfg, uint16_t addr, uint32_t mod_id,
+				bool vendor, struct mesh_config_sub *sub);
+bool mesh_config_model_sub_del_all(void *cfg, uint16_t addr, uint32_t mod_id,
+								bool vendor);
+bool mesh_config_app_key_add(void *cfg, uint16_t net_idx, uint16_t app_idx,
+							const uint8_t key[16]);
+bool mesh_config_app_key_update(void *cfg, uint16_t app_idx,
 							const uint8_t key[16]);
-bool mesh_config_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx);
-bool mesh_config_net_key_add(json_object *jobj, uint16_t net_idx,
+bool mesh_config_app_key_del(void *cfg, uint16_t net_idx, uint16_t idx);
+bool mesh_config_net_key_add(void *cfg, uint16_t net_idx,
 							const uint8_t key[16]);
-bool mesh_config_net_key_update(json_object *jobj, uint16_t idx,
+bool mesh_config_net_key_update(void *cfg, uint16_t net_idx,
 							const uint8_t key[16]);
-bool mesh_config_net_key_del(json_object *jobj, uint16_t net_idx);
-bool mesh_config_net_key_set_phase(json_object *jobj, uint16_t idx,
-								uint8_t phase);
-bool mesh_config_write_address(json_object *jobj, uint16_t address);
-bool mesh_config_write_iv_index(json_object *jobj, uint32_t idx, bool update);
-void mesh_config_remove_property(json_object *jobj, const char *desc);
+bool mesh_config_net_key_del(void *cfg, uint16_t net_idx);
+bool mesh_config_net_key_set_phase(void *cfg, uint16_t net_idx, uint8_t phase);
+bool mesh_config_write_address(void *cfg, uint16_t address);
+bool mesh_config_write_iv_index(void *cfg, uint32_t net_idx, bool update);
+void mesh_config_remove_property(void *cfg, const char *desc);
-- 
2.21.0

