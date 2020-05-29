Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C19AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790F9208A7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgE2Gh6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 02:37:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:53722 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgE2Gh5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 02:37:57 -0400
IronPort-SDR: WAIRAXKPcjZUufy+KCV2yXHcysBYskKrRAD2x+HjgKyk1MXE2q1hRxqw7eleiONjyYQgMxxomB
 q5iYM2voM/ZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 23:37:56 -0700
IronPort-SDR: k6RoykzRkzgHTBNAPW3s1OX8PvD7NizUq6XNgQEuC+lP5x4z4smeekO1i6wR76z9XJ2XW9U1Vf
 qgSZLg2q40WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="257260609"
Received: from dmikkels-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.187])
  by fmsmga008.fm.intel.com with ESMTP; 28 May 2020 23:37:56 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 5/5] mesh: Remove unused functions from net.c
Date:   Thu, 28 May 2020 23:37:50 -0700
Message-Id: <20200529063750.186278-6-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063750.186278-1-inga.stotland@intel.com>
References: <20200529063750.186278-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The folllowing functionsa are not being used anywhere in the code and
have been removed:
mesh_net_flush()
mesh_net_prov_caps_get()
mesh_net_priv_key_get()
mesh_net_priv_key_set()
mesh_net_prov_rand()
mesh_net_prov_uni()
mesh_net_id_uuid_set()
mesh_net_test_addr()
mesh_net_test_mode()
mesh_net_uni_range_set()
mesh_net_uni_range_get()
mesh_net_set_window_accuracy()
---
 mesh/net.c | 149 ++---------------------------------------------------
 mesh/net.h |  21 --------
 2 files changed, 4 insertions(+), 166 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index af891e5a9..07813eec4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -124,7 +124,6 @@ struct mesh_net {
 	uint8_t chan; /* Channel of recent Rx */
 	uint8_t default_ttl;
 	uint8_t tid;
-	uint8_t window_accuracy;
 
 	struct {
 		bool enable;
@@ -144,21 +143,6 @@ struct mesh_net {
 	struct l_queue *friends;
 	struct l_queue *negotiations;
 	struct l_queue *destinations;
-
-	uint8_t prov_priv_key[32];
-
-	/* Unprovisioned Identity */
-	char id_name[20];
-	uint8_t id_uuid[16];
-
-	/* Provisioner: unicast address range */
-	struct mesh_net_addr_range prov_uni_addr;
-
-	/* Test Data */
-	uint8_t prov_rand[16];
-	uint8_t test_bd_addr[6];
-	struct mesh_net_prov_caps prov_caps;
-	bool test_mode;
 };
 
 struct mesh_msg {
@@ -648,9 +632,6 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	net->seq_num = DEFAULT_SEQUENCE_NUMBER;
 	net->default_ttl = TTL_MASK;
 
-	memset(&net->prov_caps, 0, sizeof(net->prov_caps));
-	net->prov_caps.algorithms = 1;
-
 	net->tx_cnt = DEFAULT_TRANSMIT_COUNT;
 	net->tx_interval = DEFAULT_TRANSMIT_INTERVAL;
 
@@ -829,93 +810,6 @@ bool mesh_net_set_relay_mode(struct mesh_net *net, bool enable,
 	return true;
 }
 
-struct mesh_net_prov_caps *mesh_net_prov_caps_get(struct mesh_net *net)
-{
-	if (net)
-		return &net->prov_caps;
-
-	return NULL;
-}
-
-char *mesh_net_id_name(struct mesh_net *net)
-{
-	if (net && net->id_name[0])
-		return net->id_name;
-
-	return NULL;
-}
-
-bool mesh_net_id_uuid_set(struct mesh_net *net, uint8_t uuid[16])
-{
-	if (!net)
-		return false;
-
-	memcpy(net->id_uuid, uuid, 16);
-
-	return true;
-}
-
-uint8_t *mesh_net_priv_key_get(struct mesh_net *net)
-{
-	if (net)
-		return net->prov_priv_key;
-
-	return NULL;
-}
-
-bool mesh_net_priv_key_set(struct mesh_net *net, uint8_t key[32])
-{
-	if (!net)
-		return false;
-
-	memcpy(net->prov_priv_key, key, 32);
-	return true;
-}
-
-uint8_t *mesh_net_test_addr(struct mesh_net *net)
-{
-	const uint8_t zero_addr[] = {0, 0, 0, 0, 0, 0};
-
-	if (net && memcmp(net->test_bd_addr, zero_addr, 6))
-		return net->test_bd_addr;
-
-	return NULL;
-}
-
-uint8_t *mesh_net_prov_rand(struct mesh_net *net)
-{
-	if (net)
-		return net->prov_rand;
-
-	return NULL;
-}
-
-uint16_t mesh_net_prov_uni(struct mesh_net *net, uint8_t ele_cnt)
-{
-	uint16_t uni;
-	uint16_t next;
-
-	if (!net)
-		return 0;
-
-	next = net->prov_uni_addr.next + ele_cnt;
-	if (next > 0x8000 || next > net->prov_uni_addr.high)
-		return UNASSIGNED_ADDRESS;
-
-	uni = net->prov_uni_addr.next;
-	net->prov_uni_addr.next = next;
-
-	return uni;
-}
-
-bool mesh_net_test_mode(struct mesh_net *net)
-{
-	if (net)
-		return net->test_mode;
-
-	return false;
-}
-
 int mesh_net_get_identity_mode(struct mesh_net *net, uint16_t idx,
 								uint8_t *mode)
 {
@@ -1026,11 +920,6 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 	return MESH_STATUS_SUCCESS;
 }
 
-void mesh_net_flush_msg_queues(struct mesh_net *net)
-{
-	l_queue_clear(net->msg_cache, l_free);
-}
-
 uint32_t mesh_net_get_iv_index(struct mesh_net *net)
 {
 	if (!net)
@@ -2543,7 +2432,7 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 							net->iv_index, false);
 		l_queue_foreach(net->subnets, refresh_beacon, net);
 		queue_friend_update(net);
-		mesh_net_flush_msg_queues(net);
+		l_queue_clear(net->msg_cache, l_free);
 		break;
 
 	case IV_UPD_INIT:
@@ -2937,7 +2826,7 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 		return false;
 
 	l_debug("iv_upd_state = IV_UPD_UPDATING");
-	mesh_net_flush_msg_queues(net);
+	l_queue_clear(net->msg_cache, l_free);
 
 	if (!mesh_config_write_iv_index(node_config_get(net->node),
 						net->iv_index + 1, true))
@@ -2999,15 +2888,6 @@ bool mesh_net_dst_unreg(struct mesh_net *net, uint16_t dst)
 	return true;
 }
 
-bool mesh_net_flush(struct mesh_net *net)
-{
-	if (!net)
-		return false;
-
-	/* TODO mesh-io Flush */
-	return true;
-}
-
 static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 {
 	struct mesh_subnet *subnet;
@@ -3430,7 +3310,7 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 	return MESH_STATUS_SUCCESS;
 }
 
-uint16_t mesh_net_get_features(struct mesh_net *net)
+static uint16_t get_features(struct mesh_net *net)
 {
 	uint16_t features = 0;
 
@@ -3473,20 +3353,7 @@ void mesh_net_heartbeat_init(struct mesh_net *net)
 
 	memset(hb, 0, sizeof(struct mesh_net_heartbeat));
 	hb->sub_min_hops = 0xff;
-	hb->features = mesh_net_get_features(net);
-}
-
-void mesh_net_uni_range_set(struct mesh_net *net,
-				struct mesh_net_addr_range *range)
-{
-	net->prov_uni_addr.low = range->low;
-	net->prov_uni_addr.high = range->high;
-	net->prov_uni_addr.next = range->next;
-}
-
-struct mesh_net_addr_range mesh_net_uni_range_get(struct mesh_net *net)
-{
-	return net->prov_uni_addr;
+	hb->features = get_features(net);
 }
 
 void mesh_net_set_iv_index(struct mesh_net *net, uint32_t index, bool update)
@@ -3582,14 +3449,6 @@ bool mesh_net_is_local_address(struct mesh_net *net, uint16_t src,
 			(last >= net->src_addr && last <= net->last_addr);
 }
 
-void mesh_net_set_window_accuracy(struct mesh_net *net, uint8_t accuracy)
-{
-	if (!net)
-		return;
-
-	net->window_accuracy = accuracy;
-}
-
 void mesh_net_transmit_params_set(struct mesh_net *net, uint8_t count,
 							uint16_t interval)
 {
diff --git a/mesh/net.h b/mesh/net.h
index 12808ce38..84e7c1545 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -120,12 +120,6 @@ struct mesh_node;
 #define DEFAULT_MIN_DELAY		0
 #define DEFAULT_MAX_DELAY		25
 
-struct mesh_net_addr_range {
-	uint16_t low;
-	uint16_t high;
-	uint16_t next;
-};
-
 struct mesh_net_prov_caps {
 	uint8_t num_ele;
 	uint16_t algorithms;
@@ -264,7 +258,6 @@ typedef void (*mesh_status_func_t)(void *user_data, bool result);
 struct mesh_net *mesh_net_new(struct mesh_node *node);
 void mesh_net_free(void *net);
 void mesh_net_cleanup(void);
-void mesh_net_flush_msg_queues(struct mesh_net *net);
 void mesh_net_set_iv_index(struct mesh_net *net, uint32_t index, bool update);
 bool mesh_net_iv_index_update(struct mesh_net *net);
 bool mesh_net_set_seq_num(struct mesh_net *net, uint32_t number);
@@ -300,7 +293,6 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io);
 struct mesh_io *mesh_net_detach(struct mesh_net *net);
 struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
 
-bool mesh_net_flush(struct mesh_net *net);
 void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 				uint16_t net_idx, uint32_t iv_index,
 				uint8_t ttl, uint32_t seq, uint16_t src,
@@ -316,17 +308,9 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, bool rly,
 				uint16_t seqZero, uint32_t ack_flags);
-struct mesh_net_prov_caps *mesh_net_prov_caps_get(struct mesh_net *net);
-uint8_t *mesh_net_priv_key_get(struct mesh_net *net);
-bool mesh_net_priv_key_set(struct mesh_net *net, uint8_t key[32]);
-uint8_t *mesh_net_prov_rand(struct mesh_net *net);
-uint16_t mesh_net_prov_uni(struct mesh_net *net, uint8_t ele_cnt);
-bool mesh_net_id_uuid_set(struct mesh_net *net, uint8_t uuid[16]);
-uint8_t *mesh_net_test_addr(struct mesh_net *net);
 int mesh_net_get_identity_mode(struct mesh_net *net, uint16_t idx,
 								uint8_t *mode);
 char *mesh_net_id_name(struct mesh_net *net);
-bool mesh_net_test_mode(struct mesh_net *net);
 bool mesh_net_dst_reg(struct mesh_net *net, uint16_t dst);
 bool mesh_net_dst_unreg(struct mesh_net *net, uint16_t dst);
 struct mesh_friend *mesh_friend_new(struct mesh_net *net, uint16_t dst,
@@ -348,13 +332,9 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, uint32_t hdr,
 				const void *seg, uint16_t seg_len);
-uint16_t mesh_net_get_features(struct mesh_net *net);
 struct mesh_net_heartbeat *mesh_net_heartbeat_get(struct mesh_net *net);
 void mesh_net_heartbeat_init(struct mesh_net *net);
 void mesh_net_heartbeat_send(struct mesh_net *net);
-void mesh_net_uni_range_set(struct mesh_net *net,
-				struct mesh_net_addr_range *range);
-struct mesh_net_addr_range mesh_net_uni_range_get(struct mesh_net *net);
 void mesh_net_provisioner_mode_set(struct mesh_net *net, bool mode);
 bool mesh_net_provisioner_mode_get(struct mesh_net *net);
 bool mesh_net_key_list_get(struct mesh_net *net, uint8_t *buf, uint16_t *count);
@@ -365,7 +345,6 @@ struct mesh_node *mesh_net_node_get(struct mesh_net *net);
 bool mesh_net_have_key(struct mesh_net *net, uint16_t net_idx);
 bool mesh_net_is_local_address(struct mesh_net *net, uint16_t src,
 							uint16_t count);
-void mesh_net_set_window_accuracy(struct mesh_net *net, uint8_t accuracy);
 void mesh_net_transmit_params_set(struct mesh_net *net, uint8_t count,
 							uint16_t interval);
 void mesh_net_transmit_params_get(struct mesh_net *net, uint8_t *count,
-- 
2.26.2

