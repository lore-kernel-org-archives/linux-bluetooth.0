Return-Path: <cyrus@holtmann.org>
Subject: Re: fix bug in suspend/resume code of btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200810022232.07165.oliver@neukum.org>
References: <200810022232.07165.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 08:34:36 +0200
Message-Id: <1223015676.11272.27.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> this fixes an issue in btusb's suspend/resume support that strikes if
> the adapter is suspended while the hci is down.
> This probably fixes the bug Pavel sees with autosuspend and fixes a bug
> for me. I am currently looking at issues with new hardware, but with this patch
> it should work at least for the best hardware.
> 
> What tree should I base a clean patch against?

give me the weekend to sort out the trees. I want to get two extra fixes
into 2.6.27-rc9 and then we can start working on the suspend stuff for
2.6.28. I have pending patches that your patches should be based on so
we have a clean revision history and see how the evolved. I really hated
the quick fixing inside hci_usb and nobody ever could figure out what
actually made it work and what not.

Regards

Marcel


