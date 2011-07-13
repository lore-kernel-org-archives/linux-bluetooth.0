Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 02:04:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Renaud <andre@bluewatersys.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Headset+Alsa problems (without Pulse Audio)
Message-ID: <20110713230417.GA15596@dell.ger.corp.intel.com>
References: <4E1D2146.2050508@bluewatersys.com>
 <20110713080934.GA14678@dell.ger.corp.intel.com>
 <4E1E1E59.2000602@bluewatersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E1E1E59.2000602@bluewatersys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Jul 14, 2011, Andre Renaud wrote:
> On 13/07/11 20:09, Johan Hedberg wrote:
> > Regarding the other issues, unfortunately I can't really help you there.
> > I've never really looked into these ALSA user-space plugins in detail.
> > It's not a big surprise though that it doesn't work: it seems like the
> > last time ctl_bluetooth.c got major changes was back in 2007 (i.e.
> > no-one seems to have had much interest in maintaining it since then).
> > 
> > You should also know that unless someone puts effort into adding support
> > for the D-Bus Media API (doc/media-api.txt) then pcm_bluetooth.c and
> > ctl_bluetooth.c will be removed in the BlueZ 5.0 release along with the
> > pure unix socket based interface for audio.
> 
> Can you confirm for me then that Pulse Audio is the only real supported
> mechanism for getting Bluetooth headsets to work under Linux? If support
> for the ctl/pcm bluetooth modules is about to be dropped, I'm pretty
> sure we're not going to want to start out with that mechanism.

You can use whatever audio subsystem you like as long as it can hook up
to the interface that BlueZ provides. The Media API itself hasn't been
designed for any specific audio subsystem as such, but PulseAudio
support for it was developed in parallel so it's what probably works
best right now. And as I said, if you really need something else, such
as ALSA user space plugins, feel free to take on the effort to port them
to the Media API. The only reason they're about to get dropped is that
no-one has shown the interest and resources to port them over and it
doesn't make sense to keep maintaining two parallel API's (the old unix
socket based and the new D-Bus based Media API). Btw, I also hope that
you've done some proper study to conclude that PulseAudio doesn't suit
your needs and are not just going on a "hunch" about it.

Johan
