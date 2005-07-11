Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] OBEX File Receive
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <f16b04cf0507062355523c3d61@mail.gmail.com>
References: <f16b04cf0507062355523c3d61@mail.gmail.com>
Content-Type: text/plain;
	charset=iso-8859-1
Message-Id: <1121087185.27635.5.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Mon, 11 Jul 2005 08:06:25 -0500

El jue, 07-07-2005 a las 12:25 +0530, hariharan veerappan escribi=F3:
> Dear all/ Marcel,
>=20
> We are presently working on OBEX FTP file transfer.
>=20
> We are doing the Obex ftp with following specification:
>=20
> Machine 1:
> Bluetooth Dongle with Windows
>=20
> Machine 2:
> Bluetooth Dongle with Linux 2.4.20 Kernel.
>=20
> We had made the Machine 1 bluetooth dongle to receive file from any
> bluetooth device. We can able to send the file from machine 2 to the
> Machine 1.
>=20
> The command used on Machine 2 Linux machine.
> obexftp -b <bdaddr> -B <channel number> --put <filename>
>=20
> Like the same, when we send the file from Machine 1 to Machine 2. The
> file cannot be send to Machine2
>=20
> whether command is to be given to make the Linux OBEXFTP to be in
> receive mode of operation.

You need use opd (object push daemon) if want recive files=20

# opd --mode OBEX --channel 10 --sdp --path=20
>=20
> Advise us
> Thanks and regards
> Hariharan.V
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
