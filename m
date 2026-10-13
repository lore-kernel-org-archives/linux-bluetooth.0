Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED865221E0
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905875; cv=none; b=pJJsf+c1ZgoA4xm85yIOAnamPCXnXHtlJCKiuJ3sxlfNL+Ith9wNKDr8WBh4fyPIJ/L2yABJ7bgwlLD9iU+nTynem3TIRIYHjBB7RAzjnR5KsYtX1OLPFPAaP5OJI2UsVAzkMt60htUcw4d1aQLADyAIL6u8T37/TpHWRhj+NPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905875; c=relaxed/simple;
	bh=HRCe0Onj3z1X8a1bMKT/7icBadEfU4/+qQqceXBGryw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7TGvZui8erhr2GM72FE38wvjeMMOHkguPXdcUiI+9TH5JWnI0Z2QA/TcXMC3e+m9PlJZMqBV2hNQcCJ9yEN8Rtj5dbs9mG/p7A/jYtlTXDjGj3jv3LthF15SHWN8uK8R4sZizDvNUK2kOpWdLepm1voOwME1m3XGjmWHMYRWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=WAviYklv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rd4PD30E; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="WAviYklv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rd4PD30E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 752051D000EE
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:37:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 11:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791905873; x=
	1791992273; bh=RtUlXB4isX2mG76jIHd8UKRJmZWdVWZHpolc+rP9Qt8=; b=W
	AviYklvKukgnxaiX0CJHb2BZs3onbxFglW2sMTlc6Qzm4Xd0CJFLs8IvpymYOsdx
	fhQY6rAN3oEO7pumCov9Hem3fJxi0GxYAwGHcKUqMxSCExImCe9nWDRxo5VI/clw
	i9QSi+EPS6eBsDKV5cZ3jNsVWfIvRnstDBnIbLH1BRGxxBLQ4T0TAMURTDbc6rgm
	x9rod1k0AXgKtOA1vTNlRYAF/K14tXUGn1TSRIWrEOpZpG7trMmTh2oP+4kpiV0R
	M7GHBGhnMtbpgppHN0rZFIvbkrDQauLnUQTwo7rtr3pcUTUlb+iUxopmmOhBlscA
	G0qmNBSRS1hpU5WQ5EDKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791905873; x=1791992273; bh=R
	tUlXB4isX2mG76jIHd8UKRJmZWdVWZHpolc+rP9Qt8=; b=Rd4PD30EJgJSW7sGv
	XvvMXG8hb+geGyMwJU541KD9gjnwqvA5xZK/xlV9mtq5HtNYhFVewkshhajK3XJs
	z7e94DxWnrg6dX/1eAMf5gnck3KM4nOeOdqhESWqRhv/QpLJGVztqJxoyCeMAxbu
	IPlEvGXEAJTcMm5YHs8xzmCV2iZINSmfOlru1WhhMZzi6wMzlSccLsOQUZ51GLmI
	cnjLlAENqxRX/lGPxKaO5rr7mJMq4pvU4S4pybHRPYaiZimMaVnX5xSTGjeevI5p
	EsPKHKFUq4pu9naTob9+XGhiRE4hWI7MWNpqJj8cRbu5JhHVHEp0Cr1Ombptf+yb
	8H1Xg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791905873; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:dvMMRyuh5Vv1e/iGIwsv3MX59R4O83fUQAqR5xt791hODpA
	5ncQ7Q/XPi5ta99JgiZBm9H8C1nJoqOvNUGF7i6RolhfomNU9vtDFCKAJjlL/iRQ
	if2DzojQizrEThk2gfOzF2Q0pXkuA0xNzbrfKeRqrHf+g+ISYVgTEJFpbXZg08Pe
	7JNuqTxLHKk7K/kGcKdpNy1tMJlSANidiLgU+jmmgzcOCfnzMKj2CMoSi85OUk5o
	W83JqDO+g0v4v6gOvcGuonSr0xUcylRPJxA1oHBdlyQ1sFcYnfJ/aB7GX9kANiDf
	k1YQWMJgO0jrA27cx6XP0sR9SGAVleJyk0tawxA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DDeh/WKkQG1VVD7NgcTWGkWCGUNIfncyEuW3mmTN3Ug=:HRCe0Onj3z1X8a1bMKT/7icBadEfU4/+qQqceXBGryw=;
X-ME-Sender: <xms:UVDOanN8CNDclb2Baoa4nfiJTLsG4yYFr6B7qGOwV8Td0PI08nqcEg>
    <xme:UVDOapZGQlmrsbDbhOXDL1Kyjr-ZxkgNoaj_L25CYQ5sBUWYQtCscj4CEx6jwb0k2
    AziReaeE1ijlZxh-ohxOyoiZUg7LVm2BR1cV3yY9NO0t6_q7sETa5Ch>
X-ME-Received: <xmr:UVDOajraaOeatRofxgbJMZBxYEkxhQmaGCU4XtQY4_B7BkBU2M3646UaNFOpjelWBWTRXg8>
X-ME-Proxy-Cause: dmFkZTEsgceEzUMqrTt/TfG71ooPUHGAMU5hx6IRZmnBcgAMkI4qBGlTCJxlarmUADpcmf
    Wx2OGRaDVDDn3LA7kPOYrbHrl8PXZek8eg4Nvdw/ZH6whKNfD6k6EgaqJsBntCmXeRbnM6
    cHtEWw3CUG6gMoNINcCLRqRWisEtCg8kWhCZdoSyxIjssH+usRgQrBR4ug2SKN7l/4p3Nl
    qWZhDkoDm6LnkVGhgYoNwtsNflytC+U5ykv+ScM/po7AzKtKG3blWbCsxCkGG8oCnx7FFx
    1yXBuG9iAb3/GEl5AjutiwE1DTMGkKBTKjBBAqZv+rKkzBiOBX+sGVMVBN4ykDERrJ/4Kv
    VXDj0gOQUf7CqrhI1aWziW+Wb+NYxuyXL54LIcjEExngJJ7GzUunUaAd5NDKUzZdag4WDD
    kxcJ70e93MeRrxjtTj6AV0DVPP/j5Qefmb4TLWZsguEhHhejmi0pcbhOqRqzFhkiRUyznj
    LsXfNdPg6/cN/dNIZX4VuIUDB4qT1LGoF8SXw6LtuvIqZIe7Z7psU8gD+WwKvS0wRLT/P1
    Y9xuMFq7mZKlGawd5LplbSaFZykacIKIlqsi1A47L1U9+MW7KKL7KiUcRK6prQupgIOFw0
    dM5OC/QrhFGs7Q/0sJC5NYqoZKq6GlXndgypuRI8SCWQdmX2kJI3Z8Unryxw
X-ME-Proxy: <xmx:UVDOalaK9x3Lj6tF3aW51W6NwZSMzKkQiB4njlphFjLcMAa-uMU7vA>
    <xmx:UVDOajSmWK7Nq_fAeP7HeIpbDNE24sWAOQQJKOs5-IgEK-1qrOtgqA>
    <xmx:UVDOak79kju4BsHUQlTIpyhcmK38hoSuJeVVXn08ZFXmHtCQ1MnREA>
    <xmx:UVDOagz45ALnVJnFoTaAHdGZzUYn3Dx25wWzKm5LE0WYxSizDYIb3g>
    <xmx:UVDOalbIO6rAautYS-8AvtuiMhkEXO6hZxHxSlCQ7cFSvbYJzHZ77vLZ>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 11:37:52 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH v4 3/6] Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests
Date: Tue, 13 Oct 2026 11:36:35 -0400
Message-ID: <20261013153720.2635387-3-oss@fourdim.xyz>
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

A peer can send an ERTM RFC option with a TxWindow
of zero, which is out of spec. It is stored in
remote_tx_win unchanged and later passed to
l2cap_seq_list_init(), where roundup_pow_of_two(0)
is undefined. On some architectures this results in
a ZERO_SIZE_PTR list and a remote kernel oops.

A TxWindow above 63 is out of spec as well. With
6-bit sequence numbers we would then send more
unacknowledged frames than the sequence space can
tell apart.

Reply with L2CAP_CONF_UNACCEPT and propose the
default TxWindow instead of accepting the value, so
remote_tx_win always stays within 1 to 63. Keep the
parameters of an earlier request then, and do not
treat the request as done because an earlier one was.

Also refuse a zero size in l2cap_seq_list_init(), so
any other path that reaches it with a zero TxWindow
fails the channel instead of the kernel.

Fixes: f2fcfcd67025 ("Bluetooth: Add configuration support for ERTM and Streaming mode")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_core.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index eb55c16760a7..7ea13c0fad44 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -321,6 +321,10 @@ static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
 {
 	size_t alloc_size, i;
 
+	/* roundup_pow_of_two(0) is undefined */
+	if (!size)
+		return -EINVAL;
+
 	/* Allocated size is a power of 2 to map sequence numbers
 	 * (which may be up to 14 bits) in to a smaller array that is
 	 * sized for the negotiated ERTM transmit windows.
@@ -3723,18 +3727,33 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;
 
 		case L2CAP_MODE_ERTM:
-			if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
-				chan->remote_tx_win = rfc.txwin_size;
-			else
-				rfc.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
-
-			chan->remote_max_tx = rfc.max_transmit;
-
 			size = min_t(u16, le16_to_cpu(rfc.max_pdu_size),
 				     chan->conn->mtu - L2CAP_EXT_HDR_SIZE -
 				     L2CAP_SDULEN_SIZE - L2CAP_FCS_SIZE);
 			rfc.max_pdu_size = cpu_to_le16(size);
-			chan->remote_mps = size;
+
+			/* The TxWindow must be within 1 to 63, otherwise
+			 * propose the default one and keep the parameters of
+			 * an earlier request. This overrides a PENDING result
+			 * from the EFS check above, so the request is no
+			 * longer pending, nor done if an earlier one was.
+			 */
+			if (!rfc.txwin_size ||
+			    rfc.txwin_size > L2CAP_DEFAULT_TX_WINDOW) {
+				result = L2CAP_CONF_UNACCEPT;
+				clear_bit(CONF_LOC_CONF_PEND, &chan->conf_state);
+				clear_bit(CONF_OUTPUT_DONE, &chan->conf_state);
+				rfc.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
+				remote_efs = 0;
+			} else {
+				if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
+					chan->remote_tx_win = rfc.txwin_size;
+				else
+					rfc.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
+
+				chan->remote_max_tx = rfc.max_transmit;
+				chan->remote_mps = size;
+			}
 
 			__l2cap_set_ertm_timeouts(chan, &rfc);
 
-- 
2.55.0

