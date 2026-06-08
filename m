Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656C437268F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 13:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925351; cv=none; b=L3dBOAGASz/TCBX09t5eSiGaJzFD2nkOIIstUvA6kGmpPM6h7wQ8JqhQZMJvE3oD/C8QmytfuCFLDMBLVBNiIQ90kw27lFAH0x5SdBXb+wPdhNn4R71xRg7/J4SkNKyW3WoM9trPZInjDPk+J/ZQzSJ9oQAk5EuH4KigA7ke8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925351; c=relaxed/simple;
	bh=EIM/cIgKrCZkGYGfbOqLpVkMHH2ZTSLMiSpQm4MX4wM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a12fbQONt+27OPN48ZkTOEFt364xX2mb+9bT5z0/Qes3O61Ju7wtV2lV5Hk6H0bGZfKYBF3qb0xMtn1yXFHYgkCmTKcd4OqLGQnZoqJ8Uwd+B/7uY6rW5zgfH82/H7xN4BxA86SoiQlFlhAUsvzNVH/y+135jhAuy5b7/rmvLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=DSCy4VVj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNoJ7S0l; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="DSCy4VVj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNoJ7S0l"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7ECE14002E8;
	Mon,  8 Jun 2026 09:29:05 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Mon, 08 Jun 2026 09:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780925345;
	 x=1781011745; bh=FMINp+x/DK8ElBYRI4Xol3k+a/uhBdsKvxbxM4VISr0=; b=
	DSCy4VVjk33QJNxV8DioM1zau+S1mwsRIZWG6393+fiyxjEzc9VhEDdsWccC4pGJ
	klj+jfl0kpjTsjHMVDCH1lPSZlWhDvZdzuPy8qLeHeiueH5WdzlgeBQ5Vu1Q81Yy
	vPpB0tVA9USJkMq7IG64OX5j452ypD5MPnRRddi8/sgmYSzMQQr3vCU4fM/klmed
	+3Wrkaf8swEsfIHw0wx632vMdtlgsLHQqiZSydAQhSvbBKKjonXNJAnpM3Uvmrea
	sHZsGqOC7qPoa/EuORg3Tu85twOh5Irp2OrbjViFFwcoWSL6Vreu9zp8tVG2xLHI
	TTK2rJ2bWNERDMxs9SbznQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780925345; x=
	1781011745; bh=FMINp+x/DK8ElBYRI4Xol3k+a/uhBdsKvxbxM4VISr0=; b=T
	NoJ7S0lAAxs+exO+dtGUXLPzhVOTd7J8RUw/9n/xN11OfIxH7oK3MWmYM2cH0xIn
	rplyav4Jv1qwTp5eZuCp2fFr9X1P6qd/Zu0DWAAKA/kAHVhwOPVnwuqvuc6t03mt
	O+3eVBL0TKJO45KDorbMWwxw3zs16xFW3zNV6z5GP6j3DubfVl29vKAVTHHUDnU7
	nJiLbIQbJDNoLnCpHuQers4de00u1psuk7KzXDmi+Zy6+Y3g3+U6lR8VCf7jRCbJ
	B+xVNXKfi1DnYx7Y/1hXTiA/Ynv95uwCikJNGycr8PEKLevEwHvPP17nbMneu2vx
	MgQFLs9B6Ob6kqTiP+Xvg==
X-ME-Sender: <xms:ocMmaq4R2pEg76Cao-2nbsTeDzDP0BC0bKLNYNvdkxcPHydtwgv-aQ>
    <xme:ocMmauuushG_KJUyDX1sBNyrBHNxXE66_rqrHMyQTm_3Jfzw-CUhtKE62UZGJfYSF
    V5Ul1NJm98SixHCjh7EBAtJYAKf6PuTPGZOU1udszZScCbHI_ymEg>
X-ME-Proxy-Cause: dmFkZTF2cdfp/Mce2JC+HsKhk1VMkr/u+uF2KDzyq0l/eKP328ZR285ZkCgCz1MoSC08yG
    gu/9EverNOYK/yk/m4iC5C1U9akUy+VwlAWR9bLUnJhUc0H2o9aEQl0Puh1SW+Gid+vimF
    19BFcLCRCOzgb0AQL0+9M3juYU1/NFp/1NdXjWMnLmQWEKRMrm+GvBwlnbttNj3Kx87G9l
    9HoaIGgluZp7J3jIsf8Jhq3N2FzBIC3u2NqQOhg7yM09Ce7tf/++nuWxYMMAWycLRj5MWz
    4waUoABfWEJlowkb+sFa8r2cNM0gr1n77k4t5McD00+NuyZJ2ZapTqM9q+Gc7CiaJFd+k+
    BnQ7fFXt3c8oJE+4FxOwMhFyTqU0I4C1HQfZtiq+833LocPkrpUuJG3ne0QpX8kP1qRg3X
    Nvoy59c96NvIg2nl3t4GpiNN9U0UQQCH+L0DsRkhoP2Ii7BwSfmSDhuYj2yTQaoLstsYUC
    Z/QtrtalJaiY5cqNxZKS4r+fHjZRGotWJpw9PAOkRaAMZnBH6oSsJ9N/rzK21uG6DJMvDo
    qLH+JeOgefHrlbjkNzqAJP6ywrWjUtf6otYLPl404/5/h74McUW3Z57trRFXBu1Y9dTAlI
    4j2h5AZjBVXRHceC1LGwFtQHw2pUpSkSKrjPd6PZ6RoDNLODYwukcFoHyAyQ
X-ME-Proxy: <xmx:ocMmallApPqU8oA5Ws3dNy3zT_b12bsec-RXiY7nKmCS9nh9JzuLdg>
    <xmx:ocMmauykpfFO2Lb_a5353y0fyDkGbOoX96fCPC-6_J7JuYq5smDZgQ>
    <xmx:ocMmajO-CVEAnABxibrzxMIwYgyiPOlWvWVYzPUMvVOKR2XjP1aM4g>
    <xmx:ocMmaiS5o3Bgga7V6pGi92z0jUUA6MMtGYMpGi499NWVFY_hPKqg3w>
    <xmx:ocMmavciVUEBcb1zF6tFtupJGoPrnnSRU_2VBn3DNnv18Nuy8lXbgOBP>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 80021216008A; Mon,  8 Jun 2026 09:29:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ark7h5MHViQF
Date: Mon, 08 Jun 2026 09:28:45 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <13e2aafc-8a4c-4c00-b38a-b09deda670ce@app.fastmail.com>
In-Reply-To: <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com>
References: <20260603150835.3539963-1-oss@fourdim.xyz>
 <20260603150835.3539963-2-oss@fourdim.xyz>
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
 <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, Jun 4, 2026, at 11:52 AM, Siwei Zhang wrote:
> Hi Luiz,
>
> On Wed, Jun 3, 2026, at 2:17 PM, Luiz Augusto von Dentz wrote:
>> Hi Siwei,
>>
>> On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
>>>
>>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
>>> release_sock(parent). Once the parent lock is released, the child
>>> socket sk can be freed by another task.
>>>
>>> Allocate the channel outside the func to prevent this.
>>>
>>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2c=
ap_core.c")
>>> Cc: stable@kernel.org
>>> Assisted-by: Claude:claude-opus-4-8
>>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>>> ---
>>>  include/net/bluetooth/l2cap.h | 10 +++--
>>>  net/bluetooth/6lowpan.c       | 31 +++++++------
>>>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
>>>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++-----------=
---
>>>  net/bluetooth/smp.c           | 17 ++++---
>>>  5 files changed, 113 insertions(+), 69 deletions(-)
>>>
>>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l=
2cap.h
>>> index e0a1f2293679..7f5e4647f6e0 100644
>>> --- a/include/net/bluetooth/l2cap.h
>>> +++ b/include/net/bluetooth/l2cap.h
>>> @@ -620,7 +620,9 @@ struct l2cap_chan {
>>>  struct l2cap_ops {
>>>         char                    *name;
>>>
>>> -       struct l2cap_chan       *(*new_connection) (struct l2cap_cha=
n *chan);
>>> +       int                     (*new_connection)(struct l2cap_conn =
*conn,
>>> +                                                 struct l2cap_chan =
*chan,
>>> +                                                 struct l2cap_chan =
*new_chan);
>>>         int                     (*recv) (struct l2cap_chan * chan,
>>>                                          struct sk_buff *skb);
>>>         void                    (*teardown) (struct l2cap_chan *chan=
, int err);
>>> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2cap_cha=
n *chan, __u16 seq)
>>>         return (seq + 1) % (chan->tx_win_max + 1);
>>>  }
>>>
>>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struc=
t l2cap_chan *chan)
>>> +static inline int l2cap_chan_no_new_connection(struct l2cap_conn *c=
onn,
>>> +                                              struct l2cap_chan *ch=
an,
>>> +                                              struct l2cap_chan *ne=
w_chan)
>>>  {
>>> -       return NULL;
>>> +       return -EOPNOTSUPP;
>>>  }
>>>
>>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struc=
t sk_buff *skb)
>>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>>> index cb1e329d66fd..94863af97a44 100644
>>> --- a/net/bluetooth/6lowpan.c
>>> +++ b/net/bluetooth/6lowpan.c
>>> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
>>>         return true;
>>>  }
>>>
>>> +static void chan_init(struct l2cap_chan *chan)
>>> +{
>>> +       l2cap_chan_set_defaults(chan);
>>> +
>>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>>> +       chan->imtu =3D 1280;
>>> +}
>>> +
>>>  static struct l2cap_chan *chan_create(void)
>>>  {
>>>         struct l2cap_chan *chan;
>>> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void)
>>>         if (!chan)
>>>                 return NULL;
>>>
>>> -       l2cap_chan_set_defaults(chan);
>>> -
>>> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>>> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>>> -       chan->imtu =3D 1280;
>>> +       chan_init(chan);
>>>
>>>         return chan;
>>>  }
>>> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct l2cap_=
chan *chan)
>>>         ifup(dev->netdev);
>>>  }
>>>
>>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan=
 *pchan)
>>> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
>>> +                                  struct l2cap_chan *pchan,
>>> +                                  struct l2cap_chan *chan)
>>>  {
>>> -       struct l2cap_chan *chan;
>>> -
>>> -       chan =3D chan_create();
>>> -       if (!chan)
>>> -               return NULL;
>>> -
>>> +       chan_init(chan);
>>>         chan->ops =3D pchan->ops;
>>>
>>> +       /* Take the conn list reference; see l2cap_new_connection().=
 */
>>> +       __l2cap_chan_add(conn, chan);
>>> +
>>>         BT_DBG("chan %p pchan %p", chan, pchan);
>>>
>>> -       return chan;
>>> +       return 0;
>>>  }
>>>
>>>  static void unregister_dev(struct lowpan_btle_dev *dev)
>>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>>> index c4ccfbda9d78..62acf90837fb 100644
>>> --- a/net/bluetooth/l2cap_core.c
>>> +++ b/net/bluetooth/l2cap_core.c
>>> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(struct l2=
cap_conn *conn,
>>>         return 0;
>>>  }
>>>
>>> +/* Allocate and initialise a channel for an incoming connection.
>>> + *
>>> + * ->new_connection() initialises the channel and links it into @co=
nn with
>>> + * __l2cap_chan_add(). The l2cap_chan_create() reference becomes th=
e one owned
>>> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or peer->=
chan) and is
>>> + * released by its teardown callback; the conn list reference is re=
leased by
>>> + * l2cap_chan_del().
>>> + */
>>> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *c=
onn,
>>> +                                              struct l2cap_chan *pc=
han)
>>> +{
>>> +       struct l2cap_chan *chan;
>>> +
>>> +       chan =3D l2cap_chan_create();
>>> +       if (!chan)
>>> +               return NULL;
>>> +
>>> +       if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
>>> +               l2cap_chan_put(chan);
>>> +               return NULL;
>>> +       }
>>
>> I don't quite get why we can't just place __l2cap_chan_add here
>> instead of having it called by new_connection callbacks?
>>
>
> It's specifically the l2cap_sock_new_connection_cb() case - the very
> use-after-free this patch fixes. The __l2cap_chan_add() has to happen =
while
> the parent lock is still held, and only the callback holds that lock.
>
> The reference counting on the new child chan starts at one ref,=20
> owned by the new socket:
>
> 	/* l2cap_new_connection() */
> 	chan =3D l2cap_chan_create();		/* refcount =3D 1 */
> 	if (!chan)
> 		return NULL;
>
> 	pchan->ops->new_connection(conn, pchan, chan);
>
> and inside the socket callback:
>
> 	/* l2cap_sock_new_connection_cb() */
> 	lock_sock(parent);
> 	...
> 	sk =3D l2cap_sock_alloc(..., new_chan);	/* sk owns the chan_create re=
f */
> 	...
> 	l2cap_sock_init(sk, parent);
>
> 	__l2cap_chan_add(conn, new_chan);	/* (A) conn list takes a ref */
> 	bt_accept_enqueue(parent, sk, false);	/* (B) sk now on accept queue */
>
> 	release_sock(parent);			/* (C) parent lock dropped */
> 	return 0;
>
> The moment we hit (C), sk is reachable through the parent's accept que=
ue, so
> another task can grab and tear it down:
>
> 	accept() -> l2cap_sock_kill() -> l2cap_sock_put_chan()
> 		chan->data =3D NULL;
> 		l2cap_chan_put(chan);		/* drops the sk's chan ref */
>
> If __l2cap_chan_add() at (A) hadn't already taken the conn list refere=
nce,
> that put would drop the last ref and free new_chan. Control then retur=
ns up
> to l2cap_new_connection(), which hands the now-freed chan back to
> l2cap_connect():
>
> 	/* l2cap_connect() - runs after the callback returns */
> 	chan =3D l2cap_new_connection(conn, pchan);
> 	if (!chan)
> 		goto response;
> 	...
> 	bacpy(&chan->src, &conn->hcon->src);	/* <-- UAF on freed chan */
> 	chan->psm  =3D psm;
> 	chan->dcid =3D scid;
>
> The conn list reference taken at (A), before (C), is what keeps new_ch=
an
> alive across the release_sock() window so l2cap_connect() can keep usi=
ng it.
>
> So __l2cap_chan_add() can't move out to l2cap_new_connection(): by the=
 time
> the callback returns, the parent lock is already dropped and chan may =
already
> be freed - which is exactly the race. It has to be taken inside the ca=
llback,
> under the parent lock, before the socket is exposed.
>
> The other callbacks (6lowpan, smp) have no equivalent lock-drop window.
>  I kept __l2cap_chan_add() inside all of the ->new_connection() callba=
cks
> just to keep the "callback links the channel into conn" contract unifo=
rm.
>

Could you please check this?
Just remind you in case you miss this.

>>> +
>>> +       return chan;
>>> +}
>>> +
>>>  static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd=
_hdr *cmd,
>>>                           u8 *data, u8 rsp_code)
>>>  {
>>> @@ -4053,7 +4078,7 @@ static void l2cap_connect(struct l2cap_conn *c=
onn, struct l2cap_cmd_hdr *cmd,
>>>                 goto response;
>>>         }
>>>
>>> -       chan =3D pchan->ops->new_connection(pchan);
>>> +       chan =3D l2cap_new_connection(conn, pchan);
>>>         if (!chan)
>>>                 goto response;
>>>
>>> @@ -4071,8 +4096,6 @@ static void l2cap_connect(struct l2cap_conn *c=
onn, struct l2cap_cmd_hdr *cmd,
>>>         chan->psm  =3D psm;
>>>         chan->dcid =3D scid;
>>>
>>> -       __l2cap_chan_add(conn, chan);
>>> -
>>>         dcid =3D chan->scid;
>>>
>>>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>>> @@ -4955,7 +4978,7 @@ static int l2cap_le_connect_req(struct l2cap_c=
onn *conn,
>>>                 goto response_unlock;
>>>         }
>>>
>>> -       chan =3D pchan->ops->new_connection(pchan);
>>> +       chan =3D l2cap_new_connection(conn, pchan);
>>>         if (!chan) {
>>>                 result =3D L2CAP_CR_LE_NO_MEM;
>>>                 goto response_unlock;
>>> @@ -4970,8 +4993,6 @@ static int l2cap_le_connect_req(struct l2cap_c=
onn *conn,
>>>         chan->omtu =3D mtu;
>>>         chan->remote_mps =3D mps;
>>>
>>> -       __l2cap_chan_add(conn, chan);
>>> -
>>>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
>>>
>>>         dcid =3D chan->scid;
>>> @@ -5179,7 +5200,7 @@ static inline int l2cap_ecred_conn_req(struct =
l2cap_conn *conn,
>>>                         continue;
>>>                 }
>>>
>>> -               chan =3D pchan->ops->new_connection(pchan);
>>> +               chan =3D l2cap_new_connection(conn, pchan);
>>>                 if (!chan) {
>>>                         result =3D L2CAP_CR_LE_NO_MEM;
>>>                         continue;
>>> @@ -5194,8 +5215,6 @@ static inline int l2cap_ecred_conn_req(struct =
l2cap_conn *conn,
>>>                 chan->omtu =3D mtu;
>>>                 chan->remote_mps =3D mps;
>>>
>>> -               __l2cap_chan_add(conn, chan);
>>> -
>>>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>>>
>>>                 /* Init response */
>>> @@ -7470,14 +7489,12 @@ static void l2cap_connect_cfm(struct hci_con=
n *hcon, u8 status)
>>>                         goto next;
>>>
>>>                 l2cap_chan_lock(pchan);
>>> -               chan =3D pchan->ops->new_connection(pchan);
>>> +               chan =3D l2cap_new_connection(conn, pchan);
>>>                 if (chan) {
>>>                         bacpy(&chan->src, &hcon->src);
>>>                         bacpy(&chan->dst, &hcon->dst);
>>>                         chan->src_type =3D bdaddr_src_type(hcon);
>>>                         chan->dst_type =3D dst_type;
>>> -
>>> -                       __l2cap_chan_add(conn, chan);
>>>                 }
>>>
>>>                 l2cap_chan_unlock(pchan);
>>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>>> index 025329636353..87f4c0db5c0c 100644
>>> --- a/net/bluetooth/l2cap_sock.c
>>> +++ b/net/bluetooth/l2cap_sock.c
>>> @@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list =3D {
>>>  static const struct proto_ops l2cap_sock_ops;
>>>  static void l2cap_sock_init(struct sock *sk, struct sock *parent);
>>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket=
 *sock,
>>> -                                    int proto, gfp_t prio, int kern=
);
>>> +                                    int proto, gfp_t prio, int kern,
>>> +                                    struct l2cap_chan *chan);
>>>  static void l2cap_sock_cleanup_listen(struct sock *parent);
>>>
>>>  bool l2cap_is_socket(struct socket *sock)
>>> @@ -1287,6 +1288,23 @@ static int l2cap_sock_recvmsg(struct socket *=
sock, struct msghdr *msg,
>>>         return err;
>>>  }
>>>
>>> +/* Release the sock's ref on chan and clear the pointer so that the=
 ref is
>>> + * dropped exactly once even if both l2cap_sock_kill() and
>>> + * l2cap_sock_destruct() run. Setting chan->data to NULL first stop=
s any other
>>> + * task from dereferencing the now-dead sock pointer.
>>> + */
>>> +static void l2cap_sock_put_chan(struct sock *sk)
>>> +{
>>> +       struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
>>> +
>>> +       if (!chan)
>>> +               return;
>>> +
>>> +       chan->data =3D NULL;
>>> +       l2cap_pi(sk)->chan =3D NULL;
>>> +       l2cap_chan_put(chan);
>>> +}
>>> +
>>>  /* Kill socket (only if zapped and orphan)
>>>   * Must be called on unlocked socket, with l2cap channel lock.
>>>   */
>>> @@ -1297,13 +1315,9 @@ static void l2cap_sock_kill(struct sock *sk)
>>>
>>>         BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
>>>
>>> -       /* Sock is dead, so set chan data to NULL, avoid other task =
use invalid
>>> -        * sock pointer.
>>> -        */
>>> -       l2cap_pi(sk)->chan->data =3D NULL;
>>> -       /* Kill poor orphan */
>>> +       l2cap_sock_put_chan(sk);
>>>
>>> -       l2cap_chan_put(l2cap_pi(sk)->chan);
>>> +       /* Kill poor orphan */
>>>         sock_set_flag(sk, SOCK_DEAD);
>>>         sock_put(sk);
>>>  }
>>> @@ -1546,12 +1560,14 @@ static void l2cap_sock_cleanup_listen(struct=
 sock *parent)
>>>         }
>>>  }
>>>
>>> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap=
_chan *chan)
>>> +static int l2cap_sock_new_connection_cb(struct l2cap_conn *conn,
>>> +                                       struct l2cap_chan *chan,
>>> +                                       struct l2cap_chan *new_chan)
>>>  {
>>>         struct sock *sk, *parent =3D chan->data;
>>>
>>>         if (!parent)
>>> -               return NULL;
>>> +               return -EINVAL;
>>>
>>>         lock_sock(parent);
>>>
>>> @@ -1559,25 +1575,33 @@ static struct l2cap_chan *l2cap_sock_new_con=
nection_cb(struct l2cap_chan *chan)
>>>         if (sk_acceptq_is_full(parent)) {
>>>                 BT_DBG("backlog full %d", parent->sk_ack_backlog);
>>>                 release_sock(parent);
>>> -               return NULL;
>>> +               return -ENOBUFS;
>>>         }
>>>
>>>         sk =3D l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CA=
P,
>>> -                             GFP_ATOMIC, 0);
>>> +                             GFP_ATOMIC, 0, new_chan);
>>>         if (!sk) {
>>>                 release_sock(parent);
>>> -               return NULL;
>>> -        }
>>> +               return -ENOMEM;
>>> +       }
>>>
>>>         bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
>>>
>>>         l2cap_sock_init(sk, parent);
>>>
>>> +       /* Link the channel into conn before exposing the new socket=
 via the
>>> +        * accept queue. Once release_sock() below drops the parent =
lock the
>>> +        * socket may be freed by another task, dropping its referen=
ce on
>>> +        * new_chan; the conn list reference taken here keeps new_ch=
an alive so
>>> +        * the caller can safely use it after ->new_connection() ret=
urns.
>>> +        */
>>> +       __l2cap_chan_add(conn, new_chan);
>>> +
>>>         bt_accept_enqueue(parent, sk, false);
>>>
>>>         release_sock(parent);
>>>
>>> -       return l2cap_pi(sk)->chan;
>>> +       return 0;
>>>  }
>>>
>>>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_bu=
ff *skb)
>>> @@ -1874,10 +1898,7 @@ static void l2cap_sock_destruct(struct sock *=
sk)
>>>
>>>         BT_DBG("sk %p", sk);
>>>
>>> -       if (l2cap_pi(sk)->chan) {
>>> -               l2cap_pi(sk)->chan->data =3D NULL;
>>> -               l2cap_chan_put(l2cap_pi(sk)->chan);
>>> -       }
>>> +       l2cap_sock_put_chan(sk);
>>>
>>>         list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_bu=
sy, list) {
>>>                 kfree_skb(rx_busy->skb);
>>> @@ -1978,10 +1999,10 @@ static struct proto l2cap_proto =3D {
>>>  };
>>>
>>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket=
 *sock,
>>> -                                    int proto, gfp_t prio, int kern)
>>> +                                    int proto, gfp_t prio, int kern,
>>> +                                    struct l2cap_chan *chan)
>>>  {
>>>         struct sock *sk;
>>> -       struct l2cap_chan *chan;
>>>
>>>         sk =3D bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, k=
ern);
>>>         if (!sk)
>>> @@ -1992,16 +2013,7 @@ static struct sock *l2cap_sock_alloc(struct n=
et *net, struct socket *sock,
>>>
>>>         INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
>>>
>>> -       chan =3D l2cap_chan_create();
>>> -       if (!chan) {
>>> -               sk_free(sk);
>>> -               if (sock)
>>> -                       sock->sk =3D NULL;
>>> -               return NULL;
>>> -       }
>>> -
>>> -       l2cap_chan_hold(chan);
>>> -
>>> +       /* The sock takes ownership of the caller's reference on cha=
n. */
>>>         l2cap_pi(sk)->chan =3D chan;
>>>
>>>         return sk;
>>> @@ -2011,6 +2023,7 @@ static int l2cap_sock_create(struct net *net, =
struct socket *sock, int protocol,
>>>                              int kern)
>>>  {
>>>         struct sock *sk;
>>> +       struct l2cap_chan *chan;
>>>
>>>         BT_DBG("sock %p", sock);
>>>
>>> @@ -2025,10 +2038,16 @@ static int l2cap_sock_create(struct net *net=
, struct socket *sock, int protocol,
>>>
>>>         sock->ops =3D &l2cap_sock_ops;
>>>
>>> -       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, ker=
n);
>>> -       if (!sk)
>>> +       chan =3D l2cap_chan_create();
>>> +       if (!chan)
>>>                 return -ENOMEM;
>>>
>>> +       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, ker=
n, chan);
>>> +       if (!sk) {
>>> +               l2cap_chan_put(chan);
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>>         l2cap_sock_init(sk, NULL);
>>>         bt_sock_link(&l2cap_sk_list, sk);
>>>         return 0;
>>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>>> index 1739c1989dbd..2d31c3c7bbc0 100644
>>> --- a/net/bluetooth/smp.c
>>> +++ b/net/bluetooth/smp.c
>>> @@ -3204,16 +3204,12 @@ static const struct l2cap_ops smp_chan_ops =3D=
 {
>>>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
>>>  };
>>>
>>> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan =
*pchan)
>>> +static inline int smp_new_conn_cb(struct l2cap_conn *conn,
>>> +                                 struct l2cap_chan *pchan,
>>> +                                 struct l2cap_chan *chan)
>>>  {
>>> -       struct l2cap_chan *chan;
>>> -
>>>         BT_DBG("pchan %p", pchan);
>>>
>>> -       chan =3D l2cap_chan_create();
>>> -       if (!chan)
>>> -               return NULL;
>>> -
>>>         chan->chan_type =3D pchan->chan_type;
>>>         chan->ops       =3D &smp_chan_ops;
>>>         chan->scid      =3D pchan->scid;
>>> @@ -3229,9 +3225,12 @@ static inline struct l2cap_chan *smp_new_conn=
_cb(struct l2cap_chan *pchan)
>>>          */
>>>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
>>>
>>> -       BT_DBG("created chan %p", chan);
>>> +       /* Take the conn list reference; see l2cap_new_connection().=
 */
>>> +       __l2cap_chan_add(conn, chan);
>>>
>>> -       return chan;
>>> +       BT_DBG("initialised chan %p", chan);
>>> +
>>> +       return 0;
>>>  }
>>>
>>>  static const struct l2cap_ops smp_root_chan_ops =3D {
>>> --
>>> 2.54.0
>>>
>>
>>
>> --=20
>> Luiz Augusto von Dentz
>
> Best,
> Siwei

Best,
Siwei
