Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EF889FE818AF2543B81B678BEC09B82B0172A1@de01exm63.ds.mot.com>
From: "Waldrop Robert-rwaldrop" <bob.waldrop@motorola.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] RE: Bluez-users digest, Vol 1 #1994 - 3 msgs
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
Date: Tue, 2 Aug 2005 02:13:24 -0400

Hi,

I think there is a problem with my laptop.  Because when I delete the
/dev/rfcomm* files
And recreate them with create_dev, everything works. =20

But I would still appreciate an answer to my question about execl
security in prior mail.

Thanks!

--__--__--

Message: 2
Date: Mon, 1 Aug 2005 14:01:10 -0500
From: Robert L Waldrop <bob.waldrop@motorola.com>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] BlueZ stack failure
Reply-To: bluez-users@lists.sourceforge.net

Hi,

I'm having a problem with the rfcomm utility and linux select().
The symptoms are that if I CTRL-C after incomming connection is heard,
when using "rfcomm listen ... /dev/rfcomm10", /dev/rfcomm10 is deleted.

More importantly, a select call on the device blocks except for the=20
first try.  Also, when my machine boots, you have to run=20
"/etc/init.d/bluetooth restart" for some reason, otherwise; bluetooth
doesn't work, it's like there is something stuck at boot up.

I created the /dev/rfcomm10 using .../bluz-utils-2.18/scripts/create_dev

and am using a clean copy of "rfcomm."  I've also tried rebooting
bluetooth
between each calls rfcomm and that doesn't work.

I reinstalled libs and utils.  I had been using the patch on 2.6.11 from
bluez.org.  I'm initially had an install of Fedora Core three based on=20
2.6.9.

Thanks!

--bob w.

--=20
Robert Waldrop                  Motorola Personal Communications Sector
rwaldrop@urbana.css.mot.com     Urbana-Champaign Design Center
voice  217-384-8719             1800 South Oak Street
                                Champaign IL 61820

[X]  Motorola General Business Information
[ ]  Motorola Internal Use Only
[ ]  Motorola Confidential Proprietary


--__--__--

Message: 3
Date: Mon, 1 Aug 2005 23:41:37 +0200
From: Mathias Adam <a2@adamis.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Kernel module for PCMCIA/CF Bluetooth
cards with CSR chipset
Reply-To: bluez-users@lists.sourceforge.net

On 28.07.05 13:08:13, andy thomas wrote:
> Ah, I thought I'd try a low baud rate to begin with. But it still
times=20
> out if I use the 'bcsp' parameter although if I use 'any' then the
hci0=20
> device is registered:
>=20
>   # hciattach ttyS1 any
>   # hciconfig -a
>   hci0:   Type: UART
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
>         DOWN
>         RX bytes:2086 acl:0 sco:0 events:6 errors:168
>         TX bytes:4 acl:0 sco:0 commands:1 errors:0
>=20
> but it still won't come up.
>=20
>   # hciconfig hci0 up
>   Can't init device hci0: Connection timed out (110)

if you're using a 2.6 kernel: did you apply the patch for the serial
driver I posted here some time ago? had the same problems before.

Regards,
Mathias

--=20
Perfection is achieved not when you have nothing more to add,
but when you have nothing left to take away.
 - Antoine de Saint-Exupery



--__--__--

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


End of Bluez-users Digest


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
