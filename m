Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46A44D024
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107056; cv=pass; b=MNG2rG72rBAOJp7mST3DUXe+MXzQNSrfIEeemhuNvg8UpnTrxpasrfYph+lK88zaNLkVsYB5J9+sWw6NR4aWIAA7PeA7UIY3t6zjVHk8A/5C2FrtFsL9C3yXXkknkrPLfNkcvn9t/YC6+RY2L5ctYJTfRJjrP/iaBcgTsfxQOyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107056; c=relaxed/simple;
	bh=Uk0NOO5oJeOji153dmBZX19UGQUHwafaK+pY3NNK9Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZuxSSyCQsvJ7CmTtuBcRm+8ZZhhshQEP0pNcAaZujY96WJl5ACyvIRNJO7YyGnChlBaxoBdfF7J/gcZlNep2ZXIkLY7StF3gktPtEiNlgkK56LidQ1AV+eNYo6/csO3RtcV6xhsUtMDGmjq4QT9Klx6cCsGS6vhgyUJR7tmAAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g04NegIj; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g04NegIj"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6606678420bso7188224d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 08:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781107053; cv=none;
        d=google.com; s=arc-20240605;
        b=Ev3sDZQEQ8n4yXou5GY93tQqQP1mrXZbQCGzOYsjM/fyGc2Z8dzsU+bEVnJoLo1T+O
         qhXbdc+s8s8H+ogXEO4J52nkUfkrjDcOxH9fJAwm/R84y6WKn7oxlPfOgcOIZyKrD8vB
         gxQYKvViyZBxL1Wqs0M4nuPscJlSqyk7+e66HcMkCfcIc1P7HM2Lls9XPC8gPn/riS52
         jJp/qt6ahm/TjjfPIe5QMJWWIUE7ZcFuY8Gextw2XtzFo8atdveC1u1dVmWwX6cW7O3X
         eeuWXU/1yvJeYwmOzCg80LI/wPbfDRatSv1NPmDYNPWKqLcFacglbrD1XN3z50RSeVuA
         YHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IiUnVYKri/h5xWuj1Rtk5pNbbJ1EClwZwsE1xi77AD0=;
        fh=tyIoVIdoo3GG6ZRoi/xsrXAAPlFArnFDetdoYcj+VDI=;
        b=cYJ4g04psZeRMz1WYYjZaxcJLkZPshFOg3MT0SUBEvvy/EsfVSxR+GIq1SgxMFARYJ
         EFOTn4OT2ibRjQyv9URVcjZhlRtMfFywcbByJrgPilZ+dwYaHvVIC1temqgWPaWAjvyw
         Ouc+wjTQQeszcrbbhSZiwRAQ5vLzgTz2ItFjMYSbWwc3EHUdrzSEKjOwstu5DgB63euH
         Gmk4pq4AVt9vKMvFkNSicZDH0PUqQFiCpaFt/h2VwPc1zvwz5ZtdUp2wNOauuJoFsJZY
         b4BRYUNgEwKKjbD9x4y1Xyy7wK657hDwbMnF/RQkES/w7aDvor1thvR2imhGqeVD105u
         QrIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781107053; x=1781711853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiUnVYKri/h5xWuj1Rtk5pNbbJ1EClwZwsE1xi77AD0=;
        b=g04NegIjmBKMT6JdBcMt/Jtvvb6vSHPlGlFk+8H8IrzEIhwKpUM0nblLx6LuazcTJM
         +x8Ip9JFeX0rCwVliEZPeeJOYOQTgiEnqNDYaZmC0etZ4NDIRJQFHFcE8yga7GX+0hbO
         FwqmuXMN63Ortyyzg8GnoXcibijHtRM8QczZdrU8AdfY9haWG/lj4cVt0/f80DquwPEG
         jpW5h5ciEQmtA7jPt3o5nzFdKEkHDb9HCyMFXLi9ULekBCAE/32wKpZTJElf1kpcBB0e
         59D7bsI1Q6LWussse8i+a9JaqNxmcjk/u4VeiTvKM5HrCEkIjo2sodz0dfA4YxtW9s2d
         dhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107053; x=1781711853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IiUnVYKri/h5xWuj1Rtk5pNbbJ1EClwZwsE1xi77AD0=;
        b=oEJjyb9fUyItOQn+1TuKofp3QNdHHkMqb/s3eeA8TmsmihU+ewWtX79gJiPcx4PoUs
         LG7Xl20wYDceFOrqiwOUhsvy4++tnRKWEoRXO48CxXj2m11umk1DuaiundWB+b5ZjSjc
         rrh8LhJjCUvWqfDLg7Y0j9xRcNYS/MeXzdYO3y7EYggRumlNu3QfbdfjRmEZJIdN8oM5
         6hWxmN30Z6xwpwzz8o4RSBEmxDOjWJ9C0/dGpcxAxO/AjNPOJoCimyqOkn+cxhmhSn40
         dP4EhL1Uy5ASb1kCkBcCn4P61FcNVaY4G52qhXcFt0jXcCHE3oFGm5lXYjR1ing3CYSc
         vyYw==
X-Gm-Message-State: AOJu0YzXi0Oq+EEgCB0/JAuHgZj2HCvpGRbKTKi9bIOF01v0KNVKXql6
	nm7TQMiX7H7mhdXo+4sA/wUBUdI2UyFKIB3Yy55qI8ldBpJdpaKDpnAEKUvug26KGN/14i9Aw3q
	gXtQC+3g8D7AwT2yEfPjm184PzMBNjxBQ5IKolq0aLA==
X-Gm-Gg: Acq92OFJz1G+M3kt0CxkH4/BL98wtUV4FOS4p1DsOSjCUm2Ksj0ncj2++OJgYG6Agbm
	9Tm/CQWrTZKW29ryDVOQVDyw6nVEEs0F8QKnslM72rA76sh5c4sfa4WYznkOuNyDjggFKFv5GPN
	V+XiCWW459KSpQ50q9i6r1UwdhxfGyApd9AqVbdTBgFpR63zYNFyRWkph9hZK9m9n9ky8Kftng0
	eltLfMv84EfO2qq4jAow9pKKyYGghMmSS4jw4Lr08NImRGSnYIKKxcM22e9hNuKYPeNcfvZ1pt0
	ra7MYlU4hwjtfWwz4YiloOfqGeCqYCL7kw7QqpbQHCxMugghSfR1Y0ghSoz1wjpd9NOMxPSSJcK
	U7UQC
X-Received: by 2002:a05:690e:16a1:b0:65c:7636:2b09 with SMTP id
 956f58d0204a3-66106dcb419mr23619220d50.5.1781107052699; Wed, 10 Jun 2026
 08:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603150835.3539963-1-oss@fourdim.xyz> <20260603150835.3539963-2-oss@fourdim.xyz>
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
 <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com> <13e2aafc-8a4c-4c00-b38a-b09deda670ce@app.fastmail.com>
In-Reply-To: <13e2aafc-8a4c-4c00-b38a-b09deda670ce@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jun 2026 11:57:21 -0400
X-Gm-Features: AVVi8CeUJGNkiC3txZNywdTu7sTMG_CklTAyjqTr9o4XJpgGzuUvDJToOCR2EHk
Message-ID: <CABBYNZK2tzGe9CKcwBb7SxGzE94Y04z_VvaoFLoQPJ=3m=MUgQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Mon, Jun 8, 2026 at 9:29=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote:
>
> Hi Luiz,
>
> On Thu, Jun 4, 2026, at 11:52 AM, Siwei Zhang wrote:
> > Hi Luiz,
> >
> > On Wed, Jun 3, 2026, at 2:17 PM, Luiz Augusto von Dentz wrote:
> >> Hi Siwei,
> >>
> >> On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> =
wrote:
> >>>
> >>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
> >>> release_sock(parent). Once the parent lock is released, the child
> >>> socket sk can be freed by another task.
> >>>
> >>> Allocate the channel outside the func to prevent this.
> >>>
> >>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2ca=
p_core.c")
> >>> Cc: stable@kernel.org
> >>> Assisted-by: Claude:claude-opus-4-8
> >>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> >>> ---
> >>>  include/net/bluetooth/l2cap.h | 10 +++--
> >>>  net/bluetooth/6lowpan.c       | 31 +++++++------
> >>>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
> >>>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++------------=
--
> >>>  net/bluetooth/smp.c           | 17 ++++---
> >>>  5 files changed, 113 insertions(+), 69 deletions(-)
> >>>
> >>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2=
cap.h
> >>> index e0a1f2293679..7f5e4647f6e0 100644
> >>> --- a/include/net/bluetooth/l2cap.h
> >>> +++ b/include/net/bluetooth/l2cap.h
> >>> @@ -620,7 +620,9 @@ struct l2cap_chan {
> >>>  struct l2cap_ops {
> >>>         char                    *name;
> >>>
> >>> -       struct l2cap_chan       *(*new_connection) (struct l2cap_chan=
 *chan);
> >>> +       int                     (*new_connection)(struct l2cap_conn *=
conn,
> >>> +                                                 struct l2cap_chan *=
chan,
> >>> +                                                 struct l2cap_chan *=
new_chan);
> >>>         int                     (*recv) (struct l2cap_chan * chan,
> >>>                                          struct sk_buff *skb);
> >>>         void                    (*teardown) (struct l2cap_chan *chan,=
 int err);
> >>> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2cap_chan=
 *chan, __u16 seq)
> >>>         return (seq + 1) % (chan->tx_win_max + 1);
> >>>  }
> >>>
> >>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct=
 l2cap_chan *chan)
> >>> +static inline int l2cap_chan_no_new_connection(struct l2cap_conn *co=
nn,
> >>> +                                              struct l2cap_chan *cha=
n,
> >>> +                                              struct l2cap_chan *new=
_chan)
> >>>  {
> >>> -       return NULL;
> >>> +       return -EOPNOTSUPP;
> >>>  }
> >>>
> >>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct=
 sk_buff *skb)
> >>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> >>> index cb1e329d66fd..94863af97a44 100644
> >>> --- a/net/bluetooth/6lowpan.c
> >>> +++ b/net/bluetooth/6lowpan.c
> >>> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
> >>>         return true;
> >>>  }
> >>>
> >>> +static void chan_init(struct l2cap_chan *chan)
> >>> +{
> >>> +       l2cap_chan_set_defaults(chan);
> >>> +
> >>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> >>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >>> +       chan->imtu =3D 1280;
> >>> +}
> >>> +
> >>>  static struct l2cap_chan *chan_create(void)
> >>>  {
> >>>         struct l2cap_chan *chan;
> >>> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void)
> >>>         if (!chan)
> >>>                 return NULL;
> >>>
> >>> -       l2cap_chan_set_defaults(chan);
> >>> -
> >>> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> >>> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >>> -       chan->imtu =3D 1280;
> >>> +       chan_init(chan);
> >>>
> >>>         return chan;
> >>>  }
> >>> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct l2cap_c=
han *chan)
> >>>         ifup(dev->netdev);
> >>>  }
> >>>
> >>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan =
*pchan)
> >>> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
> >>> +                                  struct l2cap_chan *pchan,
> >>> +                                  struct l2cap_chan *chan)
> >>>  {
> >>> -       struct l2cap_chan *chan;
> >>> -
> >>> -       chan =3D chan_create();
> >>> -       if (!chan)
> >>> -               return NULL;
> >>> -
> >>> +       chan_init(chan);
> >>>         chan->ops =3D pchan->ops;
> >>>
> >>> +       /* Take the conn list reference; see l2cap_new_connection(). =
*/
> >>> +       __l2cap_chan_add(conn, chan);
> >>> +
> >>>         BT_DBG("chan %p pchan %p", chan, pchan);
> >>>
> >>> -       return chan;
> >>> +       return 0;
> >>>  }
> >>>
> >>>  static void unregister_dev(struct lowpan_btle_dev *dev)
> >>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >>> index c4ccfbda9d78..62acf90837fb 100644
> >>> --- a/net/bluetooth/l2cap_core.c
> >>> +++ b/net/bluetooth/l2cap_core.c
> >>> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(struct l2c=
ap_conn *conn,
> >>>         return 0;
> >>>  }
> >>>
> >>> +/* Allocate and initialise a channel for an incoming connection.
> >>> + *
> >>> + * ->new_connection() initialises the channel and links it into @con=
n with
> >>> + * __l2cap_chan_add(). The l2cap_chan_create() reference becomes the=
 one owned
> >>> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or peer->c=
han) and is
> >>> + * released by its teardown callback; the conn list reference is rel=
eased by
> >>> + * l2cap_chan_del().
> >>> + */
> >>> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *co=
nn,
> >>> +                                              struct l2cap_chan *pch=
an)
> >>> +{
> >>> +       struct l2cap_chan *chan;
> >>> +
> >>> +       chan =3D l2cap_chan_create();
> >>> +       if (!chan)
> >>> +               return NULL;
> >>> +
> >>> +       if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
> >>> +               l2cap_chan_put(chan);
> >>> +               return NULL;
> >>> +       }
> >>
> >> I don't quite get why we can't just place __l2cap_chan_add here
> >> instead of having it called by new_connection callbacks?
> >>
> >
> > It's specifically the l2cap_sock_new_connection_cb() case - the very
> > use-after-free this patch fixes. The __l2cap_chan_add() has to happen w=
hile
> > the parent lock is still held, and only the callback holds that lock.
> >
> > The reference counting on the new child chan starts at one ref,
> > owned by the new socket:
> >
> >       /* l2cap_new_connection() */
> >       chan =3D l2cap_chan_create();             /* refcount =3D 1 */
> >       if (!chan)
> >               return NULL;
> >
> >       pchan->ops->new_connection(conn, pchan, chan);
> >
> > and inside the socket callback:
> >
> >       /* l2cap_sock_new_connection_cb() */
> >       lock_sock(parent);
> >       ...
> >       sk =3D l2cap_sock_alloc(..., new_chan);   /* sk owns the chan_cre=
ate ref */
> >       ...
> >       l2cap_sock_init(sk, parent);
> >
> >       __l2cap_chan_add(conn, new_chan);       /* (A) conn list takes a =
ref */
> >       bt_accept_enqueue(parent, sk, false);   /* (B) sk now on accept q=
ueue */
> >
> >       release_sock(parent);                   /* (C) parent lock droppe=
d */
> >       return 0;
> >
> > The moment we hit (C), sk is reachable through the parent's accept queu=
e, so
> > another task can grab and tear it down:
> >
> >       accept() -> l2cap_sock_kill() -> l2cap_sock_put_chan()
> >               chan->data =3D NULL;
> >               l2cap_chan_put(chan);           /* drops the sk's chan re=
f */
> >
> > If __l2cap_chan_add() at (A) hadn't already taken the conn list referen=
ce,
> > that put would drop the last ref and free new_chan. Control then return=
s up
> > to l2cap_new_connection(), which hands the now-freed chan back to
> > l2cap_connect():
> >
> >       /* l2cap_connect() - runs after the callback returns */
> >       chan =3D l2cap_new_connection(conn, pchan);
> >       if (!chan)
> >               goto response;
> >       ...
> >       bacpy(&chan->src, &conn->hcon->src);    /* <-- UAF on freed chan =
*/
> >       chan->psm  =3D psm;
> >       chan->dcid =3D scid;
> >
> > The conn list reference taken at (A), before (C), is what keeps new_cha=
n
> > alive across the release_sock() window so l2cap_connect() can keep usin=
g it.
> >
> > So __l2cap_chan_add() can't move out to l2cap_new_connection(): by the =
time
> > the callback returns, the parent lock is already dropped and chan may a=
lready
> > be freed - which is exactly the race. It has to be taken inside the cal=
lback,
> > under the parent lock, before the socket is exposed.

If you do after l2cap_new_connection, yes, but what if you do before
you call ->new_connect:

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3991c179b98f..cd864f400985 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4027,8 +4027,10 @@ static struct l2cap_chan
*l2cap_new_connection(struct l2cap_conn *conn,
        if (!chan)
                return NULL;

+       __l2cap_chan_add(conn, chan);
+
        if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
-               l2cap_chan_put(chan);
+               l2cap_chan_del(chan, 0);
                return NULL;
        }

This means we have to call l2cap_chan_del if new_connection fails, but
we can eliminate other functions having to call __l2cap_chan_add with
this. If the issue is then having l2cap_chan_del called concurrently,
we can add a l2cap_chan_hold; actually, we may need a reference anyway
since sk can be released and call l2cap_chan_del, releasing both
references.

> > The other callbacks (6lowpan, smp) have no equivalent lock-drop window.
> >  I kept __l2cap_chan_add() inside all of the ->new_connection() callbac=
ks
> > just to keep the "callback links the channel into conn" contract unifor=
m.
> >
>
> Could you please check this?
> Just remind you in case you miss this.
>
> >>> +
> >>> +       return chan;
> >>> +}
> >>> +
> >>>  static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_=
hdr *cmd,
> >>>                           u8 *data, u8 rsp_code)
> >>>  {
> >>> @@ -4053,7 +4078,7 @@ static void l2cap_connect(struct l2cap_conn *co=
nn, struct l2cap_cmd_hdr *cmd,
> >>>                 goto response;
> >>>         }
> >>>
> >>> -       chan =3D pchan->ops->new_connection(pchan);
> >>> +       chan =3D l2cap_new_connection(conn, pchan);
> >>>         if (!chan)
> >>>                 goto response;
> >>>
> >>> @@ -4071,8 +4096,6 @@ static void l2cap_connect(struct l2cap_conn *co=
nn, struct l2cap_cmd_hdr *cmd,
> >>>         chan->psm  =3D psm;
> >>>         chan->dcid =3D scid;
> >>>
> >>> -       __l2cap_chan_add(conn, chan);
> >>> -
> >>>         dcid =3D chan->scid;
> >>>
> >>>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
> >>> @@ -4955,7 +4978,7 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
> >>>                 goto response_unlock;
> >>>         }
> >>>
> >>> -       chan =3D pchan->ops->new_connection(pchan);
> >>> +       chan =3D l2cap_new_connection(conn, pchan);
> >>>         if (!chan) {
> >>>                 result =3D L2CAP_CR_LE_NO_MEM;
> >>>                 goto response_unlock;
> >>> @@ -4970,8 +4993,6 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
> >>>         chan->omtu =3D mtu;
> >>>         chan->remote_mps =3D mps;
> >>>
> >>> -       __l2cap_chan_add(conn, chan);
> >>> -
> >>>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
> >>>
> >>>         dcid =3D chan->scid;
> >>> @@ -5179,7 +5200,7 @@ static inline int l2cap_ecred_conn_req(struct l=
2cap_conn *conn,
> >>>                         continue;
> >>>                 }
> >>>
> >>> -               chan =3D pchan->ops->new_connection(pchan);
> >>> +               chan =3D l2cap_new_connection(conn, pchan);
> >>>                 if (!chan) {
> >>>                         result =3D L2CAP_CR_LE_NO_MEM;
> >>>                         continue;
> >>> @@ -5194,8 +5215,6 @@ static inline int l2cap_ecred_conn_req(struct l=
2cap_conn *conn,
> >>>                 chan->omtu =3D mtu;
> >>>                 chan->remote_mps =3D mps;
> >>>
> >>> -               __l2cap_chan_add(conn, chan);
> >>> -
> >>>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
> >>>
> >>>                 /* Init response */
> >>> @@ -7470,14 +7489,12 @@ static void l2cap_connect_cfm(struct hci_conn=
 *hcon, u8 status)
> >>>                         goto next;
> >>>
> >>>                 l2cap_chan_lock(pchan);
> >>> -               chan =3D pchan->ops->new_connection(pchan);
> >>> +               chan =3D l2cap_new_connection(conn, pchan);
> >>>                 if (chan) {
> >>>                         bacpy(&chan->src, &hcon->src);
> >>>                         bacpy(&chan->dst, &hcon->dst);
> >>>                         chan->src_type =3D bdaddr_src_type(hcon);
> >>>                         chan->dst_type =3D dst_type;
> >>> -
> >>> -                       __l2cap_chan_add(conn, chan);
> >>>                 }
> >>>
> >>>                 l2cap_chan_unlock(pchan);
> >>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> >>> index 025329636353..87f4c0db5c0c 100644
> >>> --- a/net/bluetooth/l2cap_sock.c
> >>> +++ b/net/bluetooth/l2cap_sock.c
> >>> @@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list =3D {
> >>>  static const struct proto_ops l2cap_sock_ops;
> >>>  static void l2cap_sock_init(struct sock *sk, struct sock *parent);
> >>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket =
*sock,
> >>> -                                    int proto, gfp_t prio, int kern)=
;
> >>> +                                    int proto, gfp_t prio, int kern,
> >>> +                                    struct l2cap_chan *chan);
> >>>  static void l2cap_sock_cleanup_listen(struct sock *parent);
> >>>
> >>>  bool l2cap_is_socket(struct socket *sock)
> >>> @@ -1287,6 +1288,23 @@ static int l2cap_sock_recvmsg(struct socket *s=
ock, struct msghdr *msg,
> >>>         return err;
> >>>  }
> >>>
> >>> +/* Release the sock's ref on chan and clear the pointer so that the =
ref is
> >>> + * dropped exactly once even if both l2cap_sock_kill() and
> >>> + * l2cap_sock_destruct() run. Setting chan->data to NULL first stops=
 any other
> >>> + * task from dereferencing the now-dead sock pointer.
> >>> + */
> >>> +static void l2cap_sock_put_chan(struct sock *sk)
> >>> +{
> >>> +       struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> >>> +
> >>> +       if (!chan)
> >>> +               return;
> >>> +
> >>> +       chan->data =3D NULL;
> >>> +       l2cap_pi(sk)->chan =3D NULL;
> >>> +       l2cap_chan_put(chan);
> >>> +}
> >>> +
> >>>  /* Kill socket (only if zapped and orphan)
> >>>   * Must be called on unlocked socket, with l2cap channel lock.
> >>>   */
> >>> @@ -1297,13 +1315,9 @@ static void l2cap_sock_kill(struct sock *sk)
> >>>
> >>>         BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
> >>>
> >>> -       /* Sock is dead, so set chan data to NULL, avoid other task u=
se invalid
> >>> -        * sock pointer.
> >>> -        */
> >>> -       l2cap_pi(sk)->chan->data =3D NULL;
> >>> -       /* Kill poor orphan */
> >>> +       l2cap_sock_put_chan(sk);
> >>>
> >>> -       l2cap_chan_put(l2cap_pi(sk)->chan);
> >>> +       /* Kill poor orphan */
> >>>         sock_set_flag(sk, SOCK_DEAD);
> >>>         sock_put(sk);
> >>>  }
> >>> @@ -1546,12 +1560,14 @@ static void l2cap_sock_cleanup_listen(struct =
sock *parent)
> >>>         }
> >>>  }
> >>>
> >>> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_=
chan *chan)
> >>> +static int l2cap_sock_new_connection_cb(struct l2cap_conn *conn,
> >>> +                                       struct l2cap_chan *chan,
> >>> +                                       struct l2cap_chan *new_chan)
> >>>  {
> >>>         struct sock *sk, *parent =3D chan->data;
> >>>
> >>>         if (!parent)
> >>> -               return NULL;
> >>> +               return -EINVAL;
> >>>
> >>>         lock_sock(parent);
> >>>
> >>> @@ -1559,25 +1575,33 @@ static struct l2cap_chan *l2cap_sock_new_conn=
ection_cb(struct l2cap_chan *chan)
> >>>         if (sk_acceptq_is_full(parent)) {
> >>>                 BT_DBG("backlog full %d", parent->sk_ack_backlog);
> >>>                 release_sock(parent);
> >>> -               return NULL;
> >>> +               return -ENOBUFS;
> >>>         }
> >>>
> >>>         sk =3D l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP=
,
> >>> -                             GFP_ATOMIC, 0);
> >>> +                             GFP_ATOMIC, 0, new_chan);
> >>>         if (!sk) {
> >>>                 release_sock(parent);
> >>> -               return NULL;
> >>> -        }
> >>> +               return -ENOMEM;
> >>> +       }
> >>>
> >>>         bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
> >>>
> >>>         l2cap_sock_init(sk, parent);
> >>>
> >>> +       /* Link the channel into conn before exposing the new socket =
via the
> >>> +        * accept queue. Once release_sock() below drops the parent l=
ock the
> >>> +        * socket may be freed by another task, dropping its referenc=
e on
> >>> +        * new_chan; the conn list reference taken here keeps new_cha=
n alive so
> >>> +        * the caller can safely use it after ->new_connection() retu=
rns.
> >>> +        */
> >>> +       __l2cap_chan_add(conn, new_chan);
> >>> +
> >>>         bt_accept_enqueue(parent, sk, false);
> >>>
> >>>         release_sock(parent);
> >>>
> >>> -       return l2cap_pi(sk)->chan;
> >>> +       return 0;
> >>>  }
> >>>
> >>>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buf=
f *skb)
> >>> @@ -1874,10 +1898,7 @@ static void l2cap_sock_destruct(struct sock *s=
k)
> >>>
> >>>         BT_DBG("sk %p", sk);
> >>>
> >>> -       if (l2cap_pi(sk)->chan) {
> >>> -               l2cap_pi(sk)->chan->data =3D NULL;
> >>> -               l2cap_chan_put(l2cap_pi(sk)->chan);
> >>> -       }
> >>> +       l2cap_sock_put_chan(sk);
> >>>
> >>>         list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_bus=
y, list) {
> >>>                 kfree_skb(rx_busy->skb);
> >>> @@ -1978,10 +1999,10 @@ static struct proto l2cap_proto =3D {
> >>>  };
> >>>
> >>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket =
*sock,
> >>> -                                    int proto, gfp_t prio, int kern)
> >>> +                                    int proto, gfp_t prio, int kern,
> >>> +                                    struct l2cap_chan *chan)
> >>>  {
> >>>         struct sock *sk;
> >>> -       struct l2cap_chan *chan;
> >>>
> >>>         sk =3D bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, ke=
rn);
> >>>         if (!sk)
> >>> @@ -1992,16 +2013,7 @@ static struct sock *l2cap_sock_alloc(struct ne=
t *net, struct socket *sock,
> >>>
> >>>         INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
> >>>
> >>> -       chan =3D l2cap_chan_create();
> >>> -       if (!chan) {
> >>> -               sk_free(sk);
> >>> -               if (sock)
> >>> -                       sock->sk =3D NULL;
> >>> -               return NULL;
> >>> -       }
> >>> -
> >>> -       l2cap_chan_hold(chan);
> >>> -
> >>> +       /* The sock takes ownership of the caller's reference on chan=
. */
> >>>         l2cap_pi(sk)->chan =3D chan;
> >>>
> >>>         return sk;
> >>> @@ -2011,6 +2023,7 @@ static int l2cap_sock_create(struct net *net, s=
truct socket *sock, int protocol,
> >>>                              int kern)
> >>>  {
> >>>         struct sock *sk;
> >>> +       struct l2cap_chan *chan;
> >>>
> >>>         BT_DBG("sock %p", sock);
> >>>
> >>> @@ -2025,10 +2038,16 @@ static int l2cap_sock_create(struct net *net,=
 struct socket *sock, int protocol,
> >>>
> >>>         sock->ops =3D &l2cap_sock_ops;
> >>>
> >>> -       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern=
);
> >>> -       if (!sk)
> >>> +       chan =3D l2cap_chan_create();
> >>> +       if (!chan)
> >>>                 return -ENOMEM;
> >>>
> >>> +       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern=
, chan);
> >>> +       if (!sk) {
> >>> +               l2cap_chan_put(chan);
> >>> +               return -ENOMEM;
> >>> +       }
> >>> +
> >>>         l2cap_sock_init(sk, NULL);
> >>>         bt_sock_link(&l2cap_sk_list, sk);
> >>>         return 0;
> >>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> >>> index 1739c1989dbd..2d31c3c7bbc0 100644
> >>> --- a/net/bluetooth/smp.c
> >>> +++ b/net/bluetooth/smp.c
> >>> @@ -3204,16 +3204,12 @@ static const struct l2cap_ops smp_chan_ops =
=3D {
> >>>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
> >>>  };
> >>>
> >>> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *=
pchan)
> >>> +static inline int smp_new_conn_cb(struct l2cap_conn *conn,
> >>> +                                 struct l2cap_chan *pchan,
> >>> +                                 struct l2cap_chan *chan)
> >>>  {
> >>> -       struct l2cap_chan *chan;
> >>> -
> >>>         BT_DBG("pchan %p", pchan);
> >>>
> >>> -       chan =3D l2cap_chan_create();
> >>> -       if (!chan)
> >>> -               return NULL;
> >>> -
> >>>         chan->chan_type =3D pchan->chan_type;
> >>>         chan->ops       =3D &smp_chan_ops;
> >>>         chan->scid      =3D pchan->scid;
> >>> @@ -3229,9 +3225,12 @@ static inline struct l2cap_chan *smp_new_conn_=
cb(struct l2cap_chan *pchan)
> >>>          */
> >>>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
> >>>
> >>> -       BT_DBG("created chan %p", chan);
> >>> +       /* Take the conn list reference; see l2cap_new_connection(). =
*/
> >>> +       __l2cap_chan_add(conn, chan);
> >>>
> >>> -       return chan;
> >>> +       BT_DBG("initialised chan %p", chan);
> >>> +
> >>> +       return 0;
> >>>  }
> >>>
> >>>  static const struct l2cap_ops smp_root_chan_ops =3D {
> >>> --
> >>> 2.54.0
> >>>
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
> > Best,
> > Siwei
>
> Best,
> Siwei



--=20
Luiz Augusto von Dentz
