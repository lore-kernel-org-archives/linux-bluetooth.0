Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Mon, 25 Aug 2008 13:53:10 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 linux-pm@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 Pavel Machek <pavel@suse.cz>,
 linux-usb@vger.kernel.org,
 Stefan Seyfried <seife@suse.de>
References: <200808221520.19791.oliver@neukum.org> <1219415470.7591.472.camel@violet.holtmann.net> <200808251337.16076.rjw@sisk.pl>
In-Reply-To: <200808251337.16076.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808251353.12590.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 25 August 2008 13:37:14 schrieb Rafael J. Wysocki:
> Since the bluetooth adapter in this box is apparently handled by btusb, I=
'm
> suspecting the problem may be related to it or to the USB subsystem (ehci=
=2Dhcd
> in particular). =A0I'm going to debug it further, but if you have any ide=
as to
> try, I'll appreciate any help.

btusb in current git doesn't implement suspend/resume. Thus the driver will=
 be
unbound. Possibly the bluetooth subsystem cannot stand that while suspended.

	Regards
		Oliver
