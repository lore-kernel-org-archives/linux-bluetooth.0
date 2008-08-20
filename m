Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [rfc/rft]power management for btusb
Date: Wed, 20 Aug 2008 18:04:54 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Pavel Machek <pavel@suse.cz>,
 Stefan Seyfried <seife@suse.de>,
 linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <Pine.LNX.4.44L0.0808201151460.2806-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0808201151460.2806-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808201804.55338.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch 20 August 2008 17:55:23 schrieb Alan Stern:
> On Wed, 20 Aug 2008, Marcel Holtmann wrote:
> 

> > is there any way to make it default if we know it works all the time?
> 
> No, probably not.  But in general we don't know that.  And we do know
> that a fair number of devices really are broken in this way -- lots of
> printers or scanners have this problem.  Too many for us to want to
> keep a blacklist in the kernel, as Oliver mentioned.
> 
> The idea is that some desktop management program, like hal, should be 
> able to recognize which devices can autosuspend safely and then enable 
> them.  That way the whole problem is pushed out to userspace.  :-)

You could write a udev rule.

	Regards
		Oliver
