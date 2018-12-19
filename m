Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E15C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893EC21871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeLSEU4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:20:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:4125 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbeLSEU4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:20:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:20:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820122"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:20:55 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 07/30] mesh: Rewrite Network layer for multiple nodes
Date:   Tue, 18 Dec 2018 20:19:53 -0800
Message-Id: <20181219042016.25538-8-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/net.c | 293 ++++++++++++++++---------------------------------------------
 mesh/net.h |  31 ++-----
 2 files changed, 83 insertions(+), 241 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 97b6f5b16..b47df7c04 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -30,7 +30,6 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 
-#include "mesh/display.h"
 #include "mesh/crypto.h"
 #include "mesh/net_keys.h"
 #include "mesh/mesh.h"
@@ -112,12 +111,9 @@ struct mesh_subnet {
 };
 
 struct mesh_net {
-	int ref_count;
 	struct mesh_io *io;
-	struct mesh_node *local_node;
+	struct mesh_node *node;
 	struct mesh_prov *prov;
-	void *jconfig_local;
-	const char *cfg_file;
 	struct l_queue *app_keys;
 	unsigned int pkt_id;
 	unsigned int bea_id;
@@ -129,7 +125,6 @@ struct mesh_net {
 	bool beacon_enable;
 	bool proxy_enable;
 	bool provisioner;
-	bool provisioned;
 	bool friend_seq;
 	struct l_timeout *iv_update_timeout;
 	enum _iv_upd_state iv_upd_state;
@@ -139,7 +134,6 @@ struct mesh_net {
 	uint32_t iv_index;
 	uint32_t seq_num;
 	uint32_t cached_seq_num;
-	uint16_t crpl;
 	uint16_t src_addr;
 	uint16_t last_addr;
 	uint16_t friend_addr;
@@ -253,6 +247,8 @@ struct net_decode {
 	bool proxy;
 };
 
+static struct l_queue *nets;
+
 static inline struct mesh_subnet *get_primary_subnet(struct mesh_net *net)
 {
 	return l_queue_peek_head(net->subnets);
@@ -499,8 +495,8 @@ uint32_t mesh_net_next_seq_num(struct mesh_net *net)
 	/* Periodically store advanced sequence number */
 	if (net->seq_num + MIN_SEQ_TRIGGER >= net->cached_seq_num) {
 		net->cached_seq_num = net->seq_num +
-					node_seq_cache(net->local_node);
-		node_set_sequence_number(net->local_node, net->cached_seq_num);
+					node_seq_cache(net->node);
+		node_set_sequence_number(net->node, net->cached_seq_num);
 	}
 
 	return seq;
@@ -647,15 +643,13 @@ static void start_network_beacon(void *a, void *b)
 				network_beacon_timeout, subnet, NULL);
 }
 
-struct mesh_net *mesh_net_new(uint16_t index)
+struct mesh_net *mesh_net_new(struct mesh_node *node)
 {
 	struct mesh_net *net;
 
 	net = l_new(struct mesh_net, 1);
 
-	if (!net)
-		return NULL;
-
+	net->node = node;
 	net->pkt_id = 0;
 	net->bea_id = 0;
 	net->key_id_next = 0;
@@ -689,27 +683,17 @@ struct mesh_net *mesh_net_new(uint16_t index)
 
 	memset(&net->heartbeat, 0, sizeof(net->heartbeat));
 
-	return mesh_net_ref(net);
-}
-
-struct mesh_net *mesh_net_ref(struct mesh_net *net)
-{
-	if (!net)
-		return NULL;
-
-	__sync_fetch_and_add(&net->ref_count, 1);
+	if (!nets)
+		nets = l_queue_new();
 
 	return net;
 }
 
-void mesh_net_unref(struct mesh_net *net)
+void mesh_net_free(struct mesh_net *net)
 {
 	if (!net)
 		return;
 
-	if (__sync_sub_and_fetch(&net->ref_count, 1))
-		return;
-
 	l_queue_destroy(net->subnets, subnet_free);
 	l_queue_destroy(net->fast_cache, mesh_msg_free);
 	l_queue_destroy(net->msg_cache, mesh_msg_free);
@@ -773,7 +757,6 @@ bool mesh_net_register_unicast(struct mesh_net *net,
 	if (!net || !IS_UNICAST(address) || !num_ele)
 		return false;
 
-	l_info("mesh_net_set_address: 0x%x", address);
 	net->src_addr = address;
 	net->last_addr = address + num_ele - 1;
 	if (net->last_addr < net->src_addr)
@@ -971,7 +954,7 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	l_queue_remove(net->subnets, subnet);
 	subnet_free(subnet);
 
-	if (!storage_local_net_key_del(net, idx))
+	if (!storage_net_key_del(net, idx))
 		return MESH_STATUS_STORAGE_FAIL;
 
 	return MESH_STATUS_SUCCESS;
@@ -991,7 +974,7 @@ int mesh_net_add_key(struct mesh_net *net, bool update, uint16_t idx,
 			l_info("Start key refresh");
 			status = mesh_net_kr_phase_one(net, idx, value);
 			if (status == MESH_STATUS_SUCCESS &&
-				!storage_local_net_key_add(net, idx,
+				!storage_net_key_add(net, idx,
 						value, KEY_REFRESH_PHASE_ONE))
 				return MESH_STATUS_STORAGE_FAIL;
 		} else
@@ -1021,7 +1004,7 @@ int mesh_net_add_key(struct mesh_net *net, bool update, uint16_t idx,
 		return MESH_STATUS_INSUFF_RESOURCES;
 	}
 
-	if (!storage_local_net_key_add(net, idx, value,
+	if (!storage_net_key_add(net, idx, value,
 					KEY_REFRESH_PHASE_NONE)) {
 		l_queue_remove(net->subnets, subnet);
 		subnet_free(subnet);
@@ -1204,14 +1187,6 @@ static bool match_msg_timeout(const void *a, const void *b)
 	return sar->msg_timeout == msg_timeout;
 }
 
-static bool match_sar_id(const void *a, const void *b)
-{
-	const struct mesh_sar *sar = a;
-	unsigned int id = L_PTR_TO_UINT(b);
-
-	return sar->id == id;
-}
-
 static bool match_seg_timeout(const void *a, const void *b)
 {
 	const struct mesh_sar *sar = a;
@@ -1813,7 +1788,7 @@ static bool msg_rxed(struct mesh_net *net, bool frnd,
 	}
 
 not_for_friend:
-	return mesh_model_rx(net, szmic, seqAuth, seq, iv_index,
+	return mesh_model_rx(net->node, szmic, seqAuth, seq, iv_index,
 					ttl, src, dst, key_id, data, size);
 }
 
@@ -2511,22 +2486,40 @@ static void packet_received(void *user_data, const void *data, uint8_t size,
 		send_relay_pkt(net, packet, size + 1);
 }
 
+struct net_queue_data {
+	struct mesh_io_recv_info *info;
+	const uint8_t *data;
+	uint16_t len;
+};
+
+static void net_rx(void *net_ptr, void *user_data)
+{
+	struct net_queue_data *data = user_data;
+	struct mesh_net *net = net_ptr;
+	int8_t rssi = 0;
+
+	if (data->info) {
+		net->instant = data->info->instant;
+		net->chan = data->info->chan;
+		rssi = data->info->rssi;
+	}
+
+	packet_received(net, data->data, data->len, rssi);
+}
+
 static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len)
 {
-	struct mesh_net *net = user_data;
-	int8_t rssi = 0;
+	struct net_queue_data net_data = {
+		.info = info,
+		.data = data + 1,
+		.len = len - 1,
+	};
 
-	if (len <= 2 || !net)
+	if (len <= 2)
 		return;
 
-	if (info) {
-		net->instant = info->instant;
-		net->chan = info->chan;
-		rssi = info->rssi;
-	}
-
-	packet_received(user_data, data + 1, len - 1, rssi);
+	l_queue_foreach(nets, net_rx, &net_data);
 }
 
 static void set_network_beacon(void *a, void *b)
@@ -2653,7 +2646,7 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 			net->iv_upd_state = IV_UPD_NORMAL;
 		}
 
-		storage_local_set_iv_index(net, iv_index, net->iv_upd_state);
+		storage_set_iv_index(net, iv_index, net->iv_upd_state);
 
 		/* Figure out the key refresh phase */
 		if (kr_transition) {
@@ -2675,7 +2668,7 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 		net->iv_upd_state = IV_UPD_UPDATING;
 		net->iv_update_timeout = l_timeout_create(IV_IDX_UPD_MIN,
 							iv_upd_to, net, NULL);
-		storage_local_set_iv_index(net, iv_index, net->iv_upd_state);
+		storage_set_iv_index(net, iv_index, net->iv_upd_state);
 	} else if (iv_update && iv_index != net->iv_index) {
 		l_error("Update attempted too soon (iv idx already updated)");
 		return;
@@ -2688,7 +2681,7 @@ static void update_iv_kr_state(struct mesh_subnet *subnet, uint32_t iv_index,
 	if (iv_index > net->iv_index) {
 		l_queue_clear(net->msg_cache, mesh_msg_free);
 		net->iv_index = iv_index;
-		storage_local_set_iv_index(net, iv_index, net->iv_upd_state);
+		storage_set_iv_index(net, iv_index, net->iv_upd_state);
 	}
 
 	/* Figure out the key refresh phase */
@@ -2915,34 +2908,37 @@ bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable)
 	return true;
 }
 
+static bool is_this_net(const void *a, const void *b)
+{
+	return a == b;
+}
+
 bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 {
+	bool first;
+
 	if (!net)
 		return false;
 
-	net->io = io;
-	if (net->provisioned) {
+	first = l_queue_isempty(nets);
+	if (first) {
+		if (!nets)
+			nets = l_queue_new();
 
+		l_info("Register io cb");
 		mesh_io_register_recv_cb(io, MESH_IO_FILTER_BEACON,
 							beacon_recv, net);
 		mesh_io_register_recv_cb(io, MESH_IO_FILTER_NET,
-							net_msg_recv, net);
+							net_msg_recv, NULL);
 		l_queue_foreach(net->subnets, start_network_beacon, net);
+	}
 
-	} else {
-		uint8_t *uuid = node_uuid_get(net->local_node);
-
-		if (!uuid)
-			return false;
+	if (l_queue_find(nets, is_this_net, net))
+		return false;
 
-		mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_BEACON);
-		mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_NET);
+	l_queue_push_head(nets, net);
 
-		mesh_prov_listen(net, uuid, (uint8_t *) &net->prov_caps,
-					acceptor_prov_open,
-					acceptor_prov_close,
-					acceptor_prov_receive, net);
-	}
+	net->io = io;
 
 	return true;
 }
@@ -2952,10 +2948,10 @@ struct mesh_io *mesh_net_detach(struct mesh_net *net)
 	struct mesh_io *io;
 	uint8_t type = 0;
 
-	if (!net)
+	if (!net || !net->io)
 		return NULL;
 
-	io  = net->io;
+	io = net->io;
 
 	mesh_io_send_cancel(net->io, &type, 1);
 	mesh_io_deregister_recv_cb(io, MESH_IO_FILTER_BEACON);
@@ -2975,7 +2971,7 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 	mesh_net_flush_msg_queues(net);
 	net->iv_upd_state = IV_UPD_UPDATING;
 	net->iv_index++;
-	if (!storage_local_set_iv_index(net, net->iv_index, IV_UPD_UPDATING))
+	if (!storage_set_iv_index(net, net->iv_index, IV_UPD_UPDATING))
 		return false;
 
 	l_queue_foreach(net->subnets, set_network_beacon, net);
@@ -3241,28 +3237,25 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 	l_free(str);
 }
 
-unsigned int mesh_net_app_send(struct mesh_net *net, bool frnd_cred,
-				uint16_t src, uint16_t dst,
-				uint8_t key_id, uint8_t ttl,
-				uint32_t seq, uint32_t iv_index,
-				bool szmic,
+bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
+				uint16_t dst, uint8_t key_id, uint8_t ttl,
+				uint32_t seq, uint32_t iv_index, bool szmic,
 				const void *msg, uint16_t msg_len,
 				mesh_net_status_func_t status_func,
 				void *user_data)
 {
 	struct mesh_sar *payload = NULL;
 	uint8_t seg, seg_max;
-	unsigned int ret = 0;
 	bool result;
 
 	if (!net || msg_len > 384)
-		return 0;
+		return false;
 
 	if (!src)
 		src = net->src_addr;
 
 	if (!src || !dst)
-		return 0;
+		return false;
 
 	if (ttl == 0xff)
 		ttl = net->default_ttl;
@@ -3287,7 +3280,7 @@ unsigned int mesh_net_app_send(struct mesh_net *net, bool frnd_cred,
 		/* Adjust our seq_num for "virtual" delivery */
 		net->seq_num += seg_max;
 		mesh_net_next_seq_num(net);
-		return 0;
+		return true;
 	}
 
 	/* If Segmented, Cancel any OB segmented message to same DST */
@@ -3337,29 +3330,13 @@ unsigned int mesh_net_app_send(struct mesh_net *net, bool frnd_cred,
 			l_timeout_create(MSG_TO, outmsg_to, net, NULL);
 		payload->status_func = status_func;
 		payload->user_data = user_data;
-		ret = payload->id = ++net->sar_id_next;
+		payload->id = ++net->sar_id_next;
 	} else
 		mesh_sar_free(payload);
 
-	return ret;
-}
-
-void mesh_net_app_send_cancel(struct mesh_net *net, unsigned int id)
-{
-	struct mesh_sar *sar = l_queue_remove_if(net->sar_out, match_sar_id,
-						L_UINT_TO_PTR(id));
-
-	if (sar) {
-		l_info("Canceling OB %d", id);
-		if (sar->status_func)
-			sar->status_func(sar->remote, 2,
-				sar->buf, sar->len - 4,
-				sar->user_data);
-	}
-	mesh_sar_free(sar);
+	return result;
 }
 
-/* TODO: add net key index */
 void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index,
 				uint8_t ttl,
@@ -3768,40 +3745,9 @@ uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr)
 		return frnd->poll_timeout;
 }
 
-bool mesh_net_local_node_set(struct mesh_net *net, struct mesh_node *node,
-							bool provisioner)
+struct mesh_node *mesh_net_node_get(struct mesh_net *net)
 {
-	if (net->local_node) {
-		l_info("Local node already registered");
-		return false;
-	}
-
-	net->local_node = node;
-	net->provisioner = provisioner;
-
-	return true;
-}
-
-struct mesh_node *mesh_net_local_node_get(struct mesh_net *net)
-{
-	return  net->local_node;
-}
-
-bool mesh_net_set_crpl(struct mesh_net *net, uint16_t crpl)
-{
-	if (!net)
-		return false;
-
-	net->crpl = crpl;
-	return true;
-}
-
-uint16_t mesh_net_get_crpl(struct mesh_net *net)
-{
-	if (!net)
-		return 0;
-
-	return net->crpl;
+	return  net->node;
 }
 
 struct l_queue *mesh_net_get_app_keys(struct mesh_net *net)
@@ -3824,41 +3770,6 @@ bool mesh_net_have_key(struct mesh_net *net, uint16_t idx)
 						L_UINT_TO_PTR(idx)) != NULL);
 }
 
-bool mesh_net_jconfig_set(struct mesh_net *net, void *jconfig)
-{
-	if (!net)
-		return false;
-
-	net->jconfig_local = jconfig;
-	return true;
-}
-
-void *mesh_net_jconfig_get(struct mesh_net *net)
-{
-	if (!net)
-		return NULL;
-
-	return  net->jconfig_local;
-}
-
-bool mesh_net_cfg_file_set(struct mesh_net *net, const char *cfg)
-{
-	if (!net)
-		return false;
-
-	net->cfg_file = cfg;
-	return true;
-}
-
-bool mesh_net_cfg_file_get(struct mesh_net *net, const char **cfg)
-{
-	if (!net)
-		return false;
-
-	*cfg = net->cfg_file;
-	return true;
-}
-
 bool mesh_net_is_local_address(struct mesh_net *net, uint16_t addr)
 {
 	if (!net)
@@ -3919,55 +3830,3 @@ void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov)
 	net->prov = prov;
 }
 
-bool mesh_net_provisioned_new(struct mesh_net *net, uint8_t device_key[16],
-				uint16_t net_idx,  uint8_t net_key[16],
-				uint16_t unicast, uint16_t snb_flags,
-				uint32_t iv_index, mesh_status_func_t cb,
-				void *user_data)
-{
-	if (net->provisioned || !net->local_node)
-		return false;
-
-	if (!node_set_primary(net->local_node, unicast) ||
-				!(mesh_net_register_unicast(net, unicast,
-						mesh_net_get_num_ele(net))))
-		return false;
-
-	if (!node_set_device_key(net->local_node, device_key))
-		return false;
-
-	net->iv_index = iv_index;
-	net->iv_update = ((snb_flags & 0x02) != 0);
-	if (!storage_local_set_iv_index(net, iv_index, net->iv_update))
-		return false;
-
-	if (mesh_net_add_key(net, false, net_idx, net_key) !=
-							MESH_STATUS_SUCCESS)
-		return false;
-
-	if ((snb_flags & 0x01) &&
-			(mesh_net_add_key(net, true, net_idx, net_key) !=
-							MESH_STATUS_SUCCESS)) {
-		l_queue_clear(net->subnets, l_free);
-		return false;
-	}
-
-	return storage_save_new_config(net, net->cfg_file, cb, user_data);
-
-}
-
-void mesh_net_provisioned_set(struct mesh_net *net, bool provisioned)
-{
-	if (!net)
-		return;
-
-	net->provisioned = provisioned;
-}
-
-bool mesh_net_provisioned_get(struct mesh_net *net)
-{
-	if (!net)
-		return false;
-
-	return net->provisioned;
-}
diff --git a/mesh/net.h b/mesh/net.h
index b8eb0699d..c63ea59ee 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -259,9 +259,8 @@ typedef void (*mesh_net_status_func_t)(uint16_t remote, uint8_t status,
 					void *data, uint16_t size,
 					void *user_data);
 
-struct mesh_net *mesh_net_new(uint16_t index);
-struct mesh_net *mesh_net_ref(struct mesh_net *net);
-void mesh_net_unref(struct mesh_net *net);
+struct mesh_net *mesh_net_new(struct mesh_node *node);
+void mesh_net_free(struct mesh_net *net);
 void mesh_net_flush_msg_queues(struct mesh_net *net);
 void mesh_net_set_iv_index(struct mesh_net *net, uint32_t index, bool update);
 bool mesh_net_iv_index_update(struct mesh_net *net);
@@ -301,13 +300,12 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 				uint32_t seq, uint16_t src, uint16_t dst,
 				const uint8_t *msg, uint16_t msg_len);
 
-unsigned int mesh_net_app_send(struct mesh_net *net, bool frnd_cred,
-				uint16_t src, uint16_t dst, uint8_t key_id,
-				uint8_t ttl, uint32_t seq, uint32_t iv_index,
-				bool szmic, const void *msg, uint16_t msg_len,
+bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
+				uint16_t dst, uint8_t key_id, uint8_t ttl,
+				uint32_t seq, uint32_t iv_index, bool szmic,
+				const void *msg, uint16_t msg_len,
 				mesh_net_status_func_t status_func,
 				void *user_data);
-void mesh_net_app_send_cancel(struct mesh_net *net, unsigned int id);
 void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, bool rly,
@@ -363,16 +361,8 @@ void mesh_net_sub_list_add(struct mesh_net *net, uint16_t addr);
 void mesh_net_sub_list_del(struct mesh_net *net, uint16_t addr);
 uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr);
 struct mesh_io *mesh_net_get_io(struct mesh_net *net);
-bool mesh_net_local_node_set(struct mesh_net *net, struct mesh_node *node,
-							bool provisioner);
-struct mesh_node *mesh_net_local_node_get(struct mesh_net *net);
-bool mesh_net_set_crpl(struct mesh_net *net, uint16_t crpl);
-uint16_t mesh_net_get_crpl(struct mesh_net *net);
+struct mesh_node *mesh_net_node_get(struct mesh_net *net);
 bool mesh_net_have_key(struct mesh_net *net, uint16_t net_idx);
-bool mesh_net_jconfig_set(struct mesh_net *net, void *jconfig);
-void *mesh_net_jconfig_get(struct mesh_net *net);
-bool mesh_net_cfg_file_set(struct mesh_net *net, const char *cfg);
-bool mesh_net_cfg_file_get(struct mesh_net *net, const char **cfg);
 bool mesh_net_is_local_address(struct mesh_net *net, uint16_t addr);
 void mesh_net_set_window_accuracy(struct mesh_net *net, uint8_t accuracy);
 void mesh_net_transmit_params_set(struct mesh_net *net, uint8_t count,
@@ -381,10 +371,3 @@ void mesh_net_transmit_params_get(struct mesh_net *net, uint8_t *count,
 							uint16_t *interval);
 struct mesh_prov *mesh_net_get_prov(struct mesh_net *net);
 void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov);
-void mesh_net_provisioned_set(struct mesh_net *net, bool provisioned);
-bool mesh_net_provisioned_get(struct mesh_net *net);
-bool mesh_net_provisioned_new(struct mesh_net *net, uint8_t device_key[16],
-				uint16_t net_idx,  uint8_t net_key[16],
-				uint16_t unicast, uint16_t snb_flags,
-				uint32_t iv_index, mesh_status_func_t cb,
-				void *user_data);
-- 
2.14.5

