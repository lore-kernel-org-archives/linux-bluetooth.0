Return-Path: <cyrus@holtmann.org>
Message-ID: <1341924051.31958.10.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add MacBookPro10,1 support
From: Marcel Holtmann <marcel@holtmann.org>
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Jul 2012 09:40:51 -0300
In-Reply-To: <20120709202410.GA817@polaris.bitmath.org>
References: <1341856347-257-1-git-send-email-rydberg@euromail.se>
	 <20120709184824.GA21411@x220> <20120709192529.GA712@polaris.bitmath.org>
	 <20120709194947.GA17281@joana> <20120709202410.GA817@polaris.bitmath.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Henrik,

> > > > I believe the requirement is to always include a usb-devices output in
> > > > the commit message (to let maintainers confirm that no typo has occurred
> > > > in the patch itself).
> > 
> > If you don't have access to the device I can take it without usb-devices,
> > otherwise just add it to the patch and then resend.
> 
> I don't, but I trust that this patch is authentic.

the requirement is to have either /sys/kernel/debug/usb/devices section
or usb-devices output included in the commit message. No exceptions. I
want to have this documented in case any questions about it ever arises.

Regards

Marcel


