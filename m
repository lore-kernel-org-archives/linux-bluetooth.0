Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2F81AB4
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728027208; cv=none; b=Fst/h8BuCQu3DFDD5mNlGjj1Eoxv1Zwd41XR98hlzHYj3RacMFol+DtlOtL8DRbG+aqrsBrVpY/LEdxK14p4ZMA8Y9fpV5UT0pRmPPb/eME6pcXOo4XJA/5HhJCQIluwR6fWshzuAwx0e73fmV65GKRNdApSY98XjcUtQ5IyGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728027208; c=relaxed/simple;
	bh=ftKbyLxT0cDH+rLwg14rUAD7NB04S3l+MfiSUk1sms0=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=eLRLLsTJsluxQQpXXMxoEY4uIeGW+SBTmdjsjT+mfuFxCRrZZ4Vm7DgJ5JXtRy1ZFjFvDF4b+JrSz7etUrYUbPOGrvfTstKqfsAvg7L5OKWShTgfnEO8L3yxjZTtTe1evQseIvX64LJD0CbIy4NpqoZ0QW+AKZuvOHssbRb/mlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgfVJbIf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgfVJbIf"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71970655611so1740162b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728027205; x=1728632005; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07j3x6Q+PB6pSG6S699z97+92IVMoVHvzfWMiSudAMA=;
        b=MgfVJbIf9+iCCfkVqbNZv/thuF/lmy8iEyEh3Vw4X/RSwc4Txs1GQofDl0d6lbn4PD
         hs5We8edr+KGGYyI597kp7WTK79uOT+eWmJvk/vgtFWgU74JZCSfkQ9dCvif7bK9XEwS
         Tfe+mZeeVTvHcJ2sGQZDfZtLQg2oLGBJAFDa6aX2vLsBwB+8lqu6t0msp9IdcgbbyUs2
         RC8kTf/GU+EAbz4oD8ec5ufBMOTlmRKeXEsT/HT21jSDG0/SbdRvomlz/jLOnh1HeN7c
         ZhWTGxJ1Nba7lBUqfN6NWY4GlgzbKd5uXRAJBcgN8x2UPuAEtd0565vuKL6DBMwj0F6r
         w2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728027205; x=1728632005;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07j3x6Q+PB6pSG6S699z97+92IVMoVHvzfWMiSudAMA=;
        b=U4zLhQCtSl42RhyLHmihj0ORCM/iqkJgZ1y4t5PUrtYKDGPROtANDAc46yD5637GCM
         4Aaa36bkGqVVz8wCLh7/khlkUHoSKCzs/ZjK0SMGU3MgdObhbTA8yTCBccc2zL5QwlLp
         zWie0m3w+YIw+Vv99v5aw5ZNhddAmJ1b6/JLWHhzL8O1Jzd9ZtMs8kj5niHFcKp1or0Z
         pH4Lp6PMPBOxUi7ETUBonKeCIsojeOM4ABKouZhN02XZJyeLRSzhS3lZBkMRbxFsorMY
         uNo/9z4Ivj7L3XtgXcy7ls191IjfhY170QQ5rKA+jUiQ7gsd8h/6zflOBdbbS8L+m57z
         mS4w==
X-Gm-Message-State: AOJu0YwcTPUoB9ibxyQa5yrBvv8jMU3GsGlvS4SaDWr+DHFgweFlMgZH
	R1qqH25MPEDYFVS4x8fuVML66XrqRWbTWByrykOZpB1xWGuWjNGXwntvuw==
X-Google-Smtp-Source: AGHT+IGPtQnLvWYYAnn1o+8Rkj6PYgaHhR3sRsEOTL58mI9mUmn9hjWfPELn6NqrOzCjkQDdB+664w==
X-Received: by 2002:a05:6a00:81c1:b0:71d:e7ec:738d with SMTP id d2e1a72fcca58-71de7ec754dmr1171185b3a.5.1728027204521;
        Fri, 04 Oct 2024 00:33:24 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9df333csm2576431b3a.180.2024.10.04.00.33.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 00:33:24 -0700 (PDT)
Message-ID: <66ff9a44.050a0220.237ac2.b441@mx.google.com>
X-Google-Original-Message-ID: <Zv+aQdPsXjep1pdG@JUNHO-NEOSTACK.>
Date: Fri, 4 Oct 2024 16:33:21 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] mesh: Add features of Segmented Control message
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

According to Mesh Protocol v1.1, with the addition of Transport Control
messages with variable length PDU such as 'Friend Subscription List Add'
and 'Friend Subscription List Remove', it is necessary to support
segmentation in the Lower Transport layer because the Upper Transport
Control PDU can be larger than the size of a single Network PDU.

This is achieved by performing the segmentation function for Transport
Control messages, where the segmentation of Transport Control messages
is the same as for Access messages, but with different message fields
and lengths, so the segmentation is controlled by branching.

It was written to perform the function as little as possible without
changing the existing design. We avoided modifying arguments outside of
static functions, and kept the existing working design unchanged.
However, some macro definitions had to be modified because they were
written based on Access messages, so we changed them to work by
comparing the Transport Control message flag.

This commit does not support segmentation for control messages as a
friend of Low Power Nodes. This should be added later.
---
 mesh/crypto.c |  69 +++++++------
 mesh/net.c    | 277 ++++++++++++++++++++++++++++++++------------------
 mesh/net.h    |  33 ++++--
 3 files changed, 243 insertions(+), 136 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index b712a2654..08548031b 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -532,7 +532,8 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 				uint8_t *packet, uint8_t *packet_len)
 {
 	uint32_t hdr;
-	size_t n;
+	size_t hdr_offset = 9;
+	size_t payload_offset = 10;
 
 	if (seq > SEQ_MASK)
 		return false;
@@ -543,50 +544,44 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 
 	l_put_be16(src, packet + 5);
 	l_put_be16(dst, packet + 7);
-	n = 9;
 
-	if (!ctl) {
-		uint32_t tmp = segmented ? 0x1 : 0;
+	hdr = (segmented ? 0x1 : 0) << SEG_HDR_SHIFT;
+
+	if (segmented) {
+		hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
+		hdr |= (segO & SEG_MASK) << SEGO_HDR_SHIFT;
+		hdr |= (segN & SEG_MASK) << SEGN_HDR_SHIFT;
+		payload_offset += 3;
+	}
 
-		hdr = tmp << SEG_HDR_SHIFT;
+	if (!ctl) {
 		hdr |= (key_aid & KEY_ID_MASK) << KEY_HDR_SHIFT;
 
 		if (segmented) {
 			hdr |= szmic << SZMIC_HDR_SHIFT;
-			hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
-			hdr |= (segO & SEG_MASK) << SEGO_HDR_SHIFT;
-			hdr |= (segN & SEG_MASK) << SEGN_HDR_SHIFT;
 		}
-		l_put_be32(hdr, packet + n);
-
-		/* Only first octet is valid for unsegmented messages */
-		if (segmented)
-			n += 4;
-		else
-			n += 1;
-
-		memcpy(packet + n, payload, payload_len);
-
-		l_put_be32(0x00000000, packet + payload_len + n);
-		if (packet_len)
-			*packet_len = payload_len + n + 4;
 	} else {
 		if ((opcode & OPCODE_MASK) != opcode)
 			return false;
 
-		hdr = opcode << KEY_HDR_SHIFT;
-		l_put_be32(hdr, packet + n);
-		n += 1;
+		hdr |= opcode << OPCODE_HDR_SHIFT;
+	}
+
+	l_put_be32(hdr, packet + hdr_offset);
 
-		memcpy(packet + n, payload, payload_len);
-		n += payload_len;
+	memcpy(packet + payload_offset, payload, payload_len);
 
-		l_put_be64(0x0000000000000000, packet + n);
+	if (!ctl) {
+		l_put_be32(0x00000000, packet + payload_offset + payload_len);
 		if (packet_len)
-			*packet_len = n + 8;
+			*packet_len = payload_offset + payload_len + 4;
+	} else {
+		l_put_be64(0x0000000000000000, packet + payload_offset +
+								payload_len);
+		if (packet_len)
+			*packet_len = payload_offset + payload_len + 8;
 	}
 
-
 	return true;
 }
 
@@ -665,6 +660,22 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 
 			if (payload_len)
 				*payload_len = packet_len - 9;
+		} else if (is_segmented) {
+			if (seqZero)
+				*seqZero = (hdr >> SEQ_ZERO_HDR_SHIFT) &
+								SEQ_ZERO_MASK;
+
+			if (segO)
+				*segO = (hdr >> SEGO_HDR_SHIFT) & SEG_MASK;
+
+			if (segN)
+				*segN = (hdr >> SEGN_HDR_SHIFT) & SEG_MASK;
+
+			if (payload)
+				*payload = packet + 13;
+
+			if (payload_len)
+				*payload_len = packet_len - 13;
 		} else {
 			if (payload)
 				*payload = packet + 10;
diff --git a/mesh/net.c b/mesh/net.c
index f185f0280..ae8834436 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -179,12 +179,20 @@ struct mesh_sar {
 	uint16_t src;
 	uint16_t remote;
 	uint16_t len;
-	bool szmic;
 	bool segmented;
+	bool ctl;
 	bool frnd;
 	bool frnd_cred;
 	uint8_t ttl;
-	uint8_t key_aid;
+	union {
+		struct {
+			uint8_t key_aid;
+			bool szmic;
+		}; /* Access message */
+		struct {
+			uint8_t opcode;
+		}; /* Transport Control message */
+	};
 	uint8_t buf[4]; /* Large enough for ACK-Flags and MIC */
 };
 
@@ -1964,7 +1972,7 @@ static bool msg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 			hdr |= (uint32_t) 0x01 << SEG_HDR_SHIFT;
 			hdr |= szmic << SZMIC_HDR_SHIFT;
 			hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
-			hdr |= SEG_MAX(true, size) << SEGN_HDR_SHIFT;
+			hdr |= SEG_MAX(false, true, size) << SEGN_HDR_SHIFT;
 		}
 
 		if (friend_packet_queue(net, iv_index, false, frnd_ttl,
@@ -2141,11 +2149,18 @@ static void friend_seg_rxed(struct mesh_net *net,
 	frnd_msg->cnt_in++;
 }
 
+static bool ctl_rxed(struct mesh_net *net, uint32_t net_key_id,
+						uint32_t iv_index, uint8_t ttl,
+						uint32_t seq, uint16_t src,
+						uint16_t dst, uint8_t opcode,
+						int8_t rssi, const uint8_t *pkt,
+						uint8_t len);
+
 static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 					uint8_t ttl, uint32_t seq,
 					uint16_t net_idx,
-					uint16_t src, uint16_t dst,
-					uint8_t key_aid,
+					uint16_t src, uint16_t dst, bool ctl,
+					uint8_t opcode, uint8_t key_aid,
 					bool szmic, uint16_t seqZero,
 					uint8_t segO, uint8_t segN,
 					const uint8_t *data, uint8_t size)
@@ -2194,10 +2209,15 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		l_debug("RXed (old: %04x %06x size:%d) %d of %d",
 					seqZero, seq, size, segO, segN);
 		/* Sanity Check--> certain things must match */
-		if (SEG_MAX(true, sar->len) != segN ||
-				sar->key_aid != key_aid)
+		if (SEG_MAX(ctl, true, sar->len) != segN)
 			return false;
 
+		if (!ctl && sar->key_aid != key_aid) {
+			return false;
+		} else if (ctl && sar->opcode != opcode) {
+			return false;
+		}
+
 		if (sar->flags == expected) {
 			/*
 			 * According to MshPRTv1.1: 3.5.3.4, if the destination
@@ -2217,7 +2237,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 			return true;
 		}
 	} else {
-		uint16_t len = MAX_SEG_TO_LEN(segN);
+		uint16_t len = MAX_SEG_TO_LEN(ctl, segN);
 
 		l_debug("RXed (new: %04x %06x size: %d len: %d) %d of %d",
 				seqZero, seq, size, len, segO, segN);
@@ -2228,9 +2248,13 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		sar->src = dst;
 		sar->remote = src;
 		sar->seqZero = seqZero;
-		sar->key_aid = key_aid;
 		sar->len = len;
 		sar->net_idx = net_idx;
+		if (ctl) {
+			sar->opcode = opcode;
+		} else {
+			sar->key_aid = key_aid;
+		}
 
 		sar_in = mesh_sar_rx_new();
 		sar_in->sar = sar;
@@ -2270,14 +2294,14 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	l_timeout_remove(sar_in->msg_timeout);
 	sar_in->msg_timeout = NULL;
 
-	seg_off = segO * MAX_SEG_LEN;
+	seg_off = segO * MAX_SEG_LEN(ctl);
 	memcpy(sar->buf + seg_off, data, size);
 	sar->flags |= this_seg_flag;
 	sar->ttl = ttl;
 
 	/* Msg length only definitive on last segment */
 	if (segO == segN)
-		sar->len = segN * MAX_SEG_LEN + size;
+		sar->len = segN * MAX_SEG_LEN(ctl) + size;
 
 	/* Send ACK only if DST is unicast address. */
 	if(IS_UNICAST(dst)) {
@@ -2290,9 +2314,21 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		/* Got it all */
 		send_net_ack(net, sar, expected);
 
-		msg_rxed(net, frnd, iv_index, ttl, seq, net_idx,
-				sar->remote, dst, key_aid, true, szmic,
-				sar->seqZero, sar->buf, sar->len);
+		if (!ctl) {
+			msg_rxed(net, frnd, iv_index, ttl, seq, net_idx,
+					sar->remote, dst, key_aid, true, szmic,
+					sar->seqZero, sar->buf, sar->len);
+		} else {
+			struct mesh_subnet *subnet = l_queue_find(net->subnets,
+							match_key_index,
+							L_UINT_TO_PTR(net_idx));
+			if (!subnet)
+				return false;
+
+			ctl_rxed(net, subnet->net_key_tx, iv_index, ttl,
+					seq, sar->remote, dst,
+					opcode, 0, sar->buf, sar->len);
+		}
 
 		/*
 		 * Delay SAR removal to be able to acknowledge a transaction
@@ -2312,7 +2348,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	return false;
 }
 
-static bool ctl_received(struct mesh_net *net, uint32_t net_key_id,
+static bool ctl_rxed(struct mesh_net *net, uint32_t net_key_id,
 						uint32_t iv_index, uint8_t ttl,
 						uint32_t seq,
 						uint16_t src, uint16_t dst,
@@ -2324,7 +2360,11 @@ static bool ctl_received(struct mesh_net *net, uint32_t net_key_id,
 	uint8_t n = 0;
 	uint16_t net_idx;
 
-	if (ttl > 1) {
+	/* TODO: If length is greater than 11, it must be segmented, so it must
+	 * be able to handle Segmented Control messages when acting as a friend
+	 * node.
+	 */
+	if (ttl > 1 && len <= 11) {
 		uint32_t hdr = opcode << OPCODE_HDR_SHIFT;
 		uint8_t frnd_ttl = ttl - 1;
 
@@ -2625,8 +2665,15 @@ static enum _relay_advice packet_received(void *user_data,
 					ack_rxed(net, net_src, net_dst,
 							net_seqZero,
 							l_get_be32(msg + 3));
+			} else if (net_segmented) {
+				seg_rxed(net, false, iv_index, net_ttl,
+						net_seq, net_idx, net_src,
+						net_dst, net_ctl, net_opcode,
+						key_aid, net_szmic, net_seqZero,
+						net_segO, net_segN,
+						msg, app_msg_len);
 			} else {
-				ctl_received(net, net_key_id, iv_index, net_ttl,
+				ctl_rxed(net, net_key_id, iv_index, net_ttl,
 						net_seq, net_src, net_dst,
 						net_opcode, rssi, msg,
 								app_msg_len);
@@ -2651,8 +2698,9 @@ static enum _relay_advice packet_received(void *user_data,
 			} else {
 				seg_rxed(net, false, iv_index, net_ttl,
 						net_seq, net_idx, net_src,
-						net_dst, key_aid, net_szmic,
-						net_seqZero, net_segO, net_segN,
+						net_dst, net_ctl, net_opcode,
+						key_aid, net_szmic, net_seqZero,
+						net_segO, net_segN,
 						msg, app_msg_len);
 			}
 
@@ -3371,16 +3419,16 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 	uint8_t gatt_data[30];
 	uint8_t *packet = gatt_data;
 	uint8_t packet_len;
-	uint8_t segN = SEG_MAX(msg->segmented, msg->len);
-	uint16_t seg_off = SEG_OFF(segO);
+	uint8_t segN = SEG_MAX(msg->ctl, msg->segmented, msg->len);
+	uint16_t seg_off = SEG_OFF(msg->ctl, segO);
 	uint32_t seq_num;
 
 	if (msg->segmented) {
 		/* Send each segment on unique seq_num */
 		seq_num = mesh_net_next_seq_num(net);
 
-		if (msg->len - seg_off > SEG_OFF(1))
-			seg_len = SEG_OFF(1);
+		if (msg->len - seg_off > SEG_OFF(msg->ctl, 1))
+			seg_len = SEG_OFF(msg->ctl, 1);
 		else
 			seg_len = msg->len - seg_off;
 	} else {
@@ -3396,12 +3444,12 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 	l_debug("segN %d segment %d seg_off %d", segN, segO, seg_off);
 
 	/* TODO: Are we RXing on an LPN's behalf? Then set RLY bit */
-	if (!mesh_crypto_packet_build(false, msg->ttl, seq_num, msg->src,
-					msg->remote, 0, msg->segmented,
-					msg->key_aid, msg->szmic, false,
-					msg->seqZero, segO, segN,
-					msg->buf + seg_off, seg_len,
-					packet + 1, &packet_len)) {
+	if (!mesh_crypto_packet_build(msg->ctl, msg->ttl, seq_num, msg->src,
+					msg->remote, msg->opcode,
+					msg->segmented, msg->key_aid,
+					msg->szmic, false, msg->seqZero,
+					segO, segN, msg->buf + seg_off,
+					seg_len, packet + 1, &packet_len)) {
 		l_error("Failed to build packet");
 		return false;
 	}
@@ -3424,6 +3472,61 @@ static bool send_seg(struct mesh_net *net, uint8_t cnt, uint16_t interval,
 	return true;
 }
 
+static bool mesh_net_send(struct mesh_net *net, struct mesh_sar *payload,
+								uint8_t segN)
+{
+	bool result = false;
+
+	if (payload->segmented) {
+		struct mesh_sar_tx *drop_sar_tx;
+		payload->flags = 0xffffffff >> (31 - segN);
+		payload->seqZero = payload->seqAuth & SEQ_ZERO_MASK;
+
+		/* Single thread SAR messages to same Unicast DST */
+		drop_sar_tx = l_queue_find(net->sar_out, match_sar_tx_remote,
+						L_UINT_TO_PTR(payload->remote));
+		if (drop_sar_tx) {
+			/* Cancel incomplete prior SAR on the same dst */
+			l_debug("Cancel incompleted SAR: SeqZero %4.4x",
+					drop_sar_tx->sar->seqZero);
+			l_queue_remove(net->sar_out, drop_sar_tx);
+			mesh_sar_tx_free(drop_sar_tx);
+		}
+	}
+
+	result = send_seg(net, net->tx_cnt, net->tx_interval, payload, 0);
+
+	/*
+	 * Set the timeout to send the next seg or retransmit if the payload is
+	 * segmented. Flush if it is not segmented or if the transmission
+	 * failed.
+	 */
+	if (result && payload->segmented) {
+		struct mesh_sar_tx *sar_tx = mesh_sar_tx_new();
+		bool is_unicast = IS_UNICAST(payload->remote);
+		sar_tx->ack_received = false;
+		sar_tx->int_ms = sar_tx_seg_int_ms(net->sar_txr);
+		sar_tx->attempt_left = sar_tx_retrans_cnt(net->sar_txr,
+							is_unicast, false);
+		sar_tx->attempt_left_no_progress = sar_tx_retrans_cnt(
+							net->sar_txr,
+							is_unicast, true);
+		sar_tx->retrans_ms = sar_tx_retrans_timeout_ms(net->sar_txr,
+								is_unicast,
+								payload->ttl);
+		sar_tx->sar = payload;
+		l_queue_push_head(net->sar_out, sar_tx);
+		sar_tx->seg_timeout = l_timeout_create_ms(sar_tx->int_ms,
+						send_next_seg_to, net, NULL);
+		sar_tx->segO = 1;	/* The 0th seg is already sent. */
+		sar_tx->segN = segN;
+	} else {
+		mesh_sar_free(payload);
+	}
+
+	return result;
+}
+
 void mesh_net_send_seg(struct mesh_net *net, uint32_t net_key_id,
 			uint32_t iv_index, uint8_t ttl, uint32_t seq,
 			uint16_t src, uint16_t dst, uint32_t hdr,
@@ -3497,7 +3600,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 
 	/* Long and sizmic messages *require* segmenting */
 	segmented |= szmic;
-	seg_max = SEG_MAX(segmented, msg_len);
+	seg_max = SEG_MAX(false, segmented, msg_len);
 	segmented |= !!(seg_max);
 
 	/* First enqueue to any Friends and internal models */
@@ -3524,6 +3627,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	payload = mesh_sar_new(msg_len);
 	memcpy(payload->buf, msg, msg_len);
 	payload->len = msg_len;
+	payload->ctl = false;
 	payload->src = src;
 	payload->remote = dst;
 	payload->ttl = ttl;
@@ -3535,52 +3639,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	payload->seqAuth = seq;
 	payload->segmented = segmented;
 
-	if (segmented) {
-		struct mesh_sar_tx *drop_sar_tx;
-		payload->flags = 0xffffffff >> (31 - seg_max);
-		payload->seqZero = seq & SEQ_ZERO_MASK;
-
-		/* Single thread SAR messages to same Unicast DST */
-		drop_sar_tx = l_queue_find(net->sar_out, match_sar_tx_remote,
-							L_UINT_TO_PTR(dst));
-		if (drop_sar_tx) {
-			/* Cancel incomplete prior SAR on the same dst */
-			l_debug("Cancel incompleted SAR: SeqZero %4.4x",
-					drop_sar_tx->sar->seqZero);
-			l_queue_remove(net->sar_out, drop_sar_tx);
-			mesh_sar_tx_free(drop_sar_tx);
-		}
-	}
-
-	result = send_seg(net, cnt, interval, payload, 0);
-
-	/*
-	 * Set the timeout to send the next seg or retransmit if the payload is
-	 * segmented. Flush if it is not segmented or if the transmission
-	 * failed.
-	 */
-	if (result && segmented) {
-		struct mesh_sar_tx *sar_tx = mesh_sar_tx_new();
-		bool is_unicast = IS_UNICAST(dst);
-		sar_tx->ack_received = false;
-		sar_tx->int_ms = sar_tx_seg_int_ms(net->sar_txr);
-		sar_tx->attempt_left = sar_tx_retrans_cnt(net->sar_txr,
-							is_unicast, false);
-		sar_tx->attempt_left_no_progress = sar_tx_retrans_cnt(
-							net->sar_txr,
-							is_unicast, true);
-		sar_tx->retrans_ms = sar_tx_retrans_timeout_ms(net->sar_txr,
-								is_unicast,
-								ttl);
-		sar_tx->sar = payload;
-		l_queue_push_head(net->sar_out, sar_tx);
-		sar_tx->seg_timeout = l_timeout_create_ms(sar_tx->int_ms,
-						send_next_seg_to, net, NULL);
-		sar_tx->segO = 1;	/* The 0th seg is already sent. */
-		sar_tx->segN = seg_max;
-	} else {
-		mesh_sar_free(payload);
-	}
+	result = mesh_net_send(net, payload, seg_max);
 
 	return result;
 }
@@ -3639,11 +3698,18 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 				uint16_t dst, const uint8_t *msg,
 				uint16_t msg_len)
 {
-	uint32_t use_seq = seq;
-	uint8_t pkt_len;
-	uint8_t pkt[30];
+	struct mesh_sar *payload;
+	uint8_t opcode, seg_max;
+	bool segmented = false;
 	bool result = false;
 
+	/*
+	 * Check maximum message length:
+	 *	Parameter length(8) * Maximum # of segments(32) + Header size(1)
+	 */
+	if (!net || msg_len > 257)
+		return;
+
 	if (!net->src_addr)
 		return;
 
@@ -3656,10 +3722,19 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 	if (ttl == DEFAULT_TTL)
 		ttl = net->default_ttl;
 
-	/* Range check the Opcode and msg length*/
-	if (*msg & 0xc0 || (9 + msg_len + 8 > 29))
+	/*
+	 * Mesh Protocol v1.1: An unassigned address shall not be used in the
+	 * SRC field or the DST field of a Network PDU.
+	 */
+	if (IS_UNASSIGNED(src) || IS_UNASSIGNED(dst))
 		return;
 
+	segmented |= msg[0] & SEGMENTED;
+	seg_max = SEG_MAX(true, segmented, msg_len - 1);
+	segmented |= !!(seg_max);
+
+	opcode = msg[0] & OPCODE_MASK;
+
 	/*
 	 * MshPRFv1.0.1 section 3.4.5.2, Interface output filter:
 	 * If TTL is set to 1, message shall be dropped.
@@ -3680,36 +3755,38 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
 
 	/* Deliver to Local entities if applicable */
 	if (!(dst & 0x8000) && src >= net->src_addr && src <= net->last_addr)
-		result = ctl_received(net, net_key_id, iv_index, ttl,
+		result = ctl_rxed(net, net_key_id, iv_index, ttl,
 					mesh_net_next_seq_num(net), src, dst,
 					msg[0], 0, msg + 1, msg_len - 1);
 
 	if (!net_key_id) {
+		seq = mesh_net_next_seq_num(net);
+
+		if (result || (dst >= net->src_addr && dst <= net->last_addr))
+			return;
+	} else {
 		struct mesh_subnet *subnet = l_queue_find(net->subnets,
-				match_key_index, L_UINT_TO_PTR(net_idx));
+				match_key_id, L_UINT_TO_PTR(net_key_id));
 		if (!subnet)
 			return;
 
-		net_key_id = subnet->net_key_tx;
-		use_seq = mesh_net_next_seq_num(net);
-
-		if (result || (dst >= net->src_addr && dst <= net->last_addr))
-			return;
+		net_idx = subnet->idx;
 	}
 
-	if (!mesh_crypto_packet_build(true, ttl, use_seq, src, dst, msg[0],
-				false, 0, false, false, 0, 0, 0, msg + 1,
-				msg_len - 1, pkt + 1, &pkt_len))
-		return;
-
-	if (!net_key_encrypt(net_key_id, iv_index, pkt + 1, pkt_len)) {
-		l_error("Failed to encode packet");
-		return;
-	}
+	payload = mesh_sar_new(msg_len - 1);
+	memcpy(payload->buf, msg + 1, msg_len - 1);
+	payload->len = msg_len - 1;
+	payload->ctl = true;
+	payload->ttl = ttl;
+	payload->src = src;
+	payload->remote = dst;
+	payload->opcode = opcode;
+	payload->net_idx = net_idx;
+	payload->iv_index = iv_index;
+	payload->seqAuth = seq;
+	payload->segmented = segmented;
 
-	if (!(IS_UNASSIGNED(dst)))
-		send_msg_pkt(net, net->tx_cnt, net->tx_interval, pkt,
-								pkt_len + 1);
+	mesh_net_send(net, payload, seg_max);
 }
 
 int mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t idx,
diff --git a/mesh/net.h b/mesh/net.h
index d385ba16e..285c8e355 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -26,13 +26,32 @@ struct mesh_node;
 #define KEY_CACHE_SIZE	64
 #define FRND_CACHE_MAX	32
 
-#define MAX_UNSEG_LEN	15 /* msg_len == 11 + sizeof(MIC) */
-#define MAX_SEG_LEN	12 /* UnSeg length - 3 octets overhead */
-#define SEG_MAX(seg, len) ((!seg && len <= MAX_UNSEG_LEN) ? 0 : \
-						(((len) - 1) / MAX_SEG_LEN))
-
-#define SEG_OFF(seg)	((seg) * MAX_SEG_LEN)
-#define MAX_SEG_TO_LEN(seg)	((seg) ? SEG_OFF((seg) + 1) : MAX_UNSEG_LEN)
+#define MAX_CTL_UNSEG_LEN	11 /* msg_len == 7 + sizeof(MIC) */
+#define MAX_CTL_SEG_LEN	8 /* UnSeg length - 3 octets overhead */
+#define CTL_SEG_MAX(seg, len) ((!(seg) && (len) <= MAX_CTL_UNSEG_LEN) ? 0 : \
+						(((len) - 1) / MAX_CTL_SEG_LEN))
+
+#define MAX_ACC_UNSEG_LEN	15 /* msg_len == 11 + sizeof(MIC) */
+#define MAX_ACC_SEG_LEN	12 /* UnSeg length - 3 octets overhead */
+#define ACC_SEG_MAX(seg, len) ((!(seg) && (len) <= MAX_ACC_UNSEG_LEN) ? 0 : \
+						(((len) - 1) / MAX_ACC_SEG_LEN))
+
+#define MAX_UNSEG_LEN(ctl)	((ctl) ? MAX_CTL_UNSEG_LEN : MAX_ACC_UNSEG_LEN)
+#define MAX_SEG_LEN(ctl)	((ctl) ? MAX_CTL_SEG_LEN : MAX_ACC_SEG_LEN)
+#define SEG_MAX(ctl, seg, len)	((ctl) ? CTL_SEG_MAX((seg), (len)) : \
+						ACC_SEG_MAX((seg), (len)))
+
+#define CTL_SEG_OFF(seg)	((seg) * MAX_CTL_SEG_LEN)
+#define MAX_CTL_SEG_TO_LEN(seg)	((seg) ? CTL_SEG_OFF((seg) + 1) : \
+							MAX_CTL_UNSEG_LEN)
+
+#define ACC_SEG_OFF(seg)	((seg) * MAX_ACC_SEG_LEN)
+#define MAX_ACC_SEG_TO_LEN(seg)	((seg) ? ACC_SEG_OFF((seg) + 1) : \
+							MAX_ACC_UNSEG_LEN)
+
+#define SEG_OFF(ctl, seg)	((ctl) ? CTL_SEG_OFF(seg) : ACC_SEG_OFF(seg))
+#define MAX_SEG_TO_LEN(ctl, seg)	((ctl) ? MAX_CTL_SEG_TO_LEN(seg) : \
+							MAX_ACC_SEG_TO_LEN(seg))
 
 #define SEGMENTED	0x80
 #define UNSEGMENTED	0x00
-- 
2.34.1

