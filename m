Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115745BE4
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987269; cv=none; b=GxQFv4EsFkHJaXkKzYtLtNl+ZOb5tyk0Ts4+mOK9JljhyRI/2aQu3WZmJVBbSzC+5IIJEtTnyc4MoOqpFICiRCPNVp7FhNswU0fRyN7y6N51xSf/mY4eOqXC0w90yihGPPqcjzu3hDVslScW/Xl2YxCs4eIBNCim64XgoEpRYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987269; c=relaxed/simple;
	bh=uRnv42c1jsBAeLMKv7Nf4ne0X5DA5kTQzEl5JEn/qsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFGDK4lh9bfSoaoW48yFA0tX/k6F7jIiUH5KOYmkdpNneS/y7uCLXDhAmX3o3uVMLnyDt5uwxWfTVZfDqJovuhH+H3s/fPZkFExZRcioznBarllFKzQKIS5Xp59saUu7F23h/krC+5n4GYQQ0U95b+vVJov2582SLaez8Wg2YLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFkErsYo; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFkErsYo"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso59429041fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711987266; x=1712592066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xj3U9wHdepzOFFBhEnTHjUyaGiIqErz+tA9ln5zLcE=;
        b=jFkErsYoJ86fvxeWzlzEYuFWEJBjSFQtUeulSUvwb1PLR/LechZgpKIn1Mnhj6FZwT
         MmM+fuYUUKKMeu7EMCOTTvibd7oIiPswYtJ1R2m2Y+OeJ9OA3WaoXhiV0Zr2gAXo2Zx8
         IY0bET657fy003wjPL2uIHhTz28AftN6OoavviNxL/x0hp74xkiYbQbcbxiSwVuaP3hE
         cWZ35Ja/PbEhVFY97oWvMDMPgv0bvKWphYdZgYyn5m3+owDp4aKSJRgecoTA2+jWFQl6
         yrXs9WBjnE3yvC/KrEvFtkh8DX46wNJ0r1/D2bz6GCkEDiWHlzLcRJz0fvs1tjVg3LGU
         iJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711987266; x=1712592066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Xj3U9wHdepzOFFBhEnTHjUyaGiIqErz+tA9ln5zLcE=;
        b=oGhEMR0AZcpBw8nxaT9MPMb7jXxmn73zE7sYpx1YchytTiTknDunThehphoJpJTWWn
         tJp67KcSYk3SZYE+GfEUF/VdlMV5Ry/KyKCTI2IDRhCHl8/8TeNUY9LWf0zIJo20eduD
         IrKHpi/Beoj58P2L7WRwLmJcW5U/tfSZU1ahlj88Lutmy6mN16muxTgTWzzKUuIDaTIR
         jqgEOKhS3/Qumq4eB0yxeBTRFgcokoTzn+zDrFVlrw7GC0sBd+k4zRuij5vCdIfoqhOz
         KOr7sNtQRLhtmqcUuCyPGsPowi1bmUqeBHmr9MLVDHgn3EDBWuoqDpdgTIZcwsDrrhgF
         gIuw==
X-Forwarded-Encrypted: i=1; AJvYcCWaB4rdWVbn52kiovpGcLZLcpNLS/b25MMhyVQDipApwopSNE/N7oxh1HC5bWJf2S4Sag7fWKFJ4fYq6v7NpBgInX0OKGnDUh/nxWRFwYOV
X-Gm-Message-State: AOJu0Yw8lRLMUZechzqPx2fZrS5hp8xcf7DEfF1/X3HmpsMc45X+AxJR
	HVmfsxkTiTEnvYwgx4Q97wt7JS0qptykqNBgQBbrD0ziIb8N/D70QP1/Rxgm7AnnFz+h/PMPoeo
	0pBkIYEZZi7vGKMEZ5xl04kv93wD0Gccn
X-Google-Smtp-Source: AGHT+IEwRfHaMmI+woLu6nOhJExK8G/P26TvqOLJ4/+CTdvsivgK9KGrjmk4+OWZeVxbmzcmfd9h/Jn/3qkuyhuq9OM=
X-Received: by 2002:a2e:7c0a:0:b0:2d6:9d74:f553 with SMTP id
 x10-20020a2e7c0a000000b002d69d74f553mr5986118ljc.5.1711987265479; Mon, 01 Apr
 2024 09:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325144031.335354-1-vlad.pruteanu@nxp.com>
 <20240325144031.335354-2-vlad.pruteanu@nxp.com> <CABBYNZLHb3dRVQ5KxNCorOp2cJWjAwknCU9--19UScFgfMJ7bA@mail.gmail.com>
 <VI1PR04MB5389EC60FC16B07F986D9003FE352@VI1PR04MB5389.eurprd04.prod.outlook.com>
 <CABBYNZJpgBEPRmLQ4vxLzE9DkwPDzLEN+xBiwU5QrF974-A9JQ@mail.gmail.com> <ebd75f6a431bdd62021cb34f7bd6009c15772709.camel@iki.fi>
In-Reply-To: <ebd75f6a431bdd62021cb34f7bd6009c15772709.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Apr 2024 12:00:52 -0400
Message-ID: <CABBYNZKj6FS6K8-YMu=3mBpw+M-How6LXBW5+=iUHT2X=Ls++Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] client/player: Fix transport.send command's
 transfer of packets
To: Pauli Virtanen <pav@iki.fi>
Cc: Vlad Pruteanu <vlad.pruteanu@nxp.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Apr 1, 2024 at 11:05=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2024-03-26 kello 11:33 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Vlad,
> >
> > On Tue, Mar 26, 2024 at 11:21=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@n=
xp.com> wrote:
> > >
> > > Hello Luiz,
> > >
> > >
> > > > -----Original Message-----
> > > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > Sent: Monday, March 25, 2024 6:04 PM
> > > > To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
> > > > Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> > > > octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> > > > <silviu.barbulescu@nxp.com>; Iulia Tanasescu <iulia.tanasescu@nxp.c=
om>;
> > > > Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > > > Subject: [EXT] Re: [PATCH BlueZ 1/1] client/player: Fix transport.s=
end
> > > > command's transfer of packets
> > > >
> > > > Caution: This is an external email. Please take care when clicking =
links or
> > > > opening attachments. When in doubt, report the message using the 'R=
eport
> > > > this email' button
> > > >
> > > >
> > > > Hi Vlad,
> > > >
> > > > On Mon, Mar 25, 2024 at 10:40=E2=80=AFAM Vlad Pruteanu
> > > > <vlad.pruteanu@nxp.com> wrote:
> > > > >
> > > > > The transport.send command sends a number num of packets at inter=
vals
> > > > > specified by the transport latency reported by the CIS Establsihe=
d event.
> > > > > Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.in=
terval.
> > > > > Since this latency could be smaller than the SDU interval for som=
e presets,
> > > > > the resulting num would be 0, causing the file transfer to stop a=
fter the
> > > > > first packet. Instead, one packet should be sent at SDU interval =
distance
> > > > > apart.
> > > >
> > > > Please add some output samples showing the wrong interval ends up b=
eing
> > > > used.
> > > >
> > > Below you can find what I consider to a relevant excerpt taken from b=
tmon log:
> > > ...
> > > < HCI Command: LE Set Connected Isochronous Group Parameters (0x08|0x=
0062)
> > >         CIG ID: 0x00
> > >         Central to Peripheral SDU Interval: 10000 us (0x002710)
> > >         Peripheral to Central SDU Interval: 10000 us (0x002710)
> > >         SCA: 201 - 500 ppm (0x00)
> > >         Packing: Sequential (0x00)
> > >         Framing: Unframed (0x00)
> > >         Central to Peripheral Maximum Latency: 10 ms (0x000a)
> > >         Peripheral to Central Maximum Latency: 10 ms (0x000a)
> > >         Number of CIS: 1
> > >         CIS ID: 0x00
> > >         Central to Peripheral Maximum SDU Size: 40
> > >         Peripheral to Central Maximum SDU Size: 0
> > >         Central to Peripheral PHY: LE 2M (0x02)
> > >         Peripheral to Central PHY: LE 2M (0x02)
> > >         Central to Peripheral Retransmission attempts: 0x02
> > >         Peripheral to Central Retransmission attempts: 0x00
> > > ...
> > > > HCI Event: Command Complete (0x0e)
> > >       LE Set Connected Isochronous Group Parameters (0x08|0x0062) ncm=
d 1
> > >         Status: Success (0x00)
> > >         CIG ID: 0x00
> > >         Number of Handles: 1
> > >         Connection Handle #0: 144
> > > ...
> > > < HCI Command: LE Create Connected Isochronous Stream (0x08|0x0064)
> > >         Number of CIS: 1
> > >         CIS Handle: 144
> > >         ACL Handle: 128
> > > ...
> > > > HCI Event: LE Meta Event (0x3e)
> > >       LE Connected Isochronous Stream Established (0x19)
> > >         Status: Success (0x00)
> > >         Connection Handle: 144
> > >         CIG Synchronization Delay: 1992 us (0x0007c8)
> > >         CIS Synchronization Delay: 1992 us (0x0007c8)
> > >         Central to Peripheral Latency: 1992 us (0x0007c8)
> > >         Peripheral to Central Latency: 1992 us (0x0007c8)
> > >         Central to Peripheral PHY: LE 2M (0x02)
> > >         Peripheral to Central PHY: LE 2M (0x02)
> > >         Number of Subevents: 3
> > >         Central to Peripheral Burst Number: 1
> > >         Peripheral to Central Burst Number: 0
> > >         Central to Peripheral Flush Timeout: 1
> > >         Peripheral to Central Flush Timeout: 1
> > >         Central to Peripheral MTU: 40
> > >         Peripheral to Central MTU: 0
> > >         ISO Interval: 10.00 msec (0x0008)
> > > ...
> > > bluetoothd[349393]: < ISO Data TX: Handle 144 flags 0x02
> > > > HCI Event: Number of Completed Packets (0x13)
> > >         Num handles: 1
> > >         Handle: 144 Address: A0:CD:F3:78:04:0A (Murata Manufacturing =
Co., Ltd.)
> > >         Count: 1
> > >         #470: len 44 (27 Kb/s)
> > >         Latency: 13 msec (13-13 msec ~13 msec)
> > >
> > > The Maximum Latency is correctly set to 10ms in the LE Set Connected =
Isochronous Group Parameters command, and the controller reports the final =
latency as being 1992 us. This is the value that (after conversion to ms) q=
os.ucast.out.latency takes in the current implementation. num is defined as=
 num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval), with inte=
rval being the ISO interval, 10000us and therefore num will be 0 in this ca=
se. As you can see the first packet is always sent, but after that none can=
 be seen. Instead, the Host should send 1 packet every time this function i=
s called. The timer related change below ensures that this function is trig=
gered at every SDU interval. So, in the end, the Host will send 1 packet ev=
ery SDU interval.
> > > > > ---
> > > > >  client/player.c | 34 +++++++++++++++++++++++++++-------
> > > > >  1 file changed, 27 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/client/player.c b/client/player.c
> > > > > index 1f56bfd27..f579d9904 100644
> > > > > --- a/client/player.c
> > > > > +++ b/client/player.c
> > > > > @@ -34,6 +34,7 @@
> > > > >
> > > > >  #include "lib/bluetooth.h"
> > > > >  #include "lib/uuid.h"
> > > > > +#include "lib/iso.h"
> > > > >
> > > > >  #include "profiles/audio/a2dp-codecs.h"
> > > > >  #include "src/shared/lc3.h"
> > > > > @@ -5007,7 +5008,6 @@ static bool transport_timer_read(struct io =
*io,
> > > > void *user_data)
> > > > >         struct bt_iso_qos qos;
> > > > >         socklen_t len;
> > > > >         int ret, fd;
> > > > > -       uint32_t num;
> > > > >         uint64_t exp;
> > > > >
> > > > >         if (transport->fd < 0)
> > > > > @@ -5031,10 +5031,7 @@ static bool transport_timer_read(struct io=
 *io,
> > > > void *user_data)
> > > > >                 return false;
> > > > >         }
> > > > >
> > > > > -       /* num of packets =3D latency (ms) / interval (us) */
> > > > > -       num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.int=
erval);
> > > > > -
> > > > > -       ret =3D transport_send_seq(transport, transport->fd, num)=
;
> > > > > +       ret =3D transport_send_seq(transport, transport->fd, 1);
> > > > >         if (ret < 0) {
> > > > >                 bt_shell_printf("Unable to send: %s (%d)\n",
> > > > >                                         strerror(-ret), ret);
> > > > > @@ -5052,6 +5049,8 @@ static bool transport_timer_read(struct io =
*io,
> > > > void *user_data)
> > > > >  static int transport_send(struct transport *transport, int fd,
> > > > >                                         struct bt_iso_qos *qos)
> > > > >  {
> > > > > +       struct sockaddr_iso addr;
> > > > > +       socklen_t optlen;
> > > > >         struct itimerspec ts;
> > > > >         int timer_fd;
> > > > >
> > > > > @@ -5068,9 +5067,30 @@ static int transport_send(struct transport
> > > > *transport, int fd,
> > > > >                 return -errno;
> > > > >
> > > > >         memset(&ts, 0, sizeof(ts));
> > > > > -       ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> > > > > -       ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 10000=
00;
> > > > >
> > > > > +       /* Need to know if the transport on which data is sent is
> > > > > +        * broadcast or unicast so that the correct qos structure
> > > > > +        * can be accessed. At this point in code there no other
> > > > > +        * way of knowing this besides checking the peer address.
> > > > > +        * Broadcast will use BDADDR_ANY, while Unicast will use
> > > > > +        * the connected peer's actual address.
> > > > > +        */
> > > > > +       memset(&addr, 0, sizeof(addr));
> > > > > +       optlen =3D sizeof(addr);
> > > > > +
> > > > > +       if (getpeername(transport->sk, &addr, &optlen) < 0)
> > > > > +               return -errno;
> > > >
> > > > The description seems to be suggesting there is a rounding error, b=
ut
> > > > the code below only deals with the fact we didn't use proper fields
> > > > for broadcast, so is it really fixing what is the patch description=
 or
> > > > something else?
> > > >
> > > The main change that I made here is the value of the interval for the=
 timer.
> > > Before, it used to be set to qos.ucast.out.latency and I propose to c=
hange
> > > it to qos.ucast.out.interval, so that the Host will send 1SDU packet =
on
> > > every ISO Interval. I included the ucast/bcast qos update since I was
> > > already updating this line of code. That is, I didn't want to send th=
e patch
> > > with "qos->ucast.out.interval" without differentiating between bcast =
and
> > > ucast since it would've been wrong.
> >
> > Hmm if I recall correctly this code used to be sending a packet per
> > interval but we run into problems because the interval is rather short
> > and OS itself would take time to transfer the packet from userspace to
> > socket and then to driver, etc, so I suggest we round up the value if
> > it ends up being 0.
>
> ISO_Interval is not necessarily equal to the SDU_Interval, for unframed
> it may be an integer multiple of it, and for framed I guess it can be
> incommensurate. See Core v5.4 Vol 6 Part G Sec 2.
>
> There might be similar confusion also in the
> MediaTransport.QoS.Interval property, which IIRC for Client is
> SDU_Interval and for Server is ISO_Interval.
>
> ***
>
> The code here probably should not use ISO_Interval for anything, since
> this is Host -> ISOAL data flow.
>
> Instead, IIUC, it should determine SDU_Interval from the codec
> parameters and for LC3 it is the frame duration. Then it should (on
> average) send one SDU per SDU_Interval.
>
> Or, send N*SDU every N*SDU_Interval for some N>=3D1. But since it's using
> timerfd intervals here for the timing, I'm not that sure it is really
> necessary as the average data rate is then maintained even if some
> wakeups are late and the controller flow control should smooth it out.

Well afaik there is no flow control when using unframed, so the
controller will not smooth anything it will just take whatever there
is in its buffers and send each at its own interval, so if we don't
want to risk being late and thus cause no data at each interval we
better pre-load them, which is what we have been doing since the first
set of packets is sent immediately, after establishing the connection,
and then we send at each latency, we could perhaps just send on
POLLOUT though so we use the Number of Complete Packets aka. TX
Complete to control the flow that way we don't have to do any timing
calculations to know when we need to send the next packet, the problem
is that normally POLLOUT is generated when there are socket buffers
not really controller buffers, so afaik we would be buffering a lot
more than expected.

> >
> > > > > +       if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
> > > > > +               /* Interval is measured in us, multiply by 1000 t=
o get ns */
> > > > > +               ts.it_value.tv_nsec =3D qos->bcast.out.interval *=
 1000;
> > > > > +               ts.it_interval.tv_nsec =3D qos->bcast.out.interva=
l * 1000;
> > > > > +       } else {
> > > > > +               /* Interval is measured in us, multiply by 1000 t=
o get ns */
> > > > > +               ts.it_value.tv_nsec =3D qos->ucast.out.interval *=
 1000;
> > > > > +               ts.it_interval.tv_nsec =3D qos->ucast.out.interva=
l * 1000;
> > > > > +
> > > > > +       }
> > > > >         if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NUL=
L) < 0)
> > > > >                 return -errno;
> > > > >
> > > > > --
> > > > > 2.39.2
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
>


--=20
Luiz Augusto von Dentz
