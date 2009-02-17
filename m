Return-Path: <cyrus@holtmann.org>
Subject: Re: How to automatically initiate sniff mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960902161542j7d0826b7qbcbcb914fa706d15@mail.gmail.com>
References: <35c90d960902161542j7d0826b7qbcbcb914fa706d15@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 17 Feb 2009 03:37:05 +0100
Message-Id: <1234838225.13496.20.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> We have come across a headset (HTC M200) that does not send out a
> sniff mode request when in idle. Our Bluez based stack also does not
> send a sniff mode request, so we sit in a higher power state that
> necessary. (20mA instead of 1mA).
> 
> Some quick research suggests that we would need to send HCI Sniff Mode
> Command (OCF 0x03) to initiate sniff mode, and that this is not yet
> done in the Bluez code base. We do send the HCI Write Default Link
> Policy Settings Command but, as I understand, this is only applied to
> incoming sniff mode requests by the link manager and will not initiate
> an LMP sniff request.
> 
> We compared to two non-bluez mobile stacks and found the other phones
> did automatically initiate an LMP sniff mode request.
> 
> Is there a reason for Bluez not automatically sending HCI Sniff Mode
> Command, or is it just a case of no-one getting around to hitting the
> problem / implementing a fix? Or have I missed something simple?

actually BlueZ has automatically sniff mode since a long-long time ago.
It also would do sniff-subrate in case of Bluetooth 2.1 modules. However
you have to enable it since by default it is off.

Check /sys/class/bluetooth/hci0 for idle_timeout, sniff_max_interval and
sniff_min_interval. Use idle_timeout and the others to control the
interval values.

Regards

Marcel


