Return-Path: <Thomas.Luby@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-users] Serial connection between two Linux machines
Date: Wed, 21 Jul 2004 19:36:39 +0300
Message-ID: <37AD475D23C5D0469726DD437E5971412D0D25@esebe022.ntc.nokia.com>
From: <Thomas.Luby@nokia.com>
To: <marcel@holtmann.org>
Cc: <bluez-users@lists.sourceforge.net>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

I have tried "rfconn connect" instead but get the same results.=20

If I keep the connection open it works (using cat as you suggested) =
however this doesnt work if I make a getty port on the slave side

I think the problem is on the slave side because if I connect the slave =
to Windows then I get the same issue. The Windows terminal disconnects =
after 1 "echo" or one file cat

Is there a command I can use on the slave side that keeps the port open =
once connected (this is what I tried with dund --persist)

Are the commands OK on the slave side?

Thanks!

Tom=20

-----Original Message-----
From: ext Marcel Holtmann [mailto:marcel@holtmann.org]
Sent: 21 July, 2004 19:16
To: Luby Thomas (Nokia-NRC/Helsinki)
Cc: BlueZ Mailing List
Subject: Re: [Bluez-users] Serial connection between two Linux machines


Hi Thomas,

> I have two Linux machines. I wish to connect to one from the other
> using a terminal over Bluetooth
>=20
> The problem I have is annoying because it basically works. Anyway,
> here is the problem
>=20
> Master (USB bluetooth):
>=20
> modprobe hci_usb
> hciconfig hci0 up
> hciconfig
>=20
> mknod -m 666 /dev/rfcomm0 c 216 0
> rfcomm bind 0 00:60:57:18:FB:6E 1
>=20
> Slave (UART bluetooth):
>=20
> hciattach /dev/ttyS0 -s 115200 csr
> hciconfig hci0 up
> hcid
> dund --persist --listen
> sdpd
> sdptool add SP --channel=3D1
>=20
>=20
> I open a terminal on the master. A connection is present.
>=20
> I type echo "Hello" > /dev/bluetooth/rfcomm/0
>=20
> and on the master terminal I see "Hello"
>=20
> And this is where the problem comes. If I repeat the echo, I get:
> cannot create /dev/rfcomm0: No such device
>=20
> because the connection was closed
>=20
> I have sent huge files down the link with no problem...but when it
> reaches the end of the file, the connection closes everytime!
>=20
> If anyone knows what Im doing wrong I would appreciate it! I have
> searched for 2 days now and not managed to find the solution

use "rfconn connect ..." instead of "rfcomm bind ..." or keep the link
opened with "cat /dev/rfcomm0".

Regards

Marcel
