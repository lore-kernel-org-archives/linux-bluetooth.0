Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42388A52.3050601@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: [Patch] Some btsco modifications
References: <1110683934.5056.43.camel@pc7.dolda2000.com>	 <4233C663.80109@xmission.com> <1110762698.5056.73.camel@pc7.dolda2000.com>	 <423589B1.6000403@xmission.com>	 <1110809103.5056.102.camel@pc7.dolda2000.com>	 <42368D18.2000405@xmission.com>	 <1110930125.19889.13.camel@pc7.dolda2000.com>	 <42377AFF.8030405@xmission.com>	 <1110938218.19889.16.camel@pc7.dolda2000.com>	 <423826D4.7000201@dark-reality.de> <1110978114.19889.45.camel@pc7.dolda2000.com>
In-Reply-To: <1110978114.19889.45.camel@pc7.dolda2000.com>
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
Date: Wed, 16 Mar 2005 20:34:42 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Fredrik Tolf wrote:
| On Wed, 2005-03-16 at 13:30 +0100, Lars Grunewaldt wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Fredrik Tolf wrote:
|>| On Tue, 2005-03-15 at 17:17 -0700, Brad Midgley wrote:
|>| In a perfect world, yes. But the question is: Does the kernel actually
|>| detect wandering out of range, and if so, after how long? If the kernel
|>| can't detect it, is there a way of periodically pinging the headset to
|>| detect it manually?
|>
|>Of course the kernel detects it when a device get's out of range. Not
|>immediatly, but as soon as the lower level BT links break down. Pretty
|>much a protocol feature...
|
|
| Well, I have to admit that I don't really know much about how BT works.
| I just got into the btsco project because I wanted to integrate it
| closer with Gnomemeeting and other VoIP programs, as can be seen from
| the fact that the features I've contributed are pretty
| non-bluetooth-related.
|
| Thanks for enlightening me, though. I would have thought that when the
| device got out of range, the kernel just wouldn't know the status of it
| since it couldn't reach it (and maybe time out after a longer period of
| time). Does anyone have any pointers to good documentation that I can
| use to read up on BT?

As Brad already wrote, dig bluetooth.org. The whole BT thing is set up
as a standard (sort of), from hardware up to the software/driver level.
You can find everything (i.e. AT commands) in the core docs. Maybe you
have to check the older BT specs (1.1) for the headset profile and
especially the sco stuff. And make sure to understand what the different
transport layers do, it helps a lot.

good luck :)
- - Lars

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

iD8DBQFCOIpRQWC6DTWkDAoRAjOFAJ9I3dRVDKIq2ueykN9KG7t59+H8dQCgti/I
YW48SkCAWRHezHM4rMGmQeg=
=SilZ
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
