Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C135B137
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307742; cv=none; b=JhZr3wM9+ZQoikDJPJv5AVERmHAU6bz3SQnpuCNq6UVpjnilKTh0zSGVnYk9GXWPl2Kmd2yZLLIo7QXXMNf1Qmbnj3tAYVbXjmvWPnmyAPyzfoa1FeEOTySDymsIZ1iU74vH64Vr/c8lHeqCqaQD6RVx89hBLTRdcb6OjQ9KeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307742; c=relaxed/simple;
	bh=exGjNPqYYJ3jrhQTvLfvobk21zTIgbHi9Tcb1ExqRSI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BijxJyJ8C4xV3mMQu4qE/JiGAWUpFmJhJ1mWpEDGuxUl8Hvz+Xdu3MMhWUOWptgsifzH49FByI2WOYE1+O1ZpglVeyOtB/LJbFNxrd91a9Xo5rFh4DBkD4pNsv/P/NOFwe+/YopndA7V23qlkoeJz6NOs9QaatUxF1QLjZrJiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=HX7ZMYYM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zut6VuCI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="HX7ZMYYM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zut6VuCI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 06C32EC022F;
	Wed, 20 May 2026 16:09:00 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 16:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779307740;
	 x=1779394140; bh=zuHDXpz6BoTvxSR4YSeRZ7PkEgI36YEthWI3tqz9who=; b=
	HX7ZMYYMNavwJ4k9xeHVEhduab/p22/+aNomvfauADvp+kgkYKBCZBFz+5B3O8r6
	MZjHZvMlm2vtlNvEar7epBUHP9VusNFbJR57snDfAUcKESj2sD1ghDRhjNXxsS4b
	YLYRVSL4v2C1DOVGmlGOhBi8ieUZK/K4V9faj2qzA8mymia1QyFeAkPdUPUc2fND
	31MdkuTcJTOSOoJA0xSiT/o9bnJhZTcM1Yz+fQSaPEzR8IU2r+bpypA4U8GODDcK
	g3Y7udYLUQB6Utu2YUSy0rd/p4Tls7d7Pt+mRukr11NeaZ8iVaBbxJnPb2QZQzcB
	PcKlAsj6wxRS/8sekpam7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779307740; x=
	1779394140; bh=zuHDXpz6BoTvxSR4YSeRZ7PkEgI36YEthWI3tqz9who=; b=Z
	ut6VuCITx9Hy/eG3lqjvBijfm5nEJ367JEToLSbWcS3hRgAMs65VEqcQ7FHGNX89
	k6U8k9T/qz0eMpvR0XXz1EqUChon6rQwqBczdveZxyX7ABCiLTCebVb6zipd6VJN
	f5WoEXzlvj8Y9b+WWZm7gfRPdQgkiKsBsw/KGgb2ZwUB5JnHxV8vWwq+IUVN2rM7
	6A38jjzNVr/Hc2MBnSn/PFBuj6YowixwCz+jgy5H+ZODci2u2tCPYZc4k4nE7C++
	rQAjE+mxjH9/muGV3uQdo9CZT3rpUKrsU/BIPTNNsieAocPLKiyEMkIsSC6w+lA6
	C8jJijXOsEWVhVy2jCB9g==
X-ME-Sender: <xms:2xQOauliXQu95bu1m8FFrTLglD3zbgmmzxW7g3YUh48Ww_ov9AzO7w>
    <xme:2xQOagpH-9Wc2VbwAqxb11AOcNenVL6HeYkudN50Z8pFWA7uLhr_lX3VqTbVw8k3Y
    4-39djnOs7xZGv8rLRFuQgQ39tpoB2-rze3AyPkfCZAxdZUuOksWzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2xQOaoPsWdLfjNgOErN5TXNqcP3BSDyqFrydjYq2aFIoV-o0t4bJSg>
    <xmx:2xQOasxzq9YRYP6Pme395WQM7dD70nuMKWR0zJUqjbGX4a200ui-5Q>
    <xmx:2xQOapvLWsYmFvlIK4_-HLw339tslwRiivZ_Fse8SkOKmOv3V0wA5w>
    <xmx:2xQOat5AEHO567FHwgMdQ85KEycey7aENYdTTEXs91AsB9WH7_CIbQ>
    <xmx:3BQOauwlseZoHUIieftqCAkUoAhR5aWRolK0Mr4rp3gmmmo5ShZJI4-i>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BEEDD216008A; Wed, 20 May 2026 16:08:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJzjvcnhimxZ
Date: Wed, 20 May 2026 16:08:40 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 =?UTF-8?Q?Safa_Karaku=C5=9F?= <safa.karakus@secunnix.com>
Message-Id: <2d9113fc-499a-4f6c-9072-92071e69ae85@app.fastmail.com>
In-Reply-To: 
 <CABBYNZLWU4gzaLytLBD7V4fnFWyjXB4312tB2q00VRDTT6jb7g@mail.gmail.com>
References: <20260520163859.2859782-1-oss@fourdim.xyz>
 <CABBYNZ+6bP78+_m_ehhif3xCXxn2ZLQE2q5O3X_03mU8=_T5uA@mail.gmail.com>
 <ab53262f-329d-4c00-9575-8b3a8e96093a@app.fastmail.com>
 <CABBYNZLWU4gzaLytLBD7V4fnFWyjXB4312tB2q00VRDTT6jb7g@mail.gmail.com>
Subject: Re: [PATCH v7 RESEND 0/1] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_sock_cleanup_listen()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, May 20, 2026, at 3:40 PM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, May 20, 2026 at 2:57=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>> Hi Luiz,
>>
>> On Wed, May 20, 2026, at 2:26 PM, Luiz Augusto von Dentz wrote:
>> > Hi Siwei,
>> >
>> > On Wed, May 20, 2026 at 12:39=E2=80=AFPM Siwei Zhang <oss@fourdim.x=
yz> wrote:
>> >>
>> >> Hi Bluetooth maintainers,
>> >>
>> >> A public patch covering the same UAF in l2cap_sock_cleanup_listen(=
) was posted to linux-bluetooth on April 28
>> >> by Safa Karaku=C5=9F. v4 is here:
>> >>
>> >> https://lore.kernel.org/linux-bluetooth/AS8P250MB079109F82C16BEDC4=
F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM/
>> >>
>> >> I thanks for Safa's report and patch. I already reported the same =
issue privately to the maintainers in
>> >> April 11th. The public patch breaks the embargo and I would like t=
o resend my patch here.
>> >>
>> >> Safa's v4 closes the sk-lifetime hole (sock_hold inside bt_accept_=
dequeue) but does not take conn->lock around
>> >> l2cap_chan_close, so the conn->chan_l list-corruption race in my r=
eport is still open after it.
>> >
>> > Are your changes on top of Safa's though? That seems a lot cleaner =
to be honest.
>> >
>>
>> My patch is not on the top of Safa's. The diff looks quite different.
>> I reported both the sk-lifetime UAF and the conn->chan_l list-corrupt=
ion race
>> privately to the maintainers on April 11th. And patch shortly on Apri=
l 12th.
>
> I'm afraid it doesn't matter if you reported first or not, Safa's fix
> is much easier to understand. However, there still seems to be an
> issue of calling l2cap_chan_del without holding the conn->lock.
>
>> >> My patch closes both: it drops the parent sk_lock, acquires conn->=
lock =E2=86=92 chan->lock in the established order
>> >> to serialize the chan_l mutation, and re-takes the parent sk_lock =
before returning.
>> >
>> > I rather have each issue handled separately though.
>> >
>>
>> I am happy to handle that separately.
>>
>> Could I get a Reported-by on Safa's patch since I reported the underl=
ying issue before the public post?
>>
>> Reported-by: Siwei Zhang <oss@fourdim.xyz>
>
> You can do it yourself, just respond to the thread. Bonus points if
> you add a Tested-by if it actually fixes part of the problem reported.
>
>> I'll send the conn->lock patch (drains accept queue to local list, dr=
ops parent sk_lock, acquires conn->lock -> chan_lock in
>> established order) as another patch shortly.
>
> Don't quite like that solution though, we should be dropping locks we
> didn't acquire on the same scope, besides it seem that was doing a lot
> of malabarism, perhaps we could just schedule l2cap_chan_timeout with
> something like this:
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 4ed745a9c2cf..413b1c63602a 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1529,8 +1529,11 @@ static void l2cap_sock_cleanup_listen(struct
> sock *parent)
>                        state_to_string(chan->state));
>
>                 l2cap_chan_lock(chan);
> -               __clear_chan_timer(chan);
> -               l2cap_chan_close(chan, ECONNRESET);
> +               /* Since we cannot call l2cap_chan_close() without
> +                * chan->conn, schedule its timer to trigger the close=
 and
> +                * cleanup of this channel.
> +                */
> +               __set_chan_timer(chan, 0);
>                 /* l2cap_conn_del() may already have killed this socket
>                  * (it sets SOCK_DEAD); skip the duplicate to avoid a
>                  * double sock_put()/l2cap_chan_put().
>
> Or perhaps it needs to be conditional to having chan->conn since that
> indicates l2cap_chan_del has not run yet, making it safe to use
> __set_chan_timer.

Thanks, that is much cleaner.=20

PATCH sent to https://lore.kernel.org/linux-bluetooth/20260520200611.303=
3410-1-oss@fourdim.xyz/

Best,
Siwei
