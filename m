Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A6099E.2080300@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] "playback drain error" with snd-bt-sco
References: <200411250023.28429.mailsp@sebastian-eichner.de>
In-Reply-To: <200411250023.28429.mailsp@sebastian-eichner.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 25 Nov 2004 09:34:38 -0700

Sebastian,

I'll second Marcel's suggestion you try a newer kernel. Maybe you 
already have...

It's unfortunate that the module api is changing across *stable* 
versions of the kernel. The reality is we don't have the volunteers 
required to maintain for multiple kernels.

Brad

Sebastian Eichner wrote:
> Hi all,
> 
> i would love to get my new Bluetooth headset (Bluetake BT420) running 
> with linux. So i compiled and installed the alsa-bluetooth cvs code 
> (btw: i had to add "-lsdp" to the libs in the Makefile to make it 
> compile). 
> 
> I can load the kernel module and start btsco:
> /usr/local/bin/btsco 00:08:F4:30:03:71
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 5 connected
> 
> But when i play a wav-file via aplay or play/dsp1, i do not hear 
> anything but get an error message in the system log:
> 
> Nov 25 00:12:34 linux kernel: snd-bt-sco: playback_open
> Nov 25 00:12:34 linux kernel: snd-bt-sco: prepare ok bps: 16000 size: 
> 16002 count: 4000
> Nov 25 00:12:34 linux kernel: snd-bt-sco: playback_trigger 1
> Nov 25 00:12:34 linux kernel: snd-bt-sco: setting playback to bspcm
> Nov 25 00:12:44 linux kernel: ALSA sound/core/pcm_native.c:1316: 
> playback drain error (DMA or IRQ trouble?)
> Nov 25 00:12:44 linux kernel: snd-bt-sco: playback_trigger 0
> Nov 25 00:12:44 linux kernel: snd-bt-sco: setting playback to NULL
> 
> 
> I am using kernel 2.6.5 from SuSE-linux, so i replaced the kalloc() 
> statements with the old ones (found in cvs and did some merging). 
> Compiled and loaded fine without any errors.
> 
> Do you have an idea whats going wrong? Or doesnt it work with 2.6.5 
> anymore at all?
> 
> Thanks!
>  Sebastian
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
