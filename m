Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Dec 2008 14:22:05 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: /var/lib/bluetooth/$BDADDR/names, when does that file get
	updated?
Message-ID: <20081222132205.GC7064@vanheusden.com>
References: <20081212180131.GI19659@vanheusden.com> <1229713194.879.10.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1229713194.879.10.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

> > When does /var/lib/bluetooth/$BDADDR/names get updated?
> > Because hcitool inq does not tell the names while hcitool scan does not
> > tell class of the devices.
> every time a HCI remote name complete event is received. Or in case of
> Bluetooth 2.1 when an Extended Inquiry Result with name information is
> recieved.

Ah ok.

F.y.i.: I was trying to monitor 24/7 if a bluetooth device with a specific
mac-address and device-name was in reach of the system with that bluetooth-
dongle. Worked like a charm but unfortunately these usb-dongles die
(brakedown) in a couple of days.


Folkert van Heusden

-- 
MultiTail cok yonlu kullanimli bir program, loglari okumak, verilen
kommandolari yerine getirebilen. Filter, renk verme, merge, 'diff-
view', vs.  http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
