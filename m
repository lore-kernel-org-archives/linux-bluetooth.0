Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110901072416.GA17434@dell.ger.corp.intel.com>
References: <4E5F1DD6.2090102@bluewatersys.com>
	<20110901072416.GA17434@dell.ger.corp.intel.com>
Date: Thu, 1 Sep 2011 09:31:21 -0600
Message-ID: <CAKLsOOOJt4F1MuDrZEnOBzR2Vt77rm1vq=tHhVDgKLFdy-SkHQ@mail.gmail.com>
Subject: Re: PCM audio output
From: Brad Midgley <bmidgley@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan,

> If your system uses PulseAudio you're in luck since it has built-in
> support for this. However, pulse expects the kernel to provide an ALSA
> device abstraction for the PCM hardware link to the Bluetooth
> controller. You can tell the bluetooth-device module the name of this
> special ALSA device through the sco_sink and sco_source parameters.

Are you aware of anyone who has put these pieces together in something
that we can look at? I've seen discussed what it would look like a
couple of times but not specifics yet.

I see the doc/media-api.txt. Are there tests or examples of the
minimal media calls to make sco connection monitoring work?

-- 
Brad Midgley
