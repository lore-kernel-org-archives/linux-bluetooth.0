Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC0316192
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418008; cv=pass; b=DPKanqO38HP8UPOW9XrLffTQ6Cz1KYuNd38bNSQdLjaZmozANsuvlT5gJ7cxnu2YPn1C2nmG0g+yBNAJmEQabrGkwtx2X4CsuwKfuIvImHqVYdNL4ZjNH3w1UKjbx1z+kVVPNrSCwT6IDaBbPfgZtE62A++p6NdVoeLcxCuYUaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418008; c=relaxed/simple;
	bh=/Nq2qtAAN/iCFFHPiMyI45QmxmHfZI58Y2VmE9m5iPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS558dnB3k/ZM7TdRduWe6eT8DtsuxKkYcpYzNxL76WkQT8r4iemrAPpa7IVOL17N1YnboItAT+tNNuLOywQk95PTadRCfaCL5MB5sgS4PbD7JgB54iwT5+vDJZlR1AQawyXHPofrbHJbex7TGcXtNSRtjIUi/IObHs5iSLW8uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJmEAz1d; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJmEAz1d"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6605c3453f2so4441271d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 09:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780418006; cv=none;
        d=google.com; s=arc-20240605;
        b=OwwMtqD0dF4tl2eZEHCWYIg+mbq7jq/qZ+EwV2sZ9G3AFvoBtroeasbitQp1hE4WNG
         sqzbD+WurTqs5o8ti/d6CVzl9F9GwwAaj7Q9+++AUIaqyVZEhZSVNWN8O3tmgSKjBs2y
         t5BKyB6l/htDVocjWRef9wS0tuR6W+D60X3BU8h2zwyneTSpOq+fNe8tp2Cr1kViXYKW
         tTrwopXS0k+AoUcQwZmqt5opXbicpcqWSANhA12h+c4N3JL+bhekkC6FN5Rn5Rnl+NVy
         rM53MiDqL6yYXiaM4NbtBu/APa+MPH/JvGW4RVi1CddOUsCj30XjqFFrCb18KHhanRl0
         4NzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOQjcCeJsbkYkAyxh874hbzE1EDqR8wB1kdah5qdqsI=;
        fh=8IHUOD3mYl4MIDz9W32WbaeoKabqJiS8h6yZeyakXQ4=;
        b=Bedmn5YEBgXP0DPce0Hbm8FNZOwgkM8C48lvqOG99jLkhZSi52GcNHf6yZdc8jcjqw
         0wA/uyilwujUefEDmyQYD8vgNKaBR0IYpe+c5GpsEkBuRBFaKjroGMKbvhOdjegOMhAc
         tnntojaSozNawjWy3wivkEWW5TD9G741kTQ5maEO8vCM7MXO5Ks3dh0eJC1UrlkmdJ6Z
         AYmKRi9GbhkAJAiOogs23p/Ar05VAHx36pvsPu5vF1UuTVuX8/KVVes00mRjJdrITms8
         3nV70ke8JsaCDnHc+1ZbufVBNRZDI8mhJ0bffpRAirlh7gL1hEqcXL+n6JfFK8jZjZKU
         L4HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418006; x=1781022806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOQjcCeJsbkYkAyxh874hbzE1EDqR8wB1kdah5qdqsI=;
        b=JJmEAz1dKuT5BotK7NixqxUBj/kaVNSXf8zbnbuLWhMFCS8NKAVQGVVmG12T/vBkkl
         5rGqLQbsEVYg0uwTAEdMAWhgGFYOjS2RNaKd7vit7JTy7/cnYToUM5Uy/rE0cxVsk5TA
         65Y1pbzxlJhTG6zTRFJHGUS+wwkORUSbV77gGe0JmeYrJBnTZGdSu1Ot7f/Bb8RPHLpb
         jEAMZ8PlKXWtCrcifgvQugDs4kxv8NKxFx5ff9cFCz9tOMq/RfM8AkGNvCQl6/2mlACU
         rL4rhUz6DTl8WLHJeFsKWGZaBhWlCaTxM283Fuup9CtA0ue+EIrlaa4e3yyp8sx6Ny+W
         KeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418006; x=1781022806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOQjcCeJsbkYkAyxh874hbzE1EDqR8wB1kdah5qdqsI=;
        b=AGppN21OYCSgZ/Wt9/MaglF2Lxh0+eCzNsCMBQaQFFOI3BPXdk/FXAFc47eEvG7F+5
         WDy17apuoZSuGyajrXPi4KdPrtRkvTx1Rc7LWHn9vUbhTeAJIgIyoh1A35Cm+kIc4uBs
         IWZkZlBSH/sL8ITKvfo35hL+bKDPjTFHy2DlkuH4BhXnvCAkewRlyiev4xXf6HbZ0xiN
         QI8EdtwayN1zu6T41E0SG9YzOotYqrCvjtsbDmHVKb5Rm0Mv5YXyk83rpHXvRqQNK0JH
         FY6TCrBcZ1WwMGXIpjrUPQlJew0/F4pZphvRCrHgtsldggFVZchtst5S3baE/HMcKN1t
         mtwA==
X-Forwarded-Encrypted: i=1; AFNElJ8dr4KkHGR8u5XzN5KXHMs+KInrNf7Qu219KpKCYeEh7jTU7NM2xkppRQWqgcFJQfmwwAQUU/W/WXVVGG1REjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ycRvjo6ByfrkBjzdt6CcYcXUTRBaz5gBy88ctYFRVUIabF8A
	EoPIs39GsHvz477qFk4gh7aNyt30ACRhQorIy2b8gnqFU8uYyebEgWEVPTJ//6x2wqmJ7WXggfn
	ifG/QtSAgW2C2Xh5cVAPGH5QvhFf1hojvce13z2Jofg==
X-Gm-Gg: Acq92OHo23h1pCBzI9AP9cItFQkMavCojKECs+TbzA5qk9z00ucofWmo73rEkWcq495
	nRb/33wuJo/8rmC9Gt6A0pQkmNzTIVY64c5jC+JBJ7VeIYtcnrenqwhTs80cnI0aHK37FTPA+6f
	XE5UqsNeXdPepqD/cQ9ZFFF4zGF2WXR52ZjTD/ApJKeT+k6Pdu4Lm/VFqejyldniQ/iGYjMOGo6
	Z9ERNSZ/+S57ffq7gsTzbKpSFOXOmiaos7eiU3uzeAEz+06r449vHOkgDE0W0trWxWSdbxgL0oc
	TPldokQR70ZLKIZvnaVmdxs9F0S3KHA1fyZ4C/nnER9JLA2PY1eQzAxXFa4zpuPEtQhDR1jSy+l
	NBgyJfZ2Nn/zdqTk=
X-Received: by 2002:a05:690e:43c5:b0:660:56ee:ebf1 with SMTP id
 956f58d0204a3-660d5ecce29mr446401d50.22.1780418005853; Tue, 02 Jun 2026
 09:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602125618.2520506-1-oss@fourdim.xyz> <20260602125618.2520506-2-oss@fourdim.xyz>
In-Reply-To: <20260602125618.2520506-2-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 12:33:12 -0400
X-Gm-Features: AVHnY4Kk1JZA5ejgpIvK3VPVeAKwFwYG9mRk8-JeBPfNwODjpBZlqHUCIFhGRE8
Message-ID: <CABBYNZK=p3AjAJnTHXHWAvCXecw7jjvVBHwnOVOxuzkeQmOZDA@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Tue, Jun 2, 2026 at 8:56=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote:
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
>  include/net/bluetooth/l2cap.h |  8 ++--
>  net/bluetooth/6lowpan.c       | 32 +++++++++------
>  net/bluetooth/l2cap_core.c    | 60 ++++++++++++++++++++-------
>  net/bluetooth/l2cap_sock.c    | 76 ++++++++++++++++++++++-------------
>  net/bluetooth/smp.c           | 18 ++++-----
>  5 files changed, 126 insertions(+), 68 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index e0a1f2293679..ffd006187324 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -620,7 +620,8 @@ struct l2cap_chan {
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
> @@ -884,9 +885,10 @@ static inline __u16 __next_seq(struct l2cap_chan *ch=
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
> index cb1e329d66fd..40f118168015 100644
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
> @@ -745,19 +750,20 @@ static inline void chan_ready_cb(struct l2cap_chan =
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
> -
> +       chan_init(chan);
>         chan->ops =3D pchan->ops;
>
> +       /* Take a reference to match the put in chan_close_cb(). The call=
er
> +        * drops its own local reference after __l2cap_chan_add().
> +        */
> +       l2cap_chan_hold(chan);

If we are not going to assign to any variable here, I'm not sure I
agree that taking a reference is the best thing to do.

>         BT_DBG("chan %p pchan %p", chan, pchan);
>
> -       return chan;
> +       return 0;
>  }
>
>  static void unregister_dev(struct lowpan_btle_dev *dev)
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c4ccfbda9d78..31fb715fd830 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4007,6 +4007,36 @@ static inline int l2cap_command_rej(struct l2cap_c=
onn *conn,
>         return 0;
>  }
>
> +/* Allocate and initialise a channel for an incoming connection. The ret=
urned
> + * channel carries the caller's local reference, which must be dropped o=
nce
> + * __l2cap_chan_add() has pinned it via the conn list.
> + */
> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_chan *pchan)
> +{
> +       struct l2cap_chan *chan;
> +
> +       chan =3D l2cap_chan_create();
> +       if (!chan)
> +               return NULL;
> +
> +       if (pchan->ops->new_connection(pchan, chan) < 0) {
> +               l2cap_chan_put(chan);
> +               return NULL;
> +       }
> +
> +       return chan;
> +}
> +
> +/* Link a channel from l2cap_new_connection() into conn and release the =
local
> + * reference it carried. __l2cap_chan_add() pins the channel via the con=
n list,
> + * so it remains valid after this returns.
> + */
> +static void l2cap_chan_add_new(struct l2cap_conn *conn, struct l2cap_cha=
n *chan)
> +{
> +       __l2cap_chan_add(conn, chan);
> +       l2cap_chan_put(chan);
> +}

Couldn't we just make __l2cap_chan_add take ownership of the
reference, instead of doing multiple calls to
l2cap_chan_hold/l2cap_chan_put?

>  static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr =
*cmd,
>                           u8 *data, u8 rsp_code)
>  {
> @@ -4053,7 +4083,7 @@ static void l2cap_connect(struct l2cap_conn *conn, =
struct l2cap_cmd_hdr *cmd,
>                 goto response;
>         }
>
> -       chan =3D pchan->ops->new_connection(pchan);
> +       chan =3D l2cap_new_connection(pchan);
>         if (!chan)
>                 goto response;
>
> @@ -4071,7 +4101,7 @@ static void l2cap_connect(struct l2cap_conn *conn, =
struct l2cap_cmd_hdr *cmd,
>         chan->psm  =3D psm;
>         chan->dcid =3D scid;
>
> -       __l2cap_chan_add(conn, chan);
> +       l2cap_chan_add_new(conn, chan);
>
>         dcid =3D chan->scid;
>
> @@ -4883,6 +4913,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>         struct l2cap_le_conn_rsp rsp;
>         struct l2cap_chan *chan, *pchan;
>         u16 dcid, scid, credits, mtu, mps;
> +       u16 rsp_mtu, rsp_mps;
>         __le16 psm;
>         u8 result;
>
> @@ -4895,6 +4926,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>         psm  =3D req->psm;
>         dcid =3D 0;
>         credits =3D 0;
> +       rsp_mtu =3D 0;
> +       rsp_mps =3D 0;
>
>         if (mtu < 23 || mps < 23)
>                 return -EPROTO;
> @@ -4955,7 +4988,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>                 goto response_unlock;
>         }
>
> -       chan =3D pchan->ops->new_connection(pchan);
> +       chan =3D l2cap_new_connection(pchan);
>         if (!chan) {
>                 result =3D L2CAP_CR_LE_NO_MEM;
>                 goto response_unlock;
> @@ -4970,12 +5003,14 @@ static int l2cap_le_connect_req(struct l2cap_conn=
 *conn,
>         chan->omtu =3D mtu;
>         chan->remote_mps =3D mps;
>
> -       __l2cap_chan_add(conn, chan);
> +       l2cap_chan_add_new(conn, chan);
>
>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
>
>         dcid =3D chan->scid;
>         credits =3D chan->rx_credits;
> +       rsp_mtu =3D chan->imtu;
> +       rsp_mps =3D chan->mps;
>
>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>
> @@ -5003,13 +5038,8 @@ static int l2cap_le_connect_req(struct l2cap_conn =
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
> @@ -5179,7 +5209,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>                         continue;
>                 }
>
> -               chan =3D pchan->ops->new_connection(pchan);
> +               chan =3D l2cap_new_connection(pchan);
>                 if (!chan) {
>                         result =3D L2CAP_CR_LE_NO_MEM;
>                         continue;
> @@ -5194,7 +5224,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>                 chan->omtu =3D mtu;
>                 chan->remote_mps =3D mps;
>
> -               __l2cap_chan_add(conn, chan);
> +               l2cap_chan_add_new(conn, chan);
>
>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>
> @@ -7470,14 +7500,14 @@ static void l2cap_connect_cfm(struct hci_conn *hc=
on, u8 status)
>                         goto next;
>
>                 l2cap_chan_lock(pchan);
> -               chan =3D pchan->ops->new_connection(pchan);
> +               chan =3D l2cap_new_connection(pchan);
>                 if (chan) {
>                         bacpy(&chan->src, &hcon->src);
>                         bacpy(&chan->dst, &hcon->dst);
>                         chan->src_type =3D bdaddr_src_type(hcon);
>                         chan->dst_type =3D dst_type;
>
> -                       __l2cap_chan_add(conn, chan);
> +                       l2cap_chan_add_new(conn, chan);
>                 }
>
>                 l2cap_chan_unlock(pchan);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 025329636353..745b012890ee 100644
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
> @@ -1292,18 +1293,25 @@ static int l2cap_sock_recvmsg(struct socket *sock=
, struct msghdr *msg,
>   */
>  static void l2cap_sock_kill(struct sock *sk)
>  {
> +       struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> +
>         if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
>                 return;
>
>         BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
>
> -       /* Sock is dead, so set chan data to NULL, avoid other task use i=
nvalid
> -        * sock pointer.
> +       /* Release the sock's ref on chan and clear the pointer so that
> +        * l2cap_sock_destruct() does not drop it a second time. Setting
> +        * chan->data to NULL first stops any other task from dereferenci=
ng
> +        * the now-dead sock pointer.
>          */
> -       l2cap_pi(sk)->chan->data =3D NULL;
> -       /* Kill poor orphan */
> +       if (chan) {
> +               chan->data =3D NULL;
> +               l2cap_pi(sk)->chan =3D NULL;
> +               l2cap_chan_put(chan);
> +       }
>
> -       l2cap_chan_put(l2cap_pi(sk)->chan);
> +       /* Kill poor orphan */
>         sock_set_flag(sk, SOCK_DEAD);
>         sock_put(sk);
>  }
> @@ -1383,7 +1391,9 @@ static int l2cap_sock_shutdown(struct socket *sock,=
 int how)
>         sock_hold(sk);
>
>         /* prevent chan structure from being freed whilst unlocked */
> -       chan =3D l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
> +       chan =3D l2cap_pi(sk)->chan;
> +       if (chan)
> +               chan =3D l2cap_chan_hold_unless_zero(chan);

l2cap_chan_hold_unless_zero already handles !chan so no need to change
anything here.

>         if (!chan)
>                 goto shutdown_already;
>
> @@ -1546,12 +1556,13 @@ static void l2cap_sock_cleanup_listen(struct sock=
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
> @@ -1559,15 +1570,15 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
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
> @@ -1577,7 +1588,7 @@ static struct l2cap_chan *l2cap_sock_new_connection=
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
> @@ -1875,8 +1886,11 @@ static void l2cap_sock_destruct(struct sock *sk)
>         BT_DBG("sk %p", sk);
>
>         if (l2cap_pi(sk)->chan) {
> -               l2cap_pi(sk)->chan->data =3D NULL;
> -               l2cap_chan_put(l2cap_pi(sk)->chan);
> +               struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> +
> +               chan->data =3D NULL;
> +               l2cap_pi(sk)->chan =3D NULL;
> +               l2cap_chan_put(chan);
>         }
>
>         list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, l=
ist) {
> @@ -1978,10 +1992,10 @@ static struct proto l2cap_proto =3D {
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
> @@ -1992,14 +2006,11 @@ static struct sock *l2cap_sock_alloc(struct net *=
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
> +       /* The sock owns a single ref on chan. It is released by whicheve=
r of
> +        * l2cap_sock_kill() or l2cap_sock_destruct() runs first; that pa=
th
> +        * clears l2cap_pi(sk)->chan so the ref is dropped exactly once. =
The
> +        * caller keeps its own ref independent of this one.
> +        */
>         l2cap_chan_hold(chan);
>
>         l2cap_pi(sk)->chan =3D chan;
> @@ -2011,6 +2022,7 @@ static int l2cap_sock_create(struct net *net, struc=
t socket *sock, int protocol,
>                              int kern)
>  {
>         struct sock *sk;
> +       struct l2cap_chan *chan;
>
>         BT_DBG("sock %p", sock);
>
> @@ -2025,9 +2037,17 @@ static int l2cap_sock_create(struct net *net, stru=
ct socket *sock, int protocol,
>
>         sock->ops =3D &l2cap_sock_ops;
>
> -       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
> -       if (!sk)
> +       chan =3D l2cap_chan_create();
> +       if (!chan)
> +               return -ENOMEM;
> +
> +       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern, ch=
an);
> +       if (!sk) {
> +               l2cap_chan_put(chan);
>                 return -ENOMEM;
> +       }
> +       /* Sock has taken its own refs on chan; drop the chan_create() re=
f. */
> +       l2cap_chan_put(chan);

We can probably eliminate another pair of
l2cap_chan_hold/l2cap_chan_put here as well, just take the ownership
when doing l2cap_pi(sk)->chan =3D chan;, except if we are trying to
prevent use after free but until l2cap_chan is attached to a sk that
should be probably safe.

>
>         l2cap_sock_init(sk, NULL);
>         bt_sock_link(&l2cap_sk_list, sk);
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 1739c1989dbd..887a2fc34391 100644
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
> @@ -3229,9 +3224,14 @@ static inline struct l2cap_chan *smp_new_conn_cb(s=
truct l2cap_chan *pchan)
>          */
>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
>
> -       BT_DBG("created chan %p", chan);
> +       /* Take a reference to match the put in smp_teardown_cb(). The ca=
ller
> +        * drops its own local reference after __l2cap_chan_add().
> +        */
> +       l2cap_chan_hold(chan);

Ditto, if we are not attaching to a field of the sk then we shouldn't
need to hold a reference.

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
