Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2717FD
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989028; cv=pass; b=XDchNcKXPG4mRWb1NgEMG7H8pM/louqyGTdhgG8JuCRltthJpMFPa7NzDSr5LjRGLKeTCaTsTTdaM7/TCMIXprjvt3+kAUVxJyJp358Y6o1qT5rp+RoqeMzdL8t+2AMqPzsXGOG9zIoyQiA3eKKlRB9YBef/c/DjEVVJgOpEN0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989028; c=relaxed/simple;
	bh=IkTD6/B5YwQ5gBKmxwhonj0+vLAw5mzNSgeFTeG/fKM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G04mOcHuzZyTOdxFN0Ap+TRjMpHOdYGihL07cVjZpxKSMp+9UfQBFJ7lBP7kaooD2KlCidDb4zUdfdOUEhb10jTZ/HidUWd2gEI/+RWO3w1ozTyLCoOrMgwXmNBK+FcwaNPCcnMUyFJyZ/VxtD8NZlpGke77YZxzaFOSCkt8JDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=j/QvrTz4; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="j/QvrTz4"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V7c1n2PRgz49PxK;
	Mon,  1 Apr 2024 19:30:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1711989022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1qedxLuNU9hIORGoi7iH1+Ci7C79av6/nqk3/EE55g=;
	b=j/QvrTz4RteclDNTMludj/zxJQyivhuYssuagzx/goOFH3mGJbVIsOi8xXqpqOEkF4Rx+F
	+Lm3QX33weLQOENuPX/23mWrqTyqZnbvsQs/Cg83xIyuCLqiJ+JIkftUhx6ARUFn7MfUzM
	3prACKrgvsYJ0p1XA86tarxaJBMrvlew3jS/OR+ivRFxP8479fhzHlm4q5BdJC/7GTRgVe
	thgFpIAy6ZN5ylcvjIYWiwzjZqkw39XiACgeuYpRaDrKLSra4ukio2BdPHSvkTN08zix6i
	15LcrCzpDQP+FvynM2SvQEt97o3Jp7rmjB2VPb0gE+YBXf/w/w2K4dVSzxDioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1711989022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1qedxLuNU9hIORGoi7iH1+Ci7C79av6/nqk3/EE55g=;
	b=UXZqLu1FJpzMia/itEoybt8ZfcmtsLFSZBMf+fPzE1CsHKYUvz9vUeTqGPxMONVMivvTyl
	FVkfXLLs+lD9zQMPtT4E4gNrnZq/17Czx8ReOj6vD3Eay4XDHIScmvCSgrUsQ+FrKUdJ/D
	hmlBlyn1ufFArbx1huisk3ObrY7WRbo/GWzktgjXflXI3lXvNrXeqyssjWiHudz8rS98Kg
	X7cdabD2JxyC5sG5oGdDFgP+yDVeIsJj4M54YIAxsNdHrZIbpKniSu4l94pbF3xABl1BKC
	UQCJKIgSxN0aZUzm7EpL6jXqJaxNHG3YvHFwPxN93FxhHUiWaGyDbwkznqHHnQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1711989022; a=rsa-sha256;
	cv=none;
	b=gZfL8DB4NqH3sgHRwzTCVa16OwJEfVAMdFL2E3tyIZDf9I/TvLYdhfC2GtWcz64HZTzmHK
	dqZU7rdKuvhgyVTpyaLlmWqJGCB9sj7SF4MZ4K8bBL/Df2e6EWjJweXwus7kfFtBSkbEWR
	qO+QLc8+8BZ3/1jef/3YyAaZKbhA1sDyc3ehnq+YXOVd79Km1FEX8FsShPRRPHjs5OwGMe
	iP3IZYBKTedzA7KEKqhEEB3SYqW8fBfwZPTa40u6sA2rvxyaMVNDQcU2e+6zTU/4FBaBJo
	7JyWQ2sbBtkEzgy0XHSNWZHylJnUq+EMBYbIAKmdS5osFArcpzYYPotQG1zzcA==
Message-ID: <9087dd8906dd8fc26e610f03ecc755790c0c6439.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/1] client/player: Fix transport.send command's
 transfer of packets
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vlad Pruteanu <vlad.pruteanu@nxp.com>, "linux-bluetooth@vger.kernel.org"
	 <linux-bluetooth@vger.kernel.org>
Date: Mon, 01 Apr 2024 19:30:19 +0300
In-Reply-To: <CABBYNZKj6FS6K8-YMu=3mBpw+M-How6LXBW5+=iUHT2X=Ls++Q@mail.gmail.com>
References: <20240325144031.335354-1-vlad.pruteanu@nxp.com>
	 <20240325144031.335354-2-vlad.pruteanu@nxp.com>
	 <CABBYNZLHb3dRVQ5KxNCorOp2cJWjAwknCU9--19UScFgfMJ7bA@mail.gmail.com>
	 <VI1PR04MB5389EC60FC16B07F986D9003FE352@VI1PR04MB5389.eurprd04.prod.outlook.com>
	 <CABBYNZJpgBEPRmLQ4vxLzE9DkwPDzLEN+xBiwU5QrF974-A9JQ@mail.gmail.com>
	 <ebd75f6a431bdd62021cb34f7bd6009c15772709.camel@iki.fi>
	 <CABBYNZKj6FS6K8-YMu=3mBpw+M-How6LXBW5+=iUHT2X=Ls++Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2024-04-01 kello 12:00 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Mon, Apr 1, 2024 at 11:05=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Hi,
> >=20
> > ti, 2024-03-26 kello 11:33 -0400, Luiz Augusto von Dentz kirjoitti:
> > > Hi Vlad,
> > >=20
> > > On Tue, Mar 26, 2024 at 11:21=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu=
@nxp.com> wrote:
> > > >=20
> > > > Hello Luiz,
> > > >=20
> > > >=20
> > > > > -----Original Message-----
> > > > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > > Sent: Monday, March 25, 2024 6:04 PM
> > > > > To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
> > > > > Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai=
-
> > > > > octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> > > > > <silviu.barbulescu@nxp.com>; Iulia Tanasescu <iulia.tanasescu@nxp=
.com>;
> > > > > Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > > > > Subject: [EXT] Re: [PATCH BlueZ 1/1] client/player: Fix transport=
.send
> > > > > command's transfer of packets
> > > > >=20
> > > > > Caution: This is an external email. Please take care when clickin=
g links or
> > > > > opening attachments. When in doubt, report the message using the =
'Report
> > > > > this email' button
> > > > >=20
> > > > >=20
> > > > > Hi Vlad,
> > > > >=20
> > > > > On Mon, Mar 25, 2024 at 10:40=E2=80=AFAM Vlad Pruteanu
> > > > > <vlad.pruteanu@nxp.com> wrote:
> > > > > >=20
> > > > > > The transport.send command sends a number num of packets at int=
ervals
> > > > > > specified by the transport latency reported by the CIS Establsi=
hed event.
> > > > > > Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.=
interval.
> > > > > > Since this latency could be smaller than the SDU interval for s=
ome presets,
> > > > > > the resulting num would be 0, causing the file transfer to stop=
 after the
> > > > > > first packet. Instead, one packet should be sent at SDU interva=
l distance
> > > > > > apart.
> > > > >=20
> > > > > Please add some output samples showing the wrong interval ends up=
 being
> > > > > used.
> > > > >=20
> > > > Below you can find what I consider to a relevant excerpt taken from=
 btmon log:
> > > > ...
> > > > < HCI Command: LE Set Connected Isochronous Group Parameters (0x08|=
0x0062)
> > > >         CIG ID: 0x00
> > > >         Central to Peripheral SDU Interval: 10000 us (0x002710)
> > > >         Peripheral to Central SDU Interval: 10000 us (0x002710)
> > > >         SCA: 201 - 500 ppm (0x00)
> > > >         Packing: Sequential (0x00)
> > > >         Framing: Unframed (0x00)
> > > >         Central to Peripheral Maximum Latency: 10 ms (0x000a)
> > > >         Peripheral to Central Maximum Latency: 10 ms (0x000a)
> > > >         Number of CIS: 1
> > > >         CIS ID: 0x00
> > > >         Central to Peripheral Maximum SDU Size: 40
> > > >         Peripheral to Central Maximum SDU Size: 0
> > > >         Central to Peripheral PHY: LE 2M (0x02)
> > > >         Peripheral to Central PHY: LE 2M (0x02)
> > > >         Central to Peripheral Retransmission attempts: 0x02
> > > >         Peripheral to Central Retransmission attempts: 0x00
> > > > ...
> > > > > HCI Event: Command Complete (0x0e)
> > > >       LE Set Connected Isochronous Group Parameters (0x08|0x0062) n=
cmd 1
> > > >         Status: Success (0x00)
> > > >         CIG ID: 0x00
> > > >         Number of Handles: 1
> > > >         Connection Handle #0: 144
> > > > ...
> > > > < HCI Command: LE Create Connected Isochronous Stream (0x08|0x0064)
> > > >         Number of CIS: 1
> > > >         CIS Handle: 144
> > > >         ACL Handle: 128
> > > > ...
> > > > > HCI Event: LE Meta Event (0x3e)
> > > >       LE Connected Isochronous Stream Established (0x19)
> > > >         Status: Success (0x00)
> > > >         Connection Handle: 144
> > > >         CIG Synchronization Delay: 1992 us (0x0007c8)
> > > >         CIS Synchronization Delay: 1992 us (0x0007c8)
> > > >         Central to Peripheral Latency: 1992 us (0x0007c8)
> > > >         Peripheral to Central Latency: 1992 us (0x0007c8)
> > > >         Central to Peripheral PHY: LE 2M (0x02)
> > > >         Peripheral to Central PHY: LE 2M (0x02)
> > > >         Number of Subevents: 3
> > > >         Central to Peripheral Burst Number: 1
> > > >         Peripheral to Central Burst Number: 0
> > > >         Central to Peripheral Flush Timeout: 1
> > > >         Peripheral to Central Flush Timeout: 1
> > > >         Central to Peripheral MTU: 40
> > > >         Peripheral to Central MTU: 0
> > > >         ISO Interval: 10.00 msec (0x0008)
> > > > ...
> > > > bluetoothd[349393]: < ISO Data TX: Handle 144 flags 0x02
> > > > > HCI Event: Number of Completed Packets (0x13)
> > > >         Num handles: 1
> > > >         Handle: 144 Address: A0:CD:F3:78:04:0A (Murata Manufacturin=
g Co., Ltd.)
> > > >         Count: 1
> > > >         #470: len 44 (27 Kb/s)
> > > >         Latency: 13 msec (13-13 msec ~13 msec)
> > > >=20
> > > > The Maximum Latency is correctly set to 10ms in the LE Set Connecte=
d Isochronous Group Parameters command, and the controller reports the fina=
l latency as being 1992 us. This is the value that (after conversion to ms)=
 qos.ucast.out.latency takes in the current implementation. num is defined =
as num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval), with in=
terval being the ISO interval, 10000us and therefore num will be 0 in this =
case. As you can see the first packet is always sent, but after that none c=
an be seen. Instead, the Host should send 1 packet every time this function=
 is called. The timer related change below ensures that this function is tr=
iggered at every SDU interval. So, in the end, the Host will send 1 packet =
every SDU interval.
> > > > > > ---
> > > > > >  client/player.c | 34 +++++++++++++++++++++++++++-------
> > > > > >  1 file changed, 27 insertions(+), 7 deletions(-)
> > > > > >=20
> > > > > > diff --git a/client/player.c b/client/player.c
> > > > > > index 1f56bfd27..f579d9904 100644
> > > > > > --- a/client/player.c
> > > > > > +++ b/client/player.c
> > > > > > @@ -34,6 +34,7 @@
> > > > > >=20
> > > > > >  #include "lib/bluetooth.h"
> > > > > >  #include "lib/uuid.h"
> > > > > > +#include "lib/iso.h"
> > > > > >=20
> > > > > >  #include "profiles/audio/a2dp-codecs.h"
> > > > > >  #include "src/shared/lc3.h"
> > > > > > @@ -5007,7 +5008,6 @@ static bool transport_timer_read(struct i=
o *io,
> > > > > void *user_data)
> > > > > >         struct bt_iso_qos qos;
> > > > > >         socklen_t len;
> > > > > >         int ret, fd;
> > > > > > -       uint32_t num;
> > > > > >         uint64_t exp;
> > > > > >=20
> > > > > >         if (transport->fd < 0)
> > > > > > @@ -5031,10 +5031,7 @@ static bool transport_timer_read(struct =
io *io,
> > > > > void *user_data)
> > > > > >                 return false;
> > > > > >         }
> > > > > >=20
> > > > > > -       /* num of packets =3D latency (ms) / interval (us) */
> > > > > > -       num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.i=
nterval);
> > > > > > -
> > > > > > -       ret =3D transport_send_seq(transport, transport->fd, nu=
m);
> > > > > > +       ret =3D transport_send_seq(transport, transport->fd, 1)=
;
> > > > > >         if (ret < 0) {
> > > > > >                 bt_shell_printf("Unable to send: %s (%d)\n",
> > > > > >                                         strerror(-ret), ret);
> > > > > > @@ -5052,6 +5049,8 @@ static bool transport_timer_read(struct i=
o *io,
> > > > > void *user_data)
> > > > > >  static int transport_send(struct transport *transport, int fd,
> > > > > >                                         struct bt_iso_qos *qos)
> > > > > >  {
> > > > > > +       struct sockaddr_iso addr;
> > > > > > +       socklen_t optlen;
> > > > > >         struct itimerspec ts;
> > > > > >         int timer_fd;
> > > > > >=20
> > > > > > @@ -5068,9 +5067,30 @@ static int transport_send(struct transpo=
rt
> > > > > *transport, int fd,
> > > > > >                 return -errno;
> > > > > >=20
> > > > > >         memset(&ts, 0, sizeof(ts));
> > > > > > -       ts.it_value.tv_nsec =3D qos->ucast.out.latency * 100000=
0;
> > > > > > -       ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 100=
0000;
> > > > > >=20
> > > > > > +       /* Need to know if the transport on which data is sent =
is
> > > > > > +        * broadcast or unicast so that the correct qos structu=
re
> > > > > > +        * can be accessed. At this point in code there no othe=
r
> > > > > > +        * way of knowing this besides checking the peer addres=
s.
> > > > > > +        * Broadcast will use BDADDR_ANY, while Unicast will us=
e
> > > > > > +        * the connected peer's actual address.
> > > > > > +        */
> > > > > > +       memset(&addr, 0, sizeof(addr));
> > > > > > +       optlen =3D sizeof(addr);
> > > > > > +
> > > > > > +       if (getpeername(transport->sk, &addr, &optlen) < 0)
> > > > > > +               return -errno;
> > > > >=20
> > > > > The description seems to be suggesting there is a rounding error,=
 but
> > > > > the code below only deals with the fact we didn't use proper fiel=
ds
> > > > > for broadcast, so is it really fixing what is the patch descripti=
on or
> > > > > something else?
> > > > >=20
> > > > The main change that I made here is the value of the interval for t=
he timer.
> > > > Before, it used to be set to qos.ucast.out.latency and I propose to=
 change
> > > > it to qos.ucast.out.interval, so that the Host will send 1SDU packe=
t on
> > > > every ISO Interval. I included the ucast/bcast qos update since I w=
as
> > > > already updating this line of code. That is, I didn't want to send =
the patch
> > > > with "qos->ucast.out.interval" without differentiating between bcas=
t and
> > > > ucast since it would've been wrong.
> > >=20
> > > Hmm if I recall correctly this code used to be sending a packet per
> > > interval but we run into problems because the interval is rather shor=
t
> > > and OS itself would take time to transfer the packet from userspace t=
o
> > > socket and then to driver, etc, so I suggest we round up the value if
> > > it ends up being 0.
> >=20
> > ISO_Interval is not necessarily equal to the SDU_Interval, for unframed
> > it may be an integer multiple of it, and for framed I guess it can be
> > incommensurate. See Core v5.4 Vol 6 Part G Sec 2.
> >=20
> > There might be similar confusion also in the
> > MediaTransport.QoS.Interval property, which IIRC for Client is
> > SDU_Interval and for Server is ISO_Interval.
> >=20
> > ***
> >=20
> > The code here probably should not use ISO_Interval for anything, since
> > this is Host -> ISOAL data flow.
> >=20
> > Instead, IIUC, it should determine SDU_Interval from the codec
> > parameters and for LC3 it is the frame duration. Then it should (on
> > average) send one SDU per SDU_Interval.
> >=20
> > Or, send N*SDU every N*SDU_Interval for some N>=3D1. But since it's usi=
ng
> > timerfd intervals here for the timing, I'm not that sure it is really
> > necessary as the average data rate is then maintained even if some
> > wakeups are late and the controller flow control should smooth it out.
>=20
> Well afaik there is no flow control when using unframed, so the
> controller will not smooth anything it will just take whatever there
> is in its buffers and send each at its own interval, so if we don't
> want to risk being late and thus cause no data at each interval we
> better pre-load them, which is what we have been doing since the first
> set of packets is sent immediately, after establishing the connection,
> and then we send at each latency, we could perhaps just send on
> POLLOUT though so we use the Number of Complete Packets aka. TX
> Complete to control the flow that way we don't have to do any timing
> calculations to know when we need to send the next packet, the problem
> is that normally POLLOUT is generated when there are socket buffers
> not really controller buffers, so afaik we would be buffering a lot
> more than expected.

So the flow control behavior observed is that if a packet is late,
controller does not drop it but uses it for the next interval. Each
miss then increases the latency until you reach a value where it's
larger than your userspace jitter, and you no longer should run out.

I don't see sending N*SDU each N*SDU_Interval=C2=A0changing this: after
N*SDU_Interval you are in a situation where socket/controller queue is
again empty, and late wakeup causes a miss.

To preload, I think you'd need to send M > N packets on the first timer
round, and then you'd have M-N packets of latency buffer in the queues.

>=20
> > >=20
> > > > > > +       if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
> > > > > > +               /* Interval is measured in us, multiply by 1000=
 to get ns */
> > > > > > +               ts.it_value.tv_nsec =3D qos->bcast.out.interval=
 * 1000;
> > > > > > +               ts.it_interval.tv_nsec =3D qos->bcast.out.inter=
val * 1000;
> > > > > > +       } else {
> > > > > > +               /* Interval is measured in us, multiply by 1000=
 to get ns */
> > > > > > +               ts.it_value.tv_nsec =3D qos->ucast.out.interval=
 * 1000;
> > > > > > +               ts.it_interval.tv_nsec =3D qos->ucast.out.inter=
val * 1000;
> > > > > > +
> > > > > > +       }
> > > > > >         if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, N=
ULL) < 0)
> > > > > >                 return -errno;
> > > > > >=20
> > > > > > --
> > > > > > 2.39.2
> > > > > >=20
> > > > >=20
> > > > >=20
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >=20
> > >=20
> > >=20
> >=20
>=20
>=20

