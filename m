Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0934B404
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337523; cv=none; b=j80AKQ2xH30fO3mlaXAtrl6Lk+YIDJLoabtwW87npWAs+d7/jrcAS0ENsale9HKLGVMZhLPEACwjsYtXlZ11Zh6L0ryfOgy8StZ+fqOFBwggbE74/vNkU/6C3imi1RJ5tN0NhAkLc1zYPUc6knpsQh3nPCq7trNmfTVGpV5Sfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337523; c=relaxed/simple;
	bh=SqC+HGFCGMcsD1WbMfljn1efXlZGDQL1nf8+DjedYMk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BPquIp7nNbho54ZVvE9QcBcXYaVIlnnvwUBlQajwhYEIUkulh+tiRQ3dJrib0/QnUd45LZHcqs/YXp3JQXrDWX/aYS4FXzWBevWg+gSQglPpjV52B+DoXdXi9BNmpLVv/+Xom5ziGKsOKGsB23GJ/NPU5BkjR/oujOTT3S9Zmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=Qx8Tyk7x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=voPDA6L/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="Qx8Tyk7x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="voPDA6L/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D553A14000EC;
	Thu, 21 May 2026 00:25:12 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 00:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779337512;
	 x=1779423912; bh=dssKicvpb504eC1iRyISmQcBmi8gqGPgh2tlDWTBX+0=; b=
	Qx8Tyk7xzC4w0OKUXiGTc3AqKlcieFY5dj9oqqTmbCpz+232W091Zd92WlHW95MA
	Fw7qp/PWFraBJiDrH2kT69sdra1RmN9mscJGMZaEN8tQ79o4I/6aGU7Otzb1izEK
	/KX1gRfp8ievav8IUREpYDV4zqTd0Y4OZnLfHfHVKN2r0WnvUNEyQyqRn3DcoDwS
	5BOPnCwgghYw/1S2la7Aqpt6+fad75RgEyhx9/OQucrqSvPzz4sIbyAwj1YLy3tq
	hYNJK8MQYcuIaaV/g/Qdm0SqNt/xLHmtAVrs2SNLZXAXq0GOLcZLHUuXFmxOeaJ0
	hpf7opBaM2GoaPUrOBTcoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779337512; x=
	1779423912; bh=dssKicvpb504eC1iRyISmQcBmi8gqGPgh2tlDWTBX+0=; b=v
	oPDA6L/+E1X5tNKodtW4F6fMLFSvXv0gJKSnxQY1lrBB3Y90bZHfkp/ucdWLpPC6
	XLcWe3HuX+vBBAJ9wbectIIcGW3Gmq4eI3B2yvbLyLCQsCnHCakP3/fKmU8pp6Gq
	tVeaobwmZFqq0NOKs572sB22M/2u3EsL+QiA6gc0eRJNoAmwmSNGkw/wVZuszl+6
	ScPjwSTWcVoSQourkzwHbcEFKB4Ozefhh5qeX/kRIJyT+lvcXd4UyTB8UEHZK7+V
	FEoPX2OhmzMKBEoOqcRnIWNIVBiqNYyClLLNbwLHmtnh/i/BWpUMMdN2SRa/AO8J
	kIUn+F0Te1NKbQhWNCZGw==
X-ME-Sender: <xms:KIkOasE12UqMsos953qVSIND23ayhRUtMs1ztcAUzHy44iTe1jOMQA>
    <xme:KIkOagIdQszhwO-3b87Ynn_fdiCWbA-gGZU_MkYNys6jz10mv9JgjFK_vzD10GX9W
    e0A4jv0RT-QVBtOXDnGvknoPC3-0MTdqM44D5VTLUiOrdl_VTG8Ac0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeiheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuihifvghiucgkhhgrnhhgfdcuoehoshhssehfohhurhguihhmrd
    ighiiiqeenucggtffrrghtthgvrhhnpefghfejfedtjeefjefgteejkeeutdegkeduteeh
    uedtgfejgffhveetlefhveeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehoshhssehfohhurhguihhmrdighiiipdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhiiidruggvnhhtiiesgh
    hmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KIkOaiyPUGrEfwU2L8gRpL1Qyd9hs8JUQuwfjFIY4hkP8J5fD2wvZA>
    <xmx:KIkOasPGWPFYLT_yZO3bKw78eZEGvvXCorYiE8h1n6hAU80aUIKs7Q>
    <xmx:KIkOar5Q6sRkgcDuTvgkk25GO3NBzqUT3MDcv1iH8nAzebtcZNLBNA>
    <xmx:KIkOalMADy2SydYvgWrqNuMpvX9EKvLPxJJw2WZxgIaEU-wySahF-w>
    <xmx:KIkOas5zu_XAfC3-KlNeyvz_slfZydSnSpQgYTIHsTIMCuXJyJgXrUPs>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B5965216008A; Thu, 21 May 2026 00:25:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4i_tNf7zNzg
Date: Thu, 21 May 2026 00:24:51 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: linux-bluetooth@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Message-Id: <63eb935a-08d0-4ed7-a654-3de2adec8688@app.fastmail.com>
In-Reply-To: <6a0e82a1.131d4d69.3874c7.d8ed@mx.google.com>
References: <20260521021249.3258069-1-oss@fourdim.xyz>
 <6a0e82a1.131d4d69.3874c7.d8ed@mx.google.com>
Subject: Re: [v2] Bluetooth: L2CAP: use chan timer to close channels in
 cleanup_listen()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, May 20, 2026, at 11:57 PM, bluez.test.bot@gmail.com wrote:
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing 
> list.
> While preparing the CI tests, the patches you submitted couldn't be 
> applied to the current HEAD of the repository.
>
> ----- Output -----
>
> error: patch failed: net/bluetooth/l2cap_sock.c:1512
> error: net/bluetooth/l2cap_sock.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.
>
>
> ---
> Regards,
> Linux Bluetooth

I think it is false positive as I rebased against latest bluetooth-next.

Best,
Siwei
