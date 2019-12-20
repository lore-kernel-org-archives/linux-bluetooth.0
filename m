Return-Path: <SRS0=msWm=2K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B51C43603
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4467206D3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 19:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLTTNb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:13:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:35736 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfLTTNb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Dec 2019 14:13:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 11:13:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,336,1571727600"; 
   d="scan'208";a="366463896"
Received: from ingas-nuc1.sea.intel.com ([10.254.189.210])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2019 11:13:30 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Base config json code on newer version of json-c
Date:   Fri, 20 Dec 2019 11:13:29 -0800
Message-Id: <20191220191329.5190-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes a roundabout logic that was required to delete
a json entry from a json array using libjsonc utilities.
A new API function, json_object_array_del_idx(), implemented in
json-c version 0.13 simplifies array entry removal to one call.

Also, add requirement to configure.ac for json-c version >= 0.13
---
 configure.ac            |   4 +-
 mesh/mesh-config-json.c | 126 ++++++++--------------------------------
 tools/mesh/mesh-db.c    |  42 +++-----------
 3 files changed, 34 insertions(+), 138 deletions(-)

diff --git a/configure.ac b/configure.ac
index 57a816fd5..6f7717f24 100644
--- a/configure.ac
+++ b/configure.ac
@@ -230,8 +230,8 @@ AC_ARG_ENABLE(mesh, AC_HELP_STRING([--enable-mesh],
 AM_CONDITIONAL(MESH, test "${enable_mesh}" = "yes")
 
 if (test "${enable_mesh}" = "yes"); then
-	PKG_CHECK_MODULES(JSONC, json-c, dummy=yes,
-				AC_MSG_ERROR(json-c is required))
+	PKG_CHECK_MODULES(JSONC, json-c >= 0.13, dummy=yes,
+				AC_MSG_ERROR(json-c >= 0.13 is required))
 	AC_SUBST(JSON_CFLAGS)
 	AC_SUBST(JSON_LIBS)
 fi
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 5ca2961b0..755caab0e 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -232,15 +232,9 @@ static bool jarray_has_string(json_object *jarray, char *str, size_t len)
 	return false;
 }
 
-static json_object *jarray_string_del(json_object *jarray, char *str,
-								size_t len)
+static void jarray_string_del(json_object *jarray, char *str, size_t len)
 {
 	int i, sz = json_object_array_length(jarray);
-	json_object *jarray_new;
-
-	jarray_new = json_object_new_array();
-	if (!jarray_new)
-		return NULL;
 
 	for (i = 0; i < sz; ++i) {
 		json_object *jentry;
@@ -248,14 +242,13 @@ static json_object *jarray_string_del(json_object *jarray, char *str,
 
 		jentry = json_object_array_get_idx(jarray, i);
 		str_entry = (char *)json_object_get_string(jentry);
-		if (str_entry && !strncmp(str, str_entry, len))
-			continue;
 
-		json_object_get(jentry);
-		json_object_array_add(jarray_new, jentry);
-	}
+		if (str_entry && !strncmp(str, str_entry, len)) {
+			json_object_array_del_idx(jarray, i, 1);
+			return;
+		}
 
-	return jarray_new;
+	}
 }
 
 static json_object *get_key_object(json_object *jarray, uint16_t idx)
@@ -304,29 +297,21 @@ static bool get_key_index(json_object *jobj, const char *keyword,
 	return true;
 }
 
-static json_object *jarray_key_del(json_object *jarray, int16_t idx)
+static void jarray_key_del(json_object *jarray, int16_t idx)
 {
-	json_object *jarray_new;
 	int i, sz = json_object_array_length(jarray);
 
-	jarray_new = json_object_new_array();
-	if (!jarray_new)
-		return NULL;
-
 	for (i = 0; i < sz; ++i) {
 		json_object *jentry;
 		uint16_t nidx;
 
 		jentry = json_object_array_get_idx(jarray, i);
 
-		if (get_key_index(jentry, "index", &nidx) && nidx == idx)
-			continue;
-
-		json_object_get(jentry);
-		json_object_array_add(jarray_new, jentry);
+		if (get_key_index(jentry, "index", &nidx) && nidx == idx) {
+			json_object_array_del_idx(jarray, i, 1);
+			return;
+		}
 	}
-
-	return jarray_new;
 }
 
 static bool read_unicast_address(json_object *jobj, uint16_t *unicast)
@@ -660,39 +645,20 @@ bool mesh_config_net_key_update(struct mesh_config *cfg, uint16_t idx,
 
 bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t idx)
 {
-	json_object *jnode, *jarray, *jarray_new;
+	json_object *jnode, *jarray;
 
 	if (!cfg)
 		return false;
 
 	jnode = cfg->jnode;
 
-	/* TODO: Decide if we treat this as an error: no network keys??? */
 	if (!json_object_object_get_ex(jnode, "netKeys", &jarray))
 		return true;
 
-	/* Check if matching entry exists */
-	if (!get_key_object(jarray, idx))
-		return true;
+	jarray_key_del(jarray, idx);
 
-	if (json_object_array_length(jarray) == 1) {
+	if (!json_object_array_length(jarray))
 		json_object_object_del(jnode, "netKeys");
-		/* TODO: Do we raise an error here? */
-		l_warn("Removing the last network key! Zero keys left.");
-		return save_config(jnode, cfg->node_dir_path);
-	}
-
-	/*
-	 * There is no easy way to delete a value from json array.
-	 * Create a new copy without specified element and
-	 * then remove old array.
-	 */
-	jarray_new = jarray_key_del(jarray, idx);
-	if (!jarray_new)
-		return false;
-
-	json_object_object_del(jnode, "netKeys");
-	json_object_object_add(jnode, "netKeys", jarray_new);
 
 	return save_config(jnode, cfg->node_dir_path);
 }
@@ -810,7 +776,7 @@ bool mesh_config_app_key_update(struct mesh_config *cfg, uint16_t app_idx,
 bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
 								uint16_t idx)
 {
-	json_object *jnode, *jarray, *jarray_new;
+	json_object *jnode, *jarray;
 
 	if (!cfg)
 		return false;
@@ -820,26 +786,10 @@ bool mesh_config_app_key_del(struct mesh_config *cfg, uint16_t net_idx,
 	if (!json_object_object_get_ex(jnode, "appKeys", &jarray))
 		return true;
 
-	/* Check if matching entry exists */
-	if (!get_key_object(jarray, idx))
-		return true;
+	jarray_key_del(jarray, idx);
 
-	if (json_object_array_length(jarray) == 1) {
+	if (!json_object_array_length(jarray))
 		json_object_object_del(jnode, "appKeys");
-		return true;
-	}
-
-	/*
-	 * There is no easy way to delete a value from json array.
-	 * Create a new copy without specified element and
-	 * then remove old array.
-	 */
-	jarray_new = jarray_key_del(jarray, idx);
-	if (!jarray_new)
-		return false;
-
-	json_object_object_del(jnode, "appKeys");
-	json_object_object_add(jnode, "appKeys", jarray_new);
 
 	return save_config(jnode, cfg->node_dir_path);
 }
@@ -893,7 +843,7 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
 						bool vendor, uint32_t mod_id,
 							uint16_t app_idx)
 {
-	json_object *jnode, *jmodel, *jarray, *jarray_new;
+	json_object *jnode, *jmodel, *jarray;
 	int ele_idx;
 	char buf[5];
 
@@ -915,25 +865,10 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
 
 	snprintf(buf, 5, "%4.4x", app_idx);
 
-	if (!jarray_has_string(jarray, buf, 4))
-		return true;
+	jarray_string_del(jarray, buf, 4);
 
-	if (json_object_array_length(jarray) == 1) {
+	if (!json_object_array_length(jarray))
 		json_object_object_del(jmodel, "bind");
-		return true;
-	}
-
-	/*
-	 * There is no easy way to delete a value from json array.
-	 * Create a new copy without specified element and
-	 * then remove old array.
-	 */
-	jarray_new = jarray_string_del(jarray, buf, 4);
-	if (!jarray_new)
-		return false;
-
-	json_object_object_del(jmodel, "bind");
-	json_object_object_add(jmodel, "bind", jarray_new);
 
 	return save_config(jnode, cfg->node_dir_path);
 }
@@ -1994,7 +1929,7 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 						uint32_t mod_id, bool vendor,
 						struct mesh_config_sub *sub)
 {
-	json_object *jnode, *jmodel, *jarray, *jarray_new;
+	json_object *jnode, *jmodel, *jarray;
 	char buf[33];
 	int len, ele_idx;
 
@@ -2022,25 +1957,10 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 		len = 32;
 	}
 
-	if (!jarray_has_string(jarray, buf, len))
-		return true;
+	jarray_string_del(jarray, buf, len);
 
-	if (json_object_array_length(jarray) == 1) {
+	if (!json_object_array_length(jarray))
 		json_object_object_del(jmodel, "subscribe");
-		return true;
-	}
-
-	/*
-	 * There is no easy way to delete a value from a json array.
-	 * Create a new copy without specified element and
-	 * then remove old array.
-	 */
-	jarray_new = jarray_string_del(jarray, buf, len);
-	if (!jarray_new)
-		return false;
-
-	json_object_object_del(jmodel, "subscribe");
-	json_object_object_add(jmodel, "subscribe", jarray_new);
 
 	return save_config(jnode, cfg->node_dir_path);
 }
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 8f5cd186f..5dbb91440 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -419,15 +419,10 @@ bool mesh_db_node_net_key_add(uint16_t unicast, uint16_t idx)
 	return add_node_key(jnode, "netKeys", idx);
 }
 
-static json_object *jarray_key_del(json_object *jarray, int16_t idx)
+static void jarray_key_del(json_object *jarray, int16_t idx)
 {
-	json_object *jarray_new;
 	int i, sz = json_object_array_length(jarray);
 
-	jarray_new = json_object_new_array();
-	if (!jarray_new)
-		return NULL;
-
 	for (i = 0; i < sz; ++i) {
 		json_object *jentry, *jval;
 		uint16_t val;
@@ -436,48 +431,29 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 		jentry = json_object_array_get_idx(jarray, i);
 
 		if (!json_object_object_get_ex(jentry, "index", &jval))
-			goto fail;
+			continue;
 
 		str = json_object_get_string(jval);
 
 		if (sscanf(str, "%04hx", &val) != 1)
-			goto fail;
-
-		if (val == idx)
 			continue;
 
-		json_object_get(jentry);
-		json_object_array_add(jarray_new, jentry);
-	}
+		if (val == idx) {
+			json_object_array_del_idx(jarray, i, 1);
+			return;
+		}
 
-	return jarray_new;
-fail:
-	json_object_put(jarray_new);
-	return NULL;
+	}
 }
 
 static bool delete_key(json_object *jobj, const char *desc, uint16_t idx)
 {
-	json_object *jarray, *jarray_new;
+	json_object *jarray;
 
 	if (!json_object_object_get_ex(jobj, desc, &jarray))
 		return true;
 
-	/* Check if matching entry exists */
-	if (!get_key_object(jarray, idx))
-		return true;
-
-	/*
-	 * There is no easy way to delete a value from a json array.
-	 * Create a new copy without specified element and
-	 * then remove old array.
-	 */
-	jarray_new = jarray_key_del(jarray, idx);
-	if (!jarray_new)
-		return false;
-
-	json_object_object_del(jobj, desc);
-	json_object_object_add(jobj, desc, jarray_new);
+	jarray_key_del(jarray, idx);
 
 	return mesh_config_save((struct mesh_config *) cfg, true,
 								NULL, NULL);
-- 
2.21.0

