Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Regarding a2recv
Message-Id: <20050509005413.3787d2d7.henryk@ploetzli.ch>
In-Reply-To: <20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
References: <20050506060525.32b209ca.henryk@ploetzli.ch>
	<20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__9_May_2005_00_54_13_+0200_ofmkOdwVU=m=gNiM"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 9 May 2005 00:54:13 +0200

--Signature=_Mon__9_May_2005_00_54_13_+0200_ofmkOdwVU=m=gNiM
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sun, 8 May 2005 13:50:39 +0100 (BST) schrieb Mayank Batra:

> I believe that should have been a problem because
> interchanding packet_type and message_type does make a
> lot of difference to the avdtp packet.

Yes, it does.

I now completely restructured the a2recv code into something that more
closely resembles a socket server application. Basically it is now a
giant endless loop that is blocking in select() on the serverfd and
optionally the cmdfd and streamfd (should they be open) and as soon as
there is data to read or a connection to accept I am reading it.

There is also an internal state like that from the AVDTP spec and I'm
treating incoming packets based on that state. This will allow any
sequence of AVDTP_DISCOVER, AVDTP_GET_CAPABILITIES, AVDTP_OPEN, etc.
commands to occur and also makes it possible to have the server handle
more than one connection during its lifetime (only one at a time, of
course).

The code is currently completely lacking any error handling, and simply
ignores the offending packet (or exits), so that should be added. I also
don't like the structs used for the avdtp signalling packets, I think
there should only be one struct that includes a struct avdtp_header and
a union with all the other optional signalling contents. Then there
would have to be specialised read()/write() functions which figure out
(based on the header) how long the packet actually is and automatically
send/receive that many bytes. However, that would also require
modification of a2play so I thought I'd ask first.

That would make it easier to send rejection messages (which may differ
from the acceptance message in length) and do proper error handling.

> Why doesn't the streaming start?

If I only knew ...
The current code shows me that the stream connection is correctly
established and the start streaming response is sent. Then after some
seconds I get a read error on the command fd with error message
"Connection timed out".=20

Again, please check that I didn't break your devices. I can only test
with a2play. There might also still be some flaws in the state handling
since this is slightly more complex than the original straight linear
design.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Mon__9_May_2005_00_54_13_+0200_ofmkOdwVU=m=gNiM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCfpiZIjWgKE0OA2gRAjy7AKDM+JSST/0BfpL4Xb5QCQrjnbK24QCfc6lo
GwimbsSZvpP2+yd4Hg9diVc=
=bwCV
-----END PGP SIGNATURE-----

--Signature=_Mon__9_May_2005_00_54_13_+0200_ofmkOdwVU=m=gNiM--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
