Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: starting btsco-in-libalsa
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41B83BA8.5010001@suche.org>
References: <41B81ACB.1080807@xmission.com>
	 <1102589835.9988.114.camel@pegasus>  <41B83BA8.5010001@suche.org>
Content-Type: text/plain
Message-Id: <1102594031.9988.171.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 09 Dec 2004 13:07:11 +0100

Hi Thomas,

> > nice start. Actually I tried this by myself some time ago, but haven't
> > got any further than a skeleton. The main problem I see at the moment is
> > that we have to develop this inside the ALSA lib source and that is bad.
> > The reason for this is "pcm_local.h" and its definitions that are not
> > installed system wide. I don't think that SND_PCM_TYPE_BLUETOOTH is
> > needed, but I can be wrong of course. The other thing is that this stuff
> > should belong to the pcm/ext/ directory. My skeleton is attached and I
> > used these extra lines in ~/.asoundrc
> > 
> > 	pcm.aiptek {
> > 		type a2dp
> > 		bdaddr "00:0B:xx:xx:xx:xx"
> > 	}
> > 
> > Assuming that /usr/lib/alsa-lib/libasound_module_pcm_a2dp.so exists this
> > works as it should. So we have PCM at the input side of this plugin and
> > we send SBC over AVDTP to our headphone.
> >   
> 
> i think this goes to the wrong direction.
> 1. Even if there exist alsa library for many programms it is sufficent
> to use /dev/dsp and /dev/audio.
> This mean that the soundcard driver should work independent of the
> alsa library.

this is too short thinking. There are parts that don't belong inside the
kernel. And SBC encoding and decoding is one of them.

> For me looks this very similar to the old pwc driver problem.
> a) An kernel module that create an hook for interact with an non
> kernel module

No it is not. We don't design crappy binary interfaces to the kernel.
Everything is open and the socket interface is a well known "hook" into
the kernel side of a network stack.

> b) There is an gerneral interface dsp/audio/mixer wich become crippled
> without the alsa lib
> So why not be conesquent and put btsco int the snd-bt-sco module ?
> Like other hardware the module is tooled via command line or IOCTL
> wich bt-device it should handle.

Bluetooth is not only hardware. What you see is a dongle, but on top
there is a complete stack. We interface with L2CAP and this is a
software layer.

> Than the we have and "single" module wich is responsable for handling
> bluetooth sound.

See the point above. There will never be a "single" module solution.

> Currently it look more like an skeleton for me that grab data from SCO
> and tell BTSCO how to configure the hardware.

It is this way actually, because the sound volume (mixer settings) are
done via AT commands over RFCOMM. There is no way to do this inside the
kernel.

> So what are the grounds for moving btsco to the lib inseat of moving
> it to the module ?

The support for a Bluetooth protocol can be implemented as a kernel
module or in userspace depending on its needs. A Bluetooth profile is
like an application is this is userspace. So decide by yourself what is
the protocol and what is the profile.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
