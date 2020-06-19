Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2819C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A698121924
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgFSV1D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:27:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:21821 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgFSV1C (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 17:27:02 -0400
IronPort-SDR: fhx5DojSC2jByxoPM4VygngvxYXRAveG4YefZTzhzHL98p6UteTjLtDM3HQ0S+xNKeBBxecwmI
 AAduqQSQRG2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="143045129"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="143045129"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 14:27:01 -0700
IronPort-SDR: sa/Gvf6iXBl5/AGg/zfcK95b4ci2Lk5kpMNSdpO1ZF4+kLOX+OKUK/nBYUWPzmIiZfJKyhdaWT
 t9geknA0HdqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="292246249"
Received: from pafleisc-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.109.121])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2020 14:27:01 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/3] tools/mesh-cfgclient: add list of blacklisted addresses
Date:   Fri, 19 Jun 2020 14:26:55 -0700
Message-Id: <20200619212655.107839-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619212655.107839-1-inga.stotland@intel.com>
References: <20200619212655.107839-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a concept of "blacklisted" addresses. that a provisioner is
not allowed to assign to newly added mesh nodes.
An address may be "blacklisted" is a node has been removed from the network
(e.g., after node reset procedure). This ensures that the addresses are not
reused for provisioning new nodes to prevent a potential communication
problem due to saved RPL entries associated with these addresses in the
rest of the mesh network. The address is "cleared", when IV index updates
at least twice.
---
 tools/mesh-cfgclient.c |   2 +
 tools/mesh/mesh-db.c   | 145 +++++++++++++++++++++++++++++++++++++++++
 tools/mesh/mesh-db.h   |   2 +
 tools/mesh/remote.c    | 110 ++++++++++++++++++++++++++++---
 tools/mesh/remote.h    |   3 +
 5 files changed, 252 insertions(+), 10 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index da9f83c29..0dd02fad8 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -699,6 +699,7 @@ static void attach_node_reply(struct l_dbus_proxy *proxy,
 							ivi != iv_index) {
 		iv_index = ivi;
 		mesh_db_set_iv_index(ivi);
+		remote_clear_blacklisted_addresses(ivi);
 	}
 
 	return;
@@ -1823,6 +1824,7 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 
 			iv_index = ivi;
 			mesh_db_set_iv_index(ivi);
+			remote_clear_blacklisted_addresses(ivi);
 		}
 	}
 }
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index dbeed0214..7f2d5b358 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1255,6 +1255,143 @@ bool mesh_db_set_iv_index(uint32_t ivi)
 	return save_config();
 }
 
+static int get_blacklisted_by_iv_index(json_object *jarray, uint32_t iv_index)
+{
+	int i, cnt;
+
+	cnt = json_object_array_length(jarray);
+
+	for (i = 0; i < cnt; i++) {
+		json_object *jentry;
+		int index;
+
+		jentry = json_object_array_get_idx(jarray, i);
+
+		if (!get_int(jentry, "ivIndex", &index))
+			continue;
+
+		if (iv_index == (uint32_t)index)
+			return i;
+	}
+
+	return -1;
+}
+
+static bool load_blacklisted(json_object *jobj)
+{
+	json_object *jarray;
+	int i, cnt;
+
+	json_object_object_get_ex(jobj, "blacklistedAddresses", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return true;
+
+	cnt = json_object_array_length(jarray);
+
+	for (i = 0; i < cnt; i++) {
+		json_object *jaddrs, *jentry, *jval;
+		int iv_index, addr_cnt, j;
+
+		jentry = json_object_array_get_idx(jarray, i);
+
+		if (!get_int(jentry, "ivIndex", &iv_index))
+			return false;
+
+		if (!json_object_object_get_ex(jentry, "addresses",
+								&jaddrs))
+			return false;
+
+		addr_cnt = json_object_array_length(jaddrs);
+
+		for (j = 0; j < addr_cnt; j++) {
+			const char *str;
+			uint16_t unicast;
+
+			jval = json_object_array_get_idx(jaddrs, j);
+			str = json_object_get_string(jval);
+
+			if (sscanf(str, "%04hx", &unicast) != 1)
+				return false;
+
+			remote_add_blacklisted_address(unicast, iv_index,
+								false);
+		}
+	}
+
+	return true;
+}
+
+bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index)
+{
+	json_object *jarray, *jobj, *jaddrs, *jstring;
+	int idx;
+	char buf[5];
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	json_object_object_get_ex(cfg->jcfg, "blacklistedAddresses", &jarray);
+	if (!jarray) {
+		jarray = json_object_new_array();
+		json_object_object_add(cfg->jcfg, "blacklistedAddresses",
+									jarray);
+	}
+
+	idx = get_blacklisted_by_iv_index(jarray, iv_index);
+
+	if (idx < 0) {
+		jobj = json_object_new_object();
+
+		if (!write_int(jobj, "ivIndex", iv_index))
+			goto fail;
+
+		jaddrs = json_object_new_array();
+		json_object_object_add(jobj, "addresses", jaddrs);
+
+	} else {
+		jobj = json_object_array_get_idx(jarray, idx);
+	}
+
+	json_object_object_get_ex(jobj, "addresses", &jaddrs);
+
+	snprintf(buf, 5, "%4.4x", unicast);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		goto fail;
+
+	json_object_array_add(jaddrs, jstring);
+
+	if (idx < 0)
+		json_object_array_add(jarray, jobj);
+
+	return save_config();
+
+fail:
+	json_object_put(jobj);
+	return false;
+}
+
+bool mesh_db_clear_blacklisted(uint32_t iv_index)
+{
+	json_object *jarray;
+	int idx;
+
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	json_object_object_get_ex(cfg->jcfg, "blacklistedAddresses", &jarray);
+	if (!jarray || json_object_get_type(jarray) != json_type_array)
+		return false;
+
+	idx = get_blacklisted_by_iv_index(jarray, iv_index);
+	if (idx < 0)
+		return true;
+
+	json_object_array_del_idx(jarray, idx, 1);
+
+	return save_config();
+}
+
 bool mesh_db_create(const char *fname, const uint8_t token[8],
 							const char *mesh_name)
 {
@@ -1305,6 +1442,12 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 
 	json_object_object_add(jcfg, "appKeys", jarray);
 
+	jarray = json_object_new_array();
+	if (!jarray)
+		goto fail;
+
+	json_object_object_add(jcfg, "blacklistedAddresses", jarray);
+
 	write_int(jcfg, "ivIndex", 0);
 
 	if (!save_config())
@@ -1370,6 +1513,8 @@ bool mesh_db_load(const char *fname)
 
 	load_remotes(jcfg);
 
+	load_blacklisted(jcfg);
+
 	return true;
 fail:
 	release_config();
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 83fcfbee7..49af33e87 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -58,3 +58,5 @@ bool mesh_db_node_model_binding_del(uint16_t unicast, uint8_t ele, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
 struct l_queue *mesh_db_load_groups(void);
 bool mesh_db_add_group(struct mesh_group *grp);
+bool mesh_db_add_blacklisted_addr(uint16_t unicast, uint32_t iv_index);
+bool mesh_db_clear_blacklisted(uint32_t iv_index);
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 344de798b..2a8f747d6 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -31,6 +31,8 @@
 #include "tools/mesh/mesh-db.h"
 #include "tools/mesh/remote.h"
 
+#define abs_diff(a, b) ((a) > (b) ? (a) - (b) : (b) - (a))
+
 struct remote_node {
 	uint16_t unicast;
 	struct l_queue *net_keys;
@@ -40,8 +42,13 @@ struct remote_node {
 	uint8_t num_ele;
 };
 
-static struct l_queue *nodes;
+struct blacklisted_addr {
+	uint32_t iv_index;
+	uint16_t unicast;
+};
 
+static struct l_queue *nodes;
+static struct l_queue *blacklisted;
 
 static bool key_present(struct l_queue *keys, uint16_t app_idx)
 {
@@ -115,6 +122,7 @@ uint8_t remote_del_node(uint16_t unicast)
 {
 	struct remote_node *rmt;
 	uint8_t num_ele, i;
+	uint32_t iv_index = mesh_db_get_iv_index();
 
 	rmt = l_queue_remove_if(nodes, match_node_addr, L_UINT_TO_PTR(unicast));
 	if (!rmt)
@@ -122,9 +130,10 @@ uint8_t remote_del_node(uint16_t unicast)
 
 	num_ele = rmt->num_ele;
 
-	for (i = 0; i < num_ele; ++i)
+	for (i = 0; i < num_ele; ++i) {
 		l_queue_destroy(rmt->els[i], NULL);
-
+		remote_add_blacklisted_address(unicast + i, iv_index, true);
+	}
 	l_free(rmt->els);
 
 	l_queue_destroy(rmt->net_keys, l_free);
@@ -331,6 +340,46 @@ static void print_node(void *rmt, void *user_data)
 		print_element(node->els[i], i);
 }
 
+static bool match_black_addr(const void *a, const void *b)
+{
+	const struct blacklisted_addr *addr = a;
+	uint16_t unicast = L_PTR_TO_UINT(b);
+
+	return addr->unicast == unicast;
+}
+
+static uint16_t get_next_addr(uint16_t high, uint16_t addr,
+							uint8_t ele_cnt)
+{
+	while ((addr + ele_cnt - 1) <= high) {
+		int i = 0;
+
+		for (i = 0; i < ele_cnt; i++) {
+			struct blacklisted_addr *black;
+
+			black = l_queue_find(blacklisted, match_black_addr,
+						L_UINT_TO_PTR(addr + i));
+			if (!black)
+				break;
+		}
+
+		addr += i;
+
+		if ((i != ele_cnt) && (addr + ele_cnt - 1) <= high)
+			return addr;
+	}
+
+	return 0;
+}
+
+static bool check_iv_index(const void *a, const void *b)
+{
+	const struct blacklisted_addr *black_addr = a;
+	uint32_t iv_index = L_PTR_TO_UINT(b);
+
+	return (abs_diff(iv_index, black_addr->iv_index) > 2);
+}
+
 void remote_print_node(uint16_t addr)
 {
 	struct remote_node *rmt;
@@ -373,15 +422,56 @@ uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt)
 	for (; l; l = l->next) {
 		rmt = l->data;
 
-		if (rmt->unicast >= (addr + ele_cnt))
-			return addr;
+		if (rmt->unicast < low)
+			continue;
+
+		if (rmt->unicast >= (addr + ele_cnt)) {
+			uint16_t unicast;
 
-		if ((rmt->unicast + rmt->num_ele) > addr)
-			addr = rmt->unicast + rmt->num_ele;
+			unicast = get_next_addr(rmt->unicast - 1, addr,
+								ele_cnt);
+			if (unicast)
+				return unicast;
+		}
+
+		addr = rmt->unicast + rmt->num_ele;
 	}
 
-	if ((addr + ele_cnt - 1) <= high)
-		return addr;
+	addr = get_next_addr(high, addr, ele_cnt);
 
-	return 0;
+	return addr;
+}
+
+void remote_add_blacklisted_address(uint16_t addr, uint32_t iv_index,
+								bool save)
+{
+	struct blacklisted_addr *black_addr;
+
+	if (!blacklisted)
+		blacklisted = l_queue_new();
+
+	black_addr = l_new(struct blacklisted_addr, 1);
+	black_addr->unicast = addr;
+	black_addr->iv_index = iv_index;
+
+	l_queue_push_tail(blacklisted, black_addr);
+
+	if (save)
+		mesh_db_add_blacklisted_addr(addr, iv_index);
+}
+
+void remote_clear_blacklisted_addresses(uint32_t iv_index)
+{
+	struct blacklisted_addr *black_addr;
+
+	black_addr = l_queue_remove_if(blacklisted, check_iv_index,
+						L_UINT_TO_PTR(iv_index));
+
+	while (black_addr) {
+		l_free(black_addr);
+		black_addr = l_queue_remove_if(blacklisted, check_iv_index,
+						L_UINT_TO_PTR(iv_index));
+	}
+
+	mesh_db_clear_blacklisted(iv_index);
 }
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index 33398c8bd..482817c5a 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -22,6 +22,9 @@ bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 uint8_t remote_del_node(uint16_t unicast);
 bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 								bool vendor);
+void remote_add_blacklisted_address(uint16_t addr, uint32_t iv_index,
+								bool save);
+void remote_clear_blacklisted_addresses(uint32_t iv_index);
 uint16_t remote_get_next_unicast(uint16_t low, uint16_t high, uint8_t ele_cnt);
 bool remote_add_net_key(uint16_t addr, uint16_t net_idx);
 bool remote_del_net_key(uint16_t addr, uint16_t net_idx);
-- 
2.26.2

