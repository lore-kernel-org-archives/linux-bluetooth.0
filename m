Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474D184E
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540282; cv=none; b=tgYTez+NuOLBzhtt1b0iAm5vRqEiZFYJOC02jqKtjAWnwEyHLuhUKUCSPsHS2ci9J82hl3jx/E3dbQdgHpKgsB5DzveaDQymCPFlANDzWkjkBj8kAYkmwnzC2Q54dKR6nJFDMXJkzKrvDtKxKyTvOraDOC6Z4mYCPdaiuivI93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540282; c=relaxed/simple;
	bh=GUe5ZBPpY0POZjbkkkwfrit/NAAasHZEYFMjTtaJhmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ex/eu738mFZBTKzuwEfPdFzUIDjrvNklo+YzVoqwdR1LwcmAAxkk+WIctiCEuUcAtGnHq3wnbi7+UB0ziGUX6LcJwjLruVlj6fUFy4fbaAgbQAWHfl/+PRnjkaug8/hU1XypQl/HiPAOJw1hZN4OcznaYIEFU8360mUXV6T1n2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khGCzy2j; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khGCzy2j"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so10903621fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713540279; x=1714145079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jelfnOTLqGFrvbfRDFIMU34NXG8TPwYxc+ZC/xQgdO0=;
        b=khGCzy2jgIwijPn/K0efYAbxvEc2D6kqdvoRWVK9xeGztqvbkOGIBfmvm7QH1EiBKI
         r4TldZWrs+HaRTiTCH8aZgss2b7IcZZkqU/AjuSzh8uTrBy9qsKqhFDewG/JRRF1X6KS
         vcjhaw70k28znWAiFzr9GaLtswa6++ej2Fv6xZNEVIgo6PjKqIWYuMFFbijmE49bxC+v
         MWQpU7vobh8o3k9UgDjYwXmRZNxhNsXI3FrBpSAzopa3PK2UaILgVstMDBEljV5AUnl6
         iNochPFhTx8X7HPek76ryLkvZ0l8hLXJSYkFYZ4nSh7Vo4WDFsj700hleTt+MatBTQ3U
         g69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540279; x=1714145079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jelfnOTLqGFrvbfRDFIMU34NXG8TPwYxc+ZC/xQgdO0=;
        b=pf3KmQaze2FvJI2nyuhWzq2dmvI6T9InG/MxPCWbiz26fIxASNSvJBXDH+wdtqflx3
         82PcMgXcHnamJjzUm99mSoLZtCk1SNiK7q2kpuqnECTxJ80ASi8iOJhxDOn4YaXnrZ2o
         T6/SjbSg+NDTEEbZJmsucRS2zWNijDKms/8UXWh0yM77j73FUa+pMUOpznfaXDCcRUeo
         BsXeh51JCJnVfrjVBWzZCiBzwthJtppadNgqq3e2sZOYx+qofb9crN/im8KfbJs1Ffcw
         pPZ0kn7un+U9AaFqVNBIiFWX07sYmf1sc5IUcTxnkHp52YwV/+l84CdpuqwU6fEF8eBH
         NMUQ==
X-Gm-Message-State: AOJu0YyiFK9429gCFvasBW+HwWz3ijPZXZ9Swg/gBK0z0iblDJrj9T9x
	sewyqgrGxRmUwW5NrAWGKfZ/SqLnBlb35Q1pk9Y2C7CTk0T/mKRlSehHRj508Wt4ychCxhHjnjv
	9XYT37rdJ0ce/9sO8lVCubHAfivk=
X-Google-Smtp-Source: AGHT+IEfet+Yy4a9dNlgoOU9MbH+GXt/dvvMj5fjgUM8E9pgsSmy9y5TtZNbNQEIJFOGmfjFBRvTNrD80l4qAB9jFjk=
X-Received: by 2002:a2e:9d58:0:b0:2d8:67a0:61b2 with SMTP id
 y24-20020a2e9d58000000b002d867a061b2mr1693327ljj.20.1713540278070; Fri, 19
 Apr 2024 08:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419145805.46263-1-vlad.pruteanu@nxp.com> <20240419145805.46263-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20240419145805.46263-2-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Apr 2024 11:24:25 -0400
Message-ID: <CABBYNZKAa5FHSxSByjp1OEFAJS_dTSnOdjEA3PoxcjbtH3aSLw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] client/player: Fix transport.send command's
 transfer of packets
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Fri, Apr 19, 2024 at 10:58=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.c=
om> wrote:
>
> The transport.send command sends a number num of packets at intervals of
> transport latency.
>
> Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interval.
>
> Since this latency could be smaller than the SDU interval, the resulting
> num could be 0, causing the file transfer to stop after the first packet.
> In this case num will be set to 1 so that at least 1 packet is always sen=
t.
>
> It the transport send timer is set to a value smaller than that of SDU
> interval, the available buffers for ISO Data will eventually become full.
> Thus, if a packet can't be sent due to resource temporarily being
> unavailable decrease the fd offset so that next time the same packet will
> be sent.
>
> This patch is a temporary fix until the appropriate solution that uses
> number of completed packets to control the flow of ISO Data packets is
> implemented.
>
> Since both Unicast and Broadcast scenarios use the same transport functio=
ns
> differentiate between the 2 cases when accessing the qos structures to ge=
t
> the transport latency.
> ---
>  client/player.c | 55 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index 1f56bfd27..ca169e58f 100644
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
> @@ -4972,11 +4973,23 @@ static int transport_send_seq(struct transport *t=
ransport, int fd, uint32_t num)
>                 }
>
>                 ret =3D send(transport->sk, buf, ret, 0);
> +               /* If send failed due to the resource being temporarily
> +                * unavailable the controller's ISO data buffers are
> +                * full. Try sending the same packet next time.
> +                */
>                 if (ret <=3D 0) {
> -                       bt_shell_printf("send failed: %s (%d)",
> +                       if (errno =3D=3D EAGAIN) {
> +                               /* Decrease the fd's offset so that the s=
ame
> +                                * packet is sent next time.
> +                                */
> +                               offset =3D lseek(fd, -transport->mtu[1],
> +                                                               SEEK_CUR)=
;

Not really sure why you think this is a good idea, ISO already has
retransmission support and if that is failing then there is no reason
to retry here, beside this could loop causing the same data to be
retried forever.

> +                       } else {
> +                               bt_shell_printf("send failed: %s (%d)",
>                                                         strerror(errno), =
errno);
> -                       free(buf);
> -                       return -errno;
> +                               free(buf);
> +                               return -errno;
> +                       }
>                 }
>
>                 elapsed_time(!transport->seq, &secs, &nsecs);
> @@ -5033,7 +5046,15 @@ static bool transport_timer_read(struct io *io, vo=
id *user_data)
>
>         /* num of packets =3D latency (ms) / interval (us) */
>         num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval);
> -
> +       if (num < 1)
> +               /* The latency could be smaller than the interval resulti=
ng in
> +                * num being 0. If this is the case, set it to 1 so that =
packets
> +                * will still be sent.
> +                */
> +               num =3D 1;

Perhaps we should be looking into rounding closest sort of logic.

> +       /* TODO: replace this timer based implementation with one that
> +        * uses the number of completed packets reports.
> +        */
>         ret =3D transport_send_seq(transport, transport->fd, num);
>         if (ret < 0) {
>                 bt_shell_printf("Unable to send: %s (%d)\n",
> @@ -5052,6 +5073,8 @@ static bool transport_timer_read(struct io *io, voi=
d *user_data)
>  static int transport_send(struct transport *transport, int fd,
>                                         struct bt_iso_qos *qos)
>  {
> +       struct sockaddr_iso addr;
> +       socklen_t optlen;
>         struct itimerspec ts;
>         int timer_fd;
>
> @@ -5068,8 +5091,28 @@ static int transport_send(struct transport *transp=
ort, int fd,
>                 return -errno;
>
>         memset(&ts, 0, sizeof(ts));
> -       ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> -       ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 1000000;
> +       /* Need to know if the transport on which data is sent is
> +        * broadcast or unicast so that the correct qos structure
> +        * can be accessed. At this point in code there's no other
> +        * way of knowing this besides checking the peer address.
> +        * Broadcast will use BDADDR_ANY, while Unicast will use
> +        * the connected peer's actual address.
> +        */
> +       memset(&addr, 0, sizeof(addr));
> +       optlen =3D sizeof(addr);
> +
> +       if (getpeername(transport->sk, &addr, &optlen) < 0)
> +               return -errno;
> +
> +       if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
> +               /* Interval is measured in ms, multiply by 1000000 to get=
 ns */
> +               ts.it_value.tv_nsec =3D qos->bcast.out.latency * 1000000;
> +               ts.it_interval.tv_nsec =3D qos->bcast.out.latency * 10000=
00;
> +       } else {
> +               /* Interval is measured in ms, multiply by 1000000 to get=
 ns */
> +               ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> +               ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 10000=
00;
> +       }

This is a different fix, please send it as a separate patch.

>         if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
>                 return -errno;
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
