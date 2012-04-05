Return-Path: <cyrus@holtmann.org>
Message-ID: <1333663889.16897.18.camel@aeonflux>
Subject: Re: question on timestamps generated with "hcidump -t"
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Apr 2012 15:11:29 -0700
In-Reply-To: <201204052239.27843.oliver@neukum.org>
References: <201204052100.17893.oliver@neukum.org>
	 <1333654479.16897.17.camel@aeonflux> <201204052239.27843.oliver@neukum.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > could somebody enlighten me, when exactly those timestamps are generated?
> > 
> > they are normally stamped when they enter our internal queues. So the
> > Bluetooth core stamps them when they come from the driver.
> 
> Thanks. That means if they come from btusb on ehci they are
> stamped in interrupt.
> So it is not possible that an event is late because the work queue
> was congested.

not that I can tell. And yes, in case of USB they are stamped in
interrupt.

But with USB keep in mind that HCI events and HCI ACL data is on
different endpoints.

Regards

Marcel


