Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7958024DFF9
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110795; cv=pass; b=HAQf7IOnjhIU/lu0Bobw5rq56a1IYg5s13vw+3yQysFZ51xa0x03Ga3DI7tHewfggawbnc/lHNv9/FG3p/Tl2L33T5eYZ6mWxF/e+k6fCe2KBBCQzihNaNKGOohXcyNozF0OUu5pbNJOokSVBRIUoCxXo6wxmFAfSb/eHnTHMw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110795; c=relaxed/simple;
	bh=VWpDIzoglvyKest2YQDodKfR+Ue6iXInVEXHQwQsP/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxU6bkhSbxTh47wDyzqtr1dShAasvEudWr73kdqi1j8eDRPxFhFXDo2OQzl+AyzovANlKNCn1OtCVrs7BCG0GuAC1XBjfzoKzsgoaNpGT4MB0Ctd6afJ9//4alky6LqDpQ3OnIIHMwm1l7PnpNzyUx8Nn3A5XQ747wSBNk9s6BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xh2Jl61t; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh2Jl61t"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-660e9fef1d4so7995184d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 09:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781110792; cv=none;
        d=google.com; s=arc-20240605;
        b=OLdGdm6YJbcSQj63kzY0JZxSLI2R+dqrfUQoBVom+HMKRJSZArqdMTJEIQwbLDpRJx
         YHWNqPS9kEeEVZAzBb6WUAgaiT6lymjjpN/qcrUYuJ6dj0SnSuOdYMWQ0AnsxdAZlK6W
         0wsE3nJlw5MsLyRdTgiQWRKwHQqXedoFe/HEnJyqTO5Tvgt2E8SYADaEEMIzBYZvPeAF
         cWBBRPfUaxXrm02gNCJsTuWbQuzgRIReIQLGGVvdBoZLzUwJEI6i6tkwomadNTXJlWrH
         3j6tUCJZsdFB6yj6Mm+d5N1fsAdq8r7ZwSPgwDpSbqI8aHY4uFhLiqH6YP4kEr3ZYfi4
         q7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XA1F68F7pS3PUZhwBmf1Gf27tGmUxdTRKeKSh56YDVQ=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=bzdD4iFv0zYJlar1O+EKWt2dzmP+icnXhQMBFvnfj1Z8DWfTPQbar9WvHFHxo+HY4T
         9miMj5VVYTZPDWp8x7JFFwlUInSNR9XA0lcBGVDcNGQmcgUlwjY/JNnX1mM0FXnmyEmG
         erhCzUq0uqsCi1wQ8d2H90WD16pCKYZ6+3GZsMT5HSVr0ceR97c8taT/Nl0OsbMr1QXO
         IhMyKGhPD7A3oiAYVXs5/zFqIWvmwoclV/lfaZjwpPV4FZOvQioWQL/WFXAA5syePaoj
         H7wMtdYZV4Eaq0xCNXR2qZnn6wZFDfqmTC0bD5eJn88ip2vroKDrRcHUZcp0WorX/zgb
         nSng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781110792; x=1781715592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA1F68F7pS3PUZhwBmf1Gf27tGmUxdTRKeKSh56YDVQ=;
        b=Xh2Jl61tQb0gPFs6XsatPrz06g2JUwCQNCLMfsfV26VhHXILL33pZPeHhx/svcrwUA
         Tx8+7linCeevn8oJqcYxKrnVEL2wrPjCKQM5w4st/i8I4EcxNayMxkIWKssgQU9RUfIX
         V92z7CxCvTe3KFGrn517/7BL/hOhAzMaTiAYv5Xj4J0Ml0CvhNJ5kJ5hWpwW8YeK70LY
         Md1ezrPmn6NnEIWkz4wrm3c/0hxf0ICPeKgiLJjdpTNEUXfvb0/cgWxKzesGqotzpMl6
         0EW3ufLiCp8u+BsFREQ5VsdJnjTHssTAn5rSXB0OnsNgQ1pYGENKOuSZUW59Z14tR9rD
         WXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781110792; x=1781715592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XA1F68F7pS3PUZhwBmf1Gf27tGmUxdTRKeKSh56YDVQ=;
        b=S4u1E3iWrAoR5Mjn0NCkDjw+5YmDAeCdpqacTd4gY0YqiwfJk3TMUKn8YwqT/TaVW6
         ToSgafkkiHC1yo4p9LA9HA18ElcCjlGmcZK75YAICECKqtTypJ3Po5rQwMA9wQdlr53b
         JVy0n7EZvhoC8/aExKKVRYnTE0sInRcNOxUDf6QNffIrggGTHT8hg4lsOEkBoSehF46K
         DLZoN0botxJGE2qmNMJelN60bW7zjk48bojpbgOxdQIuNP/2jjZ9Z6q6edf+H/PDsksq
         hQSNMkbSi9gv7KKfW7MkrzODjjDPZLvK8bbFuclOYqR+ZR4hdr6APN3RxSjCRS+1JrOe
         VZhw==
X-Gm-Message-State: AOJu0YxlmP7OjfmwbGdTYpezUvCbBDV2pab6M5YNEzb2i6SpNnlU+ICf
	zbhyfkB1MFAcyBaa7AOWkuthMqRZfCLWzR/tpp+M/+P7Hw7znX2iXB84cqAbcdjpw1I7yKEg0pn
	Rm9J2DQKEkRZOfc6Cso25bXKJqa6VOi4=
X-Gm-Gg: Acq92OH+rh1zS/b4BviInQ32IivX0bP2n50OxL/8T+s4wPQZJqcOrz7vhCUb1znS2Wy
	LRxzJH0LRYB5ZjMj3MhHh3ieCHkfo/SkEZi08DcASBKS+P//S/+ZJvh6Xc91z2cGvxlIum7jhoU
	ZUvNwcZOdCdNXxnaVHfgY6JF6AuCi2tdZLUSHTpxcGz7ZoDMx4HizWlyL0x+NZ5/I/t3LiB2Iox
	gR6MOjd6E9V4zCN8qdJd89GphFPTSV5dgpNhmdW6F/l2f0UL0fCkK0i6lWtAM/MkxjzJuvLd5VN
	tEg4ZITd5U8BN5Yap8DOKVAV2W7tUZ8pggntKQyFBEpKO51CKTnYb+EGxa+CMf1bEoNJwg/iCmN
	n9dh8
X-Received: by 2002:a05:690e:4842:b0:660:6780:f3e4 with SMTP id
 956f58d0204a3-66106f5ee9amr16755739d50.27.1781110792289; Wed, 10 Jun 2026
 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603150835.3539963-1-oss@fourdim.xyz> <20260603150835.3539963-2-oss@fourdim.xyz>
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
 <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com> <13e2aafc-8a4c-4c00-b38a-b09deda670ce@app.fastmail.com>
 <CABBYNZK2tzGe9CKcwBb7SxGzE94Y04z_VvaoFLoQPJ=3m=MUgQ@mail.gmail.com> <3cf8c12c-10c3-4ba8-9037-7e41a820d23d@app.fastmail.com>
In-Reply-To: <3cf8c12c-10c3-4ba8-9037-7e41a820d23d@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 12:59:41 -0400
X-Gm-Features: AVVi8Ce_pIlqp-DkvMsaP9ffy2f1U7sEjIMAzIpI4Z12STKSa2-w0sJxVR3NWD4
Message-ID: <CABBYNZJsyPU5wr4T32Ej9Vj0=Nco=PjtQn4aiC=NqUGbgP3zBw@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, Jun 10, 2026 at 12:33=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrot=
e:
>
>
>
> On Wed, Jun 10, 2026, at 11:57 AM, Luiz Augusto von Dentz wrote:
> > Hi Siwei,
> >
> > On Mon, Jun 8, 2026 at 9:29=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wr=
ote:
> >>
> >> Hi Luiz,
> >>
> >> On Thu, Jun 4, 2026, at 11:52 AM, Siwei Zhang wrote:
> >> > Hi Luiz,
> >> >
> >> > On Wed, Jun 3, 2026, at 2:17 PM, Luiz Augusto von Dentz wrote:
> >> >> Hi Siwei,
> >> >>
> >> >> On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fourdim.xy=
z> wrote:
> >> >>>
> >> >>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
> >> >>> release_sock(parent). Once the parent lock is released, the child
> >> >>> socket sk can be freed by another task.
> >> >>>
> >> >>> Allocate the channel outside the func to prevent this.
> >> >>>
> >> >>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l=
2cap_core.c")
> >> >>> Cc: stable@kernel.org
> >> >>> Assisted-by: Claude:claude-opus-4-8
> >> >>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> >> >>> ---
> >> >>>  include/net/bluetooth/l2cap.h | 10 +++--
> >> >>>  net/bluetooth/6lowpan.c       | 31 +++++++------
> >> >>>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
> >> >>>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++---------=
-----
> >> >>>  net/bluetooth/smp.c           | 17 ++++---
> >> >>>  5 files changed, 113 insertions(+), 69 deletions(-)
> >> >>>
> >> >>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth=
/l2cap.h
> >> >>> index e0a1f2293679..7f5e4647f6e0 100644
> >> >>> --- a/include/net/bluetooth/l2cap.h
> >> >>> +++ b/include/net/bluetooth/l2cap.h
> >> >>> @@ -620,7 +620,9 @@ struct l2cap_chan {
> >> >>>  struct l2cap_ops {
> >> >>>         char                    *name;
> >> >>>
> >> >>> -       struct l2cap_chan       *(*new_connection) (struct l2cap_c=
han *chan);
> >> >>> +       int                     (*new_connection)(struct l2cap_con=
n *conn,
> >> >>> +                                                 struct l2cap_cha=
n *chan,
> >> >>> +                                                 struct l2cap_cha=
n *new_chan);
> >> >>>         int                     (*recv) (struct l2cap_chan * chan,
> >> >>>                                          struct sk_buff *skb);
> >> >>>         void                    (*teardown) (struct l2cap_chan *ch=
an, int err);
> >> >>> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2cap_c=
han *chan, __u16 seq)
> >> >>>         return (seq + 1) % (chan->tx_win_max + 1);
> >> >>>  }
> >> >>>
> >> >>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(str=
uct l2cap_chan *chan)
> >> >>> +static inline int l2cap_chan_no_new_connection(struct l2cap_conn =
*conn,
> >> >>> +                                              struct l2cap_chan *=
chan,
> >> >>> +                                              struct l2cap_chan *=
new_chan)
> >> >>>  {
> >> >>> -       return NULL;
> >> >>> +       return -EOPNOTSUPP;
> >> >>>  }
> >> >>>
> >> >>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, str=
uct sk_buff *skb)
> >> >>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> >> >>> index cb1e329d66fd..94863af97a44 100644
> >> >>> --- a/net/bluetooth/6lowpan.c
> >> >>> +++ b/net/bluetooth/6lowpan.c
> >> >>> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn *hc=
on)
> >> >>>         return true;
> >> >>>  }
> >> >>>
> >> >>> +static void chan_init(struct l2cap_chan *chan)
> >> >>> +{
> >> >>> +       l2cap_chan_set_defaults(chan);
> >> >>> +
> >> >>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> >> >>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >> >>> +       chan->imtu =3D 1280;
> >> >>> +}
> >> >>> +
> >> >>>  static struct l2cap_chan *chan_create(void)
> >> >>>  {
> >> >>>         struct l2cap_chan *chan;
> >> >>> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void)
> >> >>>         if (!chan)
> >> >>>                 return NULL;
> >> >>>
> >> >>> -       l2cap_chan_set_defaults(chan);
> >> >>> -
> >> >>> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> >> >>> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >> >>> -       chan->imtu =3D 1280;
> >> >>> +       chan_init(chan);
> >> >>>
> >> >>>         return chan;
> >> >>>  }
> >> >>> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct l2ca=
p_chan *chan)
> >> >>>         ifup(dev->netdev);
> >> >>>  }
> >> >>>
> >> >>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_ch=
an *pchan)
> >> >>> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
> >> >>> +                                  struct l2cap_chan *pchan,
> >> >>> +                                  struct l2cap_chan *chan)
> >> >>>  {
> >> >>> -       struct l2cap_chan *chan;
> >> >>> -
> >> >>> -       chan =3D chan_create();
> >> >>> -       if (!chan)
> >> >>> -               return NULL;
> >> >>> -
> >> >>> +       chan_init(chan);
>
> ref1: chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED; set
> in chan_init.
>
> >> >>>         chan->ops =3D pchan->ops;
> >> >>>
> >> >>> +       /* Take the conn list reference; see l2cap_new_connection(=
). */
> >> >>> +       __l2cap_chan_add(conn, chan);
> >> >>> +
> >> >>>         BT_DBG("chan %p pchan %p", chan, pchan);
> >> >>>
> >> >>> -       return chan;
> >> >>> +       return 0;
> >> >>>  }
> >> >>>
> >> >>>  static void unregister_dev(struct lowpan_btle_dev *dev)
> >> >>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core=
.c
> >> >>> index c4ccfbda9d78..62acf90837fb 100644
> >> >>> --- a/net/bluetooth/l2cap_core.c
> >> >>> +++ b/net/bluetooth/l2cap_core.c
> >> >>> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(struct =
l2cap_conn *conn,
> >> >>>         return 0;
> >> >>>  }
> >> >>>
> >> >>> +/* Allocate and initialise a channel for an incoming connection.
> >> >>> + *
> >> >>> + * ->new_connection() initialises the channel and links it into @=
conn with
> >> >>> + * __l2cap_chan_add(). The l2cap_chan_create() reference becomes =
the one owned
> >> >>> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or peer=
->chan) and is
> >> >>> + * released by its teardown callback; the conn list reference is =
released by
> >> >>> + * l2cap_chan_del().
> >> >>> + */
> >> >>> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn =
*conn,
> >> >>> +                                              struct l2cap_chan *=
pchan)
> >> >>> +{
> >> >>> +       struct l2cap_chan *chan;
> >> >>> +
> >> >>> +       chan =3D l2cap_chan_create();
> >> >>> +       if (!chan)
> >> >>> +               return NULL;
> >> >>> +
> >> >>> +       if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
> >> >>> +               l2cap_chan_put(chan);
> >> >>> +               return NULL;
> >> >>> +       }
> >> >>
> >> >> I don't quite get why we can't just place __l2cap_chan_add here
> >> >> instead of having it called by new_connection callbacks?
> >> >>
> >> >
> >> > It's specifically the l2cap_sock_new_connection_cb() case - the very
> >> > use-after-free this patch fixes. The __l2cap_chan_add() has to happe=
n while
> >> > the parent lock is still held, and only the callback holds that lock=
.
> >> >
> >> > The reference counting on the new child chan starts at one ref,
> >> > owned by the new socket:
> >> >
> >> >       /* l2cap_new_connection() */
> >> >       chan =3D l2cap_chan_create();             /* refcount =3D 1 */
> >> >       if (!chan)
> >> >               return NULL;
> >> >
> >> >       pchan->ops->new_connection(conn, pchan, chan);
> >> >
> >> > and inside the socket callback:
> >> >
> >> >       /* l2cap_sock_new_connection_cb() */
> >> >       lock_sock(parent);
> >> >       ...
> >> >       sk =3D l2cap_sock_alloc(..., new_chan);   /* sk owns the chan_=
create ref */
> >> >       ...
> >> >       l2cap_sock_init(sk, parent);
> >> >
> >> >       __l2cap_chan_add(conn, new_chan);       /* (A) conn list takes=
 a ref */
> >> >       bt_accept_enqueue(parent, sk, false);   /* (B) sk now on accep=
t queue */
> >> >
> >> >       release_sock(parent);                   /* (C) parent lock dro=
pped */
> >> >       return 0;
> >> >
> >> > The moment we hit (C), sk is reachable through the parent's accept q=
ueue, so
> >> > another task can grab and tear it down:
> >> >
> >> >       accept() -> l2cap_sock_kill() -> l2cap_sock_put_chan()
> >> >               chan->data =3D NULL;
> >> >               l2cap_chan_put(chan);           /* drops the sk's chan=
 ref */
> >> >
> >> > If __l2cap_chan_add() at (A) hadn't already taken the conn list refe=
rence,
> >> > that put would drop the last ref and free new_chan. Control then ret=
urns up
> >> > to l2cap_new_connection(), which hands the now-freed chan back to
> >> > l2cap_connect():
> >> >
> >> >       /* l2cap_connect() - runs after the callback returns */
> >> >       chan =3D l2cap_new_connection(conn, pchan);
> >> >       if (!chan)
> >> >               goto response;
> >> >       ...
> >> >       bacpy(&chan->src, &conn->hcon->src);    /* <-- UAF on freed ch=
an */
> >> >       chan->psm  =3D psm;
> >> >       chan->dcid =3D scid;
> >> >
> >> > The conn list reference taken at (A), before (C), is what keeps new_=
chan
> >> > alive across the release_sock() window so l2cap_connect() can keep u=
sing it.
> >> >
> >> > So __l2cap_chan_add() can't move out to l2cap_new_connection(): by t=
he time
> >> > the callback returns, the parent lock is already dropped and chan ma=
y already
> >> > be freed - which is exactly the race. It has to be taken inside the =
callback,
> >> > under the parent lock, before the socket is exposed.
> >
> > If you do after l2cap_new_connection, yes, but what if you do before
> > you call ->new_connect:
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 3991c179b98f..cd864f400985 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4027,8 +4027,10 @@ static struct l2cap_chan
> > *l2cap_new_connection(struct l2cap_conn *conn,
> >         if (!chan)
> >                 return NULL;
> >
> > +       __l2cap_chan_add(conn, chan);
> > +
> >         if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
> > -               l2cap_chan_put(chan);
> > +               l2cap_chan_del(chan, 0);
> >                 return NULL;
> >         }
> >
> > This means we have to call l2cap_chan_del if new_connection fails, but
> > we can eliminate other functions having to call __l2cap_chan_add with
> > this. If the issue is then having l2cap_chan_del called concurrently,
> > we can add a l2cap_chan_hold; actually, we may need a reference anyway
> > since sk can be released and call l2cap_chan_del, releasing both
> > references.
> >
>
> In:
>
> void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> {
>         ...
>         switch (chan->chan_type) {
>         case L2CAP_CHAN_CONN_ORIENTED:
>                 ...
>                 break;
>         case L2CAP_CHAN_CONN_LESS:
>                 ...
>                 break;
>         case L2CAP_CHAN_FIXED:
>                 ...
>                 break;
>         default:
>                 ...
>         }
> }
>
> Apparently it depends on chan->chan_type and it is set by ref1.
> It is only set in cb function.

Ok, this probably needs fixing in 6lowpan. These defaults should come
from the parent channel, similar to how it's done in l2cap_sock_init.
Perhaps we should promote that logic to l2cap_chan_set_defaults
passing pchan so it can initialize the channel before calling
__l2cap_chan_add.
