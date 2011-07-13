Return-Path: <cyrus@holtmann.org>
Message-ID: <4E1E1E59.2000602@bluewatersys.com>
Date: Thu, 14 Jul 2011 10:38:17 +1200
From: Andre Renaud <andre@bluewatersys.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Headset+Alsa problems (without Pulse Audio)
References: <4E1D2146.2050508@bluewatersys.com> <20110713080934.GA14678@dell.ger.corp.intel.com>
In-Reply-To: <20110713080934.GA14678@dell.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
On 13/07/11 20:09, Johan Hedberg wrote:
> Regarding the other issues, unfortunately I can't really help you there.
> I've never really looked into these ALSA user-space plugins in detail.
> It's not a big surprise though that it doesn't work: it seems like the
> last time ctl_bluetooth.c got major changes was back in 2007 (i.e.
> no-one seems to have had much interest in maintaining it since then).
> 
> You should also know that unless someone puts effort into adding support
> for the D-Bus Media API (doc/media-api.txt) then pcm_bluetooth.c and
> ctl_bluetooth.c will be removed in the BlueZ 5.0 release along with the
> pure unix socket based interface for audio.

Can you confirm for me then that Pulse Audio is the only real supported
mechanism for getting Bluetooth headsets to work under Linux? If support
for the ctl/pcm bluetooth modules is about to be dropped, I'm pretty
sure we're not going to want to start out with that mechanism.

Regards,
Andre
