Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4234DDAA.8050704@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco volume commands
References: <Pine.LNX.4.62.0503092351590.6694@block> <422F838B.2060700@xmission.com>
In-Reply-To: <422F838B.2060700@xmission.com>
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
Date: Mon, 14 Mar 2005 01:41:14 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Maybe someone who has the BT specs handy can have a look how the command
style for volume changes exactly is! I don't think it would have worked
if we were using totally wrong commands, and the disfunction after
adding AT+ looks wierd.

best regards,
~  Lars

Brad Midgley wrote:
| Guys,
|
| I made the change in cvs.
|
| My ericsson headset stopped working, so I'm going to ask people to try
| out the current cvs and let me know if there are any headsets that won't
| accept volume changes prefixed with AT. I'm surprised it worked before.
|
| Florian--which headset are you using again? I remember hearing about
| this problem on the Motorola HS-801 at least.
|
| Brad
|
| Florian Echtler wrote:
|
| Hello everyone,
|
| I noticed that in btsco.c from CVS, line 465 and 470, the string
| that is to be sent to the headset seems to be lacking an "AT" prefix.
| After adding that, my headset now correctly changes its
| volume when done via alsamixer (previously, it ignored that).
|
| If desired, I can prepare a patch.
|
| Yours, Florian
| -- Preserve wildlife - pickle a squirrel today!
|>
|>
- -------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

| -------------------------------------------------------
| SF email is sponsored by - The IT Product Guide
| Read honest & candid reviews on hundreds of IT Products from real users.
| Discover which products truly live up to the hype. Start reading now.
| http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
| _______________________________________________
| Bluez-devel mailing list
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel



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

iD8DBQFCNN2qQWC6DTWkDAoRAvmuAJ9UK9hdEkSbuC+EhSzkfWgVwFoYDwCgxPJC
PuWL/gHJYsHumc4nK4o01t8=
=qe/B
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
