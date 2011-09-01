Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Sep 2011 10:24:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Renaud <andre@bluewatersys.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PCM audio output
Message-ID: <20110901072416.GA17434@dell.ger.corp.intel.com>
References: <4E5F1DD6.2090102@bluewatersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E5F1DD6.2090102@bluewatersys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Sep 01, 2011, Andre Renaud wrote:
> I am working with an embedded device which has a Marvell 8688 based
> bluetooth chip. We would like to use an external headset, but rather
> than have the audio be transmitted over the HCI layer, we'd like it to
> be sent directly out the PCM lines from the bluetooth chip, thus Linux
> really doesn't see any audio data, but is responsible for setting up the
> link/keys/authentication etc...
> 
> Are there any instructions on how to go about this? I've had a quick
> look around, and this doesn't seem to be a particularly popular
> configuration.

It might not be common on Linux PC's but most embedded systems (e.g.
phones) running Linux/BlueZ use PCM routing. Essentially your audio
subsystem needs to "know" that PCM routing is in place and that the SCO
socket received over the (now deprecated) audio unix socket interface or
the (new) Media interface isn't much more than a /dev/null (it's
a bit more useful than that since it lets the audio subsystem know that
there's a SCO connection and allows monitoring its lifetime through
POLLHUP/POLLERR).

If your system uses PulseAudio you're in luck since it has built-in
support for this. However, pulse expects the kernel to provide an ALSA
device abstraction for the PCM hardware link to the Bluetooth
controller. You can tell the bluetooth-device module the name of this
special ALSA device through the sco_sink and sco_source parameters.

Johan
