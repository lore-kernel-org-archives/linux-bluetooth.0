Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444263;
	b=r2hd9XCU5C2Q0QfWRZctVhG1O5cU/fLjqxZ7PhUFb7gSs9tyievXGb9JJd9HvuzdAKjW
	 sYG+1LF7Ncexn6L81pRwperKuQB38oSxYmWDh4j4Uvab28eUDnIBcQiKdRPLGi209aAQL
	 jgbMhWfJ4QTvPUZlDk2Kfj3yN+yPbuC8FmygFcHOZEvayZMxYM/jc05+LETfjcfnFp3gs
	 qd18cL3D7D+4/8Sgn4kvaf2Zbo26YimX6t6ibKUS7zlKm42bHrVQzMz6FNkyJcxfE9UkR
	 TBYzVXn5DnqXuhY8XHuIbQPJrE5ztclhrgl3uZn9BzEzQM71/k7clQsSJvsoML5mcYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444263;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YLF87eN/uU/wqvmvlFHoOiiN67mCEi5yALyn3P/yr8o=;
	b=xTbupfz/NJnG+vZaJr4iDoXrkFMZ9///z8l0SGDaNM5fR3HSkS6DxSozfkuhmvKn0TEN
	 y2Q+2UtzKEXEHU6eyudXAeFxxDVQiW9AYlut3Fa8X42E+mgz1ZgZw+ZKwteejDsrviy1w
	 6HfbSBbi+/nWFBep+eLYbnUK3CrFKBSO35J25jAR1X09PaDyz1HSYytOzmf+GmOytvpIF
	 GCOsS5xmnaayO57Z7ABssvTfJOhopQ25r/EIecQ7eRG5AbNJOdcUkgsryKUq5jcOb7/K8
	 38iwYeWQ40570SKhrjSDsB9q5xNhHgPkbfrkaqANCKSFaMq9Cmt4/CNmx+60hCf+HjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Kw0dAo4n;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350A7606A33C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 350A7606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Kw0dAo4n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795444260;
	bh=WsBRTtICNGWnSvJhfOS8taVkxqUOxDW6E23Q4+HWFtY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Kw0dAo4n/9jK8SUkf4hJK+re7TksUlvi75JQrU8AHT6C2xEJ85XmYamXrGpYsMt1Z
	 zHqes51x+VP/J0w2EZ2P9bxlX6PIz9puxgTs0i+pz3Myi1irF6qqGWliCLy32mTxkU
	 bYf1+EPDMYqp/eKUyD0y3biPBfjL+QP2605NoPj1HrXr69PtRCV8tim+S1dCrG/wRJ
	 5S01rWHFevtCtHJiInQ+2YnNYRqv6y8LOk1hxj+soDC9OsO/yUyYqvH5lec2lqfIXG
	 pgh42O6phmc6EOVenIflSOC7EQPQ7ZCi4WvIZ0q9gu+wuO4qKeza6D81C+y1EvYf2N
	 N3jL1mg0+lO2A==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A84C717E0FB8
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:31:00 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] monitor: Reassemble L2CAP ERTM/Streaming fragments before dissecting
Date: Mon, 23 Nov 2026 15:30:54 +0100
Message-ID: <20261123143054.116007-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123143054.116007-1-frederic.danis@collabora.com>
References: <20261123143054.116007-1-frederic.danis@collabora.com>
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

Assisted-by: Claude:claude-sonnet-5
---
v1->v2: Fix commit title issue

 monitor/l2cap.c  | 175 ++++++++++++++++++++++++++++++++++++++++++-----
 monitor/obex.c   |  63 +++++++++++++++--
 monitor/obex.h   |   3 +-
 monitor/rfcomm.c |   2 +-
 4 files changed, 216 insertions(+), 27 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 3e7f2f97a..8a196f2fe 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -86,9 +86,21 @@
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
+};
+
 struct chan_data {
 	uint16_t index;
 	uint16_t handle;
@@ -102,11 +114,19 @@ struct chan_data {
 	uint8_t  seq_num;
 	uint16_t sdu;
 	uint8_t  fcs;
+	struct l2cap_sdu sdu_rx[2];
 	struct packet_latency tx_l;
 };
 
 static struct chan_data chan_list[MAX_CHAN];
 
+static void reset_sdu_rx(struct chan_data *chan)
+{
+	free(chan->sdu_rx[0].data);
+	free(chan->sdu_rx[1].data);
+	memset(chan->sdu_rx, 0, sizeof(chan->sdu_rx));
+}
+
 static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
 			uint16_t psm, uint8_t mode, uint8_t ctrlid)
 {
@@ -146,6 +166,7 @@ static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
 	if (n < 0)
 		return;
 
+	reset_sdu_rx(&chan_list[n]);
 	memset(&chan_list[n], 0, sizeof(chan_list[n]));
 	chan_list[n].index = frame->index;
 	chan_list[n].handle = frame->handle;
@@ -182,11 +203,13 @@ static void release_scid(const struct l2cap_frame *frame, uint16_t scid)
 
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
@@ -480,8 +503,11 @@ static char *mode2str(uint8_t mode)
 	}
 }
 
-static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
+static uint8_t l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl,
+							uint16_t *sdu_len)
 {
+	uint8_t sar = L2CAP_SAR_NONE;
+
 	display_printf("      %s:",
 		ctrl & L2CAP_EXT_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
 
@@ -493,16 +519,14 @@ static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
 		if (ctrl & L2CAP_EXT_CTRL_POLL)
 			display_printf(" P-bit");
 	} else {
-		uint8_t sar = (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
+		sar = (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
 						L2CAP_EXT_CTRL_SAR_SHIFT;
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
 		display_printf(" TxSeq %d",
 			(ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
@@ -514,10 +538,15 @@ static void l2cap_ctrl_ext_parse(struct l2cap_frame *frame, uint32_t ctrl)
 
 	if (ctrl & L2CAP_EXT_CTRL_FINAL)
 		display_printf(" F-bit");
+
+	return sar;
 }
 
-static void l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl)
+static uint8_t l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl,
+							uint16_t *sdu_len)
 {
+	uint8_t sar = L2CAP_SAR_NONE;
+
 	display_printf("      %s:",
 			ctrl & L2CAP_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");
 
@@ -529,17 +558,13 @@ static void l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl)
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
 		display_printf(" TxSeq %d", (ctrl & L2CAP_CTRL_TXSEQ_MASK) >>
 						L2CAP_CTRL_TXSEQ_SHIFT);
@@ -550,6 +575,8 @@ static void l2cap_ctrl_parse(struct l2cap_frame *frame, uint32_t ctrl)
 
 	if (ctrl & L2CAP_CTRL_FINAL)
 		display_printf(" F-bit");
+
+	return sar;
 }
 
 #define MAX_INDEX 16
@@ -2704,6 +2731,70 @@ static void smp_packet(uint16_t index, bool in, uint16_t handle,
 	opcode_data->func(&frame);
 }
 
+/* Reassemble ERTM/Streaming mode SAR fragments (Start/Continuation/End)
+ * into a single SDU before handing it to the upper layer dissector.
+ * Returns true when frame now holds a complete payload ready for
+ * dispatch (either because sar is the end of a multi-fragment SDU, or
+ * because reassembly could not be tracked and the single fragment
+ * should be dispatched as-is). Returns false while more fragments are
+ * still expected.
+ */
+static bool l2cap_sdu_reassemble(struct chan_data *chan, bool in,
+					uint8_t sar, uint16_t sdu_len,
+					struct l2cap_frame *frame)
+{
+	struct l2cap_sdu *sdu;
+	uint32_t len;
+
+	if (!chan)
+		return true;
+
+	sdu = &chan->sdu_rx[in ? 1 : 0];
+
+	if (sar == L2CAP_SAR_START) {
+		if (sdu->data) {
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
+			return true;
+		}
+	} else if (!sdu->data) {
+		print_text(COLOR_ERROR, "unexpected continuation segment");
+		return true;
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
+
+	sdu->data = NULL;
+	sdu->len = 0;
+	sdu->total = 0;
+
+	return true;
+}
+
 void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 			uint16_t psm, const void *data, uint16_t size)
 {
@@ -2712,6 +2803,10 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 	uint32_t ctrl32 = 0;
 	uint16_t ctrl16 = 0;
 	uint8_t ext_ctrl;
+	uint8_t sar = L2CAP_SAR_UNSEGMENTED;
+	uint16_t sdu_len = 0;
+	uint16_t frag_len = size;
+	void *sdu_buf = NULL;
 
 	switch (cid) {
 	case 0x0001:
@@ -2778,7 +2873,8 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 						frame.psm, mode2str(frame.mode),
 						frame.mode, frame.chan);
 
-				l2cap_ctrl_ext_parse(&frame, ctrl32);
+				sar = l2cap_ctrl_ext_parse(&frame, ctrl32,
+								&sdu_len);
 			} else {
 				if (!l2cap_frame_get_le16(&frame, &ctrl16))
 					return;
@@ -2791,7 +2887,8 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 						frame.psm, mode2str(frame.mode),
 						frame.mode, frame.chan);
 
-				l2cap_ctrl_parse(&frame, ctrl16);
+				sar = l2cap_ctrl_parse(&frame, ctrl16,
+								&sdu_len);
 			}
 
 			display_printf("\n");
@@ -2805,6 +2902,44 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
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
+								sdu_len,
+								&frame)) {
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
+				if (sar == L2CAP_SAR_END)
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
 
@@ -2833,16 +2968,18 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
 			break;
 		case 0x1001:
 			obex_packet(&frame, l2cap_chan_key(index, in, handle,
-									cid));
+								cid), frag_len);
 			break;
 		default:
 			if (obex_psm(index, handle, frame.psm))
 				obex_packet(&frame, l2cap_chan_key(index, in,
-								handle, cid));
+							handle, cid), frag_len);
 			else
 				packet_hexdump(data, size);
 			break;
 		}
+
+		free(sdu_buf);
 		break;
 	}
 }
diff --git a/monitor/obex.c b/monitor/obex.c
index 873e3b538..de76f347e 100644
--- a/monitor/obex.c
+++ b/monitor/obex.c
@@ -903,6 +903,36 @@ static void print_unicode_header(const char *label, const uint8_t *data,
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
@@ -1081,7 +1111,10 @@ static void obex_print_apparam_tag(enum obex_profile profile, uint8_t tag,
 
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
@@ -1117,7 +1150,8 @@ static void obex_print_apparam(const uint8_t *data, uint16_t size,
 }
 
 static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent,
-							uint16_t channel)
+					uint16_t channel, const uint8_t *base,
+					uint16_t dump_from)
 {
 	while (frame->size > 0) {
 		uint8_t hdr_id;
@@ -1186,6 +1220,16 @@ static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent,
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
@@ -1251,7 +1295,8 @@ static bool obex_setpath_fields(struct l2cap_frame *frame, uint8_t indent)
 	return true;
 }
 
-void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
+void obex_packet(const struct l2cap_frame *frame, uint16_t channel,
+							uint16_t frag_len)
 {
 	struct l2cap_frame obex_frame;
 	struct l2cap_frame *f = &obex_frame;
@@ -1262,9 +1307,15 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
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
 
@@ -1318,7 +1369,7 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
 			goto fail;
 	}
 
-	if (!obex_print_headers(f, indent, channel))
+	if (!obex_print_headers(f, indent, channel, dump_base, dump_from))
 		goto fail;
 
 	if (is_request)
@@ -1328,12 +1379,12 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
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

