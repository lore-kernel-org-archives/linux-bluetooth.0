Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
Date: Wed, 20 Aug 2008 15:05:21 +0200
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
References: <200808201142.52620.oliver@neukum.org> <200808201442.08208.oliver@neukum.org> <1219237250.7591.328.camel@violet.holtmann.net>
In-Reply-To: <1219237250.7591.328.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808201505.21996.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch 20 August 2008 15:00:50 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > > I tried to run this on my Quad G5, but I never see suspend() or resume()
> > > called. Do I have to do something to make autosuspend work?
> > 
> > echo "auto" > $(directry in sysfs for device)/power/level
> > And you'll see power events in syslog only if you compile with
> > CONFIG_USB_DEBUG
> 
> I only seem to see power/wakeup entries. I don't have power/level. Am I
> missing some configuration option?

Probably CONFIG_USB_SUSPEND

	HTH
		Oliver
