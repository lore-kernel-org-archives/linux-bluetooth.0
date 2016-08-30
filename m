Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9f92cebe-284c-47b1-1e7d-1ed6581b20f4@nextfour.com>
References: <9f92cebe-284c-47b1-1e7d-1ed6581b20f4@nextfour.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Aug 2016 11:23:30 +0300
Message-ID: <CABBYNZLtFB9HWXs_Z+CsHJ9pP=NZ_rm8bhx5ng5Cu_LtHJu2kA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth, regression: MSG_TRUNC fixes
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mika,

On Wed, Aug 24, 2016 at 1:13 PM, Mika Penttil=C3=A4
<mika.penttila@nextfour.com> wrote:
> Recent 4.8-rc changes to bluetooth MSG_TRUNC handling introduced regressi=
on; pairing finishes
> but connecting profiles not.
>
> With the below fixes to MSG_TRUNC handling the connection is established =
normally.
>
> --Mika
>
>
> Signed-off-by: Mika Penttil=C3=A4 <mika.penttila@nextfour.com>
> ---
>
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index ece45e0..0b5f729 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -250,7 +250,7 @@ int bt_sock_recvmsg(struct socket *sock, struct msghd=
r *msg, siz
>
>         skb_free_datagram(sk, skb);
>
> -       if (msg->msg_flags & MSG_TRUNC)
> +       if (flags & MSG_TRUNC)
>                 copied =3D skblen;
>
>         return err ? : copied;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 6ef8a01..96f04b7 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1091,7 +1091,7 @@ static int hci_sock_recvmsg(struct socket *sock, st=
ruct msghdr
>
>         skb_free_datagram(sk, skb);
>
> -       if (msg->msg_flags & MSG_TRUNC)
> +       if (flags & MSG_TRUNC)
>                 copied =3D skblen;
>
>         return err ? : copied;
> --

I believe similar patches already went to bluetooth-next so it should
be in the way if not already merged.

--=20
Luiz Augusto von Dentz
