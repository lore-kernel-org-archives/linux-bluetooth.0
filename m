Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532226;
	b=1IMWZIzWzIAlK5krstA7E9Hy5c9eBxtCMAlyrWtcy1eZhqIbF3xNc5vOq5YibRAmgNen
	 8QUSeUtNBzSoYzNvtaht16oEXLR6HIVmWLl3C63IgJHIeXGUGIca3J4hnOs+CIpEnCQja
	 6m5hh3b3tA9Sy6oOvVXWWn4gPpJPYWbkSNpvzuRqxc142CayJU4r6CCmlHetj2DjMw0K2
	 eY4TjG6PNFjLq6Tv4aB3BvmkrkPtoJT8a8ClMu21+oS9FK2FlyMot334/Qx2wtk6UZ/Up
	 lGNTEjJ9yRktVKO3f7fYnrYZfxnmNnXPEjFdPqcDDCfL9M3b9g1azFW1vtZFEUQRqJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532226;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rI2NdPHwj+rbbSNN8XipxukML9FpNZsd/md7ScWlb9s=;
	b=2lqAxqCeWtgrTfxurUwLIZu9niXtM6nSTQlSdWY1OGa5TvAJJY/FOmanrgvYTOK1O07g
	 2q2p3Qd/EaXcTHqQMslIBSDUPnSQCskyRwxoguE29f5ZexkPxecGicja63QliF+SaDt50
	 pmUC2xWpQZJ7YjAPmm4njp7aH7KO4y4NrVLTN0lfX9lZva9tBW7lahtvxrIyOHjTx3vB/
	 UEqBjR3aB2/8qK87i5st9sy55T8DMl76LpDP3aW2mAHoYRdveQq8Rvcr/iYjwbtKP2Ng4
	 LxD1pnnCbLUx/a1gX0lXuXX3BfvJ9FqrEqh+6s1gjVcFvJmoXQu7LlT8av/E8y0LBBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=FbPiwSPm;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584F606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2584F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=FbPiwSPm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795532223;
	bh=wLsDPgZf+yUmv6T2hqX8ptzNXHS1Xeo4lzF/Sg/aHRI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FbPiwSPmtt0ffr1wDKtY9Ngj7kcqgtenK/hBIUXIfdnYp5r3UnCXnv+RGcqWgQZV2
	 0DdZOK7OI8jUV/awUA+fLrLuXcceDQVgwPPDuVhDZcr5siDzHqgAhQi1Zh6B8QORyp
	 AVmQUv4zTlDGJkRljWs1kihCZyKTBjvXVQGKDOiXoJc2Ol32LzfhVmiXfca1Wos/Mj
	 wl+zud6YJNmapeAq5/KdNLi7FaPlAjEvP5vAVc5MtYcb7NqcGFms3+gzpdUQJWTL7D
	 NPRY+DjaqhiB1dqaIu8prgZ+fcBNKnZ7nVKpR0Sub1LgNkXXDhGPkSWV+jQgELYMTP
	 bLfw5+/iZ5q/g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9409E17E047C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:57:03 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/6] monitor: Strip trailing L2CAP FCS before upper layer dissectors
Date: Tue, 24 Nov 2026 15:56:47 +0100
Message-ID: <20261124145653.336273-2-frederic.danis@collabora.com>
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

Verified against a real btsnoop capture: the spurious 2-byte "Trailing
data" hexdump after every OBEX PDU on an ERTM channel is gone, while
decode output is otherwise unchanged (109 OBEX PDUs decoded before and
after).

Assisted-by: Claude:claude-sonnet-5
---
v3->v4:
  - Track the FCS value requested by a Config Request and apply it on
    a successful Config Response that doesn't repeat it (a successful
    response need not repeat accepted options), instead of only
    reading the FCS option when the response itself carries it.

 monitor/l2cap.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index ddc2388d5..3fc876f5a 100644
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
 
@@ -255,6 +264,98 @@ static void assign_mode(const struct l2cap_frame *frame,
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
 static int get_chan_data_index(const struct l2cap_frame *frame)
 {
 	int i;
@@ -882,6 +983,11 @@ static void print_config_options(const struct l2cap_frame *frame,
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
@@ -1188,10 +1294,13 @@ static void sig_config_rsp(const struct l2cap_frame *frame)
 	print_cid("Source", pdu->scid);
 	print_config_flags(pdu->flags);
 	print_config_result(pdu->result);
-	if (pdu->result == 0x0003)
+	if (pdu->result == 0x0003) {
 		print_unknown_options(frame, 6);
-	else
+	} else {
+		if (pdu->result == 0x0000)
+			apply_req_fcs(frame, le16_to_cpu(pdu->scid));
 		print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
+	}
 }
 
 static void sig_disconn_req(const struct l2cap_frame *frame)
@@ -2740,6 +2849,16 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
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

