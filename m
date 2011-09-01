Return-Path: <cyrus@holtmann.org>
Message-ID: <4E5FF591.7060905@bluewatersys.com>
Date: Fri, 02 Sep 2011 09:13:53 +1200
From: Andre Renaud <andre@bluewatersys.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: PCM audio output
References: <4E5F1DD6.2090102@bluewatersys.com> <20110901072416.GA17434@dell.ger.corp.intel.com>
In-Reply-To: <20110901072416.GA17434@dell.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 01/09/11 19:24, Johan Hedberg wrote:
> It might not be common on Linux PC's but most embedded systems (e.g.
> phones) running Linux/BlueZ use PCM routing. Essentially your audio
> subsystem needs to "know" that PCM routing is in place and that the SCO
> socket received over the (now deprecated) audio unix socket interface or
> the (new) Media interface isn't much more than a /dev/null (it's
> a bit more useful than that since it lets the audio subsystem know that
> there's a SCO connection and allows monitoring its lifetime through
> POLLHUP/POLLERR).
> 
> If your system uses PulseAudio you're in luck since it has built-in
> support for this. However, pulse expects the kernel to provide an ALSA
> device abstraction for the PCM hardware link to the Bluetooth
> controller. You can tell the bluetooth-device module the name of this
> special ALSA device through the sco_sink and sco_source parameters.

Another issue I'm trying to get my head around, is that the system I'm
working on doesn't have audio attached to the CPU. The PCM lines are
going to an external FPGA which is entirely independent. So the Linux
kernel has no Alsa drivers, and no audio codec. Due to space limitations
of the filesystem, subsystems like PulseAudio are probably not going to
be available.

I think this essentially comes down to vendor specific HCI writes to
toggle the audio path, but I'm not sure if I have a full understanding
of how it all works.

Can anyone tell me how they went about setting up an audio connection
with an Bluetooth headset, and then configured the audio to go over the
PCM channel?

Regards,
Andre
