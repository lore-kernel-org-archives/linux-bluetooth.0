Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42DE9F3C.6050503@hasborg.com>
From: Joshua Wright <jwright@hasborg.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] making a cellphone ring using bluetooth message
References: <baec107c05072005529550ac5@mail.gmail.com>	 <1121876820.24456.273.camel@santafe> <1121878162.7415.22.camel@panic> <baec107c05072011129b1402f@mail.gmail.com>
In-Reply-To: <baec107c05072011129b1402f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 20 Jul 2005 15:00:12 -0400

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tri Ngo wrote:
> Thanks everyone. I havea  follow up question, is it possible to
> establish an rfcomm connection with a bluetooth phone automatically. 

My understanding is that if you have already established a paired
relationship with the target bluetooth device, some phones will allow
you to connect without prompting Yes/No on the target device.

Looking at the content on the trifinite.org site, it appears that phones
vulnerable to the BlueBug attack
(http://trifinite.org/trifinite_stuff_bluebug.html) would also allow an
attacker to establish an rfcomm connection without notifying the owner
of the target device.

- -Josh
- --
- -Joshua Wright
jwright@hasborg.com

2005-2006 pgpkey: http://802.11ninja.net/pgpkey.htm
fingerprint: F00E 7A42 8375 0C55 964F E5A4 4D2F 22F6 3658 A4BF

Today I stumbled across the world's largest hotspot.  The SSID is "linksys".
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC3p87TS8i9jZYpL8RAlKWAKDF2zfEZpn+2jaPfLqMFdF9GB94hgCgwRZJ
qYXLgTBTT9gRufP9INLSumk=
=lFx+
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
