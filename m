Return-Path: <SRS0=ZFDx=QV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D154BC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA50921B1A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 03:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395432AbfBNDpb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:45:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:19361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395323AbfBNDpa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Feb 2019 22:45:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 19:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; 
   d="scan'208";a="274927356"
Received: from ingas-nuc1.sea.intel.com ([10.254.99.167])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 19:45:30 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/3] mesh: Separate functions for app key add and update
Date:   Wed, 13 Feb 2019 19:45:25 -0800
Message-Id: <20190214034527.6310-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190214034527.6310-1-inga.stotland@intel.com>
References: <20190214034527.6310-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This splits appkey_key_add() into two separate functions:
app_key_add() and app_key_update().
Fix checks for miscellaneous invalid conditions and return
appropriate error status.
---
 mesh/appkey.c        | 89 +++++++++++++++++++++++++-------------------
 mesh/appkey.h        |  4 +-
 mesh/cfgmod-server.c |  8 +++-
 3 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index a437763db..f799b7782 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -364,8 +364,8 @@ bool appkey_have_key(struct mesh_net *net, uint16_t app_idx)
 		return true;
 }
 
-int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
-					const uint8_t *new_key, bool update)
+int appkey_key_update(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
+							const uint8_t *new_key)
 {
 	struct mesh_app_key *key;
 	struct l_queue *app_keys;
@@ -375,61 +375,74 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 	if (!app_keys)
 		return MESH_STATUS_INSUFF_RESOURCES;
 
-	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
-
-	if (!mesh_net_have_key(net, net_idx) ||
-					(update && key->net_idx != net_idx))
+	if (!mesh_net_have_key(net, net_idx))
 		return MESH_STATUS_INVALID_NETKEY;
 
-	if (update && !key)
+	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
+
+	if (!key)
 		return MESH_STATUS_INVALID_APPKEY;
 
+	if (key->net_idx != net_idx)
+		return MESH_STATUS_INVALID_BINDING;
+
 	mesh_net_key_refresh_phase_get(net, net_idx, &phase);
-	if (update && phase != KEY_REFRESH_PHASE_ONE)
+	if (phase != KEY_REFRESH_PHASE_ONE)
 		return MESH_STATUS_CANNOT_UPDATE;
 
+	/* Check if the key has been already successfully updated */
+	if (memcmp(new_key, key->new_key, 16) == 0)
+		return MESH_STATUS_SUCCESS;
+
+	if (!set_key(key, app_idx, new_key, true))
+		return MESH_STATUS_INSUFF_RESOURCES;
+
+	if (!storage_app_key_add(net, net_idx, app_idx, new_key, true))
+		return MESH_STATUS_STORAGE_FAIL;
+
+	return MESH_STATUS_SUCCESS;
+}
+
+int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
+							const uint8_t *new_key)
+{
+	struct mesh_app_key *key;
+	struct l_queue *app_keys;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return MESH_STATUS_INSUFF_RESOURCES;
+
+	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
 	if (key) {
 		if (memcmp(new_key, key->key, 16) == 0)
 			return MESH_STATUS_SUCCESS;
-
-		if (!update) {
-			l_debug("Failed to add key: index already stored %x",
-				(net_idx << 16) | app_idx);
+		else
 			return MESH_STATUS_IDX_ALREADY_STORED;
-		}
 	}
 
-	if (!key) {
-		if (!(l_queue_length(app_keys) < MAX_APP_KEYS))
-			return MESH_STATUS_INSUFF_RESOURCES;
-
-		key = app_key_new();
-		if (!key)
-			return MESH_STATUS_INSUFF_RESOURCES;
+	if (!mesh_net_have_key(net, net_idx))
+		return MESH_STATUS_INVALID_NETKEY;
 
-		if (!set_key(key, app_idx, new_key, false)) {
-			appkey_key_free(key);
-			return MESH_STATUS_INSUFF_RESOURCES;
-		}
+	if (l_queue_length(app_keys) >= MAX_APP_KEYS)
+		return MESH_STATUS_INSUFF_RESOURCES;
 
-		if (!storage_app_key_add(net, net_idx, app_idx, new_key,
-								false)) {
-			appkey_key_free(key);
-			return MESH_STATUS_STORAGE_FAIL;
-		}
+	key = app_key_new();
 
-		key->net_idx = net_idx;
-		key->app_idx = app_idx;
-		l_queue_push_tail(app_keys, key);
-	} else {
-		if (!set_key(key, app_idx, new_key, true))
-			return MESH_STATUS_INSUFF_RESOURCES;
+	if (!set_key(key, app_idx, new_key, false)) {
+		appkey_key_free(key);
+		return MESH_STATUS_INSUFF_RESOURCES;
+	}
 
-		if (!storage_app_key_add(net, net_idx, app_idx, new_key,
-								true))
-			return MESH_STATUS_STORAGE_FAIL;
+	if (!storage_app_key_add(net, net_idx, app_idx, new_key, false)) {
+		appkey_key_free(key);
+		return MESH_STATUS_STORAGE_FAIL;
 	}
 
+	key->net_idx = net_idx;
+	key->app_idx = app_idx;
+	l_queue_push_tail(app_keys, key);
+
 	l_queue_clear(key->replay_cache, l_free);
 
 	return MESH_STATUS_SUCCESS;
diff --git a/mesh/appkey.h b/mesh/appkey.h
index 21bc6a70e..eda82ac3b 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -35,7 +35,9 @@ const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 							uint8_t *key_id);
 bool appkey_have_key(struct mesh_net *net, uint16_t app_idx);
 int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
-					const uint8_t *new_key, bool update);
+							const uint8_t *new_key);
+int appkey_key_update(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
+							const uint8_t *new_key);
 int appkey_key_delete(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx);
 void appkey_delete_bound_keys(struct mesh_net *net, uint16_t net_idx);
 uint8_t appkey_list(struct mesh_net *net, uint16_t net_idx, uint8_t *buf,
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 899bdde2e..992d4ac6a 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -925,8 +925,12 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 
 		net_idx = l_get_le16(pkt) & 0xfff;
 		app_idx = l_get_le16(pkt + 1) >> 4;
-		b_res = appkey_key_add(net, net_idx, app_idx, pkt + 3,
-						opcode == OP_APPKEY_UPDATE);
+
+		if (opcode == OP_APPKEY_ADD)
+			b_res = appkey_key_add(net, net_idx, app_idx, pkt + 3);
+		else
+			b_res = appkey_key_update(net, net_idx, app_idx,
+								pkt + 3);
 
 		l_debug("Add/Update AppKey %s: Net_Idx %3.3x, App_Idx %3.3x",
 			(b_res == MESH_STATUS_SUCCESS) ? "success" : "fail",
-- 
2.17.2

