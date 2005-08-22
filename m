Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <396736060508212049590777da@mail.gmail.com>
From: Robert Brewer <rwb123@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] What's status of bt headset on linux?
In-Reply-To: <deah86$c2k$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <deah86$c2k$1@sea.gmane.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 21 Aug 2005 23:49:48 -0400

I have the zonet usb adapter and a Logitech Mobile freedom headset.
btsco is needed, but bluez does not support broadcom chipsets
for SCO right now.  So it will not work.  With my setup I have gotten
btsco running, and I can ring the headset, but when the headset
answers, I get no audio.

I have tested the headset under WinXP with the same hardware
and it works fine.  So I am currently attempting to find out what
is needed to make broadcom chips work with SCO under bluez.
At this point I have sniffed some USB messages under WinXP,
my next step is to sniff the messaging under Linux and=20
then attempt to compare them.

Please write me off-list if you are interested in helping.

-Rob

On 8/21/05, sean <seandarcy2@gmail.com> wrote:
> I have a Zonet BT usb adapter:
>=20
> cat /proc/bus/usb/devices:
>=20
> ........
> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 Spd=3D12
> MxCh=3D 0
> D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0a5c ProdID=3D200a Rev=3D 0.01
> S:  Manufacturer=3DBroadcom
> S:  Product=3DCCBT2035BDGP23-1
> S:  SerialNumber=3D000272C426F1
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01
> Driver=3Dhci_usb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01
> Driver=3D(none)
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> ...............
>=20
>=20
> and a Logitech Mobile Pro bt headset.
>=20
> I'm trying to set this up to use Sype or Free World Dialup
> on FC4.
>=20
>  From dmesg:
>=20
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> .......
> Bluetooth: HCI USB driver ver 2.8
> usbcore: registered new driver hci_usb
> Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> usbcore: registered new driver bcm203x
> .............
> Bluetooth: L2CAP ver 2.7
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO (Voice Link) ver 0.4
> Bluetooth: SCO socket layer initialized
> Bluetooth: HIDP (Human Interface Emulation) ver 1.1
> ............
> Bluetooth: RFCOMM ver 1.5
> Bluetooth: RFCOMM socket layer initialized
>=20
> Do I need btsco to make this work? It appears btsco will
> only work with csr chips, not broadcom like I have.
>=20
> But dmesg shows an SCO socket layer. Is this all that's needed?
>=20
> If so, could someone give me, or direct me, to some explicit
> instructions on how to make this work? googling has not been
> successful.
>=20
> thanks
> sean
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20


--=20
Robert W. Brewer


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
