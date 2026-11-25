Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613891;
	b=KXPquB9Rb5m1zvMDLkDfTOQhWn2Wz4kDw0PUZUIyo6vq8qo7b0aQTSQW8Ed7hU+DXi0U
	 RAHj/XPw1ZgRVkbO4XYkiogE/LcwqlXqlDGn8/j1sXg7Nozu5ZpLY+PK9nAj/GG7TGcU4
	 /KjJfhk9vpO9FNDXbQ116sbjx7iLy+FgOVE82/FSCHhsasxcvxA+eeURhhQMK4c4zlgRQ
	 aAhJPfwxwERNOX8+AkYr65oCOcNpgjyENAuAQQ9pLd0DeGPODMFMP6B25p6s7eqiNLk6H
	 EwaWQbkO5uOXD8eCDoW/RX3NWxdtJ5nrj+8uwQ9veT78z5N2HLasvOKfMMTKYOrqkKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613891;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hsg9L0Hdg4A5dhGkhyC9t4gbJg2aW8iucmW95cuLcg4=;
	b=a4lEziljKX5NStP1LG6GOVQnOHe0bwTZmGFG+vAvEOOiQc+T38ZfOjnVquX8xHtGXH+1
	 AnCLyOkdD6rkZM/FlXbRLh4I7vDnfhaedOBbs6wXG/uU7mlVzVA/JrSxfRIwkE+/XxI0y
	 gp31rY1ijy6NmuhxCaioYVbo9b+6GrBiGFPJFoOL6NGlZevveKSnF2MadDdSpadB+OCpN
	 ii/MZwh/C0Qm90ZCP5/I/Zz5do9obAHwxRJjgDG9OUFxVebdOmf8SGmCtoZNVHawoKa3T
	 lqmCPQ3H7c6qeD4GtULc/vw4AjLaeHi0co4dQc1Zf2vce4eBqChizYO9shBRzmHlMsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="KWx9Wt/w";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B273606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B273606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KWx9Wt/w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795613888;
	bh=XjPQiSrRUwOb9hJXxTiH1MS29srmrdw0r0GZdDJZ7Mw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KWx9Wt/wn7KMSn/B4etbZFxUyhfxXf+aTbTgOVu8G11rp1ndH5W5GFt53NUyNFG9F
	 7eG/qkpX3SUmEuWp2XalX+e2nSLAY8Ix7QBvTD/Lj+FCeT39VUiYKMQ8LgZzJC1b5P
	 ERKGyvM5r3ZZGc0RZSfF8MfOrBVsmiR2NFRNGR+P5m/DyYaoho3qoA3hs0HJvGop9s
	 CMcwsPwtbaxRX0lrHMK9Wft25Rn5TMq0Xj/3cpI5QS43izwnrgqkGWYD4lBD/8FnQ6
	 HHwLpV42La42sbRgJoEJgJUr+pzTINYgYXpEult8+cbD8dqUgnRofjZRkBzcE3NkB2
	 bwVRbA6IZtPsQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7DE8717E0075
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:38:08 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 1/6] monitor: Strip trailing L2CAP FCS before upper layer dissectors
Date: Wed, 25 Nov 2026 14:37:51 +0100
Message-ID: <20261125133756.551659-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125133756.551659-1-frederic.danis@collabora.com>
References: <20261125133756.551659-1-frederic.danis@collabora.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

ERTM/Streaming mode I-frames append a 2-byte FCS after the payload,
which was never stripped before handing the frame to protocol
dissectors (OBEX, RFCOMM, SDP, ...). OBEX's own PDU length enforcement
was masking this as spurious "Trailing data" on every ERTM frame, two
bytes that are actually the L2CAP checksum, not protocol payload.

Track the negotiated FCS option per channel (defaulting to the 16-bit
FCS enabled by the Core Spec unless a peer explicitly negotiates "No
FCS"), and trim the trailing 2 bytes off ERTM/Streaming mode frames
before dispatching to the PSM-specific dissector.

Discard a channel's pending "No FCS" request if its Config Request is
rejected with Unknown Options, so a later, unrelated successful Config
Response in the same renegotiation doesn't apply the rejected value
and wrongly stop stripping the FCS.

Assisted-by: Claude:claude-sonnet-5
---
v3->v4:
  - Track the FCS value requested by a Config Request and apply it on
    a successful Config Response that doesn't repeat it (a successful
    response need not repeat accepted options), instead of only
    reading the FCS option when the response itself carries it.
v4->v5:
  - Discard a pending requested FCS value when its Config Request is
    rejected with Unknown Options (discard_req_fcs()), so a later,
    unrelated successful Config Response in the same renegotiation
    doesn't apply the rejected value.

 monitor/l2cap.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index ddc2388d5..62c7641ed 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -100,6 +100,8 @@ struct chan_data {
 	uint8_t  ext_ctrl;
 	uint8_t  seq_num;
 	uint16_t sdu;
+	uint8_t  fcs;
+	int8_t   req_fcs;
 	struct packet_latency tx_l;
 };
 
@@ -158,6 +160,13 @@ static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
 	chan_list[n].ctrlid = ctrlid;
 	chan_list[n].mode = mode;
 
+	/* 16-bit FCS is the default for ERTM/Streaming mode unless the
+	 * peer explicitly negotiates "No FCS" via the FCS configuration
+	 * option (see assign_fcs()).
+	 */
+	chan_list[n].fcs = 1;
+	chan_list[n].req_fcs = -1;
+
 	chan_list[n].seq_num = seq_num;
 }
 
@@ -255,6 +264,131 @@ static void assign_mode(const struct l2cap_frame *frame,
 	}
 }
 
+/* Record whether the peer negotiated "No FCS" (0x00) or "16-bit FCS"
+ * (0x01) via the FCS configuration option, so the trailing 2-byte FCS
+ * on ERTM/Streaming mode frames can be stripped before handing the
+ * payload to upper layer dissectors.
+ */
+static void assign_fcs(const struct l2cap_frame *frame,
+					uint8_t fcs, uint16_t dcid)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHAN; i++) {
+		if (chan_list[i].index != frame->index)
+			continue;
+
+		if (chan_list[i].handle != frame->handle)
+			continue;
+
+		if (frame->in) {
+			if (chan_list[i].scid == dcid) {
+				chan_list[i].fcs = fcs;
+				break;
+			}
+		} else {
+			if (chan_list[i].dcid == dcid) {
+				chan_list[i].fcs = fcs;
+				break;
+			}
+		}
+	}
+}
+
+/* Record the FCS value requested by a Config Request, so it can be
+ * applied on a successful Config Response even if that response omits
+ * the FCS option (a successful response need not repeat accepted
+ * options).
+ */
+static void assign_req_fcs(const struct l2cap_frame *frame,
+					uint8_t fcs, uint16_t dcid)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHAN; i++) {
+		if (chan_list[i].index != frame->index)
+			continue;
+
+		if (chan_list[i].handle != frame->handle)
+			continue;
+
+		if (frame->in) {
+			if (chan_list[i].scid == dcid) {
+				chan_list[i].req_fcs = fcs;
+				break;
+			}
+		} else {
+			if (chan_list[i].dcid == dcid) {
+				chan_list[i].req_fcs = fcs;
+				break;
+			}
+		}
+	}
+}
+
+/* Apply a previously requested FCS value on a successful Config
+ * Response, in case the response is option-free.
+ */
+static void apply_req_fcs(const struct l2cap_frame *frame, uint16_t scid)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHAN; i++) {
+		if (chan_list[i].index != frame->index)
+			continue;
+
+		if (chan_list[i].handle != frame->handle)
+			continue;
+
+		if (frame->in) {
+			if (chan_list[i].scid == scid) {
+				if (chan_list[i].req_fcs >= 0)
+					chan_list[i].fcs = chan_list[i].req_fcs;
+				break;
+			}
+		} else {
+			if (chan_list[i].dcid == scid) {
+				if (chan_list[i].req_fcs >= 0)
+					chan_list[i].fcs = chan_list[i].req_fcs;
+				break;
+			}
+		}
+	}
+}
+
+/* Discard a pending FCS value requested by a Config Request that is
+ * then rejected with Unknown Options, so a later, unrelated
+ * successful Config Response in the same renegotiation (sent without
+ * repeating the option) doesn't apply the rejected value. Left alone
+ * on a continuation response, since the rejection there isn't final
+ * and a later fragment of the same response still carries the result
+ * that matters.
+ */
+static void discard_req_fcs(const struct l2cap_frame *frame, uint16_t scid)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHAN; i++) {
+		if (chan_list[i].index != frame->index)
+			continue;
+
+		if (chan_list[i].handle != frame->handle)
+			continue;
+
+		if (frame->in) {
+			if (chan_list[i].scid == scid) {
+				chan_list[i].req_fcs = -1;
+				break;
+			}
+		} else {
+			if (chan_list[i].dcid == scid) {
+				chan_list[i].req_fcs = -1;
+				break;
+			}
+		}
+	}
+}
+
 static int get_chan_data_index(const struct l2cap_frame *frame)
 {
 	int i;
@@ -882,6 +1016,11 @@ static void print_config_options(const struct l2cap_frame *frame,
 					get_le16(data + consumed + 9));
 			break;
 		case 0x05:
+			if (response)
+				assign_fcs(frame, data[consumed + 2], cid);
+			else
+				assign_req_fcs(frame, data[consumed + 2], cid);
+
 			switch (data[consumed + 2]) {
 			case 0x00:
 				str = "No FCS";
@@ -1188,10 +1327,20 @@ static void sig_config_rsp(const struct l2cap_frame *frame)
 	print_cid("Source", pdu->scid);
 	print_config_flags(pdu->flags);
 	print_config_result(pdu->result);
-	if (pdu->result == 0x0003)
+	if (pdu->result == 0x0003) {
+		/* Unknown Options: the rejected Config Request (and any
+		 * FCS value it proposed) won't take effect, unless this
+		 * is a non-final fragment of a continued response, in
+		 * which case the result isn't final yet.
+		 */
+		if (!(le16_to_cpu(pdu->flags) & 0x0001))
+			discard_req_fcs(frame, le16_to_cpu(pdu->scid));
 		print_unknown_options(frame, 6);
-	else
+	} else {
+		if (pdu->result == 0x0000)
+			apply_req_fcs(frame, le16_to_cpu(pdu->scid));
 		print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
+	}
 }
 
 static void sig_disconn_req(const struct l2cap_frame *frame)
@@ -2740,6 +2889,16 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 			}
 
 			display_printf("\n");
+
+			/* ERTM/Streaming mode frames carry a trailing 2-byte
+			 * FCS (unless explicitly negotiated off via the FCS
+			 * configuration option) that is not part of the
+			 * upper layer payload.
+			 */
+			chan = get_chan(&frame);
+			if (chan && chan->fcs && frame.size >= 2)
+				frame.size -= 2;
+
 			break;
 		}
 
-- 
2.43.0

