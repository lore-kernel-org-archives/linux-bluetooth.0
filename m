Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 16 Feb 2009 15:42:42 -0800
Message-ID: <35c90d960902161542j7d0826b7qbcbcb914fa706d15@mail.gmail.com>
Subject: How to automatically initiate sniff mode
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We have come across a headset (HTC M200) that does not send out a
sniff mode request when in idle. Our Bluez based stack also does not
send a sniff mode request, so we sit in a higher power state that
necessary. (20mA instead of 1mA).

Some quick research suggests that we would need to send HCI Sniff Mode
Command (OCF 0x03) to initiate sniff mode, and that this is not yet
done in the Bluez code base. We do send the HCI Write Default Link
Policy Settings Command but, as I understand, this is only applied to
incoming sniff mode requests by the link manager and will not initiate
an LMP sniff request.

We compared to two non-bluez mobile stacks and found the other phones
did automatically initiate an LMP sniff mode request.

Is there a reason for Bluez not automatically sending HCI Sniff Mode
Command, or is it just a case of no-one getting around to hitting the
problem / implementing a fix? Or have I missed something simple?

Cheers,
Nick
