Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77E53D9E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905876; cv=none; b=EpkKYR6B7c91ZbqDA9L3uFlm140Fp1rViGKz8GXFWDtb9Bsn96zv0fYxP0kgRe873ytoiUqIODjU69x3uMV5S3BgJgT9wc7A7UCxhJcdV2Z0UhWbeHpdxUu21y+lpFt3oR734qTx5TE3MPb2FiVp3CaXALn87xivyD3eVygRW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905876; c=relaxed/simple;
	bh=iMuPW6O+NIXubotusk8Oug6g5/q7rbFsKmWZhRP2avw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZIFAg0D6bGstUnaCeij3bxuLz084HySAiFbCCh5+opPKkO9uNGyTN0kP9izyg04GmDI4ApYPtLKNnhn03qTrh4ddWshnJw43pMpaiqGn8DrrdP7LxdIup3dO7HqIVW8riSHWm98018TMUZted8YCeBhqd9Kw0H3N/Iuq+ZUPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=qz8OtPc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cto0//65; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="qz8OtPc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cto0//65"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 54B5E1D000CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:37:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 11:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791905874; x=
	1791992274; bh=+X4QniGjfMq4Jw111C8mvSuVf+UTjYPp+AEnff/ueR0=; b=q
	z8OtPc6LypParAi3c4rHFFALFes73aqp4VN6uZxwf1yJRAOJk/pH3UX0emdxsP0U
	/DGn+HRYGTcZZ3ZUpD0T3ZfQo++rNXgq1AIVLOlM09IOI+NqoFqZ3c6PbapfV6WZ
	tMP+Azctu8t+jPDe5J1tL+YFumERbd2nWChj49J7gxmOnqqLLaCE9l+7ka9/gkps
	0VbeZ6AAW7H4DTTVFQQDSnKnkPInF9bZSdETlEp6zSOB4Rb2P6BI2zT5JefSfcYN
	wZlIFkwfuPXJ9vdPmfv6aRF89KyhBpdK7imTk8e1W7bM4EZP/75bOeDAliKs5ViG
	FwsHo8IQDsaNJOPy+75kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791905874; x=1791992274; bh=+
	X4QniGjfMq4Jw111C8mvSuVf+UTjYPp+AEnff/ueR0=; b=cto0//65KGNEAQjAa
	EfHEjHRoVTH30vxctHvpZLwtjlUUrQQEFyWzVUGTgfS6AgtPE6EnBSOXCTEuI4jO
	zvhxUaghI4erMcwJsHhBC6YcgNXuGzf7EgeofW/zhuTjJR/IjVf8T7ZkFQUpErLK
	9WHrOymI9k1YNPwQ3wK+I6wNnMS1NL3Hcscy2CvY0jaVKBjBXOCZwp2fTXB3Uily
	L2OVXJ1JMMsflHQvlfekcKuaCP76JVbGFh8xaGfuKRep0o9sEEN3exFPZSBTBIrG
	KA5rqRsQ059ShVveKV9/KGqxtgrzLu2Qb5gDUWb/dgBt4k4NJcN5+Ogi8Xnho1kQ
	QhnHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791905874; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:e1YcS70w0IwQTZC5Qn0Sd+Ql26iCeGBkgb/U8345GYvFkQt
	+kI6cowEZ7RQ3+e6MDAFuIwBps9uw73RIAwY4+pKpv4NCYQNrFfwjDmPqB33gEP2
	oYoS1cByAjqTKGbLzRltm5ItdM7ov4PLVjBEUUsaaAQbD4nowmBpkP94TZZ1ZCqH
	Is4i67GkqzkBXsnSHXI68qp49kOcWwitq//AhDeeNjfLTCpNf4SIVey+MDuBqd21
	WltvhnooOEtZ77WZiNLPZNyMERTSta0W57Z6rm4DmCdEPUtNeZfc4tk+Gah2WPCb
	YO5yxUh4FNI2ioktHCFvnXKEIwRx29u0fyHrZYA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0KwmCwAvS/KZbCJMHZV2+zDISSZh0He1epmw+/kZFoY=:iMuPW6O+NIXubotusk8Oug6g5/q7rbFsKmWZhRP2avw=;
X-ME-Sender: <xms:UVDOavsb2a6tcRy8G_W4ie0MqOD9ubcWOI8lY7uJ7eH7GAEyXBnEWQ>
    <xme:UVDOan5jyqg9e7KLogwrwhccpQ_o6eAPGPsHos-EPb5cRehE4AbUyqCZQj-BNROag
    K893ktKR3Z_Mp_uRfjucbh4LPwVH7WlL82ioJITFzX1RAyZev8ieQ-O>
X-ME-Received: <xmr:UVDOagKZNeSP--3sUeL7rPxkVrgryPBUP0hglPx9LPaBwV4frMa5j4WmZaTFs1Gz1wbzzQc>
X-ME-Proxy-Cause: dmFkZTF7QXxcE+FbS9lGzBNJthlp2fAAjiFd+yLjPLgMroSiIsWTg1Luy5K6KmTUzlC8qs
    CYYypQn/SFSuOyHrlWxAMDSUiWOpcYiVbzhoDHswrgzk3rtxWPBdaGP7SiFziEpZLWj7QE
    NuZwoT1m999jflapv/Q3GW6dcXyXssTUAroRcB4i/d929yfb5LZ8xaooCwT731s4XYn5rS
    izBOTwI5GvTu1G2LAuWDJTCIaEwek+Pl9XXQILGMYsqlu/h7g1OyD4WBUCTOr04sJWUSwE
    ZX2qCwEn8WDInJ7R11GmM7PGcdzfsZ1eEyjuulWmQsOCUyRThrLhPG25/9vv25XAAmewKv
    VXDj0gOQUf7CqrhI1aWziW+Wb+NYxuyXL54LIcjEExngJJ7GzUunUaAd5NDKUzZdag4WDD
    kxcJ70e93MeRrxjtTj6AV0DVPP/j5Qefmb4TLWZsguEhHhejmi0pcbhOqRqzFhkiRUyznj
    LsXfNdPg6/cN/dNIZX4VuIUDB4qT1LGoF8SXw6LtuvIqZIe7Z7psU8gD+WwKvS0wRLT/P1
    Y9xuMFq7mZKlGawd5LplbSaFZykacIKIlqsi1A47L1U9+MW7KKL7KiUcRK6prQupgIOFw0
    dM5OC/QrhFGs7Q/0sJC5NYqoZKq6GlXndgypuRI8SCWQdmX2kJI3Z8Unryxw
X-ME-Proxy: <xmx:UVDOan517AQPpzqhj3dMUQYBj8Y9R9Lz9db8ROvzOZUBSN08c0FFuw>
    <xmx:UVDOajy2xoh9Dj653nWuOahtjdW-XBhm8gpI3NddHs0iESyFCWh5QQ>
    <xmx:UVDOarYAN9ZlV88FNQpf-9AmvR1Hf26xVn_o6kcuwHObFjT6wbnirQ>
    <xmx:UVDOalTbqYkoJ7kVMmzRySS5GuQIsqUihjlPz-otBst5718T5zKARg>
    <xmx:UlDOaj4XSqzGSjWimz4RNPUVGVbZAg00TLbRGE5rq_vQr5pxRINX62iR>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 11:37:53 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v4 4/6] Bluetooth: L2CAP: Use default TxWindow for zero socket option
Date: Tue, 13 Oct 2026 11:36:36 -0400
Message-ID: <20261013153720.2635387-4-oss@fourdim.xyz>
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

L2CAP_OPTIONS accepts a txwin_size of zero and
stores it in tx_win. The zero is then sent to the
peer in our configuration request, and if the
channel ends up in ERTM mode it is passed to
l2cap_seq_list_init().

Use the default TxWindow instead, as the mode can
still be changed to ERTM during configuration.

Fixes: 14b5aa71ec50 ("Bluetooth: Add sockopt configuration for txWindow on L2CAP")
Cc: stable@vger.kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_sock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c92f31b997dd..47b0f8886fd1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -815,6 +815,10 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		/* A zero TxWindow is invalid, use the default instead */
+		if (!opts.txwin_size)
+			opts.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
+
 		if (!l2cap_valid_mtu(chan, opts.imtu)) {
 			err = -EINVAL;
 			break;
-- 
2.55.0

