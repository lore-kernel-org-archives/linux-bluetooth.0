Return-Path: <SRS0=okSL=QO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51624C282C4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 03:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF1A2175B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 03:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfBGDzm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:55:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:49795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfBGDzm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 22:55:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 19:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="scan'208";a="141359312"
Received: from ingas-nuc1.sea.intel.com ([10.251.16.219])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2019 19:55:42 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/5 v2] mesh: Add function to restore net key state from storage
Date:   Wed,  6 Feb 2019 19:55:34 -0800
Message-Id: <20190207035537.20375-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190207035537.20375-1-inga.stotland@intel.com>
References: <20190207035537.20375-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This creates subnet state based on saved network key state:
current keys and, if present, updated keys.
Secure network beacon is generated according to key refresh phase.
---
 mesh/net.c     | 90 ++++++++++++++++++++++++++++++++++++++++++++------
 mesh/net.h     |  2 ++
 mesh/storage.c |  6 +---
 3 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 91823c724..8cd547663 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -970,20 +970,10 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
+static int add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 {
 	struct mesh_subnet *subnet;
 
-	subnet = l_queue_find(net->subnets, match_key_index,
-							L_UINT_TO_PTR(idx));
-
-	if (subnet) {
-		if (net_key_confirm(subnet->net_key_cur, value))
-			return MESH_STATUS_SUCCESS;
-		else
-			return MESH_STATUS_IDX_ALREADY_STORED;
-	}
-
 	subnet = subnet_new(net, idx);
 	if (!subnet)
 		return MESH_STATUS_INSUFF_RESOURCES;
@@ -1000,6 +990,32 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 		return MESH_STATUS_INSUFF_RESOURCES;
 	}
 
+	return MESH_STATUS_SUCCESS;
+}
+
+/*
+ * This function is called when Configuration Server Model receives
+ * a NETKEY_ADD command
+ */
+int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
+{
+	struct mesh_subnet *subnet;
+	int status;
+
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(idx));
+
+	if (subnet) {
+		if (net_key_confirm(subnet->net_key_cur, value))
+			return MESH_STATUS_SUCCESS;
+		else
+			return MESH_STATUS_IDX_ALREADY_STORED;
+	}
+
+	status = add_key(net, idx, value);
+	if (status != MESH_STATUS_SUCCESS)
+		return status;
+
 	if (!storage_net_key_add(net, idx, value,
 					KEY_REFRESH_PHASE_NONE)) {
 		l_queue_remove(net->subnets, subnet);
@@ -2923,6 +2939,54 @@ bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable)
 	return true;
 }
 
+/* This function is called when network keys are restored from storage. */
+bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
+					const uint8_t *new_key, uint8_t phase)
+{
+	struct mesh_subnet *subnet;
+	int status;
+
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(idx));
+	if (subnet)
+		return false;
+
+	/* Current key must be always present */
+	if (!key)
+		return false;
+
+	/* If key refresh is in progress, a new key must be present */
+	if (phase != KEY_REFRESH_PHASE_NONE && !new_key)
+		return false;
+
+	status = add_key(net, idx, key);
+	if (status != MESH_STATUS_SUCCESS)
+		return false;
+
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(idx));
+	if (!subnet)
+		return false;
+
+	if (new_key)
+		subnet->net_key_upd = net_key_add(new_key);
+
+	/* Preserve key refresh state to generate secure beacon flags*/
+	if (phase == KEY_REFRESH_PHASE_TWO) {
+		subnet->key_refresh = 1;
+		subnet->net_key_tx = subnet->net_key_upd;
+	}
+
+	subnet->kr_phase = phase;
+
+	set_network_beacon(subnet, net);
+
+	if (net->io)
+		start_network_beacon(subnet, net);
+
+	return true;
+}
+
 static bool is_this_net(const void *a, const void *b)
 {
 	return a == b;
@@ -3556,6 +3620,10 @@ uint8_t mesh_net_key_refresh_phase_get(struct mesh_net *net, uint16_t idx,
 	return MESH_STATUS_SUCCESS;
 }
 
+/*
+ * This function is called when Configuration Server Model receives
+ * a NETKEY_UPDATE command
+ */
 int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 							const uint8_t *value)
 {
diff --git a/mesh/net.h b/mesh/net.h
index b27a4e614..591a6898e 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -284,6 +284,8 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t net_idx,
 							const uint8_t *key);
 int mesh_net_update_key(struct mesh_net *net, uint16_t net_idx,
 							const uint8_t *key);
+bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
+					const uint8_t *new_key, uint8_t phase);
 uint32_t mesh_net_get_iv_index(struct mesh_net *net);
 void mesh_net_get_snb_state(struct mesh_net *net,
 					uint8_t *flags, uint32_t *iv_index);
diff --git a/mesh/storage.c b/mesh/storage.c
index 1b52000b0..84f7c6161 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -120,11 +120,7 @@ static bool read_net_keys_cb(uint16_t idx, uint8_t *key, uint8_t *new_key,
 	if (!net)
 		return false;
 
-	if (mesh_net_add_key(net, idx, key) != MESH_STATUS_SUCCESS)
-		return false;
-	/* TODO: handle restoring key refresh phase and new keys */
-
-	return true;
+	return mesh_net_set_key(net, idx, key, new_key, phase);
 }
 
 static bool read_app_keys_cb(uint16_t net_idx, uint16_t app_idx, uint8_t *key,
-- 
2.17.2

