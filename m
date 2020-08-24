Return-Path: <SRS0=dZ4y=CC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 20:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202B62067C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Aug 2020 20:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHXUJy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:09:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:59571 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHXUJy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Aug 2020 16:09:54 -0400
IronPort-SDR: JBZtKgQJK8KRoRxqoiAfbhNMiRwUy2SRlrRHa7MI3g3V6VJkXZwJpSSADhWw3my+AqpZWy6NPR
 Ne+fgG21KHPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136046020"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="136046020"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 13:09:53 -0700
IronPort-SDR: wbty+Va7ePbZTVMjxryGzdw4jeuSNoxdjxo3m5o9C1TZSzSx5HW5dqcV6R5MTj64NbPmecHp3p
 zg9FsVsNAfzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="294727631"
Received: from apaharia-mobl.gar.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.231.108])
  by orsmga003.jf.intel.com with ESMTP; 24 Aug 2020 13:09:53 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Store key indices as integers in node config
Date:   Mon, 24 Aug 2020 13:09:52 -0700
Message-Id: <20200824200952.20818-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Store NetKey and AppKey indices as integers instead of hex strings.
This removes unnecessary sting manipulationswhile not affecting
configuration file readability.
---
 mesh/mesh-config-json.c | 102 +++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 64 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 63b6c3988..30c90170d 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -249,21 +249,31 @@ static void jarray_string_del(json_object *jarray, char *str, size_t len)
 	}
 }
 
+static bool get_key_index(json_object *jobj, const char *keyword,
+								uint16_t *index)
+{
+	int idx;
+
+	if (!get_int(jobj, keyword, &idx))
+		return false;
+
+	if (!CHECK_KEY_IDX_RANGE(idx))
+		return false;
+
+	*index = (uint16_t) idx;
+	return true;
+}
+
 static json_object *get_key_object(json_object *jarray, uint16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
 
 	for (i = 0; i < sz; ++i) {
-		json_object *jentry, *jvalue;
-		const char *str;
+		json_object *jentry;
 		uint16_t jidx;
 
 		jentry = json_object_array_get_idx(jarray, i);
-		if (!json_object_object_get_ex(jentry, "index", &jvalue))
-			return NULL;
-
-		str = json_object_get_string(jvalue);
-		if (sscanf(str, "%04hx", &jidx) != 1)
+		if (!get_key_index(jentry, "index", &jidx))
 			return NULL;
 
 		if (jidx == idx)
@@ -273,28 +283,6 @@ static json_object *get_key_object(json_object *jarray, uint16_t idx)
 	return NULL;
 }
 
-static bool get_key_index(json_object *jobj, const char *keyword,
-								uint16_t *index)
-{
-	uint16_t idx;
-	json_object *jvalue;
-	const char *str;
-
-	if (!json_object_object_get_ex(jobj, keyword, &jvalue))
-		return false;
-
-	str = json_object_get_string(jvalue);
-
-	if (sscanf(str, "%04hx", &idx) != 1)
-		return false;
-
-	if (!CHECK_KEY_IDX_RANGE(idx))
-		return false;
-
-	*index = (uint16_t) idx;
-	return true;
-}
-
 static void jarray_key_del(json_object *jarray, int16_t idx)
 {
 	int i, sz = json_object_array_length(jarray);
@@ -594,11 +582,23 @@ fail:
 	return false;
 }
 
+static bool write_int(json_object *jobj, const char *desc, int val)
+{
+	json_object *jvalue;
+
+	jvalue = json_object_new_int(val);
+	if (!jvalue)
+		return false;
+
+	json_object_object_del(jobj, desc);
+	json_object_object_add(jobj, desc, jvalue);
+	return true;
+}
+
 bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t idx,
 							const uint8_t key[16])
 {
-	json_object *jnode, *jarray = NULL, *jentry = NULL, *jstring;
-	char buf[5];
+	json_object *jnode, *jarray = NULL, *jentry = NULL;
 
 	if (!cfg)
 		return false;
@@ -618,13 +618,9 @@ bool mesh_config_net_key_add(struct mesh_config *cfg, uint16_t idx,
 	if (!jentry)
 		return false;
 
-	snprintf(buf, 5, "%4.4x", idx);
-	jstring = json_object_new_string(buf);
-	if (!jstring)
+	if (!write_int(jentry, "index", idx))
 		goto fail;
 
-	json_object_object_add(jentry, "index", jstring);
-
 	if (!add_key_value(jentry, "key", key))
 		goto fail;
 
@@ -724,8 +720,7 @@ bool mesh_config_write_token(struct mesh_config *cfg, uint8_t *token)
 bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 					uint16_t app_idx, const uint8_t key[16])
 {
-	json_object *jnode, *jarray = NULL, *jentry = NULL, *jstring = NULL;
-	char buf[5];
+	json_object *jnode, *jarray = NULL, *jentry = NULL;
 
 	if (!cfg)
 		return false;
@@ -744,20 +739,12 @@ bool mesh_config_app_key_add(struct mesh_config *cfg, uint16_t net_idx,
 	if (!jentry)
 		return false;
 
-	snprintf(buf, 5, "%4.4x", app_idx);
-	jstring = json_object_new_string(buf);
-	if (!jstring)
+	if (!write_int(jentry, "index", app_idx))
 		goto fail;
 
-	json_object_object_add(jentry, "index", jstring);
-
-	snprintf(buf, 5, "%4.4x", net_idx);
-	jstring = json_object_new_string(buf);
-	if (!jstring)
+	if (!write_int(jentry, "boundNetKey", net_idx))
 		goto fail;
 
-	json_object_object_add(jentry, "boundNetKey", jstring);
-
 	if (!add_key_value(jentry, "key", key))
 		goto fail;
 
@@ -995,6 +982,7 @@ static struct mesh_config_pub *parse_model_publication(json_object *jpub)
 	case 32:
 		if (!str2hex(str, len, pub->virt_addr, 16))
 			goto fail;
+
 		pub->virt = true;
 		break;
 	default:
@@ -1468,19 +1456,6 @@ static bool write_uint32_hex(json_object *jobj, const char *desc, uint32_t val)
 	return true;
 }
 
-static bool write_int(json_object *jobj, const char *desc, int val)
-{
-	json_object *jvalue;
-
-	jvalue = json_object_new_int(val);
-	if (!jvalue)
-		return false;
-
-	json_object_object_del(jobj, desc);
-	json_object_object_add(jobj, desc, jvalue);
-	return true;
-}
-
 static const char *mode_to_string(int mode)
 {
 	switch (mode) {
@@ -1872,7 +1847,7 @@ bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!res)
 		goto fail;
 
-	if (!write_uint16_hex(jpub, "index", pub->idx))
+	if (!write_int(jpub, "index", pub->idx))
 		goto fail;
 
 	if (!write_int(jpub, "ttl", pub->ttl))
@@ -1881,8 +1856,7 @@ bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!write_int(jpub, "period", pub->period))
 		goto fail;
 
-	if (!write_int(jpub, "credentials",
-						pub->credential ? 1 : 0))
+	if (!write_int(jpub, "credentials", pub->credential ? 1 : 0))
 		goto fail;
 
 	jrtx = json_object_new_object();
-- 
2.26.2

