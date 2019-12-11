Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4DBC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 23:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7D221556
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 23:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLKX2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:28:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:52050 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfLKX2u (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 18:28:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 15:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="265038899"
Received: from ingas-nuc1.sea.intel.com ([10.251.159.74])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2019 15:28:48 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add more checks for element properties
Date:   Wed, 11 Dec 2019 15:28:47 -0800
Message-Id: <20191211232847.31501-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds consistency checks for mandatory properties on
org.bluez.mesh.Element1 interface:
    - disallow duplicate models on the same element
    - disallow elements with duplicate indices
    - disallow configuration server model on any element but primary
---
 mesh/node.c | 52 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index f8acc78c3..1f328bd21 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1081,7 +1081,7 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	free_node_dbus_resources(node);
 }
 
-static void get_sig_models_from_properties(struct node_element *ele,
+static bool get_sig_models_from_properties(struct node_element *ele,
 					struct l_dbus_message_iter *property)
 {
 	struct l_dbus_message_iter ids;
@@ -1091,24 +1091,31 @@ static void get_sig_models_from_properties(struct node_element *ele,
 		ele->models = l_queue_new();
 
 	if (!l_dbus_message_iter_get_variant(property, "aq", &ids))
-		return;
+		return false;
 
 	/* Bluetooth SIG defined models */
 	while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
 		struct mesh_model *mod;
 		uint32_t id = mod_id | VENDOR_ID_MASK;
 
+		/* Allow Config Server Model only on the primary element */
+		if (ele->idx != PRIMARY_ELE_IDX && id == CONFIG_SRV_MODEL)
+			return false;
+
+		/* Disallow duplicates */
 		if (l_queue_find(ele->models, match_model_id,
 						L_UINT_TO_PTR(id)))
-			continue;
+			return false;
 
 		mod = mesh_model_new(ele->idx, id);
 
 		l_queue_insert(ele->models, mod, compare_model_id, NULL);
 	}
+
+	return true;
 }
 
-static void get_vendor_models_from_properties(struct node_element *ele,
+static bool get_vendor_models_from_properties(struct node_element *ele,
 					struct l_dbus_message_iter *property)
 {
 	struct l_dbus_message_iter ids;
@@ -1118,21 +1125,24 @@ static void get_vendor_models_from_properties(struct node_element *ele,
 		ele->models = l_queue_new();
 
 	if (!l_dbus_message_iter_get_variant(property, "a(qq)", &ids))
-		return;
+		return false;
 
 	/* Vendor defined models */
 	while (l_dbus_message_iter_next_entry(&ids, &vendor_id, &mod_id)) {
 		struct mesh_model *mod;
 		uint32_t id = mod_id | (vendor_id << 16);
 
+		/* Disallow duplicates */
 		if (l_queue_find(ele->models, match_model_id,
 							L_UINT_TO_PTR(id)))
-			continue;
+			return false;
 
 		mod = mesh_model_new(ele->idx, id);
 
 		l_queue_insert(ele->models, mod, compare_model_id, NULL);
 	}
+
+	return true;
 }
 
 static bool get_element_properties(struct mesh_node *node, const char *path,
@@ -1150,34 +1160,36 @@ static bool get_element_properties(struct mesh_node *node, const char *path,
 	ele->location = DEFAULT_LOCATION;
 
 	while (l_dbus_message_iter_next_entry(properties, &key, &var)) {
-		if (!idx && !strcmp(key, "Index")) {
-			if (!l_dbus_message_iter_get_variant(&var, "y",
+		if (!strcmp(key, "Index")) {
+
+			if (idx || !l_dbus_message_iter_get_variant(&var, "y",
 								&ele->idx))
 				goto fail;
+
 			idx = true;
-			continue;
-		}
 
-		if (!mods && !strcmp(key, "Models")) {
-			get_sig_models_from_properties(ele, &var);
+		} else if (!strcmp(key, "Models")) {
+
+			if (mods || !get_sig_models_from_properties(ele, &var))
+				goto fail;
+
 			mods = true;
-			continue;
-		}
+		} else if (!strcmp(key, "VendorModels")) {
+
+			if (vendor_mods ||
+				!get_vendor_models_from_properties(ele, &var))
+				goto fail;
 
-		if (!vendor_mods && !strcmp(key, "VendorModels")) {
-			get_vendor_models_from_properties(ele, &var);
 			vendor_mods = true;
-			continue;
-		}
 
-		if (!strcmp(key, "Location")) {
+		} else if (!strcmp(key, "Location")) {
 			if (!l_dbus_message_iter_get_variant(&var, "q",
 							&ele->location))
 				goto fail;
-			continue;
 		}
 	}
 
+	/* Check for the presence of the required properties */
 	if (!idx || !mods || !vendor_mods)
 		goto fail;
 
-- 
2.21.0

