Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAD31D759
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111657; cv=none; b=q/5aQ/dwkDTO+nuB3oTiYxnIxMTv7WmpLq8ajPuzmxX4Mm4XnyvnInPHzyP9DO+FNfxuez2daivDyGAnFtjxAqJ/aSQkJX8OIa3UabXb1RZH/TtsSRQUF2ORDbKHbHqv0ZZyEyStoBGHHYH7XhcuSr1KyINyJ02S1x9gGGWcDyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111657; c=relaxed/simple;
	bh=YFrWtm73TFjEF5FjiAWYwGSgsn/qEesaG5qoVh5J7co=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A+AYTQpAd4WQz0hQU4c2jPGRI2wvlNQqNDnzr/4yC6axcR9lDUwqcsIeRd5fJc63WBErJIBwuOdRNUDbS5rEWWx5IO8Sol+ZkqiaJVXK90kQjP7GanfoGZ9o8S3gbtVr3qAbhW8F8tTO8Y1ZqVBumFWNn4IgXKcowecdGAWl5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=W2uhYPzR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LggSjXYv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="W2uhYPzR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LggSjXYv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9755D1D000D5;
	Wed, 10 Jun 2026 13:14:14 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 13:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781111654;
	 x=1781198054; bh=+rQoHJjvp6Zd5edAX72czaR+Cns2FPBzov5T5G2rDsY=; b=
	W2uhYPzR7F2BDvuNAt67qGGt6nozzAFf2dfsOX9yNeCD8i+QJfbPMd8rSYaToCQ0
	T+F3v+qWA2eZIZM2DYxcjsiwRFEA4gO0KiRWC9JG0wdsObPw2LfJGuO8qJG+YDnt
	PA3J1ptQldCm5CXqIZNB+2xD8S27qjABjhhyCpX2oRkDs4AI/jIbVdtUVDyJilJL
	Zzxv4iQ7dTYttv1Iu+P9eAW5a2yg1qGH8i4v/15CodUfC9h8ZsTSMcdDxGBNtOzd
	j6Vrv6ksmpXjIjN9rWJ/pBDNLTUgrkFGMvIgolRBN8Ybyz1qEzYJYTdP+9DeBcHy
	VRuo+a7G5l7J0ZB51Ww9mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781111654; x=
	1781198054; bh=+rQoHJjvp6Zd5edAX72czaR+Cns2FPBzov5T5G2rDsY=; b=L
	ggSjXYvBccgUx+gCFSuBERx6WoscNJA1zR01WsWUn8pUI3dTWxp1JXKPQx7O/ep9
	eEoWkTG5twM6T41o2n8c5jxYlCobLdJP80MHPItBk7xCBet5MLuqpY0+XyDD8ugQ
	nNPfUKRXCOe8tigywNACKeG71xpr3uzsDG83Vun8q5w2IVhjx7+2WORtbcRQcDZf
	TUv4hxMi5+1mU+G+nmKkTyDj46qLJmiHLSnlmThJNLH6Am4bA47Z4My0Vk8L+nxy
	mB5LAlf/DgDeVGHbaVSGxH+MOgbKScNv6S9VIRV2YLLMObKpFpzpotDP+XRSonNn
	BvoHs8koLuez9daXc7JOQ==
X-ME-Sender: <xms:Zpspal9NQlu35bHg6_jTXNSj3unx0Hg_7p9m-C313a5uQ6l6dlP7IQ>
    <xme:Zpspakgf4f0d8r8ksTbXX2XZRSvfs6Q1rsS9OOgg2Wonw6V9zREHw5kN2PdHSIWOU
    tQNEa-Walliz-h7wZkLQR71sznKuBb_yK8sr-T2Bef7kLRz7u0kUfY>
X-ME-Proxy-Cause: dmFkZTFh+QybQzFHWw+O3mIGo12PfGYvwkYA1Z+b58tv9jHNUXmmm0Ouq0sJyFfCdpZzCY
    KNGt0SuONL+NVauWudqFsPZxxJZ9bnuvwdhfV6yWzKtcDh+lrD0LQ8FBbKsfN1XAHhwBKk
    I2GZVtWuRQH7fK4sbaP8BGd/bvGK7Qm7Tyt32GNhtg9mxeJpl9IJmFAgDr952pxUgKxO3a
    OmId6N5KxvAyrhiHnQSMcUzkexp4P1T1gBpLMifu813YKJD+WdST8nzdtdr0w8giEcZmzz
    Y0NHxrO8MW3yv3yyUUYdJTgxzfzk5bFMonNIDK1NEhGZ6aKXSYXljaCG2zzWR5cdQnuDLY
    13lkq2fCMRmt5GMhNZWhgYXLKOjT4jBPpV5geI9wGW+m9I5XMyXqBvw+nEFbaajFF9aonk
    Z1IJae+TEjcevByYzIB1AhihUwYjrYgTw+1FoqiH7VjckadrzyLuWA/1LjL7PmU0vr0RA2
    sDaVmD8lEN+5FycpPeXSbsUpyaWuH0cg0p4lSVzbxOAEksNUJxvBBhoIeD7XmLssXBBduW
    +PyMjjxtHXXPkrRkcAbO7wLqG7Qy9f/zW1nT6Z3CR9V7KzWC+OEKjXigry/gRnU2PSNfzn
    +mfSiNIf9rt8MSe01RsTB9/tdkMllQs7hOwBIj5II8+3CAb4s3FI4cPqdwiA
X-ME-Proxy: <xmx:ZpspakrKxlrzeo3i72SNCiOJ3LCaQakSCE5G9MGEulnWJfJZxAFn5Q>
    <xmx:ZpspaonmdBCoXj6LNF39Ugs4KAW7RSzMIOryUHuBo7ZPnAXiRJ_YGA>
    <xmx:Zpspagy890YET1sLw1LM7kgfZEo9wX-PThLHOGV0VVVtiaaC2RMe6A>
    <xmx:ZpspaonEFSureosQbCICD_Yan2vYs67-FVu49AsQmWIEmpIe9xlnew>
    <xmx:ZpspapTJU4lxRit9J3RM8EBbsg2D4-2vgwLdK671B1y0NrkW0MnT53Ls>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4DB55216008A; Wed, 10 Jun 2026 13:14:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ark7h5MHViQF
Date: Wed, 10 Jun 2026 13:13:52 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <40f6b1b0-d3ec-4f62-979b-1d6da19cf76b@app.fastmail.com>
In-Reply-To: 
 <CABBYNZKuKSs938J6Pt_gqJzj4s1vz3wTGzJsfowS7H_n6mPd4A@mail.gmail.com>
References: <20260603150835.3539963-1-oss@fourdim.xyz>
 <20260603150835.3539963-2-oss@fourdim.xyz>
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
 <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com>
 <13e2aafc-8a4c-4c00-b38a-b09deda670ce@app.fastmail.com>
 <CABBYNZK2tzGe9CKcwBb7SxGzE94Y04z_VvaoFLoQPJ=3m=MUgQ@mail.gmail.com>
 <3cf8c12c-10c3-4ba8-9037-7e41a820d23d@app.fastmail.com>
 <CABBYNZJsyPU5wr4T32Ej9Vj0=Nco=PjtQn4aiC=NqUGbgP3zBw@mail.gmail.com>
 <e9720437-0673-4428-9be2-203404e5cbec@app.fastmail.com>
 <CABBYNZKuKSs938J6Pt_gqJzj4s1vz3wTGzJsfowS7H_n6mPd4A@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Jun 10, 2026, at 1:12 PM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, Jun 10, 2026 at 1:03=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>>
>> On Wed, Jun 10, 2026, at 12:59 PM, Luiz Augusto von Dentz wrote:
>> > Hi Siwei,
>> >
>> > On Wed, Jun 10, 2026 at 12:33=E2=80=AFPM Siwei Zhang <oss@fourdim.x=
yz> wrote:
>> >>
>> >>
>> >>
>> >> On Wed, Jun 10, 2026, at 11:57 AM, Luiz Augusto von Dentz wrote:
>> >> > Hi Siwei,
>> >> >
>> >> > On Mon, Jun 8, 2026 at 9:29=E2=80=AFAM Siwei Zhang <oss@fourdim.=
xyz> wrote:
>> >> >>
>> >> >> Hi Luiz,
>> >> >>
>> >> >> On Thu, Jun 4, 2026, at 11:52 AM, Siwei Zhang wrote:
>> >> >> > Hi Luiz,
>> >> >> >
>> >> >> > On Wed, Jun 3, 2026, at 2:17 PM, Luiz Augusto von Dentz wrote:
>> >> >> >> Hi Siwei,
>> >> >> >>
>> >> >> >> On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fou=
rdim.xyz> wrote:
>> >> >> >>>
>> >> >> >>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan =
after
>> >> >> >>> release_sock(parent). Once the parent lock is released, the=
 child
>> >> >> >>> socket sk can be freed by another task.
>> >> >> >>>
>> >> >> >>> Allocate the channel outside the func to prevent this.
>> >> >> >>>
>> >> >> >>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage=
 from l2cap_core.c")
>> >> >> >>> Cc: stable@kernel.org
>> >> >> >>> Assisted-by: Claude:claude-opus-4-8
>> >> >> >>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> >> >> >>> ---
>> >> >> >>>  include/net/bluetooth/l2cap.h | 10 +++--
>> >> >> >>>  net/bluetooth/6lowpan.c       | 31 +++++++------
>> >> >> >>>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
>> >> >> >>>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++--=
------------
>> >> >> >>>  net/bluetooth/smp.c           | 17 ++++---
>> >> >> >>>  5 files changed, 113 insertions(+), 69 deletions(-)
>> >> >> >>>
>> >> >> >>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bl=
uetooth/l2cap.h
>> >> >> >>> index e0a1f2293679..7f5e4647f6e0 100644
>> >> >> >>> --- a/include/net/bluetooth/l2cap.h
>> >> >> >>> +++ b/include/net/bluetooth/l2cap.h
>> >> >> >>> @@ -620,7 +620,9 @@ struct l2cap_chan {
>> >> >> >>>  struct l2cap_ops {
>> >> >> >>>         char                    *name;
>> >> >> >>>
>> >> >> >>> -       struct l2cap_chan       *(*new_connection) (struct =
l2cap_chan *chan);
>> >> >> >>> +       int                     (*new_connection)(struct l2=
cap_conn *conn,
>> >> >> >>> +                                                 struct l2=
cap_chan *chan,
>> >> >> >>> +                                                 struct l2=
cap_chan *new_chan);
>> >> >> >>>         int                     (*recv) (struct l2cap_chan =
* chan,
>> >> >> >>>                                          struct sk_buff *sk=
b);
>> >> >> >>>         void                    (*teardown) (struct l2cap_c=
han *chan, int err);
>> >> >> >>> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct =
l2cap_chan *chan, __u16 seq)
>> >> >> >>>         return (seq + 1) % (chan->tx_win_max + 1);
>> >> >> >>>  }
>> >> >> >>>
>> >> >> >>> -static inline struct l2cap_chan *l2cap_chan_no_new_connect=
ion(struct l2cap_chan *chan)
>> >> >> >>> +static inline int l2cap_chan_no_new_connection(struct l2ca=
p_conn *conn,
>> >> >> >>> +                                              struct l2cap=
_chan *chan,
>> >> >> >>> +                                              struct l2cap=
_chan *new_chan)
>> >> >> >>>  {
>> >> >> >>> -       return NULL;
>> >> >> >>> +       return -EOPNOTSUPP;
>> >> >> >>>  }
>> >> >> >>>
>> >> >> >>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *ch=
an, struct sk_buff *skb)
>> >> >> >>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpa=
n.c
>> >> >> >>> index cb1e329d66fd..94863af97a44 100644
>> >> >> >>> --- a/net/bluetooth/6lowpan.c
>> >> >> >>> +++ b/net/bluetooth/6lowpan.c
>> >> >> >>> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_c=
onn *hcon)
>> >> >> >>>         return true;
>> >> >> >>>  }
>> >> >> >>>
>> >> >> >>> +static void chan_init(struct l2cap_chan *chan)
>> >> >> >>> +{
>> >> >> >>> +       l2cap_chan_set_defaults(chan);
>> >> >> >>> +
>> >> >> >>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> >> >> >>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> >> >> >>> +       chan->imtu =3D 1280;
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>>  static struct l2cap_chan *chan_create(void)
>> >> >> >>>  {
>> >> >> >>>         struct l2cap_chan *chan;
>> >> >> >>> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(=
void)
>> >> >> >>>         if (!chan)
>> >> >> >>>                 return NULL;
>> >> >> >>>
>> >> >> >>> -       l2cap_chan_set_defaults(chan);
>> >> >> >>> -
>> >> >> >>> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> >> >> >>> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> >> >> >>> -       chan->imtu =3D 1280;
>> >> >> >>> +       chan_init(chan);
>> >> >> >>>
>> >> >> >>>         return chan;
>> >> >> >>>  }
>> >> >> >>> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(stru=
ct l2cap_chan *chan)
>> >> >> >>>         ifup(dev->netdev);
>> >> >> >>>  }
>> >> >> >>>
>> >> >> >>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l=
2cap_chan *pchan)
>> >> >> >>> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
>> >> >> >>> +                                  struct l2cap_chan *pchan,
>> >> >> >>> +                                  struct l2cap_chan *chan)
>> >> >> >>>  {
>> >> >> >>> -       struct l2cap_chan *chan;
>> >> >> >>> -
>> >> >> >>> -       chan =3D chan_create();
>> >> >> >>> -       if (!chan)
>> >> >> >>> -               return NULL;
>> >> >> >>> -
>> >> >> >>> +       chan_init(chan);
>> >>
>> >> ref1: chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED; set
>> >> in chan_init.
>> >>
>> >> >> >>>         chan->ops =3D pchan->ops;
>> >> >> >>>
>> >> >> >>> +       /* Take the conn list reference; see l2cap_new_conn=
ection(). */
>> >> >> >>> +       __l2cap_chan_add(conn, chan);
>> >> >> >>> +
>> >> >> >>>         BT_DBG("chan %p pchan %p", chan, pchan);
>> >> >> >>>
>> >> >> >>> -       return chan;
>> >> >> >>> +       return 0;
>> >> >> >>>  }
>> >> >> >>>
>> >> >> >>>  static void unregister_dev(struct lowpan_btle_dev *dev)
>> >> >> >>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2c=
ap_core.c
>> >> >> >>> index c4ccfbda9d78..62acf90837fb 100644
>> >> >> >>> --- a/net/bluetooth/l2cap_core.c
>> >> >> >>> +++ b/net/bluetooth/l2cap_core.c
>> >> >> >>> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(=
struct l2cap_conn *conn,
>> >> >> >>>         return 0;
>> >> >> >>>  }
>> >> >> >>>
>> >> >> >>> +/* Allocate and initialise a channel for an incoming conne=
ction.
>> >> >> >>> + *
>> >> >> >>> + * ->new_connection() initialises the channel and links it=
 into @conn with
>> >> >> >>> + * __l2cap_chan_add(). The l2cap_chan_create() reference b=
ecomes the one owned
>> >> >> >>> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp =
or peer->chan) and is
>> >> >> >>> + * released by its teardown callback; the conn list refere=
nce is released by
>> >> >> >>> + * l2cap_chan_del().
>> >> >> >>> + */
>> >> >> >>> +static struct l2cap_chan *l2cap_new_connection(struct l2ca=
p_conn *conn,
>> >> >> >>> +                                              struct l2cap=
_chan *pchan)
>> >> >> >>> +{
>> >> >> >>> +       struct l2cap_chan *chan;
>> >> >> >>> +
>> >> >> >>> +       chan =3D l2cap_chan_create();
>> >> >> >>> +       if (!chan)
>> >> >> >>> +               return NULL;
>> >> >> >>> +
>> >> >> >>> +       if (pchan->ops->new_connection(conn, pchan, chan) <=
 0) {
>> >> >> >>> +               l2cap_chan_put(chan);
>> >> >> >>> +               return NULL;
>> >> >> >>> +       }
>> >> >> >>
>> >> >> >> I don't quite get why we can't just place __l2cap_chan_add h=
ere
>> >> >> >> instead of having it called by new_connection callbacks?
>> >> >> >>
>> >> >> >
>> >> >> > It's specifically the l2cap_sock_new_connection_cb() case - t=
he very
>> >> >> > use-after-free this patch fixes. The __l2cap_chan_add() has t=
o happen while
>> >> >> > the parent lock is still held, and only the callback holds th=
at lock.
>> >> >> >
>> >> >> > The reference counting on the new child chan starts at one re=
f,
>> >> >> > owned by the new socket:
>> >> >> >
>> >> >> >       /* l2cap_new_connection() */
>> >> >> >       chan =3D l2cap_chan_create();             /* refcount =3D=
 1 */
>> >> >> >       if (!chan)
>> >> >> >               return NULL;
>> >> >> >
>> >> >> >       pchan->ops->new_connection(conn, pchan, chan);
>> >> >> >
>> >> >> > and inside the socket callback:
>> >> >> >
>> >> >> >       /* l2cap_sock_new_connection_cb() */
>> >> >> >       lock_sock(parent);
>> >> >> >       ...
>> >> >> >       sk =3D l2cap_sock_alloc(..., new_chan);   /* sk owns th=
e chan_create ref */
>> >> >> >       ...
>> >> >> >       l2cap_sock_init(sk, parent);
>> >> >> >
>> >> >> >       __l2cap_chan_add(conn, new_chan);       /* (A) conn lis=
t takes a ref */
>> >> >> >       bt_accept_enqueue(parent, sk, false);   /* (B) sk now o=
n accept queue */
>> >> >> >
>> >> >> >       release_sock(parent);                   /* (C) parent l=
ock dropped */
>> >> >> >       return 0;
>> >> >> >
>> >> >> > The moment we hit (C), sk is reachable through the parent's a=
ccept queue, so
>> >> >> > another task can grab and tear it down:
>> >> >> >
>> >> >> >       accept() -> l2cap_sock_kill() -> l2cap_sock_put_chan()
>> >> >> >               chan->data =3D NULL;
>> >> >> >               l2cap_chan_put(chan);           /* drops the sk=
's chan ref */
>> >> >> >
>> >> >> > If __l2cap_chan_add() at (A) hadn't already taken the conn li=
st reference,
>> >> >> > that put would drop the last ref and free new_chan. Control t=
hen returns up
>> >> >> > to l2cap_new_connection(), which hands the now-freed chan bac=
k to
>> >> >> > l2cap_connect():
>> >> >> >
>> >> >> >       /* l2cap_connect() - runs after the callback returns */
>> >> >> >       chan =3D l2cap_new_connection(conn, pchan);
>> >> >> >       if (!chan)
>> >> >> >               goto response;
>> >> >> >       ...
>> >> >> >       bacpy(&chan->src, &conn->hcon->src);    /* <-- UAF on f=
reed chan */
>> >> >> >       chan->psm  =3D psm;
>> >> >> >       chan->dcid =3D scid;
>> >> >> >
>> >> >> > The conn list reference taken at (A), before (C), is what kee=
ps new_chan
>> >> >> > alive across the release_sock() window so l2cap_connect() can=
 keep using it.
>> >> >> >
>> >> >> > So __l2cap_chan_add() can't move out to l2cap_new_connection(=
): by the time
>> >> >> > the callback returns, the parent lock is already dropped and =
chan may already
>> >> >> > be freed - which is exactly the race. It has to be taken insi=
de the callback,
>> >> >> > under the parent lock, before the socket is exposed.
>> >> >
>> >> > If you do after l2cap_new_connection, yes, but what if you do be=
fore
>> >> > you call ->new_connect:
>> >> >
>> >> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_co=
re.c
>> >> > index 3991c179b98f..cd864f400985 100644
>> >> > --- a/net/bluetooth/l2cap_core.c
>> >> > +++ b/net/bluetooth/l2cap_core.c
>> >> > @@ -4027,8 +4027,10 @@ static struct l2cap_chan
>> >> > *l2cap_new_connection(struct l2cap_conn *conn,
>> >> >         if (!chan)
>> >> >                 return NULL;
>> >> >
>> >> > +       __l2cap_chan_add(conn, chan);
>> >> > +
>> >> >         if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
>> >> > -               l2cap_chan_put(chan);
>> >> > +               l2cap_chan_del(chan, 0);
>> >> >                 return NULL;
>> >> >         }
>> >> >
>> >> > This means we have to call l2cap_chan_del if new_connection fail=
s, but
>> >> > we can eliminate other functions having to call __l2cap_chan_add=
 with
>> >> > this. If the issue is then having l2cap_chan_del called concurre=
ntly,
>> >> > we can add a l2cap_chan_hold; actually, we may need a reference =
anyway
>> >> > since sk can be released and call l2cap_chan_del, releasing both
>> >> > references.
>> >> >
>> >>
>> >> In:
>> >>
>> >> void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *=
chan)
>> >> {
>> >>         ...
>> >>         switch (chan->chan_type) {
>> >>         case L2CAP_CHAN_CONN_ORIENTED:
>> >>                 ...
>> >>                 break;
>> >>         case L2CAP_CHAN_CONN_LESS:
>> >>                 ...
>> >>                 break;
>> >>         case L2CAP_CHAN_FIXED:
>> >>                 ...
>> >>                 break;
>> >>         default:
>> >>                 ...
>> >>         }
>> >> }
>> >>
>> >> Apparently it depends on chan->chan_type and it is set by ref1.
>> >> It is only set in cb function.
>> >
>> > Ok, this probably needs fixing in 6lowpan. These defaults should co=
me
>> > from the parent channel, similar to how it's done in l2cap_sock_ini=
t.
>> > Perhaps we should promote that logic to l2cap_chan_set_defaults
>> > passing pchan so it can initialize the channel before calling
>> > __l2cap_chan_add.
>>
>> I can fix that in a separate patch.
>> Could you please merge it first?
>
> Merge it first, and then rework the order? Not sure what is the
> benefit of doing that, it is a somewhat substatial change either way
> so I don't think it will make it much easier to lets say backport.
>

Will do a patch v10.

>> Best,
>> Siwei
>
>
>
> --=20
> Luiz Augusto von Dentz

Best,
Siwei
