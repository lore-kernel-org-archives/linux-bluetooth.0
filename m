Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59BC47257
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 19:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A232208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 19:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgEGTRS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:37113 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTRR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 15:17:17 -0400
IronPort-SDR: TtU1wuHomlui28SzxavdiQ/RgDZzXw9AQD+VNSbBBWuqULX90zM+ngbuKLf9Z/vt+AMxtXXSH+
 Ag1R3g0lzWeA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 12:17:05 -0700
IronPort-SDR: zp+PBfJYkrIbWq0evy4v09XGOmyNwrSEPCuqXPS45gPWEXFTPIOBpMWv/fQmvoaFIGk2fNax6r
 DkIXiKXJYafg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="305209031"
Received: from ingas-nuc1.sea.intel.com ([10.254.74.176])
  by FMSMGA003.fm.intel.com with ESMTP; 07 May 2020 12:17:03 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Save node's composition in config
Date:   Thu,  7 May 2020 12:17:02 -0700
Message-Id: <20200507191702.13563-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Store remote node's composition after successful completion
of "composition-get" command (config menu).
Show model IDs when printing node info for "list-nodes" command
(main menu).
---
 tools/mesh/cfgcli.c  |   2 +
 tools/mesh/mesh-db.c | 294 ++++++++++++++++++++++++++++++++++++++++---
 tools/mesh/mesh-db.h |  10 +-
 tools/mesh/remote.c  |  93 +++++++++++++-
 tools/mesh/remote.h  |   2 +
 5 files changed, 374 insertions(+), 27 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index b96c6c9e6..218e82c50 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -434,6 +434,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 		print_composition(data, len);
 
+		if (!mesh_db_node_set_composition(src, data, len))
+			bt_shell_printf("Failed to save node composition!\n");
 		break;
 
 	case OP_APPKEY_STATUS:
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index d39435ca0..8973bba76 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -45,6 +45,7 @@
 #include "tools/mesh/mesh-db.h"
 
 #define KEY_IDX_INVALID NET_IDX_INVALID
+#define DEFAULT_LOCATION 0x0000
 
 struct mesh_db {
 	json_object *jcfg;
@@ -217,6 +218,23 @@ static bool write_uint16_hex(json_object *jobj, const char *desc,
 	return true;
 }
 
+static bool write_uint32_hex(json_object *jobj, const char *desc, uint32_t val)
+{
+	json_object *jstring;
+	char buf[9];
+
+	snprintf(buf, 9, "%8.8x", val);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		return false;
+
+	/* Overwrite old value if present */
+	json_object_object_del(jobj, desc);
+
+	json_object_object_add(jobj, desc, jstring);
+	return true;
+}
+
 static json_object *get_node_by_uuid(json_object *jcfg, uint8_t uuid[16])
 {
 	json_object *jarray = NULL;
@@ -338,6 +356,65 @@ static int compare_group_addr(const void *a, const void *b, void *user_data)
 	return 0;
 }
 
+static bool load_composition(json_object *jnode, uint16_t unicast)
+{
+	json_object *jarray;
+	int i, ele_cnt;
+
+	if (!json_object_object_get_ex(jnode, "elements", &jarray))
+		return false;
+
+	if (json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	ele_cnt = json_object_array_length(jarray);
+
+	for (i = 0; i < ele_cnt; ++i) {
+		json_object *jentry, *jval, *jmods;
+		int32_t index;
+		int k, mod_cnt;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		if (!json_object_object_get_ex(jentry, "index", &jval))
+			return false;
+
+		index = json_object_get_int(jval);
+		if (index > 0xff)
+			return false;
+
+		if (!json_object_object_get_ex(jentry, "models", &jmods))
+			return false;
+
+		mod_cnt = json_object_array_length(jmods);
+
+		for (k = 0; k < mod_cnt; ++k) {
+			json_object *jmod, *jid;
+			uint32_t mod_id, len;
+			const char *str;
+
+			jmod = json_object_array_get_idx(jmods, k);
+			if (!json_object_object_get_ex(jmod, "modelId", &jid))
+				return false;
+
+			str = json_object_get_string(jid);
+			len = strlen(str);
+
+			if (len != 4 && len != 8)
+				return false;
+
+			if ((len == 4) && (sscanf(str, "%04x", &mod_id) != 1))
+				return false;
+
+			if ((len == 8) && (sscanf(str, "%08x", &mod_id) != 1))
+				return false;
+
+			remote_set_model(unicast, index, mod_id, len == 8);
+		}
+	}
+
+	return true;
+}
+
 static void load_remotes(json_object *jcfg)
 {
 	json_object *jnodes;
@@ -420,6 +497,8 @@ static void load_remotes(json_object *jcfg)
 				remote_add_app_key(unicast, key_idx);
 		}
 
+		load_composition(jnode, unicast);
+
 		node_count++;
 
 		/* TODO: Add the rest of the configuration */
@@ -819,12 +898,34 @@ struct l_queue *mesh_db_load_groups(void)
 	return groups;
 }
 
+static json_object *init_elements(uint8_t num_els)
+{
+	json_object *jelements;
+	uint8_t i;
+
+	jelements = json_object_new_array();
+
+	for (i = 0; i < num_els; ++i) {
+		json_object *jelement, *jmods;
+
+		jelement = json_object_new_object();
+
+		write_int(jelement, "index", i);
+		write_uint16_hex(jelement, "location", DEFAULT_LOCATION);
+		jmods = json_object_new_array();
+		json_object_object_add(jelement, "models", jmods);
+
+		json_object_array_add(jelements, jelement);
+	}
+
+	return jelements;
+}
+
 bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 							uint16_t net_idx)
 {
 	json_object *jnode;
 	json_object *jelements, *jnodes, *jnetkeys, *jappkeys;
-	int i;
 
 	if (!cfg || !cfg->jcfg)
 		return false;
@@ -842,22 +943,7 @@ bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 	if (!add_u8_16(jnode, "uuid", uuid))
 		goto fail;
 
-	jelements = json_object_new_array();
-	if (!jelements)
-		goto fail;
-
-	for (i = 0; i < num_els; ++i) {
-		json_object *jelement = json_object_new_object();
-
-		if (!jelement) {
-			json_object_put(jelements);
-			goto fail;
-		}
-
-		write_int(jelement, "elementIndex", i);
-		json_object_array_add(jelements, jelement);
-	}
-
+	jelements = init_elements(num_els);
 	json_object_object_add(jnode, "elements", jelements);
 
 	jnetkeys = json_object_new_array();
@@ -932,6 +1018,180 @@ bool mesh_db_del_node(uint16_t unicast)
 	return save_config();
 }
 
+static json_object *init_model(uint16_t mod_id)
+{
+	json_object *jmod, *jarray;
+
+	jmod = json_object_new_object();
+
+	if (!write_uint16_hex(jmod, "modelId", mod_id)) {
+		json_object_put(jmod);
+		return NULL;
+	}
+
+	jarray = json_object_new_array();
+	json_object_object_add(jmod, "bind", jarray);
+
+	jarray = json_object_new_array();
+	json_object_object_add(jmod, "subscribe", jarray);
+
+	return jmod;
+}
+
+static json_object *init_vendor_model(uint32_t mod_id)
+{
+	json_object *jmod, *jarray;
+
+	jmod = json_object_new_object();
+
+	if (!write_uint32_hex(jmod, "modelId", mod_id)) {
+		json_object_put(jmod);
+		return NULL;
+	}
+
+	jarray = json_object_new_array();
+	json_object_object_add(jmod, "bind", jarray);
+
+	jarray = json_object_new_array();
+	json_object_object_add(jmod, "subscribe", jarray);
+
+	return jmod;
+}
+
+bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data, uint16_t len)
+{
+	uint16_t features;
+	int sz, i = 0;
+	json_object *jnode, *jobj, *jelements;
+	uint16_t crpl;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	jnode = get_node_by_unicast(unicast);
+	if (!jnode)
+		return false;
+
+	/* skip page -- We only support Page Zero */
+	data++;
+	len--;
+
+	/* If "crpl" property is present, composition is already recorded */
+	if (json_object_object_get_ex(jnode, "crpl", &jobj))
+		return true;
+
+	if (!write_uint16_hex(jnode, "cid", l_get_le16(&data[0])))
+		return false;
+
+	if (!write_uint16_hex(jnode, "pid", l_get_le16(&data[2])))
+		return false;
+
+	if (!write_uint16_hex(jnode, "vid", l_get_le16(&data[4])))
+		return false;
+
+	crpl = l_get_le16(&data[6]);
+
+	features = l_get_le16(&data[8]);
+	data += 10;
+	len -= 10;
+
+	jobj = json_object_object_get(jnode, "features");
+	if (!jobj) {
+		jobj = json_object_new_object();
+		json_object_object_add(jnode, "features", jobj);
+	}
+
+	if (!(features & FEATURE_RELAY))
+		write_int(jobj, "relay", 2);
+
+	if (!(features & FEATURE_FRIEND))
+		write_int(jobj, "friend", 2);
+
+	if (!(features & FEATURE_PROXY))
+		write_int(jobj, "proxy", 2);
+
+	if (!(features & FEATURE_LPN))
+		write_int(jobj, "lowPower", 2);
+
+	jelements = json_object_object_get(jnode, "elements");
+	if (!jelements)
+		return false;
+
+	sz = json_object_array_length(jelements);
+
+	while (len) {
+		json_object *jentry, *jmods;
+		uint32_t mod_id;
+		uint8_t m, v;
+
+		/* Mismatch in the element count */
+		if (i >= sz)
+			return false;
+
+		jentry = json_object_array_get_idx(jelements, i);
+
+		if (!write_uint16_hex(jentry, "location", l_get_le16(data)))
+			return false;
+
+		data += 2;
+		len -= 2;
+
+		m = *data++;
+		v = *data++;
+		len -= 2;
+
+		jmods = json_object_object_get(jentry, "models");
+		if (!jmods || json_object_get_type(jmods) != json_type_array)
+			return false;
+
+		while (len >= 2 && m--) {
+			mod_id = l_get_le16(data);
+
+			jobj = init_model(mod_id);
+			if (!jobj)
+				goto fail;
+
+			json_object_array_add(jmods, jobj);
+			data += 2;
+			len -= 2;
+		}
+
+		while (len >= 4 && v--) {
+			jobj = json_object_new_object();
+			mod_id = l_get_le16(data + 2);
+			mod_id = l_get_le16(data) << 16 | mod_id;
+
+			jobj = init_vendor_model(mod_id);
+			if (!jobj)
+				goto fail;
+
+			json_object_array_add(jmods, jobj);
+
+			data += 4;
+			len -= 4;
+		}
+
+		i++;
+	}
+
+	/* CRPL is written last. Will be used to check composition's presence */
+	if (!write_uint16_hex(jnode, "crpl", crpl))
+		goto fail;
+
+	/* Initiate remote's composition from storage */
+	if (!load_composition(jnode, unicast))
+		goto fail;
+
+	return save_config();
+
+fail:
+	/* Reset elements array */
+	json_object_object_del(jnode, "elements");
+	init_elements(sz);
+
+	return false;
+}
+
 bool mesh_db_get_token(uint8_t token[8])
 {
 	if (!cfg || !cfg->jcfg)
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 1f9e4e3d3..89c644400 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -38,11 +38,11 @@ bool mesh_db_get_addr_range(uint16_t *low, uint16_t *high);
 bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 							uint16_t net_idx);
 bool mesh_db_del_node(uint16_t unicast);
-bool mesh_db_node_set_composition(uint16_t unicast, uint16_t cid, uint16_t pid,
-						uint16_t vid, uint16_t crpl,
-						struct mesh_config_modes modes,
-						struct l_queue *elements);
-
+bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data,
+								uint16_t len);
+bool mesh_db_add_provisioner(const char *name, uint8_t uuid[16],
+				uint16_t unicast_low, uint16_t unicast_high,
+				uint16_t group_low, uint16_t group_high);
 bool mesh_db_node_set_net_transmit(uint16_t unicast, uint8_t cnt,
 							uint16_t interval);
 bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx);
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 24bc59129..344de798b 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -35,12 +35,14 @@ struct remote_node {
 	uint16_t unicast;
 	struct l_queue *net_keys;
 	struct l_queue *app_keys;
+	struct l_queue **els;
 	uint8_t uuid[16];
 	uint8_t num_ele;
 };
 
 static struct l_queue *nodes;
 
+
 static bool key_present(struct l_queue *keys, uint16_t app_idx)
 {
 	const struct l_queue_entry *l;
@@ -55,6 +57,26 @@ static bool key_present(struct l_queue *keys, uint16_t app_idx)
 	return false;
 }
 
+static int compare_mod_id(const void *a, const void *b, void *user_data)
+{
+	uint32_t id1 = L_PTR_TO_UINT(a);
+	uint32_t id2 = L_PTR_TO_UINT(b);
+
+	if (id1 >= VENDOR_ID_MASK)
+		id1 &= ~VENDOR_ID_MASK;
+
+	if (id2 >= VENDOR_ID_MASK)
+		id2 &= ~VENDOR_ID_MASK;
+
+	if (id1 < id2)
+		return -1;
+
+	if (id1 > id2)
+		return 1;
+
+	return 0;
+}
+
 static int compare_unicast(const void *a, const void *b, void *user_data)
 {
 	const struct remote_node *a_rmt = a;
@@ -92,7 +114,7 @@ static bool match_bound_key(const void *a, const void *b)
 uint8_t remote_del_node(uint16_t unicast)
 {
 	struct remote_node *rmt;
-	uint8_t num_ele;
+	uint8_t num_ele, i;
 
 	rmt = l_queue_remove_if(nodes, match_node_addr, L_UINT_TO_PTR(unicast));
 	if (!rmt)
@@ -100,8 +122,13 @@ uint8_t remote_del_node(uint16_t unicast)
 
 	num_ele = rmt->num_ele;
 
-	l_queue_destroy(rmt->net_keys, NULL);
-	l_queue_destroy(rmt->app_keys, NULL);
+	for (i = 0; i < num_ele; ++i)
+		l_queue_destroy(rmt->els[i], NULL);
+
+	l_free(rmt->els);
+
+	l_queue_destroy(rmt->net_keys, l_free);
+	l_queue_destroy(rmt->app_keys, l_free);
 	l_free(rmt);
 
 	mesh_db_del_node(unicast);
@@ -126,6 +153,8 @@ bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 
 	l_queue_push_tail(rmt->net_keys, L_UINT_TO_PTR(net_idx));
 
+	rmt->els = l_new(struct l_queue *, ele_cnt);
+
 	if (!nodes)
 		nodes = l_queue_new();
 
@@ -133,6 +162,30 @@ bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 	return true;
 }
 
+bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
+								bool vendor)
+{
+	struct remote_node *rmt;
+
+	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(unicast));
+	if (!rmt)
+		return false;
+
+	if (ele_idx >= rmt->num_ele)
+		return false;
+
+	if (!rmt->els[ele_idx])
+		rmt->els[ele_idx] = l_queue_new();
+
+	if (!vendor)
+		mod_id = VENDOR_ID_MASK | mod_id;
+
+	l_queue_insert(rmt->els[ele_idx], L_UINT_TO_PTR(mod_id),
+							compare_mod_id, NULL);
+
+	return true;
+}
+
 bool remote_add_net_key(uint16_t addr, uint16_t net_idx)
 {
 	struct remote_node *rmt;
@@ -224,9 +277,35 @@ static void print_key(void *key, void *user_data)
 	bt_shell_printf("%u (0x%3.3x), ", idx, idx);
 }
 
+static void print_model(void *model, void *user_data)
+{
+	uint32_t mod_id = L_PTR_TO_UINT(model);
+
+	if (mod_id >= VENDOR_ID_MASK) {
+		mod_id &= ~VENDOR_ID_MASK;
+		bt_shell_printf("\t\t\t" COLOR_GREEN "SIG model: %4.4x\n"
+							COLOR_OFF, mod_id);
+		return;
+	}
+
+	bt_shell_printf("\t\t\t" COLOR_GREEN "Vendor model: %8.8x\n"
+							COLOR_OFF, mod_id);
+
+}
+
+static void print_element(struct l_queue *mods, int idx)
+{
+	if (!mods)
+		return;
+
+	bt_shell_printf("\t\t" COLOR_GREEN "element %u:\n" COLOR_OFF, idx);
+	l_queue_foreach(mods, print_model, NULL);
+}
+
 static void print_node(void *rmt, void *user_data)
 {
 	struct remote_node *node = rmt;
+	int i;
 	char *str;
 
 	bt_shell_printf(COLOR_YELLOW "Mesh node:\n" COLOR_OFF);
@@ -235,8 +314,6 @@ static void print_node(void *rmt, void *user_data)
 	l_free(str);
 	bt_shell_printf("\t" COLOR_GREEN "primary = %4.4x\n" COLOR_OFF,
 								node->unicast);
-	bt_shell_printf("\t" COLOR_GREEN "elements = %u\n" COLOR_OFF,
-								node->num_ele);
 	bt_shell_printf("\t" COLOR_GREEN "net_keys = ");
 	l_queue_foreach(node->net_keys, print_key, NULL);
 	bt_shell_printf("\n" COLOR_OFF);
@@ -246,6 +323,12 @@ static void print_node(void *rmt, void *user_data)
 		l_queue_foreach(node->app_keys, print_key, NULL);
 		bt_shell_printf("\n" COLOR_OFF);
 	}
+
+	bt_shell_printf("\t" COLOR_GREEN "elements (%u):\n" COLOR_OFF,
+								node->num_ele);
+
+	for (i = 0; i < node->num_ele; ++i)
+		print_element(node->els[i], i);
 }
 
 void remote_print_node(uint16_t addr)
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index 63382ed90..33398c8bd 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -20,6 +20,8 @@
 bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx);
 uint8_t remote_del_node(uint16_t unicast);
+bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
+								bool vendor);
 uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt);
 bool remote_add_net_key(uint16_t addr, uint16_t net_idx);
 bool remote_del_net_key(uint16_t addr, uint16_t net_idx);
-- 
2.21.3

