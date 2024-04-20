Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F6219E2
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713616990; cv=pass; b=rEs1hxSuk+8+cHV7GGrO0NOee4xhCefq/jDtO68moqI6YObUya4dRvblHEhJZdjDE8qiXzLYdYWdYNEARdwKlR0kJ7tz+uBaHMhJSYPTD6T7ZQAil9XusWW1+cD3CB3XU/rf76/I73PZup15SPPxxtCXjPblCpXbws825pUicHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713616990; c=relaxed/simple;
	bh=LwFbDNOJiYBys9ph6tDsvwa0A+NRiTJSgekBjCX8M9k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HV0ZPjavrHvuTNLpr97T/S8AsEanylhfGPPYBzq3ol0LCFROmRE8GWYRwNeMBlm6GoUJaLgrcyqP6WNPG2rGuai27N6BI7Asuokprvbr0yKFgl6+zKhSaCc//OmgEiTqxTNYStSTB+Z0mGgM3dRBAAfESCdAvNGwegU67lgH5xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=T5iijE/z; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="T5iijE/z"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VMB4k67Vwz49Q12;
	Sat, 20 Apr 2024 15:43:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1713616984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e038Tz7qoIY0cFWI9Q0Vg0FpMtbO95FDk0lu0u5kApI=;
	b=T5iijE/zsYWWgyf5cglz6UQ75TlaUXR9semukuJ62GBBrOtUUDYFRxsB+0IJA2aAAxsaSn
	srxWwxrX0AjCdKECog+7Xr/jWhoD0LrHqEOC/nFPqCZlUk/AfgadPgIlVOG0Aawg8bFC4k
	YiNVJrgTCnKmBU04E/2k994j4tcjIVof31f5CaMZ1LrY9Dhx2trWIiFO5is66XDuUmdQIu
	TMHq4vkKyHTkzxGOUuRMfUVHbnK1FoWHKHqlxTdItVa0o5qfHWrKaJ4uxKSyYeblgZspVu
	4h4iRBurkdPM4zLDe8vWp8V18dGTau0Xo0zRwpL3kM2Kmbl6oUb/lTpIFPBVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1713616984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e038Tz7qoIY0cFWI9Q0Vg0FpMtbO95FDk0lu0u5kApI=;
	b=dJvw/FlwHHlWkpkFzintsTbduKg3oC5HfI7ZEVNGgBRVMikPN8VOIfAReNO18sM0/rcyY6
	/MiDPrbDLjAzqcu1QZPWz9ngzeiA6wtnW8soaTL3og1omga3vtd/nE2Iicwoh4/P/A3OZO
	n2n+8cEJno7A08XTYUM3m/IgCOJ3UPK0qoO6P/u20S/b2n1kBqrK53rYXP7mGhEhMwWzbt
	Xe7ZSoKpmZh7HfvYLQyOAsamYivvtsbjHtqYvD53XlpoUcMrbcnu6PqR04kROh9ALhvlM4
	6nQoU2MUXAdUxeJUiTGw6Tkfmq0K2rStoBP1C4aABxfzqQ4erlMkSZ1YSINKfw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1713616984; a=rsa-sha256;
	cv=none;
	b=PjjRk1ccjGlVKy5+QRhywRcDR+8fQsFV45LkhtPkm7EKwOJpJa/H8BoixD0sf18j3bXvak
	1WRrxZ87kAvK3yYYN+JAs3sfe2+EzB0Orj0vRjQHWuzLthanfsBwo5SBWH2WIZqx44NwcW
	kFmY13NtHMk8OUv2BHpgYAyPx8oegU+2BWI7B24f6AdQtaTey7qloFTmiothjOp6dJdK57
	CkjPU0sQRCUXL6xuAwfsOr8py0WI60r/8udJBvaiLEOSId+46lwvL2NY0ls2xHwQY0Lh1r
	ZVd5i+AQIzlq75GD67O8bbwTW40Y4BegknKKO913UT0wTUx10WWlsTjHx3hm+Q==
Message-ID: <b356c9360b6491c77b8ae83072d19b8097d1f955.camel@iki.fi>
Subject: Re: [PATCH BlueZ v2 1/1] client/player: Fix transport.send
 command's transfer of packets
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Vlad Pruteanu
	 <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 20 Apr 2024 15:42:58 +0300
In-Reply-To: <CABBYNZ+SLy72-Tc-bDCYWRtin1y9VtQmKS-5vCYsdqDjSEfF8w@mail.gmail.com>
References: <20240419145805.46263-1-vlad.pruteanu@nxp.com>
	 <20240419145805.46263-2-vlad.pruteanu@nxp.com>
	 <CABBYNZKAa5FHSxSByjp1OEFAJS_dTSnOdjEA3PoxcjbtH3aSLw@mail.gmail.com>
	 <CABBYNZ+SLy72-Tc-bDCYWRtin1y9VtQmKS-5vCYsdqDjSEfF8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

pe, 2024-04-19 kello 14:16 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Fri, Apr 19, 2024 at 11:24=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >=20
> > Hi Vlad,
> >=20
> > On Fri, Apr 19, 2024 at 10:58=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@n=
xp.com> wrote:
> > >=20
> > > The transport.send command sends a number num of packets at intervals=
 of
> > > transport latency.
> > >=20
> > > Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interv=
al.
> > >=20
> > > Since this latency could be smaller than the SDU interval, the result=
ing
> > > num could be 0, causing the file transfer to stop after the first pac=
ket.
> > > In this case num will be set to 1 so that at least 1 packet is always=
 sent.
> > >=20
> > > It the transport send timer is set to a value smaller than that of SD=
U
> > > interval, the available buffers for ISO Data will eventually become f=
ull.
> > > Thus, if a packet can't be sent due to resource temporarily being
> > > unavailable decrease the fd offset so that next time the same packet =
will
> > > be sent.
> > >=20
> > > This patch is a temporary fix until the appropriate solution that use=
s
> > > number of completed packets to control the flow of ISO Data packets i=
s
> > > implemented.
> > >=20
> > > Since both Unicast and Broadcast scenarios use the same transport fun=
ctions
> > > differentiate between the 2 cases when accessing the qos structures t=
o get
> > > the transport latency.
> > > ---
> > >  client/player.c | 55 +++++++++++++++++++++++++++++++++++++++++++----=
--
> > >  1 file changed, 49 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/client/player.c b/client/player.c
> > > index 1f56bfd27..ca169e58f 100644
> > > --- a/client/player.c
> > > +++ b/client/player.c
> > > @@ -34,6 +34,7 @@
> > >=20
> > >  #include "lib/bluetooth.h"
> > >  #include "lib/uuid.h"
> > > +#include "lib/iso.h"
> > >=20
> > >  #include "profiles/audio/a2dp-codecs.h"
> > >  #include "src/shared/lc3.h"
> > > @@ -4972,11 +4973,23 @@ static int transport_send_seq(struct transpor=
t *transport, int fd, uint32_t num)
> > >                 }
> > >=20
> > >                 ret =3D send(transport->sk, buf, ret, 0);
> > > +               /* If send failed due to the resource being temporari=
ly
> > > +                * unavailable the controller's ISO data buffers are
> > > +                * full. Try sending the same packet next time.
> > > +                */
> > >                 if (ret <=3D 0) {
> > > -                       bt_shell_printf("send failed: %s (%d)",
> > > +                       if (errno =3D=3D EAGAIN) {
> > > +                               /* Decrease the fd's offset so that t=
he same
> > > +                                * packet is sent next time.
> > > +                                */
> > > +                               offset =3D lseek(fd, -transport->mtu[=
1],
> > > +                                                               SEEK_=
CUR);
> >=20
> > Not really sure why you think this is a good idea, ISO already has
> > retransmission support and if that is failing then there is no reason
> > to retry here, beside this could loop causing the same data to be
> > retried forever.
> >=20
> > > +                       } else {
> > > +                               bt_shell_printf("send failed: %s (%d)=
",
> > >                                                         strerror(errn=
o), errno);
> > > -                       free(buf);
> > > -                       return -errno;
> > > +                               free(buf);
> > > +                               return -errno;
> > > +                       }
> > >                 }
> > >=20
> > >                 elapsed_time(!transport->seq, &secs, &nsecs);
> > > @@ -5033,7 +5046,15 @@ static bool transport_timer_read(struct io *io=
, void *user_data)
> > >=20
> > >         /* num of packets =3D latency (ms) / interval (us) */
> > >         num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interva=
l);
> > > -
> > > +       if (num < 1)
> > > +               /* The latency could be smaller than the interval res=
ulting in
> > > +                * num being 0. If this is the case, set it to 1 so t=
hat packets
> > > +                * will still be sent.
> > > +                */
> > > +               num =3D 1;
> >=20
> > Perhaps we should be looking into rounding closest sort of logic.
> >=20
> > > +       /* TODO: replace this timer based implementation with one tha=
t
> > > +        * uses the number of completed packets reports.
> > > +        */
>=20
> Regarding this TODO item, Im planning to introduce something like the
> following to io.h:
>=20
> +bool io_set_tx_complete_handler(struct io *io, io_tx_complete_func_t cal=
lback,
> +                               int flags, int pool_interval,
> +                               void *user_data, io_destroy_func_t destro=
y);
>=20
> The problem is that if we do schedule new packets on tx_complete
> callback that doesn't account for the time it takes to process such
> event, so over time this will accumulate and at some point we could
> perhaps miss an interval, @Pauli Virtanen or perhaps you are not
> really doing the flow control based on the TX timestamp/complete? That
> perhaps depends if the controller is generating the events as soon as
> the packet is submitted or at the exact moment of the event interval,
> in any case the general idea is that we keep the controller buffers
> full as much as possible to prevent missing intervals.

Pipewire is currently not using the TX timestamps for flow control like
that.

The running min--max range of sendmsg-to-NCP event latency of each CIS
is monitored, and if they are not in sync then packets are dropped to
realign the CIS. Similarly, packets are dropped if latencies become
larger than a defined threshold.

Otherwise, one sendmsg() per CIS is done on every SDU_Interval based on
a timer. This is from rt prio thread, so there's less timing jitter on
our side. Earlier I experimented with explicitly pushing more data to
keep buffers filled but this did not seem to really matter.

One probably could try to do something smarter here, e.g. indeed trying
to use the TX timestamp events to track how many packets are
uncompleted, and then try to keep the number at a constant.

However, I don't see the Core specification saying much about the HCI
ISO flow control. E.g. it's not so clear you can queue SDUs for next
SDU_Intervals if you are not providing time stamps:

BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 6, Part G page 3079

3.3 TIME STAMP FOR SDU
...
When an HCI ISO Data packet sent by the Host does not contain a
Time_Stamp or the Time_Stamp value is not based on the Controller's
clock, the Controller should determine the CIS or BIS event to be used
to transmit the SDU contained in that packet based on the time of
arrival of that packet.
...

>=20
> > >         ret =3D transport_send_seq(transport, transport->fd, num);
> > >         if (ret < 0) {
> > >                 bt_shell_printf("Unable to send: %s (%d)\n",
> > > @@ -5052,6 +5073,8 @@ static bool transport_timer_read(struct io *io,=
 void *user_data)
> > >  static int transport_send(struct transport *transport, int fd,
> > >                                         struct bt_iso_qos *qos)
> > >  {
> > > +       struct sockaddr_iso addr;
> > > +       socklen_t optlen;
> > >         struct itimerspec ts;
> > >         int timer_fd;
> > >=20
> > > @@ -5068,8 +5091,28 @@ static int transport_send(struct transport *tr=
ansport, int fd,
> > >                 return -errno;
> > >=20
> > >         memset(&ts, 0, sizeof(ts));
> > > -       ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> > > -       ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 1000000;
> > > +       /* Need to know if the transport on which data is sent is
> > > +        * broadcast or unicast so that the correct qos structure
> > > +        * can be accessed. At this point in code there's no other
> > > +        * way of knowing this besides checking the peer address.
> > > +        * Broadcast will use BDADDR_ANY, while Unicast will use
> > > +        * the connected peer's actual address.
> > > +        */
> > > +       memset(&addr, 0, sizeof(addr));
> > > +       optlen =3D sizeof(addr);
> > > +
> > > +       if (getpeername(transport->sk, &addr, &optlen) < 0)
> > > +               return -errno;
> > > +
> > > +       if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
> > > +               /* Interval is measured in ms, multiply by 1000000 to=
 get ns */
> > > +               ts.it_value.tv_nsec =3D qos->bcast.out.latency * 1000=
000;
> > > +               ts.it_interval.tv_nsec =3D qos->bcast.out.latency * 1=
000000;
> > > +       } else {
> > > +               /* Interval is measured in ms, multiply by 1000000 to=
 get ns */
> > > +               ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000=
000;
> > > +               ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 1=
000000;
> > > +       }
> >=20
> > This is a different fix, please send it as a separate patch.
> >=20
> > >         if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) <=
 0)
> > >                 return -errno;
> > > --
> > > 2.40.1
> > >=20
> >=20
> >=20
> > --
> > Luiz Augusto von Dentz
>=20
>=20
>=20

--=20
Pauli Virtanen
