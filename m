Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5539EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 20:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB65207FC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 20:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHDURw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:17:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:65000 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgHDURv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 16:17:51 -0400
IronPort-SDR: /r4LLgebyEGGxfUsbEsQ9I6fEzmitbGV765aa9CJyKfczDMmZ999Fjlp5ZbFHUB0y202KgM1JN
 bVWvmJXRzrrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="153565399"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="153565399"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 13:17:50 -0700
IronPort-SDR: rKGEktD89CY9SMjnaWEwGk9YZLCX60jh912v8o7+jEUhWWJKigfRsyzso5WmeBg0QJ42wHqwoq
 0rGfHv3xAprA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="324783858"
Received: from unknown (HELO ingas-nuc1.intel.com) ([10.254.118.65])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2020 13:17:49 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 10/10] mesh: Refactor heartbeat pub/sub
Date:   Tue,  4 Aug 2020 13:17:44 -0700
Message-Id: <20200804201744.23327-10-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804201744.23327-1-inga.stotland@intel.com>
References: <20200804201744.23327-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Move heartbeat publication/subscription timers and housekeeping
to net.c since this is where the trigger events and control messages
are handled. Configuration server (cfgmod-server.c) stays
responsible for parsing the set pub/sub message parameters and
assemblying the pub/sub status messages.

Also, make sure that the correct message status is reported.
---
 mesh/cfgmod-server.c | 307 ++++++++++++++-----------------------------
 mesh/net.c           | 273 ++++++++++++++++++++++++++++----------
 mesh/net.h           |  48 ++++---
 3 files changed, 328 insertions(+), 300 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 5854f7a1c..40ecec16a 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -445,50 +445,6 @@ static uint16_t cfg_key_refresh_phase(struct mesh_node *node,
 	return n + 3;
 }
 
-static void hb_pub_timeout_func(struct l_timeout *timeout, void *user_data)
-{
-	struct mesh_net *net = user_data;
-	struct mesh_net_heartbeat *hb = mesh_net_heartbeat_get(net);
-
-	mesh_net_heartbeat_send(net);
-
-	if (hb->pub_count != 0xffff)
-		hb->pub_count--;
-	if (hb->pub_count > 0)
-		l_timeout_modify(hb->pub_timer, hb->pub_period);
-	else {
-		l_timeout_remove(hb->pub_timer);
-		hb->pub_timer = NULL;
-	}
-}
-
-static void update_hb_pub_timer(struct mesh_net *net,
-						struct mesh_net_heartbeat *hb)
-{
-	if (IS_UNASSIGNED(hb->pub_dst) || hb->pub_count == 0) {
-		l_timeout_remove(hb->pub_timer);
-		hb->pub_timer = NULL;
-		return;
-	}
-
-	if (!hb->pub_timer)
-		hb->pub_timer = l_timeout_create(hb->pub_period,
-					hb_pub_timeout_func, net, NULL);
-	else
-		l_timeout_modify(hb->pub_timer, hb->pub_period);
-}
-
-static void hb_sub_timeout_func(struct l_timeout *timeout, void *user_data)
-{
-	struct mesh_net *net = user_data;
-	struct mesh_net_heartbeat *hb = mesh_net_heartbeat_get(net);
-
-	l_debug("HB Subscription Ended");
-	l_timeout_remove(hb->sub_timer);
-	hb->sub_timer = NULL;
-	hb->sub_enabled = false;
-}
-
 static uint8_t uint32_to_log(uint32_t value)
 {
 	uint32_t val = 1;
@@ -507,85 +463,112 @@ static uint8_t uint32_to_log(uint32_t value)
 	return ret;
 }
 
-static uint32_t log_to_uint32(uint8_t log, uint8_t offset)
+static uint16_t hb_subscription_get(struct mesh_node *node, int status)
 {
-	if (!log)
-		return 0x0000;
-	else if (log > 0x11)
-		return 0xffff;
+	struct mesh_net *net = node_get_net(node);
+	struct mesh_net_heartbeat_sub *sub = mesh_net_get_heartbeat_sub(net);
+	struct timeval time_now;
+	uint16_t n;
+
+	gettimeofday(&time_now, NULL);
+	time_now.tv_sec -= sub->start;
+
+	if (time_now.tv_sec >= (long int) sub->period)
+		time_now.tv_sec = 0;
 	else
-		return (1 << (log - offset));
-}
+		time_now.tv_sec = sub->period - time_now.tv_sec;
 
+	l_debug("Sub Period (Log %2.2x) %d sec", uint32_to_log(time_now.tv_sec),
+							(int) time_now.tv_sec);
 
-static int hb_subscription_set(struct mesh_net *net, uint16_t src,
-					uint16_t dst, uint8_t period_log)
+	n = mesh_model_opcode_set(OP_CONFIG_HEARTBEAT_SUB_STATUS, msg);
+	msg[n++] = status;
+	l_put_le16(sub->src, msg + n);
+	n += 2;
+	l_put_le16(sub->dst, msg + n);
+	n += 2;
+	msg[n++] = uint32_to_log(time_now.tv_sec);
+	msg[n++] = uint32_to_log(sub->count);
+	msg[n++] = sub->count ? sub->min_hops : 0;
+	msg[n++] = sub->max_hops;
+
+	return n;
+}
+
+static uint16_t hb_subscription_set(struct mesh_node *node, const uint8_t *pkt)
 {
-	struct mesh_net_heartbeat *hb = mesh_net_heartbeat_get(net);
-	struct timeval time_now;
+	uint16_t src, dst;
+	uint8_t period_log;
+	struct mesh_net *net;
+	int status;
+
+	src = l_get_le16(pkt);
+	dst = l_get_le16(pkt + 2);
 
 	/* SRC must be Unicast, DST can be any legal address except Virtual */
 	if ((!IS_UNASSIGNED(src) && !IS_UNICAST(src)) || IS_VIRTUAL(dst))
-		return -1;
-
-	/* Check if the subscription should be disabled */
-	if (IS_UNASSIGNED(src) || IS_UNASSIGNED(dst)) {
-		if (IS_GROUP(hb->sub_dst))
-			mesh_net_dst_unreg(net, hb->sub_dst);
-
-		l_timeout_remove(hb->sub_timer);
-		hb->sub_timer = NULL;
-		hb->sub_enabled = false;
-		hb->sub_dst = UNASSIGNED_ADDRESS;
-		hb->sub_src = UNASSIGNED_ADDRESS;
-		hb->sub_count = 0;
-		hb->sub_period = 0;
-		hb->sub_min_hops = 0;
-		hb->sub_max_hops = 0;
-		return MESH_STATUS_SUCCESS;
-
-	} else if (!period_log && src == hb->sub_src && dst == hb->sub_dst) {
-		/* Preserve collected data, but disable */
-		l_timeout_remove(hb->sub_timer);
-		hb->sub_timer = NULL;
-		hb->sub_enabled = false;
-		hb->sub_period = 0;
-		return MESH_STATUS_SUCCESS;
-	}
+		return 0;
 
-	if (hb->sub_dst != dst) {
-		if (IS_GROUP(hb->sub_dst))
-			mesh_net_dst_unreg(net, hb->sub_dst);
-		if (IS_GROUP(dst))
-			mesh_net_dst_reg(net, dst);
-	}
+	period_log = pkt[4];
 
-	hb->sub_enabled = !!period_log;
-	hb->sub_src = src;
-	hb->sub_dst = dst;
-	hb->sub_count = 0;
-	hb->sub_period = log_to_uint32(period_log, 1);
-	hb->sub_min_hops = 0x00;
-	hb->sub_max_hops = 0x00;
+	if (period_log > 0x11)
+		return 0;
 
-	gettimeofday(&time_now, NULL);
-	hb->sub_start = time_now.tv_sec;
+	net = node_get_net(node);
 
-	if (!hb->sub_enabled) {
-		l_timeout_remove(hb->sub_timer);
-		hb->sub_timer = NULL;
-		return MESH_STATUS_SUCCESS;
-	}
+	status = mesh_net_set_heartbeat_sub(net, src, dst, period_log);
 
-	hb->sub_min_hops = 0xff;
+	return hb_subscription_get(node, status);
+}
 
-	if (!hb->sub_timer)
-		hb->sub_timer = l_timeout_create(hb->sub_period,
-						hb_sub_timeout_func, net, NULL);
-	else
-		l_timeout_modify(hb->sub_timer, hb->sub_period);
+static uint16_t hb_publication_get(struct mesh_node *node, int status)
+{
+	struct mesh_net *net = node_get_net(node);
+	struct mesh_net_heartbeat_pub *pub = mesh_net_get_heartbeat_pub(net);
+	uint16_t n;
 
-	return MESH_STATUS_SUCCESS;
+	n = mesh_model_opcode_set(OP_CONFIG_HEARTBEAT_PUB_STATUS, msg);
+	msg[n++] = status;
+	l_put_le16(pub->dst, msg + n);
+	n += 2;
+	msg[n++] = uint32_to_log(pub->count);
+	msg[n++] = uint32_to_log(pub->period);
+	msg[n++] = pub->ttl;
+	l_put_le16(pub->features, msg + n);
+	n += 2;
+	l_put_le16(pub->net_idx, msg + n);
+	n += 2;
+
+	return n;
+}
+
+static uint16_t hb_publication_set(struct mesh_node *node, const uint8_t *pkt)
+{
+	uint16_t dst, features, net_idx;
+	uint8_t period_log, count_log, ttl;
+	struct mesh_net *net;
+	int status;
+
+	dst = l_get_le16(pkt);
+	count_log = pkt[2];
+	period_log = pkt[3];
+	ttl = pkt[4];
+
+	if (count_log > 0x11 && count_log != 0xff)
+		return 0;
+
+	if (period_log > 0x11 || ttl > TTL_MASK || IS_VIRTUAL(dst))
+		return 0;
+
+	features = l_get_le16(pkt + 5) & 0xf;
+	net_idx = l_get_le16(pkt + 7);
+
+	net = node_get_net(node);
+
+	status = mesh_net_set_heartbeat_pub(net, dst, features, net_idx, ttl,
+						count_log, period_log);
+
+	return hb_publication_get(node, status);
 }
 
 static void node_reset(void *user_data)
@@ -738,10 +721,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 	struct mesh_node *node = (struct mesh_node *) user_data;
 	struct mesh_net *net;
 	const uint8_t *pkt = data;
-	struct timeval time_now;
 	uint32_t opcode;
-	int b_res = MESH_STATUS_SUCCESS;
-	struct mesh_net_heartbeat *hb;
 	uint16_t n_idx;
 	uint8_t state;
 	bool virt = false;
@@ -757,7 +737,7 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		return false;
 
 	net = node_get_net(node);
-	hb = mesh_net_heartbeat_get(net);
+
 	l_debug("CONFIG-SRV-opcode 0x%x size %u idx %3.3x", opcode, size,
 								net_idx);
 
@@ -1030,113 +1010,35 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 		break;
 
 	case OP_CONFIG_HEARTBEAT_PUB_SET:
-		l_debug("OP_CONFIG_HEARTBEAT_PUB_SET");
+		l_debug("Config Heartbeat Publication Set");
 		if (size != 9)
 			return true;
 
-		if (pkt[2] > 0x11 || pkt[3] > 0x10 || pkt[4] > 0x7f)
-			return true;
-		else if (IS_VIRTUAL(l_get_le16(pkt)))
-			b_res = MESH_STATUS_INVALID_ADDRESS;
-		else if (l_get_le16(pkt + 7) != mesh_net_get_primary_idx(net))
-			/* Future work: check for valid subnets */
-			b_res = MESH_STATUS_INVALID_NETKEY;
-
-		n = mesh_model_opcode_set(OP_CONFIG_HEARTBEAT_PUB_STATUS,
-						msg);
-		msg[n++] = b_res;
-
-		memcpy(&msg[n], pkt, 9);
-
-		/* Ignore RFU bits in features */
-		l_put_le16(l_get_le16(pkt + 5) & 0xf, &msg[n + 5]);
-
-		/* Add octet count to status */
-		n += 9;
-
-		if (b_res != MESH_STATUS_SUCCESS)
-			break;
-
-		hb->pub_dst = l_get_le16(pkt);
-		if (hb->pub_dst == UNASSIGNED_ADDRESS ||
-				pkt[2] == 0 || pkt[3] == 0) {
-			/*
-			 * We might still have a pub_dst here in case
-			 * we need it for State Change heartbeat
-			 */
-			hb->pub_count = 0;
-			hb->pub_period = 0;
-		} else {
-			hb->pub_count = (pkt[2] != 0xff) ?
-				log_to_uint32(pkt[2], 1) : 0xffff;
-			hb->pub_period = log_to_uint32(pkt[3], 1);
-		}
-
-		hb->pub_ttl = pkt[4];
-		hb->pub_features = l_get_le16(pkt + 5) & 0xf;
-		hb->pub_net_idx = l_get_le16(pkt + 7);
-		update_hb_pub_timer(net, hb);
-
+		n = hb_publication_set(node, pkt);
 		break;
 
 	case OP_CONFIG_HEARTBEAT_PUB_GET:
 		if (size != 0)
 			return true;
 
-		n = mesh_model_opcode_set(OP_CONFIG_HEARTBEAT_PUB_STATUS, msg);
-		msg[n++] = b_res;
-		l_put_le16(hb->pub_dst, msg + n);
-		n += 2;
-		msg[n++] = uint32_to_log(hb->pub_count);
-		msg[n++] = uint32_to_log(hb->pub_period);
-		msg[n++] = hb->pub_ttl;
-		l_put_le16(hb->pub_features, msg + n);
-		n += 2;
-		l_put_le16(hb->pub_net_idx, msg + n);
-		n += 2;
+		n = hb_publication_get(node, MESH_STATUS_SUCCESS);
 		break;
 
 	case OP_CONFIG_HEARTBEAT_SUB_SET:
 		if (size != 5)
 			return true;
 
-		l_debug("Set Sub Period (Log %2.2x) %d sec",
-				pkt[4], log_to_uint32(pkt[4], 1));
-
-		b_res = hb_subscription_set(net, l_get_le16(pkt),
-						l_get_le16(pkt + 2),
-						pkt[4]);
-		if (b_res < 0)
-			return true;
+		l_debug("Set HB Sub Period Log %2.2x", pkt[4]);
 
-		/* Fall through */
+		n = hb_subscription_set(node, pkt);
+		break;
 
 	case OP_CONFIG_HEARTBEAT_SUB_GET:
-		if (opcode == OP_CONFIG_HEARTBEAT_SUB_GET && size != 0)
-			return true;
-
-		gettimeofday(&time_now, NULL);
-		time_now.tv_sec -= hb->sub_start;
 
-		if (time_now.tv_sec >= (long int) hb->sub_period)
-			time_now.tv_sec = 0;
-		else
-			time_now.tv_sec = hb->sub_period - time_now.tv_sec;
-
-		l_debug("Sub Period (Log %2.2x) %d sec",
-				uint32_to_log(time_now.tv_sec),
-				(int) time_now.tv_sec);
+		if (size != 0)
+			return true;
 
-		n = mesh_model_opcode_set(OP_CONFIG_HEARTBEAT_SUB_STATUS, msg);
-		msg[n++] = b_res;
-		l_put_le16(hb->sub_src, msg + n);
-		n += 2;
-		l_put_le16(hb->sub_dst, msg + n);
-		n += 2;
-		msg[n++] = uint32_to_log(time_now.tv_sec);
-		msg[n++] = uint32_to_log(hb->sub_count);
-		msg[n++] = hb->sub_count ? hb->sub_min_hops : 0;
-		msg[n++] = hb->sub_max_hops;
+		n = hb_subscription_get(node, MESH_STATUS_SUCCESS);
 		break;
 
 	case OP_CONFIG_POLL_TIMEOUT_GET:
@@ -1166,13 +1068,6 @@ static bool cfg_srv_pkt(uint16_t src, uint16_t dst, uint16_t app_idx,
 
 static void cfgmod_srv_unregister(void *user_data)
 {
-	struct mesh_node *node = user_data;
-	struct mesh_net *net = node_get_net(node);
-	struct mesh_net_heartbeat *hb = mesh_net_heartbeat_get(net);
-
-	l_timeout_remove(hb->pub_timer);
-	l_timeout_remove(hb->sub_timer);
-	hb->pub_timer = hb->sub_timer = NULL;
 }
 
 static const struct mesh_model_ops ops = {
diff --git a/mesh/net.c b/mesh/net.c
index b54c647cb..5bfaa181a 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -23,6 +23,8 @@
 
 #define _GNU_SOURCE
 
+#include <sys/time.h>
+
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
@@ -132,7 +134,10 @@ struct mesh_net {
 		uint8_t count;
 	} relay;
 
-	struct mesh_net_heartbeat heartbeat;
+	/* Heartbeat info */
+	struct mesh_net_heartbeat_sub hb_sub;
+	struct mesh_net_heartbeat_pub hb_pub;
+	uint16_t features;
 
 	struct l_queue *subnets;
 	struct l_queue *msg_cache;
@@ -255,35 +260,46 @@ static bool match_friend_key_id(const void *a, const void *b)
 					(key_id == friend->net_key_upd);
 }
 
-static void idle_mesh_heartbeat_send(void *net)
+static void send_hb_publication(void *data)
 {
-	mesh_net_heartbeat_send(net);
+	struct mesh_net *net = data;
+	struct mesh_net_heartbeat_pub *pub = &net->hb_pub;
+	uint8_t msg[4];
+	int n = 0;
+
+	if (pub->dst == UNASSIGNED_ADDRESS)
+		return;
+
+	msg[n++] = NET_OP_HEARTBEAT;
+	msg[n++] = pub->ttl;
+	l_put_be16(net->features, msg + n);
+	n += 2;
+
+	mesh_net_transport_send(net, 0, 0, mesh_net_get_iv_index(net),
+					pub->ttl, 0, 0, pub->dst, msg, n);
 }
 
 static void trigger_heartbeat(struct mesh_net *net, uint16_t feature,
-								bool in_use)
+								bool enable)
 {
-	struct mesh_net_heartbeat *hb = &net->heartbeat;
-
-	l_debug("%s: %4.4x --> %d", __func__, feature, in_use);
+	l_debug("HB: %4.4x --> %d", feature, enable);
 
-	if (in_use) {
-		if (net->heartbeat.features & feature)
+	if (enable) {
+		if (net->features & feature)
 			return; /* no change */
 
-		hb->features |= feature;
+		net->features |= feature;
 	} else {
-		if (!(hb->features & feature))
+		if (!(net->features & feature))
 			return; /* no change */
 
-		hb->features &= ~feature;
+		net->features &= ~feature;
 	}
 
-	if (!(hb->pub_features & feature))
-		return; /* not interested in this feature */
-
-	l_idle_oneshot(idle_mesh_heartbeat_send, net, NULL);
+	if (!(net->hb_pub.features & feature))
+		return; /* no interest in this feature */
 
+	l_idle_oneshot(send_hb_publication, net, NULL);
 }
 
 static bool match_by_friend(const void *a, const void *b)
@@ -616,8 +632,6 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	net->destinations = l_queue_new();
 	net->app_keys = l_queue_new();
 
-	memset(&net->heartbeat, 0, sizeof(net->heartbeat));
-
 	if (!nets)
 		nets = l_queue_new();
 
@@ -813,8 +827,8 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	appkey_delete_bound_keys(net, idx);
 
 	/* Disable hearbeat publication on this subnet */
-	if (idx == net->heartbeat.pub_net_idx)
-		net->heartbeat.pub_dst = UNASSIGNED_ADDRESS;
+	if (idx == net->hb_pub.net_idx)
+		net->hb_pub.dst = UNASSIGNED_ADDRESS;
 
 	/* TODO: cancel beacon_enable on this subnet */
 
@@ -2017,25 +2031,23 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 		break;
 
 	case NET_OP_HEARTBEAT:
-		if (net->heartbeat.sub_enabled &&
-				src == net->heartbeat.sub_src) {
+		if (net->hb_sub.enabled && src == net->hb_sub.src) {
 			uint8_t hops = pkt[0] - ttl + 1;
 
 			print_packet("Rx-NET_OP_HEARTBEAT", pkt, len);
 
-			if (net->heartbeat.sub_count != 0xffff)
-				net->heartbeat.sub_count++;
+			if (net->hb_sub.count != 0xffff)
+				net->hb_sub.count++;
 
-			if (net->heartbeat.sub_min_hops > hops)
-				net->heartbeat.sub_min_hops = hops;
+			if (net->hb_sub.min_hops > hops)
+				net->hb_sub.min_hops = hops;
 
-			if (net->heartbeat.sub_max_hops < hops)
-				net->heartbeat.sub_max_hops = hops;
+			if (net->hb_sub.max_hops < hops)
+				net->hb_sub.max_hops = hops;
 
 			l_debug("HB: cnt:%4.4x min:%2.2x max:%2.2x",
-					net->heartbeat.sub_count,
-					net->heartbeat.sub_min_hops,
-					net->heartbeat.sub_max_hops);
+					net->hb_sub.count, net->hb_sub.min_hops,
+							net->hb_sub.max_hops);
 		}
 		break;
 	}
@@ -3276,52 +3288,14 @@ int mesh_net_update_key(struct mesh_net *net, uint16_t idx,
 	return MESH_STATUS_SUCCESS;
 }
 
-static uint16_t get_features(struct mesh_net *net)
-{
-	uint16_t features = 0;
-
-	if (net->relay.enable)
-		features |= FEATURE_RELAY;
-
-	if (net->proxy_enable)
-		features |= FEATURE_PROXY;
-
-	if (net->friend_enable)
-		features |= FEATURE_FRIEND;
-
-	return features;
-}
-
-struct mesh_net_heartbeat *mesh_net_heartbeat_get(struct mesh_net *net)
-{
-	return &net->heartbeat;
-}
-
-void mesh_net_heartbeat_send(struct mesh_net *net)
+struct mesh_net_heartbeat_sub *mesh_net_get_heartbeat_sub(struct mesh_net *net)
 {
-	struct mesh_net_heartbeat *hb = &net->heartbeat;
-	uint8_t msg[4];
-	int n = 0;
-
-	if (hb->pub_dst == UNASSIGNED_ADDRESS)
-		return;
-
-	msg[n++] = NET_OP_HEARTBEAT;
-	msg[n++] = hb->pub_ttl;
-	l_put_be16(hb->features, msg + n);
-	n += 2;
-
-	mesh_net_transport_send(net, 0, 0, mesh_net_get_iv_index(net),
-					hb->pub_ttl, 0, 0, hb->pub_dst, msg, n);
+	return &net->hb_sub;
 }
 
-void mesh_net_heartbeat_init(struct mesh_net *net)
+struct mesh_net_heartbeat_pub *mesh_net_get_heartbeat_pub(struct mesh_net *net)
 {
-	struct mesh_net_heartbeat *hb = &net->heartbeat;
-
-	memset(hb, 0, sizeof(struct mesh_net_heartbeat));
-	hb->sub_min_hops = 0xff;
-	hb->features = get_features(net);
+	return &net->hb_pub;
 }
 
 void mesh_net_set_iv_index(struct mesh_net *net, uint32_t index, bool update)
@@ -3559,3 +3533,156 @@ void net_msg_add_replay_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
 	/* Optimize so that most recent conversations stay earliest in cache */
 	l_queue_push_head(net->replay_cache, rpe);
 }
+
+static void hb_sub_timeout_func(struct l_timeout *timeout, void *user_data)
+{
+	struct mesh_net *net = user_data;
+	struct mesh_net_heartbeat_sub *sub = &net->hb_sub;
+
+	l_debug("HB Subscription Ended");
+	l_timeout_remove(sub->timer);
+	sub->timer = NULL;
+	sub->enabled = false;
+}
+
+static uint32_t log_to_uint32(uint8_t log)
+{
+	if (!log)
+		return 0x0000;
+
+	return (1 << (log - 1));
+}
+
+int mesh_net_set_heartbeat_sub(struct mesh_net *net, uint16_t src, uint16_t dst,
+							uint8_t period_log)
+{
+	struct mesh_net_heartbeat_sub *sub = &net->hb_sub;
+	struct timeval time_now;
+
+	if (!net)
+		return MESH_STATUS_UNSPECIFIED_ERROR;
+
+	/* Check if the subscription should be disabled */
+	if (IS_UNASSIGNED(src) || IS_UNASSIGNED(dst)) {
+		if (IS_GROUP(sub->dst))
+			mesh_net_dst_unreg(net, sub->dst);
+
+		sub->enabled = false;
+		sub->dst = UNASSIGNED_ADDRESS;
+		sub->src = UNASSIGNED_ADDRESS;
+		sub->count = 0;
+		sub->period = 0;
+		sub->min_hops = 0;
+		sub->max_hops = 0;
+
+	} else if (!period_log && src == sub->src && dst == sub->dst) {
+		/* Preserve collected data, but disable */
+		sub->enabled = false;
+		sub->period = 0;
+
+	} else if (sub->dst != dst) {
+		if (IS_GROUP(sub->dst))
+			mesh_net_dst_unreg(net, sub->dst);
+
+		if (IS_GROUP(dst))
+			mesh_net_dst_reg(net, dst);
+
+		sub->enabled = !!period_log;
+		sub->src = src;
+		sub->dst = dst;
+		sub->count = 0;
+		sub->period = log_to_uint32(period_log);
+		sub->min_hops = 0x00;
+		sub->max_hops = 0x00;
+		gettimeofday(&time_now, NULL);
+		sub->start = time_now.tv_sec;
+	}
+
+	/* TODO: Save to node config */
+
+	if (!sub->enabled) {
+		l_timeout_remove(sub->timer);
+		sub->timer = NULL;
+		return MESH_STATUS_SUCCESS;
+	}
+
+	sub->min_hops = 0xff;
+
+	if (!sub->timer)
+		sub->timer = l_timeout_create(sub->period, hb_sub_timeout_func,
+								net, NULL);
+	else
+		l_timeout_modify(sub->timer, sub->period);
+
+	return MESH_STATUS_SUCCESS;
+}
+
+static void hb_pub_timeout_func(struct l_timeout *timeout, void *user_data)
+{
+	struct mesh_net *net = user_data;
+	struct mesh_net_heartbeat_pub *pub = &net->hb_pub;
+
+	send_hb_publication(net);
+
+	if (pub->count != 0xffff)
+		pub->count--;
+
+	if (pub->count > 0)
+		l_timeout_modify(pub->timer, pub->period);
+	else {
+		l_timeout_remove(pub->timer);
+		pub->timer = NULL;
+	}
+}
+
+static void update_hb_pub_timer(struct mesh_net *net,
+					struct mesh_net_heartbeat_pub *pub)
+{
+	if (IS_UNASSIGNED(pub->dst) || pub->count == 0) {
+		l_timeout_remove(pub->timer);
+		pub->timer = NULL;
+		return;
+	}
+
+	if (!pub->timer)
+		pub->timer = l_timeout_create(pub->period,
+					hb_pub_timeout_func, net, NULL);
+	else
+		l_timeout_modify(pub->timer, pub->period);
+}
+
+int mesh_net_set_heartbeat_pub(struct mesh_net *net, uint16_t dst,
+				uint16_t features, uint16_t idx, uint8_t ttl,
+				uint8_t count_log, uint8_t period_log)
+{
+	struct mesh_subnet *subnet;
+	struct mesh_net_heartbeat_pub *pub = &net->hb_pub;
+
+	if (!net)
+		return MESH_STATUS_UNSPECIFIED_ERROR;
+
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(idx));
+	if (!subnet)
+		return MESH_STATUS_INVALID_NETKEY;
+
+	pub->dst = dst;
+
+	if (pub->dst == UNASSIGNED_ADDRESS) {
+		pub->count = 0;
+		pub->period = 0;
+		pub->ttl = 0;
+	} else {
+		pub->count = (count_log != 0xff) ?
+					log_to_uint32(count_log) : 0xffff;
+		pub->period = log_to_uint32(period_log);
+	}
+
+	pub->ttl = ttl;
+	pub->features = features;
+	pub->net_idx = idx;
+	update_hb_pub_timer(net, pub);
+
+	/* TODO: Save to node config */
+	return MESH_STATUS_SUCCESS;
+}
diff --git a/mesh/net.h b/mesh/net.h
index 2673b895a..6d707436e 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -129,25 +129,27 @@ struct mesh_net_prov_caps {
 	uint16_t input_action;
 } __packed;
 
-struct mesh_net_heartbeat {
-	struct l_timeout *pub_timer;
-	struct l_timeout *sub_timer;
-	struct timeval sub_time;
-	bool sub_enabled;
-	uint32_t pub_period;
-	uint32_t sub_period;
-	uint32_t sub_start;
-	uint16_t pub_dst;
-	uint16_t pub_count;
-	uint16_t pub_features;
+struct mesh_net_heartbeat_sub {
+	struct l_timeout *timer;
+	uint32_t start;
+	uint32_t period;
 	uint16_t features;
-	uint16_t pub_net_idx;
-	uint16_t sub_src;
-	uint16_t sub_dst;
-	uint16_t sub_count;
-	uint8_t pub_ttl;
-	uint8_t sub_min_hops;
-	uint8_t sub_max_hops;
+	uint16_t src;
+	uint16_t dst;
+	uint16_t count;
+	bool enabled;
+	uint8_t min_hops;
+	uint8_t max_hops;
+};
+
+struct mesh_net_heartbeat_pub {
+	struct l_timeout *timer;
+	uint32_t period;
+	uint16_t dst;
+	uint16_t count;
+	uint16_t features;
+	uint16_t net_idx;
+	uint8_t ttl;
 };
 
 struct mesh_key_set {
@@ -328,9 +330,13 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, uint32_t hdr,
 				const void *seg, uint16_t seg_len);
-struct mesh_net_heartbeat *mesh_net_heartbeat_get(struct mesh_net *net);
-void mesh_net_heartbeat_init(struct mesh_net *net);
-void mesh_net_heartbeat_send(struct mesh_net *net);
+struct mesh_net_heartbeat_sub *mesh_net_get_heartbeat_sub(struct mesh_net *net);
+int mesh_net_set_heartbeat_sub(struct mesh_net *net, uint16_t src, uint16_t dst,
+							uint8_t period_log);
+struct mesh_net_heartbeat_pub *mesh_net_get_heartbeat_pub(struct mesh_net *net);
+int mesh_net_set_heartbeat_pub(struct mesh_net *net, uint16_t dst,
+				uint16_t features, uint16_t idx, uint8_t ttl,
+				uint8_t count_log, uint8_t period_log);
 bool mesh_net_key_list_get(struct mesh_net *net, uint8_t *buf, uint16_t *count);
 uint16_t mesh_net_get_primary_idx(struct mesh_net *net);
 uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr);
-- 
2.26.2

