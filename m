Return-Path: <SRS0=okSL=QO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402FCC282C2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 03:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F67F2175B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Feb 2019 03:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfBGDzq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:55:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:49795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfBGDzq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 22:55:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 19:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="scan'208";a="141359323"
Received: from ingas-nuc1.sea.intel.com ([10.251.16.219])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2019 19:55:44 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/5 v2] mesh: Declare internal functions as static
Date:   Wed,  6 Feb 2019 19:55:35 -0800
Message-Id: <20190207035537.20375-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190207035537.20375-1-inga.stotland@intel.com>
References: <20190207035537.20375-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This renames mesh_net_key_refresh_finish() to key_refresh_finish() and
mesh_net_key_phase_two() to key_refresh_phase_wo() and changes the
function declaration to static since they are called only within net.c
---
 mesh/net.c | 146 ++++++++++++++++++++++++++---------------------------
 mesh/net.h |   2 -
 2 files changed, 73 insertions(+), 75 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 8cd547663..1be722181 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1016,8 +1016,7 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 	if (status != MESH_STATUS_SUCCESS)
 		return status;
 
-	if (!storage_net_key_add(net, idx, value,
-					KEY_REFRESH_PHASE_NONE)) {
+	if (!storage_net_key_add(net, idx, value, KEY_REFRESH_PHASE_NONE)) {
 		l_queue_remove(net->subnets, subnet);
 		subnet_free(subnet);
 		return MESH_STATUS_STORAGE_FAIL;
@@ -2629,6 +2628,70 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 	}
 }
 
+
+static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
+{
+	struct mesh_subnet *subnet;
+
+	if (!net)
+		return MESH_STATUS_UNSPECIFIED_ERROR;
+
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(idx));
+
+	if (!subnet || !subnet->net_key_upd)
+		return MESH_STATUS_INVALID_NETKEY;
+
+	l_info("Key refresh procedure phase 2: start using new net TX keys");
+	subnet->key_refresh = 1;
+	subnet->net_key_tx = subnet->net_key_upd;
+	/* TODO: Provisioner may need to stay in phase three until
+	 * it hears beacons from all the nodes
+	 */
+	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
+	set_network_beacon(subnet, net);
+
+	if (net->friend_addr)
+		frnd_key_refresh(net, 2);
+	else
+		l_queue_foreach(net->friends, frnd_kr_phase2, net);
+
+	return MESH_STATUS_SUCCESS;
+}
+
+static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
+{
+	struct mesh_subnet *subnet;
+
+	if (!net)
+		return MESH_STATUS_UNSPECIFIED_ERROR;
+
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(idx));
+	if (!subnet || !subnet->net_key_upd)
+		return MESH_STATUS_INVALID_NETKEY;
+
+	if (subnet->kr_phase == KEY_REFRESH_PHASE_NONE)
+		return MESH_STATUS_SUCCESS;
+
+	l_info("Key refresh phase 3: use new keys only, discard old ones");
+
+	/* Switch to using new keys, discard old ones */
+	net_key_unref(subnet->net_key_cur);
+	subnet->net_key_tx = subnet->net_key_cur = subnet->net_key_upd;
+	subnet->net_key_upd = 0;
+	subnet->key_refresh = 0;
+	subnet->kr_phase = KEY_REFRESH_PHASE_NONE;
+	set_network_beacon(subnet, net);
+
+	if (net->friend_addr)
+		frnd_key_refresh(net, 3);
+	else
+		l_queue_foreach(net->friends, frnd_kr_phase3, net);
+
+	return MESH_STATUS_SUCCESS;
+}
+
 static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 				bool iv_update, bool kr_transition,
 				bool rxed_key_refresh, bool lpn)
@@ -2680,11 +2743,11 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 
 		/* Figure out the key refresh phase */
 		if (kr_transition) {
+			l_debug("Beacon based KR phase change");
 			if (rxed_key_refresh)
-				mesh_net_key_refresh_phase_two(net,
-								subnet->idx);
+				key_refresh_phase_two(net, subnet->idx);
 			else
-				mesh_net_key_refresh_finish(net, subnet->idx);
+				key_refresh_finish(net, subnet->idx);
 		}
 
 		if (!lpn)
@@ -2717,9 +2780,9 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 	/* Figure out the key refresh phase */
 	if (kr_transition) {
 		if (rxed_key_refresh)
-			mesh_net_key_refresh_phase_two(net, subnet->idx);
+			key_refresh_phase_two(net, subnet->idx);
 		else
-			mesh_net_key_refresh_finish(net, subnet->idx);
+			key_refresh_finish(net, subnet->idx);
 	}
 
 	if (!lpn)
@@ -3588,18 +3651,19 @@ uint8_t mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t idx,
 
 	switch (transition) {
 	case 2:
-		if (mesh_net_key_refresh_phase_two(net, idx)
+		if (key_refresh_phase_two(net, idx)
 							!= MESH_STATUS_SUCCESS)
 			return MESH_STATUS_CANNOT_SET;
 		break;
 	case 3:
-		if (mesh_net_key_refresh_finish(net, idx)
+		if (key_refresh_finish(net, idx)
 							!= MESH_STATUS_SUCCESS)
 			return MESH_STATUS_CANNOT_SET;
 		break;
 	default:
 		return MESH_STATUS_CANNOT_SET;
 	}
+
 	return MESH_STATUS_SUCCESS;
 }
 
@@ -3674,70 +3738,6 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_net_key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
-{
-	struct mesh_subnet *subnet;
-
-	if (!net)
-		return MESH_STATUS_UNSPECIFIED_ERROR;
-
-	subnet = l_queue_find(net->subnets, match_key_index,
-							L_UINT_TO_PTR(idx));
-
-	if (!subnet || !subnet->net_key_upd)
-		return MESH_STATUS_INVALID_NETKEY;
-
-	l_info("Key refresh procedure phase 2: start using new net TX keys");
-	subnet->key_refresh = 1;
-	subnet->net_key_tx = subnet->net_key_upd;
-	/* TODO: Provisioner may need to stay in phase three until
-	 * it hears beacons from all the nodes
-	 */
-	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
-	set_network_beacon(subnet, net);
-
-	if (net->friend_addr)
-		frnd_key_refresh(net, 2);
-	else
-		l_queue_foreach(net->friends, frnd_kr_phase2, net);
-
-	return MESH_STATUS_SUCCESS;
-}
-
-int mesh_net_key_refresh_finish(struct mesh_net *net, uint16_t idx)
-{
-	struct mesh_subnet *subnet;
-
-	if (!net)
-		return MESH_STATUS_UNSPECIFIED_ERROR;
-
-	subnet = l_queue_find(net->subnets, match_key_index,
-							L_UINT_TO_PTR(idx));
-
-	if (!subnet || !subnet->net_key_upd)
-		return MESH_STATUS_INVALID_NETKEY;
-
-	if (subnet->kr_phase == KEY_REFRESH_PHASE_NONE)
-		return MESH_STATUS_SUCCESS;
-
-	l_info("Key refresh phase 3: use new keys only, discard old ones");
-
-	/* Switch to using new keys, discard old ones */
-	net_key_unref(subnet->net_key_cur);
-	subnet->net_key_tx = subnet->net_key_cur = subnet->net_key_upd;
-	subnet->net_key_upd = 0;
-	subnet->key_refresh = 0;
-	subnet->kr_phase = KEY_REFRESH_PHASE_NONE;
-	set_network_beacon(subnet, net);
-
-	if (net->friend_addr)
-		frnd_key_refresh(net, 3);
-	else
-		l_queue_foreach(net->friends, frnd_kr_phase3, net);
-
-	return MESH_STATUS_SUCCESS;
-}
-
 uint16_t mesh_net_get_features(struct mesh_net *net)
 {
 	uint16_t features = 0;
diff --git a/mesh/net.h b/mesh/net.h
index 591a6898e..e040e19fa 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -339,8 +339,6 @@ uint8_t mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t net_idx,
 							uint8_t transition);
 uint8_t mesh_net_key_refresh_phase_get(struct mesh_net *net, uint16_t net_idx,
 							uint8_t *phase);
-int mesh_net_key_refresh_phase_two(struct mesh_net *net, uint16_t net_idx);
-int mesh_net_key_refresh_finish(struct mesh_net *net, uint16_t net_idx);
 void mesh_net_send_seg(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, uint32_t hdr,
-- 
2.17.2

