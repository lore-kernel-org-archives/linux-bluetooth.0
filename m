Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <406C8B62.4000802@netpeople.ch>
From: Thomas Lenherr <lenherr@netpeople.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC6BD34895AF36B14F4BF4222"
Subject: [Bluez-users] Once again some media-keys from logitech...
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 01 Apr 2004 23:36:34 +0200

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC6BD34895AF36B14F4BF4222
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
because quite all of my media-keys from my logitech elite keyboard did 
not work,
I started googling and found ... nothing (almost). So I started 
searching the sources
and came to parser.c where I found the producer of these nice "unknown 
consumer"
messages. As somebody else already told in this forum, the keyboard 
seems to
have all the codes wrong by 1 (or there's something wrong with the 
source, but
that doesn't matter), so I just decided to place a nice -1 at the right 
place et voila,
all these messages where gone in the log (except for FLock and the 
change user-button,
but that's something else). After that I lived happily ever after.

Not really... Well, the messages in the log were gone, but neither 
"scankey -s" nor "xev"
were somehow interested in my banging actions on my keyboard.

So, once for short, here are my three questions:
1) Why are these keys lost somewhere in the kernel? (At least I think 
it's there)
2) If I'd like a working FLock-LED, how should I do this?
3) And why the hell is my key for the "anti-{" not working (although 
this one IS
generating an event, but "xev" tells me, this button is for printing...)

Thanks a lot and good night
    Thomas Lenherr

--------------enigC6BD34895AF36B14F4BF4222
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAbItz3E1pPHX30VoRAjXaAJ0ftjFISLIy5iBBTQBJvB3EDyZ6HgCePMcA
SES1AlIOeaD4T8bEqnrKAd0=
=xO55
-----END PGP SIGNATURE-----

--------------enigC6BD34895AF36B14F4BF4222--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
