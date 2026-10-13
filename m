Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061153ECE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905875; cv=none; b=f1SM370yh7nu5cnXCNNSob47XXo+oyRiom3CTUr7Lee2KtWy5c/1haNYlVB32Z4A1pvjn/KYLsMkbrnudsqC2ug+eLMg3Il7NkrTNqsc6sA8kEbqjLnWfBB1/yusxQtxiBR0oApVo2SP1LJC6aI+sE8wMl74Q7g0ElNiOqepF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905875; c=relaxed/simple;
	bh=LqcXlLTdMIK+zR157x3oqXso1Y/gQic5/ClD+CKG0oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lW8ezN637BxjI6/DwzckV+BJ3IVK23JC0lzAIWRRdIsmfJU0pMlTo/W7LpoaIa/9TPII1R9+aMp28ks89gsZuP+B+yWY4eLlcYK+R8wY2c1tNAfLNbr6PYd05AqHIGfOFJ7D2cVQpGaMjtryME8cp2AhqdjsMvXlRuQiG14EBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=H7TWD1Rr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5c/5XMR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="H7TWD1Rr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5c/5XMR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 998671D000C6
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:37:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 13 Oct 2026 11:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791905872; x=
	1791992272; bh=LfGzWSgLooSaGKObZK4570QsGXoCIy2O9d9wcwIDu6Q=; b=H
	7TWD1Rr+saLPALK5Kw9DkRpYPNamSXOzcinjivbAeqpDoG/in2ftQHZeanUnSY+m
	EkBOs0/m8FhP03jN4f3Nin9u9i3W9xTiqbv262F6ub3A3WEBWQey9K7xI5c8wo81
	g00ERJckEhle4m5VYXfRZijvWS5P9q0Gmz1GT4rs3PZfIy5PCW/MrbrLhSkMYHJz
	m2mqZD1IjUrznr26Pn+SIAavWJiBBKRAGtlP0ieiqkZPw4bCoJnX3oW4mOlwOEHP
	Cwco5cF2GSS2/essyIfM7cLwhZfSlCUJOZAXhyDGEyrkq2/BGNf+vkTGugBtZf2I
	QSzY76yUtFQOgXCOCdLbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791905872; x=1791992272; bh=L
	fGzWSgLooSaGKObZK4570QsGXoCIy2O9d9wcwIDu6Q=; b=W5c/5XMRsgbo/n+Nq
	PL/1ZfFr/gyv7jq1vSC0jzDBJ1cxQYycvy+uTUYZQ8zNlUEM7oT/cNYAYAEfqNXu
	HtJxv53tqgCxfJSfcz5/mUMexoeGSraZEdVMffxIuSmHl2/zjbvrsKHMTjep5eP9
	c417ke9dVeax/46ZQScydiMIAK9mLujXg7B+ynFLMKA26Zw4Z83hMPuy+YSVcc3D
	tEMjkLmzRWPeH+KO18Raf3wPDA8434VPQW2KEU5Dy0ssoX04eisnJt17r1KkjkEp
	kVe/LNGiX+gWIJeUSbcQZ832Md6pfwt8lKE7kN+iansd2Gd0WGS4vO5gvgZh3GlG
	2iB0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791905872; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UeVydmm2cSqCc12xeDc/EGZNTSU4O9tFuQc8d+4rnEfF6Rz
	2PHOKY4g2hKsJXNJx3TapkP8318N+ZaVqQGhlo27pZGHMc7bmf9Zaeg9d9f3qhPO
	CL/MctuwLDc7it0bkNHuCpi44OZQ75LBCmu8xOMWlv3MCNtfHTlGvz/sgO0ze0C1
	y7jv6mKH+AT5QTci5f/3sl1H9muFOVTz4HeE7BgOBYAdlA1yK8b5WjR2SuX6p5W8
	mrMmPufYYJ4IBEZQ69egNhT88CYyeePazvzdfjhygYLx80ZCk3xCITTB6J/AJ1Qy
	JMQVzr9SUh5qoLbZd5ZCluMM9AxLWFGUmveVKWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RkSoMx4ZbS+E+7o//50H4KVKbtl8A4v2mgat7qMbaVY=:LqcXlLTdMIK+zR157x3oqXso1Y/gQic5/ClD+CKG0oQ=;
X-ME-Sender: <xms:UFDOaqWi-OEHNraWzd7Qbx5zt9C3xaoJKCl5qG7Nn41bU_n0nuX_fA>
    <xme:UFDOauB161DO_hMqkrhuNW-AeKNfyiwcFK2ohY5r0bjo7Bnr6QXSDCBrxgfZtc8CA
    xqO7lTfwWoqKB3euZw6ROLt6Te6cFiFxzt_uwYc28i2wk6hqUJwMSU>
X-ME-Received: <xmr:UFDOarx4Jh-OgofLs2AMAVKTSGXAd1UquXP-sv27AJxKCEHWhreIuWppGTwtcv8LHsr-1aw>
X-ME-Proxy-Cause: dmFkZTEdYGWu58Dq3CtXq0oRHYLpY8RJyLiAtcdjzljt1zdPOSe2OYGLal2d2MZPbU7AMv
    2G35OGnDNU3OBscwynvQ6BimHhrynkqd6C9X/1+1RzwKCccswPb/AGu/n/u5VMBeJOmKl1
    NM2nN1hv5Vzbbw81pPFIGkSrLMUqHK/9Sw6qfbfhdbaQgB9XbxF2C0UEURE4nEmT4Je33S
    QMj7/WZMAlYZkfZtNAR1hV6xnzdGq+Fg1Woywh6R8v230mt7DrcRLQAbas4jqt2MqBzGRS
    V4+IQ4KUdpBWI+0YolnqeQgS72PwIeQLHgvMOkHFreoQc2d67fiypL3AbjRg/zsH+XSqN7
    Tdnf+sWgo5bHgFwsXGGcj16narzGnQY62KIYbwvFRJx97Z6F3asuhr+hBBxvUfkpMShK1I
    Yefk/eynR5/WPABZlxtx1YUXfMGqOLf/t7QajLDPdAsmRHzKg/MF+fyMhfB/SFmebS+l3Y
    ej5+LHXqJNhFR4xiNBs3vPQq/WiqXadOc6NC0tR88BtxkLeGWk03GnpBIsP620/uZUfah5
    oC2mV8y2wMod1BbYRGuO02OJ4Fygt9zhKuF39th1OQgt28wjFmd/n6FY8WAIEI2BK5JiaB
    vcoTMiF/w9mKcJ0L933kC4daPwNVTT7abhS1CF4TLRlBQ6epWoxZs37HgMDg
X-ME-Proxy: <xmx:UFDOarDT9BHHpZ4Aj2MWP6kSreNwDREliWU3H1iwgHDxMiXU5r5wUg>
    <xmx:UFDOaoa9D8ww0d2eGNyO3QVCQ4reb0NJTnlVyK9i0FCQ99pWT-yzfQ>
    <xmx:UFDOajiXE_0b_vqiD1p1GYUUO1o1_4Pk-JoKJRZSViPdoF4mpMyxEA>
    <xmx:UFDOaq68psCWTWdli_V3vww9fjqtUdy9R8kEzHdapjaJLky2uMvH8Q>
    <xmx:UFDOakawJk2Z2Hau57SMBlAzBB7W0t011aEmmRaDIZhbLWTphiOauhix>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 11:37:51 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v4 2/6] Bluetooth: L2CAP: Reject signalling responses in invalid states
Date: Tue, 13 Oct 2026 11:36:34 -0400
Message-ID: <20261013153720.2635387-2-oss@fourdim.xyz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013153720.2635387-1-oss@fourdim.xyz>
References: <20261013153720.2635387-1-oss@fourdim.xyz>
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
v4:
  - default l2cap_conf_rfc.mode to chan->mode
v3: https://lore.kernel.org/linux-bluetooth/20261007144717.3832330-1-oss@fourdim.xyz/
  - git lint on comments
v2: https://lore.kernel.org/linux-bluetooth/20260929154219.2366060-1-oss@fourdim.xyz/
  - resolve the patch conflict
v1: https://lore.kernel.org/linux-bluetooth/20260928173324.1837653-1-oss@fourdim.xyz/

 net/bluetooth/l2cap_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c730da87734b..eb55c16760a7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4442,6 +4442,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
+	/* Ignore a late response after the channel has left BT_CONNECT. */
+	if (chan->state != BT_CONNECT)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
@@ -4471,6 +4475,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		break;
 	}
 
+done:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
@@ -4608,7 +4613,13 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
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
@@ -4661,6 +4672,10 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
+	/* Connected channels may also receive reconfiguration responses. */
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECTED)
+		goto done;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -4728,6 +4743,9 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
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

