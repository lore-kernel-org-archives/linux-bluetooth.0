Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E95236.3010903@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: scooped by pocketpc (a2dp)
References: <41E93682.9040907@xmission.com> <pan.2005.01.15.16.35.03.165547@yahoo.com>
In-Reply-To: <pan.2005.01.15.16.35.03.165547@yahoo.com>
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
Date: Sat, 15 Jan 2005 18:26:14 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

I think you use snd-bt-sco, don't you? This should of course work,
because snd-bt-sco is no user-space alsa driver, but runs in kernel
space, so oss emulation works. It uses the headset profile, not a2dp.
(fancy stereo audio stuff) :)

Or am I wrong? I thought there's no alsa support for a2dp yet.

best regards,
~  Lars

Paul Ionescu wrote:
| Hi Brad,
|
| I am successfully using my jabra BT110 headset with gnomemeeting which
| supports alsa natively. For now gnomemeeting supports only H323, but it
| will do SIP in the near future.
|
| But I also tested with linphone which only supports OSS, and the
| oss emulation worked for me (used /dev/dsp1 ).
| I tested with linphone version 0.12.2.
|
|
|
| On Sat, 15 Jan 2005 08:28:02 -0700, Brad Midgley wrote:
|
|
|>hey
|>
|>it's interesting to note that one of the pocketpc manufacturers
|>(audiovox?) was announcing a2dp profile support at the consumer
|>electronics show. the implementation has been floating around and i tried
|>it out. it needs the occasional soft reset but otherwise works.
|>
|>anyway, we're no longer ahead of every other commercial OS with our
|>implementation, but on the bright side, we should be getting interest from
|>more developers.
|>
|>the next step is still an a2dp userspace alsa driver which has sort of
|>stalled (my fault). i would be more excited about it if there was a voip
|>application out there that used libalsa. (there's not a way to get oss
|>emulation for a userspace alsa driver) kphone uses only oss.
|>
|>btw, i couldn't find a way in the spec to adjust the a2dp headset's audio
|>from the a2dp source. has anyone noticed a way?
|>
|>brad
|>
|>
|>------------------------------------------------------- The SF.Net email
|>is sponsored by: Beat the post-holiday blues Get a FREE limited edition
|>SourceForge.net t-shirt from ThinkGeek. It's fun and FREE -- well,
|>almost....http://www.thinkgeek.com/sfshirt
|
|
|
|
|
| -------------------------------------------------------
| The SF.Net email is sponsored by: Beat the post-holiday blues
| Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
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

iD8DBQFB6VI2QWC6DTWkDAoRAnKqAKC4d297UXOCT0uj335SiVxIVwIu+QCfbGqu
sXoZbqAiZoetK/98bLxVID4=
=FnW7
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
