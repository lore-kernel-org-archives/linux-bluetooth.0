Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Mar 2013 11:56:18 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bluetooth: Replaced kzalloc and memcpy with kmemdup
Message-ID: <20130318145618.GA16337@joana>
References: <1363442830-13754-1-git-send-email-gheorghiuandru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1363442830-13754-1-git-send-email-gheorghiuandru@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexandru,

* Alexandru Gheorghiu <gheorghiuandru@gmail.com> [2013-03-16 16:07:10 +0200=
]:

> Replaced calls to kzalloc followed by memcpy with a single call to kmemdu=
p.
> Patch found using coccinelle.
>=20
> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
> ---
>  net/bluetooth/a2mp.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index eb0f4b1..140e81c 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -397,13 +397,12 @@ static int a2mp_getampassoc_rsp(struct amp_mgr *mgr=
, struct sk_buff *skb,
>  	if (ctrl) {
>  		u8 *assoc;
> =20
> -		assoc =3D kzalloc(assoc_len, GFP_KERNEL);
> +		assoc =3D kmemdup(rsp->amp_assoc, assoc_len, GFP_KERNEL);
>  		if (!assoc) {
>  			amp_ctrl_put(ctrl);
>  			return -ENOMEM;
>  		}
> =20
> -		memcpy(assoc, rsp->amp_assoc, assoc_len);
>  		ctrl->assoc =3D assoc;
>  		ctrl->assoc_len =3D assoc_len;
>  		ctrl->assoc_rem_len =3D assoc_len;
> @@ -472,13 +471,12 @@ static int a2mp_createphyslink_req(struct amp_mgr *=
mgr, struct sk_buff *skb,
>  		size_t assoc_len =3D le16_to_cpu(hdr->len) - sizeof(*req);
>  		u8 *assoc;
> =20
> -		assoc =3D kzalloc(assoc_len, GFP_KERNEL);
> +		assoc =3D kmemdup(rep->amp_assoc, assoc_len, GFP_KERNEL);

Please get into the habit of build your patches before sending them upstrea=
m:

  CC [M]  net/bluetooth/a2mp.o
net/bluetooth/a2mp.c: In function =E2=80=98a2mp_createphyslink_req=E2=80=99:
net/bluetooth/a2mp.c:474:19: error: =E2=80=98rep=E2=80=99 undeclared (first=
 use in this function)
net/bluetooth/a2mp.c:474:19: note: each undeclared identifier is reported o=
nly once for each function it appears in
make[2]: *** [net/bluetooth/a2mp.o] Error 1
make[1]: *** [net/bluetooth] Error 2


	Gustavo
