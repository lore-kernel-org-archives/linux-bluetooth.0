Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CD15FCE1
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334904; cv=none; b=orxRNqX8IUVGVgu+T3aUaALwhQZSwbiNX+Z61AXWwdQWyV1X8bP9TR3uf4BHAjtQpRtTRvh7IM9kXcoAnUGfWLQfN8ISJBEHDFScpqMPJSsOLVgc+RiB4DIWNj0N395U2fRUmxBrFyiOV0m68y4kA5QpekpxoEecB4C+zLd5WOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334904; c=relaxed/simple;
	bh=zyYfLt4Ecs8HU/x+zjq4DFkOpZ4wMvlgECzsCL41iqA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uDITcA4OA9l69hz13SUOhVISLscf/bKiQVAJD8aUWGnxSWJz6xaB3TDgB3XKsldGsmumgjkRQeMngFVnhv73AGY3FcUR56vChWrsmEsHrA7F+3N6PO9ZLXW8JfakU/YLg01RWzRdUSq/SC5DM64BCpWhdaH6UqipyiM8T6mY2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=lUnbSe3v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M5Xq2BMv; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="lUnbSe3v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M5Xq2BMv"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 291151C00067;
	Fri, 10 May 2024 05:55:01 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Fri, 10 May 2024 05:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1715334900; x=
	1715421300; bh=zsAX12i3wiGs8NpHFwK4gaLZUeZbeVFiTubMbmtjtjM=; b=l
	UnbSe3vvJ65EIfoOs6o22VLB3Xfhx2zUELZHMUBPbSnABGRS9Z2WGUmpI9ij+z5T
	h/PBo2NgNublSXDhZKgIRqRXWJwZ/5rrmbqmkMuItJZg/JY1lXja4b3tjZayadAj
	171mwwgYqkrlqYkuj/FWfCSE06AKxfLvKBBX/CbYDX8X0tpOroJo2vbC6tGIu4JX
	8BOnjtSelvZ60Jc6KOsVnyBE4tr98qC1rup1tETSlNit+nROfklwKQ1/0oPz5pQY
	Cvb24JHdQ753hjazzM1jHcCOkUnoQQDNCTQwZZKIexn+MixrdNV+RYYYvOteCEvW
	6tbSN2J6/vSFRu8dyYtOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715334900; x=1715421300; bh=zsAX12i3wiGs8NpHFwK4gaLZUeZb
	eVFiTubMbmtjtjM=; b=M5Xq2BMvKcAoUAQ9HgnGrL6dzZjs6aT8ryY0VuaT22XN
	lhZQYs2AwfepeDbtjBVwPmy5vjN6uBmIdN9l9ZpYfUpEj6vhGBqc5GEYv9aDRgeR
	cwru4/ASI/4jkvB2h0x0AmIEDEtu4TxdDqzU8ajQecwi88JhvcR2dJWkGj3HHrnC
	+IXzu3TXw0+NKWoYowDRyj4s0KJ8RS3H2rqq2ZptHb8ZxD4AzZllzHxA+OalyitU
	SSCRGViyGQ2qbJxkxHbEnuWUsW34bNjI4l39GAi15HRKIN5gvs1l3FvqgAP7/Tt0
	7O2JHQGPekR5OodFnj9K1Tuwu5Bvas0yibAQPNGxmw==
X-ME-Sender: <xms:9O49Zhk49omYKwRCcqPcWBW-t0AvS2ttraComtyroE9xsW4wgJJF0w>
    <xme:9O49Zs10PqHeqrOnSA47L8WmgPn4p5gdYxWRdMB9ngg9Az2Q0c3DsPzkPwxG98q2Y
    qk2KT20PUC7cPfCkhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:9O49ZnpB5C5MtTsDvpbijslCJtSHgFdBvfk4QF4-2QUoVfOB_5866w>
    <xmx:9O49ZhnpXnfN2lzMKuNXKNeWpQ8hWxeO06ppCsDmwLUddGnDJYhzVw>
    <xmx:9O49Zv15Jebi5f-5Pr14iQBFcIXDIPIEYMHjrr1SQb7cPAQK4GnyEQ>
    <xmx:9O49ZgvbsAUld6bWPRnvQ82GZRtXGY9FIZE5Ob2yYehmA_zK_d3-Tg>
    <xmx:9O49Zv9enmUL1YEnuuXLhlaQdIunvBWR9d-T5bb2NRmchMg-_wrfjEez>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3C359A60079; Fri, 10 May 2024 05:55:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4e194251-d175-49d0-af03-b2cdd8a30fe0@app.fastmail.com>
In-Reply-To: <70078624-d766-4db6-8ddb-511251baf0f2@marcan.st>
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
 <Zjz0atzRhFykROM9@robin>
 <CABBYNZLMODHp+jBu2oVDC5Pg6fyAKJugQF0N-XgarjWQJJPObg@mail.gmail.com>
 <Zj0tcmseJCjR4hK2@robin>
 <CABBYNZLnYz-vPrMbtsJTsLPsyo62j+cxctSkLjRom3bWEU9N3A@mail.gmail.com>
 <CABBYNZJ-6oyLnBov9H_jym9m-9qiUt1ELxYGuBOdZT29aj9MCA@mail.gmail.com>
 <70078624-d766-4db6-8ddb-511251baf0f2@marcan.st>
Date: Fri, 10 May 2024 11:54:40 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Hector Martin" <marcan@marcan.st>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Janne Grunau" <j@jannau.net>
Cc: linux-bluetooth@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 asahi@lists.linux.dev
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on
 hci_le_ext_create_conn_sync
Content-Type: text/plain

Hi,


On Fri, May 10, 2024, at 05:13, Hector Martin wrote:
> Hi,
>
> On 2024/05/10 7:41, Luiz Augusto von Dentz wrote:
> <snip>
>
>> If I print the actual value then we got:
>> 
>> Primary PHY: Reserved (0x81)
>> 
>> I guess one needs to disregard the reserved range, well until they are
>> no longer reserved then it will no longer work. Perhaps we should talk
>> to broadcom to know what is up with using reserved values and if that
>> is an apple thing then perhaps we could ask them to provide firmware
>> that acts according to the spec.
>
> Apple and Broadcom do not support Linux on this platform. The kernel has
> to work with the existing firmware (which is the firmware macOS uses),
> we don't get to request changes. If the firmware has quirks the kernel
> has to deal with it, that's how it goes. It would be great if we had
> vendor support, but that is not something we can control. This is common
> (Linux is full of quirks to support noncompliant hardware/firmware).

While I agree with Hector here that they won't even talk to us it's
sometimes possible to figure out what exactly they were thinking with
their reserved values. Apple provides "Additional Tools for XCode" which
include their "PacketLogger" which contains most of their vendor
specific hacks with a human readable explanation. I wasn't able to generate
this specific event with my hardware here but I was able to inject a custom
event into their trace format and then load it and see how it's decoded.

From a very brief look it appears that they AND Primary_PHY/Secondary_PHY with
0x1f to decode it and then support all values defined in the bluetooth
spec, i.e. "no packets", "LE 1M", "LE 2M" and "LE coded". No idea what the
higher bits mean though since they are ignored and don't seem to be decoded.



Sven

