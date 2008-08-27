Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Wed, 27 Aug 2008 15:09:05 +0200
Cc: Stefan Seyfried <seife@suse.de>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-pm@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 Pavel Machek <pavel@suse.cz>,
 linux-usb@vger.kernel.org
References: <200808221520.19791.oliver@neukum.org> <200808270955.12511.oliver@neukum.org> <200808271504.56824.rjw@sisk.pl>
In-Reply-To: <200808271504.56824.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808271509.06097.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Mittwoch 27 August 2008 15:04:55 schrieb Rafael J. Wysocki:
> I'm quite confident it's specific to bluetooth, because I only need to turn
> the bluetooth user space off, most importantly hcid, to make the problem go
> away even without the patch (that is, without the patch I don't even have to
> uload btusb before suspend if the bluetoot user land is not running).

But do you use any other usb driver without support for suspend/resume?

	Regards
		Oliver
