Return-Path: <cyrus@holtmann.org>
Message-ID: <4E1E2813.4040408@bluewatersys.com>
Date: Thu, 14 Jul 2011 11:19:47 +1200
From: Andre Renaud <andre@bluewatersys.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Headset+Alsa problems (without Pulse Audio)
References: <4E1D2146.2050508@bluewatersys.com> <20110713080934.GA14678@dell.ger.corp.intel.com> <4E1E1E59.2000602@bluewatersys.com> <20110713230417.GA15596@dell.ger.corp.intel.com>
In-Reply-To: <20110713230417.GA15596@dell.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
> You can use whatever audio subsystem you like as long as it can hook up
> to the interface that BlueZ provides. The Media API itself hasn't been
> designed for any specific audio subsystem as such, but PulseAudio
> support for it was developed in parallel so it's what probably works
> best right now. And as I said, if you really need something else, such
> as ALSA user space plugins, feel free to take on the effort to port them
> to the Media API. The only reason they're about to get dropped is that
> no-one has shown the interest and resources to port them over and it
> doesn't make sense to keep maintaining two parallel API's (the old unix
> socket based and the new D-Bus based Media API). Btw, I also hope that
> you've done some proper study to conclude that PulseAudio doesn't suit
> your needs and are not just going on a "hunch" about it.

Thanks for that. Can you tell me if there are any other upper layer
systems that support the Media API?

Regarding the usage of pulse audio, our primary restriction at the
moment is disk space, so minimising the number of libraries used is of
great importance. We only have 8MB available on the final system, so as
you can imagine bringing in large libraries is not always possible. The
study you mention is what we're conducting at the moment. I'd welcome
any alternatives that you can suggest. Given what has been discussed so
far, we are currently doing further investigation into using PulseAudio.

Regards,
Andre
