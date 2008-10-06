Return-Path: <cyrus@holtmann.org>
Subject: Re: fix bug in suspend/resume code of btusb
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200810022232.07165.oliver@neukum.org>
References: <200810022232.07165.oliver@neukum.org>
Content-Type: text/plain
Date: Mon, 06 Oct 2008 13:09:11 +0200
Message-Id: <1223291351.11272.156.camel@violet.holtmann.net>
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

can you send patches against my bluetooth-testing tree:

http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-testing.git;a=summary

Regards

Marcel


