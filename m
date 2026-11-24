Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532227;
	b=oXdiidKV92zYrM0V5tZOfPDZs1e1mb12aMAc48b1GgpL9r6byM9E0jQD1VmI89VAKz2J
	 p7pVoKEJSdsLia0/QvEGWUTO/ok/irn/TriragIILIXCpLnOSVDKtOIQFmLC9I8giAm0v
	 Vex0naeQHpWQtUmXT97kc8gvhlrNIR8GaNOzRe5SBPAPE3S9gx0JEi68kwm2gShh9eWsa
	 wgZM6C0HW5+UshsJvDUJs57597fBKvhTa9V9q8o9aDDX5/VOOyeBTKpdwAQ4KOa0FTW01
	 /HqVpq+JBQDj6F96MfmsgN9IxrYCaDfx//WsG7N2pwX3kdWizKzKGkYx8Jf5vcV6lGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532227;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uFD5kOkJS5jicp6BGOfPAWYZCmXmAm7sxy1k3bO1qX0=;
	b=WxcKlontL1wNlncaUSADQMJ/+EYNaLafxyqvSmNNZTd6WvigiFZKvPpkT/16bpINFpu2
	 j5Cky2utTS8jGbm01UYGgPOLGTW5eO+ZMuXqMaTL1LMgD1iIh7ZiOB5oTxPhHLO1yhPQj
	 WvYKtlys2SZ9+ONCUnYPakCzoVnsJ2iClwXteUKmbdtW9lwhgI6bWsnwrh3Pk18rsi1Wm
	 F9nlpfw1Xqp3r9sY4EpN1i4eCBcoCm0s63lM2Y13mGbX90ApBm/y+anduFvS4kD9DmNrQ
	 OpNJI2V6Lb1YzBWoFqfdichXkVt24V5U6MAVR6BGSg5c0sekX2ZwW/1F5MxECGIeBfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=k9i6VlDx;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D9606A33C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 618D9606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=k9i6VlDx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795532224;
	bh=8FzNN7WIH1eovhabdqmbiN1IhPVNsvLDMebltbUKiUA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k9i6VlDx729y2dEgpDzoyIIx8/C8NpXx/PnKKD+l7eu1LLeJR/8KyK7OPqdTKzcOJ
	 CI6Nw1va+lDTbGy6nvXLVaSWysq/ekTypOywcBjw6F90Qsgs2upSIcmsta1WQuVyzV
	 1LZSHtu/mpcuIcra5XzjyYbPxL7qyNLqhSRaVz3bmXGUajltOUFFLsJgxdass9qqi+
	 yiAWUunMmGSiH2Sc7rsYN5gRHmlGSYkqrnw0Euj4p44TA2SqTeiW15KGFqcgfkVvYp
	 UYnKnWWBidBHcMlGnxy/fWNsPiisSirvcmH1Fjpw5mT8KIYPmobV8jyfhqrxuN8V1i
	 rAFGjjoVU07SA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CE7E417E0FD4
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:57:04 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/6] monitor: Reassemble OBEX PDUs split across RFCOMM UIH frames
Date: Tue, 24 Nov 2026 15:56:52 +0100
Message-ID: <20261124145653.336273-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124145653.336273-1-frederic.danis@collabora.com>
References: <20261124145653.336273-1-frederic.danis@collabora.com>
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

The RFCOMM MTU is typically much smaller than the maximum OBEX PDU
length, so a single OBEX PDU can be split across several UIH frames.
uih_frame() decoded each UIH frame's payload independently, so any
OBEX PDU spanning more than one frame failed to parse ('frame too
short').

Buffer UIH information bytes per index/handle/channel/direction
(obex_frag_list[]/obex_frag_get()) until a complete PDU (3-byte
opcode+length header plus body) is available, then decode it and
keep any leftover bytes for the next frame. Drop the buffer for a
channel when it is torn down (rfcomm_remove_channel(), called
alongside obex_remove_channel() on DISC/DM) so a later renegotiation
of the same channel number doesn't resume from stale fragments.

Assisted-by: Claude:claude-sonnet-5
---
v2->v3: New in v3.
v3->v4:
  - Add rfcomm_remove_handle(), called from the HCI disconnect
    complete handler, to free every fragment buffer still tracked for
    an ACL handle that goes away without an RFCOMM DISC/DM on each of
    its channels.
  - Widen the reassembly buffer's length/position tracking from
    uint16_t to uint32_t, and clamp the amount handed to obex_packet()
    on a malformed declared length to l2cap_frame.size's uint16_t
    range, keeping any excess buffered for the next call instead of
    reporting an incorrect remaining size.

 monitor/l2cap.h  |   2 +
 monitor/packet.c |   1 +
 monitor/rfcomm.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 167 insertions(+), 3 deletions(-)

diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index 1c1f7e609..6cfc25f8c 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -364,4 +364,6 @@ void l2cap_packet(uint16_t index, bool in, uint16_t handle, uint8_t flags,
 
 void rfcomm_packet(const struct l2cap_frame *frame);
 
+void rfcomm_remove_handle(uint16_t index, uint16_t handle);
+
 void l2cap_dequeue_frame(struct timeval *delta, struct packet_conn_data *conn);
diff --git a/monitor/packet.c b/monitor/packet.c
index 7414910c7..ca68c54ae 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12315,6 +12315,7 @@ static void disconnect_complete_evt(struct timeval *tv, uint16_t index,
 	if (evt->status == 0x00) {
 		release_handle(le16_to_cpu(evt->handle));
 		obex_disconnect_handle(index, le16_to_cpu(evt->handle));
+		rfcomm_remove_handle(index, le16_to_cpu(evt->handle));
 	}
 }
 
diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 8a44a2199..a17d7acfa 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -386,12 +386,112 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	return true;
 }
 
+/* An OBEX PDU may be split across several RFCOMM UIH frames since the
+ * RFCOMM MTU is typically much smaller than the maximum OBEX PDU
+ * length. Information bytes are buffered per index/handle/channel and
+ * direction until a complete PDU (3-byte opcode+length header plus
+ * body) is available; complete PDUs are then decoded and any leftover
+ * bytes are kept for the next frame.
+ */
+#define MAX_OBEX_FRAG 64
+
+struct obex_frag_data {
+	uint16_t index;
+	uint16_t handle;
+	uint8_t channel;
+	bool in;
+	uint8_t *buf;
+	uint32_t len;
+};
+
+static struct obex_frag_data obex_frag_list[MAX_OBEX_FRAG];
+
+static struct obex_frag_data *obex_frag_get(uint16_t index, uint16_t handle,
+						uint8_t channel, bool in)
+{
+	int i, n = -1;
+
+	for (i = 0; i < MAX_OBEX_FRAG; i++) {
+		if (!obex_frag_list[i].channel) {
+			if (n < 0)
+				n = i;
+			continue;
+		}
+
+		if (obex_frag_list[i].index == index &&
+				obex_frag_list[i].handle == handle &&
+				obex_frag_list[i].channel == channel &&
+				obex_frag_list[i].in == in)
+			return &obex_frag_list[i];
+	}
+
+	if (n < 0)
+		return NULL;
+
+	obex_frag_list[n].index = index;
+	obex_frag_list[n].handle = handle;
+	obex_frag_list[n].channel = channel;
+	obex_frag_list[n].in = in;
+	obex_frag_list[n].buf = NULL;
+	obex_frag_list[n].len = 0;
+
+	return &obex_frag_list[n];
+}
+
+static void obex_frag_reset(struct obex_frag_data *frag)
+{
+	free(frag->buf);
+	frag->buf = NULL;
+	frag->len = 0;
+}
+
+static void rfcomm_remove_channel(uint16_t index, uint16_t handle,
+							uint8_t channel)
+{
+	int i;
+
+	for (i = 0; i < MAX_OBEX_FRAG; i++) {
+		if (obex_frag_list[i].channel == channel &&
+				obex_frag_list[i].index == index &&
+				obex_frag_list[i].handle == handle) {
+			obex_frag_reset(&obex_frag_list[i]);
+			memset(&obex_frag_list[i], 0,
+					sizeof(obex_frag_list[i]));
+		}
+	}
+}
+
+/* An ACL handle may be disconnected without an RFCOMM DISC/DM on each
+ * of its channels (e.g. the link is simply dropped), which would
+ * otherwise leave both directions' reassembly buffers and their slots
+ * allocated. Free every fragment buffer still tracked for this handle.
+ */
+void rfcomm_remove_handle(uint16_t index, uint16_t handle)
+{
+	int i;
+
+	for (i = 0; i < MAX_OBEX_FRAG; i++) {
+		if (!obex_frag_list[i].channel)
+			continue;
+
+		if (obex_frag_list[i].index == index &&
+				obex_frag_list[i].handle == handle) {
+			obex_frag_reset(&obex_frag_list[i]);
+			memset(&obex_frag_list[i], 0,
+					sizeof(obex_frag_list[i]));
+		}
+	}
+}
+
 static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 {
 	uint8_t credits;
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
 	struct rfcomm_lhdr *hdr = &rfcomm_frame->hdr;
 	uint8_t channel = RFCOMM_GET_CHANNEL(hdr->address);
+	struct obex_frag_data *frag;
+	uint8_t *buf;
+	uint32_t pos;
 
 	if (!channel)
 		return mcc_frame(rfcomm_frame, indent);
@@ -410,10 +510,69 @@ static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 	if (!frame->size)
 		return true;
 
-	if (obex_channel(frame->index, frame->handle, channel, NULL))
-		obex_packet(frame, channel, frame->size);
-	else
+	if (!obex_channel(frame->index, frame->handle, channel, NULL)) {
 		packet_hexdump(frame->data, frame->size);
+		return true;
+	}
+
+	frag = obex_frag_get(frame->index, frame->handle, channel, frame->in);
+	if (!frag) {
+		obex_packet(frame, channel, frame->size);
+		return true;
+	}
+
+	buf = realloc(frag->buf, frag->len + frame->size);
+	if (!buf) {
+		obex_frag_reset(frag);
+		obex_packet(frame, channel, frame->size);
+		return true;
+	}
+
+	memcpy(buf + frag->len, frame->data, frame->size);
+	frag->buf = buf;
+	frag->len += frame->size;
+
+	pos = 0;
+
+	while (frag->len - pos >= 3) {
+		struct l2cap_frame pdu_frame = *frame;
+		uint16_t pdu_len = get_be16(frag->buf + pos + 1);
+
+		if (pdu_len < 3) {
+			/* Malformed declared length: hand over as much of
+			 * the rest of the buffer as fits in l2cap_frame.size
+			 * (uint16_t) and let obex_packet() report the error,
+			 * rather than buffering indefinitely. Any excess
+			 * stays buffered and is retried on the next call.
+			 */
+			uint32_t remaining = frag->len - pos;
+
+			if (remaining > UINT16_MAX)
+				remaining = UINT16_MAX;
+
+			pdu_frame.data = frag->buf + pos;
+			pdu_frame.size = remaining;
+			obex_packet(&pdu_frame, channel, pdu_frame.size);
+			pos += remaining;
+			break;
+		}
+
+		if (frag->len - pos < pdu_len)
+			break;
+
+		pdu_frame.data = frag->buf + pos;
+		pdu_frame.size = pdu_len;
+		obex_packet(&pdu_frame, channel, pdu_len);
+
+		pos += pdu_len;
+	}
+
+	if (pos == frag->len) {
+		obex_frag_reset(frag);
+	} else if (pos) {
+		memmove(frag->buf, frag->buf + pos, frag->len - pos);
+		frag->len -= pos;
+	}
 
 	return true;
 }
@@ -523,6 +682,8 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 		 */
 		obex_remove_channel(frame->index, frame->handle,
 					RFCOMM_GET_CHANNEL(hdr.address));
+		rfcomm_remove_channel(frame->index, frame->handle,
+					RFCOMM_GET_CHANNEL(hdr.address));
 	}
 
 	return;
-- 
2.43.0

