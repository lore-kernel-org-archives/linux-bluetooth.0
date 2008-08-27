Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Wed, 27 Aug 2008 09:55:11 +0200
Cc: Stefan Seyfried <seife@suse.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-pm@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
	Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org
References: <200808221520.19791.oliver@neukum.org> <200808262153.18240.oliver@neukum.org> <200808270128.16052.rjw@sisk.pl>
In-Reply-To: <200808270128.16052.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808270955.12511.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch 27 August 2008 01:28:15 schrieb Rafael J. Wysocki:
> > This doesn't explain the original failure. Can you comment out the supp=
ort
> > for suspend/resume in the driver and try again?
>=20
> With that commented out, I'm able to reproduce the failure. =A0With the o=
riginal
> patch, I'm not.

Now we know a driver without support for suspend/resume breaks suspend and
hibernate. We need to find out whether this is limited to btusb or everythi=
ng.

Can you test with anotherrrrr driver, like a mouse and remove suspend/resume
from usbhid? If this is specific to btusb we have a fix, if not, I am afraid
this has to be bisected.

	Regards
		Oliver
