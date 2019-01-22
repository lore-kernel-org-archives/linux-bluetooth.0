Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41E5C282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 20:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875B721726
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 20:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfAVUu0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:50:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:54616 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfAVUuZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 15:50:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 12:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,508,1539673200"; 
   d="scan'208";a="110217376"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga006.jf.intel.com with ESMTP; 22 Jan 2019 12:50:25 -0800
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 22 Jan 2019 12:50:24 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.104]) with mapi id 14.03.0415.000;
 Tue, 22 Jan 2019 12:50:24 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: RE: [PATCH BlueZ v2] mesh: Fix Relaying for multiple nodes
Thread-Topic: [PATCH BlueZ v2] mesh: Fix Relaying for multiple nodes
Thread-Index: AQHUr4N+8VlYHv6yaE+3wjjxQR2AwaW7yRmw
Date:   Tue, 22 Jan 2019 20:50:23 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D90E2BA@ORSMSX103.amr.corp.intel.com>
References: <20190118231358.1206-1-brian.gix@intel.com>
In-Reply-To: <20190118231358.1206-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDM0ZmFkOWQtMTA0MS00MDEyLWIzMTMtYzgyOWE0NWFjZmFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWjRzVFh3UW1ZYlpOT0xoaHZcLzZ4V29rWE91ZXdqWEc4a3dCMDRvMUJrSWh1XC9Ca1FKQlZOanlvUDVOdHl0bzZlIn0=
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

patch applied

> -----Original Message-----
> From: Gix, Brian
> Sent: Friday, January 18, 2019 3:14 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Stotland, Inga <inga.stotland@intel.com>; Gix, Brian
> <brian.gix@intel.com>
> Subject: [PATCH BlueZ v2] mesh: Fix Relaying for multiple nodes
> 
> Relay is now a cooperation between all the nodes on the daemon.
> If any one or more nodes have relay enabled and a received packet is
> addressed to a Group, or a non-present Unicast address, then the packet's
> TTL is decremented and it is resent.
> ---
>  mesh/crypto.c    |   8 +--
>  mesh/mesh-defs.h |   9 ++-
>  mesh/net.c       | 186 ++++++++++++++++++++++++++++++++-----------------
> ------
>  3 files changed, 118 insertions(+), 85 deletions(-)
> 
> diff --git a/mesh/crypto.c b/mesh/crypto.c index e68cc2d5f..451e2da71
> 100644
> --- a/mesh/crypto.c
> +++ b/mesh/crypto.c
> @@ -1169,13 +1169,13 @@ bool mesh_crypto_packet_parse(const uint8_t
> *packet, uint8_t packet_len,
>  				*payload = packet + 9;
> 
>  			if (payload_len)
> -				*payload_len = packet_len - 9 - 8;
> +				*payload_len = packet_len - 9;
>  		} else {
>  			if (payload)
>  				*payload = packet + 10;
> 
>  			if (payload_len)
> -				*payload_len = packet_len - 10 - 8;
> +				*payload_len = packet_len - 10;
>  		}
>  	} else {
>  		if (cookie)
> @@ -1202,13 +1202,13 @@ bool mesh_crypto_packet_parse(const uint8_t
> *packet, uint8_t packet_len,
>  				*payload = packet + 13;
> 
>  			if (payload_len)
> -				*payload_len = packet_len - 13 - 4;
> +				*payload_len = packet_len - 13;
>  		} else {
>  			if (payload)
>  				*payload = packet + 10;
> 
>  			if (payload_len)
> -				*payload_len = packet_len - 10 - 4;
> +				*payload_len = packet_len - 10;
>  		}
>  	}
> 
> diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h index
> d40fc43e8..c30041e4a 100644
> --- a/mesh/mesh-defs.h
> +++ b/mesh/mesh-defs.h
> @@ -62,7 +62,9 @@
>  #define VIRTUAL_ADDRESS_LOW	0x8000
>  #define VIRTUAL_ADDRESS_HIGH	0xbfff
>  #define GROUP_ADDRESS_LOW	0xc000
> -#define GROUP_ADDRESS_HIGH	0xff00
> +#define GROUP_ADDRESS_HIGH	0xfeff
> +#define FIXED_GROUP_LOW		0xff00
> +#define FIXED_GROUP_HIGH	0xffff
> 
>  #define NODE_IDENTITY_STOPPED		0x00
>  #define NODE_IDENTITY_RUNNING		0x01
> @@ -79,6 +81,7 @@
>  					((x) < VIRTUAL_ADDRESS_LOW))
>  #define IS_VIRTUAL(x)		(((x) >= VIRTUAL_ADDRESS_LOW)
> && \
>  					((x) <= VIRTUAL_ADDRESS_HIGH))
> -#define IS_GROUP(x)		(((x) >= GROUP_ADDRESS_LOW) && \
> -					((x) <= GROUP_ADDRESS_HIGH))
> +#define IS_GROUP(x)		((((x) >= GROUP_ADDRESS_LOW) && \
> +					((x) < FIXED_GROUP_HIGH)) || \
> +					((x) == ALL_NODES_ADDRESS))
>  #define IS_ALL_NODES(x)	((x) == ALL_NODES_ADDRESS)
> diff --git a/mesh/net.c b/mesh/net.c
> index 6ef056b56..9e509a8ea 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -71,6 +71,13 @@
> 
>  #define SAR_KEY(src, seq0)	((((uint32_t)(seq0)) << 16) | (src))
> 
> +enum _relay_advice {
> +	RELAY_NONE,		/* Relay not enabled in node */
> +	RELAY_ALLOWED,		/* Relay enabled, msg not to node's
> unicast */
> +	RELAY_DISALLOWED,	/* Msg was unicast handled by this node */
> +	RELAY_ALWAYS		/* Relay enabled, msg to a group */
> +};
> +
>  enum _iv_upd_state {
>  	/* Allows acceptance of any iv_index secure net beacon */
>  	IV_UPD_INIT,
> @@ -160,7 +167,6 @@ struct mesh_net {
>  	struct l_queue *frnd_msgs;
>  	struct l_queue *friends;
>  	struct l_queue *destinations;
> -	struct l_queue *fast_cache;
> 
>  	uint8_t prov_priv_key[32];
> 
> @@ -248,6 +254,8 @@ struct net_decode {
>  	bool proxy;
>  };
> 
> +#define FAST_CACHE_SIZE 8
> +static struct l_queue *fast_cache;
>  static struct l_queue *nets;
> 
>  static inline struct mesh_subnet *get_primary_subnet(struct mesh_net
> *net) @@ -673,7 +681,6 @@ struct mesh_net *mesh_net_new(struct
> mesh_node *node)
>  	net->tx_interval = DEFAULT_TRANSMIT_INTERVAL;
> 
>  	net->subnets = l_queue_new();
> -	net->fast_cache = l_queue_new();
>  	net->msg_cache = l_queue_new();
>  	net->sar_in = l_queue_new();
>  	net->sar_out = l_queue_new();
> @@ -687,6 +694,9 @@ struct mesh_net *mesh_net_new(struct mesh_node
> *node)
>  	if (!nets)
>  		nets = l_queue_new();
> 
> +	if (!fast_cache)
> +		fast_cache = l_queue_new();
> +
>  	return net;
>  }
> 
> @@ -696,7 +706,6 @@ void mesh_net_free(struct mesh_net *net)
>  		return;
> 
>  	l_queue_destroy(net->subnets, subnet_free);
> -	l_queue_destroy(net->fast_cache, mesh_msg_free);
>  	l_queue_destroy(net->msg_cache, mesh_msg_free);
>  	l_queue_destroy(net->sar_in, mesh_sar_free);
>  	l_queue_destroy(net->sar_out, mesh_sar_free); @@ -1021,7
> +1030,6 @@ int mesh_net_add_key(struct mesh_net *net, bool update,
> uint16_t idx,  void mesh_net_flush_msg_queues(struct mesh_net *net)  {
>  	l_queue_clear(net->msg_cache, mesh_msg_free);
> -	l_queue_clear(net->fast_cache, mesh_msg_free);
>  }
> 
>  uint32_t mesh_net_get_iv_index(struct mesh_net *net) @@ -2210,23
> +2218,23 @@ static bool find_fast_hash(const void *a, const void *b)
>  	return *entry == *test;
>  }
> 
> -static void *check_fast_cache(struct mesh_net *net, uint64_t hash)
> +static bool check_fast_cache(uint64_t hash)
>  {
> -	void *found = l_queue_find(net->fast_cache, find_fast_hash,
> &hash);
> +	void *found = l_queue_find(fast_cache, find_fast_hash, &hash);
>  	uint64_t *new_hash;
> 
>  	if (found)
> -		return NULL;
> +		return false;
> 
> -	if (l_queue_length(net->fast_cache) >= 8)
> -		new_hash = l_queue_pop_head(net->fast_cache);
> +	if (l_queue_length(fast_cache) >= FAST_CACHE_SIZE)
> +		new_hash = l_queue_pop_head(fast_cache);
>  	else
>  		new_hash = l_malloc(sizeof(hash));
> 
>  	*new_hash = hash;
> -	l_queue_push_tail(net->fast_cache, new_hash);
> +	l_queue_push_tail(fast_cache, new_hash);
> 
> -	return new_hash;
> +	return true;
>  }
> 
>  static bool match_by_dst(const void *a, const void *b) @@ -2237,8 +2245,9
> @@ static bool match_by_dst(const void *a, const void *b)
>  	return dest->dst == dst;
>  }
> 
> -static void send_relay_pkt(struct mesh_net *net, uint8_t *packet, uint8_t
> size)
> +static void send_relay_pkt(struct mesh_net *net, uint8_t *data, uint8_t
> +size)
>  {
> +	uint8_t packet[30];
>  	struct mesh_io *io = net->io;
>  	struct mesh_io_send_info info = {
>  		.type = MESH_IO_TIMING_TYPE_GENERAL,
> @@ -2249,8 +2258,9 @@ static void send_relay_pkt(struct mesh_net *net,
> uint8_t *packet, uint8_t size)
>  	};
> 
>  	packet[0] = MESH_AD_TYPE_NETWORK;
> +	memcpy(packet + 1, data, size);
> 
> -	mesh_io_send(io, &info, packet, size);
> +	mesh_io_send(io, &info, packet, size + 1);
>  }
> 
>  static void send_msg_pkt(struct mesh_net *net, uint8_t *packet, uint8_t
> size) @@ -2270,15 +2280,12 @@ static void send_msg_pkt(struct mesh_net
> *net, uint8_t *packet, uint8_t size)
>  	mesh_io_send(io, &info, packet, size);  }
> 
> -static void packet_received(void *user_data, const void *data, uint8_t size,
> -								int8_t rssi)
> +static enum _relay_advice packet_received(void *user_data,
> +				uint32_t key_id, uint32_t iv_index,
> +				const void *data, uint8_t size, int8_t rssi)
>  {
>  	struct mesh_net *net = user_data;
> -	uint32_t iv_index;
> -	uint8_t iv_flag;
>  	const uint8_t *msg = data;
> -	uint8_t *out;
> -	size_t out_size;
>  	uint8_t app_msg_len;
>  	uint8_t net_ttl, net_key_id, net_segO, net_segN, net_opcode;
>  	uint32_t net_seq, cache_cookie;
> @@ -2287,50 +2294,13 @@ static void packet_received(void *user_data,
> const void *data, uint8_t size,
>  	bool net_ctl, net_segmented, net_szmic, net_relay;
>  	struct mesh_friend *net_frnd = NULL;
>  	bool drop = false;
> -	uint64_t hash, *isNew = NULL;
> -	uint32_t key_id;
> -
> -	iv_flag = msg[0] >> 7;
> -	iv_index = net->iv_index;
> -	l_debug("%s iv_index %d NID: %2.2x", __func__, iv_index, msg[0] &
> 0x7f);
> -
> -	if (sizeof(uint16_t) <= sizeof(void *)) {
> -		/* Add in additional cache to allow us to
> -		 * avoid decrypting duplicatesr
> -		 * Fast 64 bit Hash, Network MIC doesn't matter
> -		 * With 64 bit hash, false pos chance is 1 in 1.8 * 10^19
> -		 */
> -		hash = l_get_le64(msg + 1) ^ l_get_le64(msg + 9);
> -		isNew = check_fast_cache(net, hash);
> -		if (!isNew)
> -			return;
> -
> -		l_debug("New");
> -	}
> -
> -	memcpy(packet + 2, data, size);
> -
> -	if (iv_index && (iv_index & 0x01) != iv_flag)
> -		iv_index--;
> 
>  	/* Tester--Drop 90% of packets */
>  	/* l_getrandom(&iv_flag, 1); */
>  	/* if (iv_flag%10<9) drop = true; */
> 
> -	if (!drop)
> -		print_packet("RX: Network [enc] :", data, size);
> -
> -	key_id = net_key_decrypt(iv_index, packet + 2, size, &out,
> &out_size);
> 
> -	if (!key_id) {
> -		l_debug("Failed to decode packet");
> -		/* Remove fast-cache-hash */
> -		l_queue_remove(net->fast_cache, isNew);
> -		l_free(isNew);
> -		return;
> -	}
> -
> -	memcpy(packet + 2, out, out_size);
> +	memcpy(packet + 2, data, size);
> 
>  	if (!drop)
>  		print_packet("RX: Network [clr] :", packet + 2, size); @@ -
> 2347,7 +2317,7 @@ static void packet_received(void *user_data, const void
> *data, uint8_t size,
>  					&net_segO, &net_segN,
>  					&msg, &app_msg_len)) {
>  		l_error("Failed to parse packet content");
> -		return;
> +		return RELAY_NONE;
>  	}
> 
>  	/* Ignore incoming packets if we are LPN and frnd bit not set */ @@ -
> 2357,7 +2327,7 @@ static void packet_received(void *user_data, const void
> *data, uint8_t size,
>  		subnet = l_queue_find(net->subnets, match_key_id,
> 
> 	L_UINT_TO_PTR(key_id));
>  		if (subnet)
> -			return;
> +			return RELAY_NONE;
> 
>  		/* If the queue is empty, stop polling */
>  		if (net_ctl && net_opcode == NET_OP_FRND_UPDATE &&
> !msg[5]) @@ -2368,16 +2338,16 @@ static void packet_received(void
> *user_data, const void *data, uint8_t size,
>  	} else if (net_dst == 0) {
>  		l_error("illegal parms: DST: %4.4x Ctl: %d TTL: %2.2x",
>  						net_dst, net_ctl, net_ttl);
> -		return;
> +		return RELAY_NONE;
>  	}
> 
>  	/* Ignore if we originally sent this */
>  	if (is_us(net, net_src, true))
> -		return;
> +		return RELAY_NONE;
> 
>  	if (drop) {
>  		l_info("Dropping SEQ 0x%06x", net_seq);
> -		return;
> +		return RELAY_NONE;
>  	}
> 
>  	l_debug("check %08x", cache_cookie);
> @@ -2385,7 +2355,7 @@ static void packet_received(void *user_data, const
> void *data, uint8_t size,
>  	/* As a Relay, suppress repeats of last N packets that pass through */
>  	/* The "cache_cookie" should be unique part of App message */
>  	if (msg_in_cache(net, net_src, net_seq, cache_cookie))
> -		return;
> +		return RELAY_NONE;
> 
>  	l_debug("RX: Network %04x -> %04x : TTL 0x%02x : IV : %8.8x SEQ
> 0x%06x",
>  			net_src, net_dst, net_ttl, iv_index, net_seq); @@ -
> 2403,12 +2373,12 @@ static void packet_received(void *user_data, const
> void *data, uint8_t size,
>  			if (net_opcode == NET_OP_SEG_ACKNOWLEDGE) {
>  				/* Illegal to send ACK to non-Unicast Addr */
>  				if (net_dst & 0x8000)
> -					return;
> +					return RELAY_NONE;
> 
>  				/* print_packet("Got ACK", msg,
> app_msg_len); */
>  				/* Pedantic check for correct size */
>  				if (app_msg_len != 7)
> -					return;
> +					return RELAY_NONE;
> 
>  				/* If this is an ACK to our friend queue-only
> */
>  				if (is_lpn_friend(net, net_dst, true)) @@ -
> 2468,28 +2438,37 @@ static void packet_received(void *user_data, const
> void *data, uint8_t size,
>  		if (!!(net_frnd))
>  			l_info("Ask for more data!");
> 
> -		/* If this is one of our Unicast addresses, don't relay */
> -		if (net_dst <= 0x7fff)
> -			return;
> +		/* If this is one of our Unicast addresses, disallow relay */
> +		if (IS_UNICAST(net_dst))
> +			return RELAY_DISALLOWED;
>  	}
> 
> +	/* If relay not enable, or no more hops allowed */
>  	if (!net->relay.enable || net_ttl < 0x02 || net_frnd)
> -		return;
> +		return RELAY_NONE;
> 
> -	packet[2 + 1] = (packet[2 + 1] & ~TTL_MASK) | (net_ttl - 1);
> +	/* Group or Virtual destinations should *always* be relayed */
> +	if (IS_GROUP(net_dst) || IS_VIRTUAL(net_dst))
> +		return RELAY_ALWAYS;
> 
> -	if (!net_key_encrypt(key_id, iv_index, packet + 2, size)) {
> -		l_error("Failed to encode relay packet");
> -		return;
> -	}
> +	/* Unicast destinations for other nodes *may* be relayed */
> +	else if (IS_UNICAST(net_dst))
> +		return RELAY_ALLOWED;
> 
> -	if (net->relay.enable)
> -		send_relay_pkt(net, packet, size + 1);
> +	/* Otherwise, do not make a relay decision */
> +	else
> +		return RELAY_NONE;
>  }
> 
>  struct net_queue_data {
>  	struct mesh_io_recv_info *info;
> +	struct mesh_net *net;
>  	const uint8_t *data;
> +	uint8_t *out;
> +	size_t out_size;
> +	enum _relay_advice relay_advice;
> +	uint32_t key_id;
> +	uint32_t iv_index;
>  	uint16_t len;
>  };
> 
> @@ -2497,30 +2476,78 @@ static void net_rx(void *net_ptr, void
> *user_data)  {
>  	struct net_queue_data *data = user_data;
>  	struct mesh_net *net = net_ptr;
> +	enum _relay_advice relay_advice;
> +	uint8_t *out;
> +	size_t out_size;
> +	uint32_t key_id;
>  	int8_t rssi = 0;
> 
> +	key_id = net_key_decrypt(net->iv_index, data->data, data->len,
> +								&out,
> &out_size);
> +
> +	if (!key_id)
> +		return;
> +
> +	print_packet("RX: Network [enc] :", data->data, data->len);
> +
>  	if (data->info) {
>  		net->instant = data->info->instant;
>  		net->chan = data->info->chan;
>  		rssi = data->info->rssi;
>  	}
> 
> -	packet_received(net, data->data, data->len, rssi);
> +	relay_advice = packet_received(net, key_id, net->iv_index,
> +							out, out_size, rssi);
> +	if (relay_advice > data->relay_advice) {
> +		bool iv_flag = !!(net->iv_index & 1);
> +		bool iv_pkt = !!(data->data[0] & 0x80);
> +
> +		data->iv_index = net->iv_index;
> +		if (iv_pkt != iv_flag)
> +			data->iv_index--;
> +
> +		data->relay_advice = relay_advice;
> +		data->key_id = key_id;
> +		data->net = net;
> +		data->out = out;
> +		data->out_size = out_size;
> +	}
>  }
> 
>  static void net_msg_recv(void *user_data, struct mesh_io_recv_info *info,
>  					const uint8_t *data, uint16_t len)  {
> +	uint64_t hash;
> +	bool isNew;
>  	struct net_queue_data net_data = {
>  		.info = info,
>  		.data = data + 1,
>  		.len = len - 1,
> +		.relay_advice = RELAY_NONE,
>  	};
> 
> -	if (len <= 2)
> +	if (len < 9)
> +		return;
> +
> +	hash = l_get_le64(data + 1);
> +
> +	/* Only process packet once per reception */
> +	isNew = check_fast_cache(hash);
> +	if (!isNew)
>  		return;
> 
>  	l_queue_foreach(nets, net_rx, &net_data);
> +
> +	if (net_data.relay_advice == RELAY_ALWAYS ||
> +			net_data.relay_advice == RELAY_ALLOWED) {
> +		uint8_t ttl = net_data.out[1] & TTL_MASK;
> +
> +		net_data.out[1] &=  ~TTL_MASK;
> +		net_data.out[1] |= ttl - 1;
> +		net_key_encrypt(net_data.key_id, net_data.iv_index,
> +					net_data.out, net_data.out_size);
> +		send_relay_pkt(net_data.net, net_data.out,
> net_data.out_size);
> +	}
>  }
> 
>  static void set_network_beacon(void *a, void *b) @@ -2927,6 +2954,9 @@
> bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
>  		if (!nets)
>  			nets = l_queue_new();
> 
> +		if (!fast_cache)
> +			fast_cache = l_queue_new();
> +
>  		l_info("Register io cb");
>  		mesh_io_register_recv_cb(io, MESH_IO_FILTER_BEACON,
>  							beacon_recv, net);
> --
> 2.14.5

