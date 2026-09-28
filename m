Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1344E56C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616841; cv=none; b=H3ZYn025B49YxgFrh89ahoAgxXJeaqgPYXvCz0RD9xnIKQczvLq7Jj3qSo3l/7FsqzaR6a5hk/rTqDaR3xgjg3sV75qLwvusk5fBjLQGJLuDoPZhFxZM2lTaXNj6tO+LRxCxoiLhcVucOiXIY2wBS3AwKtUibLhOQ9MLaGazfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616841; c=relaxed/simple;
	bh=ZIMmR0iO3tP53NP400Otizty4rxLLdd3oiFThc5jie8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z38bmJQfrBcUT/3TNEiMuW70GDl3bDUdFpf3Pi5vdBMT0ep2NM64Y02v8FMPF9N9Xa0zXmZ3c1RI0CaIYwFfeW97rUFx9bdqXJ6Gb0gWoem/XbDHn3ESi7VUC4qXSnAmyQdwetVh5LJNyHLt7/CPgK5LCZuntaXuV9DzB5Wecow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=xd69bgQ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bX3W7V6X; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="xd69bgQ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bX3W7V6X"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 371B514000F0;
	Mon, 28 Sep 2026 13:33:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 13:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1790616838; x=1790703238; bh=HxeizjDJLrH9MQ9/CFLRU
	eRKMHOd4CfrS1OKdZfHQyM=; b=xd69bgQ5ArNhOJwvckKpYO+kytE6OIVX70hXJ
	EaAX2EcKuKihUBBAly27qH0ER7vHVXuI3c3b1epsONg9DHcSMWjeCbU+yE+7WR5L
	TsCD634mhqpcfW/5jBsGYY8fwwyo5huSjIgJzkG5oFVn6y6HUzjLI1SRS6RSIQBx
	RkSduB2I1qbqbzi1NKOJ/AKKkKhfjWvciDTIG5iOuNqBVLJjz8q9pn8eGJZlFkLe
	FNhPCQeWu6we7Ils+a11WEIlpjQN0AQpe8rURMyNmtqQ+P5RbiJv0giMJWImRHzC
	v9puXLB2+n/U3Uc1bbUB4UBpi21ccRXRt10PeOREZ2Pb2XVSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790616838; x=1790703238; bh=HxeizjDJLrH9MQ9/CFLRUeRKMHOd4CfrS1O
	KdZfHQyM=; b=bX3W7V6XokxBVWf2PXq9zB1u5VPkNEQAIJiwEfG/o9ZmTCBNKNE
	4OogoA5VfAeUdjBxVp2gYkwkeMwOlJOHLyOvLgg33EtA/nIUnp9YZvOjNBsCBWaf
	OvTBawqmId4sABQhPjmn5EZcOR/tSqTOsoe3+PJLwb0tNQJmATdpwB6amenkYgEd
	pGz9w6/tdrT73Pu3blyGb34chyimY4xc+8WCiKzFDupRGCL677y0Wxaym2x59ecP
	ClnyzAijvL31562IhPfP253bMGnjDaRlDaa9vfQ59A44Bsns+sOq9BZAOSHqC9Ld
	P+tvVKdJfuCNvpH3x7u238ualYoIgvoOJIg==
X-ME-Sender: <xms:BqW6augqTDVpAWFxK_mqAca1tQ8j0Ghse1osctCvroIqYXChRM4ThA>
    <xme:BqW6amesrI8bpOL_Tl3TuZwQyRH8W0nsAcC3GgQ5A29hOWpCGXVBLUYwZnqvJg3wD
    WI1Fe4xMOPFazX-_hPb8PWFUiGzFU06pFHf8WCFnxFggwBftvgj-0U>
X-ME-Received: <xmr:BqW6ajf628Qz8V15J8a_uS1sGD8XTzinYpkcBXnM1twtQzMlYZIn6wKZOM6-VQAY0KaXdLA>
X-ME-Proxy-Cause: dmFkZTFfknwNKbA4N0Ac1scNpqRjuK28JPNjWTbRrDicigegApN0ZrVW89Pm1Y9pCss2d9
    IaM1eFqwI494X0qhtkpT+VPCFpMAUix2aDmaD6wpw4vlPHOtABxOwDTX6WlNEciK9iWWZI
    NkdO6Zo53xvIJ0NvCwd4Gs8gg0gOlrxLEuFeGGXT6VzpvVJSFc8iofm4nfZfxKBzdFE2V2
    W7Eyf1PA18I2Bw8PvVWAPHLPB3d2y8d0sxB6qlYQlKvQxGM0+6VoCUZfiMiL7M3iw/LPx3
    pOsBJN7s6tpnnaen3CGEwL9ugrt9FztM7vgYwM/jW/RQRHBmIV/59yS5s+b+8iPMjTX6CI
    NWVuRqxR3Fjn8vJXm3VvvILCgX8THAgoqM+G9aIEWSK3krcX8PXF0+mZ4oyvxtd2oXyBOL
    SGgl7BpBv7Se9bi8E6/OPbQkdua4zXlk+NyB2jddqeqoXYJyz757c2QHt3YlZE8v0jLzfl
    cUby2ocD6rx9tsFvhsn+pgPv1dPA+yLdGAjnRQPLlcm6QnUdfwTjQf24C8vmFZbp2xB8ta
    y71E9m7gk8uG0fyo7etA01uOv9a1qidKexJUE8D9xCrxkOGHR0d/usaqM8OjALj6M3cAT1
    T+QotDAoMxYq+IQz6rj+W8mOKLSDTLpIqKgfK0IU2U/vE4FCoSKJ1HrDRmmg
X-ME-Proxy: <xmx:BqW6ag939blSgc38QkNk4voLiazPqIVaNi9tvpZv-2knVbIb15qQ8A>
    <xmx:BqW6avmmsORGBtpzcMFN3fBR8cVMOHB1i01DZsh5i2YqcjuvZVmHVQ>
    <xmx:BqW6ai9PWPu9086TJDfkPYQeLpfrL0E1TDXvAA5RsTDVM74KCmoJ9Q>
    <xmx:BqW6atn65IpomTe1hZEdLqtsoH-uD4wbr8y0lKG484T5lG47_-C-Xg>
    <xmx:BqW6amc9AB29eDm5k3XS9Xlgi8lT-qPRH41WIUPhYI67Uh6WlkOTlSXR>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 13:33:57 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Mon, 28 Sep 2026 13:33:13 -0400
Message-ID: <20260928173324.1837653-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A peer can send configuration messages while an
incoming channel is in BT_CONNECT2, before the
security or deferred accept gate has completed. A
configuration response can then promote the channel
to BT_CONNECTED. Configuration responses can also
act on channels that are closing, and a late connection
response can move a disconnecting channel back to
BT_CONFIG.

Accept connection responses only while waiting in
BT_CONNECT. Answer configuration requests in
BT_CONNECT2, but defer our own request until
BT_CONFIG so configuration cannot complete before
the gate. Ignore configuration responses outside
BT_CONFIG and BT_CONNECTED, and only complete
configuration in BT_CONFIG.

Assisted-By: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aaa2a1cd489a..d3450a90b4d2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4284,6 +4284,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4313,6 +4317,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4445,7 +4450,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
+	/* A channel in BT_CONNECT2 has not passed security or userspace
+	 * accept yet. Answer the peer's request, but hold our own until
+	 * the channel reaches BT_CONFIG: the CONNECT2 -> CONFIG sites send
+	 * it. Connected channels may also need to reconfigure.
+	 */
+	if ((chan->state == BT_CONFIG || chan->state == BT_CONNECTED) &&
+	    !test_and_set_bit(CONF_REQ_SENT, &chan->conf_state)) {
 		u8 buf[64];
 		l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
 			       l2cap_build_conf_req(chan, buf, sizeof(buf)), buf);
@@ -4493,6 +4504,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (!chan)
 		return 0;
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
-- 
2.55.0

