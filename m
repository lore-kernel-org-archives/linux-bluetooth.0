Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8B202997
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303423; cv=none; b=It7IoMVappxakKo2MjgTtn4G+TWld+HZxMDRAx6sKqrGENa/q6w8ghymw1UkcTsKssHVIgiH1DvH5HB4ZJfMzYqB1x4mkewQn4Y8/oXJw0pBPSxTamlKC+5rsp1RKWP1GwUkzo/EQ1lFAugZwYKWrS/bTf2JsU4BZl+NOXeXxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303423; c=relaxed/simple;
	bh=0sUtFsV4bfzsw679dK5BbaYEZ5RY0tsxgA/8MkbjK7A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TlpHz+pOt9cnw7JKwHiXYEjT6+2EkKKgzlDpJulS77D1HA9c2yMILruDZj1Z8ktrvh6TLPaQjnAfSjcHKUrJvksYO5wpLvrkJTGwzFzpcmRa0F9WjSO0QH61l8rxQii43fYS/CbQQsDyLnAyqOHsTB5lyq569SydTfhcXL0gvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=UutpHSKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDRpB12h; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="UutpHSKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDRpB12h"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B887EEC008B;
	Wed, 20 May 2026 14:57:00 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 14:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779303420;
	 x=1779389820; bh=J8oUrwqJmr+c4l5Lo0Xsp3znZ8pTGaRbeVAjbiYiWQg=; b=
	UutpHSKbANvIhc9poQ8mFPqkwowInE7uVf4QckCLkLynPxXP4q+GslbqOHl0yTTN
	2SLurp9cc7qVllFoNf795SkjzD57sVao5rPUnli6NlPgOtccMUxPb/37DDCEhoFz
	GUHfitTyDsWH2IQUpYRDWV1kRUQX37rpVJjeCwEHIu2vOWehfmzCiDXGFas7qGro
	l6gkX+2C/CBiL6h+Do7woRFIEemqe5WB+yQvNH7ix0aQLDYwRxg73X8Nfy7q5bAW
	6wQoLp32wLcz0jAOrgRZtBk1/rxkt1yDr4I2ynrWJ41knm1e0soNPwCUbLQUqo/f
	RYiZX+/L+RnahxWYhPmDlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779303420; x=
	1779389820; bh=J8oUrwqJmr+c4l5Lo0Xsp3znZ8pTGaRbeVAjbiYiWQg=; b=M
	DRpB12hNBkJeJGOSizfF/ACIdxcQhCW0Tslh/nuZrncaY7L4MToQ32Z3krHkoAJG
	F2YeL0cFx1R6JnPXAZE6/tTIFn+5Z3RPUVutYcVmlOqvIcB358cqPZNloyz1NUJB
	bii4y0bZ10MKG91b+DlONl1H4wfbbX3Cwyziv60e6oAd3BEcGzYC0j5Jtpd8h0qZ
	P8rxQL35wG7CBAPvyuDaXkir7VTKLt2tnOp/rHhDzw0jYekPwfQS7CWj7XS91uJB
	bmB6giImlaxt1o//ZzjkWef08y6A/OWM6rOjRlKSMXMrHVlZ3UDC/udysmojKqnK
	814M+fNu6wQVIbZPqeMNQ==
X-ME-Sender: <xms:_AMOamIL_K8fZdJR12mXNtnvJ5Fvqpgoid6qZWaOjf2X5dSq7T7d4w>
    <xme:_AMOao-4cba0PmC8BY-zYp0eWyP5R8l35YDgT7Hx8C8Iy0K7lNOZaRw5AcJUuy7SQ
    r3-ic-l9QKeBISesjcFS27p_9Xz5u6vabjFpUUKL__g7F8PvE7QvnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfuihifvghiucgkhhgrnhhgfdcuoehoshhssehfohhurhguihhmrd
    ighiiiqeenucggtffrrghtthgvrhhnpeehveffieefgfffgeffheejffdugffhgedtgfeh
    ieeiffeuleefffdugfejleehvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhsshesfhho
    uhhrughimhdrgiihiidpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtthhopehsrghfrgdrkhgrrh
    grkhhushesshgvtghunhhnihigrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgv
    thhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_AMOauyX6K0FjgNi46JCwv3eSZADJv_ywWW3fz2RKMrF3xrJLwYKag>
    <xmx:_AMOaoHFNpNwfKvyLJ1EUrtSij8QkmN441zdaeqXOaP-KOTbewNFgw>
    <xmx:_AMOaqwz8YG_V6f75EZj1cCW4gHTwrCnP2nIcv9MNXxs9Lt3Db0XyA>
    <xmx:_AMOahvWRSFZLTgAsTPzoALpUfLAIxlT8DsZYY43OPRgiGpkdIcZAA>
    <xmx:_AMOascrhEo_LqkfvNsX5wvI3VV1RpdBplQt-tURdFBOCbM0Torr43rs>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F50C2160098; Wed, 20 May 2026 14:57:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJzjvcnhimxZ
Date: Wed, 20 May 2026 14:56:41 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 =?UTF-8?Q?Safa_Karaku=C5=9F?= <safa.karakus@secunnix.com>
Message-Id: <ab53262f-329d-4c00-9575-8b3a8e96093a@app.fastmail.com>
In-Reply-To: 
 <CABBYNZ+6bP78+_m_ehhif3xCXxn2ZLQE2q5O3X_03mU8=_T5uA@mail.gmail.com>
References: <20260520163859.2859782-1-oss@fourdim.xyz>
 <CABBYNZ+6bP78+_m_ehhif3xCXxn2ZLQE2q5O3X_03mU8=_T5uA@mail.gmail.com>
Subject: Re: [PATCH v7 RESEND 0/1] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_sock_cleanup_listen()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, May 20, 2026, at 2:26 PM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, May 20, 2026 at 12:39=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
>>
>> Hi Bluetooth maintainers,
>>
>> A public patch covering the same UAF in l2cap_sock_cleanup_listen() w=
as posted to linux-bluetooth on April 28
>> by Safa Karaku=C5=9F. v4 is here:
>>
>> https://lore.kernel.org/linux-bluetooth/AS8P250MB079109F82C16BEDC4F9F=
E584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM/
>>
>> I thanks for Safa's report and patch. I already reported the same iss=
ue privately to the maintainers in
>> April 11th. The public patch breaks the embargo and I would like to r=
esend my patch here.
>>
>> Safa's v4 closes the sk-lifetime hole (sock_hold inside bt_accept_deq=
ueue) but does not take conn->lock around
>> l2cap_chan_close, so the conn->chan_l list-corruption race in my repo=
rt is still open after it.
>
> Are your changes on top of Safa's though? That seems a lot cleaner to =
be honest.
>

My patch is not on the top of Safa's. The diff looks quite different.
I reported both the sk-lifetime UAF and the conn->chan_l list-corruption=
 race
privately to the maintainers on April 11th. And patch shortly on April 1=
2th.

>> My patch closes both: it drops the parent sk_lock, acquires conn->loc=
k =E2=86=92 chan->lock in the established order
>> to serialize the chan_l mutation, and re-takes the parent sk_lock bef=
ore returning.
>
> I rather have each issue handled separately though.
>

I am happy to handle that separately.

Could I get a Reported-by on Safa's patch since I reported the underlyin=
g issue before the public post?

Reported-by: Siwei Zhang <oss@fourdim.xyz>

I'll send the conn->lock patch (drains accept queue to local list, drops=
 parent sk_lock, acquires conn->lock -> chan_lock in
established order) as another patch shortly.

>> Crash stack and C reproducers are available upon request, only for th=
e maintainers.
>>
>> Maintainers can also refer to the email thread [Bug] KASAN: slab-use-=
after-free Read in l2cap_security_cfm
>> sent to security@kernel.org on April 11th for more details.
>>
>> Detailed Timeline:
>>
>> April 11th: I privately reported the issue to the maintainers and sec=
urity@kernel.org
>> April 12th: Patch v1
>> April 13th: Patch v2
>> April 13th: Patch v3
>> April 14th: Patch v4
>> April 15th: Patch v5
>> May 2nd: Patch v6
>> May 2nd: Patch v7
>> May 20th: Resend v7 with a cover letter
>>
>> Best,
>> Siwei
>>
>> Siwei Zhang (1):
>>   Bluetooth: L2CAP: Fix slab-use-after-free in
>>     l2cap_sock_cleanup_listen()
>>
>>  net/bluetooth/l2cap_sock.c | 57 ++++++++++++++++++++++++++++++++----=
--
>>  1 file changed, 49 insertions(+), 8 deletions(-)
>>
>> --
>> 2.54.0
>>
>
>
> --=20
> Luiz Augusto von Dentz

Best,
Siwei

