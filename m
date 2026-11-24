Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512184;
	b=XCU7pp4aJpOsgEoYDP8N9CZvst7cbEZSuGgjiOJqSmyfrZGtAWov1/xInjVTEYla/8vp
	 pX/FgRZQR8lV0HFdZq0Wjmb5bw8maXvTn9KgaM4GYtEJ+qeJrgsFD7NzMjdPYpViLvOvs
	 4Zi5135nUVF0BTDIT296wukZ4HB4yuyDquR2XkmtiyejT4usPoB7gg2KasvnMB5DL/cOn
	 MKJ8Oega1kjAgsHVd+C6ddqu9d/SZtwjuQh5qR6JLDKdV5hA7jpkjRAoJQkmQQMWPTapk
	 iGNIUBIx3iaHK9z3/FifUxvCBa2w95bq2EKdXAUJsGkl2XyQ0JAslIXtpp8oNda0SEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512184;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YwXkbkl3iVfk8gBLB83HdRUtSP0q2a/7T4pw6qDz2fk=;
	b=hbqjcLE1ufwOmZ7/MLhbom89nmFTcCU6Og1OvDq/nznBK7MDR0kJgE/fLKA3aA5noLHA
	 ab6051OSa2zGXldpoGVwtVfId/SpvbjWl4G+TV/+lKfV2nUdL+HavV9+mWZrkR59wg5QO
	 zM8WXeRApY5IsrdO8E/LBIFAFuB3pRZ/sbh01FUqykE1KAsr9kmEqBhnnEAV0Gj7hZT2B
	 ItFPBCCQmwvA0K7fKXymgTW1E/4OacFbx/ZE3QQU7v/0/QucSaPNfrFi3gQ482Or3LMGw
	 wCW1xLODlIwzVWkgIZwG3P+8ZXLhLcbZe4pJudukM6a+iN6Z9LaCLUHEn4QYDAFFWZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nxNom1rj;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128B606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6128B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nxNom1rj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795512176;
	bh=QCuTkRddL2dTqO+tNFLoWEnI/1asLb9f+dutsx8+yyY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nxNom1rjF4q4TA1V29XrA7cC/WBOj4M3w/SACFC+d5UtGI0UGG084t6ik5xM2fFDM
	 W7MCaOp/HwERsi+KDUvhIpYCx3IuJW2CWxLgzy/FrhCJ6xt/PPPzmlEwHmdrecPO/a
	 uJZlsSJs6rBNXaUKy21pHj83ymV6b8ISNvSTWjUNep/gD9rC3O9AiJT+fVDVZmtEPV
	 owlBbF13q/xIB+xFVqy7l7eHeKqEyJlX8hyHE4HWD4hlfZxgq8fgayhTBYC/N/ldn6
	 3hHXkKv/LlRHKJlEE6kXr9fp6LcJXLqtKVwpzitnmKOuXnmq/L1F1sB7qVUg8rAphj
	 1wYKaGVJGm5MA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BB1ED17E1031
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:22:56 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/6] monitor: Reassemble OBEX PDUs split across RFCOMM UIH frames
Date: Tue, 24 Nov 2026 10:22:47 +0100
Message-ID: <20261124092248.207565-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124092248.207565-1-frederic.danis@collabora.com>
References: <20261124092248.207565-1-frederic.danis@collabora.com>
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

 monitor/rfcomm.c | 138 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 3 deletions(-)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 8a44a2199..b49adb324 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -386,12 +386,90 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
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
+	uint16_t len;
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
 static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
 {
 	uint8_t credits;
 	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
 	struct rfcomm_lhdr *hdr = &rfcomm_frame->hdr;
 	uint8_t channel = RFCOMM_GET_CHANNEL(hdr->address);
+	struct obex_frag_data *frag;
+	uint8_t *buf;
+	uint16_t pos;
 
 	if (!channel)
 		return mcc_frame(rfcomm_frame, indent);
@@ -410,10 +488,62 @@ static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
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
+			/* Malformed declared length: hand over the rest
+			 * of the buffer as-is and let obex_packet() report
+			 * the error, rather than buffering indefinitely.
+			 */
+			pdu_frame.data = frag->buf + pos;
+			pdu_frame.size = frag->len - pos;
+			obex_packet(&pdu_frame, channel, pdu_frame.size);
+			pos = frag->len;
+			break;
+		}
+
+		if ((uint16_t) (frag->len - pos) < pdu_len)
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
@@ -523,6 +653,8 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 		 */
 		obex_remove_channel(frame->index, frame->handle,
 					RFCOMM_GET_CHANNEL(hdr.address));
+		rfcomm_remove_channel(frame->index, frame->handle,
+					RFCOMM_GET_CHANNEL(hdr.address));
 	}
 
 	return;
-- 
2.43.0

