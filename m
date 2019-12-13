Return-Path: <SRS0=edj+=2D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F18EC4D2ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908542477D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfLMUP2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:15:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:63270 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbfLMUP2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Dec 2019 15:15:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 12:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="208566072"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.70.3])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2019 12:15:25 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2] mesh: Refactor Secure Network Beaconing
Date:   Fri, 13 Dec 2019 12:15:05 -0800
Message-Id: <20191213201505.32480-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The daemon handles multiple nodes, that may or may not be on the same
mesh network.  While each node my be seperately configured to beacon or
not beacon, there is nothing gained (except redundent traffic) for each
node to beacon seperately.  Beaconing is therefore centralized with the
Network Key the SNB represents, with each *received* beacon delivered
to each node. But for SNBs generated, we keep a count of how many nodes
want beacons sent for a specific key. If 1 or more, we beacon, if 0
nodes want the beacon sent, then we do not beacon.
---
 mesh/mesh-io.c  |   3 +
 mesh/net-keys.c | 204 +++++++++++++++++++++++++++-
 mesh/net-keys.h |   8 ++
 mesh/net.c      | 350 ++++++++++++++++--------------------------------
 mesh/net.h      |   3 +
 5 files changed, 326 insertions(+), 242 deletions(-)

diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 95a99b6a5..1ab173d9c 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -171,6 +171,9 @@ bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
 {
 	io = l_queue_find(io_list, match_by_io, io);
 
+	if (!io)
+		io = l_queue_peek_head(io_list);
+
 	if (io && io->api && io->api->send)
 		return io->api->send(io, info, data, len);
 
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 5be7e0b58..65f0808dd 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -23,16 +23,35 @@
 
 #include <ell/ell.h>
 
+#include "mesh/mesh-defs.h"
+#include "mesh/util.h"
 #include "mesh/crypto.h"
+#include "mesh/mesh-io.h"
+#include "mesh/net.h"
 #include "mesh/net-keys.h"
 
 #define BEACON_TYPE_SNB		0x01
 #define KEY_REFRESH		0x01
 #define IV_INDEX_UPDATE		0x02
 
+#define BEACON_INTERVAL_MIN	10
+#define BEACON_INTERVAL_MAX	600
+
+struct net_beacon {
+	struct l_timeout *timeout;
+	uint32_t ts;
+	uint16_t observe_period;
+	uint16_t observed;
+	uint16_t expected;
+	bool half_period;
+	uint8_t beacon[23];
+};
+
 struct net_key {
 	uint32_t id;
+	struct net_beacon snb;
 	uint16_t ref_cnt;
+	uint16_t beacon_enables;
 	uint8_t friend_key;
 	uint8_t nid;
 	uint8_t master[16];
@@ -157,6 +176,7 @@ void net_key_unref(uint32_t id)
 
 	if (key && key->ref_cnt) {
 		if (--key->ref_cnt == 0) {
+			l_timeout_remove(key->snb.timeout);
 			l_queue_remove(keys, key);
 			l_free(key);
 		}
@@ -305,18 +325,188 @@ bool net_key_snb_compose(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 		return false;
 	}
 
-	snb[0] = BEACON_TYPE_SNB;
-	snb[1] = 0;
+	snb[0] = MESH_AD_TYPE_BEACON;
+	snb[1] = BEACON_TYPE_SNB;
+	snb[2] = 0;
 
 	if (kr)
-		snb[1] |= KEY_REFRESH;
+		snb[2] |= KEY_REFRESH;
 
 	if (ivu)
-		snb[1] |= IV_INDEX_UPDATE;
+		snb[2] |= IV_INDEX_UPDATE;
 
-	memcpy(snb + 2, key->network, 8);
-	l_put_be32(iv_index, snb + 10);
-	l_put_be64(cmac, snb + 14);
+	memcpy(snb + 3, key->network, 8);
+	l_put_be32(iv_index, snb + 11);
+	l_put_be64(cmac, snb + 15);
 
 	return true;
 }
+
+static void send_network_beacon(struct net_key *key)
+{
+	struct mesh_io_send_info info = {
+		.type = MESH_IO_TIMING_TYPE_GENERAL,
+		.u.gen.interval = 100,
+		.u.gen.cnt = 1,
+		.u.gen.min_delay = DEFAULT_MIN_DELAY,
+		.u.gen.max_delay = DEFAULT_MAX_DELAY
+	};
+
+	mesh_io_send(NULL, &info, key->snb.beacon, sizeof(key->snb.beacon));
+}
+
+static void snb_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct net_key *key = user_data;
+	uint32_t interval, scale_factor;
+
+	/* Always send at least one beacon */
+	send_network_beacon(key);
+
+	/* Count our own beacons towards the vicinity total */
+	key->snb.observed++;
+
+	if (!key->snb.half_period) {
+
+		l_debug("beacon %d for %d nodes, period %d, obs %d, exp %d",
+						key->id,
+						key->beacon_enables,
+						key->snb.observe_period,
+						key->snb.observed,
+						key->snb.expected);
+
+
+		interval = (key->snb.observe_period * key->snb.observed)
+							/ key->snb.expected;
+
+		/* Limit Increases and Decreases by 10 seconds Up and
+		 * 20 seconds down each step, to avoid going nearly silent
+		 * in highly populated environments.
+		 */
+		if (interval - 10 > key->snb.observe_period)
+			interval = key->snb.observe_period + 10;
+		else if (interval + 20 < key->snb.observe_period)
+			interval = key->snb.observe_period - 20;
+
+		/* Beaconing must be no *slower* than once every 10 minutes,
+		 * and no *faster* than once every 10 seconds, per spec.
+		 * Observation period is twice beaconing period.
+		 */
+		if (interval < BEACON_INTERVAL_MIN * 2)
+			interval = BEACON_INTERVAL_MIN * 2;
+		else if (interval > BEACON_INTERVAL_MAX * 2)
+			interval = BEACON_INTERVAL_MAX * 2;
+
+		key->snb.observe_period = interval;
+		key->snb.observed = 0;
+
+		/* To prevent "over slowing" of the beaconing frequency,
+		 * require more significant "over observing" the slower
+		 * our own beaconing frequency.
+		 */
+		key->snb.expected = interval / 10;
+		scale_factor = interval / 60;
+		key->snb.expected += scale_factor * 3;
+	}
+
+	interval = key->snb.observe_period / 2;
+	key->snb.ts = get_timestamp_secs();
+	key->snb.half_period = !key->snb.half_period;
+
+	if (key->beacon_enables)
+		l_timeout_modify(timeout, interval);
+	else {
+		l_timeout_remove(timeout);
+		key->snb.timeout = NULL;
+	}
+}
+
+void net_key_beacon_seen(uint32_t id)
+{
+	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
+
+	if (key)
+		key->snb.observed++;
+}
+
+void net_key_beacon_enable(uint32_t id)
+{
+	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
+	bool enabled;
+	uint32_t rand_ms;
+
+	if (!key)
+		return;
+
+	enabled = !!key->beacon_enables;
+	key->beacon_enables++;
+
+	/* If already Enabled, do nothing */
+	if (enabled)
+		return;
+
+	/* Randomize first timeout to avoid bursts of beacons */
+	l_getrandom(&rand_ms, sizeof(rand_ms));
+	rand_ms %= (BEACON_INTERVAL_MIN * 1000);
+	rand_ms++;
+
+	/* Enable Periodic Beaconing on this key */
+	key->snb.ts = get_timestamp_secs();
+	key->snb.observe_period = BEACON_INTERVAL_MIN * 2;
+	key->snb.expected = 2;
+	key->snb.observed = 0;
+	key->snb.half_period = true;
+	l_timeout_remove(key->snb.timeout);
+	key->snb.timeout = l_timeout_create_ms(rand_ms, snb_timeout, key, NULL);
+}
+
+bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu)
+{
+	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
+	uint8_t beacon[23];
+	uint32_t rand_ms;
+
+	if (!key)
+		return false;
+
+	if (!net_key_snb_compose(id, iv_index, kr, ivu, beacon))
+		return false;
+
+	if (memcmp(key->snb.beacon, beacon, sizeof(beacon)))
+		memcpy(key->snb.beacon, beacon, sizeof(beacon));
+	else
+		return false;
+
+	l_debug("Setting SNB: IVI: %8.8x, IVU: %d, KR: %d", iv_index, ivu, kr);
+	print_packet("Set SNB Beacon to", beacon, sizeof(beacon));
+
+	/* Send one new SNB soon, after all nodes have seen it */
+	l_getrandom(&rand_ms, sizeof(rand_ms));
+	rand_ms %= 1000;
+	key->snb.expected++;
+
+	if (key->snb.timeout)
+		l_timeout_modify_ms(key->snb.timeout, 500 + rand_ms);
+	else
+		key->snb.timeout = l_timeout_create_ms(500 + rand_ms,
+						snb_timeout, key, NULL);
+
+	return true;
+}
+
+void net_key_beacon_disable(uint32_t id)
+{
+	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
+
+	if (!key || !key->beacon_enables)
+		return;
+
+	key->beacon_enables--;
+
+	if (key->beacon_enables)
+		return;
+
+	/* Disable periodic Beaconing on this key */
+	l_timeout_remove(key->snb.timeout);
+	key->snb.timeout = NULL;
+}
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index d54c52156..3c2c4d0da 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -17,6 +17,10 @@
  *
  */
 
+#define BEACON_TYPE_SNB		0x01
+#define KEY_REFRESH		0x01
+#define IV_INDEX_UPDATE		0x02
+
 bool net_key_confirm(uint32_t id, const uint8_t master[16]);
 bool net_key_retrieve(uint32_t id, uint8_t *master);
 uint32_t net_key_add(const uint8_t master[16]);
@@ -31,3 +35,7 @@ bool net_key_snb_check(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 								uint64_t cmac);
 bool net_key_snb_compose(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 								uint8_t *snb);
+void net_key_beacon_seen(uint32_t id);
+void net_key_beacon_enable(uint32_t id);
+bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu);
+void net_key_beacon_disable(uint32_t id);
diff --git a/mesh/net.c b/mesh/net.c
index f662d8a91..e708b2aa4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -53,15 +53,9 @@
 #define SEG_TO	2
 #define MSG_TO	60
 
-#define DEFAULT_MIN_DELAY		0
-#define DEFAULT_MAX_DELAY		25
-
 #define DEFAULT_TRANSMIT_COUNT		1
 #define DEFAULT_TRANSMIT_INTERVAL	100
 
-#define BEACON_INTERVAL_MIN	10
-#define BEACON_INTERVAL_MAX	600
-
 #define SAR_KEY(src, seq0)	((((uint32_t)(seq0)) << 16) | (src))
 
 enum _relay_advice {
@@ -90,23 +84,12 @@ struct net_key {
 	uint8_t network_id[8];
 };
 
-struct mesh_beacon {
-	struct l_timeout *timeout;
-	uint32_t ts;
-	uint16_t observe_period;
-	uint16_t observed;
-	uint16_t expected;
-	uint8_t half_period;
-	uint8_t beacon[23];
-};
-
 struct mesh_subnet {
 	struct mesh_net *net;
 	uint16_t idx;
 	uint32_t net_key_tx;
 	uint32_t net_key_cur;
 	uint32_t net_key_upd;
-	struct mesh_beacon snb;
 	uint8_t key_refresh;
 	uint8_t kr_phase;
 };
@@ -260,8 +243,11 @@ struct net_queue_data {
 };
 
 struct net_beacon_data {
-	const uint8_t *data;
-	uint16_t len;
+	uint32_t key_id;
+	uint32_t ivi;
+	bool ivu;
+	bool kr;
+	bool processed;
 };
 
 #define FAST_CACHE_SIZE 8
@@ -570,9 +556,6 @@ static void subnet_free(void *data)
 	l_free(subnet);
 }
 
-static void lpn_process_beacon(void *user_data, const void *data, uint8_t size,
-								int8_t rssi);
-
 static struct mesh_subnet *subnet_new(struct mesh_net *net, uint16_t idx)
 {
 	struct mesh_subnet *subnet;
@@ -583,93 +566,71 @@ static struct mesh_subnet *subnet_new(struct mesh_net *net, uint16_t idx)
 
 	subnet->net = net;
 	subnet->idx = idx;
-	subnet->snb.beacon[0] = MESH_AD_TYPE_BEACON;
 	return subnet;
 }
 
-static bool create_secure_beacon(struct mesh_net *net,
-					struct mesh_subnet *subnet,
-					uint8_t *beacon_data)
+static void enable_beacon(void *a, void *b)
 {
-	bool kr = (subnet->kr_phase == KEY_REFRESH_PHASE_TWO);
+	struct mesh_subnet *subnet = a;
+	struct mesh_net *net = b;
 
-	return net_key_snb_compose(subnet->net_key_tx, net->iv_index,
-					kr, net->iv_update, beacon_data);
+	if (net->beacon_enable)
+		net_key_beacon_enable(subnet->net_key_tx);
+	else
+		net_key_beacon_disable(subnet->net_key_tx);
 }
 
-static void send_network_beacon(struct mesh_subnet *subnet,
-							struct mesh_net *net)
+static void enqueue_update(void *a, void *b);
+
+static void queue_friend_update(struct mesh_net *net)
 {
-	struct mesh_io_send_info info = {
-		.type = MESH_IO_TIMING_TYPE_GENERAL,
-		.u.gen.interval = net->tx_interval,
-		.u.gen.cnt = 1,
-		.u.gen.min_delay = DEFAULT_MIN_DELAY,
-		.u.gen.max_delay = DEFAULT_MAX_DELAY
-	};
+	struct mesh_subnet *subnet;
+	struct mesh_friend *frnd;
+	uint8_t flags = 0;
 
-	l_info("Send SNB on network %3.3x", subnet->idx);
-	mesh_io_send(net->io, &info, subnet->snb.beacon,
-						sizeof(subnet->snb.beacon));
-}
+	if (l_queue_length(net->friends)) {
+		struct mesh_friend_msg update = {
+			.src = net->src_addr,
+			.iv_index = mesh_net_get_iv_index(net),
+			.last_len = 7,
+			.ctl = true,
+		};
 
-static void network_beacon_timeout(struct l_timeout *timeout, void *user_data)
-{
-	struct mesh_subnet *subnet = user_data;
-	uint32_t interval;
+		frnd = l_queue_peek_head(net->friends);
+		subnet = l_queue_find(net->subnets, match_key_index,
+						L_UINT_TO_PTR(frnd->net_idx));
 
-	send_network_beacon(subnet, subnet->net);
+		if (!subnet)
+			return;
 
-	if (!subnet->snb.half_period) {
-		l_debug("beacon TO period %d, observed %d, expected %d",
-						subnet->snb.observe_period,
-						subnet->snb.observed,
-						subnet->snb.expected);
-		interval = subnet->snb.observe_period *
-			(subnet->snb.observed + 1) / subnet->snb.expected;
-		subnet->snb.observe_period = interval * 2;
-		subnet->snb.expected = subnet->snb.observe_period / 10;
-		subnet->snb.observed = 0;
-	} else
-		interval = subnet->snb.observe_period / 2;
+		if (subnet->kr_phase == KEY_REFRESH_PHASE_TWO)
+			flags |= KEY_REFRESH;
 
-	if (interval < BEACON_INTERVAL_MIN)
-		interval = BEACON_INTERVAL_MIN;
+		if (net->iv_update)
+			flags |= IV_INDEX_UPDATE;
 
-	if (interval > BEACON_INTERVAL_MAX)
-		interval = BEACON_INTERVAL_MAX;
+		update.u.one[0].hdr = NET_OP_FRND_UPDATE << OPCODE_HDR_SHIFT;
+		update.u.one[0].seq = mesh_net_next_seq_num(net);
+		update.u.one[0].data[0] = NET_OP_FRND_UPDATE;
+		update.u.one[0].data[1] = flags;
+		l_put_be32(net->iv_index, update.u.one[0].data + 2);
+		update.u.one[0].data[6] = 0x01; /* More Data */
+		/* print_packet("Frnd-Beacon-SRC",
+		 *			beacon_data, sizeof(beacon_data));
+		 */
+		/* print_packet("Frnd-Update", update.u.one[0].data, 6); */
 
-	subnet->snb.ts = get_timestamp_secs();
-	subnet->snb.half_period ^= 1;
-	l_timeout_modify(timeout, interval);
+		l_queue_foreach(net->friends, enqueue_update, &update);
+	}
 }
 
-static void start_network_beacon(void *a, void *b)
+static void refresh_beacon(void *a, void *b)
 {
 	struct mesh_subnet *subnet = a;
 	struct mesh_net *net = b;
 
-	if (!net->beacon_enable) {
-		if (subnet->snb.timeout)
-			l_timeout_remove(subnet->snb.timeout);
-		subnet->snb.timeout = NULL;
-		return;
-	}
-
-	/* If timeout is active, let it run it's course */
-	if (subnet->snb.timeout)
-		return;
-
-	send_network_beacon(subnet, subnet->net);
-
-	subnet->snb.ts = get_timestamp_secs();
-	subnet->snb.expected = 2;
-	subnet->snb.observed = 0;
-	subnet->snb.half_period = 1;
-	subnet->snb.observe_period = BEACON_INTERVAL_MIN * 2;
-
-	subnet->snb.timeout = l_timeout_create(BEACON_INTERVAL_MIN,
-				network_beacon_timeout, subnet, NULL);
+	net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
+		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update);
 }
 
 struct mesh_net *mesh_net_new(struct mesh_node *node)
@@ -1005,10 +966,11 @@ static struct mesh_subnet *add_key(struct mesh_net *net, uint16_t idx,
 		return NULL;
 	}
 
-	if (!create_secure_beacon(net, subnet, subnet->snb.beacon + 1)) {
-		subnet_free(subnet);
-		return NULL;
-	}
+	net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
+						false, net->iv_update);
+
+	if (net->beacon_enable)
+		net_key_beacon_enable(subnet->net_key_tx);
 
 	l_queue_push_tail(net->subnets, subnet);
 
@@ -1043,9 +1005,6 @@ int mesh_net_add_key(struct mesh_net *net, uint16_t idx, const uint8_t *value)
 		return MESH_STATUS_STORAGE_FAIL;
 	}
 
-	if (net->io)
-		start_network_beacon(subnet, net);
-
 	return MESH_STATUS_SUCCESS;
 }
 
@@ -1072,11 +1031,11 @@ void mesh_net_get_snb_state(struct mesh_net *net, uint8_t *flags,
 		return;
 
 	*iv_index = net->iv_index;
-	*flags = (net->iv_upd_state == IV_UPD_UPDATING) ? 0x02 : 0x00;
+	*flags = net->iv_update ? IV_INDEX_UPDATE : 0x00;
 
 	subnet = get_primary_subnet(net);
 	if (subnet)
-		*flags |= subnet->key_refresh ? 0x01 : 0x00;
+		*flags |= subnet->key_refresh ? KEY_REFRESH : 0x00;
 }
 
 bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
@@ -2117,14 +2076,6 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
 						L_UINT_TO_PTR(src)));
 		break;
 
-	case NET_OP_FRND_UPDATE:
-		if (ttl)
-			return false;
-
-		print_packet("Rx-NET_OP_FRND_UPDATE", pkt, len);
-		lpn_process_beacon(net, pkt, len, 0);
-		break;
-
 	case NET_OP_FRND_REQUEST:
 		if (!net->friend_enable)
 			return false;
@@ -2539,50 +2490,6 @@ static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
 	}
 }
 
-static void set_network_beacon(void *a, void *b)
-{
-	struct mesh_subnet *subnet = a;
-	struct mesh_net *net = b;
-	uint8_t beacon_data[22];
-
-	if (!create_secure_beacon(net, subnet, beacon_data))
-		return;
-
-	if (memcmp(&subnet->snb.beacon[1], beacon_data,
-						sizeof(beacon_data)) == 0)
-		return;
-
-	memcpy(&subnet->snb.beacon[1], beacon_data, sizeof(beacon_data));
-
-	if (net->beacon_enable && !net->friend_addr) {
-		print_packet("Set My Beacon to",
-			beacon_data, sizeof(beacon_data));
-		start_network_beacon(subnet, net);
-	}
-
-	if (l_queue_length(net->friends)) {
-		struct mesh_friend_msg update = {
-			.src = net->src_addr,
-			.iv_index = mesh_net_get_iv_index(net),
-			.last_len = 7,
-			.ctl = true,
-		};
-
-		update.u.one[0].hdr = NET_OP_FRND_UPDATE << OPCODE_HDR_SHIFT;
-		update.u.one[0].seq = mesh_net_next_seq_num(net);
-		update.u.one[0].data[0] = NET_OP_FRND_UPDATE;
-		update.u.one[0].data[1] = beacon_data[3];
-		l_put_be32(net->iv_index, update.u.one[0].data + 2);
-		update.u.one[0].data[6] = 0x01; /* More Data */
-		/* print_packet("Frnd-Beacon-SRC",
-		 *			beacon_data, sizeof(beacon_data));
-		 */
-		/* print_packet("Frnd-Update", update.u.one[0].data, 6); */
-
-		l_queue_foreach(net->friends, enqueue_update, &update);
-	}
-}
-
 static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
@@ -2604,7 +2511,8 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 		net->iv_update = false;
 		mesh_config_write_iv_index(node_config_get(net->node),
 							net->iv_index, false);
-		l_queue_foreach(net->subnets, set_network_beacon, net);
+		l_queue_foreach(net->subnets, refresh_beacon, net);
+		queue_friend_update(net);
 		mesh_net_flush_msg_queues(net);
 		break;
 
@@ -2646,7 +2554,8 @@ static int key_refresh_phase_two(struct mesh_net *net, uint16_t idx)
 	 * it hears beacons from all the nodes
 	 */
 	subnet->kr_phase = KEY_REFRESH_PHASE_TWO;
-	set_network_beacon(subnet, net);
+	refresh_beacon(subnet, net);
+	queue_friend_update(net);
 
 	l_queue_foreach(net->friends, frnd_kr_phase2, net);
 
@@ -2679,7 +2588,8 @@ static int key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	subnet->net_key_upd = 0;
 	subnet->key_refresh = 0;
 	subnet->kr_phase = KEY_REFRESH_PHASE_NONE;
-	set_network_beacon(subnet, net);
+	refresh_beacon(subnet, net);
+	queue_friend_update(net);
 
 	l_queue_foreach(net->friends, frnd_kr_phase3, net);
 
@@ -2771,106 +2681,73 @@ static void update_iv_ivu_state(struct mesh_net *net, uint32_t iv_index,
 static void process_beacon(void *net_ptr, void *user_data)
 {
 	struct mesh_net *net = net_ptr;
-	const uint8_t *buf = *(uint8_t **)user_data;
+	struct net_beacon_data *beacon_data = user_data;
 	uint32_t ivi;
 	bool ivu, kr, local_kr;
 	struct mesh_subnet *subnet;
-	uint32_t key_id;
 
-	ivi = l_get_be32(buf + 10);
+	ivi = beacon_data->ivi;
 
 	/* Ignore out-of-range IV_Index for this network */
 	if ((net->iv_index + IV_IDX_DIFF_RANGE < ivi) || (ivi < net->iv_index))
 		return;
 
-	/* Ignore Network IDs unknown to this mesh universe */
-	key_id = net_key_network_id(buf + 2);
-	if (!key_id)
-		return;
-
+	/* Ignore beacons not in this universe */
 	subnet = l_queue_find(net->subnets, match_key_id,
-							L_UINT_TO_PTR(key_id));
+					L_UINT_TO_PTR(beacon_data->key_id));
+
 	if (!subnet)
 		return;
 
 	/* Get IVU and KR boolean bits from beacon */
-	ivu = !!(buf[1] & 0x02);
-	kr = !!(buf[1] & 0x01);
-	local_kr = !!(subnet->kr_phase != KEY_REFRESH_PHASE_TWO);
-
-	if (net->iv_upd_state != IV_UPD_INIT) {
-		/* Ignore beacons that indicate *no change* */
-		if (!memcmp(&subnet->snb.beacon[1], buf, 22)) {
-			subnet->snb.observed++;
-			return;
-		}
-	}
-
-	/* Validate beacon before accepting */
-	if (!net_key_snb_check(key_id, ivi, kr, ivu, l_get_be64(buf + 14))) {
-		l_error("mesh_crypto_beacon verify failed");
-		return;
-	}
+	ivu = beacon_data->ivu;
+	kr = beacon_data->kr;
+	local_kr = !!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO);
 
 	/* We have officially *seen* this beacon now */
-	subnet->snb.observed++;
-
-	update_iv_ivu_state(net, ivi, ivu);
-	update_kr_state(subnet, kr, key_id);
-
-	if (ivi != net->iv_index || ivu != net->iv_update || kr != local_kr)
-		set_network_beacon(subnet, net);
-}
-
-static void lpn_process_beacon(void *user_data, const void *data,
-						uint8_t size, int8_t rssi)
-{
-	struct mesh_net *net = user_data;
-	const uint8_t *buf = data;
-	uint32_t ivi;
-	bool ivu, kr, local_kr;
-	struct mesh_subnet *subnet;
-	bool kr_transition = false;
-
-	/* print_packet("lpn: Secure Net Beacon RXed", data, size); */
-	kr = !!(buf[0] & 0x01);
-	ivu = !!(buf[0] & 0x02);
-	ivi = l_get_be32(buf + 1);
-
-	l_debug("KR: %d -- IVU: %d -- IVI: %8.8x", kr, ivu, ivi);
-
-	/* TODO: figure out actual network index (i.e., friendship subnet) */
-	subnet = get_primary_subnet(net);
-	if (!subnet)
-		return;
-
-	local_kr = (subnet->kr_phase == KEY_REFRESH_PHASE_TWO);
+	beacon_data->processed = true;
 
-	/* Don't bother going further if nothing has changed */
-	if (local_kr == kr && ivi == net->iv_index && ivu == net->iv_update &&
-					net->iv_upd_state != IV_UPD_INIT)
+	if (ivi == net->iv_index && ivu == net->iv_update && kr == local_kr)
 		return;
 
 	update_iv_ivu_state(net, ivi, ivu);
-
-	if (kr)
-		update_kr_state(subnet, kr_transition, subnet->net_key_upd);
-	else
-		update_kr_state(subnet, kr_transition, subnet->net_key_cur);
+	update_kr_state(subnet, kr, beacon_data->key_id);
+	net_key_beacon_refresh(beacon_data->key_id, net->iv_index,
+		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update);
 }
 
 static void beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len)
 {
-	const uint8_t *ptr = data + 1;
+	struct net_beacon_data beacon_data = {
+		.processed = false,
+	};
 
 	if (len != 23 || data[1] != 0x01)
 		return;
 
-	l_debug("KR: %d -- IVU: %d -- IV: %8.8x",
-			data[2] & 1, !!(data[2] & 2), l_get_be32(data + 11));
+	/* Ignore Network IDs unknown to this daemon */
+	beacon_data.key_id = net_key_network_id(data + 3);
+	if (!beacon_data.key_id)
+		return;
+
+	/* Get data bits from beacon */
+	beacon_data.ivu = !!(data[2] & 0x02);
+	beacon_data.kr = !!(data[2] & 0x01);
+	beacon_data.ivi = l_get_be32(data + 11);
 
-	l_queue_foreach(nets, process_beacon, &ptr);
+	/* Validate beacon before accepting */
+	if (!net_key_snb_check(beacon_data.key_id, beacon_data.ivi,
+					beacon_data.kr, beacon_data.ivu,
+					l_get_be64(data + 15))) {
+		l_error("mesh_crypto_beacon verify failed");
+		return;
+	}
+
+	l_queue_foreach(nets, process_beacon, &beacon_data);
+
+	if (beacon_data.processed)
+		net_key_beacon_seen(beacon_data.key_id);
 }
 
 bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable)
@@ -2878,16 +2755,16 @@ bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable)
 	if (!net || !IS_UNASSIGNED(net->friend_addr))
 		return false;
 
-	if (net->beacon_enable != enable) {
-		uint8_t type = MESH_AD_TYPE_BEACON;
+	if (net->beacon_enable == enable)
+		return true;
 
-		net->beacon_enable = enable;
+	net->beacon_enable = enable;
 
-		if (!enable)
-			mesh_io_send_cancel(net->io, &type, 1);
+	if (enable)
+		l_queue_foreach(net->subnets, refresh_beacon, net);
 
-		l_queue_foreach(net->subnets, start_network_beacon, net);
-	}
+	l_queue_foreach(net->subnets, enable_beacon, net);
+	queue_friend_update(net);
 
 	return true;
 }
@@ -2923,14 +2800,18 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 	if (phase == KEY_REFRESH_PHASE_TWO) {
 		subnet->key_refresh = 1;
 		subnet->net_key_tx = subnet->net_key_upd;
+		if (net->beacon_enable) {
+			/* Switch beaconing key */
+			net_key_beacon_disable(subnet->net_key_cur);
+			net_key_beacon_enable(subnet->net_key_upd);
+		}
 	}
 
 	subnet->kr_phase = phase;
 
-	set_network_beacon(subnet, net);
+	net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
+		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update);
 
-	if (net->io)
-		start_network_beacon(subnet, net);
 
 	return true;
 }
@@ -2960,7 +2841,6 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 							beacon_recv, NULL);
 		mesh_io_register_recv_cb(io, MESH_IO_FILTER_NET,
 							net_msg_recv, NULL);
-		l_queue_foreach(net->subnets, start_network_beacon, net);
 	}
 
 	if (l_queue_find(nets, is_this_net, net))
@@ -3007,7 +2887,8 @@ bool mesh_net_iv_index_update(struct mesh_net *net)
 	net->iv_upd_state = IV_UPD_UPDATING;
 	net->iv_index++;
 	net->iv_update = true;
-	l_queue_foreach(net->subnets, set_network_beacon, net);
+	l_queue_foreach(net->subnets, refresh_beacon, net);
+	queue_friend_update(net);
 	net->iv_update_timeout = l_timeout_create(
 			IV_IDX_UPD_MIN,
 			iv_upd_to, net, NULL);
@@ -3059,7 +2940,6 @@ bool mesh_net_set_friend(struct mesh_net *net, uint16_t friend_addr)
 
 	net->friend_addr = friend_addr;
 
-	set_network_beacon(get_primary_subnet(net), net);
 	return true;
 }
 
diff --git a/mesh/net.h b/mesh/net.h
index fe4e0b653..90ca8328b 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -117,6 +117,9 @@ struct mesh_node;
 #define FRND_OPCODE(x) \
 		((x) >= NET_OP_FRND_POLL && (x) <= NET_OP_FRND_CLEAR_CONFIRM)
 
+#define DEFAULT_MIN_DELAY		0
+#define DEFAULT_MAX_DELAY		25
+
 struct mesh_net_addr_range {
 	uint16_t low;
 	uint16_t high;
-- 
2.21.0

