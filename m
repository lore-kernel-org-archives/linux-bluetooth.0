Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090123094149.GA31218@milesteg.arr>
References: <20090123094149.GA31218@milesteg.arr>
Date: Fri, 23 Jan 2009 14:50:13 +0100
Message-ID: <80b317760901230550u75353e7dw1efed395cc9e6259@mail.gmail.com>
Subject: Re: [PATCH] Fix unused variable warning in rfcomm
From: Richard Genoud <richard.genoud@gmail.com>
To: Daniele Venzano <venza@brownhat.org>
Cc: Kernel Janitors <kernel-janitors@vger.kernel.org>, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2009/1/23 Daniele Venzano <venza@brownhat.org>:
> The following patch fixes a warning generated when compiling rfcomm.c
> without CONFIG_BT_RFCOMM_DEBUG.
> The warning was:
> net/bluetooth/rfcomm/sock.c: In function 'rfcomm_sock_ioctl':
> net/bluetooth/rfcomm/sock.c:795: warning: unused variable 'sk'
>
> Patch is against 2.6.28.1
>
> Signed-off-by: Daniele Venzano <venza@brownhat.org>
>
> --- a/net/bluetooth/rfcomm/sock.c       2009-01-23 10:30:34.000000000 +0100
> +++ b/net/bluetooth/rfcomm/sock.c       2009-01-23 10:31:25.000000000 +0100
> @@ -792,7 +792,9 @@ static int rfcomm_sock_getsockopt(struct
>
>  static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  {
> +#ifdef CONFIG_BT_RFCOMM_DEBUG
>        struct sock *sk = sock->sk;
> +#endif
>        int err;
>
>        BT_DBG("sk %p cmd %x arg %lx", sk, cmd, arg);
>

if CONFIG_BT_RFCOMM_TTY is set, the compilation will break.

richard.
