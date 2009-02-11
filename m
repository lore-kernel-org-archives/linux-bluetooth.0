Return-Path: <cyrus@holtmann.org>
Subject: Re: [linux-pm] [rft]autosuspend for btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, linux-bluetooth@vger.kernel.org,
	Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org,
	Stefan Seyfried <seife@suse.de>,
	linux-pm@lists.linux-foundation.org
In-Reply-To: <20090211165221.GB15838@srcf.ucam.org>
References: <200808221520.19791.oliver@neukum.org>
	 <200808221551.57225.oliver@neukum.org>
	 <1219415470.7591.472.camel@violet.holtmann.net>
	 <200808251243.47569.oliver@neukum.org>
	 <72EBACB5-155E-4F42-9852-886AB6B10417@holtmann.org>
	 <20090211165221.GB15838@srcf.ucam.org>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 17:55:28 +0100
Message-Id: <1234371328.7293.16.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthew,

> > Can you break out the USB anchor extensions and make sure they get  
> > merged into 2.6.28 in an early stage of the merge window. It really  
> > wanna get all of this stuff into the next kernel release. Finally we  
> > are getting somewhere with this driver and can kill the broken hci_usb.
> 
> The anchor extensions have hit mainline, but there doesn't seem to have 
> been any progress on the btusb autosuspend front. Are there any plans 
> for this?

not right now, but my bluetooth-testing.git tree has one change for the
bulk URBs. It seems that some dongles really require them to be present
and won't work otherwise.

Regards

Marcel


