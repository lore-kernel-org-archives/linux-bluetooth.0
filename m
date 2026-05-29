Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D543EBF35
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072815; cv=pass; b=Tmrynw86Pm1GqhQY1Go92/gB6wEYrtjnIs2l5lPhQnFEDumjqX/dGsq8JAtbNa+xEF9GgXHiID/xdcQ37XIPbeKDoMLFwuKs8eGMKKvBC9QLDg+VY9VZno2oh6NKI+fkhdn0xPL6Y0rFqUFfXahRoMNxkvvYU5adrPFRQ2KQhO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072815; c=relaxed/simple;
	bh=SQXa/qcDFF2MduFVWX3diW0jdBcj/sWLyGR80n9K8nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlrurzRLyGlra8PR+lfp/dQAda76c4h+tQs562DpgYsK3ErtMy+6iXJa6O0IiFvz5QsNpGfDx2MDm7gmKFOM05t4y1Z4G6c+eV7YfnVYARvfGFw5qoccIdYsYNGl/0tCVvyzmUrpAxU2ZYoyeyOppf6zxNKppGoG/56pU7njCmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEc2Rj0V; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEc2Rj0V"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e615b4c2a7so2014939a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 09:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780072812; cv=none;
        d=google.com; s=arc-20240605;
        b=WawLlL211xL0NSmB/i0qudJPmGP3X09kOu1Dc+QWFDynBTihp80JO5a+3MPMED6+iJ
         DvbX92209vtACtzVCqFizdSZGWBZGEmDmPNlKEbAejrIwF3y0PTBkV7Om120o8/gbvoP
         t6ZZOzx+5r7CwN8deREIn7Cxy2CUmKlaX34oxnyQarNL9teffxqNlEm0rp5QZNw+QyZc
         LYovDHU1/jjXdLhEH7c4Ct+ETdgFaKG4k3mhj18Vbf7lY1ZmH+VSBidzm23agD+JX1ks
         M4glQ/JLQr5ac5nb26qPpVtBsVEQnCYZ2GYyP8EvPQjK+yof1lTppaKv5z7mbefDTWg1
         ZfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cfX/CQgKqbeHfjIdkLNUgtH3YxPFlwBDmp4pl5VrB28=;
        fh=TPugDPb6gJ0lU4oYEKmHIEZt24vw74OIc5NaeVRixvs=;
        b=kQkjza1tuDWXgCSqfYQJoRTs+KPWuA7txxJlaRYInJMHV+swHsalS+5RELli80skgc
         WKmDwMp+hpRU1axqQra4iM9a5M275w8adQPNG5ljQi+hCCsIAet6flYsJFFbf4Ooi+4c
         5xsQQfTa6dviHR32zD2a1H3gaWh0WxD9I7iZ3H7CE+vQ+izbPDaF64s4MbjrJ6Xzx2xV
         zP007Grus9DrKncm1QaI+N3mASFsfx4acimgIUreLg8V6kiH4cMRfVfNd7QG9KTBitFg
         nT+3OqqohDeJ9DhF8ccRqgyzHxyPWpO5OosmrtwpXSwUqi7Vrmxehc52KtGXaU8OnTT7
         dt+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780072812; x=1780677612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfX/CQgKqbeHfjIdkLNUgtH3YxPFlwBDmp4pl5VrB28=;
        b=KEc2Rj0VQtB0UnGXxMzA6SYELVn984ADTqzLh43iojQ1knNATiaqVYbEaFLflKOUpv
         RNCMtOcBsW81wzcyB7Zb5rRjHjGQTlcHO2Y2BgPCC+rj9IqYrS5hcUx3HKiS9H/JFUgh
         DHaaMxPbwbX2UV9IbwpwfwWMDzCwEMjlx0uVEVQhySweOcBUWTujg6zicibVdKmkZEPa
         fn+WqUj6u8M8gYQb+4oEbwWjDT4iLqfnIW744Y9fk/EY1FJtQLiMgvPeLjGiEGWPAqBx
         lyaoIkNvN2L0uxN+K2qhlyqW1XQeFrdcJ2wHkpVEzAiSmSG/mS3PGxlYr82qp4qHOCQf
         M4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780072812; x=1780677612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfX/CQgKqbeHfjIdkLNUgtH3YxPFlwBDmp4pl5VrB28=;
        b=WZxicaQSpx3nZjrQoA8uitisxsU3Y0bRoOdaHQKYElwKtpXDdoq4Y3oK692e4ON/Ib
         x0Uqd41yTuwyTSLbwkKI5qfqmDgODu3O+E5szT4lPVt7kr+f+67PlTW/HfPsAxWNuC98
         rFrR2WVjh4zS4SGK7Z7jtYNPOUHpsa4hVnfCpKG0w8FkBY2WdpQbKyeoft+CSOYj43Xi
         hfe6Fu3lsgazolcMq1Ek13+Doo8GYViM83xps5NscSiUqmLkdreI4hymDbci+HRpLB2r
         JrMQrZwuIG9K6juAi/06P2BSIp9nIdiujAThdnDU0JEDwQLAoURUTNWRnTbSlNg0QcFg
         NpUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nhVCHsbN7LDKzJLboieSdqWxdYI3VBI0klaT0Ds1syVsB0HdBkh143sC7g7ALFAsW6TDZJCjJfpM/bhy7XC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4WKbsNZaZ11PpPkVxFbobnqE1YR1Mnc2odtYHlwREmoa+E1Z
	iwXVPXTmEWyOifkzqrkfz7nr6NMxEjRaTi/O/geItyjijetNgtLJV7OO3oGSNs9cMRY2voYYav7
	FWPTYeHkzk0LAQM7UMif7pUoX4HsIAUE6x1ZD4RA=
X-Gm-Gg: Acq92OFL2drg+X0JBd9eC7uyxOWvgHqDbYCTWeigxpdpaR84EF2UcX4jRZm7KjAMz9L
	N8K1MoTJLBqFOaX6YUsbgYJmXY7yrwSw00HhWBUJwQdwuJRtxNMz1u3pbZkUCu7sHLYYA/GySgT
	2khEh6RX92w5WDDva2AdSOcYW5gMB6jcwQlc3kZwHDCveLNCknuoARnRHWw/npF8DmqacO8Eu0+
	nNIgDWcheLiXsJf3azhSQWPQoi/RGB8wMCDKKl3quZYm9wIJrXAPuRFWacR85dEr3oO1BHwnNU8
	y8NDTYcwTt+n6VPzFb0/34TSGOmnwrvgdZjXmwBbaVvzZ2nbXCP58lhfGAiusStwQcGd/T9dsC+
	erqsy
X-Received: by 2002:a05:6820:1a07:b0:69d:7a88:9cc1 with SMTP id
 006d021491bc7-69e103d4c12mr12138eaf.49.1780072811948; Fri, 29 May 2026
 09:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162030.2842543-1-oss@fourdim.xyz> <20260520162030.2842543-2-oss@fourdim.xyz>
 <CABBYNZL_ymHCE+uf6kJ2Mi=R4pEwy-wcSL3HKDP0krd7D73Kqw@mail.gmail.com>
 <c45459c5-e7d9-4ea2-bd61-903a33f8778f@app.fastmail.com> <460b3909-2210-4cf3-be9e-4f8af3175160@app.fastmail.com>
In-Reply-To: <460b3909-2210-4cf3-be9e-4f8af3175160@app.fastmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 29 May 2026 12:40:00 -0400
X-Gm-Features: AVHnY4KLWFfMRqoFLBOWTpedzyyael0M-McD3T_l4qmAHYTuXN2CzzGNsNmeqFw
Message-ID: <CABBYNZLQX2DAxKYBQLDmUZ0idKxTJiFZGLw7OTbsR-c2kE4PBw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Fri, May 29, 2026 at 12:33=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrot=
e:
>
> Hi Luiz,
>
> On Wed, May 27, 2026, at 12:16 AM, Siwei Zhang wrote:
> > Hi Luiz,
> >
> > On Tue, May 26, 2026, at 4:46 PM, Luiz Augusto von Dentz wrote:
> >> Hi Siwei,
> >>
> >> On Wed, May 20, 2026 at 12:20=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz>=
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
> >>> Assisted-by: Claude:claude-opus-4-6
> >>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> >>> ---
> >>>  include/net/bluetooth/l2cap.h |  8 +++--
> >>>  net/bluetooth/6lowpan.c       | 14 ++++-----
> >>>  net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++-----=
--
> >>>  net/bluetooth/l2cap_sock.c    | 48 +++++++++++++++++------------
> >>>  net/bluetooth/smp.c           | 13 +++-----
> >>>  5 files changed, 91 insertions(+), 50 deletions(-)
> >>>
> >>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2=
cap.h
> >>> index 5172afee5494..f7a11e6431f0 100644
> >>> --- a/include/net/bluetooth/l2cap.h
> >>> +++ b/include/net/bluetooth/l2cap.h
> >>> @@ -619,7 +619,8 @@ struct l2cap_chan {
> >>>  struct l2cap_ops {
> >>>         char                    *name;
> >>>
> >>> -       struct l2cap_chan       *(*new_connection) (struct l2cap_chan=
 *chan);
> >>> +       int                     (*new_connection)(struct l2cap_chan *=
chan,
> >>> +                                                 struct l2cap_chan *=
new_chan);
> >>>         int                     (*recv) (struct l2cap_chan * chan,
> >>>                                          struct sk_buff *skb);
> >>>         void                    (*teardown) (struct l2cap_chan *chan,=
 int err);
> >>> @@ -883,9 +884,10 @@ static inline __u16 __next_seq(struct l2cap_chan=
 *chan, __u16 seq)
> >>>         return (seq + 1) % (chan->tx_win_max + 1);
> >>>  }
> >>>
> >>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct=
 l2cap_chan *chan)
> >>> +static inline int l2cap_chan_no_new_connection(struct l2cap_chan *ch=
an,
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
> >>> index 23a229ab6a33..286c0b45055b 100644
> >>> --- a/net/bluetooth/6lowpan.c
> >>> +++ b/net/bluetooth/6lowpan.c
> >>> @@ -743,19 +743,19 @@ static inline void chan_ready_cb(struct l2cap_c=
han *chan)
> >>>         ifup(dev->netdev);
> >>>  }
> >>>
> >>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan =
*pchan)
> >>> +static inline int chan_new_conn_cb(struct l2cap_chan *pchan,
> >>> +                                  struct l2cap_chan *chan)
> >>>  {
> >>> -       struct l2cap_chan *chan;
> >>> -
> >>> -       chan =3D chan_create();
> >>> -       if (!chan)
> >>> -               return NULL;
> >>> +       l2cap_chan_set_defaults(chan);
> >>>
> >>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> >>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >>> +       chan->imtu =3D 1280;
> >>
> >> The 3 lines above make no sense.
> >>
> >
> > chan_create code in 6lowpan.c
> >
> > static struct l2cap_chan *chan_create(void)
> > {
> >       struct l2cap_chan *chan;
> >
> >       chan =3D l2cap_chan_create();
> >       if (!chan)
> >               return NULL;
> >
> >       l2cap_chan_set_defaults(chan);
> >
> >       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> >       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> >       chan->imtu =3D 1280;
> >
> >       return chan;
> > }
> >
> > Since we allocate chan outside and replace the chan_create here,
> > I do think these are needed and they are specific to 6lowpan only.
> >
> > I can refactor it in this patch or in a follow-up patch. I would prefer=
 it
> > to be in a follow-up patch.
> >
>
> What do you think. Please let me know if you want me to change anything.

There is something off then, because nothing is being removed that
sets similar values which is what led me to believe it was necessary
at first.

> >>>         chan->ops =3D pchan->ops;
> >>>
> >>>         BT_DBG("chan %p pchan %p", chan, pchan);
> >>>
> >>> -       return chan;
> >>> +       return 0;
> >>>  }
> >>>
> >>>  static void unregister_dev(struct lowpan_btle_dev *dev)
> >>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> >>> index fdccd62ccca8..505f32034971 100644
> >>> --- a/net/bluetooth/l2cap_core.c
> >>> +++ b/net/bluetooth/l2cap_core.c
> >>> @@ -4051,10 +4051,16 @@ static void l2cap_connect(struct l2cap_conn *=
conn, struct l2cap_cmd_hdr *cmd,
> >>>                 goto response;
> >>>         }
> >>>
> >>> -       chan =3D pchan->ops->new_connection(pchan);
> >>> +       chan =3D l2cap_chan_create();
> >>>         if (!chan)
> >>>                 goto response;
> >>>
> >>> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
> >>> +               l2cap_chan_put(chan);
> >>> +               chan =3D NULL;
> >>> +               goto response;
> >>> +       }
> >>> +
> >>>         /* For certain devices (ex: HID mouse), support for authentic=
ation,
> >>>          * pairing and bonding is optional. For such devices, inorder=
 to avoid
> >>>          * the ACL alive for too long after L2CAP disconnection, rese=
t the ACL
> >>> @@ -4132,6 +4138,10 @@ static void l2cap_connect(struct l2cap_conn *c=
onn, struct l2cap_cmd_hdr *cmd,
> >>>                 chan->num_conf_req++;
> >>>         }
> >>>
> >>> +       /* Drop our local ref; __l2cap_chan_add() pinned chan via the=
 conn list. */
> >>> +       if (chan)
> >>> +               l2cap_chan_put(chan);
> >>> +
> >>>         l2cap_chan_unlock(pchan);
> >>>         l2cap_chan_put(pchan);
> >>>  }
> >>> @@ -4881,6 +4891,7 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
> >>>         struct l2cap_le_conn_rsp rsp;
> >>>         struct l2cap_chan *chan, *pchan;
> >>>         u16 dcid, scid, credits, mtu, mps;
> >>> +       u16 rsp_mtu, rsp_mps;
> >>>         __le16 psm;
> >>>         u8 result;
> >>>
> >>> @@ -4893,6 +4904,8 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
> >>>         psm  =3D req->psm;
> >>>         dcid =3D 0;
> >>>         credits =3D 0;
> >>> +       rsp_mtu =3D 0;
> >>> +       rsp_mps =3D 0;
> >>>
> >>>         if (mtu < 23 || mps < 23)
> >>>                 return -EPROTO;
> >>> @@ -4953,12 +4966,19 @@ static int l2cap_le_connect_req(struct l2cap_=
conn *conn,
> >>>                 goto response_unlock;
> >>>         }
> >>>
> >>> -       chan =3D pchan->ops->new_connection(pchan);
> >>> +       chan =3D l2cap_chan_create();
> >>>         if (!chan) {
> >>>                 result =3D L2CAP_CR_LE_NO_MEM;
> >>>                 goto response_unlock;
> >>>         }
> >>>
> >>> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
> >>> +               l2cap_chan_put(chan);
> >>> +               chan =3D NULL;
> >>> +               result =3D L2CAP_CR_LE_NO_MEM;
> >>> +               goto response_unlock;
> >>> +       }
> >>> +
> >>>         bacpy(&chan->src, &conn->hcon->src);
> >>>         bacpy(&chan->dst, &conn->hcon->dst);
> >>>         chan->src_type =3D bdaddr_src_type(conn->hcon);
> >>> @@ -4974,6 +4994,8 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
> >>>
> >>>         dcid =3D chan->scid;
> >>>         credits =3D chan->rx_credits;
> >>> +       rsp_mtu =3D chan->imtu;
> >>> +       rsp_mps =3D chan->mps;
> >>>
> >>>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
> >>>
> >>> @@ -4993,6 +5015,9 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
> >>>                 result =3D L2CAP_CR_LE_SUCCESS;
> >>>         }
> >>>
> >>> +       /* Drop our local ref; __l2cap_chan_add() pinned chan via the=
 conn list. */
> >>> +       l2cap_chan_put(chan);
> >>> +
> >>>  response_unlock:
> >>>         l2cap_chan_unlock(pchan);
> >>>         l2cap_chan_put(pchan);
> >>> @@ -5001,13 +5026,8 @@ static int l2cap_le_connect_req(struct l2cap_c=
onn *conn,
> >>>                 return 0;
> >>>
> >>>  response:
> >>> -       if (chan) {
> >>> -               rsp.mtu =3D cpu_to_le16(chan->imtu);
> >>> -               rsp.mps =3D cpu_to_le16(chan->mps);
> >>> -       } else {
> >>> -               rsp.mtu =3D 0;
> >>> -               rsp.mps =3D 0;
> >>> -       }
> >>> +       rsp.mtu =3D cpu_to_le16(rsp_mtu);
> >>> +       rsp.mps =3D cpu_to_le16(rsp_mps);
> >>>
> >>>         rsp.dcid    =3D cpu_to_le16(dcid);
> >>>         rsp.credits =3D cpu_to_le16(credits);
> >>> @@ -5177,12 +5197,18 @@ static inline int l2cap_ecred_conn_req(struct=
 l2cap_conn *conn,
> >>>                         continue;
> >>>                 }
> >>>
> >>> -               chan =3D pchan->ops->new_connection(pchan);
> >>> +               chan =3D l2cap_chan_create();
> >>>                 if (!chan) {
> >>>                         result =3D L2CAP_CR_LE_NO_MEM;
> >>>                         continue;
> >>>                 }
> >>>
> >>> +               if (pchan->ops->new_connection(pchan, chan) < 0) {
> >>> +                       l2cap_chan_put(chan);
> >>> +                       result =3D L2CAP_CR_LE_NO_MEM;
> >>> +                       continue;
> >>> +               }
> >>> +
> >>>                 bacpy(&chan->src, &conn->hcon->src);
> >>>                 bacpy(&chan->dst, &conn->hcon->dst);
> >>>                 chan->src_type =3D bdaddr_src_type(conn->hcon);
> >>> @@ -5217,6 +5243,9 @@ static inline int l2cap_ecred_conn_req(struct l=
2cap_conn *conn,
> >>>                 } else {
> >>>                         l2cap_chan_ready(chan);
> >>>                 }
> >>> +
> >>> +               /* Drop our local ref; __l2cap_chan_add() pinned chan=
 via the conn list. */
> >>> +               l2cap_chan_put(chan);
> >>>         }
> >>>
> >>>  unlock:
> >>> @@ -7399,7 +7428,11 @@ static void l2cap_connect_cfm(struct hci_conn =
*hcon, u8 status)
> >>>                         goto next;
> >>>
> >>>                 l2cap_chan_lock(pchan);
> >>> -               chan =3D pchan->ops->new_connection(pchan);
> >>> +               chan =3D l2cap_chan_create();
> >>> +               if (chan && pchan->ops->new_connection(pchan, chan) <=
 0) {
> >>> +                       l2cap_chan_put(chan);
> >>> +                       chan =3D NULL;
> >>> +               }
> >>>                 if (chan) {
> >>>                         bacpy(&chan->src, &hcon->src);
> >>>                         bacpy(&chan->dst, &hcon->dst);
> >>> @@ -7407,6 +7440,9 @@ static void l2cap_connect_cfm(struct hci_conn *=
hcon, u8 status)
> >>>                         chan->dst_type =3D dst_type;
> >>>
> >>>                         __l2cap_chan_add(conn, chan);
> >>> +
> >>> +                       /* Drop our local ref; __l2cap_chan_add() pin=
ned chan via the conn list. */
> >>> +                       l2cap_chan_put(chan);
> >>>                 }
> >>>
> >>>                 l2cap_chan_unlock(pchan);
> >>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> >>> index dede550d6031..598f24c8f704 100644
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
> >>> @@ -1507,12 +1508,13 @@ static void l2cap_sock_cleanup_listen(struct =
sock *parent)
> >>>         }
> >>>  }
> >>>
> >>> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_=
chan *chan)
> >>> +static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
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
> >>> @@ -1520,15 +1522,15 @@ static struct l2cap_chan *l2cap_sock_new_conn=
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
> >>> @@ -1538,7 +1540,7 @@ static struct l2cap_chan *l2cap_sock_new_connec=
tion_cb(struct l2cap_chan *chan)
> >>>
> >>>         release_sock(parent);
> >>>
> >>> -       return l2cap_pi(sk)->chan;
> >>> +       return 0;
> >>>  }
> >>>
> >>>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buf=
f *skb)
> >>> @@ -1939,10 +1941,10 @@ static struct proto l2cap_proto =3D {
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
> >>> @@ -1953,14 +1955,11 @@ static struct sock *l2cap_sock_alloc(struct n=
et *net, struct socket *sock,
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
> >>> +       /* The sock owns two refs on chan, matching the puts in
> >>> +        * l2cap_sock_kill() and l2cap_sock_destruct(). The caller ke=
eps
> >>> +        * its own ref independent of these.
> >>> +        */
> >>> +       l2cap_chan_hold(chan);
> >>>         l2cap_chan_hold(chan);
> >>>
> >>>         l2cap_pi(sk)->chan =3D chan;
> >>> @@ -1972,6 +1971,7 @@ static int l2cap_sock_create(struct net *net, s=
truct socket *sock, int protocol,
> >>>                              int kern)
> >>>  {
> >>>         struct sock *sk;
> >>> +       struct l2cap_chan *chan;
> >>>
> >>>         BT_DBG("sock %p", sock);
> >>>
> >>> @@ -1986,10 +1986,18 @@ static int l2cap_sock_create(struct net *net,=
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
> >>> +       /* Sock has taken its own refs on chan; drop the chan_create(=
) ref. */
> >>> +       l2cap_chan_put(chan);
> >>> +
> >>>         l2cap_sock_init(sk, NULL);
> >>>         bt_sock_link(&l2cap_sk_list, sk);
> >>>         return 0;
> >>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> >>> index 1739c1989dbd..25cb5dc580bf 100644
> >>> --- a/net/bluetooth/smp.c
> >>> +++ b/net/bluetooth/smp.c
> >>> @@ -3204,16 +3204,11 @@ static const struct l2cap_ops smp_chan_ops =
=3D {
> >>>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
> >>>  };
> >>>
> >>> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *=
pchan)
> >>> +static inline int smp_new_conn_cb(struct l2cap_chan *pchan,
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
> >>> @@ -3229,9 +3224,9 @@ static inline struct l2cap_chan *smp_new_conn_c=
b(struct l2cap_chan *pchan)
> >>>          */
> >>>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
> >>>
> >>> -       BT_DBG("created chan %p", chan);
> >>> +       BT_DBG("initialised chan %p", chan);
> >>>
> >>> -       return chan;
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
