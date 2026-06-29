Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD75346E4C;
	Mon, 29 Jun 2026 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732762; cv=none; b=tGJWka0PNheIMHVknN09W9O6QdDHLh6h4xXX1O3hMuH7k3HPb8nGfmbjMQ7Np9ruf7O8jzZXvh+EZTAcsdv0hcjPDqe0nL62BQEtSjTQ+EuQ1czPU3JwcDu3avbFeitxutRoVsWSS8E9h4hUX4FOHViJDEOmzX/aHNH2sSZDMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732762; c=relaxed/simple;
	bh=fRYDDJ5StxN3h/4dkWLxrgqH61N3GxSVw2mr8P1+OVo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u/+qYUcd+K8JpEKFWFLpO5RGSsQNLUhq/pKNQktOVVkYSopeQBX992qDz3UR/03TXVgC4uKzvEdxoeyZrClzBkTNw1EjuN7fnao8G8pK3Fka6O1wFiTTYOc/sH6q9UoC/P06nfMtzjTHUS3GRHTWv29aVHcDS+AdWFQ4kQCg8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=EVQ4kW8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOL7igEq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="EVQ4kW8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOL7igEq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BBA8140010F;
	Mon, 29 Jun 2026 07:32:39 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-07.internal (MEProxy); Mon, 29 Jun 2026 07:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1782732759; x=1782819159; bh=j47sqoA9LsXBDJhXCBOb4QMnFis/G07F
	6uWGiNjtTLg=; b=EVQ4kW8qIOPYAsvL5Jti2gMlehCe+nWd5ODJBEU3vFaeQqGf
	aoZoLGZkPLGnjNy3eq+GhGcnCODs2lKMNWR3uWcXAyK/gZH/b2robil/FnfB6sVq
	3DVN2okK2dPLDTq0Rl+K6vcVVwNtl7roTzM6gkhtVGnAmosWo0AENBGFm38hwZB2
	gVHx8ft2t/D6Zd8pT1Boy7pnnDkhh86CTvA54xsQhWQvo1Pgmw4R7rn/k6vBUSr+
	Jztp1zoNgwd6GLwCwtsLNO1+oUhUkKpAN4kaKEpfmBW76g1hotN4NXruX+S3xKze
	qOyox6F9O7GhvMcfohzKcA1E0JOr4JwXLirTwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782732759; x=
	1782819159; bh=j47sqoA9LsXBDJhXCBOb4QMnFis/G07F6uWGiNjtTLg=; b=L
	OL7igEqm4M13ITeQYlGxGaWUntwhnVEVVuZ3bFgKpk8F0EkacWH78aj6wRy2l+6F
	H0W9v1xQgiR/DZBduq0mgoaA5HsuO/T0CJU+KiHRmGTL/MVge1TYBmh+OR1HVbTs
	dUfoLUsvbilVw7g+/gV415PNVI3exosxZDSqi52/2lTyxxbCEgFJaYNUncA8bfmk
	97Og9WXsL9nmTUry+0MrYdnt6RbABwCcW2t3TaGl2ILaie9IARLSNnqRMvMEFsD+
	h8qmmbvEv46/vWbBUSHBO6W60r/l1H7tdaMY29TTTN6QvdRE41OqfXSkPzZ4M7NK
	rzCejw9dNUN3vzVUVA2VA==
X-ME-Sender: <xms:1ldCalssaFBJXUbWO6d_70TPYvY6eJ5IfeZGfF5OV7UES0ncBi_jtw>
    <xme:1ldCapR4p33WkEuNNoo47paSuuyiPVKySBDD8Vsc02VOmrAMCjbd2WW5GYR1dAOKV
    4FNhmzf1er89IXsDbjoaLZQ_kbJeZI31wG3Wi3niKvHw1t2Vc6aDg>
X-ME-Proxy-Cause: dmFkZTEzMGVsDTKyUGADaW8eo6J33N2sD6A4HlSFJmBrIvNb68e5N6YeVyEnG5iuFAPzjF
    iVtqaOZ7TTh5rGjGicSJRH0pgwnOjr1Wr1syPiHecV1Oy345Fu4LL8l8xjWlYerIWPiigL
    IZFgmcCSmEMmmC6HUOOce5zKY3CKyxBZEKKPmBmChRVDYy8RNe3rQwZ4+QXF/8BPEp2+N6
    gnjc2p5ZNOF3EuspRtfnBhLgU/4WzcGCUD0paG5wnXKfGm7qq+3IVa0Vi1jsoY1chN0j8z
    dY8PMv9phDv64bJOfN4VfEe8Qhekm1BiRLiVp76LgPpjl7ewRp1MghlLDN3JQ1zum4JVYD
    3ddQINKQH9gxeojHhNzNEKtxqWYD/pTkTJNVt+Y7w/ijxKCJ+QuQKuKlMcLedKRHbj4vAz
    pgPT17fvlZtgzxiRQMfCHXdt80ZnsVD4Nhd0k+u0Ib3HTwb/ZLZwXHh0Z4MfdPtl2CTlXG
    6JtNVMONvZ0RUpudPYs0znlYJoZyFfQoQltgKONb4xB4Z/AjVDi/tRSoMzl0MKrWSeGuFt
    ko9H8Ktx32mnk9KmWPOAUvhHRz5XQyvgwRPzgsfD3Pg+U7piLBLnW+KoS3LEk5fbGEVWmX
    ndD22kQO3rcI3J063NKk+y0ZA2kD47/c55+IpVR1a38Z2nOuuYU6ilV+K7+A
X-ME-Proxy: <xmx:1ldCakT65ns5pPudxMpDZyQVo6gi-m97fEdYM5-W0AD97-7Ydxhnjw>
    <xmx:1ldCap-3U7cPPoi17hP8gFQZgSqC7YAsKHoOwkM8JRZl0RjkryHpRA>
    <xmx:1ldCatbKrPewKEfXJTzQFLj2w5Y1kRO-SuQkQnWqQuQtfdaEtyNEvA>
    <xmx:1ldCaionj6YC8N4PcwhW8E9d3WgcfViZD-d-5hgTeZRzxiwLtnI5Ow>
    <xmx:11dCagNSPQP_FnqHnn4LcwcF_-QtfJMT39kibFkRhW-x1eAN7NcznOpB>
Feedback-ID: ib8c04050:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92CAF216008A; Mon, 29 Jun 2026 07:32:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALKm71tceP_3
Date: Mon, 29 Jun 2026 13:32:18 +0200
From: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
To: "Conor Dooley" <conor@kernel.org>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <91619a5a-602d-4650-99d0-326971f5e5e6@app.fastmail.com>
In-Reply-To: <20260628-shakable-spooky-e75e410f20f5@spud>
References: <20260628095500.29810-1-hugo@whynothugo.nl>
 <20260628095500.29810-2-hugo@whynothugo.nl>
 <20260628-shakable-spooky-e75e410f20f5@spud>
Subject: Re: [PATCH 2/2] dt-bindings: bluetooth: broadcom: add BCM43752
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, 28 Jun 2026, at 21:17, Conor Dooley wrote:
> On Sun, Jun 28, 2026 at 11:55:00AM +0200, Hugo Osvaldo Barrera wrote:
>> Document the compatible string for BCM43752.
>> 
>> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>> ---
>>  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
>> index 95501e858e6f..04e8a968548d 100644
>> --- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
>> @@ -29,6 +29,7 @@ properties:
>>            - brcm,bcm43438-bt
>>            - brcm,bcm4345c5
>>            - brcm,bcm43540-bt
>> +          - brcm,bcm43752-bt
>
> This new compatible uses no match data. Why is a fallback compatible not
> suitable?
>

I wasn't aware that this was the preferred approach.

I used `compatible = "brcm,bcm43752-bt", "brcm,bcm43430a0-bt";`
in my DT and Bluetooth works equally well. Both of these patches
can be ignored, thanks for the review.

There are multiple compatible with no match data, and I was
mostly following that approach. Are they there mostly for
legacy reasons and adding more with no match data is discouraged?
Or am I missing something else?

Thanks,

-- 
Hugo
