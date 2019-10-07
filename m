Return-Path: <SRS0=J5Bo=YA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EAFC47404
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 20:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE3A21721
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 20:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfJGUdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:33:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:30185 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGUdb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Oct 2019 16:33:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 13:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="368225725"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.139.185])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2019 13:33:30 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ] mesh: Fix IV_Index recovery logic
Date:   Mon,  7 Oct 2019 13:33:20 -0700
Message-Id: <20191007203320.31820-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fix divorces the state tracking of the IV Index updating stages
from the actual realtime setting of IV_Index and IV_Update values.

We are more permissive about what we accept as IV_Index and the IVU
boolean from incoming Secure Network Beacons on Startup, in case the
daemon has "Been Away" from the mesh network. But we need to more
carefully track what IV_Index we use for outgoing messages, and the
instant we reset the outgoing Sequence number to Zero.  So iv_index,
and iv_update are now fully independant of the iv_upd_state.
---
 mesh/mesh-config-json.c |  3 +-
 mesh/net.c              | 83 ++++++++++++++++++++++++++---------------
 2 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 198fef518..df58cbd7d 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -2057,7 +2057,8 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 		return mesh_config_save(cfg, true, NULL, NULL);
 	}
 
-	if (get_int(cfg->jnode, "sequenceNumber", &value))
+	/* If resetting seq to Zero, make sure cached value reset as well */
+	if (seq && get_int(cfg->jnode, "sequenceNumber", &value))
 		cached = (uint32_t)value;
 
 	/*
diff --git a/mesh/net.c b/mesh/net.c
index 2785039db..64333f64c 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -503,6 +503,7 @@ void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn,
 uint32_t mesh_net_next_seq_num(struct mesh_net *net)
 {
 	uint32_t seq = net->seq_num++;
+
 	node_set_sequence_number(net->node, net->seq_num);
 	return seq;
 }
@@ -718,6 +719,7 @@ bool mesh_net_set_seq_num(struct mesh_net *net, uint32_t seq)
 		return false;
 
 	net->seq_num = seq;
+	node_set_sequence_number(net->node, net->seq_num);
 
 	return true;
 }
@@ -1034,7 +1036,7 @@ uint32_t mesh_net_get_iv_index(struct mesh_net *net)
 	if (!net)
 		return 0xffffffff;
 
-	return net->iv_index - (iv_is_updating(net) ? 1 : 0);
+	return net->iv_index - net->iv_update;
 }
 
 /* TODO: net key index? */
@@ -2619,7 +2621,10 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 		l_info("iv_upd_state = IV_UPD_NORMAL_HOLD");
 		net->iv_upd_state = IV_UPD_NORMAL_HOLD;
 		l_timeout_modify(net->iv_update_timeout, IV_IDX_UPD_MIN);
-		mesh_net_set_seq_num(net, 0);
+		if (net->iv_update)
+			mesh_net_set_seq_num(net, 0);
+
+		net->iv_update = false;
 		l_queue_foreach(net->subnets, set_network_beacon, net);
 		mesh_net_flush_msg_queues(net);
 		break;
@@ -2631,6 +2636,10 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 		net->iv_update_timeout = NULL;
 		l_info("iv_upd_state = IV_UPD_NORMAL");
 		net->iv_upd_state = IV_UPD_NORMAL;
+		if (net->iv_update)
+			mesh_net_set_seq_num(net, 0);
+
+		net->iv_update = false;
 		if (net->seq_num > IV_UPDATE_SEQ_TRIGGER)
 			mesh_net_iv_index_update(net);
 		break;
@@ -2721,23 +2730,33 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 	 */
 	local_iv_index = net->iv_index;
 	local_kr = subnet->key_refresh;
-	local_iv_update = iv_is_updating(net);
+	local_iv_update = net->iv_update;
 
-	if (iv_index != local_iv_index || kr_transition)
+	if ((iv_index - iv_update) < (local_iv_index - local_iv_update)) {
+		/* Disallow negative adjustments */
+		l_debug("Expired beacon received");
+		return;
+	}
+
+	if (iv_index != local_iv_index || iv_update != local_iv_update ||
+								kr_transition)
 		l_info("SNB-RX: %8.8x - Key Refresh: %d IV Update: %d",
 					iv_index, rxed_key_refresh, iv_update);
 
 	if (iv_update && (net->iv_upd_state > IV_UPD_UPDATING)) {
 		if (iv_index != net->iv_index)
-			l_error("Update attempted to0 soon (Normal < MIN)");
+			l_error("Update attempted too soon (Normal < MIN)");
 
 		return;
 	}
 
 	if (net->iv_upd_state == IV_UPD_INIT) {
-		if (iv_index > net->iv_index)
+		local_iv_index -= local_iv_update;
+		if ((iv_index - iv_update) > local_iv_index)
 			mesh_net_set_seq_num(net, 0);
+
 		net->iv_index = iv_index;
+		net->iv_update = iv_update;
 
 		if (iv_update) {
 			/* Other devices will be accepting old or new iv_index,
@@ -2755,7 +2774,7 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 		}
 
 		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
-							net->iv_upd_state);
+								iv_update);
 
 		/* Figure out the key refresh phase */
 		if (kr_transition) {
@@ -2772,29 +2791,32 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 		return;
 	}
 
-	if (iv_update && !iv_is_updating(net)) {
-		l_info("iv_upd_state = IV_UPD_UPDATING");
-		net->iv_upd_state = IV_UPD_UPDATING;
-		net->iv_update_timeout = l_timeout_create(IV_IDX_UPD_MIN,
-							iv_upd_to, net, NULL);
-		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
-							net->iv_upd_state);
-	} else if (iv_update && iv_index != net->iv_index) {
-		l_error("Update attempted too soon (iv idx already updated)");
-		return;
+	if (iv_update) {
+		if (!local_iv_update &&
+				net->iv_upd_state == IV_UPD_NORMAL_HOLD) {
+			l_error("Update attempted too soon");
+			return;
+		}
+		if (!local_iv_update) {
+			l_info("iv_upd_state = IV_UPD_UPDATING");
+			net->iv_upd_state = IV_UPD_UPDATING;
+			net->iv_update_timeout = l_timeout_create(
+					IV_IDX_UPD_MIN, iv_upd_to, net, NULL);
+		}
 	}
 
-	if (iv_index != local_iv_index || kr_transition)
-		l_info("IVindex 0x%8.8x / Key Refresh update received",
-								iv_index);
+	net->iv_index = iv_index;
+	net->iv_update = iv_update;
 
-	if (iv_index > net->iv_index) {
+	if (iv_update != local_iv_update || iv_index != local_iv_index) {
 		l_queue_clear(net->msg_cache, mesh_msg_free);
-		net->iv_index = iv_index;
 		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
-							net->iv_upd_state);
+								iv_update);
 	}
 
+	if ((iv_index - iv_update) > (local_iv_index - local_iv_update))
+		mesh_net_set_seq_num(net, 0);
+
 	/* Figure out the key refresh phase */
 	if (kr_transition) {
 		if (rxed_key_refresh)
@@ -2803,12 +2825,12 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 			key_refresh_finish(net, subnet->idx);
 	}
 
-	if (!lpn)
+	/* Don't Beacon if we are an LPN */
+	if (lpn)
 		return;
 
-	if (local_kr != subnet->key_refresh ||
-					local_iv_index != net->iv_index ||
-					local_iv_update != iv_is_updating(net))
+	if (local_kr != subnet->key_refresh || local_iv_index != iv_index ||
+						local_iv_update != iv_update)
 		set_network_beacon(subnet, net);
 }
 
@@ -3128,12 +3150,13 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 
 	l_info("iv_upd_state = IV_UPD_UPDATING");
 	mesh_net_flush_msg_queues(net);
-	net->iv_upd_state = IV_UPD_UPDATING;
-	net->iv_index++;
 	if (!mesh_config_write_iv_index(node_config_get(net->node),
-					net->iv_index, IV_UPD_UPDATING))
+						net->iv_index + 1, true))
 		return false;
 
+	net->iv_upd_state = IV_UPD_UPDATING;
+	net->iv_index++;
+	net->iv_update = true;
 	l_queue_foreach(net->subnets, set_network_beacon, net);
 	net->iv_update_timeout = l_timeout_create(
 			IV_IDX_UPD_MIN,
-- 
2.21.0

