Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354202;
	b=cbzJeB+DIY/UTwk5dGp/0un3PzrZKC/9EGvWcrbLdQxI6kNflu9dH3Hd3ANJg54C6M6Y
	 DwIhWV9n5P9Pj6S7ItVJPsrSIxXvx8zuELZ4tYBW7+AmKH4HW2uNxlLXAwCQseuj7IIiL
	 VkeN91whrgbbzakHMWTK/SM+fbU2UNCVCn9xw1hNbgJJD6FjZ0OZGkSg1cKIwE2W84l6W
	 PYs+pv3KRLte/s3WIHYT8WbmhjHJQM/3vyIDZOZzevIE/dBFlzaS58gSpoLkpxAgU90H7
	 x+q1nFJLfGJa17vIP4azNjldiK1+yCA8Y3wfGUccC4AwBpd486oB9lwz5pfqsyTl+Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354202;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=0x6QN9wo/gIl6u/ONE+WuFx2SJWN+x0pCIuLNaVpstw=;
	b=dFmWRExEWON8SdcF209TgDadwkQKaV54AnSBEQg6nvUNe5qM25nSjgMTtpa5y7TzGfoC
	 72Nz0x5FjeDbgRpNTgonPpwzW3NDyd327DJ6GjqJXSSbjNm4E5IIMwU878BT6ROI0p7Eq
	 tynxDsgPSKBSq8HW6TKpkzJTFr1kUpmaIYjA/ujWVIbrD0m+g32sI3vfjWG47UL05Tlki
	 CauGpNtpepma037INLYdyRJxFkRp9lA0UH7p25UVbkA9aSs/HArC1V7qUPNKw5R6lGfjh
	 XqKi0SV9GAHd0aL2FvgNRK3z4uE0HoE/Im6LnPfzOe2Q0RgwN3p6qHD+SDno2v3WoUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=alistair23.me;
	spf=pass smtp.mailfrom=alistair23.me;
	dkim=pass header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=SLTRwptr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LvIryW+U;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D00606A325
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 23:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D00606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=SLTRwptr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LvIryW+U
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id F2D65EC05F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 18:43:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 10 Nov 2026 18:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1794354200; x=1794440600; bh=0x6QN9wo/gIl6u/ONE+WuFx2SJWN+x0p
	CIuLNaVpstw=; b=SLTRwptregmi5YgLcqMIJr1XNTmok1drjTOQY8r7bwcZnPJY
	e3WMsgkDUiQBxSB6DEYNqLWcK4F8oo8eJw9LTPyiJBn4PZMWJ7YTPHQrrDiRgejZ
	CP8gY++zNgjuAAkDbIxIatPrnGggdEiamfEIqb72zQ1bvwbj0Lqbw2GBr4Sm3vA2
	DwEeNElmboQe3Kn//Rfhkx84HRAH3wIE637Glo5jhbRXbLkdjoM9liT6PIGCZH7A
	vHxB9KthZ6mV8pQToL9FokWuKrFFXLZQmD24ZLWR513xzcglC/eJYuiL3+t67YQL
	vYsRF/O2EbsacqFxAAOihJwY/dHgqsZTTi9ySw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794354200; x=
	1794440600; bh=0x6QN9wo/gIl6u/ONE+WuFx2SJWN+x0pCIuLNaVpstw=; b=L
	vIryW+Uc//8KT1///hSFZ5BUkFs5DKzbZtv9/CNM/3k3Q6wDtjwFMcPnN8OwxQNm
	EUtTpvdIjQvFZfDX5b4qK1ECoJQ4+EQ3VLSlswSlJy/BVEzw6MPcrCi5ahBowtH6
	NBEbzAzU/LW1xHdP3pSi6zsLtoOgL7KfyetPbw7ycGdn68Ee/I4qjv20rQLyWO70
	DDHZ72z8+l8u6dcm+6EgsZdLlxMq93ONZZXmXBtpayNSw4GNV8cjIeu6aAZ9ePxa
	O/G/7WYKnBDnU1fN3y3ltodBRa52YcfOMKeYaizTOpafz6CnSJmNJdrGMS7K0giG
	sJKYHRYvfEP2pIE2rPk3w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794354200; d=alistair23.me;
	mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
	rt=PGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:aYb6P4uD5h9bcXLqFXL2DXVOkXpXOcbjLvQsDW0n28iWUJf
	nD75eLDNnhFsu3huSBitGpRM2Cq/wockNwvnSSEia5UsV40h2feNteR7N+FpFDzX
	GqR+g36PJMo57G7Uqu0j72u3TYIDu0x5xOYbkzKVFhWzVnbfQdQMp2haRO8NrYhR
	Rg6UkV7/TKK1i2HvyE4mVoEPx/CYjyuX7Egi0FgUClP1kyfpqy29wLu+OymEwxpc
	DPTGDnXYNEzREo++mUHtBLfINDLsGMk1W6fCWLzGYPbvV7+r3az3X3YsvEY0MRh5
	AQphaK07/0tN09Do1Sv+fg2Bvy57adaxyv7jj0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Qk7gK0IsGB1Q6aMT9k9ePKHHzrDKj/tmy1PB+LqXS+8=:0x6QN9wo/gIl6u/ONE+WuFx2SJWN+x0pCIuLNaVpstw=;
X-ME-Sender: <xms:Fqzzav6CaRv0CZbpxaOaxI427YxzI0JXQeiBEP_FEXoTduxxdSW9KA>
    <xme:Fqzzar1XqJKXDv2fua0IUkpihguiZF-Qx6aLA8ONrbsGVXIzDnDN0ErOEiEGSkTC8
    5UTtqjBatuyRVNJiI8mNr5ZKRIrqVfut_k589jJma_ZL-ZRH4N2wHXP>
X-ME-Received: <xmr:Fqzzarh7rCqzpoW2_Ze1VXOpeFiDtFZ-HYgAXPzeAZFzbk2Tybau9VCEwHTuwtDUvv27UKLQLcHDpk8j1Rcp>
X-ME-Proxy-Cause: dmFkZTFEX2UJcgpQyiNt+GxCdCP+sn8sCJSYmF1dP9IOYwinxKt8hHWepJE33Bo25oa75j
    7gYdW9w0WbI1jJmzHwxrRwYH/Xkjfzj1yd9rLQkOTNeYP831KcvJRlyXTPGSQntqNX989A
    rJ1Zv+fbrOEP/F1XVyGYnhaIFK2xhP3dYOl1BebBb9gXvOcQfiXrvc3yExHxVmuC3DQ3S0
    IrX3U95+MFySpqTExrClQ99RERJLeLlqG5NK7HRE2QLNSdmp1C7JQGLx7RRqoYYPQlFJZy
    fYNjsLgymWFoiNeFxev51sYd0FUYH6bv6duka8km9mkgrCBoXVpgMooGzQuArczz/S0zjF
    89VpIcB+8BgGiEqNTOMqmqWpArDL00KPCSx2ZdPUXc2L4Exmfoj+27+VnHOZBbu8Ac7HgB
    q2YkjksWafyjGGs9Iu95Z32qXKTMWdJEvixQ+ByAd7GSyLoimQrcIjtICLp45ZWR3PmevI
    yVO0bxLh2ji5bMhtqUzh9YIuA9OPL1cyhZVLmRX5XKYJV4zQI7u1J2o6xCBPHxRtziYFY3
    DG/t4hLh+MjwNGQIZUcbiThQqLn4C3EvgJ84tcb2sALmQ7YX3iQ1ionCAt1bLwaJqwXChL
    2wN4nvBvJshvhI8X+7wZIyqrpMHa/3jL2PaDkVTIvrcRpGOUSTIj5VcN2L1Q
X-ME-Proxy: <xmx:FqzzanQ17uTRRiZOYy9o-IGG0nlVQclLbKF8PHhe7VVHf3OGtWQJaQ>
    <xmx:Fqzzat7uwXYoFXrH1gMhNdWKIwL6bfq7JMDDnbN8p_6ymoRAN1feVw>
    <xmx:Fqzzavz_pwLK_ml4Tho34EuPc1x8Jg81BmUW6ftWq9xEgWr89JhJtw>
    <xmx:FqzzatCuIMkDsSetXx98vgWYEBIUs-IEK98FOma_PsVTFHQXUUwr0w>
    <xmx:GKzzasWECsVibloWQs9MRGueFVep43cowMHxf1hnUYg2YjXDMRaTJ1dM>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 18:43:13 -0500 (EST)
Message-ID: <7ba76316996d17efab87a180c88da4c3300f075c.camel@alistair23.me>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: realtek: Add RTL8852BS
From: Alistair <alistair@alistair23.me>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Mah=E9?= <frederic.mahe@cirad.fr>, Marcel
 Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Yixun Lan
 <dlan@kernel.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Troy Mitchell
 <troy.mitchell@linux.spacemit.com>, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 09:43:10 +1000
In-Reply-To: <20261110074607.363918-2-frederic.mahe@cirad.fr>
References: <20261110074607.363918-1-frederic.mahe@cirad.fr>
	 <20261110074607.363918-2-frederic.mahe@cirad.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 08:46 +0100, Fr=C3=A9d=C3=A9ric Mah=C3=A9 wrote:
> The RTL8852BS is a Wi-Fi 6 + Bluetooth 5.2 chip with Wi-Fi on SDIO
> and Bluetooth on UART (H5). Its Bluetooth part works with the
> RTL8822CS driver data, so use realtek,rtl8822cs-bt as fallback.
>=20
> This patch was prepared with the help of an AI assistant (Claude),
> which also ran the tests.
>=20
> Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> =C2=A0.../bindings/net/bluetooth/realtek,bluetooth.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0 | 11 +++++++--
> --
> =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git
> a/Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.y
> aml
> b/Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.y
> aml
> index 7d567122b..ffdf13b05 100644
> ---
> a/Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.y
> aml
> +++
> b/Documentation/devicetree/bindings/net/bluetooth/realtek,bluetooth.y
> aml
> @@ -4,16 +4,16 @@
> =C2=A0$id:
> http://devicetree.org/schemas/net/bluetooth/realtek,bluetooth.yaml#
> =C2=A0$schema: http://devicetree.org/meta-schemas/core.yaml#
> =C2=A0
> -title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS Bluetooth
> +title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS/RTL8852BS Bluetooth
> =C2=A0
> =C2=A0maintainers:
> =C2=A0=C2=A0 - Vasily Khoruzhick <anarsoul@gmail.com>
> =C2=A0=C2=A0 - Alistair Francis <alistair@alistair23.me>
> =C2=A0
> =C2=A0description:
> -=C2=A0 RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS is a WiFi + BT chip. WiFi
> part
> -=C2=A0 is connected over SDIO, while BT is connected over serial. It
> speaks
> -=C2=A0 H5 protocol with few extra commands to upload firmware and change
> +=C2=A0 RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS/RTL8852BS is a WiFi + BT
> chip.
> +=C2=A0 WiFi part is connected over SDIO, while BT is connected over
> serial. It
> +=C2=A0 speaks H5 protocol with few extra commands to upload firmware and
> change
> =C2=A0=C2=A0 module speed.
> =C2=A0
> =C2=A0properties:
> @@ -28,6 +28,9 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - realtek,rtl8821cs-bt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rea=
ltek,rtl8723bs-bt
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: realtek,=
rtl8852bs-bt
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: realtek,=
rtl8822cs-bt
> =C2=A0
> =C2=A0=C2=A0 device-wake-gpios:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
