Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4211C910.1020204@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] snd-bt-sco built-in
References: <cusgdr$4g1$1@sea.gmane.org>
In-Reply-To: <cusgdr$4g1$1@sea.gmane.org>
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
Date: Tue, 15 Feb 2005 11:04:00 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sebastian Roth wrote:
| Hi,
|
| I'm trying to build snd-bt-sco directly into the kernel.

why?

| As other soundcard drivers can be built in I think this is no problem
| with the kernel or ALSA-core.
| Can someone please point me to why this is happening or is it known
| that snd-bt-sco is working as module only?

I think nobody ever tried to compile it into the kernel, and I definitly
never did. I think it's not written with that in mind.

I can't tell for sure why this function is failing this way. Did you
build snd-hw-dep and put it in the kernel, too? If it's missing than
that could be the problem. I think the dynamic loader would notice in a
module, but propably not if the kernel itself is missing it.

best regards,
~   Lars

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

iD8DBQFCEckQQWC6DTWkDAoRAgOZAJ9HKs/CoqCdoIuBAou5UlUcrPisYQCglwlJ
ai8YKl5y0NI5RV7HMv1Lczw=
=QLIf
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
