Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E8C54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjAXU1B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjAXU0l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:41 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E04B1B5
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lp10so12857784pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=407Z2w0BBlNKEhCLrOumCSQPsx6l5mvADFbiNUhctXE=;
        b=gQvJcOC0/QSbNMK8lrCnyN51TT9xq2lGUgo5Q9jSRREmam9HH0KfsAjTnFNhCO4yCg
         IxzEv8u57jiomASF0KbR0b86dbuyjrlMENkQu72Ir0dE0Wlt5fgnwvGPiNqvNgkV/GXM
         sH5v8M+Wo/pZ9X4WChHjQiwngsSRRPDZICahIoULpXd3N9IOYkXHwfWt472iHOw225XJ
         Le+wR3l59p/LjthnyNuVu0wvPAgLmi3IfDSFo8h8obUXYB20PpRap6lrl7q508R12vN/
         aFwjFcVjzU8t0//LMh9PycxGNDMBqpDIbug2RL/8GY4CAcAP6kHcK0GJEU0ZJ5ySt/Di
         07iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=407Z2w0BBlNKEhCLrOumCSQPsx6l5mvADFbiNUhctXE=;
        b=myegGnE+0HqGSrBzPSyZITD75m1DQr9T+8cu+UiovQmc/t3trWJoc9a8Lj8ookQ+Cu
         cesQuNgSVPqrNHLMH7DkARemX6IZi0lpnqXbJA8n/TjiC/yrAVJ5Cri9wiQ7U2f3J01V
         gGGQwrRX4VD/+7X6w371c7rLDpkH64G3dStHwI7Ue/IdKtvR0cehHnc81Y6qTSXFxgN1
         ssWbQ4x7e2BHvYH6DzB4KCRGwCP9dfByDrv/mMhdwiZ3Wo5ViAE48YLZDl6wUHGO012w
         6V9Fbg3OkvsOHrvWNsqSFs5VnNEABTnUI7g/o0geoJ9ti9BLZkLkEbjQv0Nr7FIkM24/
         dvIw==
X-Gm-Message-State: AFqh2krG2jJ8WvDitVYCgS+M9ySSWM0jW2rH24Y1JrIpmdloAxICJL+T
        hh5VI9HDQ/DkTjqsF1Vfrqco4XqaAHoP8A==
X-Google-Smtp-Source: AMrXdXuBe3fC0xiOMXdAgTAo2EUQCJO8a4i8L2veZbcvi++IcFdEeC8d0tsbD6QIosKiGf3uC9uHxg==
X-Received: by 2002:a17:902:a418:b0:194:a6e0:3ba with SMTP id p24-20020a170902a41800b00194a6e003bamr27769188plq.54.1674591988311;
        Tue, 24 Jan 2023 12:26:28 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:27 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v4 08/13] mesh: Add Tx/Rx support of Mesh Private Beacons
Date:   Tue, 24 Jan 2023 12:26:11 -0800
Message-Id: <20230124202616.310544-9-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

With this change, we start evaluating received Mesh Private Beacons in
addition to the legacy Secure Network Beacons. We also add the ability
to request Tx of Mesh Private Beacons, which are regenerated with new
Random Nonce a minimum of every 0 - 2550 seconds.
---
 mesh/net-keys.c | 501 +++++++++++++++++++++++++++++++++++++-----------
 mesh/net-keys.h |  10 +-
 mesh/net.c      | 172 ++++++++++++-----
 mesh/net.h      |   6 +-
 mesh/node.c     |   4 +-
 5 files changed, 519 insertions(+), 174 deletions(-)

diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index ee7bbf0c0..0ba051d79 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -21,39 +21,55 @@
 #include "mesh/net.h"
 #include "mesh/net-keys.h"
 
-#define BEACON_TYPE_SNB		0x01
-#define KEY_REFRESH		0x01
-#define IV_INDEX_UPDATE		0x02
-
 #define BEACON_INTERVAL_MIN	10
 #define BEACON_INTERVAL_MAX	600
 
-struct net_beacon {
+/* This allows daemon to skip decryption on recently seen beacons */
+#define BEACON_CACHE_MAX	10
+
+struct beacon_rx {
+	uint8_t data[28];
+	uint32_t id;
+	uint32_t ivi;
+	bool kr;
+	bool ivu;
+};
+
+struct beacon_observe {
 	struct l_timeout *timeout;
 	uint32_t ts;
-	uint16_t observe_period;
-	uint16_t observed;
+	uint16_t period;
+	uint16_t seen;
 	uint16_t expected;
 	bool half_period;
-	uint8_t beacon[23];
 };
 
 struct net_key {
 	uint32_t id;
-	struct net_beacon snb;
+	struct l_timeout *mpb_to;
+	uint8_t *mpb;
+	uint8_t *snb;
+	struct beacon_observe observe;
+	uint32_t ivi;
 	uint16_t ref_cnt;
-	uint16_t beacon_enables;
+	uint16_t mpb_enables;
+	uint16_t snb_enables;
+	uint8_t mpb_refresh;
 	uint8_t friend_key;
 	uint8_t nid;
 	uint8_t flooding[16];
-	uint8_t encrypt[16];
-	uint8_t privacy[16];
-	uint8_t beacon[16];
-	uint8_t network[8];
+	uint8_t enc_key[16];
+	uint8_t prv_key[16];
+	uint8_t snb_key[16];
+	uint8_t pvt_key[16];
+	uint8_t net_id[8];
+	bool kr;
+	bool ivu;
 };
 
-static struct l_queue *keys = NULL;
-static uint32_t last_flooding_id = 0;
+static struct l_queue *beacons;
+static struct l_queue *keys;
+static uint32_t last_flooding_id;
 
 /* To avoid re-decrypting same packet for multiple nodes, cache and check */
 static uint8_t cache_pkt[29];
@@ -81,9 +97,9 @@ static bool match_id(const void *a, const void *b)
 static bool match_network(const void *a, const void *b)
 {
 	const struct net_key *key = a;
-	const uint8_t *network = b;
+	const uint8_t *net_id = b;
 
-	return memcmp(key->network, network, sizeof(key->network)) == 0;
+	return memcmp(key->net_id, net_id, sizeof(key->net_id)) == 0;
 }
 
 /* Key added from Provisioning, NetKey Add or NetKey update */
@@ -101,19 +117,26 @@ uint32_t net_key_add(const uint8_t flooding[16])
 	if (!keys)
 		keys = l_queue_new();
 
+	if (!beacons)
+		beacons = l_queue_new();
+
 	key = l_new(struct net_key, 1);
 	memcpy(key->flooding, flooding, 16);
 	key->ref_cnt++;
-	result = mesh_crypto_k2(flooding, p, sizeof(p), &key->nid, key->encrypt,
-								key->privacy);
+	result = mesh_crypto_k2(flooding, p, sizeof(p), &key->nid, key->enc_key,
+								key->prv_key);
 	if (!result)
 		goto fail;
 
-	result = mesh_crypto_k3(flooding, key->network);
+	result = mesh_crypto_k3(flooding, key->net_id);
 	if (!result)
 		goto fail;
 
-	result = mesh_crypto_nkbk(flooding, key->beacon);
+	result = mesh_crypto_nkbk(flooding, key->snb_key);
+	if (!result)
+		goto fail;
+
+	result = mesh_crypto_nkpk(flooding, key->pvt_key);
 	if (!result)
 		goto fail;
 
@@ -146,7 +169,7 @@ uint32_t net_key_frnd_add(uint32_t flooding_id, uint16_t lpn, uint16_t frnd,
 	l_put_be16(fn_cnt, p + 7);
 
 	result = mesh_crypto_k2(key->flooding, p, sizeof(p), &frnd_key->nid,
-				frnd_key->encrypt, frnd_key->privacy);
+				frnd_key->enc_key, frnd_key->prv_key);
 
 	if (!result) {
 		l_free(frnd_key);
@@ -167,7 +190,7 @@ void net_key_unref(uint32_t id)
 
 	if (key && key->ref_cnt) {
 		if (--key->ref_cnt == 0) {
-			l_timeout_remove(key->snb.timeout);
+			l_timeout_remove(key->observe.timeout);
 			l_queue_remove(keys, key);
 			l_free(key);
 		}
@@ -206,7 +229,7 @@ static void decrypt_net_pkt(void *a, void *b)
 
 	result = mesh_crypto_packet_decode(cache_pkt, cache_len, false,
 						cache_plain, cache_iv_index,
-						key->encrypt, key->privacy);
+						key->enc_key, key->prv_key);
 
 	if (result) {
 		cache_id = key->id;
@@ -254,8 +277,8 @@ bool net_key_encrypt(uint32_t id, uint32_t iv_index, uint8_t *pkt, size_t len)
 	if (!key)
 		return false;
 
-	result = mesh_crypto_packet_encode(pkt, len, iv_index, key->encrypt,
-							key->privacy);
+	result = mesh_crypto_packet_encode(pkt, len, iv_index, key->enc_key,
+							key->prv_key);
 
 	if (!result)
 		return false;
@@ -265,9 +288,9 @@ bool net_key_encrypt(uint32_t id, uint32_t iv_index, uint8_t *pkt, size_t len)
 	return result;
 }
 
-uint32_t net_key_network_id(const uint8_t network[8])
+uint32_t net_key_network_id(const uint8_t net_id[8])
 {
-	struct net_key *key = l_queue_find(keys, match_network, network);
+	struct net_key *key = l_queue_find(keys, match_network, net_id);
 
 	if (!key)
 		return 0;
@@ -275,6 +298,55 @@ uint32_t net_key_network_id(const uint8_t network[8])
 	return key->id;
 }
 
+struct auth_check {
+	const uint8_t *data;
+	uint32_t id;
+	uint32_t ivi;
+	bool ivu;
+	bool kr;
+};
+
+static void check_auth(void *a, void *b)
+{
+	struct net_key *key = a;
+	struct auth_check *auth = b;
+	uint8_t out[5];
+
+
+	/* Stop checking if already found */
+	if (auth->id)
+		return;
+
+	if (mesh_crypto_aes_ccm_decrypt(auth->data + 1, key->pvt_key, NULL, 0,
+							auth->data + 14, 13,
+							out, NULL, 8)) {
+		auth->id = key->id;
+		auth->ivi = l_get_be32(out + 1);
+		auth->ivu = !!(out[0] & 0x02);
+		auth->kr = !!(out[0] & 0x01);
+	}
+}
+
+static uint32_t private_beacon_check(const void *beacon, uint32_t *ivi,
+							bool *ivu, bool *kr)
+{
+	struct auth_check auth = {
+		.data = beacon,
+		.id = 0,
+	};
+
+	auth.id = 0;
+	l_queue_foreach(keys, check_auth, &auth);
+
+	if (auth.id) {
+		*ivi = auth.ivi;
+		*ivu = auth.ivu;
+		*kr = auth.kr;
+	}
+
+	return auth.id;
+}
+
 bool net_key_snb_check(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 								uint64_t cmac)
 {
@@ -285,7 +357,7 @@ bool net_key_snb_check(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 		return false;
 
 	/* Any behavioral changes must pass CMAC test */
-	if (!mesh_crypto_beacon_cmac(key->beacon, key->network, iv_index, kr,
+	if (!mesh_crypto_beacon_cmac(key->snb_key, key->net_id, iv_index, kr,
 							ivu, &cmac_check)) {
 		l_error("mesh_crypto_beacon_cmac failed");
 		return false;
@@ -300,39 +372,142 @@ bool net_key_snb_check(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 	return true;
 }
 
-bool net_key_snb_compose(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
-								uint8_t *snb)
+static bool mpb_compose(struct net_key *key, uint32_t ivi, bool kr, bool ivu)
+{
+	uint8_t b_data[5 + 8];
+	uint8_t random[13];
+
+	if (!key)
+		return false;
+
+	b_data[0] = 0;
+	l_put_be32(ivi, b_data + 1);
+
+	if (kr)
+		b_data[0] |= KEY_REFRESH;
+
+	if (ivu)
+		b_data[0] |= IV_INDEX_UPDATE;
+
+	l_getrandom(random, sizeof(random));
+	if (!mesh_crypto_aes_ccm_encrypt(random, key->pvt_key, NULL, 0,
+						b_data, 5, b_data, NULL, 8))
+		return false;
+
+	key->mpb[0] = MESH_AD_TYPE_BEACON;
+	key->mpb[1] = BEACON_TYPE_MPB;
+	memcpy(key->mpb + 2, random, 13);
+	memcpy(key->mpb + 15, b_data, 13);
+
+	return true;
+}
+
+static bool snb_compose(struct net_key *key, uint32_t ivi, bool kr, bool ivu)
 {
-	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
 	uint64_t cmac;
 
 	if (!key)
 		return false;
 
 	/* Any behavioral changes must pass CMAC test */
-	if (!mesh_crypto_beacon_cmac(key->beacon, key->network, iv_index, kr,
+	if (!mesh_crypto_beacon_cmac(key->snb_key, key->net_id, ivi, kr,
 								ivu, &cmac)) {
 		l_error("mesh_crypto_beacon_cmac failed");
 		return false;
 	}
 
-	snb[0] = MESH_AD_TYPE_BEACON;
-	snb[1] = BEACON_TYPE_SNB;
-	snb[2] = 0;
+	key->snb[0] = MESH_AD_TYPE_BEACON;
+	key->snb[1] = BEACON_TYPE_SNB;
+	key->snb[2] = 0;
 
 	if (kr)
-		snb[2] |= KEY_REFRESH;
+		key->snb[2] |= KEY_REFRESH;
 
 	if (ivu)
-		snb[2] |= IV_INDEX_UPDATE;
+		key->snb[2] |= IV_INDEX_UPDATE;
 
-	memcpy(snb + 3, key->network, 8);
-	l_put_be32(iv_index, snb + 11);
-	l_put_be64(cmac, snb + 15);
+	memcpy(key->snb + 3, key->net_id, 8);
+	l_put_be32(ivi, key->snb + 11);
+	l_put_be64(cmac, key->snb + 15);
 
 	return true;
 }
 
+static bool match_beacon(const void *a, const void *b)
+{
+	const struct beacon_rx *cached = a;
+	const uint8_t *incoming = b;
+
+	if (incoming[0] == BEACON_TYPE_MPB)
+		return !memcmp(cached->data, incoming, 27);
+
+	if (incoming[0] == BEACON_TYPE_SNB)
+		return !memcmp(cached->data, incoming, 22);
+
+	return false;
+}
+
+uint32_t net_key_beacon(const uint8_t *data, uint16_t len, uint32_t *ivi,
+							bool *ivu, bool *kr)
+{
+	struct net_key *key;
+	struct beacon_rx *beacon;
+	uint32_t b_id, b_ivi;
+	bool b_ivu, b_kr;
+
+	if (data[1] == BEACON_TYPE_SNB && len != 23)
+		return 0;
+
+	if (data[1] == BEACON_TYPE_MPB && len != 28)
+		return 0;
+
+	beacon = l_queue_remove_if(beacons, match_beacon, data + 1);
+
+	if (beacon)
+		goto accept;
+
+	/* Validate beacon data */
+	if (data[1] == BEACON_TYPE_SNB) {
+		key = l_queue_find(keys, match_network, data + 3);
+
+		if (!key)
+			return 0;
+
+		b_id = key->id;
+		b_ivu = !!(data[2] & 0x02);
+		b_kr = !!(data[2] & 0x01);
+		b_ivi = l_get_be32(data + 11);
+
+		if (!net_key_snb_check(b_id, b_ivi, b_kr, b_ivu,
+							l_get_be64(data + 15)))
+			return 0;
+
+	} else if (data[1] == BEACON_TYPE_MPB) {
+		b_id = private_beacon_check(data + 1, &b_ivi, &b_ivu, &b_kr);
+
+		if (!b_id)
+			return 0;
+
+	} else
+		return 0;
+
+	beacon = l_new(struct beacon_rx, 1);
+	memcpy(beacon->data, data + 1, len - 1);
+	beacon->id = b_id;
+	beacon->ivi = b_ivi;
+	beacon->ivu = b_ivu;
+	beacon->kr = b_kr;
+
+accept:
+	*ivi = beacon->ivi;
+	*ivu = beacon->ivu;
+	*kr = beacon->kr;
+
+	l_queue_push_head(beacons, beacon);
+
+	return beacon->id;
+}
+
 static void send_network_beacon(struct net_key *key)
 {
 	struct mesh_io_send_info info = {
@@ -343,10 +518,26 @@ static void send_network_beacon(struct net_key *key)
 		.u.gen.max_delay = DEFAULT_MAX_DELAY
 	};
 
-	mesh_io_send(NULL, &info, key->snb.beacon, sizeof(key->snb.beacon));
+	if (key->mpb_enables) {
+		/* If Interval steps == 0, refresh key every time */
+		if (!key->mpb_refresh || !key->mpb || !key->mpb[0])
+			net_key_beacon_refresh(key->id, key->ivi, key->kr,
+								key->ivu, true);
+
+		mesh_io_send(NULL, &info, key->mpb, 28);
+	}
+
+	if (key->snb_enables) {
+		if (!key->snb || !key->snb[0]) {
+			net_key_beacon_refresh(key->id, key->ivi, key->kr,
+								key->ivu, true);
+		}
+
+		mesh_io_send(NULL, &info, key->snb, 23);
+	}
 }
 
-static void snb_timeout(struct l_timeout *timeout, void *user_data)
+static void beacon_timeout(struct l_timeout *timeout, void *user_data)
 {
 	struct net_key *key = user_data;
 	uint32_t interval, scale_factor;
@@ -355,29 +546,29 @@ static void snb_timeout(struct l_timeout *timeout, void *user_data)
 	send_network_beacon(key);
 
 	/* Count our own beacons towards the vicinity total */
-	key->snb.observed++;
+	key->observe.seen++;
 
-	if (!key->snb.half_period) {
+	if (!key->observe.half_period) {
 
 		l_debug("beacon %d for %d nodes, period %d, obs %d, exp %d",
-						key->id,
-						key->beacon_enables,
-						key->snb.observe_period,
-						key->snb.observed,
-						key->snb.expected);
+					key->id,
+					key->snb_enables + key->mpb_enables,
+					key->observe.period,
+					key->observe.seen,
+					key->observe.expected);
 
 
-		interval = (key->snb.observe_period * key->snb.observed)
-							/ key->snb.expected;
+		interval = (key->observe.period * key->observe.seen)
+							/ key->observe.expected;
 
 		/* Limit Increases and Decreases by 10 seconds Up and
 		 * 20 seconds down each step, to avoid going nearly silent
 		 * in highly populated environments.
 		 */
-		if (interval - 10 > key->snb.observe_period)
-			interval = key->snb.observe_period + 10;
-		else if (interval + 20 < key->snb.observe_period)
-			interval = key->snb.observe_period - 20;
+		if (interval - 10 > key->observe.period)
+			interval = key->observe.period + 10;
+		else if (interval + 20 < key->observe.period)
+			interval = key->observe.period - 20;
 
 		/* Beaconing must be no *slower* than once every 10 minutes,
 		 * and no *faster* than once every 10 seconds, per spec.
@@ -388,26 +579,26 @@ static void snb_timeout(struct l_timeout *timeout, void *user_data)
 		else if (interval > BEACON_INTERVAL_MAX * 2)
 			interval = BEACON_INTERVAL_MAX * 2;
 
-		key->snb.observe_period = interval;
-		key->snb.observed = 0;
+		key->observe.period = interval;
+		key->observe.seen = 0;
 
 		/* To prevent "over slowing" of the beaconing frequency,
 		 * require more significant "over observing" the slower
 		 * our own beaconing frequency.
 		 */
-		key->snb.expected = interval / 10;
+		key->observe.expected = interval / 10;
 		scale_factor = interval / 60;
-		key->snb.expected += scale_factor * 3;
+		key->observe.expected += scale_factor * 3;
 	}
 
-	interval = key->snb.observe_period / 2;
-	key->snb.half_period = !key->snb.half_period;
+	interval = key->observe.period / 2;
+	key->observe.half_period = !key->observe.half_period;
 
-	if (key->beacon_enables)
+	if (key->mpb_enables || key->snb_enables)
 		l_timeout_modify(timeout, interval);
 	else {
 		l_timeout_remove(timeout);
-		key->snb.timeout = NULL;
+		key->observe.timeout = NULL;
 	}
 }
 
@@ -416,8 +607,8 @@ void net_key_beacon_seen(uint32_t id)
 	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
 
 	if (key) {
-		key->snb.observed++;
-		key->snb.ts = get_timestamp_secs();
+		key->observe.seen++;
+		key->observe.ts = get_timestamp_secs();
 	}
 }
 
@@ -426,12 +617,83 @@ uint32_t net_key_beacon_last_seen(uint32_t id)
 	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
 
 	if (key)
-		return key->snb.ts;
+		return key->observe.ts;
 
 	return 0;
 }
 
-void net_key_beacon_enable(uint32_t id)
+bool net_key_beacon_refresh(uint32_t id, uint32_t ivi, bool kr, bool ivu,
+								bool force)
+{
+	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
+	bool refresh = force;
+	uint32_t rand_ms;
+
+	if (!key)
+		return false;
+
+	if (key->snb_enables && !key->snb) {
+		key->snb = l_new(uint8_t, 23);
+		refresh = true;
+	}
+
+	if (key->mpb_enables && !key->mpb) {
+		key->mpb = l_new(uint8_t, 28);
+		refresh = true;
+	}
+
+	if (key->ivi != ivi || key->ivu != ivu || key->kr != kr)
+		refresh = true;
+
+	if (!refresh)
+		return true;
+
+	if (key->mpb) {
+		if (!mpb_compose(key, ivi, kr, ivu))
+			return false;
+
+		print_packet("Set MPB to", key->mpb, 28);
+	}
+
+	if (key->snb) {
+		if (!snb_compose(key, ivi, kr, ivu))
+			return false;
+
+		print_packet("Set SNB to", key->snb, 23);
+	}
+
+	l_debug("Set Beacon: IVI: %8.8x, IVU: %d, KR: %d", ivi, ivu, kr);
+
+	/* Propagate changes to all local nodes */
+	net_local_beacon(id, ivi, ivu, kr);
+
+	/* Send one new SNB soon, after all nodes have seen it */
+	l_getrandom(&rand_ms, sizeof(rand_ms));
+	rand_ms %= 1000;
+	key->observe.expected++;
+
+	if (key->observe.timeout)
+		l_timeout_modify_ms(key->observe.timeout, 500 + rand_ms);
+	else
+		key->observe.timeout = l_timeout_create_ms(500 + rand_ms,
+						beacon_timeout, key, NULL);
+
+	return true;
+}
+
+static void mpb_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct net_key *key = user_data;
+
+	if (key->mpb_refresh) {
+		l_debug("Refresh in %d seconds", key->mpb_refresh * 10);
+		l_timeout_modify(timeout, key->mpb_refresh * 10);
+	}
+
+	net_key_beacon_refresh(key->id, key->ivi, key->kr, key->ivu, true);
+}
+
+void net_key_beacon_enable(uint32_t id, bool mpb, uint8_t refresh_count)
 {
 	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
 	bool enabled;
@@ -440,8 +702,19 @@ void net_key_beacon_enable(uint32_t id)
 	if (!key)
 		return;
 
-	enabled = !!key->beacon_enables;
-	key->beacon_enables++;
+	enabled = !!key->snb_enables || !!key->mpb_enables;
+
+	if (mpb) {
+		key->mpb_enables++;
+		key->mpb_refresh = refresh_count;
+		l_timeout_remove(key->mpb_to);
+		if (refresh_count)
+			key->mpb_to = l_timeout_create(refresh_count * 10,
+						mpb_timeout, key, NULL);
+		else
+			key->mpb_to = NULL;
+	} else
+		key->snb_enables++;
 
 	/* If already Enabled, do nothing */
 	if (enabled)
@@ -453,70 +726,68 @@ void net_key_beacon_enable(uint32_t id)
 	rand_ms++;
 
 	/* Enable Periodic Beaconing on this key */
-	key->snb.observe_period = BEACON_INTERVAL_MIN * 2;
-	key->snb.expected = 2;
-	key->snb.observed = 0;
-	key->snb.half_period = true;
-	l_timeout_remove(key->snb.timeout);
-	key->snb.timeout = l_timeout_create_ms(rand_ms, snb_timeout, key, NULL);
+	key->observe.period = BEACON_INTERVAL_MIN * 2;
+	key->observe.expected = 2;
+	key->observe.seen = 0;
+	key->observe.half_period = true;
+	l_timeout_remove(key->observe.timeout);
+	key->observe.timeout = l_timeout_create_ms(rand_ms, beacon_timeout,
+								key, NULL);
 }
 
-bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu)
+void net_key_beacon_disable(uint32_t id, bool mpb)
 {
 	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
-	uint8_t beacon[23];
-	uint32_t rand_ms;
 
 	if (!key)
-		return false;
+		return;
 
-	if (!net_key_snb_compose(id, iv_index, kr, ivu, beacon))
-		return false;
+	if (mpb) {
+		if (!key->mpb_enables)
+			return;
 
-	if (memcmp(key->snb.beacon, beacon, sizeof(beacon)))
-		memcpy(key->snb.beacon, beacon, sizeof(beacon));
-	else
-		return false;
+		key->mpb_enables--;
 
-	l_debug("Setting SNB: IVI: %8.8x, IVU: %d, KR: %d", iv_index, ivu, kr);
-	print_packet("Set SNB Beacon to", beacon, sizeof(beacon));
+		if (!key->mpb_enables) {
+			l_free(key->mpb);
+			key->mpb = NULL;
+			l_timeout_remove(key->mpb_to);
+			key->mpb_to = NULL;
+		}
+	} else {
+		if (!key->snb_enables)
+			return;
 
-	/* Propagate changes to all local nodes */
-	net_local_beacon(id, beacon);
+		key->snb_enables--;
 
-	/* Send one new SNB soon, after all nodes have seen it */
-	l_getrandom(&rand_ms, sizeof(rand_ms));
-	rand_ms %= 1000;
-	key->snb.expected++;
+		if (!key->snb_enables) {
+			l_free(key->snb);
+			key->snb = NULL;
+		}
+	}
 
-	if (key->snb.timeout)
-		l_timeout_modify_ms(key->snb.timeout, 500 + rand_ms);
-	else
-		key->snb.timeout = l_timeout_create_ms(500 + rand_ms,
-						snb_timeout, key, NULL);
+	if (key->snb_enables || key->mpb_enables)
+		return;
 
-	return true;
+	/* Disable periodic Beaconing on this key */
+	l_timeout_remove(key->observe.timeout);
+	key->observe.timeout = NULL;
 }
 
-void net_key_beacon_disable(uint32_t id)
+static void free_key(void *data)
 {
-	struct net_key *key = l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
-
-	if (!key || !key->beacon_enables)
-		return;
-
-	key->beacon_enables--;
+	struct net_key *key = data;
 
-	if (key->beacon_enables)
-		return;
-
-	/* Disable periodic Beaconing on this key */
-	l_timeout_remove(key->snb.timeout);
-	key->snb.timeout = NULL;
+	l_timeout_remove(key->mpb_to);
+	l_free(key->snb);
+	l_free(key->mpb);
+	l_free(key);
 }
 
 void net_key_cleanup(void)
 {
-	l_queue_destroy(keys, l_free);
+	l_queue_destroy(keys, free_key);
 	keys = NULL;
+	l_queue_destroy(beacons, l_free);
+	beacons = NULL;
 }
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index 420618f71..a3909448c 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -9,6 +9,7 @@
  */
 
 #define BEACON_TYPE_SNB		0x01
+#define BEACON_TYPE_MPB		0x02
 #define KEY_REFRESH		0x01
 #define IV_INDEX_UPDATE		0x02
 
@@ -23,12 +24,15 @@ uint32_t net_key_decrypt(uint32_t iv_index, const uint8_t *pkt, size_t len,
 					uint8_t **plain, size_t *plain_len);
 bool net_key_encrypt(uint32_t id, uint32_t iv_index, uint8_t *pkt, size_t len);
 uint32_t net_key_network_id(const uint8_t network[8]);
+uint32_t net_key_beacon(const uint8_t *data, uint16_t len, uint32_t *ivi,
+							bool *ivu, bool *kr);
 bool net_key_snb_check(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 								uint64_t cmac);
 bool net_key_snb_compose(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 								uint8_t *snb);
 void net_key_beacon_seen(uint32_t id);
-void net_key_beacon_enable(uint32_t id);
-bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu);
-void net_key_beacon_disable(uint32_t id);
+bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
+								bool force);
+void net_key_beacon_enable(uint32_t id, bool mpb, uint8_t refresh_count);
+void net_key_beacon_disable(uint32_t id, bool mpb);
 uint32_t net_key_beacon_last_seen(uint32_t id);
diff --git a/mesh/net.c b/mesh/net.c
index 1d27289bf..81f1e57ee 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -102,7 +102,8 @@ struct mesh_net {
 	unsigned int sar_id_next;
 
 	bool friend_enable;
-	bool beacon_enable;
+	bool snb_enable;
+	bool mpb_enable;
 	bool proxy_enable;
 	bool friend_seq;
 	struct l_timeout *iv_update_timeout;
@@ -119,6 +120,7 @@ struct mesh_net {
 	uint8_t chan; /* Channel of recent Rx */
 	uint8_t default_ttl;
 	uint8_t tid;
+	uint8_t mpb_period;
 
 	struct {
 		bool enable;
@@ -217,6 +219,7 @@ struct net_beacon_data {
 	bool ivu;
 	bool kr;
 	bool processed;
+	bool local;
 };
 
 static struct l_queue *fast_cache;
@@ -526,6 +529,13 @@ static void mesh_sar_free(void *data)
 static void subnet_free(void *data)
 {
 	struct mesh_subnet *subnet = data;
+	struct mesh_net *net = subnet->net;
+
+	if (net->snb_enable)
+		net_key_beacon_disable(subnet->net_key_tx, false);
+
+	if (net->mpb_enable)
+		net_key_beacon_disable(subnet->net_key_tx, true);
 
 	net_key_unref(subnet->net_key_cur);
 	net_key_unref(subnet->net_key_upd);
@@ -545,15 +555,27 @@ static struct mesh_subnet *subnet_new(struct mesh_net *net, uint16_t idx)
 	return subnet;
 }
 
-static void enable_beacon(void *a, void *b)
+static void enable_snb(void *a, void *b)
 {
 	struct mesh_subnet *subnet = a;
 	struct mesh_net *net = b;
 
-	if (net->beacon_enable)
-		net_key_beacon_enable(subnet->net_key_tx);
+	if (net->snb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, false, 0);
 	else
-		net_key_beacon_disable(subnet->net_key_tx);
+		net_key_beacon_disable(subnet->net_key_tx, false);
+}
+
+static void enable_mpb(void *a, void *b)
+{
+	struct mesh_subnet *subnet = a;
+	struct mesh_net *net = b;
+
+	if (net->mpb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, true,
+							net->mpb_period);
+	else
+		net_key_beacon_disable(subnet->net_key_tx, true);
 }
 
 static void enqueue_update(void *a, void *b);
@@ -602,7 +624,8 @@ static void refresh_beacon(void *a, void *b)
 	struct mesh_net *net = b;
 
 	net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
-		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update);
+		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update,
+									false);
 }
 
 struct mesh_net *mesh_net_new(struct mesh_node *node)
@@ -826,7 +849,7 @@ int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 	if (idx == net->hb_pub.net_idx)
 		net->hb_pub.dst = UNASSIGNED_ADDRESS;
 
-	/* TODO: cancel beacon_enable on this subnet */
+	/* TODO: cancel snb_enable on this subnet */
 
 	l_queue_remove(net->subnets, subnet);
 	subnet_free(subnet);
@@ -853,10 +876,14 @@ static struct mesh_subnet *add_key(struct mesh_net *net, uint16_t idx,
 	}
 
 	net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
-						false, net->iv_update);
+						false, net->iv_update, false);
 
-	if (net->beacon_enable)
-		net_key_beacon_enable(subnet->net_key_tx);
+	if (net->snb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, false, 0);
+
+	if (net->mpb_enable)
+		net_key_beacon_enable(subnet->net_key_tx, true,
+							net->mpb_period);
 
 	l_queue_push_tail(net->subnets, subnet);
 
@@ -2794,83 +2821,111 @@ static void process_beacon(void *net_ptr, void *user_data)
 	beacon_data->processed = true;
 
 	/*
-	 * Ignore the beacon if it doesn't change anything, unless we're
-	 * doing IV Recovery
+	 * Ignore local beacons and beacons that don't change anything,
+	 * unless we're doing IV Recovery
 	 */
-	if (net->iv_upd_state == IV_UPD_INIT || ivi != net->iv_index ||
+	if (!beacon_data->local) {
+		if (net->iv_upd_state == IV_UPD_INIT || ivi != net->iv_index ||
 							ivu != net->iv_update)
-		updated |= update_iv_ivu_state(net, ivi, ivu);
+			updated |= update_iv_ivu_state(net, ivi, ivu);
+
+		if (kr != local_kr)
+			updated |= update_kr_state(subnet, kr,
+						beacon_data->net_key_id);
 
-	if (kr != local_kr || beacon_data->net_key_id != subnet->net_key_cur)
-		updated |= update_kr_state(subnet, kr, beacon_data->net_key_id);
 
-	if (updated)
-		net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
+		if (updated)
+			net_key_beacon_refresh(beacon_data->net_key_id,
+				net->iv_index,
 				!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO),
-								net->iv_update);
+				net->iv_update, false);
+	}
 }
 
 static void beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len)
 {
 	struct net_beacon_data beacon_data = {
+		.local = false,
 		.processed = false,
 	};
 
-	if (len != 23 || data[1] != 0x01)
-		return;
+	beacon_data.net_key_id = net_key_beacon(data, len, &beacon_data.ivi,
+					&beacon_data.ivu, &beacon_data.kr);
 
-	/* Ignore Network IDs unknown to this daemon */
-	beacon_data.net_key_id = net_key_network_id(data + 3);
 	if (!beacon_data.net_key_id)
 		return;
 
-	/* Get data bits from beacon */
-	beacon_data.ivu = !!(data[2] & 0x02);
-	beacon_data.kr = !!(data[2] & 0x01);
-	beacon_data.ivi = l_get_be32(data + 11);
-
-	/* Validate beacon before accepting */
-	if (!net_key_snb_check(beacon_data.net_key_id, beacon_data.ivi,
-					beacon_data.kr, beacon_data.ivu,
-					l_get_be64(data + 15))) {
-		l_error("mesh_crypto_beacon verify failed");
-		return;
-	}
-
 	l_queue_foreach(nets, process_beacon, &beacon_data);
 
 	if (beacon_data.processed)
 		net_key_beacon_seen(beacon_data.net_key_id);
 }
 
-void net_local_beacon(uint32_t net_key_id, uint8_t *beacon)
+void net_local_beacon(uint32_t net_key_id, uint32_t ivi, bool ivu, bool kr)
 {
 	struct net_beacon_data beacon_data = {
+		.local = true,
+		.processed = false,
 		.net_key_id = net_key_id,
-		.ivu = !!(beacon[2] & 0x02),
-		.kr = !!(beacon[2] & 0x01),
-		.ivi = l_get_be32(beacon + 11),
+		.ivu = ivu,
+		.kr = kr,
+		.ivi = ivi,
 	};
 
 	/* Deliver locally generated beacons to all nodes */
 	l_queue_foreach(nets, process_beacon, &beacon_data);
 }
 
-bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable)
+bool mesh_net_set_snb_mode(struct mesh_net *net, bool enable)
 {
 	if (!net)
 		return false;
 
-	if (net->beacon_enable == enable)
+	if (net->snb_enable == enable)
 		return true;
 
-	net->beacon_enable = enable;
+	net->snb_enable = enable;
 
 	if (enable)
 		l_queue_foreach(net->subnets, refresh_beacon, net);
 
-	l_queue_foreach(net->subnets, enable_beacon, net);
+	l_queue_foreach(net->subnets, enable_snb, net);
+	queue_friend_update(net);
+
+	return true;
+}
+
+bool mesh_net_set_mpb_mode(struct mesh_net *net, bool enable, uint8_t period,
+								bool initialize)
+{
+	uint8_t old_period;
+	bool old_enable;
+
+	if (!net)
+		return false;
+
+	old_enable = net->mpb_enable;
+	old_period = net->mpb_period;
+
+	if (enable)
+		net->mpb_period = period;
+
+	if (old_enable == enable && old_period == net->mpb_period)
+		return true;
+
+	if (enable && !initialize) {
+		/* If enable with different period, disable and re-enable */
+		net->mpb_enable = false;
+		l_queue_foreach(net->subnets, enable_mpb, net);
+	}
+
+	net->mpb_enable = enable;
+
+	if (enable)
+		l_queue_foreach(net->subnets, refresh_beacon, net);
+
+	l_queue_foreach(net->subnets, enable_mpb, net);
 	queue_friend_update(net);
 
 	return true;
@@ -2908,17 +2963,25 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 		subnet->key_refresh = 1;
 		subnet->net_key_tx = subnet->net_key_upd;
 
-		if (net->beacon_enable) {
+		if (net->snb_enable) {
 			/* Switch beaconing key */
-			net_key_beacon_disable(subnet->net_key_cur);
-			net_key_beacon_enable(subnet->net_key_upd);
+			net_key_beacon_disable(subnet->net_key_cur, false);
+			net_key_beacon_enable(subnet->net_key_upd, false, 0);
+		}
+
+		if (net->mpb_enable) {
+			/* Switch beaconing key */
+			net_key_beacon_disable(subnet->net_key_cur, true);
+			net_key_beacon_enable(subnet->net_key_upd, true,
+							net->mpb_period);
 		}
 	}
 
 	subnet->kr_phase = phase;
 
 	net_key_beacon_refresh(subnet->net_key_tx, net->iv_index,
-		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update);
+		!!(subnet->kr_phase == KEY_REFRESH_PHASE_TWO), net->iv_update,
+									false);
 
 
 	return true;
@@ -2933,8 +2996,9 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 
 	first = l_queue_isempty(nets);
 	if (first) {
-		uint8_t snb[] = {MESH_AD_TYPE_BEACON, 0x01};
-		uint8_t pkt[] = {MESH_AD_TYPE_NETWORK};
+		const uint8_t snb[] = {MESH_AD_TYPE_BEACON, 1};
+		const uint8_t mpb[] = {MESH_AD_TYPE_BEACON, 2};
+		const uint8_t pkt[] = {MESH_AD_TYPE_NETWORK};
 
 		if (!nets)
 			nets = l_queue_new();
@@ -2944,6 +3008,8 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 
 		mesh_io_register_recv_cb(io, snb, sizeof(snb),
 							beacon_recv, NULL);
+		mesh_io_register_recv_cb(io, mpb, sizeof(mpb),
+							beacon_recv, NULL);
 		mesh_io_register_recv_cb(io, pkt, sizeof(pkt),
 							net_msg_recv, NULL);
 	}
@@ -2960,8 +3026,9 @@ bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io)
 
 struct mesh_io *mesh_net_detach(struct mesh_net *net)
 {
-	uint8_t snb[] = {MESH_AD_TYPE_BEACON, 0x01};
-	uint8_t pkt[] = {MESH_AD_TYPE_NETWORK};
+	const uint8_t snb[] = {MESH_AD_TYPE_BEACON, 1};
+	const uint8_t mpb[] = {MESH_AD_TYPE_BEACON, 2};
+	const uint8_t pkt[] = {MESH_AD_TYPE_NETWORK};
 	struct mesh_io *io;
 	uint8_t type = 0;
 
@@ -2975,6 +3042,7 @@ struct mesh_io *mesh_net_detach(struct mesh_net *net)
 	/* Only deregister io if this is the last network detached.*/
 	if (l_queue_length(nets) < 2) {
 		mesh_io_deregister_recv_cb(io, snb, sizeof(snb));
+		mesh_io_deregister_recv_cb(io, mpb, sizeof(mpb));
 		mesh_io_deregister_recv_cb(io, pkt, sizeof(pkt));
 	}
 
diff --git a/mesh/net.h b/mesh/net.h
index 0bacbbbbf..d385ba16e 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -236,8 +236,10 @@ void mesh_net_set_frnd_seq(struct mesh_net *net, bool seq);
 uint16_t mesh_net_get_address(struct mesh_net *net);
 bool mesh_net_register_unicast(struct mesh_net *net,
 					uint16_t unicast, uint8_t num_ele);
-void net_local_beacon(uint32_t net_key_id, uint8_t *beacon);
-bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable);
+void net_local_beacon(uint32_t key_id, uint32_t ivi, bool ivu, bool kr);
+bool mesh_net_set_snb_mode(struct mesh_net *net, bool enable);
+bool mesh_net_set_mpb_mode(struct mesh_net *net, bool enabla, uint8_t period,
+								bool init);
 bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable);
 bool mesh_net_set_relay_mode(struct mesh_net *net, bool enable, uint8_t cnt,
 							uint8_t interval);
diff --git a/mesh/node.c b/mesh/node.c
index 5150a085a..a2a330518 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -414,7 +414,7 @@ static void update_net_settings(struct mesh_node *node)
 	mesh_net_set_relay_mode(net, node->relay.mode == MESH_MODE_ENABLED,
 					node->relay.cnt, node->relay.interval);
 
-	mesh_net_set_beacon_mode(net, node->beacon == MESH_MODE_ENABLED);
+	mesh_net_set_snb_mode(net, node->beacon == MESH_MODE_ENABLED);
 }
 
 static bool init_from_storage(struct mesh_config_node *db_node,
@@ -825,7 +825,7 @@ bool node_beacon_mode_set(struct mesh_node *node, bool enable)
 
 	if (res) {
 		node->beacon = beacon;
-		mesh_net_set_beacon_mode(node->net, enable);
+		mesh_net_set_snb_mode(node->net, enable);
 	}
 
 	return res;
-- 
2.39.1

