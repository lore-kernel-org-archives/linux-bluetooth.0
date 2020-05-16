Return-Path: <SRS0=p+wm=66=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C70C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 01:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5D620756
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 01:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgEPB1w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 21:27:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:12009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgEPB1v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 21:27:51 -0400
IronPort-SDR: 0IFrDY+/Sf66Fhh2zpIfTvfGgwFutqR08DHg+vCNx+D+wfmT6G8r/z9iD/CnS0Wwo1lRn/b/Rg
 V+8iVET+vK0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 18:27:51 -0700
IronPort-SDR: 0T3vG1VZlL31+zCfhNSDIFmiFLrBEzm8TadnAXIdM6Gb930b88wEe9h+qHqCvYrgbXJmiYmSz0
 P7M8nc2MoeRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,397,1583222400"; 
   d="scan'208";a="307568634"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.132.104])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2020 18:27:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 1/2] mesh: Fix valgrind memory leaks
Date:   Fri, 15 May 2020 18:27:41 -0700
Message-Id: <20200516012742.573151-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200516012742.573151-1-brian.gix@intel.com>
References: <20200516012742.573151-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These memory leaks are ones that will compound over time with node
creation and deletion.
---
 mesh/mesh-config-json.c | 16 ++++++++--------
 mesh/mesh.c             |  5 ++++-
 mesh/node.c             |  1 +
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 9ac3979f8..6567d761c 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -447,8 +447,6 @@ static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 	if (!len)
 		return true;
 
-	node->appkeys = l_queue_new();
-
 	for (i = 0; i < len; ++i) {
 		json_object *jtemp, *jvalue;
 		char *str;
@@ -505,8 +503,6 @@ static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 	if (!len)
 		return false;
 
-	node->netkeys = l_queue_new();
-
 	for (i = 0; i < len; ++i) {
 		json_object *jtemp, *jvalue;
 		char *str;
@@ -1133,8 +1129,6 @@ static bool parse_elements(json_object *jelems, struct mesh_config_node *node)
 		/* Allow "empty" nodes */
 		return true;
 
-	node->elements = l_queue_new();
-
 	for (i = 0; i < num_ele; ++i) {
 		json_object *jelement;
 		json_object *jmodels;
@@ -1154,6 +1148,7 @@ static bool parse_elements(json_object *jelems, struct mesh_config_node *node)
 		ele = l_new(struct mesh_config_element, 1);
 		ele->index = index;
 		ele->models = l_queue_new();
+		l_queue_push_tail(node->elements, ele);
 
 		if (!json_object_object_get_ex(jelement, "location", &jvalue))
 			goto fail;
@@ -1167,8 +1162,6 @@ static bool parse_elements(json_object *jelems, struct mesh_config_node *node)
 						!parse_models(jmodels, ele))
 				goto fail;
 		}
-
-		l_queue_push_tail(node->elements, ele);
 	}
 
 	return true;
@@ -2133,6 +2126,11 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
 		goto done;
 
 	memset(&node, 0, sizeof(node));
+
+	node.elements = l_queue_new();
+	node.netkeys = l_queue_new();
+	node.appkeys = l_queue_new();
+
 	result = read_node(jnode, &node);
 
 	if (result) {
@@ -2148,6 +2146,7 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
 		result = cb(&node, uuid, cfg, user_data);
 
 		if (!result) {
+			l_free(cfg->idles);
 			l_free(cfg->node_dir_path);
 			l_free(cfg);
 		}
@@ -2157,6 +2156,7 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
 	l_free(node.net_transmit);
 	l_queue_destroy(node.netkeys, l_free);
 	l_queue_destroy(node.appkeys, l_free);
+	l_queue_destroy(node.elements, free_element);
 
 	if (!result)
 		json_object_put(jnode);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 890a3aa8f..23ff9c2a8 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -209,7 +209,7 @@ static void parse_settings(const char *mesh_conf_fname)
 
 	settings = l_settings_new();
 	if (!l_settings_load_from_file(settings, mesh_conf_fname))
-		return;
+		goto done;
 
 	str = l_settings_get_string(settings, "General", "Beacon");
 	if (str) {
@@ -242,6 +242,9 @@ static void parse_settings(const char *mesh_conf_fname)
 
 	if (l_settings_get_uint(settings, "General", "ProvTimeout", &value))
 		mesh.prov_timeout = value;
+
+done:
+	l_settings_free(settings);
 }
 
 bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
diff --git a/mesh/node.c b/mesh/node.c
index 8914b639d..2b4b3a563 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -335,6 +335,7 @@ static void free_node_resources(void *data)
 
 	free_node_dbus_resources(node);
 
+	mesh_config_release(node->cfg);
 	mesh_net_free(node->net);
 	l_free(node->storage_dir);
 	l_free(node);
-- 
2.25.4

