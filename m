Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41449F6B.7070704@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <411AA562.9000402@xmission.com> <411AB404.2010403@superbug.demon.co.uk> <411B1535.1010907@dark-reality.de> <412A660E.3020603@xmission.com> <412A8BFC.9080005@dark-reality.de> <4143B564.2000701@xmission.com> <41441D66.4080901@dark-reality.de>
In-Reply-To: <41441D66.4080901@dark-reality.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] bluetooth audio vs. new 16-bit driver
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 12 Sep 2004 13:11:39 -0600

Lars,

Thanks for the tips. I am moving this thread to bluez since it seems to 
deal with a change in bluez-owned code to get 16-bit sound. (For the 
bluez folks' benefit, we are discussing the bluetooth alsa driver that 
we just put in cvs at bluetooth-alsa.sf.net.)

I also want to hear from Marcel and other bluez experts about what 
direction we should be going to have a "clean" bluetooth audio 
implementation.

[current patches & daemon producing poor sound]
> Strange that it sounds bad. Is the linux kernel driver re-written
> appropriatly for 16 bit? The original snd-bt-sco is "configured" to
> 8bit, using an 8bit SCO endpoint in the hci-usb and telling alsa it
> delivers PCM_S8 instead of PCM_S16.

yes it's in the kernel somewhere. I don't think btsco (the userspace 
stuff) is not introducing distortion.

> I know there's still a problem with hci-usb when it comes to 16 bit
> endpoints, but this results on a terrible noise instead of "bad
> quality"; there's a known issue that sometimes the first byte of the 16
> bit stream is dropped, so that the alignment is flawed.

maybe we need to define bad sound. i usually try playing the busy sound 
from gnomemeeting

aplay -B 1000000 -D plughw:Headset 
/usr/local/share/sounds/gnomemeeting/busytone.wav

because it has a beep with silence between. I get highly distorted beeps 
and it's basically quiet between the beeps. If it was a .wav without any 
silence in it, one might just describe it as just noise.

> Maybe your bad sound problem is connected to the kernel you are using?

it's 2.6.8.1 with only the bt-alsa patches and a patch so the internal 
toshiba bluetooth adapter will power up.

> I never had any problems with sound quality (despite the fact that S8
> sounds bad, but that's normal) for S8, MU_LAW or 16 bit with my HBH-35.
> 
> Hm, I just got the CVS archives and the "default" version of the code is
> written for S8 audio:
> 
> #295:     .formats = SNDRV_PCM_FMTBIT_S8 /* | SNDRV_PCM_FMTBIT_S16_LE */ ,
> 
> #313:   .formats = SNDRV_PCM_FMTBIT_S8 /* | SNDRV_PCM_FMTBIT_S16_LE */ ,

I did change that in what I'm doing (but haven't committed it back yet). 
It didn't seem to help.

> hci_usb.c, 885ff:
> /* Use only the 9 byte
> ~ "One voice channel with 8 bit encoding"
> ~  endpoint until there is support for changing
> ~  the endpoint dynamically. See
> ~   Bluetooth 1.1 Part H:2, section 2.1 */
> if (ep->desc.wMaxPacketSize != 9)
>     break;

I did not know about this. Who knows what should it look like?

-Brad

> If you did not change this code so that it works with 16 bit (mainly the
> hci-usb endpoint selection stuff, hci_usb.c) it won't work well. If you
> did, I don't know what the problem is. Sadly enough I don't have the
> time right now to get a new kernel and try this out. You should use the
> "original" hci_usb.c that shipped with the kernel, and change .formats
> to SNDRC_PCM_FMTBIT_S16_LE. It should work if you already did that.
> 
> These hardcoded options are one of the redesign problems we have to
> face, and I think we need to fix the structure of how this works
> *before* we get a working implementation. Well, it works here, so
> there's a working proof of concept. Just the concept is flawed :/
> 
> The audio driver must be able to communicate with the hci/usb/sco layer
> and tell whether he wants 16 bit or 8 bit audio, so that an application
> can use both. And it must be able to figure out which options are
> available on the headset. And stuff. Sorry, I'm talking wierd here I
> think :)
> 
> cu,
> ~  Lars
> 
> 
> 
> 
> Brad Midgley wrote:
> | Lars
> |
> | I got in the #include linux/compler.h so btsco-cvs (0.3) would compile
> | using 2.6.8.1 with integrated alsa. It compiles and connects at 16 bit.
> | It sounds bad however on my hbh-60. It sounds like a common problem
> | people are having.
> |
> | I know everyone believes btsco is flawed in its design, but we need a
> | working 16-bit sound implementation as a reference before we can get any
> | farther.
> |
> | Does anyone have any ideas of where I should look to fix the audio
> | quality problem?
> |
> | btw, thanks for everybody's work on this so far. I know it's a tough
> | thing to invest the time into.
> |
> | Brad


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
