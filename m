Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EA9FF3.5090900@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco crash without daemon
References: <41E91B7A.1070303@egabriel.de> <41E925F4.3060907@dark-reality.de> <41E92C83.8010406@egabriel.de> <41E9349C.8060001@dark-reality.de> <41E96812.7030903@egabriel.de> <41E9B60E.2010509@dark-reality.de> <41EA44F4.50606@egabriel.de>
In-Reply-To: <41EA44F4.50606@egabriel.de>
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
Date: Sun, 16 Jan 2005 18:10:11 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ligi wrote:
|
| | Why do you want to use the external alsa-driver anyway?
| |
| It recommended to use the external Driver in the Gentoo docs - and i
| found nothing in the btsco docs that says something diffrent - so i
| used the external Driver ( Well -  I like the external Driver Concept
| (in a world with so much devices ) more too .... )

well, we want to migrate the snd-bt-sco to userspace if possible, so you
won't need a specific alsa driver (kernel vs. standalone) sooner or
later, hopefully. But until than it's the easiest way (and the proper
way) to use kernel alsa as a reference, not the standalone alsa (the
kernel is available on any system, isn't it? ;)

I ran into some problems myself when I was using btsco on a system that
had an unsupported audio device that needed a driver patched into alsa
(no patch for the kernel available) AND that was written in C++ so very
bad mojo. I hacked in into the kernel, got bad voices from lkml (*vbeg*)
for using c++ in kernel space and stuff. Well was fun. The point beeing:
meanwhile this driver has been re-implemented in C and there's a kernel
patch so it can easily used with alsa-kernel.

| PS: You can mark the SouthWing NeoVoice Headset ( on a Sitecom USB ->
| BT Dongle ) as working for btsco - there is no wiki so I cant do this
| now !-)
| btw. anyone interested in a btscoWiki ?

Sounds good for me, it would make changing the site a lot easier, would
it not? Any more comments from i.e. Brad?

Of course an "external resource site" is possible even if we don't want
to have an official wiki ;)

best regards,
~  Lars

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

iD8DBQFB6p/yQWC6DTWkDAoRAuRUAKCImgzbBTD/5PhqzRKUSRJAgce1SQCeNEWQ
ff5CCb1DTfXrk21W9n05SAQ=
=nx+Z
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
