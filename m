Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02DC35246
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C751206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 17:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgA2RHp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:07:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:46921 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgA2RHp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jan 2020 12:07:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 09:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,378,1574150400"; 
   d="scan'208";a="314877709"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.84.27])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 09:07:42 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        rafal.gajda@silvair.com
Subject: [PATCH BlueZ v5 2/5] mesh: Move Replay Protection to mesh/net.c
Date:   Wed, 29 Jan 2020 09:07:29 -0800
Message-Id: <20200129170732.1607-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200129170732.1607-1-brian.gix@intel.com>
References: <20200129170732.1607-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The specification calls for a flatter Replay Protection List that
applies to all processed messages, regardless of which credentials
were used to secure them. So storage and checking is now centralized
in mesh/net.c
---
 mesh/appkey.c | 102 -------------------------------------------------
 mesh/appkey.h |   3 --
 mesh/model.c  |   2 +-
 mesh/net.c    | 104 +++++++++++++++++++++++++++++++++++++++++++++-----
 mesh/net.h    |   3 ++
 5 files changed, 99 insertions(+), 115 deletions(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 0eb268782..45d604007 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -35,7 +35,6 @@
 #include "mesh/appkey.h"
 
 struct mesh_app_key {
-	struct l_queue *replay_cache;
 	uint16_t net_idx;
 	uint16_t app_idx;
 	uint8_t key[16];
@@ -44,12 +43,6 @@ struct mesh_app_key {
 	uint8_t new_key_aid;
 };
 
-struct mesh_msg {
-	uint32_t iv_index;
-	uint32_t seq;
-	uint16_t src;
-};
-
 static bool match_key_index(const void *a, const void *b)
 {
 	const struct mesh_app_key *key = a;
@@ -66,103 +59,11 @@ static bool match_bound_key(const void *a, const void *b)
 	return key->net_idx == idx;
 }
 
-static bool match_replay_cache(const void *a, const void *b)
-{
-	const struct mesh_msg *msg = a;
-	uint16_t src = L_PTR_TO_UINT(b);
-
-	return src == msg->src;
-}
-
-static bool clean_old_iv_index(void *a, void *b)
-{
-	struct mesh_msg *msg = a;
-	uint32_t iv_index = L_PTR_TO_UINT(b);
-
-	if (iv_index < 2)
-		return false;
-
-	if (msg->iv_index < iv_index - 1) {
-		l_free(msg);
-		return true;
-	}
-
-	return false;
-}
-
-bool appkey_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
-				uint16_t src, uint16_t crpl, uint32_t seq,
-				uint32_t iv_index)
-{
-	struct mesh_app_key *key;
-	struct mesh_msg *msg;
-	struct l_queue *app_keys;
-
-	app_keys = mesh_net_get_app_keys(net);
-	if (!app_keys)
-		return false;
-
-	l_debug("Test Replay src: %4.4x seq: %6.6x iv: %8.8x",
-						src, seq, iv_index);
-
-	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(idx));
-
-	if (!key)
-		return false;
-
-	msg = l_queue_find(key->replay_cache, match_replay_cache,
-						L_UINT_TO_PTR(src));
-
-	if (msg) {
-		if (iv_index > msg->iv_index) {
-			msg->seq = seq;
-			msg->iv_index = iv_index;
-			return false;
-		}
-
-		if (seq < msg->seq) {
-			l_debug("Ignoring packet with lower sequence number");
-			return true;
-		}
-
-		if (seq == msg->seq) {
-			l_debug("Message already processed (duplicate)");
-			return true;
-		}
-
-		msg->seq = seq;
-
-		return false;
-	}
-
-	l_debug("New Entry for %4.4x", src);
-	if (key->replay_cache == NULL)
-		key->replay_cache = l_queue_new();
-
-	/* Replay Cache is fixed sized */
-	if (l_queue_length(key->replay_cache) >= crpl) {
-		int ret = l_queue_foreach_remove(key->replay_cache,
-				clean_old_iv_index, L_UINT_TO_PTR(iv_index));
-
-		if (!ret)
-			return true;
-	}
-
-	msg = l_new(struct mesh_msg, 1);
-	msg->src = src;
-	msg->seq = seq;
-	msg->iv_index = iv_index;
-	l_queue_push_head(key->replay_cache, msg);
-
-	return false;
-}
-
 static struct mesh_app_key *app_key_new(void)
 {
 	struct mesh_app_key *key = l_new(struct mesh_app_key, 1);
 
 	key->new_key_aid = 0xFF;
-	key->replay_cache = l_queue_new();
 	return key;
 }
 
@@ -192,7 +93,6 @@ void appkey_key_free(void *data)
 	if (!key)
 		return;
 
-	l_queue_destroy(key->replay_cache, l_free);
 	l_free(key);
 }
 
@@ -403,8 +303,6 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 	key->app_idx = app_idx;
 	l_queue_push_tail(app_keys, key);
 
-	l_queue_clear(key->replay_cache, l_free);
-
 	return MESH_STATUS_SUCCESS;
 }
 
diff --git a/mesh/appkey.h b/mesh/appkey.h
index b3e548071..23b474a0a 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -25,9 +25,6 @@ struct mesh_app_key;
 bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
 				uint8_t *key_value, uint8_t *new_key_value);
 void appkey_key_free(void *data);
-bool appkey_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
-				uint16_t src, uint16_t crpl, uint32_t seq,
-				uint32_t iv_index);
 const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
 							uint8_t *key_id);
 int appkey_get_key_idx(struct mesh_app_key *app_key,
diff --git a/mesh/model.c b/mesh/model.c
index 6d7674ee5..0018c7cff 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1000,7 +1000,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 	if (key_aid != APP_AID_DEV) {
 		uint16_t crpl = node_get_crpl(node);
 
-		if (appkey_msg_in_replay_cache(net, (uint16_t) decrypt_idx, src,
+		if (net_msg_in_replay_cache(net, (uint16_t) decrypt_idx, src,
 							crpl, seq, iv_index)) {
 			result = true;
 			goto done;
diff --git a/mesh/net.c b/mesh/net.c
index 219217793..71ff2cea0 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -135,6 +135,7 @@ struct mesh_net {
 
 	struct l_queue *subnets;
 	struct l_queue *msg_cache;
+	struct l_queue *replay_cache;
 	struct l_queue *sar_in;
 	struct l_queue *sar_out;
 	struct l_queue *frnd_msgs;
@@ -255,6 +256,12 @@ struct net_beacon_data {
 	bool processed;
 };
 
+struct mesh_rpl {
+	uint32_t iv_index;
+	uint32_t seq;
+	uint16_t src;
+};
+
 #define FAST_CACHE_SIZE 8
 static struct l_queue *fast_cache;
 static struct l_queue *nets;
@@ -554,13 +561,6 @@ static void mesh_sar_free(void *data)
 	l_free(sar);
 }
 
-static void mesh_msg_free(void *data)
-{
-	struct mesh_msg *msg = data;
-
-	l_free(msg);
-}
-
 static void subnet_free(void *data)
 {
 	struct mesh_subnet *subnet = data;
@@ -688,7 +688,8 @@ void mesh_net_free(struct mesh_net *net)
 		return;
 
 	l_queue_destroy(net->subnets, subnet_free);
-	l_queue_destroy(net->msg_cache, mesh_msg_free);
+	l_queue_destroy(net->msg_cache, l_free);
+	l_queue_destroy(net->replay_cache, l_free);
 	l_queue_destroy(net->sar_in, mesh_sar_free);
 	l_queue_destroy(net->sar_out, mesh_sar_free);
 	l_queue_destroy(net->frnd_msgs, l_free);
@@ -1024,7 +1025,7 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 
 void mesh_net_flush_msg_queues(struct mesh_net *net)
 {
-	l_queue_clear(net->msg_cache, mesh_msg_free);
+	l_queue_clear(net->msg_cache, l_free);
 }
 
 uint32_t mesh_net_get_iv_index(struct mesh_net *net)
@@ -3734,3 +3735,88 @@ uint32_t mesh_net_get_instant(struct mesh_net *net)
 
 	return net->instant;
 }
+
+static bool match_replay_cache(const void *a, const void *b)
+{
+	const struct mesh_rpl *rpe = a;
+	uint16_t src = L_PTR_TO_UINT(b);
+
+	return src == rpe->src;
+}
+
+static bool clean_old_iv_index(void *a, void *b)
+{
+	struct mesh_rpl *rpe = a;
+	uint32_t iv_index = L_PTR_TO_UINT(b);
+
+	if (iv_index < 2)
+		return false;
+
+	if (rpe->iv_index < iv_index - 1) {
+		l_free(rpe);
+		return true;
+	}
+
+	return false;
+}
+
+bool net_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
+				uint16_t src, uint16_t crpl, uint32_t seq,
+				uint32_t iv_index)
+{
+	struct mesh_rpl *rpe;
+
+	/* If anything missing reject this message by returning true */
+	if (!net || !net->node)
+		return true;
+
+	if (!net->replay_cache)
+		net->replay_cache = l_queue_new();
+
+	l_debug("Test Replay src: %4.4x seq: %6.6x iv: %8.8x",
+						src, seq, iv_index);
+
+	rpe = l_queue_find(net->replay_cache, match_replay_cache,
+						L_UINT_TO_PTR(src));
+
+	if (rpe) {
+		if (iv_index > rpe->iv_index) {
+			rpe->seq = seq;
+			rpe->iv_index = iv_index;
+			return false;
+		}
+
+		if (seq < rpe->seq) {
+			l_debug("Ignoring packet with lower sequence number");
+			return true;
+		}
+
+		if (seq == rpe->seq) {
+			l_debug("Message already processed (duplicate)");
+			return true;
+		}
+
+		rpe->seq = seq;
+
+		return false;
+	}
+
+	l_debug("New Entry for %4.4x", src);
+
+	/* Replay Cache is fixed sized */
+	if (l_queue_length(net->replay_cache) >= crpl) {
+		int ret = l_queue_foreach_remove(net->replay_cache,
+				clean_old_iv_index, L_UINT_TO_PTR(iv_index));
+
+		if (!ret)
+			return true;
+	}
+
+	rpe = l_new(struct mesh_rpl, 1);
+	rpe->src = src;
+	rpe->seq = seq;
+	rpe->iv_index = iv_index;
+	l_queue_push_head(net->replay_cache, rpe);
+
+	return false;
+}
diff --git a/mesh/net.h b/mesh/net.h
index 023b61e71..ff0a9bb2b 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -379,3 +379,6 @@ void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov);
 uint32_t mesh_net_get_instant(struct mesh_net *net);
 struct l_queue *mesh_net_get_friends(struct mesh_net *net);
 struct l_queue *mesh_net_get_negotiations(struct mesh_net *net);
+bool net_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
+				uint16_t src, uint16_t crpl, uint32_t seq,
+				uint32_t iv_index);
-- 
2.21.1

