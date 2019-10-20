Return-Path: <SRS0=2Cj2=YN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C94CA9EA0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Oct 2019 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D0F21928
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Oct 2019 21:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfJTV3v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Oct 2019 17:29:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:27478 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfJTV3v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Oct 2019 17:29:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 14:29:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="398477997"
Received: from achakked-mobl2.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.104.9])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2019 14:29:50 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Fix reading/writing key indices
Date:   Sun, 20 Oct 2019 14:29:49 -0700
Message-Id: <20191020212949.21492-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes inconsistency when reading/writing NetKey and AppKey
indices to/from JSON config storage:
	- when writing, convert an integer to hex string
	- when reading, convert hex string to uint16 integer
---
 mesh/mesh-config-json.c | 67 ++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index df58cbd7d..865fbdf07 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -45,7 +45,7 @@
 #define MIN_SEQ_CACHE_VALUE	(2 * 32)
 #define MIN_SEQ_CACHE_TIME	(5 * 60)
 
-#define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
+#define CHECK_KEY_IDX_RANGE(x) ((x) <= 4095)
 
 struct mesh_config {
 	json_object *jnode;
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
@@ -419,21 +441,6 @@ static bool read_device_key(json_object *jobj, uint8_t key_buf[16])
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
 
-- 
2.21.0

