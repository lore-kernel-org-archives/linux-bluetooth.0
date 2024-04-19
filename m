Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADA13B5BE
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550615; cv=none; b=f+TL8F+nhWvf/a8ikFcjwke62Mm1hg7ueUAhbsK5DPH8cPbZ6E4etRM8XwWtCT7wODtYASSgAGjlCwxpfBvjJxqI7oMY3qRfupFG5bDtGir95OixIN2IgZ/fbD3wrjgPnguTij8zMfVTE/vWCSx9qWMZ4y8NQkoWhwGbEUoYDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550615; c=relaxed/simple;
	bh=UPeijYRLd2Zw1JdtgHEhBzbCE5Ts6CRZf+Ml5zou7p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyG/TtFKDjPL/+Yvad+qb3w+Z/4nK4b7HZITHeL+Hf6GgRoe5zg3RDNnEM9wCZZqbolXDe0rUzGSKTsxPB7FR7Xz3rXqSPmBF1ZpkRYNctzX+8UwEGmGg4p3LLKFWwljXOmAPiuEU7Hqqy6VKOgE7mKZKxLf+C3peIkRoWgq5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NM3ZZQCn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM3ZZQCn"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so32178591fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713550612; x=1714155412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/6iHQDDM/v0IHhECyIkixqClxe35q2TiHYEdZPoM2s=;
        b=NM3ZZQCn3tTcrIJLi+o+4QlGvsidxn6m2CuscWBFeqvTmhusESXL0XGqW76fgtGxCG
         N+rY9leYA2dRvOEWzsEjhVJycU9s3cTPu+y3ZfQKS4sQlWvfrgc4hPrMyktOdscrcC97
         j2U9BUG8FVYYiVzqTAciMcET4VSSosGKubMmqFWA5JMcaOjxBihT4Zy8ZsQ7/V4HZgaJ
         Jvzwn5pOxIxHEPNCXKQHbdUtvBF4ONOWjWh1SWohd61vx8TsAaHkp4NGnBLhnyc8SPHH
         QJGEF+y8BkpSYbZejn2Wj1J7LFP4b6gGZ92JCkDS4vdMY7CSBeqK5mfLv92Nh1XgZwFZ
         4FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550612; x=1714155412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/6iHQDDM/v0IHhECyIkixqClxe35q2TiHYEdZPoM2s=;
        b=ZYr2uNomRR3Gm5cXfYNLqtII0zrwynNm6UdrOmY9nb7WjHyPOBmmkqyoYQqEF8bP3Z
         4DGv4E3laW/YlJiRV/dB4CtdYTmpctSI/FXjybSE2QlDjY/NL/ouTMYWHIKfzzEnifTq
         CEgZskMYklVPvv3jE0EW2o2Zv1TvATu9LYS5IWmXna0IQ60iM4Ys/IErdsEzcatM7GPY
         IfHaXTcMlvtf3AsTksIaDtoar67cD9v+0Y7PFhjzbzY/pcw5iQSLsrpWeivw7qeZmc1H
         JTbJNm6/Gv2WEmfAFe7UOnUdgC6kzKrNz2wIyUzG+MkqG7ca7JxCiX3xx4kmLG6KCnCv
         gQKw==
X-Gm-Message-State: AOJu0YxQfms00TTCXxyqKctWtY/3Ahp/hci0plMpVHb4O621KIeNQKMY
	Hxm/TmrYXg3rGsQl4Xgo4G7ZAZnkMsvRj/PqkmcUGil0mMo1DlyvMfhzwTlSoLH0f+qUR563Otw
	DYLu+Wqa4WOElRrJ0q9Xp0URjAkjk+lhQ
X-Google-Smtp-Source: AGHT+IGa+g54QvrhUk6HRaIZajwPf5y910KGv0IzczOtTLRb3AcqFMRKh/mvKAzl3rMUbBmkDR0i3SYiW/pZy8X9elI=
X-Received: by 2002:a2e:888d:0:b0:2d8:a98d:197 with SMTP id
 k13-20020a2e888d000000b002d8a98d0197mr2323978lji.30.1713550611612; Fri, 19
 Apr 2024 11:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419145805.46263-1-vlad.pruteanu@nxp.com> <20240419145805.46263-2-vlad.pruteanu@nxp.com>
 <CABBYNZKAa5FHSxSByjp1OEFAJS_dTSnOdjEA3PoxcjbtH3aSLw@mail.gmail.com>
In-Reply-To: <CABBYNZKAa5FHSxSByjp1OEFAJS_dTSnOdjEA3PoxcjbtH3aSLw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Apr 2024 14:16:38 -0400
Message-ID: <CABBYNZ+SLy72-Tc-bDCYWRtin1y9VtQmKS-5vCYsdqDjSEfF8w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] client/player: Fix transport.send command's
 transfer of packets
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>, Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Apr 19, 2024 at 11:24=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Vlad,
>
> On Fri, Apr 19, 2024 at 10:58=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp=
.com> wrote:
> >
> > The transport.send command sends a number num of packets at intervals o=
f
> > transport latency.
> >
> > Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interval=
.
> >
> > Since this latency could be smaller than the SDU interval, the resultin=
g
> > num could be 0, causing the file transfer to stop after the first packe=
t.
> > In this case num will be set to 1 so that at least 1 packet is always s=
ent.
> >
> > It the transport send timer is set to a value smaller than that of SDU
> > interval, the available buffers for ISO Data will eventually become ful=
l.
> > Thus, if a packet can't be sent due to resource temporarily being
> > unavailable decrease the fd offset so that next time the same packet wi=
ll
> > be sent.
> >
> > This patch is a temporary fix until the appropriate solution that uses
> > number of completed packets to control the flow of ISO Data packets is
> > implemented.
> >
> > Since both Unicast and Broadcast scenarios use the same transport funct=
ions
> > differentiate between the 2 cases when accessing the qos structures to =
get
> > the transport latency.
> > ---
> >  client/player.c | 55 +++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 49 insertions(+), 6 deletions(-)
> >
> > diff --git a/client/player.c b/client/player.c
> > index 1f56bfd27..ca169e58f 100644
> > --- a/client/player.c
> > +++ b/client/player.c
> > @@ -34,6 +34,7 @@
> >
> >  #include "lib/bluetooth.h"
> >  #include "lib/uuid.h"
> > +#include "lib/iso.h"
> >
> >  #include "profiles/audio/a2dp-codecs.h"
> >  #include "src/shared/lc3.h"
> > @@ -4972,11 +4973,23 @@ static int transport_send_seq(struct transport =
*transport, int fd, uint32_t num)
> >                 }
> >
> >                 ret =3D send(transport->sk, buf, ret, 0);
> > +               /* If send failed due to the resource being temporarily
> > +                * unavailable the controller's ISO data buffers are
> > +                * full. Try sending the same packet next time.
> > +                */
> >                 if (ret <=3D 0) {
> > -                       bt_shell_printf("send failed: %s (%d)",
> > +                       if (errno =3D=3D EAGAIN) {
> > +                               /* Decrease the fd's offset so that the=
 same
> > +                                * packet is sent next time.
> > +                                */
> > +                               offset =3D lseek(fd, -transport->mtu[1]=
,
> > +                                                               SEEK_CU=
R);
>
> Not really sure why you think this is a good idea, ISO already has
> retransmission support and if that is failing then there is no reason
> to retry here, beside this could loop causing the same data to be
> retried forever.
>
> > +                       } else {
> > +                               bt_shell_printf("send failed: %s (%d)",
> >                                                         strerror(errno)=
, errno);
> > -                       free(buf);
> > -                       return -errno;
> > +                               free(buf);
> > +                               return -errno;
> > +                       }
> >                 }
> >
> >                 elapsed_time(!transport->seq, &secs, &nsecs);
> > @@ -5033,7 +5046,15 @@ static bool transport_timer_read(struct io *io, =
void *user_data)
> >
> >         /* num of packets =3D latency (ms) / interval (us) */
> >         num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval)=
;
> > -
> > +       if (num < 1)
> > +               /* The latency could be smaller than the interval resul=
ting in
> > +                * num being 0. If this is the case, set it to 1 so tha=
t packets
> > +                * will still be sent.
> > +                */
> > +               num =3D 1;
>
> Perhaps we should be looking into rounding closest sort of logic.
>
> > +       /* TODO: replace this timer based implementation with one that
> > +        * uses the number of completed packets reports.
> > +        */

Regarding this TODO item, Im planning to introduce something like the
following to io.h:

+bool io_set_tx_complete_handler(struct io *io, io_tx_complete_func_t callb=
ack,
+                               int flags, int pool_interval,
+                               void *user_data, io_destroy_func_t destroy)=
;

The problem is that if we do schedule new packets on tx_complete
callback that doesn't account for the time it takes to process such
event, so over time this will accumulate and at some point we could
perhaps miss an interval, @Pauli Virtanen or perhaps you are not
really doing the flow control based on the TX timestamp/complete? That
perhaps depends if the controller is generating the events as soon as
the packet is submitted or at the exact moment of the event interval,
in any case the general idea is that we keep the controller buffers
full as much as possible to prevent missing intervals.

> >         ret =3D transport_send_seq(transport, transport->fd, num);
> >         if (ret < 0) {
> >                 bt_shell_printf("Unable to send: %s (%d)\n",
> > @@ -5052,6 +5073,8 @@ static bool transport_timer_read(struct io *io, v=
oid *user_data)
> >  static int transport_send(struct transport *transport, int fd,
> >                                         struct bt_iso_qos *qos)
> >  {
> > +       struct sockaddr_iso addr;
> > +       socklen_t optlen;
> >         struct itimerspec ts;
> >         int timer_fd;
> >
> > @@ -5068,8 +5091,28 @@ static int transport_send(struct transport *tran=
sport, int fd,
> >                 return -errno;
> >
> >         memset(&ts, 0, sizeof(ts));
> > -       ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> > -       ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 1000000;
> > +       /* Need to know if the transport on which data is sent is
> > +        * broadcast or unicast so that the correct qos structure
> > +        * can be accessed. At this point in code there's no other
> > +        * way of knowing this besides checking the peer address.
> > +        * Broadcast will use BDADDR_ANY, while Unicast will use
> > +        * the connected peer's actual address.
> > +        */
> > +       memset(&addr, 0, sizeof(addr));
> > +       optlen =3D sizeof(addr);
> > +
> > +       if (getpeername(transport->sk, &addr, &optlen) < 0)
> > +               return -errno;
> > +
> > +       if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
> > +               /* Interval is measured in ms, multiply by 1000000 to g=
et ns */
> > +               ts.it_value.tv_nsec =3D qos->bcast.out.latency * 100000=
0;
> > +               ts.it_interval.tv_nsec =3D qos->bcast.out.latency * 100=
0000;
> > +       } else {
> > +               /* Interval is measured in ms, multiply by 1000000 to g=
et ns */
> > +               ts.it_value.tv_nsec =3D qos->ucast.out.latency * 100000=
0;
> > +               ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 100=
0000;
> > +       }
>
> This is a different fix, please send it as a separate patch.
>
> >         if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0=
)
> >                 return -errno;
> > --
> > 2.40.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
