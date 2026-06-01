Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC02E7F2C
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336730; cv=pass; b=hlUk7SXKkUh72A1lfwUw5p8X0paClCutIVJVUuK4pZfDvG31Bur3FUABKYsG5F9mfkgiWI1LEaRXUAQ35kCCvu+HA64y1SGWe8k590KV/zYG6dL8OIxHfqN8L3KrbMSgdpxAuqmcRwahxPdnLkq6c8tF4i23xFgcfMbtsltDLtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336730; c=relaxed/simple;
	bh=woNJa/FzEM0cojmyubwdWg5lY6MdMILhcKCzOAiSjOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gL8m3pMjhwPzYn4THle5ynugcwGR2+lsOtCg3DkKYLYtQh1TMOZz5oyZLkVeNz62wBRxFBV47EEt0MMzCexg6LrcXrSs7THA0+qeZqPINKvGsAWiFTgpC9f+z91AOkzN4rUueEnPf0N72BrwXDsYvQxrV4z0N90b3/4At0oDMxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK2f9lzk; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK2f9lzk"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65eb226b1ceso10771058d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 10:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336728; cv=none;
        d=google.com; s=arc-20240605;
        b=dOAvL3e3l6kpxpS1x0K1Q8fDDdVE9MZUnS2I16xY85zl2dC/uLrYpkze8og89WHuWT
         +5VbQCWNKS3bPa48TcwPoZQFIASq9wFSrMz1iRbGWVqRqDeqnqIyShtgGJOWNgpHpPyj
         gLIUFCIu51wWgKiCRLS9XZ3S7AoIihDIH2yMbyIgPaL2g0hlmU37WmZJhyTD9btxQyO0
         +wXtONlAWNE2Ny+Opi7P38FLSwPCbyZz3L1GX86AKIeGhXr9b7pXujZafTEueLRYGqkh
         VX7uHAB0rks1q0uNHEyFY2jMlQ/EdJSScOaCJtjwrF6PzbRBLa9Lyptq0tUmPqPz/quU
         8MmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLomJ0DKHOSEBGvnHCXVbu5A27ziPbPeiXLeNvvzTic=;
        fh=kmTtcPVj+NwKA/2aY2OrjqcAKmpSRxaKrLQ5z9sOKUE=;
        b=Tfn9ozSBXbDCOYfBuEPAvjP/PmVWZ04YMxJxqfMmX6U4BSuWNzVc4NDOWKPdxfbJ/M
         rIw2M2tYMH6V2u98IzBxYkdmc02nnfJXn4ApNl78KxcH4oWOLt2KLbKvdQ7qUDZA+jNn
         QDGOa8tmtrRDDUzuQSwkOhWUXPvdrNUtQBvM8WOtuVphEqe3yyujMT8cGFeZHIo/ayKz
         d9ktT39Tgji9a/3FsgMmxo7Re0WGjuCZ6dYlsozCM/YtF/J+G++a2fsORJB6h91uO8Vw
         9JcAQ591yu8jSc5hqNZs4kwSvsvnmOC9bIv2EsVCjWMslPCVvrgYqdTEmkJtAxGYN+9/
         qVeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336728; x=1780941528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLomJ0DKHOSEBGvnHCXVbu5A27ziPbPeiXLeNvvzTic=;
        b=DK2f9lzkJeiJtM7mqZx0ZefdR8EQkUgAu7TeARvwea0tLgihQsTKQYAhW+tpLU8fTK
         fJ6mqko65lA4BJ3MM7WzyCtAI/3jgUHfew0SA2pufiiqA22khS7kJHjyfs8L8zydEQbX
         cuW5Mk05GmO1bxIRIbHFcuJIllycn7Uf0sszMtfeEDHUiz0jft2W4W8BQ+ON2nSPfc8J
         M5jbLiQgpU68FKNtmITmG/IuL/J8/CpUoUTM5+YmVuyOG1Yq0CjK7sFpHx5xC0f5pnjD
         tWCU/XB3PXyAD/Jh4U+BEtRFYDtLuZjz+mQwOqErmHtpNg3v0FNDr86eGCCuW1RN1wxK
         xLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336728; x=1780941528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLomJ0DKHOSEBGvnHCXVbu5A27ziPbPeiXLeNvvzTic=;
        b=eCBjev65LgSm5A6v2AACSLwKJz1Aby0hZLHnRDUQsW0a9fv2uXqRLJqutud03pdLWw
         ylEa3aUc3dDJM4XYqDfVUZSV1fnmnqvnKW67n2inYaCDbgFfmWVg53AJdyj35RhK23o6
         Z3OSQmbzcXrJDn/daJCPYO/x0A+/wtVKfPxx53+PnAAEEHPQH3gFbqGbTA8OmAmuZLmv
         /O+eaQekUpJq9prSRrnzwxL+vOy0cdIbm0BXaNS19j7m6V+GLebtIf7aSrlrczdfm4aK
         JsiLboEBVIu5MWWg+M/HIxxN7wzTFT12Gvexk/RYFdlXbFPydpKrBARWPocVv2lGIfWC
         bpnw==
X-Forwarded-Encrypted: i=1; AFNElJ9CXlVkqUrh6zKZ1I1pvx2o4Dwu2CbqhewKSSDZUUHFMTgPo0uR3RLoBja9Df8mTzQGffB7pgxW8F65ZFZGqK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dRPfPa1R5BUV8HiX7NwOYDtVIVxiRYEnA52mONXkIQ8gD6nb
	NlrgjlXtNYQlsDeIN0bogFu1WcX3PBHdtsIjME4FbBhdgE7PRp10rmQzCZfgz3e1LGlbUsnBclV
	S9LobjreYN/HXjXbhLYq2iYiUQMMu4vQKCgcDpG0=
X-Gm-Gg: Acq92OG8YWnBMPoau5TrGi/pswaulYHybyrsHLdAqQ2vUS9MJm4VsS4pmcNq24VZVG/
	YwuRCXEnyJF19Ly8hbWe1UHyM2bEI+D28ddtyPnSGyMFwzT3uVf5xgR3+aK1EtFJwLLFD4Up1iV
	BH9I1upZS89Q2i0Jb/EcNOTVzp8fOCJybOg0DvfUTZmWtA9zcyIe1IAaRr00h/DuL20dVPjP+Ti
	i0yQ/gpRcUyCT6FrU8bTwIf6bjlGL+RdM9gtQsxP9u2Rkr9MkLi2+5v44uNk9Ye4g+IlB2MYrva
	iwtileFOnOFYJoMwFPU2cJ3X74NvIjwraurp5rnauLZEjPu3XFiIJ/EqPv275GesDeLuvhaWvUC
	YPQ==
X-Received: by 2002:a05:690e:2547:b0:650:3b84:c250 with SMTP id
 956f58d0204a3-6605ecb1b00mr8487315d50.2.1780336727501; Mon, 01 Jun 2026
 10:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601140444.1676239-1-oss@fourdim.xyz> <20260601140444.1676239-2-oss@fourdim.xyz>
In-Reply-To: <20260601140444.1676239-2-oss@fourdim.xyz>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jun 2026 13:58:35 -0400
X-Gm-Features: AVHnY4IO3_CeWOEpHt9WE37bmrz2g0EiXDBnsoJrEgLYMWLi-UuAyHSof5Yu9iQ
Message-ID: <CABBYNZ+RwgV1by5VioeHDwZSF6T2R04r+DdvKiKuDN7DX4se0A@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
To: Siwei Zhang <oss@fourdim.xyz>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Siwei,

On Mon, Jun 1, 2026 at 10:05=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> wrote=
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
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
> ---
>  include/net/bluetooth/l2cap.h |  8 +++--
>  net/bluetooth/6lowpan.c       | 32 +++++++++++--------
>  net/bluetooth/l2cap_core.c    | 60 ++++++++++++++++++++++++++---------
>  net/bluetooth/l2cap_sock.c    | 48 ++++++++++++++++------------
>  net/bluetooth/smp.c           | 18 +++++------
>  5 files changed, 106 insertions(+), 60 deletions(-)
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
> index 23a229ab6a33..284eefb73e94 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -622,6 +622,15 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
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
> @@ -630,11 +639,7 @@ static struct l2cap_chan *chan_create(void)
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
> @@ -743,19 +748,20 @@ static inline void chan_ready_cb(struct l2cap_chan =
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
> +
>         BT_DBG("chan %p pchan %p", chan, pchan);
>
> -       return chan;
> +       return 0;
>  }
>
>  static void unregister_dev(struct lowpan_btle_dev *dev)
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fdccd62ccca8..3edf6680899e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4005,6 +4005,36 @@ static inline int l2cap_command_rej(struct l2cap_c=
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
> +
>  static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr =
*cmd,
>                           u8 *data, u8 rsp_code)
>  {
> @@ -4051,7 +4081,7 @@ static void l2cap_connect(struct l2cap_conn *conn, =
struct l2cap_cmd_hdr *cmd,
>                 goto response;
>         }
>
> -       chan =3D pchan->ops->new_connection(pchan);
> +       chan =3D l2cap_new_connection(pchan);
>         if (!chan)
>                 goto response;
>
> @@ -4069,7 +4099,7 @@ static void l2cap_connect(struct l2cap_conn *conn, =
struct l2cap_cmd_hdr *cmd,
>         chan->psm  =3D psm;
>         chan->dcid =3D scid;
>
> -       __l2cap_chan_add(conn, chan);
> +       l2cap_chan_add_new(conn, chan);
>
>         dcid =3D chan->scid;
>
> @@ -4881,6 +4911,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>         struct l2cap_le_conn_rsp rsp;
>         struct l2cap_chan *chan, *pchan;
>         u16 dcid, scid, credits, mtu, mps;
> +       u16 rsp_mtu, rsp_mps;
>         __le16 psm;
>         u8 result;
>
> @@ -4893,6 +4924,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>         psm  =3D req->psm;
>         dcid =3D 0;
>         credits =3D 0;
> +       rsp_mtu =3D 0;
> +       rsp_mps =3D 0;
>
>         if (mtu < 23 || mps < 23)
>                 return -EPROTO;
> @@ -4953,7 +4986,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *=
conn,
>                 goto response_unlock;
>         }
>
> -       chan =3D pchan->ops->new_connection(pchan);
> +       chan =3D l2cap_new_connection(pchan);
>         if (!chan) {
>                 result =3D L2CAP_CR_LE_NO_MEM;
>                 goto response_unlock;
> @@ -4968,12 +5001,14 @@ static int l2cap_le_connect_req(struct l2cap_conn=
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
> @@ -5001,13 +5036,8 @@ static int l2cap_le_connect_req(struct l2cap_conn =
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
> @@ -5177,7 +5207,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>                         continue;
>                 }
>
> -               chan =3D pchan->ops->new_connection(pchan);
> +               chan =3D l2cap_new_connection(pchan);
>                 if (!chan) {
>                         result =3D L2CAP_CR_LE_NO_MEM;
>                         continue;
> @@ -5192,7 +5222,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>                 chan->omtu =3D mtu;
>                 chan->remote_mps =3D mps;
>
> -               __l2cap_chan_add(conn, chan);
> +               l2cap_chan_add_new(conn, chan);
>
>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>
> @@ -7399,14 +7429,14 @@ static void l2cap_connect_cfm(struct hci_conn *hc=
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

Hmm, this doesn't sound right. Why would we need 2 references for
l2cap_sock_kill and l2cap_sock_destruct? Whener we do l2cap_chan_put
we should set the pointer to NULL and not keep 2 references since the
destruct maybe called without it being killed first, either way having
to handle multiple reference like this is not optimal so we should fix
this if we can.

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
