Return-Path: <alwaysgone@seznam.cz>
To: =?iso-8859-2?Q?Marcel=20Holtmann?= <marcel@rvs.uni-bielefeld.de>
From: =?iso-8859-2?Q?Super=20Smart?= <alwaysgone@seznam.cz>
Subject: 
	=?iso-8859-2?Q?Re=3A=20=5BBluez=2Dusers=5D=20TDK=20Firmware=20Upgrade=20Proc
	edure=2E=2E=2E=2E?=
Cc: =?iso-8859-2?Q?BlueZ=20Mailing=20List?= <bluez-users@lists.sourceforge.net>, steve.crane@rococosoft.com, samlee@ptl.com.tw
In-Reply-To: <1053701766.10300.26.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-2
Date: Sun, 25 May 2003 14:32:24 +0200 (CEST)
Reply-To: =?iso-8859-2?Q?Super=20Smart?= <alwaysgone@seznam.cz>
Mime-Version: 1.0
Message-Id: <103424.317214-26559-26157991-1053865944@seznam.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel:

Output of hciconfig -a for the TDK device is:

hci0:	Type: USB=20
	BD Address: 00:80:98:34:83:E7 ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN=20
	RX bytes:370 acl:0 sco:0 events:15 errors:0
	TX bytes:305 acl:0 sco:0 commands:15 errors:0
	Features: 0xff 0xff 0x0f 0x00
	Packet type: DM1 DH1 HV1=20
	Link policy: RSWITCH=20
	Link mode: SLAVE ACCEPT=20
	Name: 'BT_Server '
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x20c LMP Ver: 1.1 (0x1) LMP Subver:
0x20c
	Manufacturer: Cambridge Silicon Radio (10)
=20
Best,

Guido















On 23=A0May=A02003, Marcel Holtmann, <marcel@rvs.uni-bielefeld.de> wrote:

> Hi,
>=20
> > TDK comes with Widcomm software
> > (http://www.tdksys.com/support/drivers/range.asp?id=3D1) -- However, we
> > just use it to update the firmware -- we use your BlueZ on Linux and
> > AveLink's Demo for Windoz.  Works fine now.
> >=20
> > After upgrade, we have HCI 16.4
>=20
> can you send me the output of "hciconfig -a".
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20

______________________________________________________________________
Reklama:
P=F8ij=EFte na T=FDden s Touranem do autosalon=F9 Volkswagen, 23. - 31.5. =
=C8ek=E1 v=E1s sout=EC=BE o nov=FD velkoprostorov=FD Volkswagen Touran!http=
://ad2.seznam.cz/redir.cgi?instance=3D51283%26url=3Dhttp://www.volkswagen.c=
z/touran
