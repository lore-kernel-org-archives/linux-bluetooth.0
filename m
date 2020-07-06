Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E7BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 19:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B512120675
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 19:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGFTtV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:49:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:57184 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFTtV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 15:49:21 -0400
IronPort-SDR: d2SYP8NrcID7gy0W2y22xT0JU80mWmdm8oLnJ+CPfQcA39EAmlDV4e+PTLX2UMlJNJzSF5BB9x
 a3KRA6Lk24PQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="165565754"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="165565754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 12:49:20 -0700
IronPort-SDR: 3cNi2f3rcLBqZvJMG3OO7luTvPyWosHjSg6C+2eGLTDZ38G0wIrV2qQ8xJRtXI2RMLbzwv+X+Q
 qsoZNb6p1K3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="388285975"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.228.100])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2020 12:49:20 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Add Composition page storage to node.json
Date:   Mon,  6 Jul 2020 12:49:15 -0700
Message-Id: <20200706194915.189849-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/cfgmod-server.c    |  42 ++++++++++---
 mesh/mesh-config-json.c | 131 +++++++++++++++++++++++++++++++++++++++
 mesh/mesh-config.h      |  12 ++++
 mesh/node.c             | 132 +++++++++++++++++++++++++++++++++-------
 mesh/node.h             |   6 +-
 5 files changed, 291 insertions(+), 32 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index c525d9d24..6194fc7d4 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -34,6 +34,12 @@
 
 #define CFG_MAX_MSG_LEN 380
 
+/* Supported composition pages, sorted high to low */
+/* Only page 0 is currently supported */
+static const uint8_t supported_pages[] = {
+	0
+};
+
 static void send_pub_status(struct mesh_node *node, uint16_t net_idx,
 			uint16_t src, uint16_t dst,
 			uint8_t status, uint16_t ele_addr, uint32_t mod_id,
@@ -701,6 +707,33 @@ static void node_reset(void *user_data)
 	node_remove(node);
 }
 
+static uint16_t get_composition(struct mesh_node *node, uint8_t page,
+								uint8_t *buf)
+{
+	const uint8_t *comp;
+	uint16_t len = 0;
+	size_t i;
+
+	for (i = 0; i < sizeof(supported_pages); i++) {
+		if (page < supported_pages[i])
+			continue;
+
+		page = supported_pages[i];
+		comp = node_get_comp(node, page, &len);
+
+		if (!page || len)
+			break;
+	}
+
+	if (!len)
+		return 0;
+
+	*buf++ = page;
+	memcpy(buf, comp, len);
+
+	return len + 1;
+}
+
 static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 				uint16_t net_idx, const uint8_t *data,
 				uint16_t size, const void *user_data)
@@ -746,16 +779,9 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		if (size != 1)
 			return false;
 
-		/* Only page 0 is currently supported */
-		if (pkt[0] != 0) {
-			l_debug("Unsupported page number %d", pkt[0]);
-			l_debug("Returning page number 0");
-		}
 		long_msg = l_malloc(CFG_MAX_MSG_LEN);
 		n = mesh_model_opcode_set(OP_DEV_COMP_STATUS, long_msg);
-		long_msg[n++] = 0;
-		n += node_generate_comp(node, long_msg + n,
-							CFG_MAX_MSG_LEN - n);
+		n += get_composition(node, pkt[0], long_msg + n);
 
 		break;
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 661775f95..aef5540c0 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -430,6 +430,54 @@ static bool read_device_key(json_object *jobj, uint8_t key_buf[16])
 	return true;
 }
 
+static bool read_comp_pages(json_object *jobj, struct mesh_config_node *node)
+{
+	json_object *jarray, *jentry;
+	struct mesh_config_comp_page *page;
+	int len;
+	int i;
+
+	if (!json_object_object_get_ex(jobj, "pages", &jarray))
+		return true;
+
+	if (json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	len = json_object_array_length(jarray);
+
+	for (i = 0; i < len; i++) {
+		size_t clen;
+		char *str;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		str = (char *)json_object_get_string(jentry);
+		clen = strlen(str);
+
+		if (clen < ((MIN_COMP_SIZE * 2) + 1))
+			continue;
+
+		clen = (clen / 2) - 1;
+
+		page = l_malloc(sizeof(struct mesh_config_comp_page) + clen);
+
+		if (!str2hex(str + 2, clen * 2, page->data, clen))
+			goto parse_fail;
+
+		if (sscanf(str, "%02hhx", &page->page_num) != 1)
+			goto parse_fail;
+
+		page->len = clen;
+
+		l_queue_push_tail(node->pages, page);
+	}
+
+	return true;
+
+parse_fail:
+	l_free(page);
+	return false;
+}
+
 static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 {
 	json_object *jarray;
@@ -1384,6 +1432,11 @@ static bool read_node(json_object *jnode, struct mesh_config_node *node)
 		return false;
 	}
 
+	if (!read_comp_pages(jnode, node)) {
+		l_info("Failed to read Composition Pages");
+		return false;
+	}
+
 	if (!parse_elements(jvalue, node)) {
 		l_info("Failed to parse elements");
 		return false;
@@ -1889,6 +1942,82 @@ bool mesh_config_model_pub_del(struct mesh_config *cfg, uint16_t addr,
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
+static void del_page(json_object *jarray, uint8_t page)
+{
+	char buf[3];
+	int i, len;
+
+	if (!jarray)
+		return;
+
+	snprintf(buf, 3, "%2.2x", page);
+
+	len = json_object_array_length(jarray);
+
+	for (i = 0; i < len; i++) {
+		json_object *jentry;
+		char *str;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		str = (char *)json_object_get_string(jentry);
+
+		/* Delete matching page(s) */
+		if (!memcmp(str, buf, 2))
+			json_object_array_del_idx(jarray, i, 1);
+	}
+}
+
+bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
+						uint8_t *data, uint16_t size)
+{
+	json_object *jnode, *jstring, *jarray = NULL;
+	char *buf;
+	int len;
+
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
+	json_object_object_get_ex(jnode, "pages", &jarray);
+
+	len = (size * 2) + 3;
+	buf = l_malloc(len);
+	snprintf(buf, len, "%2.2x", page);
+	hex2str(data, size, buf + 2, len - 2);
+
+	if (jarray && jarray_has_string(jarray, buf, len)) {
+		l_free(buf);
+		return true;
+	} else if (!jarray) {
+		jarray = json_object_new_array();
+		json_object_object_add(jnode, "pages", jarray);
+	} else
+		del_page(jarray, page);
+
+	jstring = json_object_new_string(buf);
+	json_object_array_add(jarray, jstring);
+	l_free(buf);
+
+	return save_config(jnode, cfg->node_dir_path);
+}
+
+bool mesh_config_comp_page_del(struct mesh_config *cfg, uint8_t page)
+{
+	json_object *jnode, *jarray = NULL;
+
+	if (!cfg)
+		return false;
+
+	jnode = cfg->jnode;
+
+	json_object_object_get_ex(jnode, "pages", &jarray);
+
+	del_page(jarray, page);
+
+	return true;
+}
+
 bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
 						struct mesh_config_sub *sub)
@@ -2212,6 +2341,7 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
 	node.elements = l_queue_new();
 	node.netkeys = l_queue_new();
 	node.appkeys = l_queue_new();
+	node.pages = l_queue_new();
 
 	result = read_node(jnode, &node);
 
@@ -2238,6 +2368,7 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
 	l_free(node.net_transmit);
 	l_queue_destroy(node.netkeys, l_free);
 	l_queue_destroy(node.appkeys, l_free);
+	l_queue_destroy(node.pages, l_free);
 	l_queue_destroy(node.elements, free_element);
 
 	if (!result)
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 9f30e693b..e1107bbe5 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -17,6 +17,8 @@
  *
  */
 
+#define MIN_COMP_SIZE 14
+
 struct mesh_config;
 
 struct mesh_config_sub {
@@ -88,10 +90,17 @@ struct mesh_config_transmit {
 	uint8_t count;
 };
 
+struct mesh_config_comp_page {
+	uint16_t len;
+	uint8_t page_num;
+	uint8_t data[];
+};
+
 struct mesh_config_node {
 	struct l_queue *elements;
 	struct l_queue *netkeys;
 	struct l_queue *appkeys;
+	struct l_queue *pages;
 	uint32_t seq_number;
 	uint32_t iv_index;
 	bool iv_update;
@@ -139,6 +148,9 @@ bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl);
 bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value);
+bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
+						uint8_t *data, uint16_t size);
+bool mesh_config_comp_page_del(struct mesh_config *cfg, uint8_t page);
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 						bool vendor, uint32_t mod_id,
 							uint16_t app_idx);
diff --git a/mesh/node.c b/mesh/node.c
index 3e888ce61..a01842c95 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -46,8 +46,6 @@
 #include "mesh/manager.h"
 #include "mesh/node.h"
 
-#define MIN_COMP_SIZE 14
-
 #define MESH_NODE_PATH_PREFIX "/node"
 
 /* Default values for a new locally created node */
@@ -81,6 +79,7 @@ struct node_composition {
 struct mesh_node {
 	struct mesh_net *net;
 	struct l_queue *elements;
+	struct l_queue *pages;
 	char *app_path;
 	char *owner;
 	char *obj_path;
@@ -266,6 +265,7 @@ static struct mesh_node *node_new(const uint8_t uuid[16])
 	node = l_new(struct mesh_node, 1);
 	node->net = mesh_net_new(node);
 	node->elements = l_queue_new();
+	node->pages = l_queue_new();
 	memcpy(node->uuid, uuid, sizeof(node->uuid));
 	set_defaults(node);
 
@@ -335,6 +335,7 @@ static void free_node_resources(void *data)
 	/* Free dynamic resources */
 	free_node_dbus_resources(node);
 	l_queue_destroy(node->elements, element_free);
+	l_queue_destroy(node->pages, l_free);
 	mesh_agent_remove(node->agent);
 	mesh_config_release(node->cfg);
 	mesh_net_free(node->net);
@@ -557,8 +558,15 @@ static bool init_from_storage(struct mesh_config_node *db_node,
 
 	l_queue_foreach(db_node->netkeys, set_net_key, node);
 
-	if (db_node->appkeys)
-		l_queue_foreach(db_node->appkeys, set_appkey, node);
+	l_queue_foreach(db_node->appkeys, set_appkey, node);
+
+	while (l_queue_length(db_node->pages)) {
+		struct mesh_config_comp_page *page;
+
+		/* Move the composition pages to the node struct */
+		page = l_queue_pop_head(db_node->pages);
+		l_queue_push_tail(node->pages, page);
+	}
 
 	mesh_net_set_seq_num(node->net, node->seq_number);
 	mesh_net_set_default_ttl(node->net, node->ttl);
@@ -877,7 +885,8 @@ uint8_t node_friend_mode_get(struct mesh_node *node)
 	return node->friend;
 }
 
-uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
+static uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf,
+								uint16_t sz)
 {
 	uint16_t n, features;
 	uint16_t num_ele = 0;
@@ -991,6 +1000,80 @@ element_done:
 	return n;
 }
 
+static bool match_page(const void *a, const void *b)
+{
+	const struct mesh_config_comp_page *page = a;
+	uint8_t page_num = L_PTR_TO_UINT(b);
+
+	return page->page_num == page_num;
+}
+
+bool node_set_comp(struct mesh_node *node, uint8_t page_num,
+					const uint8_t *data, uint16_t len)
+{
+	struct mesh_config_comp_page *page;
+
+	if (!node || len < MIN_COMP_SIZE)
+		return false;
+
+	page = l_queue_remove_if(node->pages, match_page,
+						L_UINT_TO_PTR(page_num));
+
+	l_free(page);
+
+	page = l_malloc(sizeof(struct mesh_config_comp_page) + len);
+	page->len = len;
+	page->page_num = page_num;
+	memcpy(page->data, data, len);
+	l_queue_push_tail(node->pages, page);
+
+	mesh_config_comp_page_add(node->cfg, page_num, page->data, len);
+
+	return true;
+}
+
+const uint8_t *node_get_comp(struct mesh_node *node, uint8_t page_num,
+								uint16_t *len)
+{
+	struct mesh_config_comp_page *page = NULL;
+
+	if (node)
+		page = l_queue_find(node->pages, match_page,
+						L_UINT_TO_PTR(page_num));
+
+	if (!page) {
+		*len = 0;
+		return NULL;
+	}
+
+	*len = page->len;
+	return page->data;
+}
+
+bool node_replace_comp(struct mesh_node *node, uint8_t retire, uint8_t with)
+{
+	struct mesh_config_comp_page *old_page, *keep;
+
+	if (!node)
+		return false;
+
+	keep = l_queue_find(node->pages, match_page, L_UINT_TO_PTR(with));
+
+	if (!keep)
+		return false;
+
+	old_page = l_queue_remove_if(node->pages, match_page,
+							L_UINT_TO_PTR(retire));
+
+	mesh_config_comp_page_del(node->cfg, with);
+	mesh_config_comp_page_add(node->cfg, retire, keep->data, keep->len);
+
+	l_free(old_page);
+	keep->page_num = retire;
+
+	return true;
+}
+
 static void attach_io(void *a, void *b)
 {
 	struct mesh_node *node = a;
@@ -1486,27 +1569,30 @@ static void update_model_options(struct mesh_node *node,
 
 static bool check_req_node(struct managed_obj_request *req)
 {
-	uint8_t node_comp[MAX_MSG_LEN - 2];
-	uint8_t attach_comp[MAX_MSG_LEN - 2];
-	uint16_t offset = 10;
-	uint16_t node_len = node_generate_comp(req->node, node_comp,
-							sizeof(node_comp));
+	struct mesh_node *node;
+	const int offset = 8;
+	uint16_t node_len, len;
+	uint8_t comp[MAX_MSG_LEN - 2];
+	const uint8_t *node_comp;
 
-	if (!node_len)
-		return false;
+	if (req->type == REQUEST_TYPE_ATTACH)
+		node = req->attach;
+	else
+		node = req->node;
 
-	if (req->type == REQUEST_TYPE_ATTACH) {
-		uint16_t attach_len = node_generate_comp(req->attach,
-					attach_comp, sizeof(attach_comp));
+	node_comp = node_get_comp(node, 0, &node_len);
+	len = node_generate_comp(node, comp, sizeof(comp));
 
-		/* Verify only element/models composition */
-		if (node_len != attach_len ||
-				memcmp(&node_comp[offset], &attach_comp[offset],
-							node_len - offset)) {
-			l_debug("Failed to verify app's composition data");
-			return false;
-		}
-	}
+	/* If no page 0 exists, save it and return */
+	if (req->type != REQUEST_TYPE_ATTACH || !node_len || !node_comp)
+		return node_set_comp(node, 0, comp, len);
+
+	if (node_len != len || memcmp(&node_comp[offset], &comp[offset],
+							node_len - offset))
+		return false;
+
+	else if (memcmp(node_comp, comp, node_len))
+		return node_set_comp(node, 0, comp, len);
 
 	return true;
 }
diff --git a/mesh/node.h b/mesh/node.h
index 6c4542a78..df058458a 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -63,7 +63,11 @@ struct l_queue *node_get_element_models(struct mesh_node *node, uint8_t ele_idx,
 uint16_t node_get_crpl(struct mesh_node *node);
 bool node_init_from_storage(struct mesh_node *node, const uint8_t uuid[16],
 					struct mesh_config_node *db_node);
-uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz);
+const uint8_t *node_get_comp(struct mesh_node *node, uint8_t page_num,
+								uint16_t *len);
+bool node_set_comp(struct mesh_node *node, uint8_t page_num,
+					const uint8_t *data, uint16_t len);
+bool node_replace_comp(struct mesh_node *node, uint8_t retire, uint8_t with);
 uint8_t node_lpn_mode_get(struct mesh_node *node);
 bool node_relay_mode_set(struct mesh_node *node, bool enable, uint8_t cnt,
 							uint16_t interval);
-- 
2.25.4

