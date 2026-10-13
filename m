Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599D53ED1D
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905877; cv=none; b=hpWTfnbGdAChk/YT6dlbgPHNlsFJRPZMngHJyVRJmKisAeT1ByoM+OegOH98es0HRii80RYve0rn+hugnDr6SY2TwMRehtX8FewW8RNTgQXb8eZGhqbT1cpXNn65Ax8UiwOZsmI1ve6li4dV+nIuZ1i2cWznk4AcDlCR/H2aBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905877; c=relaxed/simple;
	bh=UNqDSIC+EHSXdHKY1foFwB5mKJJON9KqjLmBDQw6nek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ45O+72a+C4qOMsVFe7d3bnkCBtEJDsVBfYNPqrQqoQsbDVlFCaXb6q0/f/9SxJoGe3kbd8q8io+o9yH5+vZfCqkhg0p+zWTwltUXHsX3uxn4Oo5HrZHD9PPqaTnWNS5t1IzUQR+jvj4YpqHAtbWsyXjzMsL60H8KXPIZC+OV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=oeBRC8ig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ANBBchgC; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="oeBRC8ig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ANBBchgC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 918587A00DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:37:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 13 Oct 2026 11:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791905875; x=
	1791992275; bh=KTpVCjrPdcj8Im9x3GrZb7EspYjvNHroeVUqcGkQNQ0=; b=o
	eBRC8igVjaM8bRv7AS56Doe5Vc74MHsX3RNOtDnvfnH3s1L5js15yDsEDwfLiXke
	lKbzGOa3QXiDCsOx7lHY1Iigz4QUnwfDHASJczUNdE28slJbXP2+7p8gQ7eKUzoH
	vl1vkT44/3qUjRQO7r3Hc2lI+zEvwzt7OSLwW/kjoyCk0JhiaT5R+YoK2SIuGRME
	AYnq17p1mnTn8hJaSvLhIJRTsJdZFM+H9vqKyM6jKy8TVM/pq7z9+OMdPpGkMyXz
	PRzPKrmZWh+BcreyB6Yp3pvm7kt+Y+yU9n5qs328N+CREpqrD3QJwKOtda3FMPiG
	iCs/XsuaQR70XE1nf8VrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791905875; x=1791992275; bh=K
	TpVCjrPdcj8Im9x3GrZb7EspYjvNHroeVUqcGkQNQ0=; b=ANBBchgCCjeHBZwlL
	F8TkRYa92Wzmb6n4iYLUmrMkJ7kr8sjL30WV4EmuaUArMnZi1g1HfYlpO8PItVdA
	v/RqyBxXXAsIrznKcrFJNvm9dP8GqpmO4WYbQEf5XYHC6uux3+qmr093A/80UXBr
	h4qQz7XDD7mbli/EfcDl5XuiZ2s+/0fn852sF17EY3f0P/L5P8PGAVBmXHPQxQXV
	APexe0PWeomE8XxOzWxt/cKtz0FNjTtwx98r4tlEHF27yWR6yBAT+apCHmstVMfv
	xkzuozWIERXbtmsaTj/nYGQCu7vsoX8T+ApUhw+Cd4/xBEVmGw68Gb0jfyVgCIw/
	sgtzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791905875; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cwrHPEbFIPMFtifZ8vedg8Btcxzu8mSTfeQNQlEhy3AG5lL
	YafUJxtkGYBNR0oGjGDD5LvSEg7xjwB15p3wXMPndEZGClLdEup1hCQjQ7b+rMQc
	Dfj4L2kLuGLmz+0o3HqZLq89MSGU9YqQSALbHuS8+Yjp2V/ydl5+sEOzQKyeCkdN
	UV3R0LrR91C90FUSin/RY2FHx2No/StOtZ5TtTMEvMz6CZsRJXuxkIUZ5x5UPQd7
	g/AYvMwAXS0sVfAyDk16Pgp+RhpcW47278ifktlZcDFMvd27FiB3GWiHKPw5wkbq
	S++zoAo+C+7Dl2K4DyrEWSuPSv0XKoT5BRRjhbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8sZlz3tYrBQZjjjEnXfVYjbqkh/OHMisa1zX8Rwv0i0=:UNqDSIC+EHSXdHKY1foFwB5mKJJON9KqjLmBDQw6nek=;
X-ME-Sender: <xms:U1DOamt63OuJp4SgUw7-ICjOmkL8V39v2UBexDaORIdWK65EoOCKOg>
    <xme:U1DOai45Utn9HCP04pSne0sBfJtpgn3cw3s4qA0UMSSYVEMYwtSgOxYhqr1DOf5wW
    Jh842o0mhIYTmu2JvTVY2_S7Oc8RFkewhd2Gc8TGm1RlUtub6EyPEjd>
X-ME-Received: <xmr:U1DOavK0Rzajt6mJJmplt-DJzeHaesQ9dR-NyFRj4a174S5jbr0ZpbUS4xz3VTSHLW422Hc>
X-ME-Proxy-Cause: dmFkZTEsgceEzUMqrTt/TfG71ooPUHGAMU5hx6IRZmnBcgAMkI4qBGlTCJxlarmUADpcmf
    Wx2OGRaDVDDn3LA7kPOYrbHrl8PXZek8eg4Nvdw/ZH6whKNfD6k6EgaqJsBntCmXeRbnM6
    cHtEWw3CUG6gMoNINcCLRqRWisEtCg8kWhCZdoSyxIjssH+usRgQrBR4ug2SKN7l/4p3Nl
    qWZhDkoDm6LnkVGhgYoNwtsNflytC+U5ykv+ScM/po7AzKtKG3blWbCsxCkGG8oCnx7FFx
    1yXBuG9iAb3/GEl5AjutiwE1DTMGkKBTKjBBAqZv+rKkzBiOBX+sGVMVBN4ykDERrJ/4Ix
    NSibvnTR36js5UV+gCifinnLL1qz+yapNWhDBlStoc8I5bFlX0Egqj6SP8+1NQRgPCFV5F
    OA/i3ENbRQx4DUgcsjtdftzNg1YCvtHR2wWXQA/1c/+jnovfnlcWUSHqMTlFcQiqnsmQC/
    DAU0VXOKRpJdW1mYIhOuyApaZGvXhQ+sJ0wTjc+VnCjk0SFceCkKI6XAO6qSITnw7BhSbf
    Be1jzBh7oe2psxAFU0nSD8gu8e1E09MTY35WkALDCFwKdAkd92i30AutDQrbyEh4QQsaG9
    HJa6G4Bhanx5OocFAFu1K7AIvar5c0QQ8MgFmbElDPujZXC+cjwvw7BkOHDA
X-ME-Proxy: <xmx:U1DOaq76-xzIoUbAqytIzVzmpBC_pDjJQ68vm_vYOgyvS_Mda-YOqg>
    <xmx:U1DOaqyLSyFyE-xbEj65Uj8Ak9aLgBhk2Ef1YMF_xSpMQ4TL4Xox5Q>
    <xmx:U1DOamaByAFTOUJ1YiY0-Y4-ZAz25gJu56N7tkMoBS2WgKc3Jh8BGA>
    <xmx:U1DOakTGexK2DdAWU-UqMRt2PtQJkM9DcEzIDShsMVGbYnfBGB82yg>
    <xmx:U1DOau7oIyEBViA1icPcgUoq8lYHWzqPQ6yr7fOtGfemItdO6gye0N5I>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 11:37:54 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v4 5/6] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Tue, 13 Oct 2026 11:36:37 -0400
Message-ID: <20261013153720.2635387-5-oss@fourdim.xyz>
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

An outgoing channel waits in BT_CONNECT until security
and the feature mask exchange complete, and only then
sends its connection request. A peer can answer it
before that with a connection response matching our
source CID. The channel then moves to BT_CONFIG,
completes configuration and becomes connected before
security has completed. If security then fails,
l2cap_security_cfm() leaves the connected channel
alone, so it stays up on a link that did not reach
the required security level.

A connection response with a zero source CID is
matched by identifier. Another channel can hold the
same identifier for a response it still has to send,
so the lookup can pick the wrong channel.

Only accept a connection response while our request
is outstanding, and only look at such channels when
matching by identifier.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7ea13c0fad44..210d1507af7e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -157,6 +157,29 @@ static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn,
 	return NULL;
 }
 
+/* Our connection request has been sent and is still outstanding */
+static bool l2cap_chan_connect_pending(struct l2cap_chan *chan)
+{
+	return chan->state == BT_CONNECT &&
+	       test_bit(CONF_CONNECT_PEND, &chan->conf_state);
+}
+
+/* Other channels may hold the same ident for a response they still have
+ * to send, so only look at channels waiting for a connection response.
+ */
+static struct l2cap_chan *__l2cap_get_connect_chan_by_ident(struct l2cap_conn *conn,
+							    u8 ident)
+	__must_hold(&conn->lock)
+{
+	struct l2cap_chan *c;
+
+	list_for_each_entry(c, &conn->chan_l, list) {
+		if (c->ident == ident && l2cap_chan_connect_pending(c))
+			return c;
+	}
+	return NULL;
+}
+
 static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src,
 						      u8 src_type)
 	__must_hold_shared(&chan_list_lock)
@@ -4446,7 +4469,7 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 		if (!chan)
 			return -EBADSLT;
 	} else {
-		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_connect_chan_by_ident(conn, cmd->ident);
 		if (!chan)
 			return -EBADSLT;
 	}
@@ -4461,8 +4484,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	lockdep_assert_held(&chan->conn->lock);
 
-	/* Ignore a late response after the channel has left BT_CONNECT. */
-	if (chan->state != BT_CONNECT)
+	/* Only accept a response to a connection request we sent and that
+	 * is still outstanding. A channel waiting in BT_CONNECT for security
+	 * or the feature mask has not sent one yet.
+	 */
+	if (!l2cap_chan_connect_pending(chan))
 		goto done;
 
 	switch (result) {
-- 
2.55.0

