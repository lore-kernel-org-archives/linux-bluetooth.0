Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946633ADA4
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147750; cv=none; b=Yz0iO0Li5nZ6KmdlVQZA2oUrqx/Y1j5fHGhY6VfTMoo4mVtRmyq71NWJjCOwZrp0nLvd1/h/0pBvAvNkbDsOeP41ZT+Ef8C1Cdf8uw9rrO4jb/jJMkjjLQE1BG5g7RGNj5/fIJCJtpDKGpjFR9RESRySz5rZTDbYRJjTwyy/gfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147750; c=relaxed/simple;
	bh=1Wvlk+rOZdO31sAUtHse3AOtJ0h51gYd926y0cMxSCo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a9NcSfCvmp1nhu4w9EhIdWv4F4YfayhX0X9ebiI1mha0+yJgJogVmiL8GuCcYemnqpCm1SwoPxWpbqwO17yVGNE6xyALjh2Llf/yhurs3E587hg5/4ObMz+jQLJHX1QRfxMcGJWvyKGJdA0ylOiVRPAeCGLQKowgNSiiowuztQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=kUalRUne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0NGJz+F; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="kUalRUne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0NGJz+F"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34DDC1400075;
	Mon, 18 May 2026 19:42:27 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 19:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779147747;
	 x=1779234147; bh=k25K3KxdA/vIaxpflEyRpI2wgSlzmAuiUsdPw4xQTIc=; b=
	kUalRUneMj4liOPXsFudrp0iW/iYiZekfd+F9WkmBJKOBzE4rONLAfO0yYjQANvY
	/UUI2xLGafjy6PGmnWN1C8IT8AHsMIJbBjKgDewpG46EgSyDlO6iDJCGK0WYSU1q
	bzljkRDN/BSxs135bgYRsAN0Rf33J0rZ33CuGmrQPMLWXkQzJiMk1A+QBQDgEC6I
	tHr1eqbEuKN0em6GEpX47rpsYmtbUeQk1ioM4Gy84ovGm4+LCOIIJ+JV0sAxoVy3
	cJNaoDBhVNhffgr+SqNCn4u0iFKPKO4GnUBTgJcABqdfKi+stRUh0MFYxv0j+RaP
	6et4kGne37yy48UlPqLg+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779147747; x=
	1779234147; bh=k25K3KxdA/vIaxpflEyRpI2wgSlzmAuiUsdPw4xQTIc=; b=Z
	0NGJz+FtD8HUNvGo+N9jvjR9hGz9z+lYpS9t0meP2Gk2g1/FgnMQK70Q7yHi9rJm
	0Q4+vRgPPKk4DtTun1a14WBu+eCJAr5kCt8Ac+SGqXhyzt6M1sNpOXQO8Uqk2Ns/
	joN6rtLhXmkr432WM765sz1v1TrAvCKrJeTFBElRasUI+wd+VgonLx1yISfJpOqG
	Jv+NRjeNfwaDRQe/xzicFUkQ3/fDdO/HS59wXPjSeUagvdBhyfqVm4lQCMsNXh+a
	iQC7xyCgb2ngEribW3QuIZTsxTcCIXaz33XmOem9ZtBi8GvpqBuIcVtOG+eT+ajZ
	fN5Sha1Ty3z7Dj9uk7mlQ==
X-ME-Sender: <xms:4qMLag0cLQEASxep4bslr0ztKjlMXUIhJNoOfwV2hcfJXUWobFLYPA>
    <xme:4qMLal5z8wSgbpMgbDXKaUuqgJXBRslpJKfehIRslYBT-zhDHAWHO0cNZZTGTdX7h
    W0RiC8Hz5let2xlZTgWom8fqE6Cb6IXYoQfmlhH93URqNkbMEuGig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfuihifvghiucgkhhgrnhhgfdcuoehoshhssehfohhurhguihhmrd
    ighiiiqeenucggtffrrghtthgvrhhnpeeuveeuleefheetgfevkeegteetffejgfeigfdt
    uedtveetieehleefjeehteekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehoshhssehfohhurhguihhmrdighiiipdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhiiidruggvnhhtiiesgh
    hmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:4qMLajxkAuk15c1EV2UieOUvqOx22PwmG4BKk0vi9tTywCUyJhhjSw>
    <xmx:4qMLajAZLbTq1LdFxIp0FZcWHJw6Dq6LRSoaqxEmKAkxZZ7MQIF1IA>
    <xmx:4qMLagZVdn6ax3zCD_3pJkjXSpDWqKpF633t7WwLncxW5HFmEQO9sw>
    <xmx:4qMLargY38gb9xUz1XRLUBb4y9bq79OoNf6Me_ZvCuDMZnSjRRYglQ>
    <xmx:46MLaglBRCnQxvTYWlbNmuCH60_GePKk9VkaTJNeD8lcNTe6X8sxrvrB>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DDB0C216008B; Mon, 18 May 2026 19:42:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6I4skvcp-pg
Date: Mon, 18 May 2026 19:42:05 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Message-Id: <42a499de-8d74-4e77-a514-14b06cb0ea2a@app.fastmail.com>
In-Reply-To: 
 <CABBYNZL8zf+mfnLcs+X+9S2Kd=0-nSN6roywWk4wz=Bcmzqa4A@mail.gmail.com>
References: <20260511170929.709823-1-oss@fourdim.xyz>
 <20260511170929.709823-2-oss@fourdim.xyz>
 <CABBYNZL3UVcogeJGiOzEcyGi3TCGf_pCCz+Vd32K3Li0GmPVwQ@mail.gmail.com>
 <558a354c-d2b6-4c7c-97cf-606753902b85@app.fastmail.com>
 <CABBYNZL8zf+mfnLcs+X+9S2Kd=0-nSN6roywWk4wz=Bcmzqa4A@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, May 18, 2026, at 5:57 PM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Thu, May 14, 2026 at 8:23=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>> Hi Luiz,
>>
>> On Mon, May 11, 2026, at 3:17 PM, Luiz Augusto von Dentz wrote:
>> > Hi,
>> >
>> > On Mon, May 11, 2026 at 1:09=E2=80=AFPM Siwei Zhang <oss@fourdim.xy=
z> wrote:
>> >>
>> >> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
>> >> release_sock(parent). Once the parent lock is released, the child
>> >> socket sk can be freed by another task.
>> >>
>> >> Save the channel pointer into a local variable while the parent lo=
ck
>> >> is still held to prevent this.
>> >>
>> >> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l=
2cap_core.c")
>> >> Cc: stable@kernel.org
>> >> Assisted-by: Claude:claude-opus-4-7
>> >> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> >> ---
>> >>  net/bluetooth/6lowpan.c    |  5 +++++
>> >>  net/bluetooth/l2cap_core.c | 12 ++++++++++++
>> >>  net/bluetooth/l2cap_sock.c | 13 ++++++++++++-
>> >>  net/bluetooth/smp.c        |  5 +++++
>> >>  4 files changed, 34 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> >> index 23a229ab6a33..71c1c04b61e5 100644
>> >> --- a/net/bluetooth/6lowpan.c
>> >> +++ b/net/bluetooth/6lowpan.c
>> >> @@ -755,6 +755,11 @@ static inline struct l2cap_chan *chan_new_con=
n_cb(struct l2cap_chan *pchan)
>> >>
>> >>         BT_DBG("chan %p pchan %p", chan, pchan);
>> >>
>> >> +       /* Match the put that the caller of ops->new_connection() =
performs
>> >> +        * once it is done with the returned channel pointer.
>> >> +        */
>> >> +       l2cap_chan_hold(chan);
>> >> +
>> >>         return chan;
>> >>  }
>> >>
>> >> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core=
.c
>> >> index 7701528f1167..0f6c3c651207 100644
>> >> --- a/net/bluetooth/l2cap_core.c
>> >> +++ b/net/bluetooth/l2cap_core.c
>> >> @@ -4071,6 +4071,9 @@ static void l2cap_connect(struct l2cap_conn =
*conn, struct l2cap_cmd_hdr *cmd,
>> >>
>> >>         __l2cap_chan_add(conn, chan);
>> >>
>> >> +       /* Drop the ops->new_connection() ref; conn list now pins =
chan. */
>> >> +       l2cap_chan_put(chan);
>> >> +
>> >>         dcid =3D chan->scid;
>> >>
>> >>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>> >> @@ -4970,6 +4973,9 @@ static int l2cap_le_connect_req(struct l2cap=
_conn *conn,
>> >>
>> >>         __l2cap_chan_add(conn, chan);
>> >>
>> >> +       /* Drop the ops->new_connection() ref; conn list now pins =
chan. */
>> >> +       l2cap_chan_put(chan);
>> >> +
>> >>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
>> >>
>> >>         dcid =3D chan->scid;
>> >> @@ -5194,6 +5200,9 @@ static inline int l2cap_ecred_conn_req(struc=
t l2cap_conn *conn,
>> >>
>> >>                 __l2cap_chan_add(conn, chan);
>> >>
>> >> +               /* Drop the ops->new_connection() ref; conn list n=
ow pins chan. */
>> >> +               l2cap_chan_put(chan);
>> >> +
>> >>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits)=
);
>> >>
>> >>                 /* Init response */
>> >> @@ -7407,6 +7416,9 @@ static void l2cap_connect_cfm(struct hci_con=
n *hcon, u8 status)
>> >>                         chan->dst_type =3D dst_type;
>> >>
>> >>                         __l2cap_chan_add(conn, chan);
>> >> +
>> >> +                       /* Drop the ops->new_connection() ref; con=
n list now pins chan. */
>> >> +                       l2cap_chan_put(chan);
>> >>                 }
>> >>
>> >>                 l2cap_chan_unlock(pchan);
>> >> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock=
.c
>> >> index cf590a67d364..295c79cf5cf3 100644
>> >> --- a/net/bluetooth/l2cap_sock.c
>> >> +++ b/net/bluetooth/l2cap_sock.c
>> >> @@ -1497,6 +1497,7 @@ static void l2cap_sock_cleanup_listen(struct=
 sock *parent)
>> >>  static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2c=
ap_chan *chan)
>> >>  {
>> >>         struct sock *sk, *parent =3D chan->data;
>> >> +       struct l2cap_chan *child_chan;
>> >>
>> >>         if (!parent)
>> >>                 return NULL;
>> >> @@ -1523,9 +1524,19 @@ static struct l2cap_chan *l2cap_sock_new_co=
nnection_cb(struct l2cap_chan *chan)
>> >>
>> >>         bt_accept_enqueue(parent, sk, false);
>> >>
>> >> +       child_chan =3D l2cap_pi(sk)->chan;
>> >> +
>> >> +       /* Pin the channel for the caller. Once release_sock(paren=
t) returns,
>> >> +        * userspace can accept(2) and immediately close(2) the ch=
ild socket,
>> >> +        * which would drop the socket's references on the channel=
 and free
>> >> +        * it before the caller (e.g. l2cap_connect_req()) is done=
 using the
>> >> +        * returned pointer. The matching put is the caller's resp=
onsibility.
>> >> +        */
>> >> +       l2cap_chan_hold(child_chan);
>> >
>> > The entire problem might be solvable by not removing `list_add` from
>> > `l2cap_create_chan`. This way, it only allocates but does not attach
>> > to global_l until __l2cap_chan_add is called which then handles the
>> > addition.
>>
>> Could you please clarify what is "not removing `list_add` from
>> `l2cap_chan_create`"? I am not touching that part of code nor removing
>> the `list_add`. Do you want me to correspond the `chan` lifetime to `=
chan_list`?
>>
>> > Alternatively, we could allocate it first, given the
>> > circular dependency involving `l2cap_core`.c->l2cap_sock.c)
>> > new_connection -> l2cap_chan_create(l2cap_sock.c->l2cap_core.c) whi=
ch
>>
>> This will change the signature of `l2cap_ops.new_connection`, which w=
ill be a large
>> refactoring across multiple files.
>>
>> Signature will be changed from
>> `struct l2cap_chan      *(*new_connection) (struct l2cap_chan *chan);`
>> to
>> `void (*new_connection) (struct l2cap_chan *chan, struct l2cap_chan *=
new_chan)`
>> Do you want me to this in this patch or in the follow up patch?
>> If in this patch, I will drop the backport cc to stable.
>>
>> > makes the code rather hard to follow.
>> >
>>
>> I totally understand this will create a maintenance problem. I create=
d this patch
>> mainly because it can be easily to be backported to the stable branch=
es and it
>> is the safest fix (though ugly). I can send a follow up patch for thi=
s to refactor it
>> according to your suggestions.
>
> I don't think adding a new argument would be complicated. This
> argument could replace the current void return, and although it will
> affect a couple more places, it shouldn't be hard to backport if it
> really needs to be backported to begin with.
>

OK, I will do that.
Also, could you please check emails titled with
[PATCH v7] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_sock_clean=
up_listen()
I sent it to you privately with CC to security@kernel.org.

>>
>> >>         release_sock(parent);
>> >>
>> >> -       return l2cap_pi(sk)->chan;
>> >> +       return child_chan;
>> >>  }
>> >>
>> >>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_=
buff *skb)
>> >> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>> >> index 1739c1989dbd..9796c3030434 100644
>> >> --- a/net/bluetooth/smp.c
>> >> +++ b/net/bluetooth/smp.c
>> >> @@ -3231,6 +3231,11 @@ static inline struct l2cap_chan *smp_new_co=
nn_cb(struct l2cap_chan *pchan)
>> >>
>> >>         BT_DBG("created chan %p", chan);
>> >>
>> >> +       /* Match the put that the caller of ops->new_connection() =
performs
>> >> +        * once it is done with the returned channel pointer.
>> >> +        */
>> >> +       l2cap_chan_hold(chan);
>> >> +
>> >>         return chan;
>> >>  }
>> >>
>> >> --
>> >> 2.54.0
>> >>
>> >
>> >
>> > --
>> > Luiz Augusto von Dentz
>>
>> Best,
>> Siwei
>
>
>
> --=20
> Luiz Augusto von Dentz

Best,
Siwei
