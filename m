Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: question on timestamps generated with "hcidump -t"
Date: Thu, 5 Apr 2012 22:39:27 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <201204052100.17893.oliver@neukum.org> <1333654479.16897.17.camel@aeonflux>
In-Reply-To: <1333654479.16897.17.camel@aeonflux>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201204052239.27843.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, 5. April 2012, 21:34:39 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > could somebody enlighten me, when exactly those timestamps are generated?
> 
> they are normally stamped when they enter our internal queues. So the
> Bluetooth core stamps them when they come from the driver.

Thanks. That means if they come from btusb on ehci they are
stamped in interrupt.
So it is not possible that an event is late because the work queue
was congested.

	Regards
		Oliver
