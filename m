Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D728A50
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382654; cv=none; b=a0Pm/qOibZoq69+qD2rnUlVsxbhy0sD5Unlo+oCXbyDpYBekLgCQP8P10x2tTCZlAKhtQShUa2bZflx1b5+X2Q0i/IQdOCspXz21bGV3VryDd4T3wBICHtzgw8EFLckoi30XyY51GVaFhinypMc8tdLGBR35Y+WdeDKhBMxnK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382654; c=relaxed/simple;
	bh=EbnxoQ3Bs21W32Ccl2e2q1I3tvRibgmDAwoqc2Sz4HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqMm8w7RPY11vDb91QB+Ubv1jgZRe32PYSSIY0uZVMGzZqu0ofojHuWw00kDAwB8WIuw/3YkkDYevElsubwIvEKz1Tpwpp925VTJz+xRh2PDRqodTK1geg6sgv68KGwrq9FNYtWSlesMzxNi+8hwHmHgPa+4JSaXGwu81AYbtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPPrAORy; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPPrAORy"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so60327551fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711382651; x=1711987451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQw1cCgEAHHtkd0WP5rvcJU6+iwd0px/j8SgkYb5pho=;
        b=VPPrAORyKjKycYirGxBmP4QRNQEe+tN5x4YN/UeLYAYzOH5hkH7J2sdKVdnqEt+Bdp
         pvK6Nri0qv7WQMtJqI+16q3Vc9Nb3ujWawl8WmqlBjluRwBriSMVjHw2K4mTVXOVlJYJ
         YEc9g6ZNRWmP79CM37FCLjlEIhOGu4raby5o4Qw4NPuvAViGJIldWniP3p9t4pFgrmiT
         wYE5FuK3TOSpNteFWv8bFAs0Vab42QBI0Yx2FwIFnR7jhmUdw7lt7fOWkx8XL6x/xPQL
         XFpq4Iq4MRkE3+4lQDzG4T+8xz3i+d+4hZT38m0UDOYTRkSq9vz5E3l7ozpJnqX8UEYJ
         GZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382651; x=1711987451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQw1cCgEAHHtkd0WP5rvcJU6+iwd0px/j8SgkYb5pho=;
        b=RbS3mK8Ax91jtChK1MSTErpq/Xq2Hahz3FbchSnQTJyaKcW/uL+1uXaw5yXRYvMKIR
         jIsxJVUEn41Sm8256vdfM1evycV91l2EpxH0F/v4Vv6YzKwZr8PfqQ8vdR/jjuSkkzH8
         bqja5a1SON6Jg4fk2uRaGTbzIKMra4QypzRPnH0+BHhRmMptJc4JfAZ21LG6BnabQpbz
         j2Dusru+GtFb3Gxp7uDMfexcF8RMJX2Lm6s5YgAJZ27nnTT9JV/MbTCfO+n2pwliLRhg
         xc0iVH1ZcuTjcFE/DUXdX6LyfXtFjn4bSQvAkUSYRAtj7+kO59oslQ16+uv+ZOP42919
         ArYg==
X-Gm-Message-State: AOJu0YwlpJjKUxlhH8SaFEzYhMSscIwZwo+QI8pYl0zOk8NwXZUD46xL
	65jzpwoL8KTKFLSsTdxuI8//BV5+5NoW7+oKvk4DzB0HdnzTuvJUC7QyJWta+vlo8YMSqRbJWdz
	UDqbygeYnSMUf6lC+z8iK7wFaR7hA6snu
X-Google-Smtp-Source: AGHT+IGBO3IEd0vhF0AqzZ1kU8Z9cNpYh4Ui+1cNKq2vK3EbWrAUtWyXVfAs4XllY6e/fk4CzOx0Jjpbe7+ZEMLPC7c=
X-Received: by 2002:a2e:9a98:0:b0:2d2:3fac:5fdc with SMTP id
 p24-20020a2e9a98000000b002d23fac5fdcmr4598856lji.10.1711382650271; Mon, 25
 Mar 2024 09:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325144031.335354-1-vlad.pruteanu@nxp.com> <20240325144031.335354-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20240325144031.335354-2-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Mar 2024 12:03:56 -0400
Message-ID: <CABBYNZLHb3dRVQ5KxNCorOp2cJWjAwknCU9--19UScFgfMJ7bA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] client/player: Fix transport.send command's
 transfer of packets
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Mon, Mar 25, 2024 at 10:40=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.c=
om> wrote:
>
> The transport.send command sends a number num of packets at intervals
> specified by the transport latency reported by the CIS Establsihed event.
> Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interval.
> Since this latency could be smaller than the SDU interval for some preset=
s,
> the resulting num would be 0, causing the file transfer to stop after the
> first packet. Instead, one packet should be sent at SDU interval distance
> apart.

Please add some output samples showing the wrong interval ends up being use=
d.

> ---
>  client/player.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index 1f56bfd27..f579d9904 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -34,6 +34,7 @@
>
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
> +#include "lib/iso.h"
>
>  #include "profiles/audio/a2dp-codecs.h"
>  #include "src/shared/lc3.h"
> @@ -5007,7 +5008,6 @@ static bool transport_timer_read(struct io *io, voi=
d *user_data)
>         struct bt_iso_qos qos;
>         socklen_t len;
>         int ret, fd;
> -       uint32_t num;
>         uint64_t exp;
>
>         if (transport->fd < 0)
> @@ -5031,10 +5031,7 @@ static bool transport_timer_read(struct io *io, vo=
id *user_data)
>                 return false;
>         }
>
> -       /* num of packets =3D latency (ms) / interval (us) */
> -       num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval);
> -
> -       ret =3D transport_send_seq(transport, transport->fd, num);
> +       ret =3D transport_send_seq(transport, transport->fd, 1);
>         if (ret < 0) {
>                 bt_shell_printf("Unable to send: %s (%d)\n",
>                                         strerror(-ret), ret);
> @@ -5052,6 +5049,8 @@ static bool transport_timer_read(struct io *io, voi=
d *user_data)
>  static int transport_send(struct transport *transport, int fd,
>                                         struct bt_iso_qos *qos)
>  {
> +       struct sockaddr_iso addr;
> +       socklen_t optlen;
>         struct itimerspec ts;
>         int timer_fd;
>
> @@ -5068,9 +5067,30 @@ static int transport_send(struct transport *transp=
ort, int fd,
>                 return -errno;
>
>         memset(&ts, 0, sizeof(ts));
> -       ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> -       ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 1000000;
>
> +       /* Need to know if the transport on which data is sent is
> +        * broadcast or unicast so that the correct qos structure
> +        * can be accessed. At this point in code there no other
> +        * way of knowing this besides checking the peer address.
> +        * Broadcast will use BDADDR_ANY, while Unicast will use
> +        * the connected peer's actual address.
> +        */
> +       memset(&addr, 0, sizeof(addr));
> +       optlen =3D sizeof(addr);
> +
> +       if (getpeername(transport->sk, &addr, &optlen) < 0)
> +               return -errno;

The description seems to be suggesting there is a rounding error, but
the code below only deals with the fact we didn't use proper fields
for broadcast, so is it really fixing what is the patch description or
something else?

> +       if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
> +               /* Interval is measured in us, multiply by 1000 to get ns=
 */
> +               ts.it_value.tv_nsec =3D qos->bcast.out.interval * 1000;
> +               ts.it_interval.tv_nsec =3D qos->bcast.out.interval * 1000=
;
> +       } else {
> +               /* Interval is measured in us, multiply by 1000 to get ns=
 */
> +               ts.it_value.tv_nsec =3D qos->ucast.out.interval * 1000;
> +               ts.it_interval.tv_nsec =3D qos->ucast.out.interval * 1000=
;
> +
> +       }
>         if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
>                 return -errno;
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
