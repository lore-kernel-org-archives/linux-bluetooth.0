Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4215FC4A.20504@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] mystic AT-Command
References: <cv4qgt$8h4$1@sea.gmane.org>
In-Reply-To: <cv4qgt$8h4$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 18 Feb 2005 15:31:38 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Looks like the wrong channel is selected.

Try enforcing another channel number by adding it after the bt address, i.e.

btsco <btaddr> 2

you can find out the channel numbers your headset provides using the
usual hcitools. I forgot what tool, though... %)

hope this helps,
~  Lars

Sebastian Roth wrote:
| Hi,
|
| one of my bluetooth headsets has the talent to send back "AT+BVRA=1"
| just about one second after it has connected (pressing the button sends
| "AT+CKPD=200"). Because of this the SCO connection is canceled
| immediately.
| Why is this behavior programmed into btsco?
|
| Best regards,
| Sebastian
|
|
|
| -------------------------------------------------------
| SF email is sponsored by - The IT Product Guide
| Read honest & candid reviews on hundreds of IT Products from real users.
| Discover which products truly live up to the hype. Start reading now.
| http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
| _______________________________________________
| Bluez-devel mailing list
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel
|


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCFfxKQWC6DTWkDAoRAshsAJwMt/k+c7vzCAZwXisyVNGDSzP8bwCghorF
oeoqjN/H5G8F9ZJbwlLz26I=
=SGS+
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
