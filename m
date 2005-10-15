Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20051015211946.GB12751@elmicha.333200002251-0001.dialin.t-online.de>
References: <ae97cd740510150951l76f4b0d3qe28795c25fe8411b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <ae97cd740510150951l76f4b0d3qe28795c25fe8411b@mail.gmail.com>
Subject: [Bluez-users] Re: "Wrong data" from my BT GPS Roylatek
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
Date: Sat, 15 Oct 2005 23:19:47 +0200

aCiDBiTS wrote:

> root@pluto:~#cat < /dev/rfcomm0
> Q=FA=06=AD=B0=B3 =A2=BCAE=EA
[...]

> As you see everything is OK, but I got "weird data" from the GPS reciever.
> While testing I made it work properly form some minutes .... As I've been
> trying with my PDA, I think that some times that it worked in the right w=
ay
> it had been before linked to the PDA without switching off the GPS. But I=
'm
> not sure about it.
>=20
> Any idea where is the problem?

<http://www.worldofppc.com/HWTests/rbt1000.htm> indicates that this GPS
has two modes: NMEA and SIRF. If you have this BlueGPS1000 software or
something similar, try setting it to NMEA. Apparently there is a SIRF
binary mode, so that seems to be the data that you get by default.

I have no idea how you can enable the NMEA mode "manually" - perhaps
it's enough to send a standard NMEA string. You can echo the strings
into your /dev/rfcomm0 (while you have cat running in another console),
e.g.

echo -e '$PSRF103,04,00,01,01*21\r\n' >/dev/rfcomm0

That's the "Recommended Minimum Navigation Data", see e.g.
http://www.martin-dehler.de/gps/navigate.htm (or google for NMEA-0182).


Regards...
		Michael


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
