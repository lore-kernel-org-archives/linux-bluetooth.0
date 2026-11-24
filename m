Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512180;
	b=yCCRNITEotpAGWQae/nRh+/DK9kuC90w8rv3qc4G1x+cs5Z3NpOHkfELWC7F0+Pi22aM
	 NRnIh5xQK8fEFTAJOVvNEm3GhRZPf4ZaxY9AbnI1qbAhLgUbegcfi3KEFBijOcUPupFlv
	 yGpBnvFITz/VgbjXImrunIf0P63d8cO+Dzfptbi86Y6s4xa4Dp0bZ10umUzpeD7a5fv11
	 wEfRLnQEMcVaPYuzaSqPwM78hMJL0QUPO34ddBZ0QZWZ0CblPTnNASo8h/4Qt60DxXbs3
	 SFJTM+S7RPYJ+03bAa54xtsOOzpqoomoRdLfj1/9a1K28MsCX6ZJM0H5K0g+4jmTNrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512180;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9FOhT3IqaA/u8/HANhD8ndKhQDbU7pmp7K2KOiytir4=;
	b=nQIPJ1WxPtFCn2xbWf3R3lVPvU5joeOZ3IDEDZ6kEsIVKjpRsHqZORXsqvya6QTO+UHa
	 nO1JjvPbOsUYMNLnxTTWyO97+aAiKwyq2VIkckDR0sqO+qJnUXz9D0ntOmGM2GPK1Guvs
	 NGSa/3Px6ZvHEo8pE84yqEuRzW3MPaUahSwKWIMYqWCtKVjunptZk/uuLyriS1nhMarDe
	 7V/bTA3g/JR2eJPrzegR3LxA2osHQYYqpjrFMVocKsMD+p1YFkqO7G4C2MEit82qcXZ80
	 BccTj5I/xTnZ9LUxAYFfyMlA9JKRiBRAeK2AOaK/zqS7PEjTdq5oIYPrn2ae38yhJPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Db55dIbZ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14516606A684
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14516606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Db55dIbZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795512175;
	bh=yc2U94/dh9YbGAwflf37WtjhRDE6y6O/FA/Q4AZQwiA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Db55dIbZgcexw6eKK+2ATcibHFA+HTHT4jBVgmBd3WljoDd02U5Ld+/4t7DMW8q5o
	 adar/XgIy1C9QygAGO2DoXvFNHbZ7AZuiRP+tkgw53XWu/clbNe5s7qqhb1/hkGJ/8
	 Bp//EO28zG6IwqvVV7DzhDsvFnFoXM4iNvTUXL+QAo5VdGAsPfFhF2njKDfvP9PO/f
	 cCOqykdMkr3sBxbzxoA+295eLDvy4p8plK/YyYn95f9pThXcwA5l05m/mG7rvIFdEO
	 mMf7CazzTefuPPX6On3pqWqJ8M20FxmP39pQNqJkn7jmVyFaqYFPY0KuZ2x2YEbsXm
	 pidMZrKtZH18Q==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 75EE817E0A0F
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:22:55 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/6] monitor: Strip trailing L2CAP FCS before upper layer dissectors
Date: Tue, 24 Nov 2026 10:22:42 +0100
Message-ID: <20261124092248.207565-2-frederic.danis@collabora.com>
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
 monitor/l2cap.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index ddc2388d5..a1c90af1d 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -100,6 +100,7 @@ struct chan_data {
 	uint8_t  ext_ctrl;
 	uint8_t  seq_num;
 	uint16_t sdu;
+	uint8_t  fcs;
 	struct packet_latency tx_l;
 };
 
@@ -158,6 +159,12 @@ static void assign_scid(const struct l2cap_frame *frame, uint16_t scid,
 	chan_list[n].ctrlid = ctrlid;
 	chan_list[n].mode = mode;
 
+	/* 16-bit FCS is the default for ERTM/Streaming mode unless the
+	 * peer explicitly negotiates "No FCS" via the FCS configuration
+	 * option (see assign_fcs()).
+	 */
+	chan_list[n].fcs = 1;
+
 	chan_list[n].seq_num = seq_num;
 }
 
@@ -255,6 +262,37 @@ static void assign_mode(const struct l2cap_frame *frame,
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
 static int get_chan_data_index(const struct l2cap_frame *frame)
 {
 	int i;
@@ -882,6 +920,9 @@ static void print_config_options(const struct l2cap_frame *frame,
 					get_le16(data + consumed + 9));
 			break;
 		case 0x05:
+			if (response)
+				assign_fcs(frame, data[consumed + 2], cid);
+
 			switch (data[consumed + 2]) {
 			case 0x00:
 				str = "No FCS";
@@ -2740,6 +2781,16 @@ void l2cap_frame(uint16_t index, bool in, uint16_t handle, uint16_t cid,
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

