Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41EE9921.9050807@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Headset connected, respondig, but silent
References: <20050118195131.CD122EACF@sc8-sf-spam2.sourceforge.net> <20050119161516.5ab84510@mirko_3>
In-Reply-To: <20050119161516.5ab84510@mirko_3>
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
Date: Wed, 19 Jan 2005 18:30:09 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

if you really unmuted *everything* in alsa mixer that was a bit to much.
In fact when you unmute the loopback option you should be able to hear
the recorded sound echoed back to the headset, but you can not
record/play anything else meanwhile. so do not unmute "loopback". If
that's not the problem I'm a bit lost :/

what kernel? is it 2.6.10 with mh1 patches from bluez?

- - Lars

mirko_3 wrote:
| Hi everyone,
| I've been trying to get my headset to work lately, with partial
success: using the latest btsco-cvs, I manage to connect to the headset
(a Jabra-250, I think), and pressing the volume/answer buttons is
correctly detected by the program. I've unmuted everything in alsamixer,
and set  snd cards_limit=2 in modules.conf (although I don't use modules
for alsa...). Everything is as it should be, except I can neither record
nor playback anything. Here's my dmesg after pressing the play button
three times on xmms (the progress bar doesn't move, the song doesn't start):
|
| snd-bt-sco revision 1.4 $
| snd-bt-sco: snd-bt-scod thread starting
| snd-bt-sco: playback_open
| snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
| snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
| snd-bt-sco: playback_trigger 1
| snd-bt-sco: setting playback to bspcm
| snd-bt-sco: playback_trigger 0
| snd-bt-sco: setting playback to NULL
| snd-bt-sco: playback_open
| snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
| snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
| snd-bt-sco: playback_trigger 1
| snd-bt-sco: setting playback to bspcm
| snd-bt-sco: playback_trigger 0
| snd-bt-sco: setting playback to NULL
| snd-bt-sco: playback_open
| snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
| snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 800
| snd-bt-sco: playback_trigger 1
| snd-bt-sco: setting playback to bspcm
| snd-bt-sco: playback_trigger 0
| snd-bt-sco: setting playback to NULL
|
| Program output is normal:
| Device is 1:0
| Voice setting: 0x0060
| RFCOMM channel 1 connected
| recieved AT+CKPD=200
| opened hwdep
| connected SCO channel
| Setting sco fd
| Done setting sco fd
| recieved AT+VGS=09
| Sending up speaker change 9
| recieved AT+VGS=08
| Sending up speaker change 8
|
|
| I really hope you can help me, as I've tried for days. Thank you all.
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

iD8DBQFB7pkhQWC6DTWkDAoRAsDgAKDC45T8kPEBJt9gE8l0vkhqMdD/tgCcCTD1
B10FzF8EIjf9fPp2sM8vMCc=
=AuRk
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
