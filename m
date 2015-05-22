Return-Path: <cyrus@holtmann.org>
Message-ID: <1432294213.8255.3.camel@suse.com>
Subject: Re: [RESEND][PATCH] Bluetooth: Make request workqueue freezable
From: Oliver Neukum <oneukum@suse.com>
To: Arend van Spriel <arend@broadcom.com>
Cc: Takashi Iwai <tiwai@suse.de>, Ming Lei <ming.lei@canonical.com>, "David
 S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@fedoraproject.org>,
 JohanHedberg <johan.hedberg@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "Gustavo F. Padovan" <gustavo@padovan.org>, Laura Abbott
 <labbott@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "bluez mailin
 list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, USB list
 <linux-usb@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Date: Fri, 22 May 2015 13:30:13 +0200
In-Reply-To: <555E442A.808@broadcom.com>
References: <33C25745-6839-4858-9A3E-19EC6408ECED@holtmann.org>
		<Pine.LNX.4.44L0.1505211112310.1397-100000@iolanthe.rowland.org>
		<s5hsiaq3pv4.wl-tiwai@suse.de>	<555E158D.4090607@broadcom.com>
	 <s5hmw0x4z12.wl-tiwai@suse.de> <555E442A.808@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2015-05-21 at 22:46 +0200, Arend van Spriel wrote:
> On 05/21/15 19:32, Takashi Iwai wrote:


> >>>>> Well, if the probe requires the access to a user-space file, it can't
> >>>>> be done during resume.  That's the very problem we're seeing now.
> >>>>> The firmware loader can't help much alone if it's a new device
> >>>>> object.
> 
> So you are saying each device driver should come up with some retry 
> mechanism. Would make more sense to come up with something like that 
> behind the scenes in the firmware loader so all device drivers can rely 
> on one and the same solution.

There is already a notifier for this. I don't see why the firmware
layer couldn't retrigger a match for all unbound devices, just like
we do when a new driver is loaded.

	Regards
		Oliver
