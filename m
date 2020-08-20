Return-Path: <SRS0=lMkY=B6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198BEC433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 05:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E732F2075E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 05:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgHTFlf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:41:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:54471 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgHTFle (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Aug 2020 01:41:34 -0400
IronPort-SDR: BcBap1Y8AAW5GYsGBsSppBXotrV2Q6HtzXGB6f9IR58b5rd9PMof5czq5HjyM0FjSSUiI/D+rb
 hNVMw+doVFkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142875131"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="142875131"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 22:41:33 -0700
IronPort-SDR: Kj75FP9OtUJyLNyXNWxKsohEVNLLe66dh0wAcME8u0FsCSGVrVZgMvXH6XxDLdm02aInTFUN3T
 /ZP0AyhGCjoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="320740667"
Received: from aupasani-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.81.12])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2020 22:41:33 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Use correct retransmit parameters for publications
Date:   Wed, 19 Aug 2020 22:41:32 -0700
Message-Id: <20200820054132.110483-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds previously missing retransmit count and interval values
specific to model publications. The values are configured by Config CLient
and may be different to each model.
---
 mesh/cfgmod-server.c    | 26 +++++++++++-------
 mesh/mesh-config-json.c | 36 ++++++++++++-------------
 mesh/mesh-config.h      |  4 +--
 mesh/model.c            | 59 +++++++++++++++++++++++------------------
 mesh/model.h            |  9 ++++---
 mesh/net.c              | 42 ++++++++++++++++++-----------
 mesh/net.h              |  6 ++---
 7 files changed, 104 insertions(+), 78 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 90ebdf046..239ea889d 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -48,7 +48,7 @@ static uint8_t msg[MAX_MSG_LEN];
 
 static uint16_t set_pub_status(uint8_t status, uint16_t ele_addr, uint32_t id,
 				uint16_t pub_addr, uint16_t idx, bool cred_flag,
-				uint8_t ttl, uint8_t period, uint8_t retransmit)
+				uint8_t ttl, uint8_t period, uint8_t rtx)
 {
 	size_t n;
 
@@ -61,7 +61,7 @@ static uint16_t set_pub_status(uint8_t status, uint16_t ele_addr, uint32_t id,
 	n += 6;
 	msg[n++] = ttl;
 	msg[n++] = period;
-	msg[n++] = retransmit;
+	msg[n++] = rtx;
 
 	if (!IS_VENDOR(id)) {
 		l_put_le16(MODEL_ID(id), msg + n);
@@ -80,6 +80,7 @@ static uint16_t config_pub_get(struct mesh_node *node, const uint8_t *pkt,
 {
 	uint32_t id;
 	uint16_t ele_addr;
+	uint8_t rtx;
 	struct mesh_model_pub *pub;
 	int status;
 
@@ -88,10 +89,12 @@ static uint16_t config_pub_get(struct mesh_node *node, const uint8_t *pkt,
 
 	pub = mesh_model_pub_get(node, ele_addr, id, &status);
 
+	rtx = pub->rtx.cnt + (((pub->rtx.interval / 50) - 1) << 3);
+
 	if (pub && status == MESH_STATUS_SUCCESS)
 		return set_pub_status(status, ele_addr, id, pub->addr, pub->idx,
 					pub->credential, pub->ttl, pub->period,
-					pub->retransmit);
+					rtx);
 	else
 		return set_pub_status(status, ele_addr, id, 0, 0, 0, 0, 0, 0);
 }
@@ -102,7 +105,7 @@ static uint16_t config_pub_set(struct mesh_node *node, const uint8_t *pkt,
 	uint32_t id;
 	uint16_t ele_addr, idx, pub_dst;
 	const uint8_t *pub_addr;
-	uint8_t ttl, period, retransmit;
+	uint8_t ttl, period, rtx, cnt, interval;
 	int status;
 	bool cred_flag;
 
@@ -124,12 +127,15 @@ static uint16_t config_pub_set(struct mesh_node *node, const uint8_t *pkt,
 	idx &= APP_IDX_MASK;
 	ttl = pkt[6];
 	period = pkt[7];
-	retransmit = pkt[8];
+	rtx = pkt[8];
 	id = CFG_GET_ID(vendor, pkt + 9);
 
+	cnt = rtx & 0x7;
+	interval = ((rtx >> 3) + 1) * 50;
+
 	status = mesh_model_pub_set(node, ele_addr, id, pub_addr, idx,
-					cred_flag, ttl, period, retransmit,
-					virt, &pub_dst);
+					cred_flag, ttl, period, cnt,
+					interval, virt, &pub_dst);
 
 	l_debug("pub_set: status %d, ea %4.4x, ota: %4.4x, id: %x, idx: %3.3x",
 					status, ele_addr, pub_dst, id, idx);
@@ -153,8 +159,8 @@ static uint16_t config_pub_set(struct mesh_node *node, const uint8_t *pkt,
 			.ttl = ttl,
 			.credential = cred_flag,
 			.period = period,
-			.count = retransmit & 0x7,
-			.interval = ((retransmit >> 3) + 1) * 50
+			.cnt = cnt,
+			.interval = interval
 		};
 
 		if (virt)
@@ -168,7 +174,7 @@ static uint16_t config_pub_set(struct mesh_node *node, const uint8_t *pkt,
 	}
 
 	return set_pub_status(status, ele_addr, id, pub_dst, idx, cred_flag,
-						ttl, period, retransmit);
+						ttl, period, rtx);
 }
 
 static uint16_t cfg_sub_get_msg(struct mesh_node *node, const uint8_t *pkt,
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index a145388d6..63b6c3988 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1021,7 +1021,7 @@ static struct mesh_config_pub *parse_model_publication(json_object *jpub)
 
 	if (!get_int(jvalue, "count", &value))
 		goto fail;
-	pub->count = (uint8_t) value;
+	pub->cnt = (uint8_t) value;
 
 	if (!get_int(jvalue, "interval", &value))
 		goto fail;
@@ -1339,20 +1339,20 @@ static bool parse_composition(json_object *jcomp, struct mesh_config_node *node)
 
 static bool read_net_transmit(json_object *jobj, struct mesh_config_node *node)
 {
-	json_object *jretransmit, *jvalue;
+	json_object *jrtx, *jvalue;
 	uint16_t interval;
 	uint8_t cnt;
 
-	if (!json_object_object_get_ex(jobj, "retransmit", &jretransmit))
+	if (!json_object_object_get_ex(jobj, "retransmit", &jrtx))
 		return true;
 
-	if (!json_object_object_get_ex(jretransmit, "count", &jvalue))
+	if (!json_object_object_get_ex(jrtx, "count", &jvalue))
 		return false;
 
 	/* TODO: add range checking */
 	cnt = (uint8_t) json_object_get_int(jvalue);
 
-	if (!json_object_object_get_ex(jretransmit, "interval", &jvalue))
+	if (!json_object_object_get_ex(jrtx, "interval", &jvalue))
 		return false;
 
 	interval = (uint16_t) json_object_get_int(jvalue);
@@ -1566,30 +1566,30 @@ bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 							uint16_t interval)
 {
-	json_object *jnode, *jretransmit;
+	json_object *jnode, *jrtx;
 
 	if (!cfg)
 		return false;
 
 	jnode = cfg->jnode;
 
-	jretransmit = json_object_new_object();
-	if (!jretransmit)
+	jrtx = json_object_new_object();
+	if (!jrtx)
 		return false;
 
-	if (!write_int(jretransmit, "count", cnt))
+	if (!write_int(jrtx, "count", cnt))
 		goto fail;
 
-	if (!write_int(jretransmit, "interval", interval))
+	if (!write_int(jrtx, "interval", interval))
 		goto fail;
 
 	json_object_object_del(jnode, "retransmit");
-	json_object_object_add(jnode, "retransmit", jretransmit);
+	json_object_object_add(jnode, "retransmit", jrtx);
 
 	return save_config(cfg->jnode, cfg->node_dir_path);
 
 fail:
-	json_object_put(jretransmit);
+	json_object_put(jrtx);
 	return false;
 
 }
@@ -1841,7 +1841,7 @@ bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 					uint32_t mod_id, bool vendor,
 					struct mesh_config_pub *pub)
 {
-	json_object *jnode, *jmodel, *jpub, *jretransmit;
+	json_object *jnode, *jmodel, *jpub, *jrtx;
 	bool res;
 	int ele_idx;
 
@@ -1885,17 +1885,17 @@ bool mesh_config_model_pub_add(struct mesh_config *cfg, uint16_t ele_addr,
 						pub->credential ? 1 : 0))
 		goto fail;
 
-	jretransmit = json_object_new_object();
-	if (!jretransmit)
+	jrtx = json_object_new_object();
+	if (!jrtx)
 		goto fail;
 
-	if (!write_int(jretransmit, "count", pub->count))
+	if (!write_int(jrtx, "count", pub->cnt))
 		goto fail;
 
-	if (!write_int(jretransmit, "interval", pub->interval))
+	if (!write_int(jrtx, "interval", pub->interval))
 		goto fail;
 
-	json_object_object_add(jpub, "retransmit", jretransmit);
+	json_object_object_add(jpub, "retransmit", jrtx);
 	json_object_object_add(jmodel, "publish", jpub);
 
 	return save_config(jnode, cfg->node_dir_path);
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index 50a55d51e..738cff9dd 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -34,10 +34,10 @@ struct mesh_config_pub {
 	uint32_t period;
 	uint16_t addr;
 	uint16_t idx;
+	uint16_t interval;
 	uint8_t ttl;
 	uint8_t credential;
-	uint8_t count;
-	uint8_t interval;
+	uint8_t cnt;
 	uint8_t virt_addr[16];
 };
 
diff --git a/mesh/model.c b/mesh/model.c
index 961391f13..eb5142503 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -508,10 +508,11 @@ static int virt_packet_decrypt(struct mesh_net *net, const uint8_t *data,
 	return -1;
 }
 
-static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
-		uint32_t dst, uint16_t app_idx, uint16_t net_idx,
-		uint8_t *label, uint8_t ttl, bool segmented,
-		const void *msg, uint16_t msg_len)
+static bool msg_send(struct mesh_node *node, bool cred, uint16_t src,
+			uint16_t dst, uint16_t app_idx, uint16_t net_idx,
+			uint8_t *label, uint8_t ttl, uint8_t cnt,
+			uint16_t interval, bool segmented, const void *msg,
+			uint16_t msg_len)
 {
 	uint8_t dev_key[16];
 	uint32_t iv_index, seq_num;
@@ -562,9 +563,9 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		goto done;
 	}
 
-	ret =  mesh_net_app_send(net, credential, src, dst, key_aid, net_idx,
-					ttl, seq_num, iv_index, segmented,
-					szmic, out, out_len);
+	ret =  mesh_net_app_send(net, cred, src, dst, key_aid, net_idx, ttl,
+					cnt, interval, seq_num, iv_index,
+					segmented, szmic, out, out_len);
 done:
 	l_free(out);
 	return ret;
@@ -705,7 +706,7 @@ static struct mesh_virtual *add_virtual(const uint8_t *v)
 
 static int set_pub(struct mesh_model *mod, uint16_t pub_addr,
 			uint16_t idx, bool cred_flag, uint8_t ttl,
-			uint8_t period, uint8_t retransmit)
+			uint8_t period, uint8_t cnt, uint16_t interval)
 {
 	if (!mod->pub)
 		mod->pub = l_new(struct mesh_model_pub, 1);
@@ -715,14 +716,15 @@ static int set_pub(struct mesh_model *mod, uint16_t pub_addr,
 	mod->pub->idx = idx;
 	mod->pub->ttl = ttl;
 	mod->pub->period = period;
-	mod->pub->retransmit = retransmit;
+	mod->pub->rtx.cnt = cnt;
+	mod->pub->rtx.interval = interval;
 
 	return MESH_STATUS_SUCCESS;
 }
 
 static int set_virt_pub(struct mesh_model *mod, const uint8_t *label,
 			uint16_t idx, bool cred_flag, uint8_t ttl,
-			uint8_t period, uint8_t retransmit)
+			uint8_t period, uint8_t cnt, uint16_t interval)
 {
 	struct mesh_virtual *virt = NULL;
 
@@ -734,8 +736,8 @@ static int set_virt_pub(struct mesh_model *mod, const uint8_t *label,
 		mod->pub = l_new(struct mesh_model_pub, 1);
 
 	mod->pub->virt = virt;
-	return set_pub(mod, virt->addr, idx, cred_flag, ttl, period,
-								retransmit);
+	return set_pub(mod, virt->addr, idx, cred_flag, ttl, period, cnt,
+								interval);
 }
 
 static int add_virt_sub(struct mesh_net *net, struct mesh_model *mod,
@@ -1058,9 +1060,10 @@ int mesh_model_publish(struct mesh_node *node, uint32_t id, uint16_t src,
 
 	net_idx = appkey_net_idx(net, mod->pub->idx);
 
-	result = msg_send(node, mod->pub->credential != 0, src,
-				mod->pub->addr, mod->pub->idx, net_idx,
-				label, mod->pub->ttl, false, msg, msg_len);
+	result = msg_send(node, mod->pub->credential != 0, src, mod->pub->addr,
+				mod->pub->idx, net_idx, label, mod->pub->ttl,
+				mod->pub->rtx.cnt, mod->pub->rtx.interval,
+				false, msg, msg_len);
 
 	return result ? MESH_ERROR_NONE : MESH_ERROR_FAILED;
 }
@@ -1070,6 +1073,10 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 					uint8_t ttl, bool segmented,
 					const void *msg, uint16_t msg_len)
 {
+	struct mesh_net *net = node_get_net(node);
+	uint8_t cnt;
+	uint16_t interval;
+
 	/* If SRC is 0, use the Primary Element */
 	if (src == 0)
 		src = node_get_primary(node);
@@ -1079,14 +1086,16 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t dst,
 	if (IS_UNASSIGNED(dst))
 		return false;
 
-	return msg_send(node, false, src, dst, app_idx, net_idx,
-					NULL, ttl, segmented, msg, msg_len);
+	mesh_net_transmit_params_get(net, &cnt, &interval);
+
+	return msg_send(node, false, src, dst, app_idx, net_idx, NULL, ttl, cnt,
+					interval, segmented, msg, msg_len);
 }
 
 int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 			const uint8_t *pub_addr, uint16_t idx, bool cred_flag,
-			uint8_t ttl, uint8_t period, uint8_t retransmit,
-			bool is_virt, uint16_t *pub_dst)
+			uint8_t ttl, uint8_t period, uint8_t cnt,
+			uint16_t interval, bool is_virt, uint16_t *pub_dst)
 {
 	struct mesh_model *mod;
 	int status, ele_idx = node_get_element_idx(node, addr);
@@ -1124,10 +1133,10 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 
 	if (!is_virt) {
 		status = set_pub(mod, l_get_le16(pub_addr), idx, cred_flag,
-						ttl, period, retransmit);
+						ttl, period, cnt, interval);
 	} else
 		status = set_virt_pub(mod, pub_addr, idx, cred_flag, ttl,
-						period, retransmit);
+							period, cnt, interval);
 
 	*pub_dst = mod->pub->addr;
 
@@ -1703,15 +1712,13 @@ static struct mesh_model *model_setup(struct mesh_net *net, uint8_t ele_idx,
 
 	/* Add publication if enabled and present */
 	if (mod->pub_enabled && pub) {
-		uint8_t retransmit = pub->count +
-					((pub->interval / 50 - 1) << 3);
 		if (pub->virt)
 			set_virt_pub(mod, pub->virt_addr, pub->idx,
-						pub->credential, pub->ttl,
-						pub->period, retransmit);
+					pub->credential, pub->ttl, pub->period,
+					pub->cnt, pub->interval);
 		else if (!IS_UNASSIGNED(pub->addr))
 			set_pub(mod, pub->addr, pub->idx, pub->credential,
-				pub->ttl, pub->period, retransmit);
+				pub->ttl, pub->period, pub->cnt, pub->interval);
 	}
 
 	mod->sub_enabled = db_mod->sub_enabled;
diff --git a/mesh/model.h b/mesh/model.h
index 147a02279..a1afedd19 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -40,10 +40,13 @@ struct mesh_model_pub {
 	struct mesh_virtual *virt;
 	uint16_t addr;
 	uint16_t idx;
+	struct {
+		uint16_t interval;
+		uint8_t cnt;
+	} rtx;
 	uint8_t ttl;
 	uint8_t credential;
 	uint8_t period;
-	uint8_t retransmit;
 };
 
 typedef void (*mesh_model_unregister)(void *user_data);
@@ -78,8 +81,8 @@ struct mesh_model_pub *mesh_model_pub_get(struct mesh_node *node,
 						uint32_t id, int *status);
 int mesh_model_pub_set(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 			const uint8_t *addr, uint16_t idx, bool cred_flag,
-			uint8_t ttl, uint8_t period, uint8_t retransmit,
-			bool is_virt, uint16_t *dst);
+			uint8_t ttl, uint8_t period, uint8_t rtx_cnt,
+			uint16_t rtx_interval, bool is_virt, uint16_t *dst);
 
 int mesh_model_binding_add(struct mesh_node *node, uint16_t ele_addr,
 						uint32_t id, uint16_t idx);
diff --git a/mesh/net.c b/mesh/net.c
index 26440b02d..93307e70c 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -212,6 +212,8 @@ struct net_queue_data {
 
 struct oneshot_tx {
 	struct mesh_net *net;
+	uint16_t interval;
+	uint8_t cnt;
 	uint8_t size;
 	uint8_t packet[30];
 };
@@ -1399,7 +1401,8 @@ static void friend_ack_rxed(struct mesh_net *net, uint32_t iv_index,
 	l_queue_foreach(net->friends, enqueue_friend_pkt, &frnd_ack);
 }
 
-static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t seg);
+static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
+					struct mesh_sar *msg, uint8_t seg);
 
 static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
 						uint32_t hdr, uint32_t flags)
@@ -1593,7 +1596,7 @@ static void ack_received(struct mesh_net *net, bool timeout,
 		l_debug("Resend Seg %d net:%p dst:%x app_idx:%3.3x",
 				i, net, outgoing->remote, outgoing->app_idx);
 
-		send_seg(net, outgoing, i);
+		send_seg(net, net->tx_cnt, net->tx_interval, outgoing, i);
 	}
 
 	l_timeout_remove(outgoing->seg_timeout);
@@ -2143,8 +2146,8 @@ static void send_msg_pkt_oneshot(void *user_data)
 
 	tx->packet[0] = MESH_AD_TYPE_NETWORK;
 	info.type = MESH_IO_TIMING_TYPE_GENERAL;
-	info.u.gen.interval = net->tx_interval;
-	info.u.gen.cnt = net->tx_cnt;
+	info.u.gen.interval = tx->interval;
+	info.u.gen.cnt = tx->cnt;
 	info.u.gen.min_delay = DEFAULT_MIN_DELAY;
 	/* No extra randomization when sending regular mesh messages */
 	info.u.gen.max_delay = DEFAULT_MIN_DELAY;
@@ -2153,11 +2156,14 @@ static void send_msg_pkt_oneshot(void *user_data)
 	l_free(tx);
 }
 
-static void send_msg_pkt(struct mesh_net *net, uint8_t *packet, uint8_t size)
+static void send_msg_pkt(struct mesh_net *net, uint8_t cnt, uint16_t interval,
+						uint8_t *packet, uint8_t size)
 {
 	struct oneshot_tx *tx = l_new(struct oneshot_tx, 1);
 
 	tx->net = net;
+	tx->interval = interval;
+	tx->cnt = cnt;
 	tx->size = size;
 	memcpy(tx->packet, packet, size);
 
@@ -2872,7 +2878,8 @@ bool mesh_net_dst_unreg(struct mesh_net *net, uint16_t dst)
 	return true;
 }
 
-static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
+static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
+					struct mesh_sar *msg, uint8_t segO)
 {
 	struct mesh_subnet *subnet;
 	uint8_t seg_len;
@@ -2927,7 +2934,7 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
 		return false;
 	}
 
-	send_msg_pkt(net, packet, packet_len + 1);
+	send_msg_pkt(net, cnt, interval, packet, packet_len + 1);
 
 	msg->last_seg = segO;
 
@@ -2967,7 +2974,8 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 		return;
 	}
 
-	send_msg_pkt(net, packet, packet_len + 1);
+	send_msg_pkt(net, net->tx_cnt, net->tx_interval, packet,
+								packet_len + 1);
 
 	l_debug("TX: Friend Seg-%d %04x -> %04x : len %u) : TTL %d : SEQ %06x",
 					segO, src, dst, packet_len, ttl, seq);
@@ -2977,9 +2985,9 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 				uint16_t dst, uint8_t key_aid, uint16_t net_idx,
-				uint8_t ttl, uint32_t seq, uint32_t iv_index,
-				bool segmented, bool szmic,
-				const void *msg, uint16_t msg_len)
+				uint8_t ttl, uint8_t cnt, uint16_t interval,
+				uint32_t seq, uint32_t iv_index, bool segmented,
+				bool szmic, const void *msg, uint16_t msg_len)
 {
 	struct mesh_sar *payload = NULL;
 	uint8_t seg, seg_max;
@@ -3054,11 +3062,12 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 
 		for (i = 0; i < 4; i++) {
 			for (seg = 0; seg <= seg_max && result; seg++)
-				result = send_seg(net, payload, seg);
+				result = send_seg(net, cnt, interval, payload,
+									seg);
 		}
 	} else {
 		for (seg = 0; seg <= seg_max && result; seg++)
-			result = send_seg(net, payload, seg);
+			result = send_seg(net, cnt, interval, payload, seg);
 	}
 
 	/* Reliable: Cache; Unreliable: Flush*/
@@ -3108,7 +3117,7 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id, uint32_t iv_index,
 		return;
 	}
 
-	send_msg_pkt(net, pkt, pkt_len + 1);
+	send_msg_pkt(net, net->tx_cnt, net->tx_interval, pkt, pkt_len + 1);
 
 	l_debug("TX: Friend ACK %04x -> %04x : len %u : TTL %d : SEQ %06x",
 					src, dst, pkt_len, ttl, seq);
@@ -3182,8 +3191,9 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 		return;
 	}
 
-	if (dst != 0)
-		send_msg_pkt(net, pkt, pkt_len + 1);
+	if (!(IS_UNASSIGNED(dst)))
+		send_msg_pkt(net, net->tx_cnt, net->tx_interval, pkt,
+								pkt_len + 1);
 }
 
 int mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t idx,
diff --git a/mesh/net.h b/mesh/net.h
index 91e07ef78..253185e42 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -300,9 +300,9 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 				uint16_t dst, uint8_t key_id, uint16_t net_idx,
-				uint8_t ttl, uint32_t seq, uint32_t iv_index,
-				bool segmented, bool szmic, const void *msg,
-				uint16_t msg_len);
+				uint8_t ttl, uint8_t cnt, uint16_t interval,
+				uint32_t seq, uint32_t iv_index, bool segmented,
+				bool szmic, const void *msg, uint16_t msg_len);
 void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, bool rly,
-- 
2.26.2

