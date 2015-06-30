Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 30 Jun 2015 10:34:52 +0200
Message-ID: <CAAUgxQLMfO4_RhhH+3DcpWw-pijw0PnBXrikhcUawycXh9ME2g@mail.gmail.com>
Subject: BCM4334x - BTLE - multiple packets per connection event
From: Krzysiek Rosinski <krzysiek@jrdltd.co.uk>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

The question which I'm going to ask is not fully related to bluez.
Sorry about that,- there is no other place I could ask this and
hopefully someone from bluez community could give us a hint.

We're using Intel Edison with BCM4334x (configured as a central role)
to receive notifications from nRF51 peripheral.

We're trying to achieve the highest possible throughput, so we've set
up connection interval to 7.5 ms. The nRF51 supports up to 6 packets
per connection event (each packet has 20 B for data) which gives
theoretical throughput of:

20B / 7.5ms * 6 =  16000 B/s

We've tested nRF51 using other BT LE dongle and this indeed works as
expected, unfortunately when we try to receive this stream using
BCM4334x we get only 2667 B/s which corresponds to 1 packet per
connection event.

I suspect that such timing is implemented in the BCM4334x firmware
part which is closed source and I have only binary of version, the
driver is available as open source but I couldn't find anything useful
to fix my issue there:

https://github.com/01org/edison-firmware
https://github.com/01org/edison-bcm43340

We've been trying to sign NDA with Broadcom but it's not possible if
you don't buy thousands of chips...

I'd be appreciated for any hint regarding this issue.

Many thanks,
Krzysztof Rosiński
