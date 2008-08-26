Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Aug 2008 13:41:39 +0200
From: Stefan Seyfried <seife@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-pm@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
	Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org
Subject: Re: btusb hibernation/suspend breakage in current -git
Message-ID: <20080826114138.GI32522@suse.de>
References: <200808221520.19791.oliver@neukum.org> <200808261136.05666.rjw@sisk.pl> <200808261143.20459.oliver@neukum.org> <200808261210.09665.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200808261210.09665.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 26, 2008 at 12:10:08PM +0200, Rafael J. Wysocki wrote:
> > Good. Can you test what happens if you unplug the device while suspended
> > and hibernated?
> 
> It's built-in, I can't unplug it. :-)

Maybe you can disable it in the BIOS, but this might change the DSDT / other
system configuration, so it might break resume in other ways :-(
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out." 

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
