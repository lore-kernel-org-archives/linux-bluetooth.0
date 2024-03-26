Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55713C919
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467242; cv=none; b=NEIwEgIG/ncey30o+QA8Hj7C6LUuYGJNVf45//bOs69UVk77wYZ99ze1FUPM2ljI+9d8LTNDQW0TMnEgpF5VPUrzSSNZ7GCPrDTE0klMwQNLljwTtymdmgsSELFWDwzq07waXvzGljq3NpdP4IGLO0RH8Jy4CTVUga3H8QGy+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467242; c=relaxed/simple;
	bh=fylGhHFqGGhA/IdFXG9bDjDOmCKG8nXTMSp197cNV+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgeaO+5z2iq13FP9NjRWddBbRfL4+/tvwxJLH7a/3EQ5WYGgWf/H7jA54xPgOBT7EpXf7LPcl/ipDy/Im/gC/uOVHnmkMlpyMNioo0Vm4WkDJeMetWXPv+qoAfKEdsxhD5FCYbHiZrMCdV5ls65yGHmHAXE/ixsXhwfUyBQ4YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAKpz88M; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAKpz88M"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d6ee81bcd4so6624341fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711467239; x=1712072039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdW5IYEdhdPJN9JvhsmEKb8jj3fZA3AkNx8BkvH5wGU=;
        b=PAKpz88MRxnF5t82FnsTHMfJF754FJrhmrTY1Hcl+ZpYZsimIiDmTIIdya56SKRIEh
         DI9z9pZSojPpnJwY4akBmlIvKrvBimu50B4fFky0sCI6cy+HM4gIH5Trx3vzPESHaIuO
         rI8OqasESnDHS+OmhEaK2MANIs2zxHeQtKwxmjglGC0m8uvwo9RufZ8JehrrJ94RLtek
         3oLZHFYeruJ/WOmOmD9rmrWryrDOQBNmuoDOXatl9vawzNzIUnujGQnXYU/utF4jNmhA
         3K/qsZPB9ako9/EScSMtBI7auy2PtlMxxIjbSLo05TcZTbqLM90Z+IwjxcQAvB4chPHP
         8nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711467239; x=1712072039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdW5IYEdhdPJN9JvhsmEKb8jj3fZA3AkNx8BkvH5wGU=;
        b=WNyQf5HS5TjPxZSpY3RUK6uXr61p4lnS/ifE+IDHuoWaDNDz7ZgQfbl59+ezlfH/uO
         auDNYPFengZfbzFsZ7CQ23ySU2Eghe3YFm65t5ET2csoLHIXgM1Rk1NSTMoaXbpdKfs2
         ji718h+a4YFSphqFAyB9HHVPYqcAQQOEu1CZcs/6wGSTJU8FJTccDrQuRz7nKP8iHsYE
         zcAHv8eAARF0NpksUZO8VDfz16wn+tdcIO0L41414CVT2sbFdvQcGtaWOSuFFQGLBFY8
         8dTMAWfQFHx0816cMcGMb7ohUMfmjRhTPMERt8F4NmYRUuuun2YzAoJ3mj5cqa6Z5rif
         QebA==
X-Gm-Message-State: AOJu0YxNu+Pbd6VqGR23Wuenn3+x5czyORhhIF5iNI3mKCQMEi7jZdXg
	wuRzE5vNbGqpvOC2jicI+IzBdHjEnkKQtNm8q7/qUG7f7w+2iiq8//phy/rnNi8yGSFg/KITmDd
	PMRxPCwxILy/APT0pYcSHxXO5S1lNhwwQ
X-Google-Smtp-Source: AGHT+IFFLt5oR6d7CNaHVzQWW8p7+KKsCSNqlrOVScS0+VGPzOasXJ8/PkT/2N30aL+hmfdG7CCc8+2bMlA5lnXfg4U=
X-Received: by 2002:a2e:9797:0:b0:2d6:c2dc:3396 with SMTP id
 y23-20020a2e9797000000b002d6c2dc3396mr5430951lji.30.1711467238306; Tue, 26
 Mar 2024 08:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325144031.335354-1-vlad.pruteanu@nxp.com>
 <20240325144031.335354-2-vlad.pruteanu@nxp.com> <CABBYNZLHb3dRVQ5KxNCorOp2cJWjAwknCU9--19UScFgfMJ7bA@mail.gmail.com>
 <VI1PR04MB5389EC60FC16B07F986D9003FE352@VI1PR04MB5389.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5389EC60FC16B07F986D9003FE352@VI1PR04MB5389.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Mar 2024 11:33:45 -0400
Message-ID: <CABBYNZJpgBEPRmLQ4vxLzE9DkwPDzLEN+xBiwU5QrF974-A9JQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ 1/1] client/player: Fix transport.send
 command's transfer of packets
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>, 
	Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>, Iulia Tanasescu <iulia.tanasescu@nxp.com>, 
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Tue, Mar 26, 2024 at 11:21=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.c=
om> wrote:
>
> Hello Luiz,
>
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Monday, March 25, 2024 6:04 PM
> > To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> > octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> > <silviu.barbulescu@nxp.com>; Iulia Tanasescu <iulia.tanasescu@nxp.com>;
> > Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > Subject: [EXT] Re: [PATCH BlueZ 1/1] client/player: Fix transport.send
> > command's transfer of packets
> >
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t
> > this email' button
> >
> >
> > Hi Vlad,
> >
> > On Mon, Mar 25, 2024 at 10:40=E2=80=AFAM Vlad Pruteanu
> > <vlad.pruteanu@nxp.com> wrote:
> > >
> > > The transport.send command sends a number num of packets at intervals
> > > specified by the transport latency reported by the CIS Establsihed ev=
ent.
> > > Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interv=
al.
> > > Since this latency could be smaller than the SDU interval for some pr=
esets,
> > > the resulting num would be 0, causing the file transfer to stop after=
 the
> > > first packet. Instead, one packet should be sent at SDU interval dist=
ance
> > > apart.
> >
> > Please add some output samples showing the wrong interval ends up being
> > used.
> >
> Below you can find what I consider to a relevant excerpt taken from btmon=
 log:
> ...
> < HCI Command: LE Set Connected Isochronous Group Parameters (0x08|0x0062=
)
>         CIG ID: 0x00
>         Central to Peripheral SDU Interval: 10000 us (0x002710)
>         Peripheral to Central SDU Interval: 10000 us (0x002710)
>         SCA: 201 - 500 ppm (0x00)
>         Packing: Sequential (0x00)
>         Framing: Unframed (0x00)
>         Central to Peripheral Maximum Latency: 10 ms (0x000a)
>         Peripheral to Central Maximum Latency: 10 ms (0x000a)
>         Number of CIS: 1
>         CIS ID: 0x00
>         Central to Peripheral Maximum SDU Size: 40
>         Peripheral to Central Maximum SDU Size: 0
>         Central to Peripheral PHY: LE 2M (0x02)
>         Peripheral to Central PHY: LE 2M (0x02)
>         Central to Peripheral Retransmission attempts: 0x02
>         Peripheral to Central Retransmission attempts: 0x00
> ...
> > HCI Event: Command Complete (0x0e)
>       LE Set Connected Isochronous Group Parameters (0x08|0x0062) ncmd 1
>         Status: Success (0x00)
>         CIG ID: 0x00
>         Number of Handles: 1
>         Connection Handle #0: 144
> ...
> < HCI Command: LE Create Connected Isochronous Stream (0x08|0x0064)
>         Number of CIS: 1
>         CIS Handle: 144
>         ACL Handle: 128
> ...
> > HCI Event: LE Meta Event (0x3e)
>       LE Connected Isochronous Stream Established (0x19)
>         Status: Success (0x00)
>         Connection Handle: 144
>         CIG Synchronization Delay: 1992 us (0x0007c8)
>         CIS Synchronization Delay: 1992 us (0x0007c8)
>         Central to Peripheral Latency: 1992 us (0x0007c8)
>         Peripheral to Central Latency: 1992 us (0x0007c8)
>         Central to Peripheral PHY: LE 2M (0x02)
>         Peripheral to Central PHY: LE 2M (0x02)
>         Number of Subevents: 3
>         Central to Peripheral Burst Number: 1
>         Peripheral to Central Burst Number: 0
>         Central to Peripheral Flush Timeout: 1
>         Peripheral to Central Flush Timeout: 1
>         Central to Peripheral MTU: 40
>         Peripheral to Central MTU: 0
>         ISO Interval: 10.00 msec (0x0008)
> ...
> bluetoothd[349393]: < ISO Data TX: Handle 144 flags 0x02
> > HCI Event: Number of Completed Packets (0x13)
>         Num handles: 1
>         Handle: 144 Address: A0:CD:F3:78:04:0A (Murata Manufacturing Co.,=
 Ltd.)
>         Count: 1
>         #470: len 44 (27 Kb/s)
>         Latency: 13 msec (13-13 msec ~13 msec)
>
> The Maximum Latency is correctly set to 10ms in the LE Set Connected Isoc=
hronous Group Parameters command, and the controller reports the final late=
ncy as being 1992 us. This is the value that (after conversion to ms) qos.u=
cast.out.latency takes in the current implementation. num is defined as num=
 =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval), with interval=
 being the ISO interval, 10000us and therefore num will be 0 in this case. =
As you can see the first packet is always sent, but after that none can be =
seen. Instead, the Host should send 1 packet every time this function is ca=
lled. The timer related change below ensures that this function is triggere=
d at every SDU interval. So, in the end, the Host will send 1 packet every =
SDU interval.
> > > ---
> > >  client/player.c | 34 +++++++++++++++++++++++++++-------
> > >  1 file changed, 27 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/client/player.c b/client/player.c
> > > index 1f56bfd27..f579d9904 100644
> > > --- a/client/player.c
> > > +++ b/client/player.c
> > > @@ -34,6 +34,7 @@
> > >
> > >  #include "lib/bluetooth.h"
> > >  #include "lib/uuid.h"
> > > +#include "lib/iso.h"
> > >
> > >  #include "profiles/audio/a2dp-codecs.h"
> > >  #include "src/shared/lc3.h"
> > > @@ -5007,7 +5008,6 @@ static bool transport_timer_read(struct io *io,
> > void *user_data)
> > >         struct bt_iso_qos qos;
> > >         socklen_t len;
> > >         int ret, fd;
> > > -       uint32_t num;
> > >         uint64_t exp;
> > >
> > >         if (transport->fd < 0)
> > > @@ -5031,10 +5031,7 @@ static bool transport_timer_read(struct io *io=
,
> > void *user_data)
> > >                 return false;
> > >         }
> > >
> > > -       /* num of packets =3D latency (ms) / interval (us) */
> > > -       num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interva=
l);
> > > -
> > > -       ret =3D transport_send_seq(transport, transport->fd, num);
> > > +       ret =3D transport_send_seq(transport, transport->fd, 1);
> > >         if (ret < 0) {
> > >                 bt_shell_printf("Unable to send: %s (%d)\n",
> > >                                         strerror(-ret), ret);
> > > @@ -5052,6 +5049,8 @@ static bool transport_timer_read(struct io *io,
> > void *user_data)
> > >  static int transport_send(struct transport *transport, int fd,
> > >                                         struct bt_iso_qos *qos)
> > >  {
> > > +       struct sockaddr_iso addr;
> > > +       socklen_t optlen;
> > >         struct itimerspec ts;
> > >         int timer_fd;
> > >
> > > @@ -5068,9 +5067,30 @@ static int transport_send(struct transport
> > *transport, int fd,
> > >                 return -errno;
> > >
> > >         memset(&ts, 0, sizeof(ts));
> > > -       ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> > > -       ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 1000000;
> > >
> > > +       /* Need to know if the transport on which data is sent is
> > > +        * broadcast or unicast so that the correct qos structure
> > > +        * can be accessed. At this point in code there no other
> > > +        * way of knowing this besides checking the peer address.
> > > +        * Broadcast will use BDADDR_ANY, while Unicast will use
> > > +        * the connected peer's actual address.
> > > +        */
> > > +       memset(&addr, 0, sizeof(addr));
> > > +       optlen =3D sizeof(addr);
> > > +
> > > +       if (getpeername(transport->sk, &addr, &optlen) < 0)
> > > +               return -errno;
> >
> > The description seems to be suggesting there is a rounding error, but
> > the code below only deals with the fact we didn't use proper fields
> > for broadcast, so is it really fixing what is the patch description or
> > something else?
> >
> The main change that I made here is the value of the interval for the tim=
er.
> Before, it used to be set to qos.ucast.out.latency and I propose to chang=
e
> it to qos.ucast.out.interval, so that the Host will send 1SDU packet on
> every ISO Interval. I included the ucast/bcast qos update since I was
> already updating this line of code. That is, I didn't want to send the pa=
tch
> with "qos->ucast.out.interval" without differentiating between bcast and
> ucast since it would've been wrong.

Hmm if I recall correctly this code used to be sending a packet per
interval but we run into problems because the interval is rather short
and OS itself would take time to transfer the packet from userspace to
socket and then to driver, etc, so I suggest we round up the value if
it ends up being 0.

> > > +       if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
> > > +               /* Interval is measured in us, multiply by 1000 to ge=
t ns */
> > > +               ts.it_value.tv_nsec =3D qos->bcast.out.interval * 100=
0;
> > > +               ts.it_interval.tv_nsec =3D qos->bcast.out.interval * =
1000;
> > > +       } else {
> > > +               /* Interval is measured in us, multiply by 1000 to ge=
t ns */
> > > +               ts.it_value.tv_nsec =3D qos->ucast.out.interval * 100=
0;
> > > +               ts.it_interval.tv_nsec =3D qos->ucast.out.interval * =
1000;
> > > +
> > > +       }
> > >         if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) <=
 0)
> > >                 return -errno;
> > >
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
