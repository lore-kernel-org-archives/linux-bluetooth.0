Return-Path: <cyrus@holtmann.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Tue, 26 Aug 2008 12:10:08 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 linux-pm@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
 Pavel Machek <pavel@suse.cz>,
 linux-usb@vger.kernel.org,
 Stefan Seyfried <seife@suse.de>
References: <200808221520.19791.oliver@neukum.org> <200808261136.05666.rjw@sisk.pl> <200808261143.20459.oliver@neukum.org>
In-Reply-To: <200808261143.20459.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808261210.09665.rjw@sisk.pl>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday, 26 of August 2008, Oliver Neukum wrote:
> Am Dienstag 26 August 2008 11:36:04 schrieb Rafael J. Wysocki:
> > [Sorry for the delayed reply.]
> >=20
> > On Monday, 25 of August 2008, Oliver Neukum wrote:
> > > Am Montag 25 August 2008 13:54:31 schrieb Marcel Holtmann:
> > > > Oliver, can you come up with a small test patch, that just kills al=
l =A0
> > > > URB when suspend and submits the interrupt ones at resume. Such a =
=A0
> > > > patch might have to be merged for 2.6.27 if it fixes this problem.
> > >=20
> > > Rafael,
> > >=20
> > > this patch implemts suspend/resume for btusb and fixes a disconnect
> > > problem. Does it help you?
> >=20
> > Yes, the patch appears to help.
> >=20
> > I haven't had a single crash since I applied it.  I'm going to test it =
a bit
> > more today, though.
>=20
> Good. Can you test what happens if you unplug the device while suspended
> and hibernated?

It's built-in, I can't unplug it. :-)

Thanks,
Rafael
