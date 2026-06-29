Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EFB4657EA;
	Mon, 29 Jun 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752265; cv=none; b=MGdmZRAZmcMICOC4j99rZgg/vny7UokPC6/3NBugLoocqSEhytm0toJQU+JbLdlXKSaNPB7lKsFKMJMyLRQVGif4k6RnCghYI6lwR1bBFrVKyOVWO+xI/9lfLDVeUY9ZtPJHFNtzqfGL5usw5J5dPZSnHPcgXYxZK3v2BpxyeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752265; c=relaxed/simple;
	bh=89+WQJ5B5E0MRo4pgw170wvcOe9OERsSyHlF5gzTCh4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G5bNFauBK+fZImXYE3njwF9JjDG95bLrPq1UjE/OB0MiENnjrDsrZmBLMLfpdLtReLTcVkdj1RCbVUChahaQWYd+w4T1BUZyJiwsbQtXER2qdHK2e4Y42EFl8wbYrYsCVlj1vG5dXdgPb+5/Wp6rqKfDMrRAAq+2DtxKIQkqSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=nL9sATa8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gL5AekUq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="nL9sATa8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gL5AekUq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A91D91D000C8;
	Mon, 29 Jun 2026 12:57:38 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-07.internal (MEProxy); Mon, 29 Jun 2026 12:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1782752258; x=1782838658; bh=8z4dX9G9HGwTDVz7lWrcyd1143t2nE4B
	3EqFZ6d7uNE=; b=nL9sATa8OM/noFDi3LIhbDKspZMTKIBp7FzvMtJ62B1Q0k9R
	lQ1s0L/lwkwlzLkzThCsYeywjh0RBiYgaeQPXUYviXYEpqbcotWaYoIxgP1IMnvp
	1qWKwiaeGknLwjrVe3IzUILW0aGN5wsUVU19hmFRne4Hq/SMnu2fCN2WRHrpdwBv
	i83VfcYezLUcD+9jZxxNbmNSUN8Gh7j2HdAX2ahYdhOD8CJAHvIW8R5Hq/MV1m9r
	SpqPBbxgxRWlbYXsgcVgvZTecNn3dKt4YAl+nSUcdW6OG1NtqlES1O9N6QgrFitf
	sljiCoP6lsphTu3gTuKpUNx0FVT8qt0rXG0SwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782752258; x=
	1782838658; bh=8z4dX9G9HGwTDVz7lWrcyd1143t2nE4B3EqFZ6d7uNE=; b=g
	L5AekUqBmnVgNrID1ug8ChcGfm6ymT6MLYr4W9Xlipj9O9e3opETAQ4Iv8pd/buZ
	DAJz6ncoVg4/CfTyIFpxXTbTWazFIh/tKw6zhI3lCww/4turQ3TWfWKBSHkw3sfB
	v8aM2pSS+W1kqM3U5jfPVQEZOkKNVyRoVcKFqEAlYVW6Srofvmc2IOrkTT6oZjZa
	+UidGKaRaEpPK/BBZxlbwCA10lgMwysYwxOC/gSWxgjShOYO5EujG41B5tUBdIwE
	YvX++/Z/YhQrOoVEXt7fanujSKk/4WkriXTPHal6ig7nn61QWXq2ZnAB6ybyFYIO
	spmQDrHI2Foomoppv1Vlw==
X-ME-Sender: <xms:AqRCam19Oq_kdWNJW_jlkPpxqocA1wl1PQjZPObGoG-n12LrqhaQww>
    <xme:AqRCaj4poiqnprtrJlihBkGKAGIDGR56EhddglmffIYWCgzqENUw3szDHvDKfD6fN
    DibIAA7s7AT5yurtAiruzLYDIvsM2XDZ561Q6ZxKGaJWnHCQpK9PBI>
X-ME-Proxy-Cause: dmFkZTF1Q3JO9KzcGoJdfn1fMv7d5167bJdyg41A7a8rELy0ZKle8CWQyAzqRq7a1FGQQG
    mtyh29+nLTxV8u2tiO1JsbEnHgZSUkqw8OoL1zqw+KNSQ5Obo+dKyM0e/f3VbudXumSLMM
    j6WtWOHCA7qA+VgLzzQgKBNCAbnv7Vr1lZLh3wThlZb0yJFGbwDHYXzBZRsrwf85GdtATw
    HpFYBvh/kR62skONdIYhUz9fZ1ArDHuvYKchBEtW/d0vTaEF/Glm+Jlj54PDWv3E3otmDQ
    nCA8zK0f0vvzyySBxljkEXqBrQpfUtcyAJJx6PH9TRWyYH9ppP0KHyzb6OzOJshiQhdfeG
    Hd+4ZZEWM6omnE3q4UYqVES8gl01g5TmAlpR65I7cDXWL46c0q8A4XzYqOQMexqcE1kW1A
    Y3JgO/30BXsBjH5ckjL3BkAadfDtQks90t6oKRvFo4UzXm11EXBCDXHlMt8mt/gWmHtHg1
    yHTrakCloOti7Cl0awKIWxU3sAaEVh26Q/KRHTRXTau1SIlZ5Y/WI6OZMQXOwqYNG/2LUA
    4pH9agISk0nxTgAGA2N8gRTsf+Mc7yw8ldDf57Fn8F0Ema59Qv4SWEjFZBDKw70ele4F51
    ntUg+pm2gRqRDLfsLW2h5q6bcToK8atqnt9LjCFzoH9rwaYkUTw6JIlnjMcQ
X-ME-Proxy: <xmx:AqRCanaMTKV9VstFv18BkF6LZ2qzU0KP4qf2DwMe6u13skgW0cns_g>
    <xmx:AqRCauniA7tPUKeqGtwb6q-TrigOYPbkwMTBeZGIRUgv8duaUWByRg>
    <xmx:AqRCali1y-QZY8I--5poaQ7NNK5ca-oZyJp-1rLYkanGnI__D-Vf_g>
    <xmx:AqRCaoTMQU-Zuf2AtKEXq-B2VXwvwbWn0qF2U2pdwej9z7S7YALdag>
    <xmx:AqRCaqlJ4y3ziIveRX8IVFtqsThoGlojM2z-r-0fVXT1hRc3AfaiLONp>
Feedback-ID: ib8c04050:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2643D216008A; Mon, 29 Jun 2026 12:57:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALKm71tceP_3
Date: Mon, 29 Jun 2026 18:57:17 +0200
From: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
To: "Conor Dooley" <conor@kernel.org>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <4fbe561f-bde2-44a8-8198-6a0a179f62f3@app.fastmail.com>
In-Reply-To: <20260629-handwork-retract-224b150e5969@spud>
References: <20260628095500.29810-1-hugo@whynothugo.nl>
 <20260628095500.29810-2-hugo@whynothugo.nl>
 <20260628-shakable-spooky-e75e410f20f5@spud>
 <91619a5a-602d-4650-99d0-326971f5e5e6@app.fastmail.com>
 <20260629-handwork-retract-224b150e5969@spud>
Subject: Re: [PATCH 2/2] dt-bindings: bluetooth: broadcom: add BCM43752
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, 29 Jun 2026, at 14:04, Conor Dooley wrote:
> On Mon, Jun 29, 2026 at 01:32:18PM +0200, Hugo Osvaldo Barrera wrote:
>> 
>> 
>> On Sun, 28 Jun 2026, at 21:17, Conor Dooley wrote:
>> > On Sun, Jun 28, 2026 at 11:55:00AM +0200, Hugo Osvaldo Barrera wrote:
>> >> Document the compatible string for BCM43752.
>> >> 
>> >> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>> >> ---
>> >>  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
>> >> index 95501e858e6f..04e8a968548d 100644
>> >> --- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
>> >> +++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
>> >> @@ -29,6 +29,7 @@ properties:
>> >>            - brcm,bcm43438-bt
>> >>            - brcm,bcm4345c5
>> >>            - brcm,bcm43540-bt
>> >> +          - brcm,bcm43752-bt
>> >
>> > This new compatible uses no match data. Why is a fallback compatible not
>> > suitable?
>> >
>> 
>> I wasn't aware that this was the preferred approach.
>> 
>> I used `compatible = "brcm,bcm43752-bt", "brcm,bcm43430a0-bt";`
>> in my DT and Bluetooth works equally well. Both of these patches
>> can be ignored, thanks for the review.
>
> You still need to add a binding patch to document the new compatible,
> just it will permit the fallback.
>

Right, CHECK_DTBS=y fails without that change.
So the second patch (which changes brcm,bluetooth.yaml) should be merged,
but not the other one is unnecessary and can be ignored.

I don't need to re-submit the second path independently, it's fine to
just merge one patch and ignore the other, right?

-- 
Hugo
