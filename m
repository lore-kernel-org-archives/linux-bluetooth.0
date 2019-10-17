Return-Path: <SRS0=wWRn=YK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E0ECE599
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 03:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE92218DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Oct 2019 03:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390685AbfJQDLy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:11:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:30646 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388274AbfJQDLy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 23:11:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 20:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,306,1566889200"; 
   d="scan'208";a="397381923"
Received: from ingas-nuc1.sea.intel.com ([10.255.229.89])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2019 20:11:51 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix reading/writing key indices
Date:   Wed, 16 Oct 2019 20:11:50 -0700
Message-Id: <20191017031150.11264-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes inconsistency when reading/writing of NetKey and AppKey
indices:
	- when writing, convert an integer to a hex string
	- when reading, convert a hex string into integer
---
 mesh/mesh-config-json.c | 97 +++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 42 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 67879ed38..865fbdf07 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -45,7 +45,7 @@
 #define MIN_SEQ_CACHE_VALUE	(2 * 32)
 #define MIN_SEQ_CACHE_TIME	(5 * 60)
 
-#define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
+#define CHECK_KEY_IDX_RANGE(x) ((x) <= 4095)
 
 struct mesh_config {
 	json_object *jnode;
@@ -109,7 +109,7 @@ static bool add_u64_value(json_object *jobject, const char *desc,
 	json_object *jstring;
 	char hexstr[17];
 
-	hex2string((uint8_t *) u64, 8, hexstr, 17);
+	hex2str((uint8_t *) u64, 8, hexstr, 17);
 	jstring = json_object_new_string(hexstr);
 	if (!jstring)
 		return false;
@@ -124,7 +124,7 @@ static bool add_key_value(json_object *jobject, const char *desc,
 	json_object *jstring;
 	char hexstr[33];
 
-	hex2string((uint8_t *) key, 16, hexstr, 33);
+	hex2str((uint8_t *) key, 16, hexstr, 33);
 	jstring = json_object_new_string(hexstr);
 	if (!jstring)
 		return false;
@@ -263,13 +263,16 @@ static json_object *get_key_object(json_object *jarray, uint16_t idx)
 
 	for (i = 0; i < sz; ++i) {
 		json_object *jentry, *jvalue;
-		uint32_t jidx;
+		const char *str;
+		uint16_t jidx;
 
 		jentry = json_object_array_get_idx(jarray, i);
 		if (!json_object_object_get_ex(jentry, "index", &jvalue))
 			return NULL;
 
-		jidx = json_object_get_int(jvalue);
+		str = json_object_get_string(jvalue);
+		if (sscanf(str, "%04hx", &jidx) != 1)
+			return NULL;
 
 		if (jidx == idx)
 			return jentry;
@@ -278,6 +281,28 @@ static json_object *get_key_object(json_object *jarray, uint16_t idx)
 	return NULL;
 }
 
+static bool get_key_index(json_object *jobj, const char *keyword,
+								uint16_t *index)
+{
+	uint16_t idx;
+	json_object *jvalue;
+	const char *str;
+
+	if (!json_object_object_get_ex(jobj, keyword, &jvalue))
+		return false;
+
+	str = json_object_get_string(jvalue);
+
+	if (sscanf(str, "%04hx", &idx) != 1)
+		return false;
+
+	if (!CHECK_KEY_IDX_RANGE(idx))
+		return false;
+
+	*index = (uint16_t) idx;
+	return true;
+}
+
 static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 {
 	json_object *jarray_new;
@@ -288,16 +313,13 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 		return NULL;
 
 	for (i = 0; i < sz; ++i) {
-		json_object *jentry, *jvalue;
+		json_object *jentry;
+		uint16_t nidx;
 
 		jentry = json_object_array_get_idx(jarray, i);
 
-		if (json_object_object_get_ex(jentry, "index", &jvalue)) {
-			int tmp = json_object_get_int(jvalue);
-
-			if (tmp == idx)
-				continue;
-		}
+		if (get_key_index(jentry, "index", &nidx) && nidx == idx)
+			continue;
 
 		json_object_get(jentry);
 		json_object_array_add(jarray_new, jentry);
@@ -395,7 +417,7 @@ static bool read_token(json_object *jobj, uint8_t token[8])
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
-	if (!string2hex(str, strlen(str), token, 8))
+	if (!str2hex(str, strlen(str), token, 8))
 		return false;
 
 	return true;
@@ -413,27 +435,12 @@ static bool read_device_key(json_object *jobj, uint8_t key_buf[16])
 		return false;
 
 	str = (char *)json_object_get_string(jvalue);
-	if (!string2hex(str, strlen(str), key_buf, 16))
+	if (!str2hex(str, strlen(str), key_buf, 16))
 		return false;
 
 	return true;
 }
 
-static bool get_key_index(json_object *jobj, const char *keyword,
-								uint16_t *index)
-{
-	int idx;
-
-	if (!get_int(jobj, keyword, &idx))
-		return false;
-
-	if (!CHECK_KEY_IDX_RANGE(idx))
-		return false;
-
-	*index = (uint16_t) idx;
-	return true;
-}
-
 static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 {
 	json_object *jarray;
@@ -472,13 +479,13 @@ static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 			goto fail;
 
 		str = (char *)json_object_get_string(jvalue);
-		if (!string2hex(str, strlen(str), appkey->new_key, 16))
+		if (!str2hex(str, strlen(str), appkey->new_key, 16))
 			goto fail;
 
 		if (json_object_object_get_ex(jtemp, "oldKey", &jvalue))
 			str = (char *)json_object_get_string(jvalue);
 
-		if (!string2hex(str, strlen(str), appkey->key, 16))
+		if (!str2hex(str, strlen(str), appkey->key, 16))
 			goto fail;
 
 		l_queue_push_tail(node->appkeys, appkey);
@@ -527,7 +534,7 @@ static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 			goto fail;
 
 		str = (char *)json_object_get_string(jvalue);
-		if (!string2hex(str, strlen(str), netkey->new_key, 16))
+		if (!str2hex(str, strlen(str), netkey->new_key, 16))
 			goto fail;
 
 		if (!json_object_object_get_ex(jtemp, "keyRefresh", &jvalue))
@@ -545,7 +552,7 @@ static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 			str = (char *)json_object_get_string(jvalue);
 		}
 
-		if (!string2hex(str, strlen(str), netkey->key, 16))
+		if (!str2hex(str, strlen(str), netkey->key, 16))
 			goto fail;
 
 		l_queue_push_tail(node->netkeys, netkey);
@@ -570,6 +577,7 @@ bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t idx,
 
 	jnode = cfg->jnode;
 
+	l_debug("netKey %4.4x", idx);
 	json_object_object_get_ex(jnode, "netKeys", &jarray);
 	if (jarray)
 		jentry = get_key_object(jarray, idx);
@@ -965,14 +973,19 @@ static bool parse_bindings(json_object *jarray, struct mesh_config_model *mod)
 	mod->bindings = l_new(uint16_t, cnt);
 
 	for (i = 0; i < cnt; ++i) {
-		int idx;
+		uint16_t idx;
+		const char *str;
 		json_object *jvalue;
 
 		jvalue = json_object_array_get_idx(jarray, i);
 		if (!jvalue)
 			return false;
 
-		idx = json_object_get_int(jvalue);
+		str = json_object_get_string(jvalue);
+
+		if (sscanf(str, "%04hx", &idx) != 1)
+			return false;
+
 		if (!CHECK_KEY_IDX_RANGE(idx))
 			return false;
 
@@ -1002,7 +1015,7 @@ static struct mesh_config_pub *parse_model_publication(json_object *jpub)
 			goto fail;
 		break;
 	case 32:
-		if (!string2hex(str, len, pub->virt_addr, 16))
+		if (!str2hex(str, len, pub->virt_addr, 16))
 			goto fail;
 		pub->virt = true;
 		break;
@@ -1077,7 +1090,7 @@ static bool parse_model_subscriptions(json_object *jsubs,
 				goto fail;
 		break;
 		case 32:
-			if (!string2hex(str, len, subs[i].src.virt_addr, 16))
+			if (!str2hex(str, len, subs[i].src.virt_addr, 16))
 				goto fail;
 			subs[i].virt = true;
 			break;
@@ -1741,7 +1754,7 @@ struct mesh_config *mesh_config_create(const char *cfgdir_name,
 	struct mesh_config *cfg;
 	size_t max_len = strlen(cfgnode_name) + strlen(bak_ext);
 
-	if (!hex2string((uint8_t *) uuid, 16, uuid_buf, sizeof(uuid_buf)))
+	if (!hex2str((uint8_t *) uuid, 16, uuid_buf, sizeof(uuid_buf)))
 		return NULL;
 
 	snprintf(name_buf, PATH_MAX, "%s/%s", cfgdir_name, uuid_buf);
@@ -1950,7 +1963,7 @@ bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 		snprintf(buf, 5, "%4.4x", sub->src.addr);
 		len = 4;
 	} else {
-		hex2string(sub->src.virt_addr, 16, buf, 33);
+		hex2str(sub->src.virt_addr, 16, buf, 33);
 		len = 32;
 	}
 
@@ -2004,7 +2017,7 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 		snprintf(buf, 5, "%4.4x", sub->src.addr);
 		len = 4;
 	} else {
-		hex2string(sub->src.virt_addr, 16, buf, 33);
+		hex2str(sub->src.virt_addr, 16, buf, 33);
 		len = 32;
 	}
 
@@ -2279,7 +2292,7 @@ bool mesh_config_load_nodes(const char *cfgdir_name, mesh_config_node_func_t cb,
 		if (path_len + node_len + 1 >= PATH_MAX)
 			continue;
 
-		if (!string2hex(entry->d_name, node_len, uuid, sizeof(uuid)))
+		if (!str2hex(entry->d_name, node_len, uuid, sizeof(uuid)))
 			continue;
 
 		dirname = l_strdup_printf("%s/%s", cfgdir_name, entry->d_name);
@@ -2336,7 +2349,7 @@ void mesh_config_destroy(struct mesh_config *cfg)
 	node_dir = dirname(cfg->node_dir_path);
 	l_debug("Delete node config %s", node_dir);
 
-	if (!hex2string(cfg->uuid, 16, uuid, sizeof(uuid)))
+	if (!hex2str(cfg->uuid, 16, uuid, sizeof(uuid)))
 		return;
 
 	node_name = basename(node_dir);
-- 
2.21.0

