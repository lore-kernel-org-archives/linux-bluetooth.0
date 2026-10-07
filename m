Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00C4A4848
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384471; cv=none; b=sNZ/ZwBwcFTVqtZLVq8t2CGiJV3+uiFz7u6fSs2LohnfU1YLD8XL+U+JBfCV19LAT0mmXi8zOlZCB9KzcRVbRv2gabqTfNs42RPYpWVi93wV3PDLNO9vsdkqTsXbKcM8SpGcUILUVDou05PGllhc/fyi7JoiWTiTRi7OeSN+VlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384471; c=relaxed/simple;
	bh=ZvY72hF5+7StL5VukGljL+W7ih5MrIUpuc3Tp4nv95Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PS9s/wZe4dKWE06ZhCqko+a7RBqbZ83xuNkrVDOvXqbVnnIOgUJZ5BnkEwmcRPFEf5ujb01zcr7NQlwF+T/Ls3crs/ku7dnyryRGGwoJjp5yX9o5yLZHxZhtqcCPMnAfwx3r/rpwUldWfMMaemowhLTppKAUMxhKcovgz8QMrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=a481re3Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nrwR7ouR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="a481re3Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nrwR7ouR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DE56EEC02AF
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 10:47:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 10:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1791384464; x=1791470864; bh=8E3MIFg3KplKFCNpJSZvO
	dopS4OuMNyxVOqY76/UO7c=; b=a481re3Zg5vlA9F67r7v89zcfPNhQ53hXeB3m
	lvcpIu4HbvwEYJ9jY2P1TgmsL3JbXgiXo4ZJXSALHKOPQCn4H76CRx02oWyj7nlb
	NFFyu2SCgqLWiD0nn/WEMORAFmhnT46HQME/gyQ18Vb7jQbyxOpANGfDFDQ2dvhc
	AgYxj4NSgkZiH9pvCZOaCOqXDw9r9dLlGOzR9idGzm1NipWy/yea6FpJ0H6uLqRX
	Uq5FIgD6Fs6BhlLEJGJtpFLb/iVwGjOVhQR0wCfOy+q77qPqYIAj0Un1Zy8dWsls
	NrW/9M1rOaLB6ewWeHRlwn/icRiHOocUKRX2xPjqrGWknr+nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791384464; x=1791470864; bh=8E3MIFg3KplKFCNpJSZvOdopS4OuMNyxVOq
	Y76/UO7c=; b=nrwR7ouR/J288CjUNDOpzCGyQF2InPzL0sHS3w+NBGC+CdgRksw
	hgsCOU37FRMQfhgyOYpNWlcuedwCxymoeONXEcKzvBgypojTRFKwoKDKmvM3ZDAR
	pT8+aCufJ0Zfx4Up0hRn11IanMo7GVyT+JApRmkKLvlk1NHQZxHI1ihyAW5YLtCL
	bOArDQ+umCkyErmTAkqtpopXJYDixWn4L9MlFD2VNNqypHU3MG/9G6b6s1l76lrS
	7ggmaQML6rq1DsJeR7QZVTydkm3HDGgFyU8LozrplA9L6HkQ4/fQft/dbV7y9M1l
	QWrSIbJI4Wb2+FiWWZETTfNzXQRZXyO9yzA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791384464; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:rVhdCBXwgYgs3Uqc0E1p5jGdUmdNQvMzTud7ObJnuot+7om
	h63K5H6Rr9h6eWH2fz4fOC2tQKBVue82Gu4tD9qnISkfRcuGjbScIi1kD/eqp7D+
	6IiyOE6bkt9Mcw0k41fnaLL4fyq025BhgqPLN5HeunX4etNNx+e3sh7VJTHPzCES
	bYNT5FlaOvu6wZErkFI90K/1ABuKS0kdFUIhm6Om0CLmgeeqeqzZklMuDb0s+YYe
	sdPPP/FIgR53cGOy68gGCkuOi5wFI16nyL113yAd5OjHp+tIzowIXtvELkAEq4+Q
	qdJWYqSGU0n2AVg38O1DVoYnnSK+P/oa5lIB8Uw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:qD5EaFYgeI0zCIqfr9ipvtFNSNp0T5k8/D56IBj1eWs=:ZvY72hF5+7StL5VukGljL+W7ih5MrIUpuc3Tp4nv95Y=;
X-ME-Sender: <xms:kFvGaiCJgHpunE4iIZAHBva7IIS0kIQFc467I53olSSTf0xchraqrQ>
    <xme:kFvGaj8aP38ly_rsgslC5q1GyEJfKdiXqOxY2ivw5-RG3g3ekgc9cDbsdz0dcaovD
    IaKGeMM9WVKaLmmDBruPsmIuRycsJrrphJ4xhgifyXoHGfw_134PTlbOA>
X-ME-Received: <xmr:kFvGai_PBOj1eOcBu4a0pyTEv31jIsTSkFbXOfUMHyMWREF1DZQvs63BBv3w6W-UfVWa400>
X-ME-Proxy-Cause: dmFkZTGaLzm6RuLHgYnrxTw+tVFgj1Zlrv3fBg4pdbu/werRw/G4gdGWM6eWcAmQwvwdvt
    skEze1Uqjz7z0UXmME2oybNtJMfhA/mztbdkHrdFifXUB3snGm6+wv+RMCcIsSq+ZI5ZdW
    C9z25cFPuxiEs3Q7DsEi1g/ae8s1tiBBFUBJj2kag3DGF7VPIvKn8oYObc8nf12b70+eOW
    mPRcGRfe1eqIzX3+ewpIxd0vyOp6xZV6U1Cz1uXu6w+j6KHc9YcNCgLzC4KKfp5JdCkZ69
    dEQuAMxw5IXQ2pDFvsyN8jNFQwPR12gPPX/q6/qN89dnP6fwOIRB2gQ88HahEUTxiH8gSa
    I+HsqtwzLqi3Y3aJRYUmujINnBZenC215n8/AgF9/fWeYa4kE+FbFj0TrBCM2WBlH2aPwm
    xtwaq94ojzdmLjloQUvDZ4IuXcih+AUe35YNRVDn04w06CRlMSTM8Va06zDhhTbk61fjRN
    4gp5iAC/uFio9oS542rxn2Kfvq8+j4tduWQDcydNPg2bf0mXmZoCZ/avNd8Wy49xgN31Td
    nnGJz0X+ZHu+svg0yIeBTJrvR6nZJeYUKfuWgsJzh9E7FVQfTNzFVMHsANPLnaZyixK7y1
    tsULIXzx6pdABNVMWXOXXftGAoOM/bLQ7PnpKZuCbw9TobPnytgLXSsiSinA
X-ME-Proxy: <xmx:kFvGaqf0TsZHeHXwO_LLVpyrXzIPf2NefIPJpWfraBrh7wIXMMM2sQ>
    <xmx:kFvGarGwwSXS1L4O16zCZABWWqgb50s4pC9PE7F7Gui2lEK8CDNGIw>
    <xmx:kFvGaofC9IM_ba7UYUyj8S8fnc8wpDLClvyV01ekwy3G9Iv41VCwow>
    <xmx:kFvGalEnQ-rnByVZaLV-AqS7TSh8hKbS10Oiwgmxeupw9JaQ6phy7A>
    <xmx:kFvGaj9p3Y1CSNk1SPMA-n283Nm91-aQJ7nKNQgZAgTiF47t0oMSGHE5>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 10:47:44 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v3] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Wed,  7 Oct 2026 10:47:10 -0400
Message-ID: <20261007144717.3832330-1-oss@fourdim.xyz>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
v3:
  - git lint on comments
v2: https://lore.kernel.org/linux-bluetooth/20260929154219.2366060-1-oss@fourdim.xyz/
  - resolve the patch conflict
v1: https://lore.kernel.org/linux-bluetooth/20260928173324.1837653-1-oss@fourdim.xyz/

 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 49a998804908..cb4ec42f99e3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4438,6 +4438,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4467,6 +4471,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4604,7 +4609,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4657,6 +4668,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4724,6 +4739,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
+		if (chan->state != BT_CONFIG)
+			goto done;
+
 		if (chan->mode == L2CAP_MODE_ERTM ||
 		    chan->mode == L2CAP_MODE_STREAMING)
 			err = l2cap_ertm_init(chan);
-- 
2.55.0

