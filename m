Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E93B4F.1010600@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] scooped by pocketpc (a2dp)
References: <41E93682.9040907@xmission.com>
In-Reply-To: <41E93682.9040907@xmission.com>
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
Date: Sat, 15 Jan 2005 16:48:31 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

dear Brad,

all programs that use openh323/pwlib (latter for hardware abstraction)
use alsalib, because pwlib can be compiled against alsalib or oss or both.

That leads to - at least - gnomemeeting and openphone supporting alsa
directly :)

to bad that skype does support only oss, while they seem to have
artsd/esd support (I never tried that though).

I'm not that interested because my headset only supports the mono
headset profile... ;)

writing the a2dp alsa driver should be similar to the btsco alsa part,
maybe we can build one thing for both purposes, or at least keep
structures similar so that both projects can support each other best!

cu,
~  Lars


Brad Midgley wrote:
| hey
|
| it's interesting to note that one of the pocketpc manufacturers
| (audiovox?) was announcing a2dp profile support at the consumer
| electronics show. the implementation has been floating around and i
| tried it out. it needs the occasional soft reset but otherwise works.
|
| anyway, we're no longer ahead of every other commercial OS with our
| implementation, but on the bright side, we should be getting interest
| from more developers.
|
| the next step is still an a2dp userspace alsa driver which has sort of
| stalled (my fault). i would be more excited about it if there was a voip
| application out there that used libalsa. (there's not a way to get oss
| emulation for a userspace alsa driver) kphone uses only oss.
|
| btw, i couldn't find a way in the spec to adjust the a2dp headset's
| audio from the a2dp source. has anyone noticed a way?
|
| brad
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

iD8DBQFB6TtPQWC6DTWkDAoRAvX2AJ41DorQDGXbmMDCwHG8q5oz9ZJacwCfWXpe
4OpQvAZUWNhgH0awprSTFBY=
=pUC7
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
