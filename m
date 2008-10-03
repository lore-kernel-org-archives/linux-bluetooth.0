Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Untrusted input devices by default
Date: Fri, 3 Oct 2008 08:51:29 -0500
Message-ID: <FA7963CC89065B49AED46A6F797F0FA6F286A4@AUSX3MPC128.aus.amer.dell.com>
References: <48E3F51B.6050001@dell.com><1223015855.11272.34.camel@violet.holtmann.net> <1223016791.3328.9.camel@macbook.infradead.org>
From: <Mario_Limonciello@Dell.com>
To: <dwmw2@infradead.org>,
	<marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David:

I have just verified myself this is still broke with a couple of input =
devices and some folks in Ubuntu are reporting it too.

I don't have a patch ATM, but I'll see what I can come up with.

Regards

Mario Limonciello=20
Dell | Linux Engineering=20
Mario_Limonciello@Dell.com=20



-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org on behalf of David Woodhouse
Sent: Fri 10/3/2008 1:53 AM
To: Marcel Holtmann
Cc: Limonciello, Mario; linux-bluetooth@vger.kernel.org
Subject: Re: Untrusted input devices by default
=20
On Fri, 2008-10-03 at 08:37 +0200, Marcel Holtmann wrote:
>=20
> > In my efforts to get BlueZ 4.x into Intrepid a question was posed.  =
How
> > come input devices don't default to "Trusted" when paired in the
> > Wizard?  This makes for a weird experience the next time you reboot =
(or
> > disconnect the device for that matter) that you need to give it
> > "authorization".
>=20
> that is a bug. We should set the input device as trusted after we
> connected to it. Any chance you have a patch for it?

I thought I was testing this a couple of weeks ago and it was working
fine.

--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

--
To unsubscribe from this list: send the line "unsubscribe =
linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
