Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DB364EAC
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 22:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751570; cv=none; b=WAtl1zJkmQV45+CV4JXcXHIWXifSvx2dvh1Yie8XqwSo9QsTGitwMjWB12X95zDuH/+LaAOqssysAWWv30q6VAcViGOp0A4ppps/oN3Lj+IhS2rrFlBfbktXjAGYq0zxFXFAvRLj58gVBv9vtqWRv1bysn6xqNgyPJVsSkEQKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751570; c=relaxed/simple;
	bh=+/iHWHQLpk3K5LJg+SvKiRZy0gFEfO1Ya2GV4blP7iE=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=Gr5tn9RAaj0aqEwEDoiDxKXsfRhUblnJZXrFK/4Hctq3p7qnAv2h47/PdQQx8Ov3k8hD7N4pFq1jzmxGm71x4ix/c1Drcd1ob1lIzDATNkpRfxk8HYcLwCsiVY3zNqu8++YPrQnaSvhCRLFXhwv58tgKhxhblwka3fj+LFYvExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=diOupYjY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=13N2KR9q; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="diOupYjY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="13N2KR9q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D15457A0155;
	Thu,  5 Mar 2026 17:59:27 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 17:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772751567;
	 x=1772837967; bh=5oNmPLUuAxpQ/gQqEmWYBp9kTllLiducyrRQ+EiB7ug=; b=
	diOupYjYOtri+ddbpkBUCrgGYM17N8d+AgGIpbeE0CP2vqCjSaeUNaF8vvLcx1Lw
	J6pzRz15uYWE8O+e9WbjeACoYF7yNxBeammlSeFusopZnjbyfMhIKG1WOxyBI6dK
	96w7MxH0KxyfMGKyhcCtTUHv6JopWRErI1p1a0w1PoSjzC3Cjj4cwfEpQBWFJK9G
	cO756tqi/iEs3//f5DzAfFhnnJZrcOAXH/YYdK3YLI3RNdUvb5rZbv4NtR0eLUCn
	NSWXVb2OtdnehkRmLNVVq4kaQ4wOG9GE2X0AV0jKbRWyruUPS1X9QaIKeG9qFgVF
	dmoypQJySTu3AThtIBQmuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772751567; x=
	1772837967; bh=5oNmPLUuAxpQ/gQqEmWYBp9kTllLiducyrRQ+EiB7ug=; b=1
	3N2KR9q4WW0f13+lCa8OeNuJAMkVX+ggINzlh50IGKEAkyf5y5D84Gmg606ge6dJ
	4XiIX0bpgrASjWaoIovV2KjUBSe+aP3/znZJdrNA+yrhLyRjGeFOZAPSunEn1pvs
	/8xYx7PUb6hAT1UXOxKVVtaWbC0jv88rFfFfBxN6UuohulXO1n5SmDCCyUCLmMal
	+q0i3nVxSwd51KWQetbXtwx2x8AUS6dwgRgypSoF8plFCC9ht7OiA0gVvBATLFpD
	uZvDbdILaSKssMwX3zv862RPkgBznDcPpH/De1l2Jc97J6ye/KmXesyMwDQogBHt
	8pPEUlkDpSisGbzC5+SYA==
X-ME-Sender: <xms:zwqqaSfO_gFjmbVcHr7qDFqaPTu8xpG3VIJ6GZUuav0RCdkrdfodtw>
    <xme:zwqqaXCkN4C-GKmxEN_cp9_Jpg_vITSYQq8dews6UjAym0hYAtE0m2wPPUSpZBANq
    VOz7j1FGzMO446GNxwLjrhWzb5uGLJwRuwrXb9JBQ7jCFpH3vqZQxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpedtudejffejkeekteelueefvdejvdeuhfefteehkeevtddvleduteek
    leetvdelhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:zwqqaRINRYRgjQxMNNY4r952GH2gZp-vbVZAI6Rpa1jpGv0GEUlaMg>
    <xmx:zwqqabEFlyuJEDvuq_MgkJNR7yJj3yzZWYKo1ZSG45j0l_LSwQYo0Q>
    <xmx:zwqqaRTwXOWXySxJw1LqAa8fW06MQWYJNnyVFM2k0ydf7Au4d5iCxA>
    <xmx:zwqqafEbTHCLcT_lison311IG4yqMVgBcoiv06LtqXC20RfFYqNStQ>
    <xmx:zwqqabxQ7djONB1sE73haDMrTKrlE2JMwX3P27ZH3Z-tqYMlJIGF9Dij>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 671361EA006B; Thu,  5 Mar 2026 17:59:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Javier Tia <floss@jetm.me>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 05 Mar 2026 16:56:47 -0600
Subject: Re: [PATCH 2/2] Bluetooth: btusb: Add USB device IDs for MediaTek MT7927 (MT6639)
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: CABBYNZ+PTk5+Dq5p+kHQdmqQshsC1kOzuqqmJtZyF5XAJzLzmA@mail.gmail.com
References: 20260305172813.12F6E1EA006C@mailuser.phl.internal CABBYNZ+PTk5+Dq5p+kHQdmqQshsC1kOzuqqmJtZyF5XAJzLzmA@mail.gmail.com
Message-Id: <20260305225927.671361EA006B@mailuser.phl.internal>

Hi Luiz,

On Thu, Mar 5, 2026 Luiz Augusto von Dentz wrote:
> Let's gather their emails and list them as Tested-by, or perhaps we
> it should really be multiple changes to make easier to trace back
> how it was tested.

Good idea. I'll split patch 2/2 into per-device commits so each USB
ID has a clear Tested-by trail. The split will be:

  - 0489:e0fa (Lenovo Legion Pro 7)
  - 0489:e10f (Gigabyte Z790/X870E boards)
  - 0489:e116 (TP-Link Archer TBE550E)
  - 0489:e13a (ASUS X870E boards)
  - 13d3:3588 (ASUS ProArt X870E-Creator)

> Ok, so Id probably require 'Tested-by' to be a human, and in this
> case, I want the lsusb and dmesg | grep bluetooth either directly
> in the commit message or as a Link so it can be verified.

Understood. Each commit will include lsusb + dmesg snippets in the
body and a Link: tag pointing to the full hardware report.

I'm collecting the Tested-by consents now. Will send v2 once I have
them all.

Javier
