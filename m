Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jul 2011 11:09:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Renaud <andre@bluewatersys.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Headset+Alsa problems (without Pulse Audio)
Message-ID: <20110713080934.GA14678@dell.ger.corp.intel.com>
References: <4E1D2146.2050508@bluewatersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E1D2146.2050508@bluewatersys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Jul 13, 2011, Andre Renaud wrote:
> I'm trying to get a bluetooth headset working on an embedded Linux 
> environment. I don't have the available resources to drag in all of
> Pulse Audio, so this is being done with essentially just bluez 
> and the alsa-libs.
> 
> It all seems to connect & pair properly, but when I go to play audio 
> no sound comes out. There are no complaints, and the 'aplay' command 
> runs for approximately the correct amount of time before exiting 
> cleanly. Using hcidump, I can see that the audio data is being 
> transmitted.
> 
> In the process of investigating this, I found that the amixer command 
> was unable to talk to the bluetooth controls. I eventually tracked 
> this down to a bug in audio/ctl_bluetooth.c. Having fixed it,
> I am now able to list the controls, but unable to change their values
> (I have also made it so that it errors out if it goes to change
> an integer, and the change doesn't take, rather than looping forever).
> 
> Does anyone know what I might be missing, or where I should start
> looking next?

About your patch, could you please send something that can be fed to
"git am". Typically git format-patch + git send-email should be enough
for this. Before that however, fix your code indentation. The BlueZ
coding style is to use *only* tabs whereas what you sent uses spaces.

Regarding the other issues, unfortunately I can't really help you there.
I've never really looked into these ALSA user-space plugins in detail.
It's not a big surprise though that it doesn't work: it seems like the
last time ctl_bluetooth.c got major changes was back in 2007 (i.e.
no-one seems to have had much interest in maintaining it since then).

You should also know that unless someone puts effort into adding support
for the D-Bus Media API (doc/media-api.txt) then pcm_bluetooth.c and
ctl_bluetooth.c will be removed in the BlueZ 5.0 release along with the
pure unix socket based interface for audio.

Johan
