Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC93451C6
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110983; cv=none; b=sgDc+VST7NWC8uDCeF8GxedPP6tn2IPVGSXUF38pYqJlLGZj2QKbDkdP63lH/2aMuQrb/NX3SP1VVk7F2fezxqBSO5HkYYAVS129gSFsLKqmLoU0iy9hakzjuRp+8GtwFUhfoCM3nQL+/lqXqhPA5pvQTsYITfZra/zEM5nMGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110983; c=relaxed/simple;
	bh=t+jp8JMP2v7pXPs5gKNCsxjFCkLp6Bx/onDIRV9H2MY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=avJNGl5b0YrArTQoB4sElZKBqHNI+G2FbeNt+64U7rCxqqk29PoRz/b/CeG+KSPk+7ANIvmVxHaIZZF+RG/GeQTp4YRse5t8SKMvuQ+hMxSQGBwFTK29WTUtDfWV0LTHKHJFWJiononMVFQi0or4aM1RSLD40ynqw8gcyJfuhCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=XhbFeinx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rq9fcLtE; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="XhbFeinx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rq9fcLtE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DE3C7A00BC;
	Wed, 10 Jun 2026 13:03:00 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 13:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781110979;
	 x=1781197379; bh=OSlbDO9KijtVo5fa76Om7KAcqxUb2gcbAls+gJeOGeI=; b=
	XhbFeinxchvNOLHbtYJHOLJbYriBNCXbuP7om2xOyIcAHpEiIXYIFnGirbGAj2AR
	RP+uI164teTUOlOkFv4Nf75+ZrzU9pxO9OCS+Oxzp9lvFgdOZ/W13/DSMKOckN1v
	Wc9xFme4lBiXKbjJt6od2oPDlsBTv7eHj/bt44B9Q4IR4uHfDjllWIyJ1RiYRpZm
	V7fcKuenwuWKxzIiTEgzlNdhwNNVHXrmRcdwdxNlRMvzYO9rFGHAJ8axPAlkTavg
	23UqJukkWvMrriUm4mMcM+JdFQBovCGgoWSi23mxLveXudHCyrcaJcuLJ+ANF1cN
	iW0dOZNbm/zMQLrci7nRpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781110979; x=
	1781197379; bh=OSlbDO9KijtVo5fa76Om7KAcqxUb2gcbAls+gJeOGeI=; b=R
	q9fcLtEgXyNJ5+zyUPC8njyCeoCbK31F8IUMZEGkfR7HhzCwP3KrXk0LLU3FAaoz
	3wYgdoRGObwTZdxNLjygAXppKiNEs8AB3EvmkW+oVPHjeJI/qebOTRgS4C38LyMq
	081qMusT/HgLk+9tV3PofHVmCUNaKbFOaFi/SEP+Jy/YNKsWtYN/BaM4i3csrJP/
	9fAH23pajNjDEzHFxRYfyPZp3ENTolneZ6AP5bY6PPmLgN0I2nhmEBcSp5IPZn/r
	iXGm4T5fgo8oDXsrV5ycwfWuAsdktowh1X92f9MA8VmMXNXACUbSiiU41Y2MKJ/P
	gTfZwWyTgBTUGqbUeLMRg==
X-ME-Sender: <xms:w5gpalY9FcyyUNxz4j88czALVJ6gcCCJPuRVOt__WoWoLztWkyygbg>
    <xme:w5gpanM1_fREjo-FsZzdeUzw0RKXoubxWVKCoSPFhwUMPMclMFb-MR5rBIXJus8cj
    aNcSvI23VL8SsmmveCQmxHRqAiz9tSgwqVmQEBjZoFNUIYR5kySQsA>
X-ME-Proxy-Cause: dmFkZTGsztQYeMXGWcNo8Hu3IUVBPd3jJwSezo03gAWbp6x2TwWMS7WaJyjpN8TXT5B8gV
    OXNHIjQ0FXrxqfVhzlHtbn/ZlErSlS8cIjm9XPbU2oYte21U55NPOJVXnWKrs/aj0eXQLS
    ZuUyp95J9OK+Q99x1ZQAFCDkYHMU5fZKciujmzynhY7ijObAEf5IUqYo1Tr3bZRoy8+1gf
    EfzYLt/vyLtZo0okxJY5DNRUsZBIdqnQtTzDJNMQKseOKRZLUgj/vaz67NdB2t+I+gOzrP
    zJInab3uDw6okxSbdVrpQAHots/j/W5Ra329O8eJDszKndPxyZP1tvA1Y9LvNftLAjaQn2
    wxiQCK3Gl5yhN/Zjvo2hoegYRMuqq/Kq9RJ0Ys0HSr5we8uCyJqNs7+thNBfYV+e1adH5h
    e58CIvU5lvy2Oi4+YFwQBe3vFFFI5rUhsz8yLOmnb6T0OmaWtJMbqA3S6LrDYGdaH6tTzM
    AmVM6HKPiyL5hbvjCIIF/QSh09wU+eI4wOJMAvCQNUJD216ckGWVweOatlDOUEUxoUK/ag
    yzxwTF0w6FuWe4vgO8RIgDzO282Wda4SxybeieAhxMWL67wSLzv6ENXSDP1umv8PWkoPd6
    K+QREKU8Ou23gfTXBTq1+N/WmnHMefEHc6alfkjfhX+PWxD8HrWIyvAFOs9g
X-ME-Proxy: <xmx:w5gpagGmIQLBCvEJWkth16JrkUryCrm0i9Xvsom-A0Ltvj0Ju5eamA>
    <xmx:w5gpanTdPjKu5HCLwdPrkWVFBP620Zp_KX1IqsyoKS1XY8nQpJSrCQ>
    <xmx:w5gpahsAcYhzaPnQ9goJPif1AT5HfCV5bH87EA8Yvu326fnMfAX_Tw>
    <xmx:w5gpauw4sb5rGzKLH_UQw6H1bi0kMEE2C7WvKBDGGHvjQKEqvFbUXA>
    <xmx:w5gpan8jDo3qqvu8Qmp0qevhQ5hEZhBtqHhMNMnYueTDuu9iZ-LwYFvX>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98305216008B; Wed, 10 Jun 2026 13:02:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ark7h5MHViQF
Date: Wed, 10 Jun 2026 13:02:39 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <e9720437-0673-4428-9be2-203404e5cbec@app.fastmail.com>
In-Reply-To: 
 <CABBYNZJsyPU5wr4T32Ej9Vj0=Nco=PjtQn4aiC=NqUGbgP3zBw@mail.gmail.com>
References: <20260603150835.3539963-1-oss@fourdim.xyz>
 <20260603150835.3539963-2-oss@fourdim.xyz>
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
 <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com>
 <13e2aafc-8a4c-4c00-b38a-b09deda670ce@app.fastmail.com>
 <CABBYNZK2tzGe9CKcwBb7SxGzE94Y04z_VvaoFLoQPJ=3m=MUgQ@mail.gmail.com>
 <3cf8c12c-10c3-4ba8-9037-7e41a820d23d@app.fastmail.com>
 <CABBYNZJsyPU5wr4T32Ej9Vj0=Nco=PjtQn4aiC=NqUGbgP3zBw@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed, Jun 10, 2026, at 12:59 PM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, Jun 10, 2026 at 12:33=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
>>
>>
>>
>> On Wed, Jun 10, 2026, at 11:57 AM, Luiz Augusto von Dentz wrote:
>> > Hi Siwei,
>> >
>> > On Mon, Jun 8, 2026 at 9:29=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz=
> wrote:
>> >>
>> >> Hi Luiz,
>> >>
>> >> On Thu, Jun 4, 2026, at 11:52 AM, Siwei Zhang wrote:
>> >> > Hi Luiz,
>> >> >
>> >> > On Wed, Jun 3, 2026, at 2:17 PM, Luiz Augusto von Dentz wrote:
>> >> >> Hi Siwei,
>> >> >>
>> >> >> On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fourdi=
m.xyz> wrote:
>> >> >>>
>> >> >>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan aft=
er
>> >> >>> release_sock(parent). Once the parent lock is released, the ch=
ild
>> >> >>> socket sk can be freed by another task.
>> >> >>>
>> >> >>> Allocate the channel outside the func to prevent this.
>> >> >>>
>> >> >>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage fr=
om l2cap_core.c")
>> >> >>> Cc: stable@kernel.org
>> >> >>> Assisted-by: Claude:claude-opus-4-8
>> >> >>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> >> >>> ---
>> >> >>>  include/net/bluetooth/l2cap.h | 10 +++--
>> >> >>>  net/bluetooth/6lowpan.c       | 31 +++++++------
>> >> >>>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
>> >> >>>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++-----=
---------
>> >> >>>  net/bluetooth/smp.c           | 17 ++++---
>> >> >>>  5 files changed, 113 insertions(+), 69 deletions(-)
>> >> >>>
>> >> >>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluet=
ooth/l2cap.h
>> >> >>> index e0a1f2293679..7f5e4647f6e0 100644
>> >> >>> --- a/include/net/bluetooth/l2cap.h
>> >> >>> +++ b/include/net/bluetooth/l2cap.h
>> >> >>> @@ -620,7 +620,9 @@ struct l2cap_chan {
>> >> >>>  struct l2cap_ops {
>> >> >>>         char                    *name;
>> >> >>>
>> >> >>> -       struct l2cap_chan       *(*new_connection) (struct l2c=
ap_chan *chan);
>> >> >>> +       int                     (*new_connection)(struct l2cap=
_conn *conn,
>> >> >>> +                                                 struct l2cap=
_chan *chan,
>> >> >>> +                                                 struct l2cap=
_chan *new_chan);
>> >> >>>         int                     (*recv) (struct l2cap_chan * c=
han,
>> >> >>>                                          struct sk_buff *skb);
>> >> >>>         void                    (*teardown) (struct l2cap_chan=
 *chan, int err);
>> >> >>> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2c=
ap_chan *chan, __u16 seq)
>> >> >>>         return (seq + 1) % (chan->tx_win_max + 1);
>> >> >>>  }
>> >> >>>
>> >> >>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection=
(struct l2cap_chan *chan)
>> >> >>> +static inline int l2cap_chan_no_new_connection(struct l2cap_c=
onn *conn,
>> >> >>> +                                              struct l2cap_ch=
an *chan,
>> >> >>> +                                              struct l2cap_ch=
an *new_chan)
>> >> >>>  {
>> >> >>> -       return NULL;
>> >> >>> +       return -EOPNOTSUPP;
>> >> >>>  }
>> >> >>>
>> >> >>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan,=
 struct sk_buff *skb)
>> >> >>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> >> >>> index cb1e329d66fd..94863af97a44 100644
>> >> >>> --- a/net/bluetooth/6lowpan.c
>> >> >>> +++ b/net/bluetooth/6lowpan.c
>> >> >>> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn=
 *hcon)
>> >> >>>         return true;
>> >> >>>  }
>> >> >>>
>> >> >>> +static void chan_init(struct l2cap_chan *chan)
>> >> >>> +{
>> >> >>> +       l2cap_chan_set_defaults(chan);
>> >> >>> +
>> >> >>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> >> >>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> >> >>> +       chan->imtu =3D 1280;
>> >> >>> +}
>> >> >>> +
>> >> >>>  static struct l2cap_chan *chan_create(void)
>> >> >>>  {
>> >> >>>         struct l2cap_chan *chan;
>> >> >>> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(voi=
d)
>> >> >>>         if (!chan)
>> >> >>>                 return NULL;
>> >> >>>
>> >> >>> -       l2cap_chan_set_defaults(chan);
>> >> >>> -
>> >> >>> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> >> >>> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> >> >>> -       chan->imtu =3D 1280;
>> >> >>> +       chan_init(chan);
>> >> >>>
>> >> >>>         return chan;
>> >> >>>  }
>> >> >>> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct =
l2cap_chan *chan)
>> >> >>>         ifup(dev->netdev);
>> >> >>>  }
>> >> >>>
>> >> >>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2ca=
p_chan *pchan)
>> >> >>> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
>> >> >>> +                                  struct l2cap_chan *pchan,
>> >> >>> +                                  struct l2cap_chan *chan)
>> >> >>>  {
>> >> >>> -       struct l2cap_chan *chan;
>> >> >>> -
>> >> >>> -       chan =3D chan_create();
>> >> >>> -       if (!chan)
>> >> >>> -               return NULL;
>> >> >>> -
>> >> >>> +       chan_init(chan);
>>
>> ref1: chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED; set
>> in chan_init.
>>
>> >> >>>         chan->ops =3D pchan->ops;
>> >> >>>
>> >> >>> +       /* Take the conn list reference; see l2cap_new_connect=
ion(). */
>> >> >>> +       __l2cap_chan_add(conn, chan);
>> >> >>> +
>> >> >>>         BT_DBG("chan %p pchan %p", chan, pchan);
>> >> >>>
>> >> >>> -       return chan;
>> >> >>> +       return 0;
>> >> >>>  }
>> >> >>>
>> >> >>>  static void unregister_dev(struct lowpan_btle_dev *dev)
>> >> >>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_=
core.c
>> >> >>> index c4ccfbda9d78..62acf90837fb 100644
>> >> >>> --- a/net/bluetooth/l2cap_core.c
>> >> >>> +++ b/net/bluetooth/l2cap_core.c
>> >> >>> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(str=
uct l2cap_conn *conn,
>> >> >>>         return 0;
>> >> >>>  }
>> >> >>>
>> >> >>> +/* Allocate and initialise a channel for an incoming connecti=
on.
>> >> >>> + *
>> >> >>> + * ->new_connection() initialises the channel and links it in=
to @conn with
>> >> >>> + * __l2cap_chan_add(). The l2cap_chan_create() reference beco=
mes the one owned
>> >> >>> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or =
peer->chan) and is
>> >> >>> + * released by its teardown callback; the conn list reference=
 is released by
>> >> >>> + * l2cap_chan_del().
>> >> >>> + */
>> >> >>> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_c=
onn *conn,
>> >> >>> +                                              struct l2cap_ch=
an *pchan)
>> >> >>> +{
>> >> >>> +       struct l2cap_chan *chan;
>> >> >>> +
>> >> >>> +       chan =3D l2cap_chan_create();
>> >> >>> +       if (!chan)
>> >> >>> +               return NULL;
>> >> >>> +
>> >> >>> +       if (pchan->ops->new_connection(conn, pchan, chan) < 0)=
 {
>> >> >>> +               l2cap_chan_put(chan);
>> >> >>> +               return NULL;
>> >> >>> +       }
>> >> >>
>> >> >> I don't quite get why we can't just place __l2cap_chan_add here
>> >> >> instead of having it called by new_connection callbacks?
>> >> >>
>> >> >
>> >> > It's specifically the l2cap_sock_new_connection_cb() case - the =
very
>> >> > use-after-free this patch fixes. The __l2cap_chan_add() has to h=
appen while
>> >> > the parent lock is still held, and only the callback holds that =
lock.
>> >> >
>> >> > The reference counting on the new child chan starts at one ref,
>> >> > owned by the new socket:
>> >> >
>> >> >       /* l2cap_new_connection() */
>> >> >       chan =3D l2cap_chan_create();             /* refcount =3D =
1 */
>> >> >       if (!chan)
>> >> >               return NULL;
>> >> >
>> >> >       pchan->ops->new_connection(conn, pchan, chan);
>> >> >
>> >> > and inside the socket callback:
>> >> >
>> >> >       /* l2cap_sock_new_connection_cb() */
>> >> >       lock_sock(parent);
>> >> >       ...
>> >> >       sk =3D l2cap_sock_alloc(..., new_chan);   /* sk owns the c=
han_create ref */
>> >> >       ...
>> >> >       l2cap_sock_init(sk, parent);
>> >> >
>> >> >       __l2cap_chan_add(conn, new_chan);       /* (A) conn list t=
akes a ref */
>> >> >       bt_accept_enqueue(parent, sk, false);   /* (B) sk now on a=
ccept queue */
>> >> >
>> >> >       release_sock(parent);                   /* (C) parent lock=
 dropped */
>> >> >       return 0;
>> >> >
>> >> > The moment we hit (C), sk is reachable through the parent's acce=
pt queue, so
>> >> > another task can grab and tear it down:
>> >> >
>> >> >       accept() -> l2cap_sock_kill() -> l2cap_sock_put_chan()
>> >> >               chan->data =3D NULL;
>> >> >               l2cap_chan_put(chan);           /* drops the sk's =
chan ref */
>> >> >
>> >> > If __l2cap_chan_add() at (A) hadn't already taken the conn list =
reference,
>> >> > that put would drop the last ref and free new_chan. Control then=
 returns up
>> >> > to l2cap_new_connection(), which hands the now-freed chan back to
>> >> > l2cap_connect():
>> >> >
>> >> >       /* l2cap_connect() - runs after the callback returns */
>> >> >       chan =3D l2cap_new_connection(conn, pchan);
>> >> >       if (!chan)
>> >> >               goto response;
>> >> >       ...
>> >> >       bacpy(&chan->src, &conn->hcon->src);    /* <-- UAF on free=
d chan */
>> >> >       chan->psm  =3D psm;
>> >> >       chan->dcid =3D scid;
>> >> >
>> >> > The conn list reference taken at (A), before (C), is what keeps =
new_chan
>> >> > alive across the release_sock() window so l2cap_connect() can ke=
ep using it.
>> >> >
>> >> > So __l2cap_chan_add() can't move out to l2cap_new_connection(): =
by the time
>> >> > the callback returns, the parent lock is already dropped and cha=
n may already
>> >> > be freed - which is exactly the race. It has to be taken inside =
the callback,
>> >> > under the parent lock, before the socket is exposed.
>> >
>> > If you do after l2cap_new_connection, yes, but what if you do before
>> > you call ->new_connect:
>> >
>> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> > index 3991c179b98f..cd864f400985 100644
>> > --- a/net/bluetooth/l2cap_core.c
>> > +++ b/net/bluetooth/l2cap_core.c
>> > @@ -4027,8 +4027,10 @@ static struct l2cap_chan
>> > *l2cap_new_connection(struct l2cap_conn *conn,
>> >         if (!chan)
>> >                 return NULL;
>> >
>> > +       __l2cap_chan_add(conn, chan);
>> > +
>> >         if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
>> > -               l2cap_chan_put(chan);
>> > +               l2cap_chan_del(chan, 0);
>> >                 return NULL;
>> >         }
>> >
>> > This means we have to call l2cap_chan_del if new_connection fails, =
but
>> > we can eliminate other functions having to call __l2cap_chan_add wi=
th
>> > this. If the issue is then having l2cap_chan_del called concurrentl=
y,
>> > we can add a l2cap_chan_hold; actually, we may need a reference any=
way
>> > since sk can be released and call l2cap_chan_del, releasing both
>> > references.
>> >
>>
>> In:
>>
>> void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *cha=
n)
>> {
>>         ...
>>         switch (chan->chan_type) {
>>         case L2CAP_CHAN_CONN_ORIENTED:
>>                 ...
>>                 break;
>>         case L2CAP_CHAN_CONN_LESS:
>>                 ...
>>                 break;
>>         case L2CAP_CHAN_FIXED:
>>                 ...
>>                 break;
>>         default:
>>                 ...
>>         }
>> }
>>
>> Apparently it depends on chan->chan_type and it is set by ref1.
>> It is only set in cb function.
>
> Ok, this probably needs fixing in 6lowpan. These defaults should come
> from the parent channel, similar to how it's done in l2cap_sock_init.
> Perhaps we should promote that logic to l2cap_chan_set_defaults
> passing pchan so it can initialize the channel before calling
> __l2cap_chan_add.

I can fix that in a separate patch.
Could you please merge it first?

Best,
Siwei
