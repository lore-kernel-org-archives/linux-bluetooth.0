Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD42DB785
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109204; cv=none; b=cFWyRPnDIBuv51G37cUyk9vRtTd/e0DmI43LQ/S9aIYyO2Qk1gbBxsXuFqmSMqtbPX9oY4KJp0J6uMvDSk8nYjWhGNYAYMqLHz34ob2sPcKexMzPwcoe9d0uTjuALXGKpM7SMSzmxapEgsGIkG41KAYUMhcmdFt69R569ee5noA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109204; c=relaxed/simple;
	bh=MUkSdBsV5EvbxB07/h8pQtGa/02CJwj9fP9YCMCDolc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lqJLHZWFn8Do2RT6967Syd1UhEFW/2UP6xsgOrAaDIq/R6r8vfDEQEruS6oNMwUYhXP4nKscI4rsl3wjSCBXMvJP3nkcEIS9BH2Bi9+AHJ6oLLbiO0ImSZfIKap/iLp9EExgvUAXSaIahqUdUloXMjicpIc18G5zaCWZN83ezl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=lceeBdlH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=leOq5Tvs; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="lceeBdlH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="leOq5Tvs"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 242BB7A011B;
	Wed, 10 Jun 2026 12:33:21 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 12:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781109200;
	 x=1781195600; bh=6+bdwvRaGAzKQBl3CSPy4guLng0Vgiv3jqTNQk9x2CI=; b=
	lceeBdlHAwvZwjiHwGwPSwpnYp1IawXg9OCyTHoZo5dCMHlI62rwxhK8VSQTk6Rq
	WYVWFgQ8i1YKGj4Ce0HTN1QmSFMSnl0m/3jrKsM7Ek7NdUg5xE4D0VrQfaG009wB
	r3MLXvSnd3WgwKtkoezWtsgWpZWhS7quXBrCI6RV0ExW2vg6TBDxVeVhI1O0S4DP
	KAlHPJ5KaolsZv32/u+oZNouJ15QgGZCIvXz9X8YGhGW5viz+qidkNUeSGZ+8A4M
	VKNxsZj0j1ZG80KoemiNvw5UG7ajrkj9D1QoKPhMjc19u5tkm5a+peuZUrQ8c2m8
	TfkRb32UYE0H0T2BhVR1vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781109200; x=
	1781195600; bh=6+bdwvRaGAzKQBl3CSPy4guLng0Vgiv3jqTNQk9x2CI=; b=l
	eOq5TvssSzNylCpSICoNZexUNchhqqXGtaVVBkEvAsfi1n3NtSxf5FTZ0E6Gf8gq
	LGxn1w7E0uZVUEpfccsUIZ3adFi7+0F3+xA5oxi1SDmlZaHDJ/NiR3zDAgSeYacM
	IK4DOoh4JKIBytaNU9F38muU1XWzn49zfzK8Y/k/mdu8M+6R2D8Yo/oFq5SiXDn6
	8LObGbeN5+92SMo3dPbia5H5QxmNVTyAgadFRCtwib4BPtiMxe2ryQG7lzEo9F+E
	qJIlY9oiHRl8F6lVVjPawHniPSwmQ8hWAvg1u7bimCxUfr3LNnc0K6jcLG4WMc5t
	jNtkh4BVeLZVUeDSNgFMQ==
X-ME-Sender: <xms:0JEpamCEVlG8kaQsmQ43RrKq9XyqKZPd_KGDv_BKtTVuf7ktDcD41Q>
    <xme:0JEparVw04DUcAYPe3ffdgtQH8fcEgmzhYxvjbTOFx-ucPRSdwzNno3vui4VCWHv7
    YTXTKyD5Ri4BR2av73yUCNQEWj-AxfuRGjnRx7fQcSKlN7eIVBPTfE>
X-ME-Proxy-Cause: dmFkZTFg5975uAmPe4CMuEQYC51SZR4Oe3MtJhdXgoQSdGqRlXKvtGH/z9oMaBCO3Xo76H
    9Fj3Mj/fI/tegCEbyb25AHFtwLO74Wsu9nuPVnHvd007xlNVPe3LBAjaSTyk11VgpQHmwI
    RKoaKWtlCmRFpC7NA3URAgB7TL+fV38OdkNKsrXUNiruACDrAx4RceIYsxBsCHbG0R4Bu+
    8buf+6E7e2+z3nJxiEz5jQsdafVkaZrB+riE4KzzVWjQVDCHS3m+/i/vxl54INvi+PEouR
    +STYID15dg1zmBOzlkgkHUCrCEhAViDH933ovvA7l8MDh1wStAyXIrjG32dQyEKl6jgKbB
    XovoKzymqo4GhjWpQ8p+wIfBe7Xc2EunrLF7k/sxlGRnnhzLlQaGik+MJLF8qrrWGWkerY
    5SiErX406GOomQO0o7igznztjguBBvlT9gW1des5Jx5motKg5Tdk3KZspJ6eaukHa2PmmJ
    9CNPHtS5CVq9K8ac6kAHc0WHKy1c682VJVqt1aH9+yxRUcSL2zLDZVVK2odwdVu89LZKyu
    MJ/QA08oVMIFl3CVcw1x4tYYoUlo90qMoiwa+unw2KIPwvR1Ul16pXb219PZZWKEuJ19W4
    rzxCI/OlQAE1w8mRykkDwfD7nlXrZY9omYzf9uzOboGUjHFZlPjhIfxA3bFg
X-ME-Proxy: <xmx:0JEpaovDykp9WCa_mmC5Y2c_kHEpz17tlxDBB4mDAbdlP4qZqfu6Vw>
    <xmx:0JEpajZtAvr1R2l9Hll1nlFpqpF9Bx1QfigcNpFtbh7Eu5ux7lh3dw>
    <xmx:0JEparWBtQz0kBvuqaG0yrN6cJ5S5nOdaYNyZNKDxKZV6rVOd_efvA>
    <xmx:0JEpan7DRKLmsGituLzVFn6F73CyBAUNpVCegBGsryFCb1aDz5cWqg>
    <xmx:0JEpakFFRGQmdf2nrH9C6cBgtnL5zJzLsRhZc7tDWzojjEx17LpwBw0d>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AF87C216008B; Wed, 10 Jun 2026 12:33:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ark7h5MHViQF
Date: Wed, 10 Jun 2026 12:32:55 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3cf8c12c-10c3-4ba8-9037-7e41a820d23d@app.fastmail.com>
In-Reply-To: 
 <CABBYNZK2tzGe9CKcwBb7SxGzE94Y04z_VvaoFLoQPJ=3m=MUgQ@mail.gmail.com>
References: <20260603150835.3539963-1-oss@fourdim.xyz>
 <20260603150835.3539963-2-oss@fourdim.xyz>
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
 <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com>
 <13e2aafc-8a4c-4c00-b38a-b09deda670ce@app.fastmail.com>
 <CABBYNZK2tzGe9CKcwBb7SxGzE94Y04z_VvaoFLoQPJ=3m=MUgQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Jun 10, 2026, at 11:57 AM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Mon, Jun 8, 2026 at 9:29=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> w=
rote:
>>
>> Hi Luiz,
>>
>> On Thu, Jun 4, 2026, at 11:52 AM, Siwei Zhang wrote:
>> > Hi Luiz,
>> >
>> > On Wed, Jun 3, 2026, at 2:17 PM, Luiz Augusto von Dentz wrote:
>> >> Hi Siwei,
>> >>
>> >> On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fourdim.x=
yz> wrote:
>> >>>
>> >>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
>> >>> release_sock(parent). Once the parent lock is released, the child
>> >>> socket sk can be freed by another task.
>> >>>
>> >>> Allocate the channel outside the func to prevent this.
>> >>>
>> >>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from =
l2cap_core.c")
>> >>> Cc: stable@kernel.org
>> >>> Assisted-by: Claude:claude-opus-4-8
>> >>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> >>> ---
>> >>>  include/net/bluetooth/l2cap.h | 10 +++--
>> >>>  net/bluetooth/6lowpan.c       | 31 +++++++------
>> >>>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
>> >>>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++--------=
------
>> >>>  net/bluetooth/smp.c           | 17 ++++---
>> >>>  5 files changed, 113 insertions(+), 69 deletions(-)
>> >>>
>> >>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetoot=
h/l2cap.h
>> >>> index e0a1f2293679..7f5e4647f6e0 100644
>> >>> --- a/include/net/bluetooth/l2cap.h
>> >>> +++ b/include/net/bluetooth/l2cap.h
>> >>> @@ -620,7 +620,9 @@ struct l2cap_chan {
>> >>>  struct l2cap_ops {
>> >>>         char                    *name;
>> >>>
>> >>> -       struct l2cap_chan       *(*new_connection) (struct l2cap_=
chan *chan);
>> >>> +       int                     (*new_connection)(struct l2cap_co=
nn *conn,
>> >>> +                                                 struct l2cap_ch=
an *chan,
>> >>> +                                                 struct l2cap_ch=
an *new_chan);
>> >>>         int                     (*recv) (struct l2cap_chan * chan,
>> >>>                                          struct sk_buff *skb);
>> >>>         void                    (*teardown) (struct l2cap_chan *c=
han, int err);
>> >>> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2cap_=
chan *chan, __u16 seq)
>> >>>         return (seq + 1) % (chan->tx_win_max + 1);
>> >>>  }
>> >>>
>> >>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(st=
ruct l2cap_chan *chan)
>> >>> +static inline int l2cap_chan_no_new_connection(struct l2cap_conn=
 *conn,
>> >>> +                                              struct l2cap_chan =
*chan,
>> >>> +                                              struct l2cap_chan =
*new_chan)
>> >>>  {
>> >>> -       return NULL;
>> >>> +       return -EOPNOTSUPP;
>> >>>  }
>> >>>
>> >>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, st=
ruct sk_buff *skb)
>> >>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> >>> index cb1e329d66fd..94863af97a44 100644
>> >>> --- a/net/bluetooth/6lowpan.c
>> >>> +++ b/net/bluetooth/6lowpan.c
>> >>> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn *h=
con)
>> >>>         return true;
>> >>>  }
>> >>>
>> >>> +static void chan_init(struct l2cap_chan *chan)
>> >>> +{
>> >>> +       l2cap_chan_set_defaults(chan);
>> >>> +
>> >>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> >>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> >>> +       chan->imtu =3D 1280;
>> >>> +}
>> >>> +
>> >>>  static struct l2cap_chan *chan_create(void)
>> >>>  {
>> >>>         struct l2cap_chan *chan;
>> >>> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void)
>> >>>         if (!chan)
>> >>>                 return NULL;
>> >>>
>> >>> -       l2cap_chan_set_defaults(chan);
>> >>> -
>> >>> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> >>> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> >>> -       chan->imtu =3D 1280;
>> >>> +       chan_init(chan);
>> >>>
>> >>>         return chan;
>> >>>  }
>> >>> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct l2c=
ap_chan *chan)
>> >>>         ifup(dev->netdev);
>> >>>  }
>> >>>
>> >>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_c=
han *pchan)
>> >>> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
>> >>> +                                  struct l2cap_chan *pchan,
>> >>> +                                  struct l2cap_chan *chan)
>> >>>  {
>> >>> -       struct l2cap_chan *chan;
>> >>> -
>> >>> -       chan =3D chan_create();
>> >>> -       if (!chan)
>> >>> -               return NULL;
>> >>> -
>> >>> +       chan_init(chan);

ref1: chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED; set
in chan_init.

>> >>>         chan->ops =3D pchan->ops;
>> >>>
>> >>> +       /* Take the conn list reference; see l2cap_new_connection=
(). */
>> >>> +       __l2cap_chan_add(conn, chan);
>> >>> +
>> >>>         BT_DBG("chan %p pchan %p", chan, pchan);
>> >>>
>> >>> -       return chan;
>> >>> +       return 0;
>> >>>  }
>> >>>
>> >>>  static void unregister_dev(struct lowpan_btle_dev *dev)
>> >>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_cor=
e.c
>> >>> index c4ccfbda9d78..62acf90837fb 100644
>> >>> --- a/net/bluetooth/l2cap_core.c
>> >>> +++ b/net/bluetooth/l2cap_core.c
>> >>> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(struct=
 l2cap_conn *conn,
>> >>>         return 0;
>> >>>  }
>> >>>
>> >>> +/* Allocate and initialise a channel for an incoming connection.
>> >>> + *
>> >>> + * ->new_connection() initialises the channel and links it into =
@conn with
>> >>> + * __l2cap_chan_add(). The l2cap_chan_create() reference becomes=
 the one owned
>> >>> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or pee=
r->chan) and is
>> >>> + * released by its teardown callback; the conn list reference is=
 released by
>> >>> + * l2cap_chan_del().
>> >>> + */
>> >>> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn=
 *conn,
>> >>> +                                              struct l2cap_chan =
*pchan)
>> >>> +{
>> >>> +       struct l2cap_chan *chan;
>> >>> +
>> >>> +       chan =3D l2cap_chan_create();
>> >>> +       if (!chan)
>> >>> +               return NULL;
>> >>> +
>> >>> +       if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
>> >>> +               l2cap_chan_put(chan);
>> >>> +               return NULL;
>> >>> +       }
>> >>
>> >> I don't quite get why we can't just place __l2cap_chan_add here
>> >> instead of having it called by new_connection callbacks?
>> >>
>> >
>> > It's specifically the l2cap_sock_new_connection_cb() case - the very
>> > use-after-free this patch fixes. The __l2cap_chan_add() has to happ=
en while
>> > the parent lock is still held, and only the callback holds that loc=
k.
>> >
>> > The reference counting on the new child chan starts at one ref,
>> > owned by the new socket:
>> >
>> >       /* l2cap_new_connection() */
>> >       chan =3D l2cap_chan_create();             /* refcount =3D 1 */
>> >       if (!chan)
>> >               return NULL;
>> >
>> >       pchan->ops->new_connection(conn, pchan, chan);
>> >
>> > and inside the socket callback:
>> >
>> >       /* l2cap_sock_new_connection_cb() */
>> >       lock_sock(parent);
>> >       ...
>> >       sk =3D l2cap_sock_alloc(..., new_chan);   /* sk owns the chan=
_create ref */
>> >       ...
>> >       l2cap_sock_init(sk, parent);
>> >
>> >       __l2cap_chan_add(conn, new_chan);       /* (A) conn list take=
s a ref */
>> >       bt_accept_enqueue(parent, sk, false);   /* (B) sk now on acce=
pt queue */
>> >
>> >       release_sock(parent);                   /* (C) parent lock dr=
opped */
>> >       return 0;
>> >
>> > The moment we hit (C), sk is reachable through the parent's accept =
queue, so
>> > another task can grab and tear it down:
>> >
>> >       accept() -> l2cap_sock_kill() -> l2cap_sock_put_chan()
>> >               chan->data =3D NULL;
>> >               l2cap_chan_put(chan);           /* drops the sk's cha=
n ref */
>> >
>> > If __l2cap_chan_add() at (A) hadn't already taken the conn list ref=
erence,
>> > that put would drop the last ref and free new_chan. Control then re=
turns up
>> > to l2cap_new_connection(), which hands the now-freed chan back to
>> > l2cap_connect():
>> >
>> >       /* l2cap_connect() - runs after the callback returns */
>> >       chan =3D l2cap_new_connection(conn, pchan);
>> >       if (!chan)
>> >               goto response;
>> >       ...
>> >       bacpy(&chan->src, &conn->hcon->src);    /* <-- UAF on freed c=
han */
>> >       chan->psm  =3D psm;
>> >       chan->dcid =3D scid;
>> >
>> > The conn list reference taken at (A), before (C), is what keeps new=
_chan
>> > alive across the release_sock() window so l2cap_connect() can keep =
using it.
>> >
>> > So __l2cap_chan_add() can't move out to l2cap_new_connection(): by =
the time
>> > the callback returns, the parent lock is already dropped and chan m=
ay already
>> > be freed - which is exactly the race. It has to be taken inside the=
 callback,
>> > under the parent lock, before the socket is exposed.
>
> If you do after l2cap_new_connection, yes, but what if you do before
> you call ->new_connect:
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 3991c179b98f..cd864f400985 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4027,8 +4027,10 @@ static struct l2cap_chan
> *l2cap_new_connection(struct l2cap_conn *conn,
>         if (!chan)
>                 return NULL;
>
> +       __l2cap_chan_add(conn, chan);
> +
>         if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
> -               l2cap_chan_put(chan);
> +               l2cap_chan_del(chan, 0);
>                 return NULL;
>         }
>
> This means we have to call l2cap_chan_del if new_connection fails, but
> we can eliminate other functions having to call __l2cap_chan_add with
> this. If the issue is then having l2cap_chan_del called concurrently,
> we can add a l2cap_chan_hold; actually, we may need a reference anyway
> since sk can be released and call l2cap_chan_del, releasing both
> references.
>

In:

void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
{
	...
	switch (chan->chan_type) {
	case L2CAP_CHAN_CONN_ORIENTED:
		...
		break;
	case L2CAP_CHAN_CONN_LESS:
		...
		break;
	case L2CAP_CHAN_FIXED:
		...
		break;
	default:
		...
	}
}

Apparently it depends on chan->chan_type and it is set by ref1.
It is only set in cb function.

>> > The other callbacks (6lowpan, smp) have no equivalent lock-drop win=
dow.
>> >  I kept __l2cap_chan_add() inside all of the ->new_connection() cal=
lbacks
>> > just to keep the "callback links the channel into conn" contract un=
iform.
>> >
>>
>> Could you please check this?
>> Just remind you in case you miss this.
>>
>> >>> +
>> >>> +       return chan;
>> >>> +}
>> >>> +
>> >>>  static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_=
cmd_hdr *cmd,
>> >>>                           u8 *data, u8 rsp_code)
>> >>>  {
>> >>> @@ -4053,7 +4078,7 @@ static void l2cap_connect(struct l2cap_conn=
 *conn, struct l2cap_cmd_hdr *cmd,
>> >>>                 goto response;
>> >>>         }
>> >>>
>> >>> -       chan =3D pchan->ops->new_connection(pchan);
>> >>> +       chan =3D l2cap_new_connection(conn, pchan);
>> >>>         if (!chan)
>> >>>                 goto response;
>> >>>
>> >>> @@ -4071,8 +4096,6 @@ static void l2cap_connect(struct l2cap_conn=
 *conn, struct l2cap_cmd_hdr *cmd,
>> >>>         chan->psm  =3D psm;
>> >>>         chan->dcid =3D scid;
>> >>>
>> >>> -       __l2cap_chan_add(conn, chan);
>> >>> -
>> >>>         dcid =3D chan->scid;
>> >>>
>> >>>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>> >>> @@ -4955,7 +4978,7 @@ static int l2cap_le_connect_req(struct l2ca=
p_conn *conn,
>> >>>                 goto response_unlock;
>> >>>         }
>> >>>
>> >>> -       chan =3D pchan->ops->new_connection(pchan);
>> >>> +       chan =3D l2cap_new_connection(conn, pchan);
>> >>>         if (!chan) {
>> >>>                 result =3D L2CAP_CR_LE_NO_MEM;
>> >>>                 goto response_unlock;
>> >>> @@ -4970,8 +4993,6 @@ static int l2cap_le_connect_req(struct l2ca=
p_conn *conn,
>> >>>         chan->omtu =3D mtu;
>> >>>         chan->remote_mps =3D mps;
>> >>>
>> >>> -       __l2cap_chan_add(conn, chan);
>> >>> -
>> >>>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
>> >>>
>> >>>         dcid =3D chan->scid;
>> >>> @@ -5179,7 +5200,7 @@ static inline int l2cap_ecred_conn_req(stru=
ct l2cap_conn *conn,
>> >>>                         continue;
>> >>>                 }
>> >>>
>> >>> -               chan =3D pchan->ops->new_connection(pchan);
>> >>> +               chan =3D l2cap_new_connection(conn, pchan);
>> >>>                 if (!chan) {
>> >>>                         result =3D L2CAP_CR_LE_NO_MEM;
>> >>>                         continue;
>> >>> @@ -5194,8 +5215,6 @@ static inline int l2cap_ecred_conn_req(stru=
ct l2cap_conn *conn,
>> >>>                 chan->omtu =3D mtu;
>> >>>                 chan->remote_mps =3D mps;
>> >>>
>> >>> -               __l2cap_chan_add(conn, chan);
>> >>> -
>> >>>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits=
));
>> >>>
>> >>>                 /* Init response */
>> >>> @@ -7470,14 +7489,12 @@ static void l2cap_connect_cfm(struct hci_=
conn *hcon, u8 status)
>> >>>                         goto next;
>> >>>
>> >>>                 l2cap_chan_lock(pchan);
>> >>> -               chan =3D pchan->ops->new_connection(pchan);
>> >>> +               chan =3D l2cap_new_connection(conn, pchan);
>> >>>                 if (chan) {
>> >>>                         bacpy(&chan->src, &hcon->src);
>> >>>                         bacpy(&chan->dst, &hcon->dst);
>> >>>                         chan->src_type =3D bdaddr_src_type(hcon);
>> >>>                         chan->dst_type =3D dst_type;
>> >>> -
>> >>> -                       __l2cap_chan_add(conn, chan);
>> >>>                 }
>> >>>
>> >>>                 l2cap_chan_unlock(pchan);
>> >>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_soc=
k.c
>> >>> index 025329636353..87f4c0db5c0c 100644
>> >>> --- a/net/bluetooth/l2cap_sock.c
>> >>> +++ b/net/bluetooth/l2cap_sock.c
>> >>> @@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list =3D {
>> >>>  static const struct proto_ops l2cap_sock_ops;
>> >>>  static void l2cap_sock_init(struct sock *sk, struct sock *parent=
);
>> >>>  static struct sock *l2cap_sock_alloc(struct net *net, struct soc=
ket *sock,
>> >>> -                                    int proto, gfp_t prio, int k=
ern);
>> >>> +                                    int proto, gfp_t prio, int k=
ern,
>> >>> +                                    struct l2cap_chan *chan);
>> >>>  static void l2cap_sock_cleanup_listen(struct sock *parent);
>> >>>
>> >>>  bool l2cap_is_socket(struct socket *sock)
>> >>> @@ -1287,6 +1288,23 @@ static int l2cap_sock_recvmsg(struct socke=
t *sock, struct msghdr *msg,
>> >>>         return err;
>> >>>  }
>> >>>
>> >>> +/* Release the sock's ref on chan and clear the pointer so that =
the ref is
>> >>> + * dropped exactly once even if both l2cap_sock_kill() and
>> >>> + * l2cap_sock_destruct() run. Setting chan->data to NULL first s=
tops any other
>> >>> + * task from dereferencing the now-dead sock pointer.
>> >>> + */
>> >>> +static void l2cap_sock_put_chan(struct sock *sk)
>> >>> +{
>> >>> +       struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
>> >>> +
>> >>> +       if (!chan)
>> >>> +               return;
>> >>> +
>> >>> +       chan->data =3D NULL;
>> >>> +       l2cap_pi(sk)->chan =3D NULL;
>> >>> +       l2cap_chan_put(chan);
>> >>> +}
>> >>> +
>> >>>  /* Kill socket (only if zapped and orphan)
>> >>>   * Must be called on unlocked socket, with l2cap channel lock.
>> >>>   */
>> >>> @@ -1297,13 +1315,9 @@ static void l2cap_sock_kill(struct sock *s=
k)
>> >>>
>> >>>         BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state=
));
>> >>>
>> >>> -       /* Sock is dead, so set chan data to NULL, avoid other ta=
sk use invalid
>> >>> -        * sock pointer.
>> >>> -        */
>> >>> -       l2cap_pi(sk)->chan->data =3D NULL;
>> >>> -       /* Kill poor orphan */
>> >>> +       l2cap_sock_put_chan(sk);
>> >>>
>> >>> -       l2cap_chan_put(l2cap_pi(sk)->chan);
>> >>> +       /* Kill poor orphan */
>> >>>         sock_set_flag(sk, SOCK_DEAD);
>> >>>         sock_put(sk);
>> >>>  }
>> >>> @@ -1546,12 +1560,14 @@ static void l2cap_sock_cleanup_listen(str=
uct sock *parent)
>> >>>         }
>> >>>  }
>> >>>
>> >>> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2=
cap_chan *chan)
>> >>> +static int l2cap_sock_new_connection_cb(struct l2cap_conn *conn,
>> >>> +                                       struct l2cap_chan *chan,
>> >>> +                                       struct l2cap_chan *new_ch=
an)
>> >>>  {
>> >>>         struct sock *sk, *parent =3D chan->data;
>> >>>
>> >>>         if (!parent)
>> >>> -               return NULL;
>> >>> +               return -EINVAL;
>> >>>
>> >>>         lock_sock(parent);
>> >>>
>> >>> @@ -1559,25 +1575,33 @@ static struct l2cap_chan *l2cap_sock_new_=
connection_cb(struct l2cap_chan *chan)
>> >>>         if (sk_acceptq_is_full(parent)) {
>> >>>                 BT_DBG("backlog full %d", parent->sk_ack_backlog);
>> >>>                 release_sock(parent);
>> >>> -               return NULL;
>> >>> +               return -ENOBUFS;
>> >>>         }
>> >>>
>> >>>         sk =3D l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L=
2CAP,
>> >>> -                             GFP_ATOMIC, 0);
>> >>> +                             GFP_ATOMIC, 0, new_chan);
>> >>>         if (!sk) {
>> >>>                 release_sock(parent);
>> >>> -               return NULL;
>> >>> -        }
>> >>> +               return -ENOMEM;
>> >>> +       }
>> >>>
>> >>>         bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
>> >>>
>> >>>         l2cap_sock_init(sk, parent);
>> >>>
>> >>> +       /* Link the channel into conn before exposing the new soc=
ket via the
>> >>> +        * accept queue. Once release_sock() below drops the pare=
nt lock the
>> >>> +        * socket may be freed by another task, dropping its refe=
rence on
>> >>> +        * new_chan; the conn list reference taken here keeps new=
_chan alive so
>> >>> +        * the caller can safely use it after ->new_connection() =
returns.
>> >>> +        */
>> >>> +       __l2cap_chan_add(conn, new_chan);
>> >>> +
>> >>>         bt_accept_enqueue(parent, sk, false);
>> >>>
>> >>>         release_sock(parent);
>> >>>
>> >>> -       return l2cap_pi(sk)->chan;
>> >>> +       return 0;
>> >>>  }
>> >>>
>> >>>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk=
_buff *skb)
>> >>> @@ -1874,10 +1898,7 @@ static void l2cap_sock_destruct(struct soc=
k *sk)
>> >>>
>> >>>         BT_DBG("sk %p", sk);
>> >>>
>> >>> -       if (l2cap_pi(sk)->chan) {
>> >>> -               l2cap_pi(sk)->chan->data =3D NULL;
>> >>> -               l2cap_chan_put(l2cap_pi(sk)->chan);
>> >>> -       }
>> >>> +       l2cap_sock_put_chan(sk);
>> >>>
>> >>>         list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx=
_busy, list) {
>> >>>                 kfree_skb(rx_busy->skb);
>> >>> @@ -1978,10 +1999,10 @@ static struct proto l2cap_proto =3D {
>> >>>  };
>> >>>
>> >>>  static struct sock *l2cap_sock_alloc(struct net *net, struct soc=
ket *sock,
>> >>> -                                    int proto, gfp_t prio, int k=
ern)
>> >>> +                                    int proto, gfp_t prio, int k=
ern,
>> >>> +                                    struct l2cap_chan *chan)
>> >>>  {
>> >>>         struct sock *sk;
>> >>> -       struct l2cap_chan *chan;
>> >>>
>> >>>         sk =3D bt_sock_alloc(net, sock, &l2cap_proto, proto, prio=
, kern);
>> >>>         if (!sk)
>> >>> @@ -1992,16 +2013,7 @@ static struct sock *l2cap_sock_alloc(struc=
t net *net, struct socket *sock,
>> >>>
>> >>>         INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
>> >>>
>> >>> -       chan =3D l2cap_chan_create();
>> >>> -       if (!chan) {
>> >>> -               sk_free(sk);
>> >>> -               if (sock)
>> >>> -                       sock->sk =3D NULL;
>> >>> -               return NULL;
>> >>> -       }
>> >>> -
>> >>> -       l2cap_chan_hold(chan);
>> >>> -
>> >>> +       /* The sock takes ownership of the caller's reference on =
chan. */
>> >>>         l2cap_pi(sk)->chan =3D chan;
>> >>>
>> >>>         return sk;
>> >>> @@ -2011,6 +2023,7 @@ static int l2cap_sock_create(struct net *ne=
t, struct socket *sock, int protocol,
>> >>>                              int kern)
>> >>>  {
>> >>>         struct sock *sk;
>> >>> +       struct l2cap_chan *chan;
>> >>>
>> >>>         BT_DBG("sock %p", sock);
>> >>>
>> >>> @@ -2025,10 +2038,16 @@ static int l2cap_sock_create(struct net *=
net, struct socket *sock, int protocol,
>> >>>
>> >>>         sock->ops =3D &l2cap_sock_ops;
>> >>>
>> >>> -       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, =
kern);
>> >>> -       if (!sk)
>> >>> +       chan =3D l2cap_chan_create();
>> >>> +       if (!chan)
>> >>>                 return -ENOMEM;
>> >>>
>> >>> +       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, =
kern, chan);
>> >>> +       if (!sk) {
>> >>> +               l2cap_chan_put(chan);
>> >>> +               return -ENOMEM;
>> >>> +       }
>> >>> +
>> >>>         l2cap_sock_init(sk, NULL);
>> >>>         bt_sock_link(&l2cap_sk_list, sk);
>> >>>         return 0;
>> >>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>> >>> index 1739c1989dbd..2d31c3c7bbc0 100644
>> >>> --- a/net/bluetooth/smp.c
>> >>> +++ b/net/bluetooth/smp.c
>> >>> @@ -3204,16 +3204,12 @@ static const struct l2cap_ops smp_chan_op=
s =3D {
>> >>>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
>> >>>  };
>> >>>
>> >>> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_ch=
an *pchan)
>> >>> +static inline int smp_new_conn_cb(struct l2cap_conn *conn,
>> >>> +                                 struct l2cap_chan *pchan,
>> >>> +                                 struct l2cap_chan *chan)
>> >>>  {
>> >>> -       struct l2cap_chan *chan;
>> >>> -
>> >>>         BT_DBG("pchan %p", pchan);
>> >>>
>> >>> -       chan =3D l2cap_chan_create();
>> >>> -       if (!chan)
>> >>> -               return NULL;
>> >>> -
>> >>>         chan->chan_type =3D pchan->chan_type;
>> >>>         chan->ops       =3D &smp_chan_ops;
>> >>>         chan->scid      =3D pchan->scid;
>> >>> @@ -3229,9 +3225,12 @@ static inline struct l2cap_chan *smp_new_c=
onn_cb(struct l2cap_chan *pchan)
>> >>>          */
>> >>>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
>> >>>
>> >>> -       BT_DBG("created chan %p", chan);
>> >>> +       /* Take the conn list reference; see l2cap_new_connection=
(). */
>> >>> +       __l2cap_chan_add(conn, chan);
>> >>>
>> >>> -       return chan;
>> >>> +       BT_DBG("initialised chan %p", chan);
>> >>> +
>> >>> +       return 0;
>> >>>  }
>> >>>
>> >>>  static const struct l2cap_ops smp_root_chan_ops =3D {
>> >>> --
>> >>> 2.54.0
>> >>>
>> >>
>> >>
>> >> --
>> >> Luiz Augusto von Dentz
>> >
>> > Best,
>> > Siwei
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
