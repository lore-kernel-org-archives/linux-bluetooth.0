Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Jeff Fern" <sf@fcse.co.uk>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Multiple Headsets
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <41E267C4.5030906@dark-reality.de>
Message-ID: <E1CqGRi-0000uU-M4@sc8-sf-mx2.sourceforge.net>
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
Date: Sun, 16 Jan 2005 19:49:57 -0000

Hello Lars,

I am now running a 2.6.10 kernel and the latest patch from bluez.org. 

I have seen the previous threads about multiple headsets which refer to the
isoc parameter for the kernel module, however this does not make any sence
to me.

Is there any chance you could provide some more information / suggestions.

Suriyan, in your reply you said you've sucessfully got it working. Is it
possible for you to send me some details on how you did this?

My knowledge of C / kernel stuff is fairly limited so please go easy on me
:)

Regards,

-Jeff Fern
 

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Lars
Grunewaldt
Sent: 10 January 2005 11:32
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple Headsets

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

first, it would be a good idea to update to the latest available sources
(that is, 2.6.10 kernel and mh10 patchset).

I think we do support multiple sco connections now, but you must either use
8-bit-audio (by hacking the btsco stuff) or hack the kernel.

The problem in short: the hci_usb driver that handles the bt dongles needs
to know how many data has to be send. So if using two 16bit channels, it
needs to switch to the 32bit-mode, not the 16bit mode that is used by
default.

This switching is not handled automatically by now (or, not handled in any
way to be precise), and while we are talking about it a lot, I think nobody
fixed this by now (this includes me).

Maybe you want to dig the list archives and have a look at discussions about
sco...

best regards,
~  Lars


Jeff Fern wrote:
| Hello all,
|
| I have sucessfully got Bluez and the bt-snd-sco alsa stuff working 
| with my debian 2.6.9 and mh5 patch.
|
| What I would like to do is get two headsets working, as two seperate 
| audio devices so I can cat /dev/dsp1 to /dev/dsp2 and pass audio through.
|
| Whenever I currently try and connect two headsets, the second one 
| reports the SCO channel is already in use.
|
| I do have two bluetooth USB dongles that can be used (although would 
| like to just use one if possible).
|
| I should point out that my background is in Java and not C, so 
| although I have examined the bt-snd-sco and btsco source files, I do 
| not understand them enough to be able to see what is going on.
|
| Any help would be much appreciated,
|
| Regards,
|
| -Jeff Fern
|
|
| -------------------------------------------------------
| The SF.Net email is sponsored by: Beat the post-holiday blues Get a 
| FREE limited edition SourceForge.net t-shirt from ThinkGeek.
| It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
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

iD8DBQFB4mfEQWC6DTWkDAoRAgVkAKCsMX0puS8uFwQ9QkrUEcL///9Y5ACgmgif
v6/EiGDihE5EE9yU8ZdbAU8=
=X+Qu
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues Get a FREE
limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
