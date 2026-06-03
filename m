Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74ED188CC9
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510689; cv=pass; b=OHkrIRAGdRy4iaPVBCRaGK0xJWJfIIqiIXZCOFr216hR6gpIvu+0A8gVpFN5uK8Pty9TrChJMKzbTwurm+T0pmD8b6ZSd4vAFzgBsG5YiqOy7zAhkI+RaFXEOEReOZ5Wm2cjezzUPazOOSMxkyOJjtfUbG7vOAfYPvbqbXLGTkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510689; c=relaxed/simple;
	bh=jMSBtr2z8yHc33aBMh9fm0ov/1vqPMC2Or+d/9PDyGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdRtecOQ8wuaplVyipJk4TKNFtthUhR7SUiDgNtIx9EA4f+P91zHCE9CDlzwmSZ6aW2wyU3a+W4ndr2zVj2/2cpUTMPuoQ/cw8Or022LbwZKMriqFS/S2j35wJ3lfP/fwBa1dJQjUfxCkB+rRWnemAnopqbNE8gDUTFvfYj4NGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltso/GET; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltso/GET"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6607048fa62so4191010d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 11:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780510687; cv=none;
        d=google.com; s=arc-20240605;
        b=P0egkNsSWcMWKc+TODiKg6jyWBC7GZWQAv1bg6pfGmWnYjET6DSWvwGAbj1cCWa4sn
         XrkswA0PZmwIZ5vNrwaCxYcKXFbuc2P34L9BEhYfcQ4fENGteimL2baGsMoXd4k7WR9x
         6ReLTLJ6RPliCOchiPJhy8xTv/ZUoUhu8r9fy6SiBOlMTYDcWJ8LSAfUvkIdAdS/MtlH
         Cs3jK2cQtuPo6WnEOEL65j3F7U5Q6W2ZEI+Ou8qYXH1wGn3N9lV0S0Cz3jhuDvsGVx8Y
         WPeU2fStW7Lii1mtTSnJ3pXms1hNGVc0wXxFzXaa3FhZsNk70OrhGkpMGo3lb4E6eq9c
         jNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q2y5IJD7fCP/J/DYpBq0ou2xX9h+1cFXbJs2+JFuxoM=;
        fh=iKKjeAwhZI9EBMSri5ZTOmb+14G2bqBmnWDJBZ1t6qI=;
        b=lsHr88x5VimqJxqP+bs9giu3ZmFH4TDXjiAN0ZOuhKFdyb7EBp/LOMHg1WgRb/JTn6
         WlSUdYtYZwRBjMNKEA5ogvbJJx9T0hE5GSasHcL1bQyGPiexEfW+Y6WDwUjMmk0e41M7
         +v/oCnJB8RvCoKXR0DplUXgW0mXx9l+99DrQFAoCyf1PysZUQaYBx/ymm28WJYSqkcO4
         FBjPS4jFtISDAO1WhpFblVtn1RoNHWVKurqz9JJipve/qMLdoxyFl3qHWkUhtko/Fwsx
         Rr0KmK6gLwP4q/zaceb/FRv7cRstelPaM815eGwWo13RrMw8ahT6nTJPc4xuLJBy07VF
         k9mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780510687; x=1781115487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2y5IJD7fCP/J/DYpBq0ou2xX9h+1cFXbJs2+JFuxoM=;
        b=Ltso/GETIUVQL4vAPt5CfuMGGiPgzTbqbpgWv7N9PLe+YfxnqKor7GTKcdYVMJLaw/
         ARyngNHNkowJacw6kMTTfMS+gzi1trl4O5xbF0o1GL8DKvfwnTdhaHSPfibxBYaBfVWZ
         /gkSBKVLzErGFt/XIje1BIBFgr9NvYWy5UtPCDnhKPI9GJJHv6Zst1ZTNxi5PuwetVz5
         mEFr4ozc+GkB2hWtD/rApyitQmz+5xGQ32T45lcOV7E314m+w8Zd5np2j0bRP/mMCBSU
         CizfkBnkdXJOeDoRKCtXMYMYYFwaw3g5h7nAj3HpPj1fdII61TzYentYcFD+JORSXOvh
         hFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510687; x=1781115487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2y5IJD7fCP/J/DYpBq0ou2xX9h+1cFXbJs2+JFuxoM=;
        b=T6wEgPSrI4Y+9wgRJlDwsiSehF1Kq3QKgAUfCTr001Lp74KU+lheBKz/esj9u1bz1p
         uimQyH3K2e0D+LF4X+Mm8kIxUcLt1RIx0szn1M+YnJ3wzjVT2BP4MqUZz5fhHYghoUqo
         sm3dCJLBmx2R6wSvAa46SVcsKeala8rqe+l+nnVQ4nvm84MO3DhHEL+Pqlkzapf2QkAn
         XzfxcjvQxBklKZHzIJ4BmLk7NEi1DiUni4kH5UFDpUFXEQORoRNBToi/nw8i+y1AgYY3
         nTy1crQ/UuDEEeRXjr3v8pOsoBMer0EzsRIL2wPdzt3bZs69+ewRvbF4+hHjVvr3JuJO
         ME5A==
X-Forwarded-Encrypted: i=1; AFNElJ/06vIN8eTctWsYUJ9vffoSPiKp7OJ1uwSBYoyG9PMY2rbTa+Y42KyJn/tVW2AyF5V1sXH2gABf54Ug9Xm1rT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKKdRDtq1OinKWdEcNuZ9J3K5zSBrLoLcTI1xlK39vEX6Z+6e
	kyVOJ7Ro9WFp/AGxa9JpIjTr9i5NYeL89JS7DOgszzkFNNkg/f8o9fn0FOqb/olZ4CvgkjHvHmz
	dhhoDGZ7ZCj5NY8j7NYZJGboe9V8yyLe38a6U
X-Gm-Gg: Acq92OEyyBvFVDFqHtFaAStdSyTzp/LGic/m/DrwFAc9NBH2ynewFMHwT9fuMYh/eTT
	ZtqWTDhMUan41QJW05OiTcg7fytDAc4xi/IQ5d4iSTBEGlJNWshdkp3vCm7e9HSPxCFVULOqIjv
	h6ORUWvTjfWU71y07FIfUa0D1G0+P89j5sI5NvwUMt1bAvL8F7YYScXAQPAfY/I/pTRbJ9uovCu
	MSGkA0pFX34vzCw0XgfWD1h3dzkPwDC5Kh3lYi0xFnp5icLWCGfMyqBEvYV1z3UsYX2ZsF+NBKr
	/KRpeVNUjzbyZLUZ6N6MEtMDZunFKkfWhUO/E89bIP2EPE2wel+bKN60nyuoLUFKXtpGff7oqvt
	MKQ==
X-Received: by 2002:a05:690e:1918:b0:660:ef1e:5f21 with SMTP id
 956f58d0204a3-660ef1e61b5mr1293325d50.37.1780510686438; Wed, 03 Jun 2026
 11:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603150835.3539963-1-oss@fourdim.xyz> <20260603150835.3539963-2-oss@fourdim.xyz>
In-Reply-To: <20260603150835.3539963-2-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jun 2026 14:17:54 -0400
X-Gm-Features: AVHnY4KcN2T5XeF3q1xMq5JaBig_Lvyr08U-CR5INMk9cVlvHmD_if37Q4aqhtk
Message-ID: <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote=
:
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
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  include/net/bluetooth/l2cap.h | 10 +++--
>  net/bluetooth/6lowpan.c       | 31 +++++++------
>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++--------------
>  net/bluetooth/smp.c           | 17 ++++---
>  5 files changed, 113 insertions(+), 69 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index e0a1f2293679..7f5e4647f6e0 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -620,7 +620,9 @@ struct l2cap_chan {
>  struct l2cap_ops {
>         char                    *name;
>
> -       struct l2cap_chan       *(*new_connection) (struct l2cap_chan *ch=
an);
> +       int                     (*new_connection)(struct l2cap_conn *conn=
,
> +                                                 struct l2cap_chan *chan=
,
> +                                                 struct l2cap_chan *new_=
chan);
>         int                     (*recv) (struct l2cap_chan * chan,
>                                          struct sk_buff *skb);
>         void                    (*teardown) (struct l2cap_chan *chan, int=
 err);
> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2cap_chan *ch=
an, __u16 seq)
>         return (seq + 1) % (chan->tx_win_max + 1);
>  }
>
> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2c=
ap_chan *chan)
> +static inline int l2cap_chan_no_new_connection(struct l2cap_conn *conn,
> +                                              struct l2cap_chan *chan,
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
> index cb1e329d66fd..94863af97a44 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
>         return true;
>  }
>
> +static void chan_init(struct l2cap_chan *chan)
> +{
> +       l2cap_chan_set_defaults(chan);
> +
> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> +       chan->imtu =3D 1280;
> +}
> +
>  static struct l2cap_chan *chan_create(void)
>  {
>         struct l2cap_chan *chan;
> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void)
>         if (!chan)
>                 return NULL;
>
> -       l2cap_chan_set_defaults(chan);
> -
> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
> -       chan->imtu =3D 1280;
> +       chan_init(chan);
>
>         return chan;
>  }
> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct l2cap_chan =
*chan)
>         ifup(dev->netdev);
>  }
>
> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pch=
an)
> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
> +                                  struct l2cap_chan *pchan,
> +                                  struct l2cap_chan *chan)
>  {
> -       struct l2cap_chan *chan;
> -
> -       chan =3D chan_create();
> -       if (!chan)
> -               return NULL;
> -
> +       chan_init(chan);
>         chan->ops =3D pchan->ops;
>
> +       /* Take the conn list reference; see l2cap_new_connection(). */
> +       __l2cap_chan_add(conn, chan);
> +
>         BT_DBG("chan %p pchan %p", chan, pchan);
>
> -       return chan;
> +       return 0;
>  }
>
>  static void unregister_dev(struct lowpan_btle_dev *dev)
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c4ccfbda9d78..62acf90837fb 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(struct l2cap_c=
onn *conn,
>         return 0;
>  }
>
> +/* Allocate and initialise a channel for an incoming connection.
> + *
> + * ->new_connection() initialises the channel and links it into @conn wi=
th
> + * __l2cap_chan_add(). The l2cap_chan_create() reference becomes the one=
 owned
> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or peer->chan)=
 and is
> + * released by its teardown callback; the conn list reference is release=
d by
> + * l2cap_chan_del().
> + */
> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
> +                                              struct l2cap_chan *pchan)
> +{
> +       struct l2cap_chan *chan;
> +
> +       chan =3D l2cap_chan_create();
> +       if (!chan)
> +               return NULL;
> +
> +       if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
> +               l2cap_chan_put(chan);
> +               return NULL;
> +       }

I don't quite get why we can't just place __l2cap_chan_add here
instead of having it called by new_connection callbacks?

> +
> +       return chan;
> +}
> +
>  static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr =
*cmd,
>                           u8 *data, u8 rsp_code)
>  {
> @@ -4053,7 +4078,7 @@ static void l2cap_connect(struct l2cap_conn *conn, =
struct l2cap_cmd_hdr *cmd,
>                 goto response;
>         }
>
> -       chan =3D pchan->ops->new_connection(pchan);
> +       chan =3D l2cap_new_connection(conn, pchan);
>         if (!chan)
>                 goto response;
>
> @@ -4071,8 +4096,6 @@ static void l2cap_connect(struct l2cap_conn *conn, =
struct l2cap_cmd_hdr *cmd,
>         chan->psm  =3D psm;
>         chan->dcid =3D scid;
>
> -       __l2cap_chan_add(conn, chan);
> -
>         dcid =3D chan->scid;
>
>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
> @@ -4955,7 +4978,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>                 goto response_unlock;
>         }
>
> -       chan =3D pchan->ops->new_connection(pchan);
> +       chan =3D l2cap_new_connection(conn, pchan);
>         if (!chan) {
>                 result =3D L2CAP_CR_LE_NO_MEM;
>                 goto response_unlock;
> @@ -4970,8 +4993,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>         chan->omtu =3D mtu;
>         chan->remote_mps =3D mps;
>
> -       __l2cap_chan_add(conn, chan);
> -
>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
>
>         dcid =3D chan->scid;
> @@ -5179,7 +5200,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>                         continue;
>                 }
>
> -               chan =3D pchan->ops->new_connection(pchan);
> +               chan =3D l2cap_new_connection(conn, pchan);
>                 if (!chan) {
>                         result =3D L2CAP_CR_LE_NO_MEM;
>                         continue;
> @@ -5194,8 +5215,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>                 chan->omtu =3D mtu;
>                 chan->remote_mps =3D mps;
>
> -               __l2cap_chan_add(conn, chan);
> -
>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>
>                 /* Init response */
> @@ -7470,14 +7489,12 @@ static void l2cap_connect_cfm(struct hci_conn *hc=
on, u8 status)
>                         goto next;
>
>                 l2cap_chan_lock(pchan);
> -               chan =3D pchan->ops->new_connection(pchan);
> +               chan =3D l2cap_new_connection(conn, pchan);
>                 if (chan) {
>                         bacpy(&chan->src, &hcon->src);
>                         bacpy(&chan->dst, &hcon->dst);
>                         chan->src_type =3D bdaddr_src_type(hcon);
>                         chan->dst_type =3D dst_type;
> -
> -                       __l2cap_chan_add(conn, chan);
>                 }
>
>                 l2cap_chan_unlock(pchan);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 025329636353..87f4c0db5c0c 100644
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
> @@ -1287,6 +1288,23 @@ static int l2cap_sock_recvmsg(struct socket *sock,=
 struct msghdr *msg,
>         return err;
>  }
>
> +/* Release the sock's ref on chan and clear the pointer so that the ref =
is
> + * dropped exactly once even if both l2cap_sock_kill() and
> + * l2cap_sock_destruct() run. Setting chan->data to NULL first stops any=
 other
> + * task from dereferencing the now-dead sock pointer.
> + */
> +static void l2cap_sock_put_chan(struct sock *sk)
> +{
> +       struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> +
> +       if (!chan)
> +               return;
> +
> +       chan->data =3D NULL;
> +       l2cap_pi(sk)->chan =3D NULL;
> +       l2cap_chan_put(chan);
> +}
> +
>  /* Kill socket (only if zapped and orphan)
>   * Must be called on unlocked socket, with l2cap channel lock.
>   */
> @@ -1297,13 +1315,9 @@ static void l2cap_sock_kill(struct sock *sk)
>
>         BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
>
> -       /* Sock is dead, so set chan data to NULL, avoid other task use i=
nvalid
> -        * sock pointer.
> -        */
> -       l2cap_pi(sk)->chan->data =3D NULL;
> -       /* Kill poor orphan */
> +       l2cap_sock_put_chan(sk);
>
> -       l2cap_chan_put(l2cap_pi(sk)->chan);
> +       /* Kill poor orphan */
>         sock_set_flag(sk, SOCK_DEAD);
>         sock_put(sk);
>  }
> @@ -1546,12 +1560,14 @@ static void l2cap_sock_cleanup_listen(struct sock=
 *parent)
>         }
>  }
>
> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan=
 *chan)
> +static int l2cap_sock_new_connection_cb(struct l2cap_conn *conn,
> +                                       struct l2cap_chan *chan,
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
> @@ -1559,25 +1575,33 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
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
>         l2cap_sock_init(sk, parent);
>
> +       /* Link the channel into conn before exposing the new socket via =
the
> +        * accept queue. Once release_sock() below drops the parent lock =
the
> +        * socket may be freed by another task, dropping its reference on
> +        * new_chan; the conn list reference taken here keeps new_chan al=
ive so
> +        * the caller can safely use it after ->new_connection() returns.
> +        */
> +       __l2cap_chan_add(conn, new_chan);
> +
>         bt_accept_enqueue(parent, sk, false);
>
>         release_sock(parent);
>
> -       return l2cap_pi(sk)->chan;
> +       return 0;
>  }
>
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *s=
kb)
> @@ -1874,10 +1898,7 @@ static void l2cap_sock_destruct(struct sock *sk)
>
>         BT_DBG("sk %p", sk);
>
> -       if (l2cap_pi(sk)->chan) {
> -               l2cap_pi(sk)->chan->data =3D NULL;
> -               l2cap_chan_put(l2cap_pi(sk)->chan);
> -       }
> +       l2cap_sock_put_chan(sk);
>
>         list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, l=
ist) {
>                 kfree_skb(rx_busy->skb);
> @@ -1978,10 +1999,10 @@ static struct proto l2cap_proto =3D {
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
> @@ -1992,16 +2013,7 @@ static struct sock *l2cap_sock_alloc(struct net *n=
et, struct socket *sock,
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
> -       l2cap_chan_hold(chan);
> -
> +       /* The sock takes ownership of the caller's reference on chan. */
>         l2cap_pi(sk)->chan =3D chan;
>
>         return sk;
> @@ -2011,6 +2023,7 @@ static int l2cap_sock_create(struct net *net, struc=
t socket *sock, int protocol,
>                              int kern)
>  {
>         struct sock *sk;
> +       struct l2cap_chan *chan;
>
>         BT_DBG("sock %p", sock);
>
> @@ -2025,10 +2038,16 @@ static int l2cap_sock_create(struct net *net, str=
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
> +
>         l2cap_sock_init(sk, NULL);
>         bt_sock_link(&l2cap_sk_list, sk);
>         return 0;
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 1739c1989dbd..2d31c3c7bbc0 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -3204,16 +3204,12 @@ static const struct l2cap_ops smp_chan_ops =3D {
>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
>  };
>
> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pcha=
n)
> +static inline int smp_new_conn_cb(struct l2cap_conn *conn,
> +                                 struct l2cap_chan *pchan,
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
> @@ -3229,9 +3225,12 @@ static inline struct l2cap_chan *smp_new_conn_cb(s=
truct l2cap_chan *pchan)
>          */
>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
>
> -       BT_DBG("created chan %p", chan);
> +       /* Take the conn list reference; see l2cap_new_connection(). */
> +       __l2cap_chan_add(conn, chan);
>
> -       return chan;
> +       BT_DBG("initialised chan %p", chan);
> +
> +       return 0;
>  }
>
>  static const struct l2cap_ops smp_root_chan_ops =3D {
> --
> 2.54.0
>


--=20
Luiz Augusto von Dentz
