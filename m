Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc/rft]power management for btusb
Date: Wed, 20 Aug 2008 17:33:12 +0200
Cc: Pavel Machek <pavel@suse.cz>,
 Stefan Seyfried <seife@suse.de>,
 linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200808201142.52620.oliver@neukum.org> <200808201600.56584.oliver@neukum.org> <1219245914.7591.338.camel@violet.holtmann.net>
In-Reply-To: <1219245914.7591.338.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808201733.13718.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch 20 August 2008 17:25:14 schrieb Marcel Holtmann:

Hi,

> finally I found the device and setting it to auto makes it actually
> suspend. Why is this not default? The driver has to enable it anyway.

for too many class drivers some devices survive suspension and others crash.
We don't want the lists of such devices in kernel space.

	Regards
		Oliver
