Return-Path: <cyrus@holtmann.org>
Subject: Re: [linux-pm] btusb hibernation/suspend breakage in current -git
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
	Stefan Seyfried <seife@suse.de>
In-Reply-To: <200808280917.57020.oliver@neukum.org>
References: <200808221520.19791.oliver@neukum.org>
	 <200808271528.48685.rjw@sisk.pl> <200808280033.08006.rjw@sisk.pl>
	 <200808280917.57020.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 08 Sep 2008 22:49:27 +0200
Message-Id: <1220906968.11655.7.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > I couldn't reproduce the breakage with suspend/resume support removed from
> > usbhid.
> > 
> > Let's just say it's related to BT, since your patch evidently fixes the problem
> > for me and I have just no reason to believe it's anything else than BT.
>
> Very good.
> 
> here it is again. You may need to cut the USB bits depending
> on which tree you want to apply it to.

do we have a version that could be applied to 2.6.27-rc5, because the
patch depends on unmerged USB stuff. I tend to leave this for 2.6.28 for
now.

Regards

Marcel


