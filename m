Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613891;
	b=di/Og03lMnfX9PRED5rQIN82xLtZMnsUYKfpvfDUvml5RoxFEzT25oy5TtVX7OUJ/R1H
	 a9+P0n7CtKNZ8IQaFXSpMIJ9KVvqlqzy68kFijPq4466v0FAHr/Nm1J2/AkGyeoqDXwqy
	 p7brTCGdLHGei8cXd6VMuk2eUcaQe9kaJO00Kk7IdftsyT8yipFYop+n05nTCpJeIZE3U
	 OjkQm+fecOmOpUu2nsZyKCSj/l1crZSH9GAo0Z2LNxEl0IZ/knrJLbOL+Mns0sAAKvVvv
	 eWrblH8U74JAm7S9ncYJ5M4mz3HQ50BKDDibkZiZrrSw1yRvGaSrxwxjYTFTfo1jJ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613891;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nnfldrxVqnwD0l+JUb6ygeubAqMPHbB+66XHdGscDaI=;
	b=uES1aFaJqxOh5cRbjNF1Y4ZU5LvtEOdGKWkRBQVb/bg9tCWlX1A2HrOEEWi9sNbjy/2B
	 Icdb2JMU9+wyPwLgbfVXqGREj3ME4AxaOEXx97S57KKCrfu3PSEiTEtx+QkC8C9/cM/vQ
	 QmHVvFdDC/RqSZNCS22oKyRe7c/YqdqM+WJJEh3T1CspXa9AaKJh8zmWItgLOZCwbs5PK
	 RMHeGxi+PIe0LaolFs2Bv7FHfDtBbJlq8iRwqFXbNHEMGZOOSOoG/jXX2aNO1dtCalQ90
	 BNjztWDUFZs0KMDMjYzbbSgsqY4RIcnM8KoCyqDheLAE8Rnhd4doZEAaW/slX6jqZyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lKeIcqpM;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA39606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBA39606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lKeIcqpM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795613889;
	bh=b1+O2fLwsIlx70aasaOU4GzmbMAdIBhPfkuiShyKzjU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lKeIcqpM0GKfHYhwjF8t/IH7yye98tKKwSB8QJIkxxedKTKKhAqA1Z3j/h0adN8wS
	 MpYh3hdfGo+Em3lZlj3oFTFWfnGjsX6naQBPVdx0v/h+dSZU7BuSo7lEncjpNDfxL6
	 UXddS0kOlFAtT+Z8COJpt0x9oZ1vqFrEJdq4OrGV8zcoKCP68sxDZiAvofP8Xk7v3m
	 peQNvZ08hKi882ZjnmzCpc0xnyru2whX6+SYPj2WhxELpQZw5AkIm09au0AtlwLf3C
	 abuWDfZweos7tJFPH3maI6uUz5TeLiR5oSsa6cXjKJ3i9ulGi8uLLsnkiSf7Zn8Lx/
	 DCiuE0L60RuMw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4582517E09ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:38:09 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 4/6] monitor: Reassemble L2CAP ERTM/Streaming SDUs
Date: Wed, 25 Nov 2026 14:37:54 +0100
Message-ID: <20261125133756.551659-5-frederic.danis@collabora.com>
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

L2CAP ERTM/Streaming mode can segment a single upper-layer SDU across
several I-frames (Start/Continuation/End SAR values). Previously each
fragment was dissected independently, so OBEX PDUs spanning more than
one fragment failed to parse ('frame too short') and S-frames (which
carry no SAR field or payload) were incorrectly sent to the upper
layer dissector as empty frames, adding further false positives.

Add per-channel, per-direction SDU reassembly buffers
(chan->sdu_rx[]), filled across Start/Continuation/End I-frames and
handed to the upper layer dissector only once the full SDU is
available. S-frames are now skipped entirely before PSM dispatch.
Each direction's expected TxSeq is tracked alongside its buffer: a
fragment matching the previous TxSeq is a retransmitted duplicate and
is discarded instead of being appended again, and a fragment whose
TxSeq doesn't match the expected value means a prior fragment was
lost, so the in-progress SDU is discarded rather than reassembled
past the gap.

While an SDU is still being reassembled (Start/Continuation
fragments), the raw per-fragment payload is still hexdumped so no
bytes are lost from the trace, but OBEX decoding itself only runs
once on the complete SDU (on the End fragment).

To avoid printing bytes twice (once as a raw Start/Continuation
fragment dump, and again inside a header value dump once the full
PDU is decoded), obex_packet() now also takes the base and size of
the fragment that triggered the call (the whole buffer for RFCOMM/
Unsegmented/untracked channels, or just the last physical I-frame's
payload for a just-completed SAR reassembly). Internal hexdumps in
obex.c are routed through a small obex_hexdump() helper that clips
output to only the bytes carried by that fragment.

Since headers are serialized near the start of a PDU while a SAR
reassembly's last fragment carries only its final bytes, restrict
this clipping to Body/End-of-Body: Application Parameters and
Target/Who header values are always shown unclipped, otherwise their
contents would be dropped whenever they land in an earlier fragment
than the one that completed reassembly.

A retransmitted duplicate of the Start fragment (same TxSeq) that
began the SDU currently being reassembled was not recognized as
such, so any already-buffered Continuation fragments for it were
discarded and reassembly restarted from scratch even though no data
was actually lost on the wire. Track the TxSeq of the Start fragment
that began the in-progress SDU and discard a repeat of it the same
way a duplicate Continuation/End fragment is discarded.

Assisted-by: Claude:claude-sonnet-5
---
v1->v2: Fix commit title issue
v2->v3:
  - Retitled from "monitor: Reassemble L2CAP ERTM/Streaming fragments
    before dissecting" (subject line was exceeding the mailing list's
    80-character limit with the series prefix).
  - Track the expected TxSeq per direction alongside each reassembly
    buffer: a fragment matching the previous TxSeq is a retransmitted
    duplicate and is discarded instead of being appended again, and a
    fragment whose TxSeq doesn't match the expected value means a prior
    fragment was lost, so the in-progress SDU is discarded rather than
    reassembled past the gap.
v4->v5:
  - Track the TxSeq of the Start fragment that began the in-progress
    SDU (start_seq) and compare a new Start fragment against it, so a
    retransmitted duplicate of that same Start fragment is recognized
    and discarded instead of needlessly dropping the already-buffered
    Continuation fragments.

 monitor/l2cap.c  | 266 +++++++++++++++++++++++++++++++++++++++++++----
 monitor/obex.c   |  63 +++++++++--
 monitor/obex.h   |   3 +-
 monitor/rfcomm.c |   2 +-
 4 files changed, 303 insertions(+), 31 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index a43b9237c..d8d6058d0 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -86,9 +86,27 @@
 #define L2CAP_SAR_START		0x01
 #define L2CAP_SAR_END		0x02
 #define L2CAP_SAR_CONTINUE	0x03
+#define L2CAP_SAR_NONE		0xff	/* S-frame, no SAR field */
 
 #define MAX_CHAN 64
 
+/* Reassembled L2CAP SDU for ERTM/Streaming mode channels using
+ * segmentation (SAR Start/Continuation/End). Tracked separately per
+ * direction since a bidirectional channel may have independent SDUs
+ * in flight each way.
+ */
+struct l2cap_sdu {
+	uint8_t *data;
+	uint16_t len;
+	uint16_t total;
+	int32_t next_seq;	/* expected TxSeq of the next fragment, or
+				 * -1 if no reassembly is in progress
+				 */
+	int32_t start_seq;	/* TxSeq of the Start segment that began
+				 * the in-progress SDU, or -1 if none
+				 */
+};
+
 struct chan_data {
 	uint16_t index;
 	uint16_t handle;
@@ -103,11 +121,21 @@ struct chan_data {
 	uint16_t sdu;
 	uint8_t  fcs;
 	int8_t   req_fcs;
+	struct l2cap_sdu sdu_rx[2];
 	struct packet_latency tx_l;
 };
 
 static struct chan_data chan_list[MAX_CHAN];
 
+static void reset_sdu_rx(struct chan_data *chan)
+{
+	free(chan->sdu_rx[0].data);
+	free(chan->sdu_rx[1].data);
+	memset(chan->sdu_rx, 0, sizeof(chan->sdu_rx));
+	chan->sdu_rx[0].next_seq = -1;
+	chan->sdu_rx[1].next_seq = -1;
+}
+
 static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
 			uint16_t psm, uint8_t mode, uint8_t ctrlid)
 {
@@ -147,6 +175,7 @@ static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
 	if (n < 0)
 		return;
 
+	reset_sdu_rx(&chan_list[n]);
 	memset(&chan_list[n], 0, sizeof(chan_list[n]));
 	chan_list[n].index = frame->index;
 	chan_list[n].handle = frame->handle;
@@ -169,6 +198,10 @@ static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
 	chan_list[n].req_fcs = -1;
 
 	chan_list[n].seq_num = seq_num;
+	chan_list[n].sdu_rx[0].next_seq = -1;
+	chan_list[n].sdu_rx[1].next_seq = -1;
+	chan_list[n].sdu_rx[0].start_seq = -1;
+	chan_list[n].sdu_rx[1].start_seq = -1;
 }
 
 static void release_scid(const struct l2cap_frame *frame, uint16_t scid)
@@ -184,11 +217,13 @@ static void release_scid(const struct l2cap_frame *frame, uint16_t scid)
 
 		if (frame->in) {
 			if (chan_list[i].scid == scid) {
+				reset_sdu_rx(&chan_list[i]);
 				chan_list[i].handle = 0;
 				break;
 			}
 		} else {
 			if (chan_list[i].dcid == scid) {
+				reset_sdu_rx(&chan_list[i]);
 				chan_list[i].handle = 0;
 				break;
 			}
@@ -576,8 +611,11 @@ static char *mode2str(uint8_t mode)
 	}
 }
 
-static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
+static uint8_t l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl,
+					uint16_t *sdu_len, uint16_t *txseq)
 {
+	uint8_t sar = L2CAP_SAR_NONE;
+
 	display_printf("      %s:",
 		ctrl & L2CAP_EXT_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
 
@@ -589,20 +627,18 @@ static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
 		if (ctrl & L2CAP_EXT_CTRL_POLL)
 			display_printf(" P-bit");
 	} else {
-		uint8_t sar = (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
+		sar = (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
 						L2CAP_EXT_CTRL_SAR_SHIFT;
 		display_printf(" %s", sar2str(sar));
 		if (sar == L2CAP_SAR_START) {
-			uint16_t len;
+			if (!l2cap_frame_get_le16(frame, sdu_len))
+				return L2CAP_SAR_NONE;
 
-			if (!l2cap_frame_get_le16(frame, &len))
-				return;
-
-			display_printf(" (len %d)", len);
+			display_printf(" (len %d)", *sdu_len);
 		}
-		display_printf(" TxSeq %d",
-			(ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
-						L2CAP_EXT_CTRL_TXSEQ_SHIFT);
+		*txseq = (ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
+						L2CAP_EXT_CTRL_TXSEQ_SHIFT;
+		display_printf(" TxSeq %d", *txseq);
 	}
 
 	display_printf(" ReqSeq %d", (ctrl & L2CAP_EXT_CTRL_REQSEQ_MASK) >>
@@ -610,10 +646,15 @@ static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
 
 	if (ctrl & L2CAP_EXT_CTRL_FINAL)
 		display_printf(" F-bit");
+
+	return sar;
 }
 
-static void l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl)
+static uint8_t l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl,
+					uint16_t *sdu_len, uint16_t *txseq)
 {
+	uint8_t sar = L2CAP_SAR_NONE;
+
 	display_printf("      %s:",
 			ctrl & L2CAP_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
 
@@ -625,20 +666,17 @@ static void l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl)
 		if (ctrl & L2CAP_CTRL_POLL)
 			display_printf(" P-bit");
 	} else {
-		uint8_t sar;
-
 		sar = (ctrl & L2CAP_CTRL_SAR_MASK) >> L2CAP_CTRL_SAR_SHIFT;
 		display_printf(" %s", sar2str(sar));
 		if (sar == L2CAP_SAR_START) {
-			uint16_t len;
-
-			if (!l2cap_frame_get_le16(frame, &len))
-				return;
+			if (!l2cap_frame_get_le16(frame, sdu_len))
+				return L2CAP_SAR_NONE;
 
-			display_printf(" (len %d)", len);
+			display_printf(" (len %d)", *sdu_len);
 		}
-		display_printf(" TxSeq %d", (ctrl & L2CAP_CTRL_TXSEQ_MASK) >>
-						L2CAP_CTRL_TXSEQ_SHIFT);
+		*txseq = (ctrl & L2CAP_CTRL_TXSEQ_MASK) >>
+						L2CAP_CTRL_TXSEQ_SHIFT;
+		display_printf(" TxSeq %d", *txseq);
 	}
 
 	display_printf(" ReqSeq %d", (ctrl & L2CAP_CTRL_REQSEQ_MASK) >>
@@ -646,6 +684,8 @@ static void l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl)
 
 	if (ctrl & L2CAP_CTRL_FINAL)
 		display_printf(" F-bit");
+
+	return sar;
 }
 
 #define MAX_INDEX 16
@@ -2815,6 +2855,133 @@ static void smp_packet(uint16_t index, bool in, uint16_t handle,
 	opcode_data->func(&frame);
 }
 
+/* Reassemble ERTM/Streaming mode SAR fragments (Start/Continuation/End)
+ * into a single SDU before handing it to the upper layer dissector.
+ * Returns true when frame now holds a complete payload ready for
+ * dispatch (either because sar is the end of a multi-fragment SDU, or
+ * because reassembly could not be tracked and the single fragment
+ * should be dispatched as-is). Returns false while more fragments are
+ * still expected. *owned is set to true only when frame->data was
+ * replaced by a heap-allocated reassembled SDU that the caller must
+ * free; it is left untouched (false) whenever frame->data still
+ * points into the original (borrowed) packet buffer.
+ */
+static bool l2cap_sdu_reassemble(struct chan_data *chan, bool in,
+					uint8_t sar, uint16_t sdu_len,
+					uint16_t txseq, uint16_t seq_mod,
+					struct l2cap_frame *frame, bool *owned)
+{
+	struct l2cap_sdu *sdu;
+	uint32_t len;
+	uint16_t prev_seq;
+
+	*owned = false;
+
+	if (!chan)
+		return true;
+
+	sdu = &chan->sdu_rx[in ? 1 : 0];
+
+	if (sar == L2CAP_SAR_START) {
+		if (sdu->data) {
+			if (sdu->start_seq == (int32_t) txseq) {
+				/* Retransmitted duplicate of the Start
+				 * segment that began the SDU currently
+				 * being reassembled: no data was lost,
+				 * keep buffering as before.
+				 */
+				print_text(COLOR_ERROR,
+					"duplicate Start segment TxSeq %u"
+					" discarded", txseq);
+				return false;
+			}
+
+			print_text(COLOR_ERROR,
+				"incomplete SDU replaced by new Start segment");
+			free(sdu->data);
+		}
+
+		sdu->len = 0;
+		sdu->total = sdu_len;
+		sdu->data = malloc(sdu_len);
+
+		if (!sdu->data) {
+			sdu->total = 0;
+			sdu->next_seq = -1;
+			sdu->start_seq = -1;
+			return true;
+		}
+
+		sdu->next_seq = (txseq + 1) % seq_mod;
+		sdu->start_seq = txseq;
+	} else {
+		if (!sdu->data) {
+			print_text(COLOR_ERROR,
+					"unexpected continuation segment");
+			return true;
+		}
+
+		prev_seq = (sdu->next_seq + seq_mod - 1) % seq_mod;
+
+		if (sdu->next_seq >= 0 && txseq == prev_seq) {
+			/* Retransmitted duplicate of the last fragment
+			 * already appended: discard it and keep waiting
+			 * for the genuine next fragment.
+			 */
+			print_text(COLOR_ERROR,
+				"duplicate segment TxSeq %u discarded",
+				txseq);
+			return false;
+		}
+
+		if (sdu->next_seq >= 0 && txseq != (uint16_t) sdu->next_seq) {
+			/* A gap means a fragment was lost (or capture
+			 * started mid-SDU): the SDU can no longer be
+			 * reassembled correctly, so discard it rather
+			 * than silently producing a corrupted payload.
+			 */
+			print_text(COLOR_ERROR,
+				"gap in reassembly (expected TxSeq %u, got"
+				" %u), discarding SDU", sdu->next_seq, txseq);
+			free(sdu->data);
+			sdu->data = NULL;
+			sdu->len = 0;
+			sdu->total = 0;
+			sdu->next_seq = -1;
+			sdu->start_seq = -1;
+			return true;
+		}
+
+		sdu->next_seq = (txseq + 1) % seq_mod;
+	}
+
+	len = sdu->len + (uint32_t) frame->size;
+	if (len > sdu->total)
+		len = sdu->total;
+
+	if (len > sdu->len)
+		memcpy(sdu->data + sdu->len, frame->data, len - sdu->len);
+	sdu->len = len;
+
+	if (sar != L2CAP_SAR_END)
+		return false;
+
+	if (sdu->len != sdu->total)
+		print_text(COLOR_ERROR, "reassembled SDU length mismatch");
+
+	frame->data = sdu->data;
+	frame->size = sdu->len;
+	*owned = true;
+
+	sdu->data = NULL;
+	sdu->len = 0;
+	sdu->total = 0;
+	sdu->next_seq = -1;
+	sdu->start_seq = -1;
+
+	return true;
+}
+
 void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 			uint16_t psm, const void *data, uint16_t size)
 {
@@ -2823,6 +2990,13 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 	uint32_t ctrl32 = 0;
 	uint16_t ctrl16 = 0;
 	uint8_t ext_ctrl;
+	uint8_t sar = L2CAP_SAR_UNSEGMENTED;
+	uint16_t sdu_len = 0;
+	uint16_t txseq = 0;
+	uint16_t seq_mod = 64;
+	uint16_t frag_len = size;
+	void *sdu_buf = NULL;
+	bool owned;
 
 	switch (cid) {
 	case 0x0001:
@@ -2889,7 +3063,9 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 						frame.psm, mode2str(frame.mode),
 						frame.mode, frame.chan);
 
-				l2cap_ctrl_ext_parse(&frame, ctrl32);
+				sar = l2cap_ctrl_ext_parse(&frame, ctrl32,
+							&sdu_len, &txseq);
+				seq_mod = 16384;
 			} else {
 				if (!l2cap_frame_get_le16(&frame, &ctrl16))
 					return;
@@ -2902,7 +3078,9 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 						frame.psm, mode2str(frame.mode),
 						frame.mode, frame.chan);
 
-				l2cap_ctrl_parse(&frame, ctrl16);
+				sar = l2cap_ctrl_parse(&frame, ctrl16,
+							&sdu_len, &txseq);
+				seq_mod = 64;
 			}
 
 			display_printf("\n");
@@ -2916,6 +3094,46 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 			if (chan && chan->fcs && frame.size >= 2)
 				frame.size -= 2;
 
+			/* Size of just this I-frame's own payload, before
+			 * it is possibly replaced by the full reassembled
+			 * SDU below. Used so the OBEX dissector can limit
+			 * fallback/binary hexdumps to the bytes carried by
+			 * the final fragment, instead of repeating bytes
+			 * already shown while earlier fragments (Start/
+			 * Continuation) were buffered.
+			 */
+			frag_len = frame.size;
+
+			if (sar != L2CAP_SAR_UNSEGMENTED &&
+					sar != L2CAP_SAR_NONE) {
+				if (!l2cap_sdu_reassemble(chan, frame.in, sar,
+								sdu_len, txseq,
+								seq_mod,
+								&frame,
+								&owned)) {
+					/* Still buffering (Start/Continue):
+					 * show the raw fragment payload, the
+					 * upper layer dissector only runs
+					 * once the SDU is fully reassembled.
+					 */
+					if (frame.size)
+						packet_hexdump(frame.data,
+								frame.size);
+					return;
+				}
+
+				if (owned)
+					sdu_buf = (void *) frame.data;
+			}
+
+			break;
+		}
+
+		/* S-frames (supervisory, e.g. RR/REJ) carry no SDU payload
+		 * and must not be handed to upper layer dissectors.
+		 */
+		if (sar == L2CAP_SAR_NONE) {
+			free(sdu_buf);
 			break;
 		}
 
@@ -2945,11 +3163,13 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 		default:
 			if (obex_psm(index, handle, frame.psm))
 				obex_packet(&frame, l2cap_chan_key(index, in,
-								handle, cid));
+							handle, cid), frag_len);
 			else
 				packet_hexdump(frame.data, frame.size);
 			break;
 		}
+
+		free(sdu_buf);
 		break;
 	}
 }
diff --git a/monitor/obex.c b/monitor/obex.c
index 6e69412ff..14f471c62 100644
--- a/monitor/obex.c
+++ b/monitor/obex.c
@@ -1018,6 +1018,36 @@ static void print_unicode_header(const char *label, const uint8_t *data,
 	print_field("%*c%s: %s", indent, ' ', label, buf);
 }
 
+/* When an OBEX PDU was reassembled from multiple L2CAP SAR fragments,
+ * the Start/Continuation fragments have already been hexdumped as raw
+ * bytes by the L2CAP layer while they were buffered. Limit hexdumps
+ * done while decoding the fully reassembled PDU to the bytes carried
+ * by the final (End) fragment, so the same bytes aren't printed twice.
+ * base is the start of the reassembled PDU and from is the byte offset
+ * (from base) where the final fragment begins, or 0 when the whole PDU
+ * came from a single, unsegmented frame.
+ */
+static void obex_hexdump(const uint8_t *base, uint16_t from,
+					const uint8_t *data, uint16_t len)
+{
+	uint32_t offset;
+
+	if (!len)
+		return;
+
+	offset = data - base;
+
+	if (offset + len <= from)
+		return;
+
+	if (offset < from) {
+		len -= from - offset;
+		data += from - offset;
+	}
+
+	packet_hexdump(data, len);
+}
+
 /* Application Parameters (Tag/Len/Value) tag tables for profiles whose
  * tag assignments are known. Tag IDs and names are taken from the
  * PBAP/MAP/BIP specifications; types indicate how to decode a tag's
@@ -1196,7 +1226,10 @@ static void obex_print_apparam_tag(enum obex_profile profile, uint8_t tag,
 
 		/* Known tag but unexpected length (or a raw-bytes type):
 		 * still show the tag's name, with a length + hexdump
-		 * instead of a decoded value.
+		 * instead of a decoded value. Application Parameters are
+		 * small labeled values (not bulk payload like Body), so
+		 * always show them in full instead of clipping to the
+		 * current SAR fragment.
 		 */
 		print_field("%*c%s: [len %d]", indent, ' ', table[i].str,
 									len);
@@ -1232,7 +1265,8 @@ static void obex_print_apparam(const uint8_t *data, uint16_t size,
 }
 
 static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent,
-							uint16_t channel)
+					uint16_t channel, const uint8_t *base,
+					uint16_t dump_from)
 {
 	while (frame->size > 0) {
 		uint8_t hdr_id;
@@ -1301,6 +1335,16 @@ static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent,
 						obex_get_profile(frame->index,
 							frame->handle,
 							channel));
+				else if (vlen && (hdr_id == OBEX_HDR_BODY ||
+						hdr_id == OBEX_HDR_BODY_END))
+					/* Body/End-of-Body can carry large,
+					 * reassembled payloads spanning
+					 * several SAR fragments already
+					 * hexdumped individually; clip to
+					 * avoid duplicating those bytes.
+					 */
+					obex_hexdump(base, dump_from, data,
+									vlen);
 				else if (vlen)
 					packet_hexdump(data, vlen);
 			}
@@ -1366,7 +1410,8 @@ static bool obex_setpath_fields(struct l2cap_frame *frame, uint8_t indent)
 	return true;
 }
 
-void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
+void obex_packet(const struct l2cap_frame *frame, uint16_t channel,
+							uint16_t frag_len)
 {
 	struct l2cap_frame obex_frame;
 	struct l2cap_frame *f = &obex_frame;
@@ -1377,9 +1422,15 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
 	bool is_request = false;
 	const uint8_t *trailer;
 	uint16_t trailer_len;
+	const uint8_t *dump_base;
+	uint16_t dump_from;
 
 	l2cap_frame_pull(f, frame, 0);
 
+	dump_base = frame->data;
+	dump_from = (frag_len < frame->size) ?
+					frame->size - frag_len : 0;
+
 	if (f->size < 3)
 		goto fail;
 
@@ -1440,7 +1491,7 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
 			goto fail;
 	}
 
-	if (!obex_print_headers(f, indent, channel))
+	if (!obex_print_headers(f, indent, channel, dump_base, dump_from))
 		goto fail;
 
 	if (is_request)
@@ -1450,12 +1501,12 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
 	if (trailer_len) {
 		print_field("%*cTrailing data: [len %d]", indent, ' ',
 							trailer_len);
-		packet_hexdump(trailer, trailer_len);
+		obex_hexdump(dump_base, dump_from, trailer, trailer_len);
 	}
 
 	return;
 
 fail:
 	print_text(COLOR_ERROR, "frame too short");
-	packet_hexdump(frame->data, frame->size);
+	obex_hexdump(dump_base, dump_from, frame->data, frame->size);
 }
diff --git a/monitor/obex.h b/monitor/obex.h
index 5af28ea8b..019ed6174 100644
--- a/monitor/obex.h
+++ b/monitor/obex.h
@@ -101,7 +101,8 @@
 #define OBEX_HDR_TYPE_UINT8	0x80
 #define OBEX_HDR_TYPE_UINT32	0xc0
 
-void obex_packet(const struct l2cap_frame *frame, uint16_t channel);
+void obex_packet(const struct l2cap_frame *frame, uint16_t channel,
+							uint16_t frag_len);
 
 void obex_add_channel(uint16_t index, uint16_t handle, uint8_t channel,
 							const char *profile);
diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 89cbf6087..d830684a9 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -405,7 +405,7 @@ static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	}
 
 	if (obex_channel(frame->index, frame->handle, channel, NULL))
-		obex_packet(frame, channel);
+		obex_packet(frame, channel, frame->size);
 	else
 		packet_hexdump(frame->data, frame->size);
 
-- 
2.43.0

