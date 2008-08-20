Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808201442.08208.oliver@neukum.org>
References: <200808201142.52620.oliver@neukum.org>
	 <200808201405.19720.oliver@neukum.org>
	 <1219235683.7591.326.camel@violet.holtmann.net>
	 <200808201442.08208.oliver@neukum.org>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 15:00:50 +0200
Message-Id: <1219237250.7591.328.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > I tried to run this on my Quad G5, but I never see suspend() or resume()
> > called. Do I have to do something to make autosuspend work?
> 
> echo "auto" > $(directry in sysfs for device)/power/level
> And you'll see power events in syslog only if you compile with
> CONFIG_USB_DEBUG

I only seem to see power/wakeup entries. I don't have power/level. Am I
missing some configuration option?

Regards

Marcel


