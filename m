Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Wed, 27 Aug 2008 15:28:47 +0200
Cc: Stefan Seyfried <seife@suse.de>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-pm@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 Pavel Machek <pavel@suse.cz>,
 linux-usb@vger.kernel.org
References: <200808221520.19791.oliver@neukum.org> <200808271504.56824.rjw@sisk.pl> <200808271509.06097.oliver@neukum.org>
In-Reply-To: <200808271509.06097.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808271528.48685.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday, 27 of August 2008, Oliver Neukum wrote:
> Am Mittwoch 27 August 2008 15:04:55 schrieb Rafael J. Wysocki:
> > I'm quite confident it's specific to bluetooth, because I only need to turn
> > the bluetooth user space off, most importantly hcid, to make the problem go
> > away even without the patch (that is, without the patch I don't even have to
> > uload btusb before suspend if the bluetoot user land is not running).
> 
> But do you use any other usb driver without support for suspend/resume?

Well, probably not.

I'll check the hid, then.

BTW, 2.6.26 appears to be fine.

Thanks,
Rafael
