Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Apr 2012 11:52:22 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Don't check source address in SCO bind
 function
Message-ID: <20120419145222.GE4127@joana>
References: <1334835833-21828-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1334835833-21828-3-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-04-19 13:43:53 +0200]:

> Checking the source address in SCO bind function will prevent from
> having an incoming and outgoing SCO socket. However that might be
> needed in case of multiple SCO connections on a single device.
>=20
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/sco.c |   16 ++++++----------
>  1 files changed, 6 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 2fb9636..8b2548c 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -463,7 +463,6 @@ static int sco_sock_bind(struct socket *sock, struct =
sockaddr *addr, int addr_le
>  {
>  	struct sockaddr_sco *sa =3D (struct sockaddr_sco *) addr;
>  	struct sock *sk =3D sock->sk;
> -	bdaddr_t *src =3D &sa->sco_bdaddr;
>  	int err =3D 0;
> =20
>  	BT_DBG("sk %p %s", sk, batostr(&sa->sco_bdaddr));
> @@ -478,17 +477,14 @@ static int sco_sock_bind(struct socket *sock, struc=
t sockaddr *addr, int addr_le
>  		goto done;
>  	}
> =20
> -	write_lock(&sco_sk_list.lock);
> -
> -	if (bacmp(src, BDADDR_ANY) && __sco_get_sock_by_addr(src)) {
> -		err =3D -EADDRINUSE;

this patch adds a compiling warning:

  CC [M]  net/bluetooth/sco.o
  net/bluetooth/sco.c:277:21: warning: =E2=80=98__sco_get_sock_by_addr=E2=
=80=99 defined
  but not used [-Wunused-function]

	Gustavo
