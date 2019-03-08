Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5988AC43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 21:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2737F20851
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 21:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCHVve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:51:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:19665 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCHVve (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 16:51:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 13:51:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132495086"
Received: from bgix-dell-lap.sea.intel.com ([10.251.136.138])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2019 13:51:33 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Enable local loop-back
Date:   Fri,  8 Mar 2019 13:51:24 -0800
Message-Id: <20190308215124.26140-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Messgaes sent from one local node to another don't need
to be relayed by an external node.
---
 mesh/net.c | 51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 2adae70c3..b173e1c09 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -254,10 +254,24 @@ struct net_decode {
 	bool proxy;
 };
 
+struct net_queue_data {
+	struct mesh_io_recv_info *info;
+	struct mesh_net *net;
+	const uint8_t *data;
+	uint8_t *out;
+	size_t out_size;
+	enum _relay_advice relay_advice;
+	uint32_t key_id;
+	uint32_t iv_index;
+	uint16_t len;
+};
+
 #define FAST_CACHE_SIZE 8
 static struct l_queue *fast_cache;
 static struct l_queue *nets;
 
+static void net_rx(void *net_ptr, void *user_data);
+
 static inline struct mesh_subnet *get_primary_subnet(struct mesh_net *net)
 {
 	return l_queue_peek_head(net->subnets);
@@ -2267,16 +2281,27 @@ static void send_relay_pkt(struct mesh_net *net, uint8_t *data, uint8_t size)
 static void send_msg_pkt(struct mesh_net *net, uint8_t *packet, uint8_t size)
 {
 	struct mesh_io *io = net->io;
-	struct mesh_io_send_info info = {
-		.type = MESH_IO_TIMING_TYPE_GENERAL,
-		.u.gen.interval = net->tx_interval,
-		.u.gen.cnt = net->tx_cnt,
-		.u.gen.min_delay = DEFAULT_MIN_DELAY,
-		/* No extra randomization when sending regular mesh messages */
-		.u.gen.max_delay = DEFAULT_MIN_DELAY
+	struct mesh_io_send_info info;
+	struct net_queue_data net_data = {
+		.info = NULL,
+		.data = packet + 1,
+		.len = size - 1,
+		.relay_advice = RELAY_NONE,
 	};
 
+	/* Send to local nodes first */
+	l_queue_foreach(nets, net_rx, &net_data);
+
+	if (net_data.relay_advice == RELAY_DISALLOWED)
+		return;
+
 	packet[0] = MESH_AD_TYPE_NETWORK;
+	info.type = MESH_IO_TIMING_TYPE_GENERAL;
+	info.u.gen.interval = net->tx_interval;
+	info.u.gen.cnt = net->tx_cnt;
+	info.u.gen.min_delay = DEFAULT_MIN_DELAY;
+	/* No extra randomization when sending regular mesh messages */
+	info.u.gen.max_delay = DEFAULT_MIN_DELAY;
 
 	mesh_io_send(io, &info, packet, size);
 }
@@ -2461,18 +2486,6 @@ static enum _relay_advice packet_received(void *user_data,
 		return RELAY_NONE;
 }
 
-struct net_queue_data {
-	struct mesh_io_recv_info *info;
-	struct mesh_net *net;
-	const uint8_t *data;
-	uint8_t *out;
-	size_t out_size;
-	enum _relay_advice relay_advice;
-	uint32_t key_id;
-	uint32_t iv_index;
-	uint16_t len;
-};
-
 static void net_rx(void *net_ptr, void *user_data)
 {
 	struct net_queue_data *data = user_data;
-- 
2.14.5

