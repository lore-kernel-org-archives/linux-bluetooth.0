Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38A446A1
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984386; cv=pass; b=eRpCCyvwfAT4xrrp+FeKbVUsumUY9tmRTFDaP36qf9Qcw2UuaRpXKbS6Y/VPQJuxkiKT8GgObyjzzqQM87XK6bjqKtnL1/rYpulhI4D2Sy4iiQtSwkWrYm1Z1JM/HuoeYtH+eGVgx4ovYnvE2COccFsiu++Ld9Hbyf+iaOa48Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984386; c=relaxed/simple;
	bh=ysQLyyvx8jN6ygG3UzhZA+FNet+1/ZmdWfagJbPkwDs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRR/XzVtLddDXgb0UhgfHL4TWoXeWUI/UPJzeFpN7ZlfYMEjGcr5mFZwLmFfW8BhLIzJhmrJOTgXJ02u+43jXpGTfjjl87iv4SRJiVHAM01WpVoHz/JX9Qrn1aUfuhRLtsFBDG4uru7Fgq/FN/OqWD6tw621QAZBcQHZxwG0XHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Zq3SuYP9; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Zq3SuYP9"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V7Z8272y8z49Q4J;
	Mon,  1 Apr 2024 18:05:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1711983939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1VHvq5N08xK9o9vFxvWyALOyBVoikxYd0jFWezt7Pvg=;
	b=Zq3SuYP95MCVtZZhoXc3Ij0QOnJBuoP4aL7UpZO89JWDoJEE6jOaYaaU2CYNGHqveeyJdt
	6H8BbgBAY8DOas1r3GcmSLyBFJjyQr1/Vt1YsbHNIBHbXJQwS7Bg77pHIk4hy6vpwphVBG
	VAOG36auKj+/cNI4vu1RRmPvK3grTtuqaXb56FY8HLu630zFh/PwNUwg7Heq8OIAJt8Q8J
	2otYE3nZYj9XEOXVIH3+Ur09w99kP+co9VPxT4eEvJs1+KKVlKtjrTotkEbpr5YiCevSNf
	zaemercK1EJe70g9Icj+lzBXull9tRzgTNgO6MbvmuxdEHP5UAfbWfj1IFfXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1711983939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1VHvq5N08xK9o9vFxvWyALOyBVoikxYd0jFWezt7Pvg=;
	b=cL/k3oAZrGyUBasyJmBeuvYKllt0UZWbvNN4p+ReWlpQXF3sGHTyLO/4a9AFYeUqz+qfbG
	ViGjJqT3bB+u/XVSSbKJ38KLArropne4KTuU0NU7TTI13lNt2t3I/C44DTdG8ktLuTttRn
	2zE1kh0hhKv8i9KomZ6B42DjjcdnjbHF0bACSj7la0BOmHTob2CmGs61VCvDW3WhQh4SUp
	L4Yql4OPgDSQxaxuNWSKq1bvP/bcR8wzYEgRzPiEoRqc/WcNYY2ySDYfW6jfBTLflBAa46
	W9aoNsOvUFQMzs5SJHg2W7XpXEw3thqQeZugilv27IqVXTJPAOprcuHkmdaPrA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1711983939; a=rsa-sha256;
	cv=none;
	b=mhRPELIX4DvIcBRglIwRaUOi5z7hi/sx6biz8YBGxncxKBPxX5+brXBM9PMIbEqteBWNKD
	3diw08a/frLVd7BspzzovYXLxj+XClxuIKuGTBOIeiEzBEo5tWg0U7h/rZzVdkCP6e4w+4
	wytfMkn6AJBaU4iLXGff+iu3p2p3wMA1bn0wQvZiRoMlEQtxu7NBTepz/gweufnAs5kuk7
	OF21uK53XYwGuwIDTE7AiV5K9MnnOoHjPzaCTjmzav6VZiRN+vl6YdMw4pyz76YHp5DvDf
	ExbHEMrc9nelMFlkI+S/cB1+LI99aRst69dZXrELNg/9gDHqXeSadjytjHgSCg==
Message-ID: <ebd75f6a431bdd62021cb34f7bd6009c15772709.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/1] client/player: Fix transport.send command's
 transfer of packets
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Vlad Pruteanu
	 <vlad.pruteanu@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 01 Apr 2024 18:05:36 +0300
In-Reply-To: <CABBYNZJpgBEPRmLQ4vxLzE9DkwPDzLEN+xBiwU5QrF974-A9JQ@mail.gmail.com>
References: <20240325144031.335354-1-vlad.pruteanu@nxp.com>
	 <20240325144031.335354-2-vlad.pruteanu@nxp.com>
	 <CABBYNZLHb3dRVQ5KxNCorOp2cJWjAwknCU9--19UScFgfMJ7bA@mail.gmail.com>
	 <VI1PR04MB5389EC60FC16B07F986D9003FE352@VI1PR04MB5389.eurprd04.prod.outlook.com>
	 <CABBYNZJpgBEPRmLQ4vxLzE9DkwPDzLEN+xBiwU5QrF974-A9JQ@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
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

ti, 2024-03-26 kello 11:33 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Vlad,
>=20
> On Tue, Mar 26, 2024 at 11:21=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp=
.com> wrote:
> >=20
> > Hello Luiz,
> >=20
> >=20
> > > -----Original Message-----
> > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > Sent: Monday, March 25, 2024 6:04 PM
> > > To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
> > > Cc: linux-bluetooth@vger.kernel.org; Mihai-Octavian Urzica <mihai-
> > > octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> > > <silviu.barbulescu@nxp.com>; Iulia Tanasescu <iulia.tanasescu@nxp.com=
>;
> > > Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > > Subject: [EXT] Re: [PATCH BlueZ 1/1] client/player: Fix transport.sen=
d
> > > command's transfer of packets
> > >=20
> > > Caution: This is an external email. Please take care when clicking li=
nks or
> > > opening attachments. When in doubt, report the message using the 'Rep=
ort
> > > this email' button
> > >=20
> > >=20
> > > Hi Vlad,
> > >=20
> > > On Mon, Mar 25, 2024 at 10:40=E2=80=AFAM Vlad Pruteanu
> > > <vlad.pruteanu@nxp.com> wrote:
> > > >=20
> > > > The transport.send command sends a number num of packets at interva=
ls
> > > > specified by the transport latency reported by the CIS Establsihed =
event.
> > > > Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.inte=
rval.
> > > > Since this latency could be smaller than the SDU interval for some =
presets,
> > > > the resulting num would be 0, causing the file transfer to stop aft=
er the
> > > > first packet. Instead, one packet should be sent at SDU interval di=
stance
> > > > apart.
> > >=20
> > > Please add some output samples showing the wrong interval ends up bei=
ng
> > > used.
> > >=20
> > Below you can find what I consider to a relevant excerpt taken from btm=
on log:
> > ...
> > < HCI Command: LE Set Connected Isochronous Group Parameters (0x08|0x00=
62)
> >         CIG ID: 0x00
> >         Central to Peripheral SDU Interval: 10000 us (0x002710)
> >         Peripheral to Central SDU Interval: 10000 us (0x002710)
> >         SCA: 201 - 500 ppm (0x00)
> >         Packing: Sequential (0x00)
> >         Framing: Unframed (0x00)
> >         Central to Peripheral Maximum Latency: 10 ms (0x000a)
> >         Peripheral to Central Maximum Latency: 10 ms (0x000a)
> >         Number of CIS: 1
> >         CIS ID: 0x00
> >         Central to Peripheral Maximum SDU Size: 40
> >         Peripheral to Central Maximum SDU Size: 0
> >         Central to Peripheral PHY: LE 2M (0x02)
> >         Peripheral to Central PHY: LE 2M (0x02)
> >         Central to Peripheral Retransmission attempts: 0x02
> >         Peripheral to Central Retransmission attempts: 0x00
> > ...
> > > HCI Event: Command Complete (0x0e)
> >       LE Set Connected Isochronous Group Parameters (0x08|0x0062) ncmd =
1
> >         Status: Success (0x00)
> >         CIG ID: 0x00
> >         Number of Handles: 1
> >         Connection Handle #0: 144
> > ...
> > < HCI Command: LE Create Connected Isochronous Stream (0x08|0x0064)
> >         Number of CIS: 1
> >         CIS Handle: 144
> >         ACL Handle: 128
> > ...
> > > HCI Event: LE Meta Event (0x3e)
> >       LE Connected Isochronous Stream Established (0x19)
> >         Status: Success (0x00)
> >         Connection Handle: 144
> >         CIG Synchronization Delay: 1992 us (0x0007c8)
> >         CIS Synchronization Delay: 1992 us (0x0007c8)
> >         Central to Peripheral Latency: 1992 us (0x0007c8)
> >         Peripheral to Central Latency: 1992 us (0x0007c8)
> >         Central to Peripheral PHY: LE 2M (0x02)
> >         Peripheral to Central PHY: LE 2M (0x02)
> >         Number of Subevents: 3
> >         Central to Peripheral Burst Number: 1
> >         Peripheral to Central Burst Number: 0
> >         Central to Peripheral Flush Timeout: 1
> >         Peripheral to Central Flush Timeout: 1
> >         Central to Peripheral MTU: 40
> >         Peripheral to Central MTU: 0
> >         ISO Interval: 10.00 msec (0x0008)
> > ...
> > bluetoothd[349393]: < ISO Data TX: Handle 144 flags 0x02
> > > HCI Event: Number of Completed Packets (0x13)
> >         Num handles: 1
> >         Handle: 144 Address: A0:CD:F3:78:04:0A (Murata Manufacturing Co=
., Ltd.)
> >         Count: 1
> >         #470: len 44 (27 Kb/s)
> >         Latency: 13 msec (13-13 msec ~13 msec)
> >=20
> > The Maximum Latency is correctly set to 10ms in the LE Set Connected Is=
ochronous Group Parameters command, and the controller reports the final la=
tency as being 1992 us. This is the value that (after conversion to ms) qos=
.ucast.out.latency takes in the current implementation. num is defined as n=
um =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval), with interv=
al being the ISO interval, 10000us and therefore num will be 0 in this case=
. As you can see the first packet is always sent, but after that none can b=
e seen. Instead, the Host should send 1 packet every time this function is =
called. The timer related change below ensures that this function is trigge=
red at every SDU interval. So, in the end, the Host will send 1 packet ever=
y SDU interval.
> > > > ---
> > > >  client/player.c | 34 +++++++++++++++++++++++++++-------
> > > >  1 file changed, 27 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/client/player.c b/client/player.c
> > > > index 1f56bfd27..f579d9904 100644
> > > > --- a/client/player.c
> > > > +++ b/client/player.c
> > > > @@ -34,6 +34,7 @@
> > > >=20
> > > >  #include "lib/bluetooth.h"
> > > >  #include "lib/uuid.h"
> > > > +#include "lib/iso.h"
> > > >=20
> > > >  #include "profiles/audio/a2dp-codecs.h"
> > > >  #include "src/shared/lc3.h"
> > > > @@ -5007,7 +5008,6 @@ static bool transport_timer_read(struct io *i=
o,
> > > void *user_data)
> > > >         struct bt_iso_qos qos;
> > > >         socklen_t len;
> > > >         int ret, fd;
> > > > -       uint32_t num;
> > > >         uint64_t exp;
> > > >=20
> > > >         if (transport->fd < 0)
> > > > @@ -5031,10 +5031,7 @@ static bool transport_timer_read(struct io *=
io,
> > > void *user_data)
> > > >                 return false;
> > > >         }
> > > >=20
> > > > -       /* num of packets =3D latency (ms) / interval (us) */
> > > > -       num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.inter=
val);
> > > > -
> > > > -       ret =3D transport_send_seq(transport, transport->fd, num);
> > > > +       ret =3D transport_send_seq(transport, transport->fd, 1);
> > > >         if (ret < 0) {
> > > >                 bt_shell_printf("Unable to send: %s (%d)\n",
> > > >                                         strerror(-ret), ret);
> > > > @@ -5052,6 +5049,8 @@ static bool transport_timer_read(struct io *i=
o,
> > > void *user_data)
> > > >  static int transport_send(struct transport *transport, int fd,
> > > >                                         struct bt_iso_qos *qos)
> > > >  {
> > > > +       struct sockaddr_iso addr;
> > > > +       socklen_t optlen;
> > > >         struct itimerspec ts;
> > > >         int timer_fd;
> > > >=20
> > > > @@ -5068,9 +5067,30 @@ static int transport_send(struct transport
> > > *transport, int fd,
> > > >                 return -errno;
> > > >=20
> > > >         memset(&ts, 0, sizeof(ts));
> > > > -       ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000;
> > > > -       ts.it_interval.tv_nsec =3D qos->ucast.out.latency * 1000000=
;
> > > >=20
> > > > +       /* Need to know if the transport on which data is sent is
> > > > +        * broadcast or unicast so that the correct qos structure
> > > > +        * can be accessed. At this point in code there no other
> > > > +        * way of knowing this besides checking the peer address.
> > > > +        * Broadcast will use BDADDR_ANY, while Unicast will use
> > > > +        * the connected peer's actual address.
> > > > +        */
> > > > +       memset(&addr, 0, sizeof(addr));
> > > > +       optlen =3D sizeof(addr);
> > > > +
> > > > +       if (getpeername(transport->sk, &addr, &optlen) < 0)
> > > > +               return -errno;
> > >=20
> > > The description seems to be suggesting there is a rounding error, but
> > > the code below only deals with the fact we didn't use proper fields
> > > for broadcast, so is it really fixing what is the patch description o=
r
> > > something else?
> > >=20
> > The main change that I made here is the value of the interval for the t=
imer.
> > Before, it used to be set to qos.ucast.out.latency and I propose to cha=
nge
> > it to qos.ucast.out.interval, so that the Host will send 1SDU packet on
> > every ISO Interval. I included the ucast/bcast qos update since I was
> > already updating this line of code. That is, I didn't want to send the =
patch
> > with "qos->ucast.out.interval" without differentiating between bcast an=
d
> > ucast since it would've been wrong.
>=20
> Hmm if I recall correctly this code used to be sending a packet per
> interval but we run into problems because the interval is rather short
> and OS itself would take time to transfer the packet from userspace to
> socket and then to driver, etc, so I suggest we round up the value if
> it ends up being 0.

ISO_Interval is not necessarily equal to the SDU_Interval, for unframed
it may be an integer multiple of it, and for framed I guess it can be
incommensurate. See Core v5.4 Vol 6 Part G Sec 2.

There might be similar confusion also in the
MediaTransport.QoS.Interval property, which IIRC for Client is
SDU_Interval and for Server is ISO_Interval.

***

The code here probably should not use ISO_Interval for anything, since
this is Host -> ISOAL data flow.

Instead, IIUC, it should determine SDU_Interval from the codec
parameters and for LC3 it is the frame duration. Then it should (on
average) send one SDU per SDU_Interval.

Or, send N*SDU every N*SDU_Interval for some N>=3D1. But since it's using
timerfd intervals here for the timing, I'm not that sure it is really
necessary as the average data rate is then maintained even if some
wakeups are late and the controller flow control should smooth it out.

>=20
> > > > +       if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
> > > > +               /* Interval is measured in us, multiply by 1000 to =
get ns */
> > > > +               ts.it_value.tv_nsec =3D qos->bcast.out.interval * 1=
000;
> > > > +               ts.it_interval.tv_nsec =3D qos->bcast.out.interval =
* 1000;
> > > > +       } else {
> > > > +               /* Interval is measured in us, multiply by 1000 to =
get ns */
> > > > +               ts.it_value.tv_nsec =3D qos->ucast.out.interval * 1=
000;
> > > > +               ts.it_interval.tv_nsec =3D qos->ucast.out.interval =
* 1000;
> > > > +
> > > > +       }
> > > >         if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL)=
 < 0)
> > > >                 return -errno;
> > > >=20
> > > > --
> > > > 2.39.2
> > > >=20
> > >=20
> > >=20
> > > --
> > > Luiz Augusto von Dentz
>=20
>=20
>=20

