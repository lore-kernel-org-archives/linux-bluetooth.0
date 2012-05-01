Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 May 2012 19:54:55 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [now bisected] Weird bluetooth keyboard regression - just me?
Message-ID: <20120501185455.GA29060@srcf.ucam.org>
References: <20120501073711.028d31d6@lwn.net>
 <20120501110156.2b6e0561@lwn.net>
 <20120501171901.GA26006@srcf.ucam.org>
 <20120501120145.21f65ae2@lwn.net>
 <20120501183149.GA28536@srcf.ucam.org>
 <20120501123923.01ac1138@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120501123923.01ac1138@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 01, 2012 at 12:39:23PM -0600, Jonathan Corbet wrote:
> On Tue, 1 May 2012 19:31:49 +0100
> Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
> > > It's Rawhide, updated yesterday.  "Removable" says "fixed".  
> > 
> > Ok, well that's the problem. udev is seeing "fixed" and enabling 
> > autosuspend. Is this really bluetooth, or does it appear as a USB HID 
> > device? Can you send lsusb -v?
> 
> Whether it's really bluetooth has been an issue in the past... parts of
> the system have fought over it.

Ok, so what I'm assuming is happening here is that the device is plugged 
into a port that's flagged "removable", but contains a built-in hub and 
the receiver is attached to *that*. So this code really needs to look 
back up the chain and see whether the parent port was removable or not. 
I think the kernel is arguably ok here, and the udev rule needs fixing. 
Let me talk to Kay.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
