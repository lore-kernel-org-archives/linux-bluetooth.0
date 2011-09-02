Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Sep 2011 11:23:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Renaud <andre@bluewatersys.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PCM audio output
Message-ID: <20110902082308.GA17562@dell>
References: <4E5F1DD6.2090102@bluewatersys.com>
 <20110901072416.GA17434@dell.ger.corp.intel.com>
 <4E5FF591.7060905@bluewatersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E5FF591.7060905@bluewatersys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Sep 02, 2011, Andre Renaud wrote:
> Another issue I'm trying to get my head around, is that the system I'm
> working on doesn't have audio attached to the CPU. The PCM lines are
> going to an external FPGA which is entirely independent. So the Linux
> kernel has no Alsa drivers, and no audio codec. Due to space limitations
> of the filesystem, subsystems like PulseAudio are probably not going to
> be available.

I suppose you still have *some* component in the system which knows
about the need for a SCO link? All you'd need is to have this component
register an endpoint through the BlueZ Media API and have it request the
SCO link whenever you need it. Luiz already pointed out in his email the
test/simple-endpoint script which should give you some idea of what to
do. When there's a HFP or HSP connection you'll get the D-Bus object
path of the media transport object through the SetConfiguration callback
of the endpoint you registered and then you can call the Acquire method
that the transport object provides to get the actual SCO link.

> I think this essentially comes down to vendor specific HCI writes to
> toggle the audio path, but I'm not sure if I have a full understanding
> of how it all works.
> 
> Can anyone tell me how they went about setting up an audio connection
> with an Bluetooth headset, and then configured the audio to go over the
> PCM channel?

The PCM routing part will always be hardware dependent. So what someone
else did won't necessarily help you much unless they had the exact same
hardware as you. If the setting isn't hard-coded in the controller you'd
typically set it through some vendor-dependent command during the
initialization phase.

Johan
