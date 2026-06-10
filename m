Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7740D576
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111553; cv=pass; b=NlR0mvwkdq4iAmfZiuAtN/YeqTnHzAkRtbC4d9avBh0xjHStA4sjjg7Brg7xFs6JffPoUW0JgSA0iEZXOw19CKOxKxVKOGNeOgzZx+UsLpv8IsIyLtmMIq7FWQNWqHRjKJcDizXeE1KTkG1dMx1TmKyrUMAFgwOnes132AuVWOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111553; c=relaxed/simple;
	bh=YtMmMgHR9k3p8gcsVkSbxxDmE/Z2CmbbPpQ1tQgMumA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0whTLJAHlE4Tf/j2a4XN7lrXEp1fawDV3R1uTOwShf4N6EaWKGPaO0lHOBC/aTEqrXHNQoFLu44QkNgDwaUKk12/dZbi5q97Zp95dkmMXGfdfBEmCiSbS2GjDXze0xIkrjdRQjVSMbDX6yf3XzHVDmQEl1adVIieQ3XhAkVC2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxj2r5dP; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxj2r5dP"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66049669d78so6359517d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 10:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781111551; cv=none;
        d=google.com; s=arc-20240605;
        b=kDXX1RHHHHpcFX8DN5MOMxhJ3stlg3gz4uxC+MNCmeGt78tDz69Qh7G3TOsxEa/XgL
         BMLJDGMi6qdEN2plLXSctAntOwZ0LKTdbPo7sDMzxfbW21Xdm6vMIR4rU+70jyeCLe8o
         ggxKALHDr5MWV3AXtPbcM5oxDJReZ9Kaj6YsNXjnEAaH8unD216mZC7fD/Ceq7+Ty8RZ
         LWOF7099pwJ07qrM7u5EjtWSY5LLks7Woe48Oji2s0YP//C2oDOjs/Frv24LbbrlzG+1
         rDuI4AM60CRX8GU5rTN/6OhbgrEtM+vlT5vnasGdPFbJN99bf/1rMAl9I/XkfY6ufsRu
         lo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJuFh1AYwleSP7Pext0SnPPCMVXnogef4DYa7fx1Zek=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=TDKmpTZnDQIgvYEvH8Qc5WmkuMwBoFufCuyEDZaCXPOE1SuoD0uRMoHri567jrBhOy
         S2xJ7tcIL80ZKmzHy2PX3MlrOxrvQzhAsQ+kXRzbqnqJ5kfn2iHJDb488PdIjtkvpX4n
         dgrhynPLjSfz4Xybd5wEa33gbf6HNLI6yxCKJ5QxItmqyBdzx4nZzHEC9uxN1Gg/wn+5
         EJgcF//v6nFmlGHzYoR5Msu8+5es9jXiCIYi7nuulCcLR+JWgo6W8EqX6991v0Ln2Wqo
         a120W9eY5PYGWcRdNIxI+K1FujdRPwrLvraFOm6tccCPHWddxkCbsg4Ds8aEWoEWTAZ3
         fQgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781111551; x=1781716351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJuFh1AYwleSP7Pext0SnPPCMVXnogef4DYa7fx1Zek=;
        b=kxj2r5dPPC6WUFZ2unCTOIUBazmxgGnZdasB6p2Q4VZFETRttObV/LIf4vNfsRaNRr
         aq+gp1UkgVwBGhvnC2MzerWLoFRLDFIl36Dp6v1+c0F+ls+mC9/JTZE0dP6xM2Kk4x/G
         VECWMywVoDgsYpt4OILRsSqFmDKSnH/MQfxXE69oDDAKuEWgK5cxgQ4jmDuDwUTDYtB0
         ToE2fsyNom8xBa8vmyVnkKJ+b/4+HcERCU9ndo+mMMvPyW0rVZDltBbeUy/1opdp9qq9
         zsVxIizgyi1swtpBudMDhUqBsISoWW9X3Yn/izHFkYFgvQMLxYy4LzUqQrMNwG5Fzg4Q
         C4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111551; x=1781716351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wJuFh1AYwleSP7Pext0SnPPCMVXnogef4DYa7fx1Zek=;
        b=ibAVMdhxFMy71lLy1u4IMIXR9OMp8rixEBSLIvNFES3TBAXn8RbP65UToIYop3W7Rt
         xTrEcSBKoNet8y6eFFW1T05KpOhgoCWxYQMAbQHrzjcr+d3u/dTfufZx2vrAWJrcLR4+
         oKLILLij0ze8dGeIdqdGo0aLigb9Rt7D/d2lC7yudaB6dn6Sm/fArlH6JAge5M5niqoo
         4z72LPqSh2Lt/Lz0t3NnGbsoYhTZqwSjR5c7G/G14iriwkjw213NT+74Cv8rZqZ+zgjt
         hbimigdBAMEskmMYrjJAEfh381XLZ0XlogEHlDD6UcH2NqYckzrF8o8hyvMqB4WOMh5S
         nHSQ==
X-Gm-Message-State: AOJu0YxZ9DXlOHY6aATQHc0ZVbKuOnFoSFVhivqx9yBJhrlh36m+6efx
	BoUqxYUlI/gjsqX/06wZigjTT3eET1/auguxI377EZ8TsHagDrQDIc7qdwSTebDxLmH7LjLCfwq
	pj1IeZFSEo5WtYFGicYsLcbAzvWpGGDpzv6MZUWE=
X-Gm-Gg: Acq92OFq9wEwFQbLIkOuZqf5msrr5/IGqs6zbAMqYjFslip6kN8MAy3Pkfy32FAVb5k
	SIhY7iLqOqvbDpL2zeck/BZXh0PWTE6yVKfhn7b4w+wtiWc4xp+RawgsX3azdPSGieLSUmI8kCg
	iYEwEMi0ULzBy7sR4hWLz8BLbFGpzL6cKty/ytTVY+JKOfevohZj9nWFrSMaPvg2OfBEgjX4hui
	lMN6kOZKCDN1n8GrUdGIPPdurmC00QOVIn40gLHfjljZRcC5bxWDIxtUEBi4hlwUo/2r3cY4X3b
	JzVMArjeHPbQb2QLxNNOB4uJSs62gXJjDn/FDjADR2VfKUfP8IkYr6dPyj1Pl22UtWttDGhNStP
	1XAEC
X-Received: by 2002:a05:690e:4395:b0:660:6f06:ae6e with SMTP id
 956f58d0204a3-661070ce78amr17192822d50.64.1781111550278; Wed, 10 Jun 2026
 10:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603150835.3539963-1-oss@fourdim.xyz> <20260603150835.3539963-2-oss@fourdim.xyz>
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
 <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com> <13e2aafc-8a4c-4c00-b38a-b09deda670ce@app.fastmail.com>
 <CABBYNZK2tzGe9CKcwBb7SxGzE94Y04z_VvaoFLoQPJ=3m=MUgQ@mail.gmail.com>
 <3cf8c12c-10c3-4ba8-9037-7e41a820d23d@app.fastmail.com> <CABBYNZJsyPU5wr4T32Ej9Vj0=Nco=PjtQn4aiC=NqUGbgP3zBw@mail.gmail.com>
 <e9720437-0673-4428-9be2-203404e5cbec@app.fastmail.com>
In-Reply-To: <e9720437-0673-4428-9be2-203404e5cbec@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 13:12:18 -0400
X-Gm-Features: AVVi8Ce-LrYesRsTjHPzGnr12N0kucdaUBYnVQowaHuWPOJ_uoyL_UD2DDMZT-8
Message-ID: <CABBYNZKuKSs938J6Pt_gqJzj4s1vz3wTGzJsfowS7H_n6mPd4A@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, Jun 10, 2026 at 1:03=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrote=
:
>
>
> On Wed, Jun 10, 2026, at 12:59 PM, Luiz Augusto von Dentz wrote:
> > Hi Siwei,
> >
> > On Wed, Jun 10, 2026 at 12:33=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> =
wrote:
> >>
> >>
> >>
> >> On Wed, Jun 10, 2026, at 11:57 AM, Luiz Augusto von Dentz wrote:
> >> > Hi Siwei,
> >> >
> >> > On Mon, Jun 8, 2026 at 9:29=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz>=
 wrote:
> >> >>
> >> >> Hi Luiz,
> >> >>
> >> >> On Thu, Jun 4, 2026, at 11:52 AM, Siwei Zhang wrote:
> >> >> > Hi Luiz,
> >> >> >
> >> >> > On Wed, Jun 3, 2026, at 2:17 PM, Luiz Augusto von Dentz wrote:
> >> >> >> Hi Siwei,
> >> >> >>
> >> >> >> On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fourdim=
.xyz> wrote:
> >> >> >>>
> >> >> >>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan afte=
r
> >> >> >>> release_sock(parent). Once the parent lock is released, the chi=
ld
> >> >> >>> socket sk can be freed by another task.
> >> >> >>>
> >> >> >>> Allocate the channel outside the func to prevent this.
> >> >> >>>
> >> >> >>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage fro=
m l2cap_core.c")
> >> >> >>> Cc: stable@kernel.org
> >> >> >>> Assisted-by: Claude:claude-opus-4-8
> >> >> >>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> >> >> >>> ---
> >> >> >>>  include/net/bluetooth/l2cap.h | 10 +++--
> >> >> >>>  net/bluetooth/6lowpan.c       | 31 +++++++------
> >> >> >>>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
> >> >> >>>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++------=
--------
> >> >> >>>  net/bluetooth/smp.c           | 17 ++++---
> >> >> >>>  5 files changed, 113 insertions(+), 69 deletions(-)
> >> >> >>>
> >> >> >>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/blueto=
oth/l2cap.h
> >> >> >>> index e0a1f2293679..7f5e4647f6e0 100644
> >> >> >>> --- a/include/net/bluetooth/l2cap.h
> >> >> >>> +++ b/include/net/bluetooth/l2cap.h
> >> >> >>> @@ -620,7 +620,9 @@ struct l2cap_chan {
> >> >> >>>  struct l2cap_ops {
> >> >> >>>         char                    *name;
> >> >> >>>
> >> >> >>> -       struct l2cap_chan       *(*new_connection) (struct l2ca=
p_chan *chan);
> >> >> >>> +       int                     (*new_connection)(struct l2cap_=
conn *conn,
> >> >> >>> +                                                 struct l2cap_=
chan *chan,
> >> >> >>> +                                                 struct l2cap_=
chan *new_chan);
> >> >> >>>         int                     (*recv) (struct l2cap_chan * ch=
an,
> >> >> >>>                                          struct sk_buff *skb);
> >> >> >>>         void                    (*teardown) (struct l2cap_chan =
*chan, int err);
> >> >> >>> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2ca=
p_chan *chan, __u16 seq)
> >> >> >>>         return (seq + 1) % (chan->tx_win_max + 1);
> >> >> >>>  }
> >> >> >>>
> >> >> >>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(=
struct l2cap_chan *chan)
> >> >> >>> +static inline int l2cap_chan_no_new_connection(struct l2cap_co=
nn *conn,
> >> >> >>> +                                              struct l2cap_cha=
n *chan,
> >> >> >>> +                                              struct l2cap_cha=
n *new_chan)
> >> >> >>>  {
> >> >> >>> -       return NULL;
> >> >> >>> +       return -EOPNOTSUPP;
> >> >> >>>  }
> >> >> >>>
> >> >> >>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, =
struct sk_buff *skb)
> >> >> >>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> >> >> >>> index cb1e329d66fd..94863af97a44 100644
> >> >> >>> --- a/net/bluetooth/6lowpan.c
> >> >> >>> +++ b/net/bluetooth/6lowpan.c
> >> >> >>> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn =
*hcon)
> >> >> >>>         return true;
> >> >> >>>  }
> >> >> >>>
> >> >> >>> +static void chan_init(struct l2cap_chan *chan)
> >> >> >>> +{
> >> >> >>> +       l2cap_chan_set_defaults(chan);
> >> >> >>> +
> >> >> >>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> >> >> >>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >> >> >>> +       chan->imtu =3D 1280;
> >> >> >>> +}
> >> >> >>> +
> >> >> >>>  static struct l2cap_chan *chan_create(void)
> >> >> >>>  {
> >> >> >>>         struct l2cap_chan *chan;
> >> >> >>> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void=
)
> >> >> >>>         if (!chan)
> >> >> >>>                 return NULL;
> >> >> >>>
> >> >> >>> -       l2cap_chan_set_defaults(chan);
> >> >> >>> -
> >> >> >>> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> >> >> >>> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >> >> >>> -       chan->imtu =3D 1280;
> >> >> >>> +       chan_init(chan);
> >> >> >>>
> >> >> >>>         return chan;
> >> >> >>>  }
> >> >> >>> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct l=
2cap_chan *chan)
> >> >> >>>         ifup(dev->netdev);
> >> >> >>>  }
> >> >> >>>
> >> >> >>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap=
_chan *pchan)
> >> >> >>> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
> >> >> >>> +                                  struct l2cap_chan *pchan,
> >> >> >>> +                                  struct l2cap_chan *chan)
> >> >> >>>  {
> >> >> >>> -       struct l2cap_chan *chan;
> >> >> >>> -
> >> >> >>> -       chan =3D chan_create();
> >> >> >>> -       if (!chan)
> >> >> >>> -               return NULL;
> >> >> >>> -
> >> >> >>> +       chan_init(chan);
> >>
> >> ref1: chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED; set
> >> in chan_init.
> >>
> >> >> >>>         chan->ops =3D pchan->ops;
> >> >> >>>
> >> >> >>> +       /* Take the conn list reference; see l2cap_new_connecti=
on(). */
> >> >> >>> +       __l2cap_chan_add(conn, chan);
> >> >> >>> +
> >> >> >>>         BT_DBG("chan %p pchan %p", chan, pchan);
> >> >> >>>
> >> >> >>> -       return chan;
> >> >> >>> +       return 0;
> >> >> >>>  }
> >> >> >>>
> >> >> >>>  static void unregister_dev(struct lowpan_btle_dev *dev)
> >> >> >>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_c=
ore.c
> >> >> >>> index c4ccfbda9d78..62acf90837fb 100644
> >> >> >>> --- a/net/bluetooth/l2cap_core.c
> >> >> >>> +++ b/net/bluetooth/l2cap_core.c
> >> >> >>> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(stru=
ct l2cap_conn *conn,
> >> >> >>>         return 0;
> >> >> >>>  }
> >> >> >>>
> >> >> >>> +/* Allocate and initialise a channel for an incoming connectio=
n.
> >> >> >>> + *
> >> >> >>> + * ->new_connection() initialises the channel and links it int=
o @conn with
> >> >> >>> + * __l2cap_chan_add(). The l2cap_chan_create() reference becom=
es the one owned
> >> >> >>> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or p=
eer->chan) and is
> >> >> >>> + * released by its teardown callback; the conn list reference =
is released by
> >> >> >>> + * l2cap_chan_del().
> >> >> >>> + */
> >> >> >>> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_co=
nn *conn,
> >> >> >>> +                                              struct l2cap_cha=
n *pchan)
> >> >> >>> +{
> >> >> >>> +       struct l2cap_chan *chan;
> >> >> >>> +
> >> >> >>> +       chan =3D l2cap_chan_create();
> >> >> >>> +       if (!chan)
> >> >> >>> +               return NULL;
> >> >> >>> +
> >> >> >>> +       if (pchan->ops->new_connection(conn, pchan, chan) < 0) =
{
> >> >> >>> +               l2cap_chan_put(chan);
> >> >> >>> +               return NULL;
> >> >> >>> +       }
> >> >> >>
> >> >> >> I don't quite get why we can't just place __l2cap_chan_add here
> >> >> >> instead of having it called by new_connection callbacks?
> >> >> >>
> >> >> >
> >> >> > It's specifically the l2cap_sock_new_connection_cb() case - the v=
ery
> >> >> > use-after-free this patch fixes. The __l2cap_chan_add() has to ha=
ppen while
> >> >> > the parent lock is still held, and only the callback holds that l=
ock.
> >> >> >
> >> >> > The reference counting on the new child chan starts at one ref,
> >> >> > owned by the new socket:
> >> >> >
> >> >> >       /* l2cap_new_connection() */
> >> >> >       chan =3D l2cap_chan_create();             /* refcount =3D 1=
 */
> >> >> >       if (!chan)
> >> >> >               return NULL;
> >> >> >
> >> >> >       pchan->ops->new_connection(conn, pchan, chan);
> >> >> >
> >> >> > and inside the socket callback:
> >> >> >
> >> >> >       /* l2cap_sock_new_connection_cb() */
> >> >> >       lock_sock(parent);
> >> >> >       ...
> >> >> >       sk =3D l2cap_sock_alloc(..., new_chan);   /* sk owns the ch=
an_create ref */
> >> >> >       ...
> >> >> >       l2cap_sock_init(sk, parent);
> >> >> >
> >> >> >       __l2cap_chan_add(conn, new_chan);       /* (A) conn list ta=
kes a ref */
> >> >> >       bt_accept_enqueue(parent, sk, false);   /* (B) sk now on ac=
cept queue */
> >> >> >
> >> >> >       release_sock(parent);                   /* (C) parent lock =
dropped */
> >> >> >       return 0;
> >> >> >
> >> >> > The moment we hit (C), sk is reachable through the parent's accep=
t queue, so
> >> >> > another task can grab and tear it down:
> >> >> >
> >> >> >       accept() -> l2cap_sock_kill() -> l2cap_sock_put_chan()
> >> >> >               chan->data =3D NULL;
> >> >> >               l2cap_chan_put(chan);           /* drops the sk's c=
han ref */
> >> >> >
> >> >> > If __l2cap_chan_add() at (A) hadn't already taken the conn list r=
eference,
> >> >> > that put would drop the last ref and free new_chan. Control then =
returns up
> >> >> > to l2cap_new_connection(), which hands the now-freed chan back to
> >> >> > l2cap_connect():
> >> >> >
> >> >> >       /* l2cap_connect() - runs after the callback returns */
> >> >> >       chan =3D l2cap_new_connection(conn, pchan);
> >> >> >       if (!chan)
> >> >> >               goto response;
> >> >> >       ...
> >> >> >       bacpy(&chan->src, &conn->hcon->src);    /* <-- UAF on freed=
 chan */
> >> >> >       chan->psm  =3D psm;
> >> >> >       chan->dcid =3D scid;
> >> >> >
> >> >> > The conn list reference taken at (A), before (C), is what keeps n=
ew_chan
> >> >> > alive across the release_sock() window so l2cap_connect() can kee=
p using it.
> >> >> >
> >> >> > So __l2cap_chan_add() can't move out to l2cap_new_connection(): b=
y the time
> >> >> > the callback returns, the parent lock is already dropped and chan=
 may already
> >> >> > be freed - which is exactly the race. It has to be taken inside t=
he callback,
> >> >> > under the parent lock, before the socket is exposed.
> >> >
> >> > If you do after l2cap_new_connection, yes, but what if you do before
> >> > you call ->new_connect:
> >> >
> >> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >> > index 3991c179b98f..cd864f400985 100644
> >> > --- a/net/bluetooth/l2cap_core.c
> >> > +++ b/net/bluetooth/l2cap_core.c
> >> > @@ -4027,8 +4027,10 @@ static struct l2cap_chan
> >> > *l2cap_new_connection(struct l2cap_conn *conn,
> >> >         if (!chan)
> >> >                 return NULL;
> >> >
> >> > +       __l2cap_chan_add(conn, chan);
> >> > +
> >> >         if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
> >> > -               l2cap_chan_put(chan);
> >> > +               l2cap_chan_del(chan, 0);
> >> >                 return NULL;
> >> >         }
> >> >
> >> > This means we have to call l2cap_chan_del if new_connection fails, b=
ut
> >> > we can eliminate other functions having to call __l2cap_chan_add wit=
h
> >> > this. If the issue is then having l2cap_chan_del called concurrently=
,
> >> > we can add a l2cap_chan_hold; actually, we may need a reference anyw=
ay
> >> > since sk can be released and call l2cap_chan_del, releasing both
> >> > references.
> >> >
> >>
> >> In:
> >>
> >> void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan=
)
> >> {
> >>         ...
> >>         switch (chan->chan_type) {
> >>         case L2CAP_CHAN_CONN_ORIENTED:
> >>                 ...
> >>                 break;
> >>         case L2CAP_CHAN_CONN_LESS:
> >>                 ...
> >>                 break;
> >>         case L2CAP_CHAN_FIXED:
> >>                 ...
> >>                 break;
> >>         default:
> >>                 ...
> >>         }
> >> }
> >>
> >> Apparently it depends on chan->chan_type and it is set by ref1.
> >> It is only set in cb function.
> >
> > Ok, this probably needs fixing in 6lowpan. These defaults should come
> > from the parent channel, similar to how it's done in l2cap_sock_init.
> > Perhaps we should promote that logic to l2cap_chan_set_defaults
> > passing pchan so it can initialize the channel before calling
> > __l2cap_chan_add.
>
> I can fix that in a separate patch.
> Could you please merge it first?

Merge it first, and then rework the order? Not sure what is the
benefit of doing that, it is a somewhat substatial change either way
so I don't think it will make it much easier to lets say backport.

> Best,
> Siwei



--=20
Luiz Augusto von Dentz
