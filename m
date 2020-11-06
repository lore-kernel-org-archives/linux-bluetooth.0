Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B7C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 22:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFA4206F9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 22:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgKFWWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:22:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:51363 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgKFWWy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 17:22:54 -0500
IronPort-SDR: lDBlG4a219rlbryTquIOgAuq1hdo32hXqrLYYPW26ovJnkIZuJ7f9U/DKMhNhU53k3uOo4u009
 QGU0proU11cA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="148888570"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="148888570"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 14:22:54 -0800
IronPort-SDR: /SRzxm8sZNlOi2G1KZsXCJM2yQiKDi7bcsWBpocz3wJePcBLOaFMXm5PU9ySAeFb3Rv6dPCZ04
 xjiUrQ7/so7Q==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="472218718"
Received: from davidche-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.213.177.187])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 14:22:54 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh/mesh-config-json: Fix errors found by static analysis
Date:   Fri,  6 Nov 2020 14:22:45 -0800
Message-Id: <20201106222245.137189-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes miscellaneous issues related to unchecked return status
and (temporary) allocated memory leaks due to daemon's exit on startup
failure.
---
 mesh/mesh-config-json.c | 62 ++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index ec9ecb786..f142f0e1f 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -475,6 +475,7 @@ static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 		struct mesh_config_appkey *appkey;
 
 		appkey = l_new(struct mesh_config_appkey, 1);
+		l_queue_push_tail(node->appkeys, appkey);
 
 		jtemp = json_object_array_get_idx(jarray, i);
 
@@ -496,8 +497,6 @@ static bool read_app_keys(json_object *jobj, struct mesh_config_node *node)
 
 		if (!str2hex(str, strlen(str), appkey->key, 16))
 			goto fail;
-
-		l_queue_push_tail(node->appkeys, appkey);
 	}
 
 	return true;
@@ -532,6 +531,8 @@ static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 
 		netkey = l_new(struct mesh_config_netkey, 1);
 
+		l_queue_push_tail(node->netkeys, netkey);
+
 		jtemp = json_object_array_get_idx(jarray, i);
 
 		if (!get_key_index(jtemp, "index", &netkey->idx))
@@ -561,8 +562,6 @@ static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 
 		if (!str2hex(str, strlen(str), netkey->key, 16))
 			goto fail;
-
-		l_queue_push_tail(node->netkeys, netkey);
 	}
 
 	return true;
@@ -1036,7 +1035,7 @@ static bool parse_model_subscriptions(json_object *jsubs,
 
 		jvalue = json_object_array_get_idx(jsubs, i);
 		if (!jvalue)
-			return false;
+			goto fail;
 
 		str = (char *)json_object_get_string(jvalue);
 		len = strlen(str);
@@ -1045,7 +1044,7 @@ static bool parse_model_subscriptions(json_object *jsubs,
 		case 4:
 			if (sscanf(str, "%04hx", &subs[i].addr.grp) != 1)
 				goto fail;
-		break;
+			break;
 		case 32:
 			if (!str2hex(str, len, subs[i].addr.label, 16))
 				goto fail;
@@ -1086,6 +1085,8 @@ static bool parse_models(json_object *jmodels, struct mesh_config_element *ele)
 
 		mod = l_new(struct mesh_config_model, 1);
 
+		l_queue_push_tail(ele->models, mod);
+
 		if (!json_object_object_get_ex(jmodel, "modelId", &jvalue))
 			goto fail;
 
@@ -1093,13 +1094,9 @@ static bool parse_models(json_object *jmodels, struct mesh_config_element *ele)
 
 		len = strlen(str);
 
-		if (len != 4 && len != 8)
-			goto fail;
-
 		if (len == 4) {
 			if (sscanf(str, "%04x", &id) != 1)
 				goto fail;
-
 		} else if (len == 8) {
 			if (sscanf(str, "%08x", &id) != 1)
 				goto fail;
@@ -1135,8 +1132,6 @@ static bool parse_models(json_object *jmodels, struct mesh_config_element *ele)
 			if (!parse_model_subscriptions(jarray, mod))
 				goto fail;
 		}
-
-		l_queue_push_tail(ele->models, mod);
 	}
 
 	return true;
@@ -1584,16 +1579,19 @@ static void add_model(void *a, void *b)
 {
 	struct mesh_config_model *mod = a;
 	json_object *jmodels = b, *jmodel, *jval;
+	bool result;
 
 	jmodel = json_object_new_object();
 	if (!jmodel)
 		return;
 
-	if (!mod->vendor)
-		write_uint16_hex(jmodel, "modelId",
-						(uint16_t) mod->id);
-	else
-		write_uint32_hex(jmodel, "modelId", mod->id);
+	result = (mod->vendor) ? write_uint32_hex(jmodel, "modelId", mod->id) :
+			write_uint16_hex(jmodel, "modelId", (uint16_t) mod->id);
+
+	if (!result) {
+		json_object_put(jmodel);
+		return;
+	}
 
 	jval = json_object_new_boolean(mod->sub_enabled);
 	json_object_object_add(jmodel, "subEnabled", jval);
@@ -1671,24 +1669,24 @@ static struct mesh_config *create_config(const char *cfg_path,
 
 		jelement = json_object_new_object();
 
-		if (!jelement) {
-			json_object_put(jelems);
-			return NULL;
-		}
+		if (!jelement)
+			goto fail;
 
-		write_int(jelement, "elementIndex", ele->index);
-		write_uint16_hex(jelement, "location", ele->location);
 		json_object_array_add(jelems, jelement);
 
+		if (!write_int(jelement, "elementIndex", ele->index))
+			goto fail;
+
+		if (!write_uint16_hex(jelement, "location", ele->location))
+			goto fail;
+
 		/* Models */
 		if (l_queue_isempty(ele->models))
 			continue;
 
 		jmodels = json_object_new_array();
-		if (!jmodels) {
-			json_object_put(jelems);
-			return NULL;
-		}
+		if (!jmodels)
+			goto fail;
 
 		json_object_object_add(jelement, "models", jmodels);
 		l_queue_foreach(ele->models, add_model, jmodels);
@@ -1706,6 +1704,10 @@ static struct mesh_config *create_config(const char *cfg_path,
 	gettimeofday(&cfg->write_time, NULL);
 
 	return cfg;
+
+fail:
+		json_object_put(jelems);
+		return NULL;
 }
 
 struct mesh_config *mesh_config_create(const char *cfgdir_name,
@@ -2404,8 +2406,10 @@ static void idle_save_config(struct l_idle *idle, void *user_data)
 
 	if (result) {
 		remove(fname_bak);
-		rename(fname_cfg, fname_bak);
-		rename(fname_tmp, fname_cfg);
+
+		if (rename(fname_cfg, fname_bak) < 0 ||
+					rename(fname_tmp, fname_cfg) < 0)
+			result = false;
 	}
 
 	remove(fname_tmp);
-- 
2.26.2

