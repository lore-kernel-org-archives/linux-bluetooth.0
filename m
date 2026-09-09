Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8B3A254D
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978542; cv=none; b=mvg27ZWjNs5iwOBTiIZDkImgQOOknmgl18DX1f+qbcIq8MSjBmqsC4iwTGl1usGjTMAJhJn4gAL8dcpHJr5XkBRGEAfqfB8KNFOysug8g0mtq5sPzw5aUfXJ9MWIsPgtKqNwiBkr7nPZuCuMczCnBDY3ngWOL5+gf6xfmCDPRzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978542; c=relaxed/simple;
	bh=R6+fnUIxG5qk8aVJxIdgEMU8HpvwuaYlnZIGCmERI8c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDGwgNdCEBwVTQbK8qawpBQ3oFf7u8TeeaM5ZxG+a9mKfF41MUVSb0hqJ5eLMOh5s+0sRKDT0kbtW9i+H8ONrnTIvORjh+3LScmJdDvGd6OlQ6DEwe5PEgpPWl82rlarKnzp09NeDuGkchFxRoyuKU/zwMtFIDIp6QD+Tb1glXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUH4guU4; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUH4guU4"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5bf959b820cso5419064e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978538; x=1789583338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5iSv8dLUeSA9kyJR90sREiSfPv9vhHgW6nYeqt96Zug=;
        b=kUH4guU4DHSkyulnYzb5RVLaD36TDllPVv/DhuoMPacKl05Q0Go7tgqD+an77CE4al
         ZwXJdPlgZFC62YmuL2X/J1MTwFSFfKIT0oukPOWe6AfdVV9wHeZU0cqa/dBpm9B8T6fk
         Y0uMLml+nHveVtNmfHc/7S+ZwNGMaZup2MeA/Zt1Po927gn06IpnXe+46j/dB3WwduqY
         moJHV4MZ9R7aoK4dUJGaXIbxtAVqswuHJu2Y7rQRuNjksBNT6mbrFKFWLr2TVOv895SC
         yjqxNIeQFdL3sf8ZXyQ4XuFao0BgUBznxn1K4lReAFQ/0xx099vcQuH4jyhrkIQZmD/Y
         gilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978538; x=1789583338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5iSv8dLUeSA9kyJR90sREiSfPv9vhHgW6nYeqt96Zug=;
        b=X+v8KXcFGBbcqoDoz5L4EN/Yqgb+7FNAClM+Pxt6fTHIKbXYB0mZmDirUAYZGHrUS2
         VVUEkY2tvkitduqsVIlry5COnnuzDYxkHkJei4ZVkyqm1RFQ1O/br8On6DQ9lDVElBnr
         y9WI4D4c/Zuz99TRxOEIqnYzIBOdnoc4ISQdjV1muPt7xE7GwEoyYwNJsUX2754l/odz
         RGvKBK2qv9WFg46LTlgkGCvZC7mCXvunXaFF6OXkOLorkWj//KnHlfiq6qIjX+3anAAc
         F50kYW00J8op89Ptwvf6RakRk67SkBpzZD33/ttxHLDf2ZVoZFdN0DvRslaLgAciyJfT
         u1Cg==
X-Gm-Message-State: AFuF++kqll44uIiHTlBivmjRaqz9rTkII0We67oKLvuDYF6/qDFOKB+q
	oPxN2Vg0XEBjQF8BUGFeMHI9wUlHLoNAdPJAUf2n1wA2NF5y1nxuvZeybKu2Yj/p
X-Gm-Gg: AYBFou1iKxVL8Ibsnk37eVr+h/32GKJiTI2bI7k7Cm73pdKPGwyJLrtvHUGD4o3Zl6C
	N8A0gC5Yhiyo9teCzBYujGFlmKjF+AbCXEvfwC8i4TMYyRpU0lCTIvR+dYcOYZwvwt8UNe15Gy0
	tCms8d1eYxHOMyBb5c5qQ26Kfx7ZzbukQjtHc0bprREpMNm/hQ0eerPl3sFmhAQrwZVc8EycI9D
	aTHPLR7hXbSCypnaOgDNKKDQd8IWdKI+4LdLB2zb7bFDzsE/zCXS9ER0oN065PDpAZrDai8KOLG
	L5V8TWq04xtBd/F6dGhfQaozSfbuXzhC0Rg34eH2i9zQvfyCiBJ8bKXi16HSlmzwSoINtczvc1D
	ctpvVrtVYdhZGq8IcAQUTvJ3J1giix3CGNVmkktsZdtBOWGqTloiAp7g7ozBI1SdMJ8Z/JDQvWL
	ho1VC3IPmFhyIouZv0+MIEGF7XUwCmWtatP+5UyfHYZE8snnmujjXk/HKcclKY3qmsnQDiuxqvU
	RB2NTd/Ho5e/Ek4O9f/FudeCSc0Ghpl9L4Wy9zNOYv4v8nv/ZMBS9lgIC6zsyT/a0o=
X-Received: by 2002:a05:6122:4fa5:b0:5c7:d204:db7b with SMTP id 71dfb90a1353d-5c7ed604813mr24085963e0c.3.1788978538396;
        Wed, 09 Sep 2026 11:28:58 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/10] monitor: Reference the request frame on SDP, AVDTP and AVCTP responses
Date: Wed,  9 Sep 2026 14:28:39 -0400
Message-ID: <20260909182840.1289776-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SDP pairs a request with its response through the transaction identifier,
and responses use the request PDU plus one with an Error Response able to
answer any request. AVDTP and AVCTP both pair a command with its response
through the transaction label:

  SDP: Service Search Request (0x02) tid 5 len 8
  SDP: Service Search Response (0x03) tid 5 len 5 #8 (12.400 msec)
  AVCTP Control: Command: type 0x00 label 7 PID 0x110e
  AVCTP Control: Response: type 0x00 label 7 PID 0x110e #12 (23.100 msec)

These all run on dynamically allocated channels, which is what the channel
keyed matching was needed for.

The model wrote the matching, which the author reviewed and verified
against a trace carrying all three over separate channels.

Assisted-by: opencode:claude-opus-5
---
 monitor/avctp.c | 24 ++++++++++++++++++++++--
 monitor/avdtp.c | 24 ++++++++++++++++++++++--
 monitor/sdp.c   | 21 ++++++++++++++++++++-
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 0db352f18ffd..75afaca8342f 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -2512,6 +2512,8 @@ void avctp_packet(const struct l2cap_frame *frame)
 	struct l2cap_frame *l2cap_frame;
 	struct avctp_frame avctp_frame;
 	const char *pdu_color;
+	char req_str[32];
+	uint16_t key;
 
 	l2cap_frame_pull(&avctp_frame.l2cap_frame, frame, 0);
 
@@ -2529,12 +2531,30 @@ void avctp_packet(const struct l2cap_frame *frame)
 	else
 		pdu_color = COLOR_BLUE;
 
+	/*
+	 * A command is answered by a response carrying the same transaction
+	 * label, which is what pairs the two.
+	 */
+	key = l2cap_chan_key(frame->index, frame->in, frame->handle,
+								frame->cid);
+	req_str[0] = '\0';
+	if (avctp_frame.hdr & 0x02)
+		packet_req_str(frame->handle, key, PACKET_PROTO_AVCTP,
+				avctp_frame.hdr >> 4,
+				(struct timeval *)&frame->tv,
+				req_str, sizeof(req_str));
+	else
+		packet_req_add(frame->handle, key, PACKET_PROTO_AVCTP,
+				avctp_frame.hdr >> 4,
+				(struct timeval *)&frame->tv, frame->num);
+
 	print_indent(6, pdu_color, "AVCTP", "", COLOR_OFF,
-				" %s: %s: type 0x%02x label %d PID 0x%04x",
+				" %s: %s: type 0x%02x label %d PID 0x%04x%s%s",
 				frame->psm == 23 ? "Control" : "Browsing",
 				avctp_frame.hdr & 0x02 ? "Response" : "Command",
 				avctp_frame.hdr & 0x0c, avctp_frame.hdr >> 4,
-				avctp_frame.pid);
+				avctp_frame.pid,
+				req_str[0] ? " " : "", req_str);
 
 	if (avctp_frame.pid == 0x110e || avctp_frame.pid == 0x110c)
 		avrcp_packet(&avctp_frame);
diff --git a/monitor/avdtp.c b/monitor/avdtp.c
index d1eb15356602..9d0016d6bc56 100644
--- a/monitor/avdtp.c
+++ b/monitor/avdtp.c
@@ -667,6 +667,8 @@ static bool avdtp_delayreport(struct avdtp_frame *avdtp_frame)
 
 static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 {
+	char req_str[32];
+	uint16_t key;
 	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
 	const char *pdu_color;
 	uint8_t hdr;
@@ -703,10 +705,28 @@ static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
 
 	avdtp_frame->sig_id = sig_id;
 
+	/*
+	 * A command is answered by a response accept or reject carrying the
+	 * same transaction label, which is what pairs the two.
+	 */
+	key = l2cap_chan_key(frame->index, frame->in, frame->handle,
+								frame->cid);
+	req_str[0] = '\0';
+	if ((hdr & 0x03) == 0x00)
+		packet_req_add(frame->handle, key, PACKET_PROTO_AVDTP,
+				hdr >> 4, (struct timeval *)&frame->tv,
+				frame->num);
+	else
+		packet_req_str(frame->handle, key, PACKET_PROTO_AVDTP,
+				hdr >> 4, (struct timeval *)&frame->tv,
+				req_str, sizeof(req_str));
+
 	print_indent(6, pdu_color, "AVDTP: ", sigid2str(sig_id), COLOR_OFF,
-			" (0x%02x) %s (0x%02x) type 0x%02x label %d nosp %d",
+			" (0x%02x) %s (0x%02x) type 0x%02x label %d nosp %d"
+			"%s%s",
 			sig_id, msgtype2str(hdr & 0x03), hdr & 0x03,
-			hdr & 0x0c, hdr >> 4, nosp);
+			hdr & 0x0c, hdr >> 4, nosp,
+			req_str[0] ? " " : "", req_str);
 
 	/* Start Packet */
 	if ((hdr & 0x0c) == 0x04) {
diff --git a/monitor/sdp.c b/monitor/sdp.c
index 9f97ba4bbea0..ce06b73ec59f 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -713,6 +713,8 @@ static const struct sdp_data sdp_table[] = {
 
 void sdp_packet(const struct l2cap_frame *frame)
 {
+	char req_str[32];
+	uint16_t key;
 	uint8_t pdu;
 	uint16_t tid, plen;
 	struct l2cap_frame sdp_frame;
@@ -758,8 +760,25 @@ void sdp_packet(const struct l2cap_frame *frame)
 		pdu_str = "Unknown";
 	}
 
+	/*
+	 * SDP responses use the request PDU plus one, and an Error Response
+	 * may answer any request. The transaction identifier pairs them.
+	 */
+	key = l2cap_chan_key(frame->index, frame->in, frame->handle,
+								frame->cid);
+	req_str[0] = '\0';
+	if (pdu == 0x02 || pdu == 0x04 || pdu == 0x06)
+		packet_req_add(frame->handle, key, PACKET_PROTO_SDP,
+					tid, (struct timeval *)&frame->tv,
+					frame->num);
+	else if (pdu == 0x01 || pdu == 0x03 || pdu == 0x05 || pdu == 0x07)
+		packet_req_str(frame->handle, key, PACKET_PROTO_SDP,
+					tid, (struct timeval *)&frame->tv,
+					req_str, sizeof(req_str));
+
 	print_indent(6, pdu_color, "SDP: ", pdu_str, COLOR_OFF,
-				" (0x%2.2x) tid %d len %d", pdu, tid, plen);
+				" (0x%2.2x) tid %d len %d%s%s", pdu, tid, plen,
+				req_str[0] ? " " : "", req_str);
 
 	tid_info = get_tid(tid, frame->chan);
 
-- 
2.55.0

