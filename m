Return-Path: <SRS0=lLJx=YD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A98EC4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Oct 2019 22:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B0220B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Oct 2019 22:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJJWvh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:51:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:48778 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbfJJWvg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Oct 2019 18:51:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 15:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="193359241"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.229.50])
  by fmsmga008.fm.intel.com with ESMTP; 10 Oct 2019 15:51:34 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v2] mesh: Secure Beacon - IV_Index/Key Refresh re-write
Date:   Thu, 10 Oct 2019 15:51:21 -0700
Message-Id: <20191010225121.2758-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a major rewrite of Secure Network Beacon (SNB) handling
that includes:

* Seperating Key Refresh from IV_Index handling

  This is a clearer handling of the two features. Although both features
  are represented in SNB's, they run independantly.

* Creating a Seperate IV_Index initialization and updating state
  distinct from the current values sent and received in SNBs.

  If a restart occured during an IV Update procedure (96 hours long)
  the IVU bit got lost, and Sequence number resetting was not done
  correctly.

* Assuring that all Nodes handled by daemon receive each incoming
  beacon. SNB handling previously stopped after the first node
  successfuly handled it, although the SNB may be valid for many local
  nodes.
---
 mesh/mesh-config-json.c |   3 +-
 mesh/net.c              | 355 +++++++++++++++-------------------------
 2 files changed, 135 insertions(+), 223 deletions(-)

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
index 2785039db..77e3e20eb 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -41,8 +41,8 @@
 
 #define IV_IDX_DIFF_RANGE	42
 
-/* #define IV_IDX_UPD_MIN	(60)		1 minute for Testing */
-#define IV_IDX_UPD_MIN	(60 * 60 * 96)	/* 96 Hours - per Spec */
+#define IV_IDX_UPD_MIN	(5 * 60)	/* 5 minute for Testing */
+//#define IV_IDX_UPD_MIN	(60 * 60 * 96)	/* 96 Hours - per Spec */
 #define IV_IDX_UPD_HOLD	(IV_IDX_UPD_MIN/2)
 #define IV_IDX_UPD_MAX	(IV_IDX_UPD_MIN + IV_IDX_UPD_HOLD)
 
@@ -257,6 +257,11 @@ struct net_queue_data {
 	uint16_t len;
 };
 
+struct net_beacon_data {
+	const uint8_t *data;
+	uint16_t len;
+};
+
 #define FAST_CACHE_SIZE 8
 static struct l_queue *fast_cache;
 static struct l_queue *nets;
@@ -503,6 +508,7 @@ void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn,
 uint32_t mesh_net_next_seq_num(struct mesh_net *net)
 {
 	uint32_t seq = net->seq_num++;
+
 	node_set_sequence_number(net->node, net->seq_num);
 	return seq;
 }
@@ -568,9 +574,10 @@ static bool create_secure_beacon(struct mesh_net *net,
 					struct mesh_subnet *subnet,
 					uint8_t *beacon_data)
 {
+	bool kr = (subnet->kr_phase == KEY_REFRESH_PHASE_TWO);
+
 	return net_key_snb_compose(subnet->net_key_tx, net->iv_index,
-				!!subnet->key_refresh, iv_is_updating(net),
-								beacon_data);
+					kr, net->iv_update, beacon_data);
 }
 
 static void send_network_beacon(struct mesh_subnet *subnet,
@@ -718,6 +725,7 @@ bool mesh_net_set_seq_num(struct mesh_net *net, uint32_t seq)
 		return false;
 
 	net->seq_num = seq;
+	node_set_sequence_number(net->node, net->seq_num);
 
 	return true;
 }
@@ -1034,7 +1042,7 @@ uint32_t mesh_net_get_iv_index(struct mesh_net *net)
 	if (!net)
 		return 0xffffffff;
 
-	return net->iv_index - (iv_is_updating(net) ? 1 : 0);
+	return net->iv_index - net->iv_update;
 }
 
 /* TODO: net key index? */
@@ -2616,10 +2624,15 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 			break;
 		}
 
-		l_info("iv_upd_state = IV_UPD_NORMAL_HOLD");
+		l_debug("iv_upd_state = IV_UPD_NORMAL_HOLD");
 		net->iv_upd_state = IV_UPD_NORMAL_HOLD;
 		l_timeout_modify(net->iv_update_timeout, IV_IDX_UPD_MIN);
-		mesh_net_set_seq_num(net, 0);
+		if (net->iv_update)
+			mesh_net_set_seq_num(net, 0);
+
+		net->iv_update = false;
+		mesh_config_write_iv_index(node_config_get(net->node),
+							net->iv_index, false);
 		l_queue_foreach(net->subnets, set_network_beacon, net);
 		mesh_net_flush_msg_queues(net);
 		break;
@@ -2629,8 +2642,12 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 	case IV_UPD_NORMAL:
 		l_timeout_remove(upd_timeout);
 		net->iv_update_timeout = NULL;
-		l_info("iv_upd_state = IV_UPD_NORMAL");
+		l_debug("iv_upd_state = IV_UPD_NORMAL");
 		net->iv_upd_state = IV_UPD_NORMAL;
+		if (net->iv_update)
+			mesh_net_set_seq_num(net, 0);
+
+		net->iv_update = false;
 		if (net->seq_num > IV_UPDATE_SEQ_TRIGGER)
 			mesh_net_iv_index_update(net);
 		break;
@@ -2707,39 +2724,41 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	return MESH_STATUS_SUCCESS;
 }
 
-static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
-				bool iv_update, bool kr_transition,
-				bool rxed_key_refresh, bool lpn)
+static void update_kr_state(struct mesh_subnet *subnet, bool kr, uint32_t id)
+{
+	/* Figure out the key refresh phase */
+	if (kr) {
+		if (id == subnet->net_key_upd) {
+			l_debug("Beacon based KR phase 2 change");
+			key_refresh_phase_two(subnet->net, subnet->idx);
+		}
+	} else {
+		if (id == subnet->net_key_upd) {
+			l_debug("Beacon based KR phase 3 change");
+			key_refresh_finish(subnet->net, subnet->idx);
+		}
+	}
+}
+
+static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
+								bool ivu)
 {
-	struct mesh_net *net = subnet->net;
-	uint8_t local_kr;
 	uint32_t local_iv_index;
-	bool local_iv_update;
+	bool local_ivu;
 
-	/* Save original settings to avoid resetting same values,
-	 * and secure beacon timer
-	 */
+	/* Save original settings to differentiate what has changed */
 	local_iv_index = net->iv_index;
-	local_kr = subnet->key_refresh;
-	local_iv_update = iv_is_updating(net);
-
-	if (iv_index != local_iv_index || kr_transition)
-		l_info("SNB-RX: %8.8x - Key Refresh: %d IV Update: %d",
-					iv_index, rxed_key_refresh, iv_update);
+	local_ivu = net->iv_update;
 
-	if (iv_update && (net->iv_upd_state > IV_UPD_UPDATING)) {
-		if (iv_index != net->iv_index)
-			l_error("Update attempted to0 soon (Normal < MIN)");
-
-		return;
+	if ((iv_index - ivu) > (local_iv_index - local_ivu)) {
+		/* Don't accept IV_Index changes when performing SAR Out */
+		if (l_queue_length(net->sar_out))
+			return;
 	}
 
+	/* If first beacon seen, accept without judgement */
 	if (net->iv_upd_state == IV_UPD_INIT) {
-		if (iv_index > net->iv_index)
-			mesh_net_set_seq_num(net, 0);
-		net->iv_index = iv_index;
-
-		if (iv_update) {
+		if (ivu) {
 			/* Other devices will be accepting old or new iv_index,
 			 * but we don't know how far through update they are.
 			 * Starting permissive state will allow us maximum
@@ -2753,164 +2772,89 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 			l_info("iv_upd_state = IV_UPD_NORMAL");
 			net->iv_upd_state = IV_UPD_NORMAL;
 		}
-
-		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
-							net->iv_upd_state);
-
-		/* Figure out the key refresh phase */
-		if (kr_transition) {
-			l_debug("Beacon based KR phase change");
-			if (rxed_key_refresh)
-				key_refresh_phase_two(net, subnet->idx);
-			else
-				key_refresh_finish(net, subnet->idx);
+	} else if (ivu) {
+		/* Ignore beacons with IVU if they come too soon */
+		if (!local_ivu && net->iv_upd_state == IV_UPD_NORMAL_HOLD) {
+			l_error("Update attempted too soon");
+			return;
 		}
 
-		if (!lpn)
-			set_network_beacon(subnet, net);
-
-		return;
-	}
-
-	if (iv_update && !iv_is_updating(net)) {
-		l_info("iv_upd_state = IV_UPD_UPDATING");
-		net->iv_upd_state = IV_UPD_UPDATING;
-		net->iv_update_timeout = l_timeout_create(IV_IDX_UPD_MIN,
-							iv_upd_to, net, NULL);
-		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
-							net->iv_upd_state);
-	} else if (iv_update && iv_index != net->iv_index) {
-		l_error("Update attempted too soon (iv idx already updated)");
+		if (!local_ivu) {
+			l_info("iv_upd_state = IV_UPD_UPDATING");
+			net->iv_upd_state = IV_UPD_UPDATING;
+			net->iv_update_timeout = l_timeout_create(
+					IV_IDX_UPD_MIN, iv_upd_to, net, NULL);
+		}
+	} else if (local_ivu) {
+		l_error("IVU clear attempted too soon");
 		return;
 	}
 
-	if (iv_index != local_iv_index || kr_transition)
-		l_info("IVindex 0x%8.8x / Key Refresh update received",
-								iv_index);
+	if ((iv_index - ivu) > (local_iv_index - local_ivu))
+		mesh_net_set_seq_num(net, 0);
 
-	if (iv_index > net->iv_index) {
-		l_queue_clear(net->msg_cache, mesh_msg_free);
-		net->iv_index = iv_index;
-		mesh_config_write_iv_index(node_config_get(net->node), iv_index,
-							net->iv_upd_state);
-	}
+	if (ivu != net->iv_update || local_iv_index != net->iv_index) {
+		struct mesh_config *cfg = node_config_get(net->node);
 
-	/* Figure out the key refresh phase */
-	if (kr_transition) {
-		if (rxed_key_refresh)
-			key_refresh_phase_two(net, subnet->idx);
-		else
-			key_refresh_finish(net, subnet->idx);
+		mesh_config_write_iv_index(cfg, iv_index, ivu);
 	}
 
-	if (!lpn)
-		return;
-
-	if (local_kr != subnet->key_refresh ||
-					local_iv_index != net->iv_index ||
-					local_iv_update != iv_is_updating(net))
-		set_network_beacon(subnet, net);
+	net->iv_index = iv_index;
+	net->iv_update = ivu;
 }
 
-static void process_beacon(void *user_data, const void *data,
-						uint8_t size, int8_t rssi)
+static void process_beacon(void *net_ptr, void *user_data)
 {
-	struct mesh_net *net = user_data;
-	const uint8_t *buf = data;
-	uint32_t iv_index;
-	bool iv_update, rxed_iv_update, rxed_key_refresh;
+	struct mesh_net *net = net_ptr;
+	const uint8_t *buf = *(uint8_t **)user_data;
+	uint32_t ivi;
+	bool ivu, kr, local_kr;
 	struct mesh_subnet *subnet;
 	uint32_t key_id;
-	bool kr_transition = false;
-
-	if (size != 22 || buf[0] != 0x01)
-		return;
 
-	/* print_packet("Secure Net Beacon RXed", data, size); */
-	rxed_key_refresh = (buf[1] & 0x01) == 0x01;
-	rxed_iv_update = iv_update = (buf[1] & 0x02) == 0x02;
-	iv_index = l_get_be32(buf + 10);
+	ivi = l_get_be32(buf + 10);
 
-	l_debug("KR: %d -- IVU: %d -- IV: %8.8x",
-				rxed_key_refresh, rxed_iv_update, iv_index);
-
-	/* Inhibit recognizing iv_update true-->false
-	 * if we have outbound SAR messages in flight
-	 */
-	if (l_queue_length(net->sar_out)) {
-		if (!iv_update && iv_update != iv_is_updating(net))
-			iv_update = true;
-	}
-
-	key_id = net_key_network_id(buf + 2);
-	subnet = l_queue_find(net->subnets, match_key_id,
-						L_UINT_TO_PTR(key_id));
-	if (!subnet || !key_id)
+	/* Ignore out-of-range IV_Index for this network */
+	if ((net->iv_index + IV_IDX_DIFF_RANGE < ivi) || (ivi < net->iv_index))
 		return;
 
-	/* Check if Key Refresh flag value is different from
-	 * the locally stored one
-	 */
-	if (rxed_key_refresh != subnet->key_refresh)
-		kr_transition = true;
-
-	/* If the local node is a provisioner or there are no new keys,
-	 * ignore KR beacon setting
-	 */
-	if (net->provisioner)
-		kr_transition = false;
-	else if (!subnet->net_key_upd)
-		kr_transition = false;
-	/* If beacon's key refresh bit is not set and the beacon is encoded
-	 * with the "new" network key, this signals transition from
-	 * key refresh procedure to normal operation
-	 */
-	else if (!rxed_key_refresh && subnet->net_key_upd == key_id)
-		kr_transition = true;
-
-	if ((net->iv_index + IV_IDX_DIFF_RANGE < iv_index) ||
-						(iv_index < net->iv_index)) {
-		l_info("iv index outside range");
+	/* Ignore Network IDs unknown to this mesh universe */
+	key_id = net_key_network_id(buf + 2);
+	if (!key_id)
 		return;
-	}
 
-	/* Don't bother going further if nothing has changed */
-	if (!memcmp(&subnet->snb.beacon[1], buf, size)) {
-		subnet->snb.observed++;
-		return;
-	}
-
-	if (!rxed_key_refresh && !subnet->key_refresh && !kr_transition)
-		key_id = subnet->net_key_cur;
-	else if (subnet->net_key_upd)
-		key_id = subnet->net_key_upd;
-	else
+	subnet = l_queue_find(net->subnets, match_key_id,
+							L_UINT_TO_PTR(key_id));
+	if (!subnet)
 		return;
 
-	if (!net_key_snb_check(key_id, iv_index, rxed_key_refresh,
-						rxed_iv_update,
-						l_get_be64(buf + 14))) {
-		l_error("mesh_crypto_beacon verify failed");
-		return;
-	}
+	/* Get IVU and KR boolean bits from beacon */
+	ivu = !!(buf[1] & 0x02);
+	kr = !!(buf[1] & 0x01);
+	local_kr = !!(subnet->kr_phase != KEY_REFRESH_PHASE_TWO);
 
-	if (iv_index == net->iv_index &&
-			iv_is_updating(net) == iv_update && !kr_transition) {
-		l_info("No change: IV index %4.4x, rxed KR = %d ",
-						iv_index, rxed_key_refresh);
-		if (net->iv_upd_state == IV_UPD_INIT) {
-			l_info("iv_upd_state = IV_UPD_NORMAL");
-			net->iv_upd_state = IV_UPD_NORMAL;
+	if (net->iv_upd_state != IV_UPD_INIT) {
+		/* Ignore beacons that indicate *no change* */
+		if (!memcmp(&subnet->snb.beacon[1], buf, 22)) {
+			subnet->snb.observed++;
+			return;
 		}
+	}
 
-		subnet->snb.observed++;
+	/* Validate beacon before accepting */
+	if (!net_key_snb_check(key_id, ivi, kr, ivu, l_get_be64(buf + 14))) {
+		l_error("mesh_crypto_beacon verify failed");
 		return;
 	}
 
+	/* We have officially *seen* this beacon now */
 	subnet->snb.observed++;
 
-	update_iv_kr_state(subnet, iv_index, iv_update, kr_transition,
-						rxed_key_refresh, false);
+	update_iv_ivu_state(net, ivi, ivu);
+	update_kr_state(subnet, kr, key_id);
+
+	if (ivi != net->iv_index || ivu != net->iv_update || kr != local_kr)
+		set_network_beacon(subnet, net);
 }
 
 static void lpn_process_beacon(void *user_data, const void *data,
@@ -2918,87 +2862,50 @@ static void lpn_process_beacon(void *user_data, const void *data,
 {
 	struct mesh_net *net = user_data;
 	const uint8_t *buf = data;
-	uint32_t iv_index;
-	bool iv_update, rxed_key_refresh;
+	uint32_t ivi;
+	bool ivu, kr, local_kr;
 	struct mesh_subnet *subnet;
 	bool kr_transition = false;
 
 	/* print_packet("lpn: Secure Net Beacon RXed", data, size); */
-	rxed_key_refresh = (buf[0] & 0x01) == 0x01;
-	iv_update = (buf[0] & 0x02) == 0x02;
-	iv_index = l_get_be32(buf + 1);
+	kr = !!(buf[0] & 0x01);
+	ivu = !!(buf[0] & 0x02);
+	ivi = l_get_be32(buf + 1);
 
-	/* Inhibit recognizing iv_update true-->false if we have outbound
-	 * SAR messages in flight
-	 */
-	if (l_queue_length(net->sar_out)) {
-		if (!iv_update && iv_update != iv_is_updating(net))
-			iv_update = true;
-	}
-
-	l_debug("KR: %d -- IVU: %d -- IV: %8.8x",
-				rxed_key_refresh, iv_update, iv_index);
+	l_debug("KR: %d -- IVU: %d -- IVI: %8.8x", kr, ivu, ivi);
 
 	/* TODO: figure out actual network index (i.e., friendship subnet) */
 	subnet = get_primary_subnet(net);
 	if (!subnet)
 		return;
 
-	/* Check if Key Refresh flag value is different from
-	 * the locally stored one
-	 */
-	if (rxed_key_refresh != subnet->key_refresh)
-		kr_transition = true;
-
-	/* If the local node is a provisioner or there are no new keys,
-	 * ignore KR beacon setting
-	 */
-	if (!subnet->net_key_upd)
-		kr_transition = false;
-
-	if ((net->iv_index + IV_IDX_DIFF_RANGE < iv_index) ||
-					(iv_index < net->iv_index)) {
-		l_info("iv index outside range");
-		return;
-	}
+	local_kr = (subnet->kr_phase == KEY_REFRESH_PHASE_TWO);
 
 	/* Don't bother going further if nothing has changed */
-	if (!kr_transition && iv_index == net->iv_index &&
-			iv_update == iv_is_updating(net) &&
-			net->iv_upd_state != IV_UPD_INIT)
+	if (local_kr == kr && ivi == net->iv_index && ivu == net->iv_update &&
+					net->iv_upd_state != IV_UPD_INIT)
 		return;
 
-	if (iv_index == net->iv_index &&
-			iv_is_updating(net) == iv_update && !kr_transition) {
-		l_info("No change: IV index %4.4x, rxed KR = %d ",
-						iv_index, rxed_key_refresh);
-		if (net->iv_upd_state == IV_UPD_INIT) {
-			l_info("iv_upd_state = IV_UPD_NORMAL");
-			net->iv_upd_state = IV_UPD_NORMAL;
-		}
-		return;
-	}
+	update_iv_ivu_state(net, ivi, ivu);
 
-	update_iv_kr_state(subnet, iv_index, iv_update, kr_transition,
-						rxed_key_refresh, true);
+	if (kr)
+		update_kr_state(subnet, kr_transition, subnet->net_key_upd);
+	else
+		update_kr_state(subnet, kr_transition, subnet->net_key_cur);
 }
 
 static void beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len)
 {
-	struct mesh_net *net = user_data;
-	int8_t rssi = 0;
+	const uint8_t *ptr = data + 1;
 
-	if (len <= 2 || !net)
+	if (len != 23 || data[1] != 0x01)
 		return;
 
-	if (info) {
-		net->instant = info->instant;
-		net->chan = info->chan;
-		rssi = info->rssi;
-	}
+	l_debug("KR: %d -- IVU: %d -- IV: %8.8x",
+			data[2] & 1, !!(data[2] & 2), l_get_be32(data + 11));
 
-	process_beacon(user_data, data + 1, len - 1, rssi);
+	l_queue_foreach(nets, process_beacon, &ptr);
 }
 
 bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable)
@@ -3044,8 +2951,10 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 	if (!subnet)
 		return false;
 
-	if (new_key)
+	if (new_key && phase) {
 		subnet->net_key_upd = net_key_add(new_key);
+		l_debug("New Key Added - %d", subnet->net_key_upd);
+	}
 
 	/* Preserve key refresh state to generate secure beacon flags*/
 	if (phase == KEY_REFRESH_PHASE_TWO) {
@@ -3085,7 +2994,7 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 
 		l_info("Register io cb");
 		mesh_io_register_recv_cb(io, MESH_IO_FILTER_BEACON,
-							beacon_recv, net);
+							beacon_recv, NULL);
 		mesh_io_register_recv_cb(io, MESH_IO_FILTER_NET,
 							net_msg_recv, NULL);
 		l_queue_foreach(net->subnets, start_network_beacon, net);
@@ -3128,12 +3037,13 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 
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
@@ -3731,6 +3641,7 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 
 	/* Preserve starting data */
 	subnet->net_key_upd = net_key_add(value);
+	l_debug("New Key Added(2) - %d", subnet->net_key_upd);
 
 	if (!subnet->net_key_upd) {
 		l_error("Failed to start key refresh phase one");
-- 
2.21.0

