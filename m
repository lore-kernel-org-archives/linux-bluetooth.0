Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686058F6D
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472729; cv=none; b=gcSjWOtCP4xZjalVkHpof6pFvpjXPnlwrJQupTXwT7g4fO5Zr5MwgNDgymiCy/R86CCeT1iD7wo0tkW8455re4saBq2+JreJJYgFHvXcypLC5mZUkDT059TupjsyBiGQlwL+AtrdK2s1mLR2mp2HkF6K95ohHWTuzk5tT+deLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472729; c=relaxed/simple;
	bh=sfEwhCPaSC8juHDAlV9abQM/BLvo8wJ5E+8R/1Y56fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5ymmfTvIWyd7yjJk5muQVzwZY2HlR+L3CiaaBL4VsU3hMMe0JLJMM3ft8D/OIyT1rEoxYDmwSHIktmV7/g0y27JdoByNbtVnHNBqqFFlqvmM0xfkKc1zqm4jELPmQE+y1auJ6slCXZzqULsjSJ1OSnSPHjmFSV/y83GJpw932Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4qV4qq2; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4qV4qq2"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d27fef509eso19555031fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710472725; x=1711077525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS4c3ZtM6l+COgmrGrxD2RksYtGeuZVB9fHm62hQuTk=;
        b=P4qV4qq2u6TX8Zacy8VdD9/bOS5Xr8H4fjFj00Lt0xe2P1Ao5jzqOwQapqKhs9CKkL
         2LXSMIovAaylDIKjMPlsqs3VdX6fdpd6aZUeF84zsBhSikKyqkJv8+Gv2IJ2+TU+31yr
         Sp8i7TAwxkcHldyt3YuhOeZ1WaWiYoFQevng5GwYe6otRscfNhs5dUjLEfEYWYTpUEBO
         4/TRvBjJyUxfJYsMdOZiz+mE19YsTkGaBsn5v4c+SO/Wh0F1ben/FB0R7IY6ygdxke9J
         c5tQwxHQ9WwcTX6VyrSAhHVqJGzkSOIASapAKYM13XMRUSAjUMrpvHLeSb0XSKuWmGwO
         Y+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710472725; x=1711077525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS4c3ZtM6l+COgmrGrxD2RksYtGeuZVB9fHm62hQuTk=;
        b=qxWbluCIZWaXUjDVwJuRddpIPtaVWxNwmH+llQZveSSXbJzs9+qEmgkJVKr1t4k7O9
         1cfZg1eAVR0aIP5GoPtVH+L9iUPxw/hqFJqiZzH3Bheb0K6jDedAuOlIZ6e+cnyzs1Kn
         Ha6yCqeG+xje+Q6OCUj18NhfVRn5q8ZJwoark7kAp0LuEeZbmn6AiSJWqCVBFthcVs7b
         6poRPnZ7p6QTHb695bmH7A2ylpIFrvmDNXi/YyIOtJXbOIQf84bz748wSzxRoyhc/doR
         19BtdPP8G6MhzvkOL1Ydsm2ilLl8xiN65hsMUBU8Sy299Fv3YDk38iF621BAiw3ZnzRq
         0fpg==
X-Gm-Message-State: AOJu0YwZkCtL4u7kl+FrU/P+oxY5gMOnRRbUDI9nXyhoyVzd2gsvjAi3
	1OcuBDddBatrXtgiRgdfwNqPdeOhjckc98vJz7NXlMM9R4KRBMKbh14pjxX5drVOJqv9BIEvlCL
	cJsZNurEhHHuCbyHm/z43+psRbAgqd2cmVvI=
X-Google-Smtp-Source: AGHT+IGVIKiCBvGZ/OjfQetjNcKeR+KnGtfUuH0HmGE4cXi/lsJM25TFS1z6B7BiTwBfGICW1Kcj/A5+Tl3N6eQJxvA=
X-Received: by 2002:a2e:7017:0:b0:2d4:758c:1c40 with SMTP id
 l23-20020a2e7017000000b002d4758c1c40mr2193713ljc.10.1710472725077; Thu, 14
 Mar 2024 20:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710440392.git.pav@iki.fi> <134027f3cbaeb7095d080c27cd4b1053d2eb560e.1710440392.git.pav@iki.fi>
In-Reply-To: <134027f3cbaeb7095d080c27cd4b1053d2eb560e.1710440392.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Mar 2024 23:18:32 -0400
Message-ID: <CABBYNZLWbwTGOuZeYvFou=+98_XNdYVu-hWiqrUFvZvuU50_yw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Bluetooth: add BT_NO_ERRQUEUE_POLL socket option
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Mar 14, 2024 at 2:23=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add socket option to disable POLLERR on non-empty socket error queue.
>
> Applications can use this for sleeping socket error POLLERR waits, also
> when using TX timestamping. This is useful when multiple layers of the
> stack are using the same socket.

So the idea here is that bluetoothd would set BT_NO_ERRQUEUE_POLL to
not be awakened by timestamps? I wonder why this works on per
fd/socket level while SO_TIMESTAMPING does apply to all sockets
though, or perhaps that is not really related to SO_TIMESTAMPING but
errqueue being the same to all cloned sockets? I'm a little hesitant
to start introducing new socket options if the whole point was to
avoid doing so with the use of SO_TIMESTAMPING.


> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/bluetooth.h |  9 +++-
>  net/bluetooth/af_bluetooth.c      | 72 ++++++++++++++++++++++++++++++-
>  net/bluetooth/iso.c               |  8 ++--
>  net/bluetooth/l2cap_sock.c        |  8 ++--
>  net/bluetooth/sco.c               |  8 ++--
>  5 files changed, 91 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 9280e72093ee..dcee5384d715 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -240,6 +240,8 @@ struct bt_codecs {
>
>  #define BT_ISO_BASE            20
>
> +#define BT_NO_ERRQUEUE_POLL    21
> +
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> @@ -387,7 +389,8 @@ struct bt_sock {
>  enum {
>         BT_SK_DEFER_SETUP,
>         BT_SK_SUSPEND,
> -       BT_SK_PKT_STATUS
> +       BT_SK_PKT_STATUS,
> +       BT_SK_NO_ERRQUEUE_POLL
>  };
>
>  struct bt_sock_list {
> @@ -410,6 +413,10 @@ int  bt_sock_stream_recvmsg(struct socket *sock, str=
uct msghdr *msg,
>                             size_t len, int flags);
>  __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_table=
 *wait);
>  int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long =
arg);
> +int bt_sock_setsockopt(struct socket *sock, int level, int optname,
> +                      sockptr_t optval, unsigned int optlen);
> +int bt_sock_getsockopt(struct socket *sock, int level, int optname,
> +                      char __user *optval, int __user *optlen);
>  int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)=
;
>  int  bt_sock_wait_ready(struct sock *sk, unsigned int msg_flags);
>
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 67604ccec2f4..997197aa7b48 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -500,6 +500,12 @@ static inline __poll_t bt_accept_poll(struct sock *p=
arent)
>         return 0;
>  }
>
> +static bool bt_sock_error_queue_poll(struct sock *sk)
> +{
> +       return !test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags) &&
> +               !skb_queue_empty_lockless(&sk->sk_error_queue);
> +}
> +
>  __poll_t bt_sock_poll(struct file *file, struct socket *sock,
>                       poll_table *wait)
>  {
> @@ -511,7 +517,7 @@ __poll_t bt_sock_poll(struct file *file, struct socke=
t *sock,
>         if (sk->sk_state =3D=3D BT_LISTEN)
>                 return bt_accept_poll(sk);
>
> -       if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
> +       if (sk->sk_err || bt_sock_error_queue_poll(sk))
>                 mask |=3D EPOLLERR |
>                         (sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI =
: 0);
>
> @@ -582,6 +588,70 @@ int bt_sock_ioctl(struct socket *sock, unsigned int =
cmd, unsigned long arg)
>  }
>  EXPORT_SYMBOL(bt_sock_ioctl);
>
> +int bt_sock_setsockopt(struct socket *sock, int level, int optname,
> +                      sockptr_t optval, unsigned int optlen)
> +{
> +       struct sock *sk =3D sock->sk;
> +       int err =3D 0;
> +       u32 opt;
> +
> +       if (level !=3D SOL_BLUETOOTH)
> +               return -ENOPROTOOPT;
> +
> +       lock_sock(sk);
> +
> +       switch (optname) {
> +       case BT_NO_ERRQUEUE_POLL:
> +               if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
> +                       err =3D -EFAULT;
> +                       break;
> +               }
> +
> +               if (opt)
> +                       set_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags=
);
> +               else
> +                       clear_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->fla=
gs);
> +               break;
> +
> +       default:
> +               err =3D -ENOPROTOOPT;
> +               break;
> +       }
> +
> +       release_sock(sk);
> +       return err;
> +}
> +EXPORT_SYMBOL(bt_sock_setsockopt);
> +
> +int bt_sock_getsockopt(struct socket *sock, int level, int optname,
> +                      char __user *optval, int __user *optlen)
> +{
> +       struct sock *sk =3D sock->sk;
> +       int err =3D 0;
> +       u32 opt;
> +
> +       if (level !=3D SOL_BLUETOOTH)
> +               return -ENOPROTOOPT;
> +
> +       lock_sock(sk);
> +
> +       switch (optname) {
> +       case BT_NO_ERRQUEUE_POLL:
> +               opt =3D test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flag=
s);
> +               if (put_user(opt, (u32 __user *)optval))
> +                       err =3D -EFAULT;
> +               break;
> +
> +       default:
> +               err =3D -ENOPROTOOPT;
> +               break;
> +       }
> +
> +       release_sock(sk);
> +       return err;
> +}
> +EXPORT_SYMBOL(bt_sock_getsockopt);
> +
>  /* This function expects the sk lock to be held when called */
>  int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo)
>  {
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index a77ab9df7994..6f5af549a8cc 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1596,8 +1596,8 @@ static int iso_sock_setsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_setsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> @@ -1667,8 +1667,8 @@ static int iso_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_getsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 9a9f933a748b..06277ce1fd6b 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -697,8 +697,8 @@ static int l2cap_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_getsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> @@ -1102,8 +1102,8 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_setsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index b3c2af7c7d67..b8b1b314aed4 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -968,8 +968,8 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_setsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> @@ -1211,8 +1211,8 @@ static int sco_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>                 break;
>
>         default:
> -               err =3D -ENOPROTOOPT;
> -               break;
> +               release_sock(sk);
> +               return bt_sock_getsockopt(sock, level, optname, optval, o=
ptlen);
>         }
>
>         release_sock(sk);
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
