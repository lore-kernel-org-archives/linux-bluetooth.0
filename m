Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DB1862
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027113; cv=none; b=MqelgqSL0dtd+EUHED0iiPP9C/WEVLhpWJBrDp8pQkoXWco16sPQAqhg6kv9J7aHKaVhHrXbYPvIZOAgLReKz1SUEdozQ93wT8eH4XfYZ8a3K14wKg2e7gjIfuOp5yVrCjxuAnEEH+9bCCHWGjgcmGV1gD7yRozCy9nQjrp8xpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027113; c=relaxed/simple;
	bh=RZwcksw4++jMw58L3aNGyHc/EQ8P+gvawPJj22mWLeA=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=rYj5Z5eTCICVSeKF3VMpAYgslDXrfLF7zaYpzgNrN7rgtkF6sujV6eUfYaRTxLhCDNCwiTP6BvXjvW0QF62eEWsDNkQQNLxZqxMDg+VD0UhioOZ8sDyvVUCWhp2AjVpjMfIuNZH7Y+BnNXwBB3h7HhNhejOY8L92XDZRJwFjvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fts6XePa; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fts6XePa"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so1072039a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 00:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728027110; x=1728631910; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MYrHo3myjpYI01dqMQFDQ2SJGzhHWZhIt/rHP28uxg=;
        b=Fts6XePacKOOmfZK9VAoGxaJzRRBLlBRybv0EXhE72JPmeu6rchwZa84YyiCcibLzi
         e/kOGVrUt1BNpou4GBV6ows3y3WKcymLRZU6U2Z2pxwyJRukqNHECUTY4kg080Gd2mdx
         z2JtCbhw0loRVe5Zkcvj9otbfGy2I5ZcPOmhQKWnkPk6o9BCbBi+PnrTdepp1NBu5LSM
         g5gjmXWDN54eN2sVF3Jss1cyVzmHLLvdflTDUy0FA4SRqbYi4dTLcuyAvL/hiWVMWHn6
         ubIk/1oAWww3DqTH2PC6BdpUlZptK9uhAeFmOZvh6dPSdRY3eB3qR9RtVHofHOiFbCyF
         xS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728027110; x=1728631910;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MYrHo3myjpYI01dqMQFDQ2SJGzhHWZhIt/rHP28uxg=;
        b=t+EJ4glnNn+dZUBqpmPLdRf1g0DVo1k0qVd7P+fkhXSXJXGoPxc2IEC7xKpBVenSeP
         qTrVLMQ+jVieTET843zK5zwLJ5WoLRkPxze2JglynNA7P1DmsiFgGnjw6rQjS4Ze7NH0
         1joZ1RuQMheF7NNOKYvSnUNAQu1rFLOz1IAi3zl+Ttqn6c3eflYeVDjYNz7ocPytbxUh
         /dkImbmtl90D3Z1ORKTpvB5IACBuVrXGP1YaEz7MHk379Bo0/jN1IQmBWIgvj1B8D5cI
         MsBN/1EZq9ktOqPlizMiytuaHhcMEMNqNjRj8V3XYtlsQsq/el5Qxd4CVaUA4zdPrse0
         fG0w==
X-Gm-Message-State: AOJu0YzorUUnsYOCY8bmeZ1gSsND+buFvxO0+QcHhoaXAkr+dggVdSrS
	WA9XgYsbYvftFS6k7bMQeP5jvLUxr+0sypfoQXTSdBVtGQb0bvTd46H3Eg==
X-Google-Smtp-Source: AGHT+IGsOF/9MnafSpF5p7czGmvrMnNTvTtiA0NlfoKKGFSNL7ZYl5PFKkd3ptAoG/e+TUZPjkV8RQ==
X-Received: by 2002:a05:6a20:7f95:b0:1d4:fb97:41b9 with SMTP id adf61e73a8af0-1d6d3b01314mr8569009637.22.1728027109860;
        Fri, 04 Oct 2024 00:31:49 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb4fdc5sm1865223a12.75.2024.10.04.00.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:31:49 -0700 (PDT)
Message-ID: <66ff99e5.630a0220.2b5d14.8e61@mx.google.com>
X-Google-Original-Message-ID: <Zv+Z4ikGmTe6l5o6@JUNHO-NEOSTACK.>
Date: Fri, 4 Oct 2024 16:31:46 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: bggixx@gmail.com
Subject: [PATCH BlueZ 1/4] mesh: Implement lower transport layer for
 segmentation and reassembly
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sections 4.2.48 and 4.2.49 of Mesh Protocol 1.1 define the transmission
interval, number of retransmissions, retransmission interval, ack
transmission, number of ack retransmissions, ack retransmission
interval, ack retransmission interval, and discard time for SAR, which
is a mutable state, and required a SAR implementation that conforms to
the specification. The existing segmentation and reassembly were
implemented before the specification was officially released, so they
were fixed.

- In the previous implementation, the segments of the SAR were sent to
  the network layer immediately for every segO. This has been changed so
  that they are sent one after the other when the timer expires for each
  segment interval state.
- In the previous implementation, the SAR retransmission feature for
  multicast sent all segments to the network layer a fixed four times.
  This has been changed to send as many SAR retransmissions for
  multicast as the number of states.
- In the original implementation, the SAR retransmission feaure for
  unicast was persistent as long as the receiver was receiving
  additional segments. This has been changed to send as many SAR
  retransmissions for unicast as the number of states.
- In the previous implementation, the SAR transfer feature for the same
  destination worked as a single thread, so if SAR transfers were
  duplicated, queuing was used to delay the transfer, but if the upper
  transport layer required successive SAR transfers, the queue would
  stack up infinitely. This was solved by discarding existing SAR
  transmissions when SAR transmissions for the same destination are
  required.
- In the previous implementation, an ack was sent each time a segment
  was received for a SAR that had already been successfully received.
  This has been changed to sending an ACK only once within a certain
  period.
---
 mesh/mesh.c |  45 ++++
 mesh/mesh.h |   2 +
 mesh/net.c  | 667 +++++++++++++++++++++++++++++++++++-----------------
 3 files changed, 495 insertions(+), 219 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 91cf25175..f89230b6c 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -95,6 +95,41 @@ static struct l_queue *pending_queue;
 
 static const char *storage_dir;
 
+struct mesh_sar_transmitter {
+	uint8_t	seg_int_step;
+	uint8_t	unicast_rtx_cnt;
+	uint8_t	unicast_rtx_without_prog_cnt;
+	uint8_t	unicast_rtx_int_step;
+	uint8_t	unicast_rtx_int_inc;
+	uint8_t	multicast_rtx_cnt;
+	uint8_t	multicast_rtx_int_step;
+};
+
+struct mesh_sar_receiver {
+	uint8_t	seg_threshold;
+	uint8_t	ack_delay_inc;
+	uint8_t	ack_rtx_cnt;
+	uint8_t	discard_timeout;
+	uint8_t	receiver_seg_int_step;
+};
+
+static struct mesh_sar_transmitter mesh_sar_txr = {
+	.seg_int_step = 5,
+	.unicast_rtx_cnt = 2,
+	.unicast_rtx_without_prog_cnt = 2,
+	.unicast_rtx_int_step = 7,
+	.unicast_rtx_int_inc = 1,
+	.multicast_rtx_cnt = 2,
+	.multicast_rtx_int_step = 8
+};
+static struct mesh_sar_receiver mesh_sar_rxr = {
+	.seg_threshold = 3,
+	.ack_delay_inc = 1,
+	.ack_rtx_cnt = 0,
+	.discard_timeout = 1,
+	.receiver_seg_int_step = 5
+};
+
 /* Forward static decalrations */
 static void def_attach(struct l_timeout *timeout, void *user_data);
 static void def_leave(struct l_timeout *timeout, void *user_data);
@@ -203,6 +238,16 @@ uint8_t mesh_get_friend_queue_size(void)
 	return mesh.friend_queue_sz;
 }
 
+void mesh_get_sar_transmitter(void *sar_txr)
+{
+	memcpy(sar_txr, &mesh_sar_txr, sizeof(struct mesh_sar_transmitter));
+}
+
+void mesh_get_sar_receiver(void *sar_rxr)
+{
+	memcpy(sar_rxr, &mesh_sar_rxr, sizeof(struct mesh_sar_receiver));
+}
+
 static void parse_settings(const char *mesh_conf_fname)
 {
 	struct l_settings *settings;
diff --git a/mesh/mesh.h b/mesh/mesh.h
index c30a8d1f0..5d62f35c8 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -43,3 +43,5 @@ bool mesh_relay_supported(void);
 bool mesh_friendship_supported(void);
 uint16_t mesh_get_crpl(void);
 uint8_t mesh_get_friend_queue_size(void);
+void mesh_get_sar_transmitter(void *sar_txr);
+void mesh_get_sar_receiver(void *sar_rxr);
diff --git a/mesh/net.c b/mesh/net.c
index 05ca48326..41e415b65 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -30,6 +30,11 @@
 #include "mesh/model.h"
 #include "mesh/appkey.h"
 #include "mesh/rpl.h"
+#include "mesh/mesh.h"
+
+#ifndef MIN
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+#endif
 
 #define abs_diff(a, b) ((a) > (b) ? (a) - (b) : (b) - (a))
 
@@ -44,10 +49,6 @@
 
 #define IV_UPDATE_SEQ_TRIGGER 0x800000  /* Half of Seq-Nums expended */
 
-#define SEG_TO	2
-#define MSG_TO	60
-#define SAR_DEL	10
-
 #define DEFAULT_TRANSMIT_COUNT		1
 #define DEFAULT_TRANSMIT_INTERVAL	100
 
@@ -91,15 +92,34 @@ struct mesh_subnet {
 	uint8_t kr_phase;
 };
 
+struct mesh_sar_transmitter {
+	uint8_t	seg_int_step;
+	uint8_t	unicast_rtx_cnt;
+	uint8_t	unicast_rtx_without_prog_cnt;
+	uint8_t	unicast_rtx_int_step;
+	uint8_t	unicast_rtx_int_inc;
+	uint8_t	multicast_rtx_cnt;
+	uint8_t	multicast_rtx_int_step;
+};
+
+struct mesh_sar_receiver {
+	uint8_t	seg_threshold;
+	uint8_t	ack_delay_inc;
+	uint8_t	ack_rtx_cnt;
+	uint8_t	discard_timeout;
+	uint8_t	receiver_seg_int_step;
+};
+
 struct mesh_net {
 	struct mesh_io *io;
 	struct mesh_node *node;
 	struct mesh_prov *prov;
 	struct l_queue *app_keys;
+	struct mesh_sar_transmitter *sar_txr;
+	struct mesh_sar_receiver *sar_rxr;
 	unsigned int pkt_id;
 	unsigned int bea_id;
 	unsigned int beacon_id;
-	unsigned int sar_id_next;
 
 	bool friend_enable;
 	bool snb_enable;
@@ -138,7 +158,6 @@ struct mesh_net {
 	struct l_queue *replay_cache;
 	struct l_queue *sar_in;
 	struct l_queue *sar_out;
-	struct l_queue *sar_queue;
 	struct l_queue *frnd_msgs;
 	struct l_queue *friends;
 	struct l_queue *negotiations;
@@ -152,15 +171,10 @@ struct mesh_msg {
 };
 
 struct mesh_sar {
-	unsigned int id;
-	struct l_timeout *seg_timeout;
-	struct l_timeout *msg_timeout;
 	uint32_t flags;
-	uint32_t last_nak;
 	uint32_t iv_index;
 	uint32_t seqAuth;
 	uint16_t seqZero;
-	uint16_t app_idx;
 	uint16_t net_idx;
 	uint16_t src;
 	uint16_t remote;
@@ -169,13 +183,32 @@ struct mesh_sar {
 	bool segmented;
 	bool frnd;
 	bool frnd_cred;
-	bool delete;
 	uint8_t ttl;
-	uint8_t last_seg;
 	uint8_t key_aid;
 	uint8_t buf[4]; /* Large enough for ACK-Flags and MIC */
 };
 
+struct mesh_sar_tx {
+	struct mesh_sar *sar;
+	struct l_timeout *seg_timeout;
+	uint16_t retrans_ms;
+	uint8_t int_ms;
+	uint8_t attempt_left;
+	uint8_t attempt_left_no_progress;
+	uint8_t segO;
+	uint8_t segN;
+	bool ack_received;
+};
+
+struct mesh_sar_rx {
+	struct mesh_sar *sar;
+	struct l_timeout *ack_timeout;
+	struct l_timeout *msg_timeout;
+	uint16_t ack_int_ms;
+	uint8_t ack_attempt_left;
+	uint8_t discard_to;
+};
+
 struct mesh_destination {
 	uint16_t dst;
 	uint16_t ref_cnt;
@@ -225,6 +258,65 @@ struct net_beacon_data {
 static struct l_queue *fast_cache;
 static struct l_queue *nets;
 
+static uint8_t sar_tx_seg_int_ms(struct mesh_sar_transmitter *txr)
+{
+	return (txr->seg_int_step + 1) * 10;
+}
+
+static uint8_t sar_tx_retrans_cnt(struct mesh_sar_transmitter *txr,
+					bool is_unicast, bool no_progress)
+{
+	if (is_unicast) {
+		return (no_progress ?
+			txr->unicast_rtx_without_prog_cnt :
+			txr->unicast_rtx_cnt);
+	} else {
+		return txr->multicast_rtx_cnt;
+	}
+}
+
+/* Maximum retransmission interval is 50800 milliseconds. */
+static uint16_t sar_tx_retrans_timeout_ms(struct mesh_sar_transmitter *txr,
+						bool is_unicast, int ttl)
+{
+	if (is_unicast) {
+		return (txr->unicast_rtx_int_step + 1 + ((ttl > 0) ?
+			 ((txr->unicast_rtx_int_inc + 1) * (ttl - 1)) :
+								0)) * 25;
+	} else {
+		return (txr->multicast_rtx_int_step + 1) * 25;
+	}
+}
+
+static uint8_t sar_rx_seg_threshold(struct mesh_sar_receiver *rxr)
+{
+	return rxr->seg_threshold;
+}
+
+/* Maximum ack retransmission interval is 1360 milliseconds. */
+static uint16_t sar_rx_ack_timeout_ms(struct mesh_sar_receiver *rxr, int segN)
+{
+	return MIN(segN, rxr->ack_delay_inc * 2 + 3) *
+			(rxr->receiver_seg_int_step + 1) * 10 / 2;
+}
+
+/* Maximum retransmission delay is 1360 milliseconds. */
+static uint16_t sar_rx_delay_ack_timeout_ms(struct mesh_sar_receiver *rxr)
+{
+	return (rxr->ack_delay_inc * 2 + 3) *
+			(rxr->receiver_seg_int_step + 1) * 10 / 2;
+}
+
+static uint8_t sar_rx_discard_timeout(struct mesh_sar_receiver *rxr)
+{
+	return (rxr->discard_timeout + 1) * 5;
+}
+
+static uint8_t sar_rx_ack_retrans_count(struct mesh_sar_receiver *rxr)
+{
+	return rxr->ack_rtx_cnt;
+}
+
 static void net_rx(void *net_ptr, void *user_data);
 
 static inline struct mesh_subnet *get_primary_subnet(struct mesh_net *net)
@@ -521,11 +613,54 @@ static void mesh_sar_free(void *data)
 	if (!sar)
 		return;
 
-	l_timeout_remove(sar->seg_timeout);
-	l_timeout_remove(sar->msg_timeout);
 	l_free(sar);
 }
 
+static struct mesh_sar_tx *mesh_sar_tx_new()
+{
+	size_t size = sizeof(struct mesh_sar_tx);
+	struct mesh_sar_tx *sar_tx;
+
+	sar_tx = l_malloc(size);
+	memset(sar_tx, 0, size);
+	return sar_tx;
+}
+
+static void mesh_sar_tx_free(void *data)
+{
+	struct mesh_sar_tx *sar_tx = data;
+
+	if (!sar_tx)
+		return;
+
+	mesh_sar_free(sar_tx->sar);
+	l_timeout_remove(sar_tx->seg_timeout);
+	l_free(sar_tx);
+}
+
+static struct mesh_sar_rx *mesh_sar_rx_new()
+{
+	size_t size = sizeof(struct mesh_sar_rx);
+	struct mesh_sar_rx *sar_rx;
+
+	sar_rx = l_malloc(size);
+	memset(sar_rx, 0, size);
+	return sar_rx;
+}
+
+static void mesh_sar_rx_free(void *data)
+{
+	struct mesh_sar_rx *sar_rx = data;
+
+	if (!sar_rx)
+		return;
+
+	mesh_sar_free(sar_rx->sar);
+	l_timeout_remove(sar_rx->ack_timeout);
+	l_timeout_remove(sar_rx->msg_timeout);
+	l_free(sar_rx);
+}
+
 static void subnet_free(void *data)
 {
 	struct mesh_subnet *subnet = data;
@@ -634,6 +769,11 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 
 	net = l_new(struct mesh_net, 1);
 
+	net->sar_txr = l_new(struct mesh_sar_transmitter, 1);
+	mesh_get_sar_transmitter(net->sar_txr);
+	net->sar_rxr = l_new(struct mesh_sar_receiver, 1);
+	mesh_get_sar_receiver(net->sar_rxr);
+
 	net->node = node;
 	net->seq_num = DEFAULT_SEQUENCE_NUMBER;
 	net->default_ttl = TTL_MASK;
@@ -645,7 +785,6 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	net->msg_cache = l_queue_new();
 	net->sar_in = l_queue_new();
 	net->sar_out = l_queue_new();
-	net->sar_queue = l_queue_new();
 	net->frnd_msgs = l_queue_new();
 	net->destinations = l_queue_new();
 	net->app_keys = l_queue_new();
@@ -667,12 +806,14 @@ void mesh_net_free(void *user_data)
 	if (!net)
 		return;
 
+	l_free(net->sar_txr);
+	l_free(net->sar_rxr);
+
 	l_queue_destroy(net->subnets, subnet_free);
 	l_queue_destroy(net->msg_cache, l_free);
 	l_queue_destroy(net->replay_cache, l_free);
-	l_queue_destroy(net->sar_in, mesh_sar_free);
-	l_queue_destroy(net->sar_out, mesh_sar_free);
-	l_queue_destroy(net->sar_queue, mesh_sar_free);
+	l_queue_destroy(net->sar_in, mesh_sar_rx_free);
+	l_queue_destroy(net->sar_out, mesh_sar_tx_free);
 	l_queue_destroy(net->frnd_msgs, l_free);
 	l_queue_destroy(net->friends, mesh_friend_free);
 	l_queue_destroy(net->negotiations, mesh_friend_free);
@@ -1080,36 +1221,52 @@ static bool msg_in_cache(struct mesh_net *net, uint16_t src, uint32_t seq,
 	return false;
 }
 
-static bool match_sar_seq0(const void *a, const void *b)
+static bool match_sar_tx_seq0(const void *a, const void *b)
 {
-	const struct mesh_sar *sar = a;
+	const struct mesh_sar_tx *sar_tx = a;
 	uint16_t seqZero = L_PTR_TO_UINT(b);
 
-	return sar->seqZero == seqZero;
+	return sar_tx->sar->seqZero == seqZero;
+}
+
+static bool match_sar_tx_remote(const void *a, const void *b)
+{
+	const struct mesh_sar_tx *sar_tx = a;
+	uint16_t remote = L_PTR_TO_UINT(b);
+
+	return sar_tx->sar->remote == remote;
 }
 
-static bool match_sar_remote(const void *a, const void *b)
+static bool match_sar_rx_remote(const void *a, const void *b)
 {
-	const struct mesh_sar *sar = a;
+	const struct mesh_sar_rx *sar_rx = a;
 	uint16_t remote = L_PTR_TO_UINT(b);
 
-	return sar->remote == remote;
+	return sar_rx->sar->remote == remote;
 }
 
 static bool match_msg_timeout(const void *a, const void *b)
 {
-	const struct mesh_sar *sar = a;
+	const struct mesh_sar_rx *sar_rx = a;
 	const struct l_timeout *msg_timeout = b;
 
-	return sar->msg_timeout == msg_timeout;
+	return sar_rx->msg_timeout == msg_timeout;
+}
+
+static bool match_ack_timeout(const void *a, const void *b)
+{
+	const struct mesh_sar_rx *sar_rx = a;
+	const struct l_timeout *ack_timeout = b;
+
+	return sar_rx->ack_timeout == ack_timeout;
 }
 
 static bool match_seg_timeout(const void *a, const void *b)
 {
-	const struct mesh_sar *sar = a;
+	const struct mesh_sar_tx *sar_tx = a;
 	const struct l_timeout *seg_timeout = b;
 
-	return sar->seg_timeout == seg_timeout;
+	return sar_tx->seg_timeout == seg_timeout;
 }
 
 static bool match_dest_dst(const void *a, const void *b)
@@ -1501,156 +1658,193 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
 				sizeof(msg));
 }
 
-static void inseg_to(struct l_timeout *seg_timeout, void *user_data)
+static void delay_seg_ack_to(struct l_timeout *ack_timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
-	struct mesh_sar *sar = l_queue_find(net->sar_in,
-					match_seg_timeout, seg_timeout);
+	struct mesh_sar_rx *sar_rx = l_queue_find(net->sar_in,
+					match_ack_timeout, ack_timeout);
 
-	l_timeout_remove(seg_timeout);
-	if (!sar)
+	l_timeout_remove(ack_timeout);
+	if (!sar_rx)
 		return;
 
-	/* Send NAK */
-	l_debug("Timeout %p %3.3x", sar, sar->app_idx);
-	send_net_ack(net, sar, sar->flags);
-
-	sar->seg_timeout = l_timeout_create(SEG_TO, inseg_to, net, NULL);
+	sar_rx->ack_timeout = NULL;
 }
 
-static void inmsg_to(struct l_timeout *msg_timeout, void *user_data)
+static void seg_ack_to(struct l_timeout *ack_timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
-	struct mesh_sar *sar = l_queue_find(net->sar_in,
-			match_msg_timeout, msg_timeout);
+	struct mesh_sar_rx *sar_rx = l_queue_find(net->sar_in,
+					match_ack_timeout, ack_timeout);
 
-	if (!sar) {
-		l_timeout_remove(msg_timeout);
+	l_timeout_remove(ack_timeout);
+	if (!sar_rx)
 		return;
-	}
 
-	if (!sar->delete) {
-		/*
-		 * Incomplete timer expired, cancel SAR and start
-		 * delete timer
-		 */
-		l_timeout_remove(sar->seg_timeout);
-		sar->seg_timeout = NULL;
-		sar->delete = true;
-		l_timeout_modify(sar->msg_timeout, SAR_DEL);
-		return;
-	}
+	sar_rx->ack_timeout = NULL;
+
+	send_net_ack(net, sar_rx->sar, sar_rx->sar->flags);
 
-	l_queue_remove(net->sar_in, sar);
-	mesh_sar_free(sar);
+	if (sar_rx->ack_attempt_left) {
+		sar_rx->ack_attempt_left--;
+		sar_rx->ack_timeout = l_timeout_create(sar_rx->ack_int_ms,
+							seg_ack_to, net, NULL);
+	}
 }
 
-static void outmsg_to(struct l_timeout *msg_timeout, void *user_data)
+static void seg_rx_completed_to(struct l_timeout *msg_timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
-	struct mesh_sar *sar = l_queue_remove_if(net->sar_out,
+	struct mesh_sar_rx *sar_rx = l_queue_find(net->sar_in,
 			match_msg_timeout, msg_timeout);
 
 	l_timeout_remove(msg_timeout);
-	if (!sar)
+	if (!sar_rx)
 		return;
 
-	sar->msg_timeout = NULL;
-	mesh_sar_free(sar);
-}
+	sar_rx->msg_timeout = NULL;
 
-static void outseg_to(struct l_timeout *seg_timeout, void *user_data);
+	l_queue_remove(net->sar_in, sar_rx);
+	mesh_sar_rx_free(sar_rx);
+}
 
-static void send_queued_sar(struct mesh_net *net, uint16_t dst)
+static void seg_rx_discard_to(struct l_timeout *msg_timeout, void *user_data)
 {
-	struct mesh_sar *sar = l_queue_remove_if(net->sar_queue,
-			match_sar_remote, L_UINT_TO_PTR(dst));
+	struct mesh_net *net = user_data;
+	struct mesh_sar_rx *sar_rx = l_queue_find(net->sar_in,
+			match_msg_timeout, msg_timeout);
 
-	if (!sar)
+	l_timeout_remove(msg_timeout);
+	if (!sar_rx)
 		return;
 
-	/* Out to current outgoing, and immediate expire Seg TO */
-	l_queue_push_head(net->sar_out, sar);
-	sar->seg_timeout = NULL;
-	sar->msg_timeout = l_timeout_create(MSG_TO, outmsg_to, net, NULL);
-	outseg_to(NULL, net);
+	sar_rx->msg_timeout = NULL;
+
+	l_debug("Discard pending SAR for %04x", sar_rx->sar->seqZero);
+	l_queue_remove(net->sar_in, sar_rx);
+	mesh_sar_rx_free(sar_rx);
 }
 
-static void ack_received(struct mesh_net *net, bool timeout,
-				uint16_t src, uint16_t dst,
-				uint16_t seq0, uint32_t ack_flag)
+static void ack_rxed(struct mesh_net *net, uint16_t src, uint16_t dst,
+					uint16_t seq0, uint32_t ack_flag)
 {
-	struct mesh_sar *outgoing;
-	uint32_t seg_flag = 0x00000001;
-	uint32_t ack_copy = ack_flag;
-	uint16_t i;
+	struct mesh_sar_tx *sar_tx;
+	struct mesh_sar *sar;
+	uint32_t flags_copy;
 
-	l_debug("ACK Rxed (%x) (to:%d): %8.8x", seq0, timeout, ack_flag);
+	l_debug("ACK Rxed (%x): %8.8x", seq0, ack_flag);
 
-	outgoing = l_queue_find(net->sar_out, match_sar_seq0,
+	sar_tx = l_queue_find(net->sar_out, match_sar_tx_seq0,
 							L_UINT_TO_PTR(seq0));
 
-	if (!outgoing) {
+	if (!sar_tx) {
 		l_debug("Not Found: %4.4x", seq0);
 		return;
 	}
 
+	sar = sar_tx->sar;
+
 	/*
 	 * TODO -- If we receive from different
 	 * SRC than we are sending to, make sure the OBO flag is set
 	 */
 
-	if ((!timeout && !ack_flag) ||
-			(outgoing->flags & ack_flag) == outgoing->flags) {
-		l_debug("ob_sar_removal (%x)", outgoing->flags);
+	if (!ack_flag) {
+		l_debug("Cancel sending segments. (%x)", sar->flags);
+		l_queue_remove(net->sar_out, sar_tx);
+		mesh_sar_tx_free(sar_tx);
+		return;
+	}
 
-		/* Note: ack_flags == 0x00000000 is a remote Cancel request */
+	flags_copy = sar->flags & ~ack_flag;
 
-		l_queue_remove(net->sar_out, outgoing);
-		send_queued_sar(net, outgoing->remote);
-		mesh_sar_free(outgoing);
+	if (flags_copy == sar->flags) {
+		/* Already received ack. */
+		return;
+	}
 
+	sar_tx->ack_received = true;
+	sar->flags = flags_copy;
+
+	if (!flags_copy) {
+		/* Complete SAR transmission. Receiver has all segs. */
+		l_queue_remove(net->sar_out, sar_tx);
+		mesh_sar_tx_free(sar_tx);
 		return;
 	}
+}
+
+static void send_next_seg_to(struct l_timeout *seg_timeout, void *user_data)
+{
+	struct mesh_net *net = user_data;
+	struct mesh_sar_tx *sar_tx = l_queue_find(net->sar_out,
+					match_seg_timeout, seg_timeout);
+	uint8_t interval_ms;
 
-	outgoing->last_nak |= ack_flag;
+	l_timeout_remove(seg_timeout);
+	if (!sar_tx)
+		return;
 
-	ack_copy &= outgoing->flags;
+	sar_tx->seg_timeout = NULL;
 
-	for (i = 0; i <= SEG_MAX(true, outgoing->len); i++, seg_flag <<= 1) {
-		if (seg_flag & ack_flag) {
-			l_debug("Skipping Seg %d of %d",
-					i, SEG_MAX(true, outgoing->len));
+	/* Complete transmission to unicast address. Receiver has all segs. */
+	if (!sar_tx->sar->flags)
+		goto free;
+
+	while (sar_tx->segO <= sar_tx->segN) {
+		if (!((1 << sar_tx->segO) & sar_tx->sar->flags)) {
+			/* Skip received segments. */
+			sar_tx->segO++;
 			continue;
 		}
 
-		ack_copy |= seg_flag;
-
-		l_debug("Resend Seg %d net:%p dst:%x app_idx:%3.3x",
-				i, net, outgoing->remote, outgoing->app_idx);
+		if (!send_seg(net, net->tx_cnt, net->tx_interval, sar_tx->sar,
+								sar_tx->segO)) {
+			l_error("Failed to send SAR");
+			goto free;
+		}
 
-		send_seg(net, net->tx_cnt, net->tx_interval, outgoing, i);
+		sar_tx->segO++;
+		interval_ms = sar_tx->int_ms;
+		break;
 	}
 
-	l_timeout_remove(outgoing->seg_timeout);
-	outgoing->seg_timeout = l_timeout_create(SEG_TO, outseg_to, net, NULL);
-}
+	if (sar_tx->segO > sar_tx->segN) {
+		if (!sar_tx->attempt_left) {
+			if (IS_UNICAST(sar_tx->sar->remote)) {
+				l_warn("Ran out of SAR retransmit attempts");
+				goto free;
+			} else {
+				/* Complete transmission to multicast address.*/
+				goto free;
+			}
+		} else if (!sar_tx->attempt_left_no_progress) {
+			l_warn("Ran out of SAR retransmit without progress attempts");
+			goto free;
+		}
 
-static void outseg_to(struct l_timeout *seg_timeout, void *user_data)
-{
-	struct mesh_net *net = user_data;
-	struct mesh_sar *sar = l_queue_find(net->sar_out,
-					match_seg_timeout, seg_timeout);
+		sar_tx->segO = 0;
+		sar_tx->attempt_left--;
+		if (!sar_tx->ack_received)
+			sar_tx->attempt_left_no_progress--;
+		else
+			sar_tx->attempt_left_no_progress = sar_tx_retrans_cnt(
+							net->sar_txr,
+							true, true);
+		sar_tx->ack_received = false;
+		interval_ms = sar_tx->retrans_ms;
+	}
 
-	l_timeout_remove(seg_timeout);
-	if (!sar)
-		return;
+	sar_tx->seg_timeout = l_timeout_create_ms(interval_ms, send_next_seg_to,
+								net, NULL);
 
-	sar->seg_timeout = NULL;
+out:
+	return;
 
-	/* Re-Send missing segments by faking NACK */
-	ack_received(net, true, sar->remote, sar->src,
-					sar->seqZero, sar->last_nak);
+free:
+	l_queue_remove(net->sar_out, sar_tx);
+	mesh_sar_tx_free(sar_tx);
+	goto out;
 }
 
 static bool match_replay_cache(const void *a, const void *b)
@@ -1956,130 +2150,165 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 					uint8_t segO, uint8_t segN,
 					const uint8_t *data, uint8_t size)
 {
-	struct mesh_sar *sar_in = NULL;
+	struct mesh_sar_rx *sar_in = NULL;
+	struct mesh_sar *sar = NULL;
 	uint16_t seg_off = 0;
 	uint32_t expected, this_seg_flag, largest, seqAuth;
-	bool reset_seg_to = true;
 
 	/*
 	 * DST could receive additional Segments after
 	 * completing due to a lost ACK, so re-ACK and discard
 	 */
-	sar_in = l_queue_find(net->sar_in, match_sar_remote,
+	sar_in = l_queue_find(net->sar_in, match_sar_rx_remote,
 						L_UINT_TO_PTR(src));
 
 	/* Discard *old* incoming-SAR-in-progress if this segment newer */
 	seqAuth = seq_auth(seq, seqZero);
-	if (sar_in && (sar_in->seqAuth != seqAuth ||
-				sar_in->iv_index != iv_index)) {
+	if (sar_in && (sar_in->sar->seqAuth != seqAuth ||
+				sar_in->sar->iv_index != iv_index)) {
 		bool newer;
 
-		if (iv_index > sar_in->iv_index)
+		if (iv_index > sar_in->sar->iv_index)
 			newer = true;
-		else if (iv_index == sar_in->iv_index)
-			newer = seqAuth > sar_in->seqAuth;
+		else if (iv_index == sar_in->sar->iv_index)
+			newer = seqAuth > sar_in->sar->seqAuth;
 		else
 			newer = false;
 
 		if (newer) {
 			/* Cancel Old, start New */
+			l_debug("Discard SAR duplicated from src: 0x%04x", src);
 			l_queue_remove(net->sar_in, sar_in);
-			mesh_sar_free(sar_in);
+			mesh_sar_rx_free(sar_in);
 			sar_in = NULL;
 		} else
 			/* Ignore Old */
+			l_debug("Ignore old seqAuth");
 			return false;
 	}
 
 	expected = 0xffffffff >> (31 - segN);
 
 	if (sar_in) {
+		sar = sar_in->sar;
 		l_debug("RXed (old: %04x %06x size:%d) %d of %d",
 					seqZero, seq, size, segO, segN);
 		/* Sanity Check--> certain things must match */
-		if (SEG_MAX(true, sar_in->len) != segN ||
-				sar_in->key_aid != key_aid)
+		if (SEG_MAX(true, sar->len) != segN ||
+				sar->key_aid != key_aid)
 			return false;
 
-		if (sar_in->flags == expected) {
-			/* Re-Send ACK for full msg */
-			send_net_ack(net, sar_in, expected);
+		if (sar->flags == expected) {
+			/*
+			 * According to MshPRTv1.1: 3.5.3.4, if the destination
+			 * is a unicast address and a segment is received for a
+			 * completed message, it sends one acknowledgment within
+			 * a period of:
+			 *	[acknowledgment delay increment * segment reception interval]
+			 */
+			l_debug("Got segment for already complete msg");
+			if (IS_UNICAST(dst) && sar_in->ack_timeout == NULL) {
+				send_net_ack(net, sar, expected);
+				sar_in->ack_timeout = l_timeout_create_ms(
+						sar_rx_delay_ack_timeout_ms(
+								net->sar_rxr),
+						delay_seg_ack_to, net, NULL);
+			}
 			return true;
-		} else if (sar_in->delete)
-			/* Ignore cancelled */
-			return false;
+		}
 	} else {
 		uint16_t len = MAX_SEG_TO_LEN(segN);
 
 		l_debug("RXed (new: %04x %06x size: %d len: %d) %d of %d",
 				seqZero, seq, size, len, segO, segN);
 		l_debug("Queue Size: %d", l_queue_length(net->sar_in));
-		sar_in = mesh_sar_new(len);
-		sar_in->seqAuth = seqAuth;
-		sar_in->iv_index = iv_index;
-		sar_in->src = dst;
-		sar_in->remote = src;
-		sar_in->seqZero = seqZero;
-		sar_in->key_aid = key_aid;
-		sar_in->len = len;
-		sar_in->last_seg = 0xff;
-		sar_in->net_idx = net_idx;
-		sar_in->msg_timeout = l_timeout_create(MSG_TO,
-					inmsg_to, net, NULL);
-
-		l_debug("First Seg %4.4x", sar_in->flags);
+		sar = mesh_sar_new(len);
+		sar->seqAuth = seqAuth;
+		sar->iv_index = iv_index;
+		sar->src = dst;
+		sar->remote = src;
+		sar->seqZero = seqZero;
+		sar->key_aid = key_aid;
+		sar->len = len;
+		sar->net_idx = net_idx;
+
+		sar_in = mesh_sar_rx_new();
+		sar_in->sar = sar;
+
+		if (IS_UNICAST(dst)) {
+			/*
+			 * According to MshPRTv1.1: 3.5.3.4, if the destination
+			 * is a unicast address, it sends the acks for received
+			 * segments, and additionally retransmits the acks when
+			 * segN exceeds the threshold.
+			 */
+			sar_in->ack_int_ms = sar_rx_ack_timeout_ms(net->sar_rxr,
+									segN);
+
+			if (segN > sar_rx_seg_threshold(net->sar_rxr)) {
+				sar_in->ack_attempt_left =
+					sar_rx_ack_retrans_count(net->sar_rxr);
+			} else {
+				sar_in->ack_attempt_left = 0;
+			}
+		}
+
+		sar_in->discard_to = sar_rx_discard_timeout(net->sar_rxr);
+
+		l_debug("First Seg %4.4x", sar->flags);
 		l_queue_push_head(net->sar_in, sar_in);
 	}
 
-	seg_off = segO * MAX_SEG_LEN;
-	memcpy(sar_in->buf + seg_off, data, size);
 	this_seg_flag = 0x00000001 << segO;
 
-	/* Don't reset Seg TO or NAK if we already have this seg */
-	if (this_seg_flag & sar_in->flags)
-		reset_seg_to = false;
+	/* Ignore this seg if it already exists.*/
+	if (this_seg_flag & sar->flags)
+		return false;
+
+	l_timeout_remove(sar_in->ack_timeout);
+	sar_in->ack_timeout = NULL;
+	l_timeout_remove(sar_in->msg_timeout);
+	sar_in->msg_timeout = NULL;
 
-	sar_in->flags |= this_seg_flag;
-	sar_in->ttl = ttl;
+	seg_off = segO * MAX_SEG_LEN;
+	memcpy(sar->buf + seg_off, data, size);
+	sar->flags |= this_seg_flag;
+	sar->ttl = ttl;
 
 	/* Msg length only definitive on last segment */
 	if (segO == segN)
-		sar_in->len = segN * MAX_SEG_LEN + size;
+		sar->len = segN * MAX_SEG_LEN + size;
+
+	/* Send ACK only if DST is unicast address. */
+	if(IS_UNICAST(dst)) {
+		sar_in->ack_timeout = l_timeout_create_ms(sar_in->ack_int_ms,
+								seg_ack_to,
+								net, NULL);
+	}
 
-	if (sar_in->flags == expected) {
+	if (sar->flags == expected) {
 		/* Got it all */
-		send_net_ack(net, sar_in, expected);
+		send_net_ack(net, sar, expected);
 
 		msg_rxed(net, frnd, iv_index, ttl, seq, net_idx,
-				sar_in->remote, dst, key_aid, true, szmic,
-				sar_in->seqZero, sar_in->buf, sar_in->len);
+				sar->remote, dst, key_aid, true, szmic,
+				sar->seqZero, sar->buf, sar->len);
 
-		/* Kill Inter-Seg timeout */
-		l_timeout_remove(sar_in->seg_timeout);
-		sar_in->seg_timeout = NULL;
-
-		/* Start delete timer */
-		sar_in->delete = true;
-		l_timeout_modify(sar_in->msg_timeout, SAR_DEL);
+		/*
+		 * Delay SAR removal to be able to acknowledge a transaction
+		 * when repeated segments are received.
+		 */
+		sar_in->msg_timeout = l_timeout_create(sar_in->discard_to,
+							seg_rx_completed_to,
+							net, NULL);
 		return true;
 	}
 
-	if (reset_seg_to) {
-		/* Restart Inter-Seg Timeout */
-		l_timeout_remove(sar_in->seg_timeout);
-
-		/* if this is the largest outstanding segment, send NAK now */
-		largest = (0xffffffff << segO) & expected;
-		if ((largest & sar_in->flags) == largest)
-			send_net_ack(net, sar_in, sar_in->flags);
-
-		sar_in->seg_timeout = l_timeout_create(SEG_TO,
-				inseg_to, net, NULL);
-	} else
-		largest = 0;
+	sar_in->msg_timeout = l_timeout_create(sar_in->discard_to,
+						seg_rx_discard_to,
+						net, NULL);
 
-	l_debug("NAK: %d expected:%08x largest:%08x flags:%08x",
-			reset_seg_to, expected, largest, sar_in->flags);
+	l_debug("expected:%08x flags:%08x", expected, sar->flags);
 	return false;
 }
 
@@ -2393,8 +2622,7 @@ static enum _relay_advice packet_received(void *user_data,
 					friend_ack_rxed(net, iv_index, net_seq,
 							net_src, net_dst, msg);
 				else
-					ack_received(net, false,
-							net_src, net_dst,
+					ack_rxed(net, net_src, net_dst,
 							net_seqZero,
 							l_get_be32(msg + 3));
 			} else {
@@ -2565,8 +2793,7 @@ static void iv_upd_to(struct l_timeout *upd_timeout, void *user_data)
 
 	switch (net->iv_upd_state) {
 	case IV_UPD_UPDATING:
-		if (l_queue_length(net->sar_out) ||
-					l_queue_length(net->sar_queue)) {
+		if (l_queue_length(net->sar_out)) {
 			l_debug("don't leave IV Update until sar_out empty");
 			l_timeout_modify(net->iv_update_timeout, 10);
 			break;
@@ -3194,8 +3421,6 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 
 	send_msg_pkt(net, cnt, interval, packet, packet_len + 1);
 
-	msg->last_seg = segO;
-
 	return true;
 }
 
@@ -3311,47 +3536,51 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	payload->segmented = segmented;
 
 	if (segmented) {
+		struct mesh_sar_tx *drop_sar_tx;
 		payload->flags = 0xffffffff >> (31 - seg_max);
 		payload->seqZero = seq & SEQ_ZERO_MASK;
-		payload->id = ++net->sar_id_next;
 
 		/* Single thread SAR messages to same Unicast DST */
-		if (l_queue_find(net->sar_out, match_sar_remote,
-							L_UINT_TO_PTR(dst))) {
-			/* Delay sending Outbound SAR unless prior
-			 * SAR to same DST has completed */
-
-			l_debug("OB-Queued SeqZero: %4.4x", payload->seqZero);
-			l_queue_push_tail(net->sar_queue, payload);
-			return true;
+		drop_sar_tx = l_queue_find(net->sar_out, match_sar_tx_remote,
+							L_UINT_TO_PTR(dst));
+		if (drop_sar_tx) {
+			/* Cancel incomplete prior SAR on the same dst */
+			l_debug("Cancel incompleted SAR: SeqZero %4.4x",
+					drop_sar_tx->sar->seqZero);
+			l_queue_remove(net->sar_out, drop_sar_tx);
+			mesh_sar_tx_free(drop_sar_tx);
 		}
 	}
 
-	result = true;
-
-	if (!IS_UNICAST(dst) && segmented) {
-		int i;
+	result = send_seg(net, cnt, interval, payload, 0);
 
-		for (i = 0; i < 4; i++) {
-			for (seg = 0; seg <= seg_max && result; seg++)
-				result = send_seg(net, cnt, interval, payload,
-									seg);
-		}
+	/*
+	 * Set the timeout to send the next seg or retransmit if the payload is
+	 * segmented. Flush if it is not segmented or if the transmission
+	 * failed.
+	 */
+	if (result && segmented) {
+		struct mesh_sar_tx *sar_tx = mesh_sar_tx_new();
+		bool is_unicast = IS_UNICAST(dst);
+		sar_tx->ack_received = false;
+		sar_tx->int_ms = sar_tx_seg_int_ms(net->sar_txr);
+		sar_tx->attempt_left = sar_tx_retrans_cnt(net->sar_txr,
+							is_unicast, false);
+		sar_tx->attempt_left_no_progress = sar_tx_retrans_cnt(
+							net->sar_txr,
+							is_unicast, true);
+		sar_tx->retrans_ms = sar_tx_retrans_timeout_ms(net->sar_txr,
+								is_unicast,
+								ttl);
+		sar_tx->sar = payload;
+		l_queue_push_head(net->sar_out, sar_tx);
+		sar_tx->seg_timeout = l_timeout_create_ms(sar_tx->int_ms,
+						send_next_seg_to, net, NULL);
+		sar_tx->segO = 1;	/* The 0th seg is already sent. */
+		sar_tx->segN = seg_max;
 	} else {
-		for (seg = 0; seg <= seg_max && result; seg++)
-			result = send_seg(net, cnt, interval, payload, seg);
-	}
-
-	/* Reliable: Cache; Unreliable: Flush*/
-	if (result && segmented && IS_UNICAST(dst)) {
-		l_queue_push_head(net->sar_out, payload);
-		payload->seg_timeout =
-			l_timeout_create(SEG_TO, outseg_to, net, NULL);
-		payload->msg_timeout =
-			l_timeout_create(MSG_TO, outmsg_to, net, NULL);
-		payload->id = ++net->sar_id_next;
-	} else
 		mesh_sar_free(payload);
+	}
 
 	return result;
 }
-- 
2.34.1

