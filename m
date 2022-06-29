Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7E4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 19:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiF2TBH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2TBE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 15:01:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E361CB35
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656529263; x=1688065263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wlzSSPa0Pb2NCZhSUleHMRLq8D4CI80yxM8O3sKVqmI=;
  b=VA2k5C4sJsZ9tAJyQljPuuKjtUfmggFdUEyCNO/zOVlIh137e62D5q6U
   GR9fSnQLZcuY0TJJfZXSkx9V2EqPB63Ss2SgQowND2LcTdP0H5japLhcG
   KB2QLDjt/mc1vuZDWqnTY9dCV3X6CqMoqKsUv9L9FEKOV1x0YBFvVMY6+
   vnDEliGmHbttHsgMrAjj36aBRnsMdOuouWwsA+oBzSiJekumWrHHU4mtk
   MgpaOwVyyNwaaI/p1NGSKZrKBa6LpwJwnecmFNtPVRgHXXZ8ahiYI4/ZT
   bL3AEDGkvSXaH86Z9X4ICvoY0+2Vjn39KR4Y1mSVcQ2TksmrW06GQsl8y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307622873"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="307622873"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:01:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="837243529"
Received: from bsquresh-mobl4.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.91.166])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 12:01:02 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix snprintf return values not being checked
Date:   Wed, 29 Jun 2022 12:00:46 -0700
Message-Id: <20220629190046.14198-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some versions of the GCC compiler complain when the return value of
snprintf is not checked. This patch cleans up the Mesh JSON parser.
---
 mesh/mesh-config-json.c | 88 ++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index f142f0e1f..cec636cc3 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -156,7 +156,7 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 						uint32_t mod_id, bool vendor)
 {
 	json_object *jelements, *jelement, *jmodels;
-	int i, num_mods;
+	int i, num_mods, ret;
 	size_t len;
 	char buf[9];
 
@@ -174,13 +174,15 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 	if (!num_mods)
 		return NULL;
 
-	if (!vendor) {
-		snprintf(buf, 5, "%4.4x", (uint16_t)mod_id);
-		len = 4;
-	} else {
-		snprintf(buf, 9, "%8.8x", mod_id);
-		len = 8;
-	}
+	if (!vendor)
+		ret = snprintf(buf, 5, "%4.4x", (uint16_t)mod_id);
+	else
+		ret = snprintf(buf, 9, "%8.8x", mod_id);
+
+	if (ret < 0)
+		return NULL;
+	else
+		len = ret;
 
 	for (i = 0; i < num_mods; ++i) {
 		json_object *jmodel, *jvalue;
@@ -818,7 +820,7 @@ bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 							uint16_t app_idx)
 {
 	json_object *jnode, *jmodel, *jstring, *jarray = NULL;
-	int ele_idx;
+	int ele_idx, ret;
 	char buf[5];
 
 	if (!cfg)
@@ -826,6 +828,10 @@ bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 
 	jnode = cfg->jnode;
 
+	ret = snprintf(buf, 5, "%4.4x", app_idx);
+	if (ret < 0)
+		return false;
+
 	ele_idx = get_element_index(jnode, ele_addr);
 	if (ele_idx < 0)
 		return false;
@@ -834,8 +840,6 @@ bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!jmodel)
 		return false;
 
-	snprintf(buf, 5, "%4.4x", app_idx);
-
 	json_object_object_get_ex(jmodel, "bind", &jarray);
 	if (jarray && jarray_has_string(jarray, buf, 4))
 		return true;
@@ -863,7 +867,7 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
 							uint16_t app_idx)
 {
 	json_object *jnode, *jmodel, *jarray;
-	int ele_idx;
+	int ele_idx, ret;
 	char buf[5];
 
 	if (!cfg)
@@ -871,6 +875,10 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
 
 	jnode = cfg->jnode;
 
+	ret = snprintf(buf, 5, "%4.4x", app_idx);
+	if (ret < 0)
+		return false;
+
 	ele_idx = get_element_index(jnode, ele_addr);
 	if (ele_idx < 0)
 		return false;
@@ -882,8 +890,6 @@ bool mesh_config_model_binding_del(struct mesh_config *cfg, uint16_t ele_addr,
 	if (!json_object_object_get_ex(jmodel, "bind", &jarray))
 		return true;
 
-	snprintf(buf, 5, "%4.4x", app_idx);
-
 	jarray_string_del(jarray, buf, 4);
 
 	if (!json_object_array_length(jarray))
@@ -1415,9 +1421,13 @@ static bool write_uint16_hex(json_object *jobj, const char *desc,
 								uint16_t value)
 {
 	json_object *jstring;
+	int ret;
 	char buf[5];
 
-	snprintf(buf, 5, "%4.4x", value);
+	ret = snprintf(buf, 5, "%4.4x", value);
+	if (ret < 5)
+		return false;
+
 	jstring = json_object_new_string(buf);
 	if (!jstring)
 		return false;
@@ -1430,9 +1440,13 @@ static bool write_uint16_hex(json_object *jobj, const char *desc,
 static bool write_uint32_hex(json_object *jobj, const char *desc, uint32_t val)
 {
 	json_object *jstring;
+	int ret;
 	char buf[9];
 
-	snprintf(buf, 9, "%8.8x", val);
+	ret = snprintf(buf, 9, "%8.8x", val);
+	if (ret < 0)
+		return false;
+
 	jstring = json_object_new_string(buf);
 	if (!jstring)
 		return false;
@@ -1716,22 +1730,24 @@ struct mesh_config *mesh_config_create(const char *cfgdir_name,
 	char uuid_buf[33];
 	char name_buf[PATH_MAX];
 	struct mesh_config *cfg;
-	size_t max_len = strlen(cfgnode_name) + strlen(bak_ext);
+	int ret;
 
 	if (!hex2str((uint8_t *) uuid, 16, uuid_buf, sizeof(uuid_buf)))
 		return NULL;
 
-	snprintf(name_buf, PATH_MAX, "%s/%s", cfgdir_name, uuid_buf);
-
-	if (strlen(name_buf) + max_len >= PATH_MAX)
+	ret = snprintf(name_buf, PATH_MAX, "%s/%s", cfgdir_name, uuid_buf);
+	if (ret < 0)
 		return NULL;
 
 	/* Create a new directory and node.json file */
 	if (mkdir(name_buf, 0755) != 0)
 		return NULL;
 
-	snprintf(name_buf, PATH_MAX, "%s/%s%s", cfgdir_name, uuid_buf,
+	ret = snprintf(name_buf, PATH_MAX, "%s/%s%s", cfgdir_name, uuid_buf,
 								cfgnode_name);
+	if (ret < 0)
+		return NULL;
+
 	l_debug("New node config %s", name_buf);
 
 	cfg = create_config(name_buf, uuid, db_node);
@@ -1904,12 +1920,14 @@ bool mesh_config_model_pub_del(struct mesh_config *cfg, uint16_t addr,
 static void del_page(json_object *jarray, uint8_t page)
 {
 	char buf[3];
-	int i, len;
+	int i, len, ret;
 
 	if (!jarray)
 		return;
 
-	snprintf(buf, 3, "%2.2x", page);
+	ret = snprintf(buf, 3, "%2.2x", page);
+	if (ret < 0)
+		return;
 
 	len = json_object_array_length(jarray);
 
@@ -1931,7 +1949,7 @@ bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
 {
 	json_object *jnode, *jstring, *jarray = NULL;
 	char *buf;
-	int len;
+	int len, ret;
 
 	if (!cfg)
 		return false;
@@ -1942,7 +1960,10 @@ bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
 
 	len = (size * 2) + 3;
 	buf = l_malloc(len);
-	snprintf(buf, len, "%2.2x", page);
+	ret = snprintf(buf, len, "%2.2x", page);
+	if (ret < 0)
+		return false;
+
 	hex2str(data, size, buf + 2, len - 2);
 
 	if (jarray && jarray_has_string(jarray, buf, len)) {
@@ -1967,12 +1988,16 @@ bool mesh_config_comp_page_mv(struct mesh_config *cfg, uint8_t old, uint8_t nw)
 	uint8_t *data;
 	char *str;
 	char old_buf[3];
-	int i, len, dlen = 0;
+	int i, len, ret, dlen = 0;
 	bool status = true;
 
 	if (!cfg || old == nw)
 		return false;
 
+	ret = snprintf(old_buf, 3, "%2.2x", old);
+	if (ret < 0)
+		return false;
+
 	jnode = cfg->jnode;
 
 	json_object_object_get_ex(jnode, "pages", &jarray);
@@ -1980,7 +2005,6 @@ bool mesh_config_comp_page_mv(struct mesh_config *cfg, uint8_t old, uint8_t nw)
 	if (!jarray)
 		return false;
 
-	snprintf(old_buf, 3, "%2.2x", old);
 	data = l_malloc(MAX_MSG_LEN);
 
 	len = json_object_array_length(jarray);
@@ -2030,8 +2054,9 @@ bool mesh_config_model_sub_add(struct mesh_config *cfg, uint16_t ele_addr,
 		return false;
 
 	if (!sub->virt) {
-		snprintf(buf, 5, "%4.4x", sub->addr.grp);
-		len = 4;
+		len = snprintf(buf, 5, "%4.4x", sub->addr.grp);
+		if (len < 0)
+			return false;
 	} else {
 		hex2str(sub->addr.label, 16, buf, 33);
 		len = 32;
@@ -2084,8 +2109,9 @@ bool mesh_config_model_sub_del(struct mesh_config *cfg, uint16_t ele_addr,
 		return true;
 
 	if (!sub->virt) {
-		snprintf(buf, 5, "%4.4x", sub->addr.grp);
-		len = 4;
+		len = snprintf(buf, 5, "%4.4x", sub->addr.grp);
+		if (len < 0)
+			return false;
 	} else {
 		hex2str(sub->addr.label, 16, buf, 33);
 		len = 32;
-- 
2.36.1

