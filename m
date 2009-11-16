Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>,
 Alan Stern <stern@rowland.harvard.edu>,
 USB list <linux-usb@vger.kernel.org>
Subject: Re: -rc6: something (probably active usb bluetooth) blocks suspend
Date: Mon, 16 Nov 2009 12:48:29 +0100
Cc: kernel list <linux-kernel@vger.kernel.org>,
 marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@sisk.pl>
References: <20091116112254.GB12315@elf.ucw.cz>
In-Reply-To: <20091116112254.GB12315@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911161248.29924.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag, 16. November 2009 12:22:54 schrieb Pavel Machek:

Hi Pavle,

first the obvious question. Does it work if you down the interface?
(not by killswitch)

> usb 5-1: usb suspend
> usb 5-1: usb auto-resume
> uhci_hcd 0000:00:1d.3: port 1 portsc 0095,01
> usb 5-1: finish resume
> uhci_hcd 0000:00:1d.3: reserve dev 2 ep81-INT, period 1, phase 0, 23
> us

Why is the device autoresumed here? Are you using autosuspend?
This is odd, as the freezer should block the send path and remote
wakeups should be deferred.

	Regards
		Oliver
