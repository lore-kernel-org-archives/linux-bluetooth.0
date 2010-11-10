Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 10 Nov 2010 14:32:56 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 0/2] Fix kernel crash in rfcomm/l2cap
Message-ID: <20101110163256.GE3275@vigoh>
References: <1288780365-32099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1289367396.9615.238.camel@aeonflux>
 <1289402694.23417.2.camel@Nokia-N900>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1289402694.23417.2.camel@Nokia-N900>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2010-11-10 17:24:=
54 +0200]:

> Hi Marcel,
>=20
> > Hi Andrei,
> >=20
> > > Yet another version of patches fixing kernel crash in RFCOMM / L2CAP.
> > > *v4: taken Gustavo comments about timer HZ -> HZ/5
> > >=20
> > > Do not delete l2cap channel and socket sk when sk is owned by user.
> > > To delete l2cap channel standard timer is used.
> > >=20
> > > lock_sock and release_sock do not hold a normal spinlock directly but=
=20
> > > instead hold the owner field. This means bh_lock_sock can still execu=
te
> > > even if the socket is "locked". More info can be found here:
> > > http://www.linuxfoundation.org/collaborate/workgroups/networking/sock=
etlocks
> > >=20
> > > When sending following sequence:
> > > ...
> > > No.=A0 =A0 =A0 =A0  Time=A0 =A0 =A0 =A0 =A0 =A0 =A0  Source=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  Destination=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =20
> > > Protocol Info 89 1.951202=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
 RFCOMM=A0 =A0  Rcvd DISC DLCI=3D20
> > > 90 1.951324=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  RFCOMM=A0 =A0=
  Sent UA DLCI=3D20
> > > 91 1.959381=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  HCI_EVT=A0 =
=A0  Number of Completed Packets
> > > 92 1.966461=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  RFCOMM=A0 =A0=
  Rcvd DISC DLCI=3D0
> > > 93 1.966492=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  L2CAP=A0 =A0 =
=A0  Rcvd Disconnect Request
> > > 94 1.972595=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  L2CAP=A0 =A0 =
=A0  Sent Disconnect Response
> > >=20
> > > ...
> > >=20
> > > krfcommd kernel thread is preempted with l2cap tasklet which remove
> > > l2cap_conn (L2CAP connection handler structure). Then rfcomm thread
> > > tries to send RFCOMM UA which is reply to RFCOMM DISC and when
> > > de-referencing l2cap_conn crash happens.
> >=20
> > so I assume you have tested this extensively with various RFCOMM corner
> > cases like incoming RFCOMM. Since a lot of profiles require proper
> > disconnects and we have to ensure that our reference counting is
> > correct.
>=20
> We have the slightly modified patch applied for a several months. No regr=
ession found.
>=20
> Regards,
> Andrei
>=20
> >=20
> > Other then that it seems fine to me.
> >=20
> > Acked-by: Marcel Holtmann <marcel@holtmann.org>

Applied to bluetooth-next-2,6, thanks.

--=20
Gustavo F. Padovan
http://profusion.mobi
