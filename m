Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40D19E13.9070005@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] question: what does this patch from snd-bt-sco
 do?
References: <40A9E6CB.4010505@dark-reality.de> <88307002-A8B9-11D8-A107-000A95A4D990@dcs.gla.ac.uk> <40A9EE51.2080102@dark-reality.de> <1084881439.5833.108.camel@pegasus> <40AA11AB.6010307@dark-reality.de> <1084888843.4327.1.camel@pegasus> <40D0CE71.2010208@dark-reality.de> <1087427168.4309.30.camel@pegasus> <40D0DFFE.7020701@dark-reality.de> <1087431863.4309.39.camel@pegasus> <E1B5DFDA-C050-11D8-9772-000A95A4D990@dcs.gla.ac.uk>
In-Reply-To: <E1B5DFDA-C050-11D8-9772-000A95A4D990@dcs.gla.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 17 Jun 2004 15:35:15 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jonathan Paisley wrote:
| On 17 Jun 2004, at 1:24, Marcel Holtmann wrote:
|
|>> To make my headset work for now (need my "phone") I used that bad kernel
|>> patch again, but I'll try to do everything to avoid that in the release.
|>> I just have to understand what's going on...
|>
|>
|> I don't see your problem. Simply use 16bit PCM in the ALSA code.
|
|
| This should work fine. Reconfigure the sound format descriptors in the
| ALSA driver to describe 16 bit audio instead of 8 bit.

won't be a problem. I know what to do because I changed them before,
from S8 to MULAW_8 :)

My only problem/wish is that I'd like to support all three audio
encodings, but I understand this is impossible right now.

What exactly are the influences of the "alternate setting"? Does this
only change SCO/Audio behaviour, or is the whole bluez stack affected by
this (if hci_usb is used, of course). I just want to understand the
pros/cons of 8bit/16bit setting.

[listOT]
There's one more (alsa-related) issue I have with the alsa driver. The
problem is that, if there's no open sco channel, the audio application
accessing the interface is stalled because the buffer is never read. It
would be better if the data could be "dumped" or something.

Is this possible in an easy way, or do I have to look for audio
sync/timing and stuff instead of just writing the data to /dev/null and
tell the app "go for the next buffer".
[/listOT]

thanks,
~  Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA0Z4TQWC6DTWkDAoRAusPAKCaEozsMCgE38q4Ki+wHBcVoYu/RwCgjbPn
6NmfwP1Qxbvgrg3tMkPQdtg=
=AMrl
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
