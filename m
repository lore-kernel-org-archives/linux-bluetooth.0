Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E6222599
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761431; cv=none; b=FkoRoAHsyqYOz8osJkE3QiS8uVBWW6hNzeaQFGFXHbeFviKL2UcxOJ/y5F57Ahwhn7ARNn2VH2FWPKaqd1897nYMd9L80O3VS26oUUREA7PjDDb2FArdYjdXqIvYV3z9sYcV97EXNDNkE7LwVYTQIvNsQLjRbTxAM9RwlNhWHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761431; c=relaxed/simple;
	bh=tNvdWsz18BZFh8ioxhmzZXU/D+bZ3VXTlHfGNXch/5Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T+NdIsrC+6TkWuC5Oe+eF4wvaz+UCVSK+ululDYmSB5Z8xaCwcZrTNkDeuxt8U37j05nNZKIrhnWhoKgomHXebSz+b+0f6u5I8+4Ftju/571ZFm+0+EGSv3rBCgQn3cCEx6jL+4rrPuxZya3wdj0EiF0usA0uEyc6yFDJtqBRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=MS0kkfNu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tyJFFFUV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="MS0kkfNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tyJFFFUV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F72B14001B3;
	Thu, 14 May 2026 08:23:49 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Thu, 14 May 2026 08:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778761429;
	 x=1778847829; bh=7bnZCjp47BGViglBj9IDRiWSVkdlLJpSr2c/1nvAO1E=; b=
	MS0kkfNuIBVu9ZKChrrQ+9jarBGmESEn9HuWgK6ntJ5Tv8dRFG+5rAD4GZvsMa7a
	nxaCm1XAwru5Nnp/9DTz2+5PPxdHF/UBECPV9cmKaIjfOgWEojaYrNJ++KpxCRrN
	0acnvblVqRQYR85Y3qdRhY3MdBj3XiZxqtp7kVhLXBgQdcVl0WWTR0WFu7BjaRkw
	dUn9/MbI4htc5WD7/H7TxaG75+hvL2UAZFvEL/jhgUTeZhYp2WytW628XI5bNfZt
	ow3AvPD04c3GrAgNL4fT+ewa+VSz0T1K/nnFxr7JRQvqdIKx9Lt5xLqmnIpRg8bO
	Ebc3vJh7da1ByLFXZJhf7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778761429; x=
	1778847829; bh=7bnZCjp47BGViglBj9IDRiWSVkdlLJpSr2c/1nvAO1E=; b=t
	yJFFFUV/hwo3bVab2erXBfA99effzIQTNe3c/siyRBhCaz1Lgx2gv54td62YnLa0
	GVHOq2rDZxgEO6p5Ih0Ec2xcHK6cse17kQZfdIeaSvqKs3kWWQCiiO9m7UfTle82
	QNGuRyqPqFZKNnMNRg3mW54tQyyOXve/qrdYpkE1DM4LgC1mzt3YJ4rY/M2auKMc
	2BaAGCkfVziNFOdg2dVkjk8d0vh+KYoNsQoyiphzKRDJ96qlZuEzDhlY/vV7IL4y
	6gVBNwhN8nqT4uQ46gUqlgkI5K43+c7P91hLOOFBrf0JgCnY9pOsZfF9jn/eIosB
	KQmkr445txZHOqmt6R75w==
X-ME-Sender: <xms:1L4FauTwq66kMmA1t4ZOnjjuZ09azZGW-qypRnVSjOgszfqLcieHzw>
    <xme:1L4Fauk8YX8TKDZnK3DfS7t11VrW0L8cvaOZdXBKd8ESce7oK_7aq3dC_CBk7tbr5
    cxQP0bh72pQMWdsn8bt_N9kpm4ArLvJJX46XJ-TWD9mv8EqAFh6iIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejheduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1L4FahtwMJgEP6s77nsy9zlCT7bbyKXWL7t3h8ODpY3AjlPyq0KgXA>
    <xmx:1b4FaiOBBv39rBAOFL6UazxDQLmJHoT0cch_4V2N4lCj4v8LeNAMFg>
    <xmx:1b4Fan3pb2QizcDPNlgYc1iJUTpycQeQxQmlrvdhewoIb9nS9TkbYg>
    <xmx:1b4FamM5Ov8XvTqkyZVI6lBvlG_McDjTuPKngAOzYdc6gqvmJfIyog>
    <xmx:1b4FasigZu8Yi5PDKayVsQxmLfFg9lPBPdHnn5gOyPYlWquUeZa2nFCz>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E137E216008A; Thu, 14 May 2026 08:23:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6I4skvcp-pg
Date: Thu, 14 May 2026 08:23:27 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Message-Id: <558a354c-d2b6-4c7c-97cf-606753902b85@app.fastmail.com>
In-Reply-To: 
 <CABBYNZL3UVcogeJGiOzEcyGi3TCGf_pCCz+Vd32K3Li0GmPVwQ@mail.gmail.com>
References: <20260511170929.709823-1-oss@fourdim.xyz>
 <20260511170929.709823-2-oss@fourdim.xyz>
 <CABBYNZL3UVcogeJGiOzEcyGi3TCGf_pCCz+Vd32K3Li0GmPVwQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, May 11, 2026, at 3:17 PM, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Mon, May 11, 2026 at 1:09=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
>> release_sock(parent). Once the parent lock is released, the child
>> socket sk can be freed by another task.
>>
>> Save the channel pointer into a local variable while the parent lock
>> is still held to prevent this.
>>
>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2ca=
p_core.c")
>> Cc: stable@kernel.org
>> Assisted-by: Claude:claude-opus-4-7
>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> ---
>>  net/bluetooth/6lowpan.c    |  5 +++++
>>  net/bluetooth/l2cap_core.c | 12 ++++++++++++
>>  net/bluetooth/l2cap_sock.c | 13 ++++++++++++-
>>  net/bluetooth/smp.c        |  5 +++++
>>  4 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> index 23a229ab6a33..71c1c04b61e5 100644
>> --- a/net/bluetooth/6lowpan.c
>> +++ b/net/bluetooth/6lowpan.c
>> @@ -755,6 +755,11 @@ static inline struct l2cap_chan *chan_new_conn_c=
b(struct l2cap_chan *pchan)
>>
>>         BT_DBG("chan %p pchan %p", chan, pchan);
>>
>> +       /* Match the put that the caller of ops->new_connection() per=
forms
>> +        * once it is done with the returned channel pointer.
>> +        */
>> +       l2cap_chan_hold(chan);
>> +
>>         return chan;
>>  }
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 7701528f1167..0f6c3c651207 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -4071,6 +4071,9 @@ static void l2cap_connect(struct l2cap_conn *co=
nn, struct l2cap_cmd_hdr *cmd,
>>
>>         __l2cap_chan_add(conn, chan);
>>
>> +       /* Drop the ops->new_connection() ref; conn list now pins cha=
n. */
>> +       l2cap_chan_put(chan);
>> +
>>         dcid =3D chan->scid;
>>
>>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>> @@ -4970,6 +4973,9 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
>>
>>         __l2cap_chan_add(conn, chan);
>>
>> +       /* Drop the ops->new_connection() ref; conn list now pins cha=
n. */
>> +       l2cap_chan_put(chan);
>> +
>>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
>>
>>         dcid =3D chan->scid;
>> @@ -5194,6 +5200,9 @@ static inline int l2cap_ecred_conn_req(struct l=
2cap_conn *conn,
>>
>>                 __l2cap_chan_add(conn, chan);
>>
>> +               /* Drop the ops->new_connection() ref; conn list now =
pins chan. */
>> +               l2cap_chan_put(chan);
>> +
>>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>>
>>                 /* Init response */
>> @@ -7407,6 +7416,9 @@ static void l2cap_connect_cfm(struct hci_conn *=
hcon, u8 status)
>>                         chan->dst_type =3D dst_type;
>>
>>                         __l2cap_chan_add(conn, chan);
>> +
>> +                       /* Drop the ops->new_connection() ref; conn l=
ist now pins chan. */
>> +                       l2cap_chan_put(chan);
>>                 }
>>
>>                 l2cap_chan_unlock(pchan);
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index cf590a67d364..295c79cf5cf3 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -1497,6 +1497,7 @@ static void l2cap_sock_cleanup_listen(struct so=
ck *parent)
>>  static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_=
chan *chan)
>>  {
>>         struct sock *sk, *parent =3D chan->data;
>> +       struct l2cap_chan *child_chan;
>>
>>         if (!parent)
>>                 return NULL;
>> @@ -1523,9 +1524,19 @@ static struct l2cap_chan *l2cap_sock_new_conne=
ction_cb(struct l2cap_chan *chan)
>>
>>         bt_accept_enqueue(parent, sk, false);
>>
>> +       child_chan =3D l2cap_pi(sk)->chan;
>> +
>> +       /* Pin the channel for the caller. Once release_sock(parent) =
returns,
>> +        * userspace can accept(2) and immediately close(2) the child=
 socket,
>> +        * which would drop the socket's references on the channel an=
d free
>> +        * it before the caller (e.g. l2cap_connect_req()) is done us=
ing the
>> +        * returned pointer. The matching put is the caller's respons=
ibility.
>> +        */
>> +       l2cap_chan_hold(child_chan);
>
> The entire problem might be solvable by not removing `list_add` from
> `l2cap_create_chan`. This way, it only allocates but does not attach
> to global_l until __l2cap_chan_add is called which then handles the
> addition.

Could you please clarify what is "not removing `list_add` from
`l2cap_chan_create`"? I am not touching that part of code nor removing
the `list_add`. Do you want me to correspond the `chan` lifetime to `cha=
n_list`?

> Alternatively, we could allocate it first, given the
> circular dependency involving `l2cap_core`.c->l2cap_sock.c)
> new_connection -> l2cap_chan_create(l2cap_sock.c->l2cap_core.c) which

This will change the signature of `l2cap_ops.new_connection`, which will=
 be a large
refactoring across multiple files.

Signature will be changed from
`struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);`
to
`void (*new_connection) (struct l2cap_chan *chan, struct l2cap_chan *new=
_chan)`
Do you want me to this in this patch or in the follow up patch?
If in this patch, I will drop the backport cc to stable.

> makes the code rather hard to follow.
>

I totally understand this will create a maintenance problem. I created t=
his patch
mainly because it can be easily to be backported to the stable branches =
and it
is the safest fix (though ugly). I can send a follow up patch for this t=
o refactor it
according to your suggestions.

>>         release_sock(parent);
>>
>> -       return l2cap_pi(sk)->chan;
>> +       return child_chan;
>>  }
>>
>>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buf=
f *skb)
>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>> index 1739c1989dbd..9796c3030434 100644
>> --- a/net/bluetooth/smp.c
>> +++ b/net/bluetooth/smp.c
>> @@ -3231,6 +3231,11 @@ static inline struct l2cap_chan *smp_new_conn_=
cb(struct l2cap_chan *pchan)
>>
>>         BT_DBG("created chan %p", chan);
>>
>> +       /* Match the put that the caller of ops->new_connection() per=
forms
>> +        * once it is done with the returned channel pointer.
>> +        */
>> +       l2cap_chan_hold(chan);
>> +
>>         return chan;
>>  }
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
