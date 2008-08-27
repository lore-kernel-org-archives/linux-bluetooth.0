Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-pm@lists.linux-foundation.org
Subject: Re: [linux-pm] btusb hibernation/suspend breakage in current -git
Date: Thu, 28 Aug 2008 00:33:06 +0200
Cc: Oliver Neukum <oliver@neukum.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org,
 Pavel Machek <pavel@suse.cz>,
 Stefan Seyfried <seife@suse.de>
References: <200808221520.19791.oliver@neukum.org> <200808271509.06097.oliver@neukum.org> <200808271528.48685.rjw@sisk.pl>
In-Reply-To: <200808271528.48685.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808280033.08006.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday, 27 of August 2008, Rafael J. Wysocki wrote:
> On Wednesday, 27 of August 2008, Oliver Neukum wrote:
> > Am Mittwoch 27 August 2008 15:04:55 schrieb Rafael J. Wysocki:
> > > I'm quite confident it's specific to bluetooth, because I only need to turn
> > > the bluetooth user space off, most importantly hcid, to make the problem go
> > > away even without the patch (that is, without the patch I don't even have to
> > > uload btusb before suspend if the bluetoot user land is not running).
> > 
> > But do you use any other usb driver without support for suspend/resume?
> 
> Well, probably not.
> 
> I'll check the hid, then.

I couldn't reproduce the breakage with suspend/resume support removed from
usbhid.

Let's just say it's related to BT, since your patch evidently fixes the problem
for me and I have just no reason to believe it's anything else than BT.

Thanks,
Rafael
