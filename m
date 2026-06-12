Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F39312819
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275111; cv=none; b=P1FSSgR4sSX8ee1W707Mu1QwxnmOiglFb2i0BTARx903x5InIfC00OEmOCM81uqY8M/hAxynU3p5B7wu/GmRk31EJ8V0aFh8Yxii71qsgHsxemM4ebHBCnFErlf78j+xwYJiuguWr0R8JMsLYpKk3SJHwD3Bezm8wdK3TePkxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275111; c=relaxed/simple;
	bh=Zf9BFyNfp4luVAn/p8NXF1JNodQLnd8uDU3J2V75aqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhxiQ79SEMGW3Bl4IhRec19pAgNqZROugM0L16heXUfyRyE3fi9rzSeSMat1RAbVycS1ZBxdoxBBsulRqaAvFTggDJxi4OvaKTqqxI4jHgW1+yDA7JO+r7oJAo/pAAuiu1teLor0+5KPG1uDseiW75kp7kWF1x4Lwz0XVSlPyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hornang.me; spf=pass smtp.mailfrom=hornang.me; dkim=pass (2048-bit key) header.d=hornang.me header.i=@hornang.me header.b=SLyYi2eV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hk0zpKVe; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hornang.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hornang.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hornang.me header.i=@hornang.me header.b="SLyYi2eV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hk0zpKVe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68C5C7A016A;
	Fri, 12 Jun 2026 10:38:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 10:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hornang.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1781275108; x=1781361508; bh=mzJLsdPaxj7dNRpLgbUgz
	8n48W8PLNGlNN/5gaW74NM=; b=SLyYi2eVSkznR27hlomaAHO0YLZDKK6vEXSp8
	ZQJeKpc4zxNEujYT0JK7tP0DCiXIHxYUHhgx1pQkSCiLjSUh8Iv6bnOMgJSWk12n
	wvzGCo0dHt/PwYp61mmOQfdtSUMSjoulCTTc0CNpXnMWJjU0NKiWOHFpAN06TRoo
	SXQsfZ1uybLr3ard7VN8WLPcCVGJpjCwBQfQYYf15mlrfuKkYgb9/Yat1wL4axok
	FOB+foNjyZhV28mcxSJZVvogK/Ph7O9kBEdQAMQL3Mu6BL2uTRHmUqP+2rfxzIjH
	gI/QkFdV15Uba5KdZv1buMhyexdrD46K+FIX+hmxNdOQaSv+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781275108; x=1781361508; bh=mzJLsdPaxj7dNRpLgbUgz8n48W8PLNGlNN/
	5gaW74NM=; b=Hk0zpKVeCULcObhFLNTL1W0ndDDEhfszzRVWO8cBpCz/N1a1BIf
	+Jq5O6HDU7UWsIkVbdPUNex/3uM6yY7ZO9IXH32g9pe5L9m7O/4XrpSLlFUNDw6X
	OCFop1JCPc5EzGD3smmPfj/0BgBdln99H9xE7uXsZXE8wJqtFRFKTucMpxaWbDBm
	tSDyFud6Db5WPHVII1K7+fgP51n0yTUz24/egic9az+Oh+MR6f/+vcGJFTMa6mLf
	6jczXuU/nYR+SjTjfDrzOSAE0XFRTkhl9bSna0p/y4W6H/nvVKmEzv9bqSy+wOTg
	ifdKLGAk+al61JCsRllmx5E3C7sRXqxMNhg==
X-ME-Sender: <xms:4xksasVX0xjzjUIQ4jY0mEqKTL2sCPXgSuOaChg44oTKyvL4Mgo4fQ>
    <xme:4xksankdopVOXddsi0J9alXFaWgaPB2PJGDB1l7JjmpEyePSIjQRLPHeFpq8JW77n
    i0W9oxVSaBm0lVon1cRCs47XLD5gIV0WQqIw4kEoK2oFXZp9fYxrJ8>
X-ME-Received: <xmr:4xksalZQ9-P9YqYNUQKaPsPWcstQesG4nvOtkqtM0GRB4YgMFeGZt43jLEoArVOT5sVkSTOp96qfFYlc2BQfVh1kgeGeb4adVKtL0go>
X-ME-Proxy-Cause: dmFkZTGWPSe2TIkkMn135iguxO9qlFGvAvlWym44kl9olX2C6Ix7XJPqg7hjGp9jBscHcc
    a7GjEKgYp1/R/0X4Gu4zE5SJTTv8HJLXljlMD4Bg/zBZXuSXqkaq/IW19S6YtrPrMegP56
    PdeInORfehct/Y15Amk+RlzCd3WvcwdZ1JaI1O1eCvoVPQ2XW47Z83uMhwccBrOp/PkiV5
    hxeC1r2Ym/T71Gu6kkh6f9d6Q53yw4Okri3U+BQ2asATErg326uXYpSpQ1m+1ugCXGA+ad
    u+agT99+O/BWiO+moqvLXaKZ6BkpdIxA6aWRS7zTnhCX8yvO5NM86dvkbBSj9JLRGZNMql
    nV98mE5czPEmrSNzLYqeRFylQZrZ0nuG284sHafg+h40Y6jJUrWYR+SVNlZvB2oaeP6lnv
    AjK62EVmH6BhaMpcRHRnMeDEn2PeFf3A/ghI9mycd9i0bn8mph6ziSts2HIzJl1M5yn+os
    iM4fa9Gcr7fBCesj1tk4HuX/6JtyiXmuO2Lg/z2cxH9xOESRzGNWm6A+GbYi+kzrehQCH6
    xyaul2Rl/IuwvbcILpBURPpas+Wve6pIRL+d9c9ab7XAY1ZcwBMoDNTryHoRkBi+VlROfm
    irS1vTEd2KA4o8fgY2SvohAJxNJmRH8uw63yt5EQL6PPQQyGL2CzlynMBL2Q
X-ME-Proxy: <xmx:4xksaqOG4r66DSIOvoUZeCn1p5ZbxjDHN2rB03v574Nkes3UEDUo0A>
    <xmx:4xksaib77vDtjVsbfpPUhwtxmGP0sX55RAPPG1S5_5GMVT2uT2IyyA>
    <xmx:4xksag1hAxVc2LlBH0OOTO3780z10Y-n5NEAn3QKGq0Ybfl5gc15Kw>
    <xmx:4xksagcUiUE_u7wWZ3eTtixVZYIm1sb0ChiNrQNFK9XNiApuEfwu8Q>
    <xmx:5BksamKpoYoAcE8lfui_gNxYUh6Su_tc0eUsliTwaaW49LJy2AbAeXpa>
Feedback-ID: i9c9648fe:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 10:38:26 -0400 (EDT)
From: Stig Hornang <stig@hornang.me>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Stig Hornang <stig@hornang.me>
Subject: [PATCH] Bluetooth: L2CAP: fix tx ident leak for commands without a response
Date: Fri, 12 Jun 2026 16:38:18 +0200
Message-ID: <20260612143818.167643-1-stig@hornang.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6c3ea155e5ee ("Bluetooth: L2CAP: Fix not tracking outstanding
TX ident") changed ident allocation to use an IDA, releasing idents in
l2cap_put_ident() when the matching response command is received.

But identifiers allocated for commands that have no response defined
are never released. In particular L2CAP_LE_CREDITS is sent repeatedly for
the lifetime of an LE CoC channel, so a peer streaming data to the
host exhausts the 1-255 ident range after 254 credit packets. From
then on l2cap_get_ident() fails:

    kernel: Bluetooth: Unable to allocate ident: -28

and every subsequent L2CAP_LE_CREDITS packet is sent with ident 0,
which is invalid (Core Spec, Vol 3, Part A, Section 4: "Signaling
identifier 0x00 is an invalid identifier and shall never be used in
any command"). Remote stacks that validate the ident drop these
commands, never receive new credits, and the channel stalls
permanently. With default socket buffers this happens after roughly 0.5 MB
of received data (the exact amount depends on the socket receive buffer):

  < ACL Data TX: Handle 2048 flags 0x00 dlen 12
        LE L2CAP: LE Flow Control Credit (0x16) ident 0 len 4
          Source CID: 64
          Credits: 1

Release the ident immediately after sending L2CAP_LE_CREDITS since no
response will ever release it. Use a local variable instead of
chan->ident so that an ident that an EXT_FLOWCTL channel may be waiting on
(e.g. a pending reconfigure) is not overwritten by a credit packet.

Also add the missing L2CAP_LE_CONN_RSP case to l2cap_put_ident() so
idents allocated for outgoing L2CAP_LE_CONN_REQ commands are released
when the response arrives.

Fixes: 6c3ea155e5ee ("Bluetooth: L2CAP: Fix not tracking outstanding TX ident")
Assisted-by: Claude:claude-opus-4.8
Assisted-by: Fable:5
Signed-off-by: Stig Hornang <stig@hornang.me>
---
 net/bluetooth/l2cap_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4810,6 +4810,7 @@ static void l2cap_put_ident(struct l2cap
 	case L2CAP_ECHO_RSP:
 	case L2CAP_INFO_RSP:
 	case L2CAP_CONN_PARAM_UPDATE_RSP:
+	case L2CAP_LE_CONN_RSP:
 	case L2CAP_ECRED_CONN_RSP:
 	case L2CAP_ECRED_RECONF_RSP:
 		/* First do a lookup since the remote may send bogus ids that
@@ -6632,6 +6633,7 @@ static void l2cap_chan_le_send_credits(s
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_credits pkt;
 	u16 return_credits = l2cap_le_rx_credits(chan);
+	int ident;

 	if (chan->mode != L2CAP_MODE_LE_FLOWCTL &&
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL)
@@ -6649,9 +6651,18 @@ static void l2cap_chan_le_send_credits(s
 	pkt.cid     = cpu_to_le16(chan->scid);
 	pkt.credits = cpu_to_le16(return_credits);

-	chan->ident = l2cap_get_ident(conn);
+	ident = l2cap_get_ident(conn);
+
+	l2cap_send_cmd(conn, ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);

-	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
+	/* L2CAP_LE_CREDITS has no response so the ident is never released by
+	 * l2cap_put_ident() - release it right away, otherwise the tx_ida
+	 * range is exhausted after 254 packets and from then on credits are
+	 * sent with the invalid ident 0, which some remote stacks ignore,
+	 * stalling the channel.
+	 */
+	if (ident > 0)
+		ida_free(&conn->tx_ida, ident);
 }

 void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
