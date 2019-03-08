Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9692C10F09
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F1D20857
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCHW62 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:58:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:23709 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfCHW61 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 17:58:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 14:58:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="120994289"
Received: from ingas-nuc1.sea.intel.com ([10.251.144.43])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2019 14:58:25 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/3] mesh: Add json config functions to save pub/sub updates
Date:   Fri,  8 Mar 2019 14:58:18 -0800
Message-Id: <20190308225820.20561-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190308225820.20561-1-inga.stotland@intel.com>
References: <20190308225820.20561-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds functions to save updates to model subscriptions and
publication in JSON format.
---
 mesh/mesh-db.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++++-
 mesh/mesh-db.h |  13 ++-
 mesh/model.c   |   4 +-
 3 files changed, 292 insertions(+), 5 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 2d518c1aa..01859f524 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -66,6 +66,32 @@ static bool add_key_value(json_object *jobject, const char *desc,
 	return true;
 }
 
+static int get_element_index(json_object *jnode, uint16_t ele_addr)
+{
+	json_object *jvalue, *jelements;
+	uint16_t addr, num_ele;
+	char *str;
+
+	json_object_object_get_ex(jnode, "unicastAddress", &jvalue);
+	if (!jvalue)
+		return -1;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", &addr) != 1)
+		return -1;
+
+	json_object_object_get_ex(jnode, "elements", &jelements);
+	if (!jelements)
+		return -1;
+
+	num_ele = json_object_array_length(jelements);
+
+	if (ele_addr >= addr + num_ele || ele_addr < addr)
+		return -1;
+
+	return ele_addr - addr;
+}
+
 static json_object *get_element_model(json_object *jnode, int ele_idx,
 						uint32_t mod_id, bool vendor)
 {
@@ -800,10 +826,18 @@ static struct mesh_db_pub *parse_model_publication(json_object *jpub)
 		goto fail;
 	pub->credential = (uint8_t) value;
 
-	if (!get_int(jpub, "retransmit", &value))
+	json_object_object_get_ex(jpub, "retransmit", &jvalue);
+	if (!jvalue)
 		goto fail;
 
-	pub->retransmit = (uint8_t) value;
+	if (!get_int(jvalue, "count", &value))
+		goto fail;
+	pub->count = (uint8_t) value;
+
+	if (!get_int(jvalue, "interval", &value))
+		goto fail;
+	pub->interval = (uint8_t) value;
+
 	return pub;
 
 fail:
@@ -1133,6 +1167,9 @@ bool mesh_db_read_node(json_object *jnode, mesh_db_node_cb cb, void *user_data)
 	json_object *jvalue;
 	char *str;
 
+	if (!jnode)
+		return false;
+
 	if (!cb) {
 		l_info("Node read callback is required");
 		return false;
@@ -1185,6 +1222,9 @@ bool mesh_db_write_uint16_hex(json_object *jobj, const char *desc,
 	json_object *jstring;
 	char buf[5];
 
+	if (!jobj)
+		return false;
+
 	snprintf(buf, 5, "%4.4x", value);
 	jstring = json_object_new_string(buf);
 	if (!jstring)
@@ -1200,6 +1240,9 @@ bool mesh_db_write_uint32_hex(json_object *jobj, const char *desc,
 	json_object *jstring;
 	char buf[9];
 
+	if (!jobj)
+		return false;
+
 	snprintf(buf, 9, "%8.8x", value);
 	jstring = json_object_new_string(buf);
 	if (!jstring)
@@ -1213,6 +1256,9 @@ bool mesh_db_write_int(json_object *jobj, const char *keyword, int value)
 {
 	json_object *jvalue;
 
+	if (!jobj)
+		return false;
+
 	json_object_object_del(jobj, keyword);
 
 	jvalue = json_object_new_int(value);
@@ -1227,6 +1273,9 @@ bool mesh_db_write_bool(json_object *jobj, const char *keyword, bool value)
 {
 	json_object *jvalue;
 
+	if (!jobj)
+		return false;
+
 	json_object_object_del(jobj, keyword);
 
 	jvalue = json_object_new_boolean(value);
@@ -1253,6 +1302,9 @@ bool mesh_db_write_mode(json_object *jobj, const char *keyword, int value)
 {
 	json_object *jstring;
 
+	if (!jobj)
+		return false;
+
 	jstring = json_object_new_string(mode_to_string(value));
 
 	if (!jstring)
@@ -1268,6 +1320,9 @@ bool mesh_db_write_relay_mode(json_object *jnode, uint8_t mode, uint8_t count,
 {
 	json_object *jrelay;
 
+	if (!jnode)
+		return false;
+
 	json_object_object_del(jnode, "relay");
 
 	jrelay = json_object_new_object();
@@ -1296,6 +1351,9 @@ bool mesh_db_read_net_transmit(json_object *jobj, uint8_t *cnt,
 {
 	json_object *jretransmit, *jvalue;
 
+	if (!jobj)
+		return false;
+
 	json_object_object_get_ex(jobj, "retransmit", &jretransmit);
 	if (!jretransmit)
 		return false;
@@ -1320,6 +1378,9 @@ bool mesh_db_write_net_transmit(json_object *jobj, uint8_t cnt,
 {
 	json_object *jretransmit;
 
+	if (!jobj)
+		return false;
+
 	json_object_object_del(jobj, "retransmit");
 
 	jretransmit = json_object_new_object();
@@ -1345,6 +1406,9 @@ bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update)
 {
 	int tmp = update ? 1 : 0;
 
+	if (!jobj)
+		return false;
+
 	if (!mesh_db_write_int(jobj, "IVindex", idx))
 		return false;
 
@@ -1356,7 +1420,8 @@ bool mesh_db_write_iv_index(json_object *jobj, uint32_t idx, bool update)
 
 void mesh_db_remove_property(json_object *jobj, const char *desc)
 {
-	json_object_object_del(jobj, desc);
+	if (jobj)
+		json_object_object_del(jobj, desc);
 }
 
 static void add_model(void *a, void *b)
@@ -1384,6 +1449,9 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
 	const struct l_queue_entry *entry;
 	json_object *jelements;
 
+	if (!jnode)
+		return false;
+
 	/* CID, PID, VID, crpl */
 	if (!mesh_db_write_uint16_hex(jnode, "cid", node->cid))
 		return false;
@@ -1505,6 +1573,9 @@ bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
 {
 	json_object *jarray, *jentry = NULL;
 
+	if (!jobj)
+		return false;
+
 	json_object_object_get_ex(jobj, "netKeys", &jarray);
 
 	if (jarray)
@@ -1524,3 +1595,205 @@ bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase)
 
 	return true;
 }
+
+bool mesh_db_model_pub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
+					bool vendor, struct mesh_db_pub *pub)
+{
+	json_object *jmodel, *jpub, *jretransmit;
+	bool res;
+	int ele_idx;
+
+	if (!jnode)
+		return false;
+
+	ele_idx = get_element_index(jnode, addr);
+	if (ele_idx < 0)
+		return false;
+
+	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
+	if (!jmodel)
+		return false;
+
+	json_object_object_del(jmodel, "publish");
+
+	jpub = json_object_new_object();
+	if (!jpub)
+		return false;
+
+	if (pub->virt)
+		res = add_key_value(jpub, "address", pub->virt_addr);
+	else
+		res = mesh_db_write_uint16_hex(jpub, "address", pub->addr);
+
+	if (!res)
+		goto fail;
+
+	if (!mesh_db_write_uint16_hex(jpub, "index", pub->idx))
+		goto fail;
+
+	if (!mesh_db_write_int(jpub, "ttl", pub->ttl))
+		goto fail;
+
+	if (!mesh_db_write_int(jpub, "period", pub->period))
+		goto fail;
+
+	if (!mesh_db_write_int(jpub, "credentials", pub->credential ? 1 : 0))
+		goto fail;
+
+	jretransmit = json_object_new_object();
+	if (!jretransmit)
+		goto fail;
+
+	if (!mesh_db_write_int(jretransmit, "count", pub->count))
+		goto fail;
+
+	if (!mesh_db_write_int(jretransmit, "interval", pub->interval))
+		goto fail;
+
+	json_object_object_add(jpub, "retransmit", jretransmit);
+	json_object_object_add(jmodel, "publish", jpub);
+
+	return true;
+fail:
+	json_object_put(jpub);
+	return false;
+}
+
+static bool delete_model_property(json_object *jnode, uint16_t addr,
+			uint32_t mod_id, bool vendor, const char *keyword)
+{
+	json_object *jmodel;
+	int ele_idx;
+
+	ele_idx = get_element_index(jnode, addr);
+	if (ele_idx < 0)
+		return false;
+
+	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
+	if (!jmodel)
+		return false;
+
+	json_object_object_del(jmodel, keyword);
+
+	return true;
+}
+
+bool mesh_db_model_pub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
+								bool vendor)
+{
+	if (!jnode)
+		return false;
+
+	return delete_model_property(jnode, addr, mod_id, vendor, "publish");
+}
+
+bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
+					bool vendor, struct mesh_db_sub *sub)
+{
+	json_object *jmodel, *jstring, *jarray;
+	int ele_idx, len;
+	char buf[33];
+
+	if (!jnode)
+		return false;
+
+	ele_idx = get_element_index(jnode, addr);
+	if (ele_idx < 0)
+		return false;
+
+	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
+	if (!jmodel)
+		return false;
+
+	json_object_object_get_ex(jmodel, "subscribe", &jarray);
+
+	if (!sub->virt) {
+		snprintf(buf, 5, "%4.4x", sub->src.addr);
+		len = 4;
+	} else {
+		hex2str(sub->src.virt_addr, 16, buf, 33);
+		len = 32;
+	}
+
+	if (jarray && jarray_has_string(jarray, buf, len))
+		return true;
+
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		return false;
+
+	if (!jarray) {
+		jarray = json_object_new_array();
+		if (!jarray) {
+			json_object_put(jstring);
+			return false;
+		}
+		json_object_object_add(jmodel, "subscribe", jarray);
+	}
+
+	json_object_array_add(jarray, jstring);
+
+	return true;
+}
+
+bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr,
+			uint32_t mod_id, bool vendor, struct mesh_db_sub *sub)
+{
+	json_object *jmodel, *jarray, *jarray_new;
+	char buf[33];
+	int len, ele_idx;
+
+	if (!jnode)
+		return false;
+
+	ele_idx = get_element_index(jnode, addr);
+	if (ele_idx < 0)
+		return false;
+
+	jmodel = get_element_model(jnode, ele_idx, mod_id, vendor);
+	if (!jmodel)
+		return false;
+
+	json_object_object_get_ex(jmodel, "subscribe", &jarray);
+	if (!jarray)
+		return true;
+
+	if (!sub->virt) {
+		snprintf(buf, 5, "%4.4x", sub->src.addr);
+		len = 4;
+	} else {
+		hex2str(sub->src.virt_addr, 16, buf, 33);
+		len = 32;
+	}
+
+	if (!jarray_has_string(jarray, buf, len))
+		return true;
+
+	if (json_object_array_length(jarray) == 1) {
+		json_object_object_del(jmodel, "subscribe");
+		return true;
+	}
+
+	/*
+	 * There is no easy way to delete a value from a json array.
+	 * Create a new copy without specified element and
+	 * then remove old array.
+	 */
+	jarray_new = jarray_string_del(jarray, buf, len);
+	if (!jarray_new)
+		return false;
+
+	json_object_object_del(jmodel, "subscribe");
+	json_object_object_add(jmodel, "subscribe", jarray_new);
+
+	return true;
+}
+
+bool mesh_db_model_sub_del_all(json_object *jnode, uint16_t addr,
+						uint32_t mod_id, bool vendor)
+{
+	if (!jnode)
+		return false;
+
+	return delete_model_property(jnode, addr, mod_id, vendor, "subscribe");
+}
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 52ea05528..5dec6cb9f 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -32,7 +32,8 @@ struct mesh_db_pub {
 	uint8_t ttl;
 	uint8_t credential;
 	uint8_t period;
-	uint8_t retransmit;
+	uint8_t count;
+	uint8_t interval;
 	uint8_t virt_addr[16];
 };
 
@@ -129,6 +130,16 @@ bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
 bool mesh_db_model_binding_del(json_object *jnode, uint8_t ele_idx, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
+bool mesh_db_model_pub_add(json_object *jnode, uint16_t ele_addr,
+			uint32_t mod_id, bool vendor, struct mesh_db_pub *pub);
+bool mesh_db_model_pub_del(json_object *jnode, uint16_t ele_addr,
+						uint32_t mod_id, bool vendor);
+bool mesh_db_model_sub_add(json_object *jnode, uint16_t addr, uint32_t mod_id,
+					bool vendor, struct mesh_db_sub *sub);
+bool mesh_db_model_sub_del(json_object *jnode, uint16_t addr, uint32_t mod_id,
+					bool vendor, struct mesh_db_sub *sub);
+bool mesh_db_model_sub_del_all(json_object *jnode, uint16_t addr,
+						uint32_t mod_id, bool vendor);
 bool mesh_db_app_key_add(json_object *jnode, uint16_t net_idx, uint16_t app_idx,
 							const uint8_t key[16]);
 bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
diff --git a/mesh/model.c b/mesh/model.c
index 5940f6854..dc525f72f 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1428,13 +1428,15 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 		struct mesh_db_pub *pub = db_mod->pub;
 		uint8_t mod_addr[2];
 		uint8_t *pub_addr;
+		uint8_t retransmit = (pub->count << 5) +
+						(pub->interval / 50 - 1);
 
 		/* Add publication */
 		l_put_le16(pub->addr, &mod_addr);
 		pub_addr = pub->virt ? pub->virt_addr : (uint8_t *) &mod_addr;
 
 		if (set_pub(mod, pub_addr, pub->idx, pub->credential, pub->ttl,
-			pub->period, pub->retransmit, pub->virt, NULL) !=
+			pub->period, retransmit, pub->virt, NULL) !=
 							MESH_STATUS_SUCCESS) {
 			mesh_model_free(mod);
 			return NULL;
-- 
2.17.2

