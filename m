Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AD3C0A0B
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779828410; cv=pass; b=pI2Y5mKrd716clXPxqdAdB8ALRRhywfEp6WLlbwM6y3Rd7hK3OBhAzN4j+lj12Yb4dowATEsLpp4fkTvt0ZY/1Y3j7T6Wqvp70a7eHkSWKIaxlh1A+N5IrKp4F9a0AOf0NlNpKJHXzKkBMtMio6rOanxEe4PbuBDMUuYHq7lqmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779828410; c=relaxed/simple;
	bh=mKO5fgC1qjQaMnZqbTxzRM8WThj4lAwrvPZ64l9O7qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOfZ4PUi5SiFdlJl3VMBFgByW4nhuGm6jiSl6kWl+R/qNUvafmmfum01OXpy7Fcn8sA0Wqr+gFBybriuApsDSG8k4pdmMeVF1pMYr/n4JLE0wtPly5tLb++NpbEX79YSPfggfkP4TBPhJbjARsPQswS/VWfUi2VbhLjvQflmMTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO06zBnu; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO06zBnu"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so10949769d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 13:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779828408; cv=none;
        d=google.com; s=arc-20240605;
        b=RHIK+kMTfdvxvFN6MACsE2PsbpwXfeRRTNhp6a23RYXfRwHgy73cA0lSWOmWvZYNAT
         ELOwhV0RI+/++LHDq0Mb6dkcxcE5oKS/GO20u5Z2/vmp24maW7+hmytq82NzW9ih9dIv
         CZgcG9wdl+MK/A3aUh/IA6ba+lfC50uH1MDp2EWyoq0MZUt2eVX9JOql+5/P2KggX9yq
         3KpoFZ9BJoINGkVH8FNLE3edOQp27cFGUth+DMFPn68M9Yk05ZOWjhsy+XihixVRPHHM
         mitpU+iUL7wbh1U6Kcgl53WlXT/YZALGWOzxGFVgGH+Sqmz42DPSAQ5FQhuE2CtWzLf2
         wK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r/ta6FJgZqetd0kCuG7wAwq1JRPtmwJ8n9RdeVx5JLY=;
        fh=RRjV+aEil7mxh7pV88x4eizlfoHntU4b2bAo15ts+Nc=;
        b=Iue/gPBKXDgaccVv62vecern/HIzo2jtibjV3yDpbhUHFdyDtXe6QEl3I6Wzp2XG1+
         H1j+mO/AhOs6d5pfr7QVnfILBQMdTNqskuOhRCvQY5NdvifbacBHNtfvRDCjF0RJitOn
         XK5Q4YBOa0J06KP4wWtMIYapmwa4uo+dYghS25+JlTUDxm9/ZbeORi9tColO6wy113oB
         nkGpjcd8DZ8V3TqD6M1fYFkclvEU1NNRMgATYSs65p6pNEiNW+I0a7s+6dHqSr0Wccw1
         Yzmm/x0KAq+Yv51XDW2ruv33ljyJ6DrAJU/hERTVxrHyAdyX41LH3RXafCzb+GAwauFA
         IB1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779828408; x=1780433208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/ta6FJgZqetd0kCuG7wAwq1JRPtmwJ8n9RdeVx5JLY=;
        b=TO06zBnuX/0fcjzy3INtFx/utUAUEd0lCpi3Suf53bApkkFAT0DhIeGj4xhelqUJJg
         j8/aIu8i9PQuYNRAyAN1Xm6GQRUkDDUTRKd3aTTL+8RtxHst/ZtRrLVu5e2P3Tc4OvJy
         /3NrIEJ1Hl0Vlx5U68KUhF5Cc3UBXiH3qitQSTATX3AMv13MUHAnc846F+T5HoNPLt+U
         ONyddksOCLyrK9qdw074NkgOKcENYIAvXUXSA6wmse6ly0aRx0iMWLsIP+1zkGy6XNrc
         1t85nuf59kv7G7mWrBW6S54ny+bDdnpGd18tNPWl/RYGlm2LozA8/HrrqAs9XfZ6M9xL
         ae4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779828408; x=1780433208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r/ta6FJgZqetd0kCuG7wAwq1JRPtmwJ8n9RdeVx5JLY=;
        b=Q2lHdMWlad78HH3paHI+nvlPbIVDVeXqJzlCJmXtrkVMTM0pxmfAxZdOHt6EUIAXV0
         zJ96zYUETnFiTc2H1afOMt++u0iBkCMVUvOyrMkuB4PrfG7szeenK0Ynr5FU8C2OGp6u
         QReF/bajpAawuAplJYDoKjMOVZoZXLu6HIA8Mjl5cv0E6sn3XRYqUy9mZNrumvixL0qC
         Vvxje758ZKsV99ljuQKF9nb39ns9dw+4UFHnj3egRqvOaW/tLUofyeGKlgsY4edaunYU
         1HJSYiBt3+LGT+dbrfFpp40YwYD3U5gVr17bSbeIL4y/WZzFVA6C1mOQpt59UvJnftJt
         ewcA==
X-Forwarded-Encrypted: i=1; AFNElJ+IOE+lcA8fugsw61xNkXvSRv8TOvJgD9UBoEltiIIbK+4c6+apA7BOjRjrXUYoSDK5WOFYxbN5KX0Ksp2/ECs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybnNXPSjrbM7gs8hfRTXbVyAkevGgx5jSwyhHAwM/tqpw0LR6O
	1fNIL3W8fszA5ETDv6pd19/SwG2Lk25FEtHIohdc6CpNOatUUDwVJETpSTF/borv4bTCop1XCJW
	pNlFRZWwtdT8irLo1Jb9fD6tuPYHXH1gCEw==
X-Gm-Gg: Acq92OE4BriSxVhuQA+HaQvtETZIyzYmzV5gbvfCfvTQFsy/+Y53tYInQnYntySh7vf
	tAI7XFkt3b4j1eY8GopQMSqy8OSgJiqikGPrBnjpg+q50wjWzPQUNh6aB7N4DnGBFI3ki3U3Tvo
	IcZW/hkBdZ5n+uBCj2Br/iisUH/SJMpJxuXoo3LirutvgN3MMKM01SmWc6D08MlrHmB55SrW254
	6xVAkznS4zYiwabt6Dm25+BWBFVcMvF9QYBnOfm5NMG5O+LbEnsVbsXJitxu21TCb2PvuyYk2sS
	LChuqT1YtfHBNQb+eNb+CLtGXy+cCmGmmN3KhtUJF3Q4IRI+LVdotPGGJbuorWkh/YhUie6xS+j
	33ZOPS+jhgqSqJZo=
X-Received: by 2002:a05:690e:d4f:b0:65c:bfe:80ea with SMTP id
 956f58d0204a3-65ec99af595mr18506789d50.58.1779828407587; Tue, 26 May 2026
 13:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162030.2842543-1-oss@fourdim.xyz> <20260520162030.2842543-2-oss@fourdim.xyz>
In-Reply-To: <20260520162030.2842543-2-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 May 2026 16:46:35 -0400
X-Gm-Features: AVHnY4Ku22tXK5kodPYSpkEFETnlRtpuLVzWmbBlcdw7hG6kJzcFaPPEavhm454
Message-ID: <CABBYNZL_ymHCE+uf6kJ2Mi=R4pEwy-wcSL3HKDP0krd7D73Kqw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, May 20, 2026 at 12:20=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> wrot=
e:
>
> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
> release_sock(parent). Once the parent lock is released, the child
> socket sk can be freed by another task.
>
> Allocate the channel outside the func to prevent this.
>
> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2cap_co=
re.c")
> Cc: stable@kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  include/net/bluetooth/l2cap.h |  8 +++--
>  net/bluetooth/6lowpan.c       | 14 ++++-----
>  net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++-------
>  net/bluetooth/l2cap_sock.c    | 48 +++++++++++++++++------------
>  net/bluetooth/smp.c           | 13 +++-----
>  5 files changed, 91 insertions(+), 50 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 5172afee5494..f7a11e6431f0 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -619,7 +619,8 @@ struct l2cap_chan {
>  struct l2cap_ops {
>         char                    *name;
>
> -       struct l2cap_chan       *(*new_connection) (struct l2cap_chan *ch=
an);
> +       int                     (*new_connection)(struct l2cap_chan *chan=
,
> +                                                 struct l2cap_chan *new_=
chan);
>         int                     (*recv) (struct l2cap_chan * chan,
>                                          struct sk_buff *skb);
>         void                    (*teardown) (struct l2cap_chan *chan, int=
 err);
> @@ -883,9 +884,10 @@ static inline __u16 __next_seq(struct l2cap_chan *ch=
an, __u16 seq)
>         return (seq + 1) % (chan->tx_win_max + 1);
>  }
>
> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2c=
ap_chan *chan)
> +static inline int l2cap_chan_no_new_connection(struct l2cap_chan *chan,
> +                                              struct l2cap_chan *new_cha=
n)
>  {
> -       return NULL;
> +       return -EOPNOTSUPP;
>  }
>
>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct sk_=
buff *skb)
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 23a229ab6a33..286c0b45055b 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -743,19 +743,19 @@ static inline void chan_ready_cb(struct l2cap_chan =
*chan)
>         ifup(dev->netdev);
>  }
>
> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pch=
an)
> +static inline int chan_new_conn_cb(struct l2cap_chan *pchan,
> +                                  struct l2cap_chan *chan)
>  {
> -       struct l2cap_chan *chan;
> -
> -       chan =3D chan_create();
> -       if (!chan)
> -               return NULL;
> +       l2cap_chan_set_defaults(chan);
>
> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> +       chan->imtu =3D 1280;

The 3 lines above make no sense.

>         chan->ops =3D pchan->ops;
>
>         BT_DBG("chan %p pchan %p", chan, pchan);
>
> -       return chan;
> +       return 0;
>  }
>
>  static void unregister_dev(struct lowpan_btle_dev *dev)
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fdccd62ccca8..505f32034971 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4051,10 +4051,16 @@ static void l2cap_connect(struct l2cap_conn *conn=
, struct l2cap_cmd_hdr *cmd,
>                 goto response;
>         }
>
> -       chan =3D pchan->ops->new_connection(pchan);
> +       chan =3D l2cap_chan_create();
>         if (!chan)
>                 goto response;
>
> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
> +               l2cap_chan_put(chan);
> +               chan =3D NULL;
> +               goto response;
> +       }
> +
>         /* For certain devices (ex: HID mouse), support for authenticatio=
n,
>          * pairing and bonding is optional. For such devices, inorder to =
avoid
>          * the ACL alive for too long after L2CAP disconnection, reset th=
e ACL
> @@ -4132,6 +4138,10 @@ static void l2cap_connect(struct l2cap_conn *conn,=
 struct l2cap_cmd_hdr *cmd,
>                 chan->num_conf_req++;
>         }
>
> +       /* Drop our local ref; __l2cap_chan_add() pinned chan via the con=
n list. */
> +       if (chan)
> +               l2cap_chan_put(chan);
> +
>         l2cap_chan_unlock(pchan);
>         l2cap_chan_put(pchan);
>  }
> @@ -4881,6 +4891,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>         struct l2cap_le_conn_rsp rsp;
>         struct l2cap_chan *chan, *pchan;
>         u16 dcid, scid, credits, mtu, mps;
> +       u16 rsp_mtu, rsp_mps;
>         __le16 psm;
>         u8 result;
>
> @@ -4893,6 +4904,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>         psm  =3D req->psm;
>         dcid =3D 0;
>         credits =3D 0;
> +       rsp_mtu =3D 0;
> +       rsp_mps =3D 0;
>
>         if (mtu < 23 || mps < 23)
>                 return -EPROTO;
> @@ -4953,12 +4966,19 @@ static int l2cap_le_connect_req(struct l2cap_conn=
 *conn,
>                 goto response_unlock;
>         }
>
> -       chan =3D pchan->ops->new_connection(pchan);
> +       chan =3D l2cap_chan_create();
>         if (!chan) {
>                 result =3D L2CAP_CR_LE_NO_MEM;
>                 goto response_unlock;
>         }
>
> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
> +               l2cap_chan_put(chan);
> +               chan =3D NULL;
> +               result =3D L2CAP_CR_LE_NO_MEM;
> +               goto response_unlock;
> +       }
> +
>         bacpy(&chan->src, &conn->hcon->src);
>         bacpy(&chan->dst, &conn->hcon->dst);
>         chan->src_type =3D bdaddr_src_type(conn->hcon);
> @@ -4974,6 +4994,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>
>         dcid =3D chan->scid;
>         credits =3D chan->rx_credits;
> +       rsp_mtu =3D chan->imtu;
> +       rsp_mps =3D chan->mps;
>
>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>
> @@ -4993,6 +5015,9 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>                 result =3D L2CAP_CR_LE_SUCCESS;
>         }
>
> +       /* Drop our local ref; __l2cap_chan_add() pinned chan via the con=
n list. */
> +       l2cap_chan_put(chan);
> +
>  response_unlock:
>         l2cap_chan_unlock(pchan);
>         l2cap_chan_put(pchan);
> @@ -5001,13 +5026,8 @@ static int l2cap_le_connect_req(struct l2cap_conn =
*conn,
>                 return 0;
>
>  response:
> -       if (chan) {
> -               rsp.mtu =3D cpu_to_le16(chan->imtu);
> -               rsp.mps =3D cpu_to_le16(chan->mps);
> -       } else {
> -               rsp.mtu =3D 0;
> -               rsp.mps =3D 0;
> -       }
> +       rsp.mtu =3D cpu_to_le16(rsp_mtu);
> +       rsp.mps =3D cpu_to_le16(rsp_mps);
>
>         rsp.dcid    =3D cpu_to_le16(dcid);
>         rsp.credits =3D cpu_to_le16(credits);
> @@ -5177,12 +5197,18 @@ static inline int l2cap_ecred_conn_req(struct l2c=
ap_conn *conn,
>                         continue;
>                 }
>
> -               chan =3D pchan->ops->new_connection(pchan);
> +               chan =3D l2cap_chan_create();
>                 if (!chan) {
>                         result =3D L2CAP_CR_LE_NO_MEM;
>                         continue;
>                 }
>
> +               if (pchan->ops->new_connection(pchan, chan) < 0) {
> +                       l2cap_chan_put(chan);
> +                       result =3D L2CAP_CR_LE_NO_MEM;
> +                       continue;
> +               }
> +
>                 bacpy(&chan->src, &conn->hcon->src);
>                 bacpy(&chan->dst, &conn->hcon->dst);
>                 chan->src_type =3D bdaddr_src_type(conn->hcon);
> @@ -5217,6 +5243,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>                 } else {
>                         l2cap_chan_ready(chan);
>                 }
> +
> +               /* Drop our local ref; __l2cap_chan_add() pinned chan via=
 the conn list. */
> +               l2cap_chan_put(chan);
>         }
>
>  unlock:
> @@ -7399,7 +7428,11 @@ static void l2cap_connect_cfm(struct hci_conn *hco=
n, u8 status)
>                         goto next;
>
>                 l2cap_chan_lock(pchan);
> -               chan =3D pchan->ops->new_connection(pchan);
> +               chan =3D l2cap_chan_create();
> +               if (chan && pchan->ops->new_connection(pchan, chan) < 0) =
{
> +                       l2cap_chan_put(chan);
> +                       chan =3D NULL;
> +               }
>                 if (chan) {
>                         bacpy(&chan->src, &hcon->src);
>                         bacpy(&chan->dst, &hcon->dst);
> @@ -7407,6 +7440,9 @@ static void l2cap_connect_cfm(struct hci_conn *hcon=
, u8 status)
>                         chan->dst_type =3D dst_type;
>
>                         __l2cap_chan_add(conn, chan);
> +
> +                       /* Drop our local ref; __l2cap_chan_add() pinned =
chan via the conn list. */
> +                       l2cap_chan_put(chan);
>                 }
>
>                 l2cap_chan_unlock(pchan);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index dede550d6031..598f24c8f704 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list =3D {
>  static const struct proto_ops l2cap_sock_ops;
>  static void l2cap_sock_init(struct sock *sk, struct sock *parent);
>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket *soc=
k,
> -                                    int proto, gfp_t prio, int kern);
> +                                    int proto, gfp_t prio, int kern,
> +                                    struct l2cap_chan *chan);
>  static void l2cap_sock_cleanup_listen(struct sock *parent);
>
>  bool l2cap_is_socket(struct socket *sock)
> @@ -1507,12 +1508,13 @@ static void l2cap_sock_cleanup_listen(struct sock=
 *parent)
>         }
>  }
>
> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan=
 *chan)
> +static int l2cap_sock_new_connection_cb(struct l2cap_chan *chan,
> +                                       struct l2cap_chan *new_chan)
>  {
>         struct sock *sk, *parent =3D chan->data;
>
>         if (!parent)
> -               return NULL;
> +               return -EINVAL;
>
>         lock_sock(parent);
>
> @@ -1520,15 +1522,15 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
on_cb(struct l2cap_chan *chan)
>         if (sk_acceptq_is_full(parent)) {
>                 BT_DBG("backlog full %d", parent->sk_ack_backlog);
>                 release_sock(parent);
> -               return NULL;
> +               return -ENOBUFS;
>         }
>
>         sk =3D l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
> -                             GFP_ATOMIC, 0);
> +                             GFP_ATOMIC, 0, new_chan);
>         if (!sk) {
>                 release_sock(parent);
> -               return NULL;
> -        }
> +               return -ENOMEM;
> +       }
>
>         bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
>
> @@ -1538,7 +1540,7 @@ static struct l2cap_chan *l2cap_sock_new_connection=
_cb(struct l2cap_chan *chan)
>
>         release_sock(parent);
>
> -       return l2cap_pi(sk)->chan;
> +       return 0;
>  }
>
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *s=
kb)
> @@ -1939,10 +1941,10 @@ static struct proto l2cap_proto =3D {
>  };
>
>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket *soc=
k,
> -                                    int proto, gfp_t prio, int kern)
> +                                    int proto, gfp_t prio, int kern,
> +                                    struct l2cap_chan *chan)
>  {
>         struct sock *sk;
> -       struct l2cap_chan *chan;
>
>         sk =3D bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
>         if (!sk)
> @@ -1953,14 +1955,11 @@ static struct sock *l2cap_sock_alloc(struct net *=
net, struct socket *sock,
>
>         INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
>
> -       chan =3D l2cap_chan_create();
> -       if (!chan) {
> -               sk_free(sk);
> -               if (sock)
> -                       sock->sk =3D NULL;
> -               return NULL;
> -       }
> -
> +       /* The sock owns two refs on chan, matching the puts in
> +        * l2cap_sock_kill() and l2cap_sock_destruct(). The caller keeps
> +        * its own ref independent of these.
> +        */
> +       l2cap_chan_hold(chan);
>         l2cap_chan_hold(chan);
>
>         l2cap_pi(sk)->chan =3D chan;
> @@ -1972,6 +1971,7 @@ static int l2cap_sock_create(struct net *net, struc=
t socket *sock, int protocol,
>                              int kern)
>  {
>         struct sock *sk;
> +       struct l2cap_chan *chan;
>
>         BT_DBG("sock %p", sock);
>
> @@ -1986,10 +1986,18 @@ static int l2cap_sock_create(struct net *net, str=
uct socket *sock, int protocol,
>
>         sock->ops =3D &l2cap_sock_ops;
>
> -       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
> -       if (!sk)
> +       chan =3D l2cap_chan_create();
> +       if (!chan)
>                 return -ENOMEM;
>
> +       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, ch=
an);
> +       if (!sk) {
> +               l2cap_chan_put(chan);
> +               return -ENOMEM;
> +       }
> +       /* Sock has taken its own refs on chan; drop the chan_create() re=
f. */
> +       l2cap_chan_put(chan);
> +
>         l2cap_sock_init(sk, NULL);
>         bt_sock_link(&l2cap_sk_list, sk);
>         return 0;
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 1739c1989dbd..25cb5dc580bf 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -3204,16 +3204,11 @@ static const struct l2cap_ops smp_chan_ops =3D {
>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
>  };
>
> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pcha=
n)
> +static inline int smp_new_conn_cb(struct l2cap_chan *pchan,
> +                                 struct l2cap_chan *chan)
>  {
> -       struct l2cap_chan *chan;
> -
>         BT_DBG("pchan %p", pchan);
>
> -       chan =3D l2cap_chan_create();
> -       if (!chan)
> -               return NULL;
> -
>         chan->chan_type =3D pchan->chan_type;
>         chan->ops       =3D &smp_chan_ops;
>         chan->scid      =3D pchan->scid;
> @@ -3229,9 +3224,9 @@ static inline struct l2cap_chan *smp_new_conn_cb(st=
ruct l2cap_chan *pchan)
>          */
>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
>
> -       BT_DBG("created chan %p", chan);
> +       BT_DBG("initialised chan %p", chan);
>
> -       return chan;
> +       return 0;
>  }
>
>  static const struct l2cap_ops smp_root_chan_ops =3D {
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
