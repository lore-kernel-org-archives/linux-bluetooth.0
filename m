Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EAFF42.20301@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Cc: Fred Schaettgen <kde-bluetooth@schaettgen.de>
Subject: Re: [Bluez-devel] Re: [kde-bluetooth] Re: Re: How can I add a new
 bluetooth service ?
References: <20050116230927.87008.qmail@web50202.mail.yahoo.com>
In-Reply-To: <20050116230927.87008.qmail@web50202.mail.yahoo.com>
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
Date: Mon, 17 Jan 2005 00:56:50 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just a few comments that where not even asked for :)

just to describe whats happening right now:

we have a small "daemon" that does the whole rfcomm and sco connection
handling (btsco). It listens on rfcomm for the connect/disconnect events
from the headset (button press) and opens/closes sco when needed.

the second part of the whole lot is snd-bt-sco, which handles the
sco-to-audio transmission. This thing will be reworked sooner or later,
we hope it can be a user-space driver AND we want to get rid of the data
transfer loop by connecting alsa and sco socket directly (or converting
the sco socket).

What I always thought about was some way of "communication" between our
btsco daemon that does the connection handling (also should manage
different headsets and stuff like auto-connection on audio-open later),
and I think you might have some suggestions here, Fred.

i.e. an application like gnomemeeting might like to open the headset, or
a tray app could display the status of the headset. For this, the daemon
must support some "connection" thingy. How should this be done? I never
did something like that before, so I don't know... :)

Maybe something simple in /proc or /dev? We won't need much mojo there,
just control for each headset (on/off)

best regards,
~  Lars


Paul Ionescu wrote:
| Hi Fred,
|
| I used the headset with a lot of alsa apps like
| gnomemeeting, mplayer, aso, and non alsa apps thru the
| oss emulation of alsa.
| For gnomemeeting this is just fine because is also
| intended for voice, but to listen to a movie on a 8KHz
| mono headset is not so HiQ.
| Anyway it realy works.
| What I am trying to do is to connect it when I press
| the button on headset and disconnect it when I press
| the button again. So no need for special applet.
| I think that will be nice to put some support for
| btsco in kdebluetooth, but the right person to ask is
| not me.
| Maybe Brad or Lars can give more details of what is in
| the future development for btsco.
| I just modified btsco a bit to be able to use the
| rfcomm connection accepted by kdebluetoothd and did
| some other small changes to better fit my Jabra BT110.
|
| Anyway, if I can help with something, just let me
| know.
|
| Thanks,
| Paul
|
|
| --- Fred Schaettgen <kde-bluetooth@schaettgen.de>
| wrote:
|
|
|>On Sunday 16 January 2005 10:27, you wrote:
|>
|>>--- Fred Schaettgen <kde-bluetooth@schaettgen.de>
|>>wrote:
|>>Hi Fred,
|>>
|>>Yes, I can press the headset button and
|>
|>kbluetoothd
|>
|>>will start a headset connection with btsco.
|>
|>And I can use it with any alsa-capable application?
|>
|>
|>>btsco is from
|>
|>http://bluetooth-alsa.sourceforge.net/
|>
|>>and is a small proof of concept AG profile using
|>>snd-bt-sco which is indeed an alsa bt driver.
|>>So you can connect btsco to a headset but not to a
|>>phone as it does not knows HS or HF profiles.
|>
|>Ah, got it.. I thought btsco handles only the SCO
|>connection, but this can
|>hardly work. Do you think it would make sense to
|>integrate headset support
|>into kdebluetooth at this point?
|>If it works already, the only thing that's missing
|>is a little tray icon,
|>where the user can terminate the headset connection.
|>Problem is snd-bt-sco
|>isn't shipped with the stock kernel. But on the
|>other hand it could help
|>making snd-bt-sco more popular if we support it in
|>kdebluetooth. What's you
|>opinion?
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

iD8DBQFB6v9BQWC6DTWkDAoRAl6vAJ95UtPcSOr4sl0ap6YDqUU317iT5gCgsE4b
K+3bSnyFJB7d2niiLrrQoaI=
=/l1/
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
