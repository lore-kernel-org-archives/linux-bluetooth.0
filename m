Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42161CC7.1090800@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: mystic AT-Command
References: <cv4qgt$8h4$1@sea.gmane.org> <4215FC4A.20504@dark-reality.de> <cv50e9$tm3$1@sea.gmane.org>
In-Reply-To: <cv50e9$tm3$1@sea.gmane.org>
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
Date: Fri, 18 Feb 2005 17:50:15 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Channel 6 seems to be OK for your headset, but the AT command that is
send back is wrong, as far as I understood the SCO control channel.

the check in btsco.c for AT+BVRA=1 was only added because I had no
understanding why my headset sometimes used this, and sometimes the
expected AT+CKPD=200 - it was because btsco sometimes used the wrong
channel. Now this should not happen any more as we have (hopefully)
proper channel auto-detection.

You can try to remove AT+BVRA=1 from btsco.c:

484:
					if (strstr(buf, "AT+BVRA=")
					    || strstr(buf, "AT+CKPD=200")
					    || strstr(buf, "AT+CHUP")
					    || strstr(buf, "AT+CIND=?")) {

===
448:
					if (strstr(buf, "AT+CKPD=200")
					    || strstr(buf, "AT+CHUP")
					    || strstr(buf, "AT+CIND=?")) {

best regards,
~  Lars

Sebastian Roth wrote:
| Hi Lars,
|
| thanks for your answer!
|
|> Looks like the wrong channel is selected.
|
| Can't imagine why this can be a problem with the RFCOMM channel. But
| let's give it a try!
|
|
| # sdptool search --bdaddr 00:0B:2E:02:03:A2 0x1108
| Class 0x1108
| Searching for 0x1108 on 00:0B:2E:02:03:A2 ...
| Service Name: Headset
| Service RecHandle: 0x20000
| Service Class ID List:
|   "Headset" (0x1108)
|   "Generic Audio" (0x1203)
| Protocol Descriptor List:
|   "L2CAP" (0x0100)
|   "RFCOMM" (0x0003)
|     Channel: 6
| Language Base Attr List:
|   code_ISO639: 0x656e
|   encoding:    0x6a
|   base_offset: 0x100
|
| If I do not specify a channel to btsco it uses 6.
| I tried to add channels to the commandline. It connects with channel 1
| or 2. But if I tried to establish the SCO channel pressing the button
| the headset continuosly peeps, no SCO connection!
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

iD8DBQFCFhzGQWC6DTWkDAoRAi25AJ4sCLjgNSG9TrnVRz9OYX+u/c/FzQCcCUMu
h/sO1UsKk7JE6i64M3RP2SE=
=aARN
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
