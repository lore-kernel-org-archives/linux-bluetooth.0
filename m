Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E891708AA
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352264; cv=none; b=PD8cduLkWA+SIaHlPBlJ2FJALzk1xMi81F8nyjyVNXTGW3MzXdh+eUY7b8bSIGCdAValUtzjPkKbmAb/RdNS7jupthJ0sgWmaOaAMms+5IdtisKmqmIjxc7uyr85a9g28wSAPcdltCVYEhCA/xZuPpiahyc2lnXVGFhDn/xhY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352264; c=relaxed/simple;
	bh=CLtL2syD9ZrfDYCx8ul5lwLyT7C1dMm/GjXi9wJ3JJE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=bhn8Ee+e0ZeKzuq/WBgckv3cv4eYZo/cvljXd2hddkbyk0+O+s6kQGJwFpEi5rH8mDnyQNYk/PcHjbIfIlB+V5xoNTl7zWHVJj+wSbP0n5/rzhmhdxxBHhM752fq9d1mqyl+868vVYUm+L7pwixChVxXr/A48YX2zoymT9/a0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=OpBVSc7a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PqBcm/Y1; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="OpBVSc7a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqBcm/Y1"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6670E18000F4;
	Fri, 10 May 2024 10:44:21 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Fri, 10 May 2024 10:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1715352261; x=1715438661; bh=CLtL2syD9ZrfDYCx8ul5lwLyT7C1dMm/
	GjXi9wJ3JJE=; b=OpBVSc7a7jRRVMYH7hUYxAzsxT4sAp58harbZ9i4Xa1sykUi
	7GpfROYTYiQTfunqJnzrFVSkIJLHjiKmzAYcjN9Vo1UDtx8kd2McTCfurCKG6KbR
	99+ii4x3vU+hAFwp954X4Z/gXcN/Puc6C/9lGGaxkpaCfd4eusqwXK5t7dFQ16S3
	pvWzyVFOuaaKiZnz67QbA4nof0VaAL159h8qTSqEOVECi3PWR1XpJK+PKCprP9is
	J/cNscZCXeYp2Vmbp8NaWptdKbj53Ae0B7VPqUhktfh+6O+ipD31wfEZGiQUxDHY
	WdfvFnM/CuPH9OVc53TQ0GFyKRecvEKalupAjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715352261; x=
	1715438661; bh=CLtL2syD9ZrfDYCx8ul5lwLyT7C1dMm/GjXi9wJ3JJE=; b=P
	qBcm/Y1f/9tR2KIEIp7MoGTyAZs/Va6jVpQdbja520m4uzysjWSVBO18lvCvN+9t
	5iWv6Mu4VZAaeCIY5Rc+Zw5NLW3ZuHaQeUDZjpkH4Jf9V0FYuO89dEfXc1UtfLI9
	YiJQKRJoVD/HhgHh4EFwr6GUW+VeoXKejvPt2mAgb9a+oLfAiLP5sWlwg4oO0IHe
	HGDEltjny3diJ+xIxUOa2C2ycLRutkIb6+IgpTAPYNpyx4RfMLbyTgxib6xtsGtr
	DZ5bzE2R8iUJtEor1mkMlMAHdG2i6kA/csHH09f00hbYJyBBldDQk8owkFcaGaZ6
	GhLqS3Q0d0Hb7iJlkEhtA==
X-ME-Sender: <xms:xDI-ZulSv-dPyrfrJkfIiK3VkPI2rkhqLFDWXIc2n-uzFjJOu7tl1g>
    <xme:xDI-Zl2_tVXsa6GUOtlrfAay2601aDSFvS7q1_ugH-iF1ZJEOR0KFCeP6-6gCEUfT
    2M-UWt7eiMJkwB0Zmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeegffdtgfdtlefhhfdujeevheekgfdujeegudevteevudefleefjeel
    tefhjeehleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghr
    rdguvghv
X-ME-Proxy: <xmx:xDI-ZspgbM8FkrMdmTLIAs9gxSP31Zj0sFuAhl1N3uFcsqURybDX4w>
    <xmx:xDI-ZikeNlu-pBFoVU5t1VOsB9LcM8YK4sgEOsRgrmJ2Uo3pvwUNXw>
    <xmx:xDI-Zs1xMw2sOWDQ6skjyvukLkvtF0uQOJ6mVYhQKq-CCo-f38EvBw>
    <xmx:xDI-Zps-CAcFQz4X_Z16yFTSyQL1gO1s0UwKpWGdJ7wXhREmS7jRWw>
    <xmx:xTI-Zg-HbPjUrUWgBP8leX1nAbKgf10kMyvU9p2pabTXlWDvJAZJ2q5M>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 407AFA60078; Fri, 10 May 2024 10:44:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <afd2cfb0-1406-4a17-a0d1-f7f6b073d26f@app.fastmail.com>
In-Reply-To: 
 <CABBYNZKkkAA0KXDR-R0M5jCHNhnLrpH38Ympfm5-JgC0yiD7Bw@mail.gmail.com>
References: <20240405204037.3451091-1-luiz.dentz@gmail.com>
 <Zjz0atzRhFykROM9@robin>
 <CABBYNZLMODHp+jBu2oVDC5Pg6fyAKJugQF0N-XgarjWQJJPObg@mail.gmail.com>
 <Zj0tcmseJCjR4hK2@robin>
 <CABBYNZLnYz-vPrMbtsJTsLPsyo62j+cxctSkLjRom3bWEU9N3A@mail.gmail.com>
 <CABBYNZJ-6oyLnBov9H_jym9m-9qiUt1ELxYGuBOdZT29aj9MCA@mail.gmail.com>
 <70078624-d766-4db6-8ddb-511251baf0f2@marcan.st>
 <4e194251-d175-49d0-af03-b2cdd8a30fe0@app.fastmail.com>
 <CABBYNZKkkAA0KXDR-R0M5jCHNhnLrpH38Ympfm5-JgC0yiD7Bw@mail.gmail.com>
Date: Fri, 10 May 2024 16:43:30 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Hector Martin" <marcan@marcan.st>, "Janne Grunau" <j@jannau.net>,
 linux-bluetooth@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 asahi@lists.linux.dev
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Use advertised PHYs on
 hci_le_ext_create_conn_sync
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Fri, May 10, 2024, at 16:33, Luiz Augusto von Dentz wrote:
> Hi Sven, Hector,
>
> On Fri, May 10, 2024 at 5:55=E2=80=AFAM Sven Peter <sven@svenpeter.dev=
> wrote:
>>
>> Hi,
>>
>>
>> On Fri, May 10, 2024, at 05:13, Hector Martin wrote:
>> > Hi,
>> >
>> > On 2024/05/10 7:41, Luiz Augusto von Dentz wrote:
>> > <snip>
>> >
>> >> If I print the actual value then we got:
>> >>
>> >> Primary PHY: Reserved (0x81)
>> >>
>> >> I guess one needs to disregard the reserved range, well until they=
 are
>> >> no longer reserved then it will no longer work. Perhaps we should =
talk
>> >> to broadcom to know what is up with using reserved values and if t=
hat
>> >> is an apple thing then perhaps we could ask them to provide firmwa=
re
>> >> that acts according to the spec.
>> >
>> > Apple and Broadcom do not support Linux on this platform. The kerne=
l has
>> > to work with the existing firmware (which is the firmware macOS use=
s),
>> > we don't get to request changes. If the firmware has quirks the ker=
nel
>> > has to deal with it, that's how it goes. It would be great if we had
>> > vendor support, but that is not something we can control. This is c=
ommon
>> > (Linux is full of quirks to support noncompliant hardware/firmware).
>
> While this may work for a dedicated driver I don't think it is that
> easy when we are talking about a standard interface, except if you are
> going to maintain a separate HCI layer at the driver to intercept the
> traffic this will cause a lot of regression to users unaware to the
> fact, and it is not like you can't get rid of it, just plug an
> external Bluetooth dongle that behaves properly.
>
>> While I agree with Hector here that they won't even talk to us it's
>> sometimes possible to figure out what exactly they were thinking with
>> their reserved values. Apple provides "Additional Tools for XCode" wh=
ich
>> include their "PacketLogger" which contains most of their vendor
>> specific hacks with a human readable explanation. I wasn't able to ge=
nerate
>> this specific event with my hardware here but I was able to inject a =
custom
>> event into their trace format and then load it and see how it's decod=
ed.
>>
>> From a very brief look it appears that they AND Primary_PHY/Secondary=
_PHY with
>> 0x1f to decode it and then support all values defined in the bluetooth
>> spec, i.e. "no packets", "LE 1M", "LE 2M" and "LE coded". No idea wha=
t the
>> higher bits mean though since they are ignored and don't seem to be d=
ecoded.
>
> Yeah, I think I saw something like that not long ago, we might need
> yet another quirk to deal with that though.

Agreed. We had a similar situation with this very same broken hardware w=
hen I
originally upstreamed the driver:
Apple and/or Broadcom decided to use the upper event type bits inside LE=
 Extended
Advertising Reports for the channel on which the frame has been received=
 [1].
I originally proposed a quick to drop these reserved bits but we then la=
ter
decided to just do it unconditionally [2].


[1] https://lore.kernel.org/linux-bluetooth/20220801103633.27772-4-sven@=
svenpeter.dev/
[2] https://lore.kernel.org/linux-bluetooth/220ab728-ed5b-415d-ab15-47a7=
153e8e5c@www.fastmail.com/


Best,


Sven
