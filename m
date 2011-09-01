Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKLsOOOJt4F1MuDrZEnOBzR2Vt77rm1vq=tHhVDgKLFdy-SkHQ@mail.gmail.com>
References: <4E5F1DD6.2090102@bluewatersys.com>
	<20110901072416.GA17434@dell.ger.corp.intel.com>
	<CAKLsOOOJt4F1MuDrZEnOBzR2Vt77rm1vq=tHhVDgKLFdy-SkHQ@mail.gmail.com>
Date: Fri, 2 Sep 2011 00:41:14 +0300
Message-ID: <CABBYNZJvQirjmhC5DgkAdG7ypkRpT4UHfoZTfQgmxxsbjvp+Ow@mail.gmail.com>
Subject: Re: PCM audio output
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Brad Midgley <bmidgley@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brad,

On Thu, Sep 1, 2011 at 6:31 PM, Brad Midgley <bmidgley@gmail.com> wrote:
> Johan,
>
>> If your system uses PulseAudio you're in luck since it has built-in
>> support for this. However, pulse expects the kernel to provide an ALSA
>> device abstraction for the PCM hardware link to the Bluetooth
>> controller. You can tell the bluetooth-device module the name of this
>> special ALSA device through the sco_sink and sco_source parameters.
>
> Are you aware of anyone who has put these pieces together in something
> that we can look at? I've seen discussed what it would look like a
> couple of times but not specifics yet.

MeeGo harmattan use sco_sink and sco_source, passed to PA bluetooth
module, instead of the socket/HCI routing. What I think we could have
been done is somehow require the driver to tag alsa device properly so
we can automatically detect and route the audio properly without
having to hardcode the alsa device in sco_sink/sco_source.

> I see the doc/media-api.txt. Are there tests or examples of the
> minimal media calls to make sco connection monitoring work?

We can probably use the capabilities of the endpoint to set the
routing so PA do the detections, actually I guess this could probably
remove any need to have the audio routing hardcoded in audio.conf. For
the media/endpoint you can play around with test/simple-endpoint to
automatically acquire the transport when configured.

-- 
Luiz Augusto von Dentz
