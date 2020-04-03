Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81CDC2BA17
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 01:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1AF2073B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 01:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbgDCB1A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:27:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:19526 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389108AbgDCB1A (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 21:27:00 -0400
IronPort-SDR: J0Y+f1KKjg34/oJFhA+zwo/TCdjxplgcmq1zMYTwGAz0Jqy9unEKpEWfGsERbqqGN6i9PQZphm
 Vbla1hAieQhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 18:26:59 -0700
IronPort-SDR: YYKmE2wIn5U1gnovMKnQkartRAEc+vS71HDQUspFrhPk1PxT2SQagGMlislzlI0eAVgPWgqrGW
 RN5ejrUb1x7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,337,1580803200"; 
   d="scan'208";a="396569401"
Received: from ingas-nuc1.sea.intel.com ([10.255.231.70])
  by orsmga004.jf.intel.com with ESMTP; 02 Apr 2020 18:26:57 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 2/2] tools/mesh-cfgclient: Store "index" as integer in config
Date:   Thu,  2 Apr 2020 18:26:55 -0700
Message-Id: <20200403012655.17517-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403012655.17517-1-inga.stotland@intel.com>
References: <20200403012655.17517-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Write "index", "elementIndex", "boundNetKey" as integers
rather than hex strings in configuration file.
---
 tools/mesh/mesh-db.c | 164 +++++++++++++++----------------------------
 1 file changed, 56 insertions(+), 108 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 5dd381232..3bd6b0d06 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -152,30 +152,6 @@ static json_object *get_node_by_unicast(uint16_t unicast)
 	return NULL;
 }
 
-static json_object *get_key_object(json_object *jarray, uint16_t idx)
-{
-	int i, sz = json_object_array_length(jarray);
-
-	for (i = 0; i < sz; ++i) {
-		json_object *jentry, *jval;
-		const char *str;
-		uint16_t jidx;
-
-		jentry = json_object_array_get_idx(jarray, i);
-		if (!json_object_object_get_ex(jentry, "index", &jval))
-			return NULL;
-
-		str = json_object_get_string(jval);
-		if (sscanf(str, "%04hx", &jidx) != 1)
-			return NULL;
-
-		if (jidx == idx)
-			return jentry;
-	}
-
-	return NULL;
-}
-
 static bool get_int(json_object *jobj, const char *keyword, int *value)
 {
 	json_object *jvalue;
@@ -184,8 +160,11 @@ static bool get_int(json_object *jobj, const char *keyword, int *value)
 		return false;
 
 	*value = json_object_get_int(jvalue);
-	if (errno == EINVAL)
+	if (errno == EINVAL) {
+		l_error("Error: %s should contain an integer value\n",
+								keyword);
 		return false;
+	}
 
 	return true;
 }
@@ -204,8 +183,27 @@ static bool write_int(json_object *jobj, const char *keyword, int val)
 	return true;
 }
 
+static json_object *get_key_object(json_object *jarray, uint16_t idx)
+{
+	int i, sz = json_object_array_length(jarray);
+
+	for (i = 0; i < sz; ++i) {
+		json_object *jentry;
+		int jidx;
+
+		jentry = json_object_array_get_idx(jarray, i);
+		if (!get_int(jentry, "index", &jidx))
+			return NULL;
+
+		if (jidx == idx)
+			return jentry;
+	}
+
+	return NULL;
+}
+
 static bool write_uint16_hex(json_object *jobj, const char *desc,
-								uint16_t value)
+							uint16_t value)
 {
 	json_object *jstring;
 	char buf[5];
@@ -252,8 +250,8 @@ static json_object *get_node_by_uuid(json_object *jcfg, uint8_t uuid[16])
 	return NULL;
 }
 
-static bool add_u8_8(json_object *jobj, const uint8_t value[8],
-							const char *desc)
+static bool add_u8_8(json_object *jobj, const char *desc,
+							const uint8_t value[8])
 {
 	json_object *jstring;
 	char buf[17];
@@ -267,8 +265,8 @@ static bool add_u8_8(json_object *jobj, const uint8_t value[8],
 	return true;
 }
 
-static bool add_u8_16(json_object *jobj, const uint8_t value[16],
-							const char *desc)
+static bool add_u8_16(json_object *jobj, const char *desc,
+							const uint8_t value[16])
 {
 	json_object *jstring;
 	char buf[33];
@@ -282,7 +280,7 @@ static bool add_u8_16(json_object *jobj, const uint8_t value[16],
 	return true;
 }
 
-static bool add_string(json_object *jobj, const char *str, const char *desc)
+static bool add_string(json_object *jobj, const char *desc, const char *str)
 {
 	json_object *jstring = json_object_new_string(str);
 
@@ -313,22 +311,17 @@ static bool get_token(json_object *jobj, uint8_t token[8])
 
 static uint16_t node_parse_key(json_object *jarray, int i)
 {
-	json_object *jkey, *jval;
-	const char *str;
-	uint16_t idx;
+	json_object *jkey;
+	int idx;
 
 	jkey = json_object_array_get_idx(jarray, i);
 	if (!jkey)
 		return KEY_IDX_INVALID;
 
-	if (!json_object_object_get_ex(jkey, "index", &jval))
+	if (!get_int(jkey, "index", &idx))
 		return KEY_IDX_INVALID;
 
-	str = json_object_get_string(jval);
-	if (sscanf(str, "%04hx", &idx) != 1)
-		return KEY_IDX_INVALID;
-
-	return idx;
+	return (uint16_t)idx;
 }
 
 static int compare_group_addr(const void *a, const void *b, void *user_data)
@@ -439,8 +432,7 @@ static void load_remotes(json_object *jcfg)
 
 static bool add_app_key(json_object *jobj, uint16_t net_idx, uint16_t app_idx)
 {
-	json_object *jval, *jkey, *jarray;
-	char buf[5];
+	json_object *jkey, *jarray;
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
@@ -448,20 +440,12 @@ static bool add_app_key(json_object *jobj, uint16_t net_idx, uint16_t app_idx)
 
 	jkey = json_object_new_object();
 
-	snprintf(buf, 5, "%4.4x", net_idx);
-	jval = json_object_new_string(buf);
-	if (!jval)
+	if (!write_int(jkey, "boundNetKey", (int)net_idx))
 		goto fail;
 
-	json_object_object_add(jkey, "boundNetKey", jval);
-
-	snprintf(buf, 5, "%4.4x", app_idx);
-	jval = json_object_new_string(buf);
-	if (!jval)
+	if (!write_int(jkey, "index", (int)app_idx))
 		goto fail;
 
-	json_object_object_add(jkey, "index", jval);
-
 	json_object_array_add(jarray, jkey);
 
 	return true;
@@ -472,8 +456,7 @@ fail:
 
 static bool add_node_key(json_object *jobj, const char *desc, uint16_t idx)
 {
-	json_object *jval, *jkey, *jarray;
-	char buf[5];
+	json_object *jkey, *jarray;
 
 	json_object_object_get_ex(jobj, desc, &jarray);
 	if (!jarray || json_object_get_type(jarray) != json_type_array)
@@ -481,15 +464,11 @@ static bool add_node_key(json_object *jobj, const char *desc, uint16_t idx)
 
 	jkey = json_object_new_object();
 
-	snprintf(buf, 5, "%4.4x", idx);
-
-	jval = json_object_new_string(buf);
-	if (!jval) {
+	if (!write_int(jkey, "index", (int)idx)) {
 		json_object_put(jkey);
 		return false;
 	}
 
-	json_object_object_add(jkey, "index", jval);
 	json_object_array_add(jarray, jkey);
 
 	return save_config();
@@ -531,18 +510,12 @@ static void jarray_key_del(json_object *jarray, int16_t idx)
 	int i, sz = json_object_array_length(jarray);
 
 	for (i = 0; i < sz; ++i) {
-		json_object *jentry, *jval;
-		uint16_t val;
-		const char *str;
+		json_object *jentry;
+		int val;
 
 		jentry = json_object_array_get_idx(jarray, i);
 
-		if (!json_object_object_get_ex(jentry, "index", &jval))
-			continue;
-
-		str = json_object_get_string(jval);
-
-		if (sscanf(str, "%04hx", &val) != 1)
+		if (!get_int(jentry, "index", &val))
 			continue;
 
 		if (val == idx) {
@@ -609,8 +582,8 @@ bool mesh_db_node_app_key_del(uint16_t unicast, uint16_t idx)
 
 static bool load_keys(json_object *jobj)
 {
-	json_object *jarray, *jentry, *jval;
-	uint16_t net_idx, app_idx;
+	json_object *jarray, *jentry;
+	int net_idx, app_idx;
 	int i, key_cnt;
 
 	json_object_object_get_ex(jobj, "netKeys", &jarray);
@@ -622,20 +595,14 @@ static bool load_keys(json_object *jobj)
 		return false;
 
 	for (i = 0; i < key_cnt; ++i) {
-		const char *str;
 		int phase;
 
 		jentry = json_object_array_get_idx(jarray, i);
 
-		if (!json_object_object_get_ex(jentry, "index", &jval))
-			return false;
-
-		str = json_object_get_string(jval);
-
-		if (sscanf(str, "%04hx", &net_idx) != 1)
+		if (!get_int(jentry, "index", &net_idx))
 			return false;
 
-		keys_add_net_key(net_idx);
+		keys_add_net_key((uint16_t) net_idx);
 
 		if (!get_int(jentry, "phase", &phase))
 			return false;
@@ -652,26 +619,16 @@ static bool load_keys(json_object *jobj)
 		return false;
 
 	for (i = 0; i < key_cnt; ++i) {
-		const char *str;
 
 		jentry = json_object_array_get_idx(jarray, i);
 
-		if (!json_object_object_get_ex(jentry, "boundNetKey", &jval))
+		if (!get_int(jentry, "boundNetKey", &net_idx))
 			return false;
 
-		str = json_object_get_string(jval);
-
-		if (sscanf(str, "%04hx", &net_idx) != 1)
+		if (!get_int(jentry, "index", &app_idx))
 			return false;
 
-		if (!json_object_object_get_ex(jentry, "index", &jval))
-			return false;
-
-		str = json_object_get_string(jval);
-
-		if (sscanf(str, "%04hx", &app_idx) != 1)
-			return false;
-		keys_add_app_key(net_idx, app_idx);
+		keys_add_app_key((uint16_t) net_idx, (uint16_t) app_idx);
 	}
 
 	return true;
@@ -679,8 +636,7 @@ static bool load_keys(json_object *jobj)
 
 bool mesh_db_net_key_add(uint16_t net_idx)
 {
-	json_object *jval, *jkey, *jarray;
-	char buf[5];
+	json_object *jkey, *jarray;
 
 	if (!cfg || !cfg->jcfg)
 		return false;
@@ -694,14 +650,9 @@ bool mesh_db_net_key_add(uint16_t net_idx)
 
 	jkey = json_object_new_object();
 
-	snprintf(buf, 5, "%4.4x", net_idx);
-
-	jval = json_object_new_string(buf);
-	if (!jval)
+	if (!write_int(jkey, "index", net_idx))
 		goto fail;
 
-	json_object_object_add(jkey, "index", jval);
-
 	if (!write_int(jkey, "phase", KEY_REFRESH_PHASE_NONE))
 		goto fail;
 
@@ -785,14 +736,11 @@ bool mesh_db_add_group(struct mesh_group *grp)
 	json_object_object_add(jgroup, "name", jval);
 
 	if (IS_VIRTUAL(grp->addr)) {
-		if (!add_u8_16(jgroup, grp->label, "address"))
+		if (!add_u8_16(jgroup, "address", grp->label))
 			goto fail;
 	} else {
-		snprintf(buf, 5, "%4.4x", grp->addr);
-		jval = json_object_new_string(buf);
-		if (!jval)
+		if (!write_uint16_hex(jgroup, "address", grp->addr))
 			goto fail;
-		json_object_object_add(jgroup, "address", jval);
 	}
 
 	json_object_array_add(jgroups, jgroup);
@@ -891,7 +839,7 @@ bool mesh_db_add_node(uint8_t uuid[16], uint8_t num_els, uint16_t unicast,
 	if (!jnode)
 		return false;
 
-	if (!add_u8_16(jnode, uuid, "uuid"))
+	if (!add_u8_16(jnode, "uuid", uuid))
 		goto fail;
 
 	jelements = json_object_new_array();
@@ -1052,15 +1000,15 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 	cfg->cfg_fname = l_strdup(fname);
 	memcpy(cfg->token, token, 8);
 
-	if (!add_u8_8(jcfg, token, "token"))
+	if (!add_u8_8(jcfg, "token", token))
 		goto fail;
 
 	l_getrandom(uuid, 16);
 
-	if (!add_u8_16(jcfg, uuid, "uuid"))
+	if (!add_u8_16(jcfg, "uuid", uuid))
 		goto fail;
 
-	if (mesh_name && !add_string(jcfg, mesh_name, "name"))
+	if (mesh_name && !add_string(jcfg, "name", mesh_name))
 		goto fail;
 
 	jarray = json_object_new_array();
-- 
2.21.1

