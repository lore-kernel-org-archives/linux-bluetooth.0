Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E884B1263
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471589; cv=none; b=ab8AORiBQ7i+3dGTACXelg8ByBgqgYXwbaPh9e/z/b1h79qirTwWh6iWd9mgT93tHpJtAGQD9nypCvULggrrKgqNLRjBE4sFgxPBWvSDNyrHxRgYe418Zlmqb1j+ElqWdTumRlikSf/vbKeu3ItvJGo1vPYkfZEsal6GnZnXmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471589; c=relaxed/simple;
	bh=691LCtUyL3GXwNR/gmCgGQJxAsD5Uv7uNIcwfbw1r2c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qYyUnCltQrIn7lAxk+ak51gxnD9k6jhS2Z+2UjVbm8zQSbPoq5amoIm78HyNKs8Lu7bWjDJTURIivvR61gmmhQ3u1BUa0iMxhMkujY1eCJG/pLoOmTJJ/ZoUFdR8t9dppr2gqL5dxpQqUovILyeohAdDIBHwv37DsnE5LyfbRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=gihFbktZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyDgKcJx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="gihFbktZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyDgKcJx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7865E7A00A4
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 10:59:37 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 10:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791471577;
	 x=1791557977; bh=iD4iQYIpjK456QzWrqNCJoD+GzURFQa3UfuIjjAM1N0=; b=
	gihFbktZ7kXT7v5fqtkg0BbgkWZ/IjhKFS0ZQo2Ua6QmD/lMncpz6pe70Qvq5kRC
	h4IGn5ILWaBeNZRDYQXmUiXjqTF5OB68sqgnoq4Tut23X02bl8tvEzNHWPcYrA45
	AlunoRVy3Exp4neAnUC1RU49LsXnB00+anPbTJnMiRo/wbcy19pyd8AflCSkR8I+
	O1Tx6HJC7N7/XKtKLtlnbS/MY4zQYpV91PthTgW1whPCXZLA7TU4AGmtIUoDW9H2
	Ns9tDwMHDVi9U1gLIFw6Y2JeJ5Iq/Iq9hxerO79oS16T9mpzkGcWunk+WvA7rT8j
	yn+NnfvouREeDMzFoDC8qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791471577; x=
	1791557977; bh=iD4iQYIpjK456QzWrqNCJoD+GzURFQa3UfuIjjAM1N0=; b=H
	yDgKcJxhqPZWsRAs+z/c40rukKifXeH5aGyL3cA9wV0gDsmpAWFcOmjqF8nt0Z1b
	JvkX9JmRejgAkj5t3EkGAkGi/TRRiMaB1osKHo02I+5GAj6MQXiml0k4hbctbtSS
	RP86QhPbP+/TbQcjo5I5t4D5aHbmTSXEyWSwtqr1RbN7Vlbbq4bS3H4Qis1cKNkF
	JUc/L7fHupmJ/Pn2sZ7H1dIDlYx80V6apwXFEkGIErKS/rlAUQFpseM7p4nOqIkb
	nU4GUJDj2L+olnG8otDkLzCZdP6DLcBHZp2+DUVg2jWRAT+3xdkGcR+0ja6VlG+X
	UKtTa+Y3vqhGBIlCAMecg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791471577; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:OhrS7Vbe1CVYHL4FdmpixNKS6k/HHpTeAxx1I0x5SYsRdBy
	lOdQPYyq/7cHecMiy/IvhNXD+LqJNFX1Om8tJw3kyLb/kch0vUfCD9egIkG0hknW
	LfYTM1IFICcB7cBhNW2ptXs1xGlTOL/IvtCWuEl7EUxl4NYPi5b3D7V/lKMmJ1kE
	z6fvlHi4/+KiGyqF4F2UVI/yPDtkUTCHkUIPLDfpyTdUQuRs8AjDsELN+a3RR9/m
	TtXPY/uBAP/2l0ckt3AewhLIwPiN3NkOAYi4RwsIVtIrD7W3AtwTmqT3vlmCmr6i
	f8kvY+epyKza9IFn/txt/QViuuvW7pAhyKs0vog==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6NGXO07lHjfpsgLw6v+pqTcx8FolFf+OVgwXaUdezso=:691LCtUyL3GXwNR/gmCgGQJxAsD5Uv7uNIcwfbw1r2c=;
X-ME-Sender: <xms:2a_HalvA3741immHPa1R0X4-SUpe2mawNr96JWEjI5ZH7MVUP_my9A>
    <xme:2a_HapR8iWVgIue1Eko0yQG4MwMR1VV0XIuCp_eh-S8X7rE4HKZaUQKCn0EIkol9Y
    wrnJ4hcydv7IKGM48ZW9i8PkEK91yLh7IqSZ6zaLjIoOBiPrrXnEOCq>
X-ME-Proxy-Cause: dmFkZTGxlGqIGqjQZDF+DGaEx7AcIc8eaXLSmD8prdtTpJmFKiKH01Sn9A96QZZ/vVeTHv
    /9LZrLNi6LUahUrd1239by7lb4ZG6sIqyM6ForauTkpoydqbEY83/1RIwHMssghmfVAIoD
    uJ7KHOTenbtWmq6Tdb8CxStkih/khdLpC1Mayl7gNtMogd2HFPvva1qd2WX+fek7ngMAU+
    g0N9/6nH59l98jwhqWQ4/zF1Z4HmPWmgqgRfthDuqnFGhpDmVofs7pqb8ZJu9HYIVpLIDM
    m6PA55wFSusWAmO3PabzgwgMB66DKRRQwm8WRFNe0dW2qkW2w1r40FLDeQnRZ0BAOdTIFK
    mim89XJtcj+B57Kt6ed5TjIbYj3dseIldkKo/u92GgwcTGmVDdd1VORXSCM4i4DIk4+MV3
    yBxCS04deSRw2janQG84DDeAPQG5qYmyrNmInoqtj/ajvmDDFPF8n94QinQOqrjScC9GdF
    ATB47rBm1zCEwFHcZDw5mBd+XG1UA4vi0GpcN2soCYGdhGYwSA3rNZlphHM0Er+hNM3koW
    qWbZKX2B2YFzPkIT2xvizrvNierruZ3DuilDFMUbSz3NekFYmxgXYQOCWQ3C15Le8U2t4x
    tp08aHeDIO2N4i/gD4OpiaGPXEb31Y5xsXcHsr5H3z7cvaDCBzxPPszyY+Jw
X-ME-Proxy: <xmx:2a_Hakb01np1dh0TSJ-VrYvPMBdaPkXTwRKOiCVB_r59UKAFpCEH2g>
    <xmx:2a_HatUuX3n1QyvKFRMs75FNdCCI5H5wvgVhaDy77wpqQ8Mefvv5LA>
    <xmx:2a_HamjMvP0U5EI6Mevvt0HEW5S6MpCaDAeSguelPPV89ce1EYoInA>
    <xmx:2a_HarVjgOYp1TECanfTBQiC2YI10tnUCJskY20PntFG2hpeFDzPpg>
    <xmx:2a_Haue56lD5wZ97t7S_8CP5kFEorSKvYbuvXcSQBcjzFQ31EsFzItv->
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0950B216008A; Thu,  8 Oct 2026 10:59:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnpTCWrVsRqZ
Date: Thu, 08 Oct 2026 10:59:14 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <ba9cb837-7083-492a-b34e-eebbbebe81d2@app.fastmail.com>
In-Reply-To: <20261008141714.95709-1-oss@fourdim.xyz>
References: <20261008141714.95709-1-oss@fourdim.xyz>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Reject mode changes on connected channels
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Oct 8, 2026, at 10:17 AM, Siwei Zhang wrote:
> Allowing mode changes on already-connected channel will
> skip necessary initialization on the new mode, resulting
> NULL ptr dereference.
>
> Cc: stable@vger.kernel.org
> Closes: 
> https://sashiko.dev/#/patchset/20261007144717.3832330-1-oss%40fourdim.xyz
> Fixes: f2fcfcd67025 ("Bluetooth: Add configuration support for ERTM and 
> Streaming mode")
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
> Please apply 
> https://lore.kernel.org/linux-bluetooth/20261007144717.3832330-1-oss@fourdim.xyz/
> as well, thank you.

Hi all,

Please don't apply it for now.

There will be some more commits to add and be turning into a patch
series. This will be the first commit.

Thank you.

Best,
Siwei

>
>  net/bluetooth/l2cap_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index cb4ec42f99e3..2cb3f59112f5 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3876,7 +3876,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan 
> *chan, void *rsp, int len,
>  		}
>  	}
> 
> -	if (chan->mode == L2CAP_MODE_BASIC && chan->mode != rfc.mode)
> +	if ((chan->mode == L2CAP_MODE_BASIC || chan->state == BT_CONNECTED) &&
> +	    chan->mode != rfc.mode)
>  		return -ECONNREFUSED;
> 
>  	chan->mode = rfc.mode;
> -- 
> 2.55.0
