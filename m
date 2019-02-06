Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9975AC169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 07:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62032218A1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 07:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfBFHjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:39:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:47819 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfBFHjU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 02:39:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 23:39:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="141955295"
Received: from naram-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.86])
  by fmsmga004.fm.intel.com with ESMTP; 05 Feb 2019 23:39:20 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 5/5] mesh: Save newly added or updated net key to config file
Date:   Tue,  5 Feb 2019 23:39:18 -0800
Message-Id: <20190206073918.29193-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This separates mesh_db_net_key_add() into distinct functions:
mesh_db_net_key_add() and mesh_db_net_key_update() which will be called
based on whether a network key was newly added or updated.
---
 mesh/mesh-db.c | 122 +++++++++++++++++++++----------------------------
 mesh/mesh-db.h |   4 +-
 mesh/net.c     |   4 +-
 mesh/node.c    |  15 ++++--
 mesh/storage.c |   7 ++-
 mesh/storage.h |   5 +-
 6 files changed, 76 insertions(+), 81 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index b9bbef912..6486f7cff 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -51,7 +51,7 @@ static bool get_int(json_object *jobj, const char *keyword, int *value)
 	return true;
 }
 
-static bool add_key(json_object *jobject, const char *desc,
+static bool add_key_value(json_object *jobject, const char *desc,
 					const uint8_t key[16])
 {
 	json_object *jstring;
@@ -382,7 +382,7 @@ bool mesh_db_read_net_keys(json_object *jobj, mesh_db_net_key_cb cb,
 }
 
 bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
-					const uint8_t key[16], int phase)
+							const uint8_t key[16])
 {
 	json_object *jarray, *jentry = NULL, *jstring;
 	char buf[5];
@@ -392,91 +392,75 @@ bool mesh_db_net_key_add(json_object *jobj, uint16_t idx,
 	if (jarray)
 		jentry = get_key_object(jarray, idx);
 
-	if (jentry) {
-		uint8_t buf[16];
-		json_object *jvalue;
-		char *str;
-
-		json_object_object_get_ex(jentry, "key", &jvalue);
-		if (!jvalue)
-			return false;
-
-		str = (char *)json_object_get_string(jvalue);
-		if (!str2hex(str, strlen(str), buf, sizeof(buf)))
-			return false;
-
-		/* If the same key, return success */
-		if (memcmp(key, buf, 16) == 0)
-			return true;
+	/* Do not allow direct overwrite */
+	if (jentry)
+		return false;
 
+	jentry = json_object_new_object();
+	if (!jentry)
 		return false;
-	}
 
-	if (!jentry) {
-		jentry = json_object_new_object();
-		if (!jentry)
-			goto fail;
+	snprintf(buf, 5, "%4.4x", idx);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		goto fail;
 
-		snprintf(buf, 5, "%4.4x", idx);
-		jstring = json_object_new_string(buf);
-		if (!jstring)
-			goto fail;
+	json_object_object_add(jentry, "index", jstring);
 
-		json_object_object_add(jentry, "index", jstring);
+	if (!add_key_value(jentry, "key", key))
+		goto fail;
 
-		snprintf(buf, 5, "%4.4x", idx);
-		jstring = json_object_new_string(buf);
-		if (!jstring)
-			goto fail;
+	json_object_object_add(jentry, "keyRefresh",
+				json_object_new_int(KEY_REFRESH_PHASE_NONE));
 
-		if (!add_key(jentry, "key", key))
+	if (!jarray) {
+		jarray = json_object_new_array();
+		if (!jarray)
 			goto fail;
+		json_object_object_add(jobj, "netKeys", jarray);
+	}
 
-		/* If Key Refresh underway, add placeholder for "Old Key" */
-		if (phase != KEY_REFRESH_PHASE_NONE) {
-			uint8_t buf[16];
-			uint8_t i;
+	json_object_array_add(jarray, jentry);
 
-			/* Flip Bits to differentiate */
-			for (i = 0; i < sizeof(buf); i++)
-				buf[i] = key[i] ^ 0xff;
+	return true;
+fail:
+	if (jentry)
+		json_object_put(jentry);
 
-			if (!add_key(jentry, "oldKey", buf))
-				goto fail;
-		}
+	return false;
+}
 
-		if (!jarray) {
-			jarray = json_object_new_array();
-			if (!jarray)
-				goto fail;
-			json_object_object_add(jobj, "netKeys", jarray);
-		}
+bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
+							const uint8_t key[16])
+{
+	json_object *jarray, *jentry, *jstring;
+	const char *str;
 
-		json_object_array_add(jarray, jentry);
+	json_object_object_get_ex(jobj, "netKeys", &jarray);
 
-	} else {
+	if (!jarray)
+		return false;
 
-		if (!json_object_object_get_ex(jentry, "key", &jstring))
-			return false;
+	jentry = get_key_object(jarray, idx);
+	/* Net key must be already recorded */
+	if (!jentry)
+		return false;
 
-		json_object_object_add(jentry, "oldKey", jstring);
-		json_object_object_del(jentry, "key");
+	if (!json_object_object_get_ex(jentry, "key", &jstring))
+		return false;
 
-		if (!add_key(jentry, "key", key))
-			return false;
-	}
+	str = json_object_get_string(jstring);
+	jstring = json_object_new_string(str);
+	json_object_object_add(jentry, "oldKey", jstring);
+	json_object_object_del(jentry, "key");
 
+	if (!add_key_value(jentry, "key", key))
+		return false;
 
 	json_object_object_add(jentry, "keyRefresh",
-					json_object_new_int(phase));
+				json_object_new_int(KEY_REFRESH_PHASE_ONE));
 
 	return true;
-fail:
-
-	if (jentry)
-		json_object_put(jentry);
-
-	return false;
 }
 
 bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
@@ -513,7 +497,7 @@ bool mesh_db_net_key_del(json_object *jobj, uint16_t idx)
 
 bool mesh_db_write_device_key(json_object *jnode, uint8_t *key)
 {
-	return add_key(jnode, "deviceKey", key);
+	return add_key_value(jnode, "deviceKey", key);
 }
 
 bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
@@ -572,7 +556,7 @@ bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
 
 		json_object_object_add(jentry, "boundNetKey", jstring);
 
-		if (!add_key(jentry, "key", key))
+		if (!add_key_value(jentry, "key", key))
 			goto fail;
 
 		if (!jarray) {
@@ -592,7 +576,7 @@ bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
 		json_object_object_add(jentry, "oldKey", jstring);
 		json_object_object_del(jentry, "key");
 
-		if (!add_key(jentry, "key", key))
+		if (!add_key_value(jentry, "key", key))
 			return false;
 	}
 
@@ -1421,7 +1405,7 @@ bool mesh_db_add_node(json_object *jnode, struct mesh_db_node *node) {
 		return false;
 
 	/* Device UUID */
-	if (!add_key(jnode, "UUID", node->uuid))
+	if (!add_key_value(jnode, "UUID", node->uuid))
 		return false;
 
 	/* Features: relay, LPN, friend, proxy*/
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index db7ea6045..513ad3861 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -133,7 +133,9 @@ bool mesh_db_app_key_add(json_object *jnode, uint16_t net_idx, uint16_t app_idx,
 					const uint8_t key[16], bool update);
 bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx);
 bool mesh_db_net_key_add(json_object *jobj, uint16_t net_idx,
-					const uint8_t key[16], int phase);
+							const uint8_t key[16]);
+bool mesh_db_net_key_update(json_object *jobj, uint16_t idx,
+							const uint8_t key[16]);
 bool mesh_db_net_key_del(json_object *jobj, uint16_t net_idx);
 bool mesh_db_net_key_set_phase(json_object *jobj, uint16_t idx, uint8_t phase);
 bool mesh_db_write_address(json_object *jobj, uint16_t address);
diff --git a/mesh/net.c b/mesh/net.c
index b85a95cad..71a283c60 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1016,7 +1016,7 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 	if (status != MESH_STATUS_SUCCESS)
 		return status;
 
-	if (!storage_net_key_add(net, idx, value, KEY_REFRESH_PHASE_NONE)) {
+	if (!storage_net_key_add(net, idx, value, false)) {
 		l_queue_remove(net->subnets, subnet);
 		subnet_free(subnet);
 		return MESH_STATUS_STORAGE_FAIL;
@@ -3729,7 +3729,7 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 
 	l_info("key refresh phase 1: Key ID %d", subnet->net_key_upd);
 
-	if (!storage_net_key_add(net, idx, value, KEY_REFRESH_PHASE_ONE))
+	if (!storage_net_key_add(net, idx, value, true))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	subnet->kr_phase = KEY_REFRESH_PHASE_ONE;
diff --git a/mesh/node.c b/mesh/node.c
index 1845f9a32..c815acf2e 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1730,9 +1730,16 @@ bool node_add_pending_local(struct mesh_node *node, void *prov_node_info,
 							MESH_STATUS_SUCCESS)
 		return false;
 
-	if (!storage_net_key_add(node->net, info->net_index, info->net_key,
-			kr ? KEY_REFRESH_PHASE_TWO : KEY_REFRESH_PHASE_NONE))
-		return false;
+	if (kr) {
+		/* Duplicate net key, if the key refresh is on */
+		if (mesh_net_update_key(node->net, info->net_index,
+				info->net_key) != MESH_STATUS_SUCCESS)
+			return false;
+
+		if (!mesh_db_net_key_set_phase(node->jconfig, info->net_index,
+							KEY_REFRESH_PHASE_TWO))
+			return false;
+	}
 
 	if (!storage_save_config(node, true, NULL, NULL))
 		return false;
@@ -1752,7 +1759,7 @@ void node_jconfig_set(struct mesh_node *node, void *jconfig)
 
 void *node_jconfig_get(struct mesh_node *node)
 {
-	return  node->jconfig;
+	return node->jconfig;
 }
 
 void node_cfg_file_set(struct mesh_node *node, char *cfg)
diff --git a/mesh/storage.c b/mesh/storage.c
index e1d86960a..d6b566a80 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -296,12 +296,15 @@ bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
 }
 
 bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
-					const uint8_t key[16], int phase)
+					const uint8_t key[16], bool update)
 {
 	struct mesh_node *node = mesh_net_node_get(net);
 	json_object *jnode = node_jconfig_get(node);
 
-	return mesh_db_net_key_add(jnode, net_idx, key, phase);
+	if (!update)
+		return mesh_db_net_key_add(jnode, net_idx, key);
+	else
+		return mesh_db_net_key_update(jnode, net_idx, key);
 }
 
 bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx)
diff --git a/mesh/storage.h b/mesh/storage.h
index 7dad2762e..85f7899bc 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -33,10 +33,9 @@ bool storage_set_relay(json_object *jnode, bool enable, uint8_t count,
 							uint8_t interval);
 bool storage_set_transmit_params(json_object *jnode, uint8_t count,
 							uint8_t interval);
-bool storage_set_mode(json_object *jnode, uint8_t mode,
-							const char *mode_name);
+bool storage_set_mode(json_object *jnode, uint8_t mode, const char *mode_name);
 bool storage_net_key_add(struct mesh_net *net, uint16_t net_idx,
-					const uint8_t key[16], int phase);
+					const uint8_t key[16], bool update);
 bool storage_net_key_del(struct mesh_net *net, uint16_t net_idx);
 bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 			uint16_t app_idx, const uint8_t key[16], bool update);
-- 
2.17.2

