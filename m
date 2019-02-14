Return-Path: <SRS0=ZFDx=QV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB580C4360F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959472089F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395435AbfBNDpc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:45:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:19361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395433AbfBNDpb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Feb 2019 22:45:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 19:45:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; 
   d="scan'208";a="274927361"
Received: from ingas-nuc1.sea.intel.com ([10.254.99.167])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 19:45:30 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/3] mesh: Save newly added or updated app key to config file
Date:   Wed, 13 Feb 2019 19:45:26 -0800
Message-Id: <20190214034527.6310-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190214034527.6310-1-inga.stotland@intel.com>
References: <20190214034527.6310-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This separates mesh_db_app_key_add() into distinct functions:
mesh_db_app_key_add() and mesh_db_app_key_update() which will be called
based on whether an application key is newly added or updated.
---
 mesh/mesh-db.c | 107 +++++++++++++++++++++++--------------------------
 mesh/mesh-db.h |   4 +-
 mesh/storage.c |   5 ++-
 3 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 6486f7cff..2d518c1aa 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -501,85 +501,52 @@ bool mesh_db_write_device_key(json_object *jnode, uint8_t *key)
 }
 
 bool mesh_db_app_key_add(json_object *jobj, uint16_t net_idx, uint16_t app_idx,
-			 const uint8_t key[16], bool update)
+							const uint8_t key[16])
 {
 	json_object *jarray, *jentry = NULL, *jstring = NULL;
 	char buf[5];
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
-	if (!jarray && update)
+	if (jarray)
 		return false;
 
 	if (jarray)
 		jentry = get_key_object(jarray, app_idx);
 
-	/* The key entry should exist if the key is updated */
-	if (!jentry  && update)
+	/* Do not allow direct overrwrite */
+	if (jentry)
 		return false;
 
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
-
+	jentry = json_object_new_object();
+	if (!jentry)
 		return false;
-	}
 
-	if (!update) {
-		jentry = json_object_new_object();
-		if (!jentry)
-			goto fail;
+	snprintf(buf, 5, "%4.4x", app_idx);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		goto fail;
 
-		snprintf(buf, 5, "%4.4x", app_idx);
-		jstring = json_object_new_string(buf);
-		if (!jstring)
-			goto fail;
+	json_object_object_add(jentry, "index", jstring);
 
-		json_object_object_add(jentry, "index", jstring);
+	snprintf(buf, 5, "%4.4x", net_idx);
+	jstring = json_object_new_string(buf);
+	if (!jstring)
+		goto fail;
 
-		snprintf(buf, 5, "%4.4x", net_idx);
-		jstring = json_object_new_string(buf);
-		if (!jstring)
-			goto fail;
+	json_object_object_add(jentry, "boundNetKey", jstring);
 
-		json_object_object_add(jentry, "boundNetKey", jstring);
+	if (!add_key_value(jentry, "key", key))
+		goto fail;
 
-		if (!add_key_value(jentry, "key", key))
+	if (!jarray) {
+		jarray = json_object_new_array();
+		if (!jarray)
 			goto fail;
-
-		if (!jarray) {
-			jarray = json_object_new_array();
-			if (!jarray)
-				goto fail;
-			json_object_object_add(jobj, "appKeys", jarray);
-		}
-
-		json_object_array_add(jarray, jentry);
-
-	} else {
-
-		if (!json_object_object_get_ex(jentry, "key", &jstring))
-			return false;
-
-		json_object_object_add(jentry, "oldKey", jstring);
-		json_object_object_del(jentry, "key");
-
-		if (!add_key_value(jentry, "key", key))
-			return false;
+		json_object_object_add(jobj, "appKeys", jarray);
 	}
 
+	json_object_array_add(jarray, jentry);
+
 	return true;
 fail:
 
@@ -589,6 +556,32 @@ fail:
 	return false;
 }
 
+bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
+							const uint8_t key[16])
+{
+	json_object *jarray, *jentry = NULL, *jstring = NULL;
+	const char *str;
+
+	json_object_object_get_ex(jobj, "appKeys", &jarray);
+	if (!jarray)
+		return false;
+
+	/* The key entry should exist if the key is updated */
+	jentry = get_key_object(jarray, app_idx);
+	if (!jentry)
+		return false;
+
+	if (!json_object_object_get_ex(jentry, "key", &jstring))
+		return false;
+
+	str = json_object_get_string(jstring);
+	jstring = json_object_new_string(str);
+	json_object_object_add(jentry, "oldKey", jstring);
+	json_object_object_del(jentry, "key");
+
+	return add_key_value(jentry, "key", key);
+}
+
 bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx)
 {
 	json_object *jarray, *jarray_new;
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 513ad3861..52ea05528 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -130,7 +130,9 @@ bool mesh_db_model_binding_add(json_object *jnode, uint8_t ele_idx, bool vendor,
 bool mesh_db_model_binding_del(json_object *jnode, uint8_t ele_idx, bool vendor,
 					uint32_t mod_id, uint16_t app_idx);
 bool mesh_db_app_key_add(json_object *jnode, uint16_t net_idx, uint16_t app_idx,
-					const uint8_t key[16], bool update);
+							const uint8_t key[16]);
+bool mesh_db_app_key_update(json_object *jobj, uint16_t app_idx,
+							const uint8_t key[16]);
 bool mesh_db_app_key_del(json_object *jobj, uint16_t net_idx, uint16_t idx);
 bool mesh_db_net_key_add(json_object *jobj, uint16_t net_idx,
 							const uint8_t key[16]);
diff --git a/mesh/storage.c b/mesh/storage.c
index d6b566a80..0b0582374 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -278,7 +278,10 @@ bool storage_app_key_add(struct mesh_net *net, uint16_t net_idx,
 	if (!jnode)
 		return false;
 
-	return mesh_db_app_key_add(jnode, net_idx, app_idx, key, update);
+	if (update)
+		return mesh_db_app_key_update(jnode, app_idx, key);
+
+	return mesh_db_app_key_add(jnode, net_idx, app_idx, key);
 }
 
 bool storage_app_key_del(struct mesh_net *net, uint16_t net_idx,
-- 
2.17.2

