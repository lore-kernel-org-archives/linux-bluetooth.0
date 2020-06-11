Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1F8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 18:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E2A20829
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 18:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFKSan (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:30:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:1954 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgFKSam (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jun 2020 14:30:42 -0400
IronPort-SDR: XCHvACZ3r6HaVKFywsxayJNt5POGzcaSfHK/R9zO7y4W3oGWOIKnI9QhAkK8xqrhRBq5Z86wI6
 uMhNbAwlPEzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 11:30:42 -0700
IronPort-SDR: QWlnxVJ9TMroK0SBHTNOdILRJPhD7jhsxeqltp6B9fsZ2C3vmOdZZopOeuOJZsh2A/6G4bEiSQ
 pjnnFHXrf2Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,500,1583222400"; 
   d="scan'208";a="419194694"
Received: from ewillia2-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.231.189])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2020 11:30:41 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Delete unused structures/functions
Date:   Thu, 11 Jun 2020 11:30:38 -0700
Message-Id: <20200611183038.96969-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This deletes unused functions and structures in net.c & net.h.
Plus, some style cleanup.
---
 mesh/net.c | 64 +++++++++++++-----------------------------------------
 mesh/net.h |  2 --
 2 files changed, 15 insertions(+), 51 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 7dbe45f7d..3ab948be5 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -59,6 +59,8 @@
 
 #define SAR_KEY(src, seq0)	((((uint32_t)(seq0)) << 16) | (src))
 
+#define FAST_CACHE_SIZE 8
+
 enum _relay_advice {
 	RELAY_NONE,		/* Relay not enabled in node */
 	RELAY_ALLOWED,		/* Relay enabled, msg not to node's unicast */
@@ -179,30 +181,6 @@ struct mesh_destination {
 	uint16_t ref_cnt;
 };
 
-struct msg_rx {
-	const uint8_t *data;
-	uint32_t iv_index;
-	uint32_t seq;
-	uint16_t src;
-	uint16_t dst;
-	uint16_t size;
-	uint8_t tc;
-	bool done;
-	bool szmic;
-	union {
-		struct {
-			uint16_t app_idx;
-			uint8_t key_aid;
-		} m;
-		struct {
-			uint16_t seq0;
-		} a;
-		struct {
-			uint8_t opcode;
-		} c;
-	} u;
-};
-
 struct net_decode {
 	struct mesh_net *net;
 	struct mesh_friend *frnd;
@@ -241,7 +219,6 @@ struct net_beacon_data {
 	bool processed;
 };
 
-#define FAST_CACHE_SIZE 8
 static struct l_queue *fast_cache;
 static struct l_queue *nets;
 
@@ -289,6 +266,7 @@ static void trigger_heartbeat(struct mesh_net *net, uint16_t feature,
 	struct mesh_net_heartbeat *hb = &net->heartbeat;
 
 	l_debug("%s: %4.4x --> %d", __func__, feature, in_use);
+
 	if (in_use) {
 		if (net->heartbeat.features & feature)
 			return; /* no change */
@@ -402,17 +380,15 @@ struct mesh_friend *mesh_friend_new(struct mesh_net *net, uint16_t dst,
 	subnet = get_primary_subnet(net);
 	/* TODO: the primary key must be present, do we need to add check?. */
 
-	frnd->net_key_cur = net_key_frnd_add(subnet->net_key_cur,
-							dst, net->src_addr,
-							lp_cnt, fn_cnt);
+	frnd->net_key_cur = net_key_frnd_add(subnet->net_key_cur, dst,
+						net->src_addr, lp_cnt, fn_cnt);
 
 	if (!subnet->net_key_upd)
 		return frnd;
 
 	frnd->net_idx = subnet->idx;
-	frnd->net_key_upd = net_key_frnd_add(subnet->net_key_upd,
-							dst, net->src_addr,
-							lp_cnt, fn_cnt);
+	frnd->net_key_upd = net_key_frnd_add(subnet->net_key_upd, dst,
+						net->src_addr, lp_cnt, fn_cnt);
 
 	return frnd;
 }
@@ -436,8 +412,7 @@ bool mesh_friend_clear(struct mesh_net *net, struct mesh_friend *frnd)
 }
 
 void mesh_friend_sub_add(struct mesh_net *net, uint16_t lpn, uint8_t ele_cnt,
-							uint8_t grp_cnt,
-							const uint8_t *list)
+					uint8_t grp_cnt, const uint8_t *list)
 {
 	uint16_t *new_list;
 	uint16_t *grp_list;
@@ -463,15 +438,13 @@ void mesh_friend_sub_add(struct mesh_net *net, uint16_t lpn, uint8_t ele_cnt,
 	frnd->u.active.grp_cnt += grp_cnt;
 }
 
-void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn,
-						uint8_t cnt,
-						const uint8_t *del_list)
+void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn, uint8_t cnt,
+							const uint8_t *del_list)
 {
 	uint16_t *grp_list;
 	int16_t i, grp_cnt;
 	size_t cnt16 = cnt * sizeof(uint16_t);
-	struct mesh_friend *frnd = l_queue_find(net->friends,
-							match_by_friend,
+	struct mesh_friend *frnd = l_queue_find(net->friends, match_by_friend,
 							L_UINT_TO_PTR(lpn));
 	if (!frnd)
 		return;
@@ -749,14 +722,6 @@ bool mesh_net_register_unicast(struct mesh_net *net,
 	return true;
 }
 
-uint8_t mesh_net_get_num_ele(struct mesh_net *net)
-{
-	if (!net)
-		return 0;
-
-	return net->last_addr - net->src_addr + 1;
-}
-
 bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable)
 {
 	if (!net)
@@ -3315,8 +3280,10 @@ static uint16_t get_features(struct mesh_net *net)
 
 	if (net->relay.enable)
 		features |= FEATURE_RELAY;
+
 	if (net->proxy_enable)
 		features |= FEATURE_PROXY;
+
 	if (net->friend_enable)
 		features |= FEATURE_FRIEND;
 
@@ -3553,10 +3520,9 @@ bool net_msg_check_replay_cache(struct mesh_net *net, uint16_t src,
 			l_debug("Ignoring replayed packet");
 			return true;
 		}
-	}
+	} else if (l_queue_length(net->replay_cache) >= crpl) {
+		/* SRC not in Replay Cache... see if there is space for it */
 
-	/* SRC not in Replay Cache... see if there is space for it */
-	else if (l_queue_length(net->replay_cache) >= crpl) {
 		int ret = l_queue_foreach_remove(net->replay_cache,
 				clean_old_iv_index, L_UINT_TO_PTR(iv_index));
 
diff --git a/mesh/net.h b/mesh/net.h
index f7fe3f150..7117f1a47 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -270,7 +270,6 @@ void mesh_net_set_frnd_seq(struct mesh_net *net, bool seq);
 uint16_t mesh_net_get_address(struct mesh_net *net);
 bool mesh_net_register_unicast(struct mesh_net *net,
 					uint16_t unicast, uint8_t num_ele);
-uint8_t mesh_net_get_num_ele(struct mesh_net *net);
 void net_local_beacon(uint32_t key_id, uint8_t *beacon);
 bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable);
 bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable);
@@ -310,7 +309,6 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 				uint16_t seqZero, uint32_t ack_flags);
 int mesh_net_get_identity_mode(struct mesh_net *net, uint16_t idx,
 								uint8_t *mode);
-char *mesh_net_id_name(struct mesh_net *net);
 bool mesh_net_dst_reg(struct mesh_net *net, uint16_t dst);
 bool mesh_net_dst_unreg(struct mesh_net *net, uint16_t dst);
 struct mesh_friend *mesh_friend_new(struct mesh_net *net, uint16_t dst,
-- 
2.26.2

