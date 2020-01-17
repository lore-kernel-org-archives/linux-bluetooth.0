Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AAEC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 07:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436CC2073A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 07:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAQHQP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:16:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:59471 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgAQHQP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 02:16:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 23:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,329,1574150400"; 
   d="scan'208";a="373574316"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.203.31])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2020 23:16:13 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ] mesh: Offload loopback packets to l_idle_onshot()
Date:   Thu, 16 Jan 2020 23:16:04 -0800
Message-Id: <20200117071604.20675-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Any packet that may be handled internally by the daemon must be sent in
it's own idle_oneshot context, to prevent multiple nodes from handling
and responding in the same context, eventually corrupting memory.

This addresses the following crash:
Program terminated with signal SIGSEGV, Segmentation fault.
 0  tcache_get (tc_idx=0) at malloc.c:2951
     2951   tcache->entries[tc_idx] = e->next;
(gdb) bt
 0  tcache_get (tc_idx=0) at malloc.c:2951
 1  __GI___libc_malloc (bytes=bytes@entry=16) at malloc.c:3058
 2  0x0000564cff9bc1de in l_malloc (size=size@entry=16) at ell/util.c:62
 3  0x0000564cff9bd46b in l_queue_push_tail (queue=0x564d000c9710, data=data@entry=0x564d000d0d60) at ell/queue.c:136
 4  0x0000564cff9beabd in idle_add (callback=callback@entry=0x564cff9be4e0 <oneshot_callback>, user_data=user_data@entry=0x564d000d4700,
    flags=flags@entry=268435456, destroy=destroy@entry=0x564cff9be4c0 <idle_destroy>) at ell/main.c:292
 5  0x0000564cff9be5f7 in l_idle_oneshot (callback=callback@entry=0x564cff998bc0 <tx_worker>, user_data=user_data@entry=0x564d000d83f0,
    destroy=destroy@entry=0x0) at ell/idle.c:144
 6  0x0000564cff998326 in send_tx (io=<optimized out>, info=0x7ffd035503f4, data=<optimized out>, len=<optimized out>)
    at mesh/mesh-io-generic.c:637
 7  0x0000564cff99675a in send_network_beacon (key=0x564d000cfee0) at mesh/net-keys.c:355
 8  snb_timeout (timeout=0x564d000dd730, user_data=0x564d000cfee0) at mesh/net-keys.c:364
 9  0x0000564cff9bdca2 in timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0x564d000dd730) at ell/timeout.c:81
 10 timeout_callback (fd=<optimized out>, events=<optimized out>, user_data=0x564d000dd730) at ell/timeout.c:70
 11 0x0000564cff9bedcd in l_main_iterate (timeout=<optimized out>) at ell/main.c:473
 12 0x0000564cff9bee7c in l_main_run () at ell/main.c:520
 13 l_main_run () at ell/main.c:502
 14 0x0000564cff9bf08c in l_main_run_with_signal (callback=<optimized out>, user_data=0x0) at ell/main.c:642
 15 0x0000564cff994b64 in main (argc=<optimized out>, argv=0x7ffd03550668) at mesh/main.c:268
---
 mesh/net.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 35388beec..219217793 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -241,6 +241,12 @@ struct net_queue_data {
 	bool seen;
 };
 
+struct oneshot_tx {
+	struct mesh_net *net;
+	uint8_t size;
+	uint8_t packet[30];
+};
+
 struct net_beacon_data {
 	uint32_t key_id;
 	uint32_t ivi;
@@ -2247,24 +2253,35 @@ static void send_relay_pkt(struct mesh_net *net, uint8_t *data, uint8_t size)
 	mesh_io_send(io, &info, packet, size + 1);
 }
 
-static void send_msg_pkt(struct mesh_net *net, uint8_t *packet, uint8_t size)
+static bool simple_match(const void *a, const void *b)
 {
-	struct mesh_io *io = net->io;
+	return a == b;
+}
+
+static void send_msg_pkt_oneshot(void *user_data)
+{
+	struct oneshot_tx *tx = user_data;
+	struct mesh_net *net;
 	struct mesh_io_send_info info;
 	struct net_queue_data net_data = {
 		.info = NULL,
-		.data = packet + 1,
-		.len = size - 1,
+		.data = tx->packet + 1,
+		.len = tx->size - 1,
 		.relay_advice = RELAY_NONE,
 	};
 
 	/* Send to local nodes first */
 	l_queue_foreach(nets, net_rx, &net_data);
 
-	if (net_data.relay_advice == RELAY_DISALLOWED)
+	/* Make sure specific network still valid */
+	net = l_queue_find(nets, simple_match, tx->net);
+
+	if (!net || net_data.relay_advice == RELAY_DISALLOWED) {
+		l_free(tx);
 		return;
+	}
 
-	packet[0] = MESH_AD_TYPE_NETWORK;
+	tx->packet[0] = MESH_AD_TYPE_NETWORK;
 	info.type = MESH_IO_TIMING_TYPE_GENERAL;
 	info.u.gen.interval = net->tx_interval;
 	info.u.gen.cnt = net->tx_cnt;
@@ -2272,7 +2289,19 @@ static void send_msg_pkt(struct mesh_net *net, uint8_t *packet, uint8_t size)
 	/* No extra randomization when sending regular mesh messages */
 	info.u.gen.max_delay = DEFAULT_MIN_DELAY;
 
-	mesh_io_send(io, &info, packet, size);
+	mesh_io_send(net->io, &info, tx->packet, tx->size);
+	l_free(tx);
+}
+
+static void send_msg_pkt(struct mesh_net *net, uint8_t *packet, uint8_t size)
+{
+	struct oneshot_tx *tx = l_new(struct oneshot_tx, 1);
+
+	tx->net = net;
+	tx->size = size;
+	memcpy(tx->packet, packet, size);
+
+	l_idle_oneshot(send_msg_pkt_oneshot, tx, NULL);
 }
 
 static enum _relay_advice packet_received(void *user_data,
@@ -2847,11 +2876,6 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 	return true;
 }
 
-static bool is_this_net(const void *a, const void *b)
-{
-	return a == b;
-}
-
 bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 {
 	bool first;
@@ -2874,7 +2898,7 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 							net_msg_recv, NULL);
 	}
 
-	if (l_queue_find(nets, is_this_net, net))
+	if (l_queue_find(nets, simple_match, net))
 		return false;
 
 	l_queue_push_head(nets, net);
-- 
2.21.1

