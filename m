Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Message-ID: <000001c31b28$8d98f7c0$1a01010a@baked>
MIME-Version: 1.0
In-Reply-To: <000801c3197e$8591e290$1a01010a@baked>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 May 2003 14:25:27 -0700
Content-Type: text/plain; CHARSET=us-ascii

Max,

Regarding the L2CAP parameter negotiation.  Not sure if you saw this (see
below).

This is the one remaining problem impeding qualification. Except, of course=
,
for the possibility of more failures in the next round of testing.

What are your thoughts on it?

Thanks,

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> Daryl Van Vorst
> Sent: May 13, 2003 11:36 AM
> To: 'Max Krasnyansky'; 'Marcel Holtmann'
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Qualification Testing
>=20
>=20
> Max,
>=20
> > >Max - You mentioned that the spec says that what the stack
> > does with a
> > >config reject can be implementation specific. I just had a
> > look at the
> > >spec and couldn't find it. Could you tell me where to look
> > in the spec?
> >=20
> > section 6.1
> > page 297
> >=20
> > "Since all L2CAP implementations are capable to support a
> > minimum L2CAP packet size, see Section 4 on page 280, MTU is=20
> > not really a negotiated value but rather an informational=20
> > parameter to the remote device that the local device can=20
> > accommodate in this channel an MTU larger than the minimum=20
> > required. In the unlikely case that the remote device is only=20
> > willing to send L2CAP packets in this channel that are larger=20
> > than the MTU announced by the local device, then this=20
> > Configuration Request will receive a negative response in=20
> > which the remote device will include the value of MTU that is=20
> > indented to transmit. In this case, it is implementation=20
> > specific on whether the local device will continue the=20
> > configuration process or even maintain this channel."
>=20
> What about flowspec and flush timeout?
>=20
> In section 6.4.2 FlushTO is listed as one of the items in the=20
> response path (along with MTU and InFlow). But in section 7.5=20
> only MTU and InFlow are listed.
>=20
> I sent the above quote to Cetecom last week. They responded=20
> saying that MTU isn't the only negotiated parameter.
>=20
> -Daryl.
>=20
>=20
>=20
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003,=20
> Santa Clara The only event dedicated to issues related to=20
> Linux enterprise solutions www.enterpriselinuxforum.com
>=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net=20
> https://lists.sourceforge.net/lists/listinfo/b> luez-devel
>=20



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
