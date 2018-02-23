Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1519385080.29059.4.camel@hadess.net>
Subject: bluetoothd Discovery caching changes?
From: Bastien Nocera <hadess@hadess.net>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Date: Fri, 23 Feb 2018 12:24:40 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

Some time ago, it seems that bluetoothd's caching got more aggressive,
and I now end up with devices listed in GNOME's Bluetooth Settings that
never seem to go away, including ones without any service or type data.

I usually have devices where pairing was attempted without success, or
were used once but not paired or trusted, being stuck in the list.
Discovered devices also stay around for a long time.

This causes problems in busy environment, as despite security advices,
tons of Bluetooth devices are visible in offices, and half-discovered
(got a bdaddr, but no SDP info) devices are still visible long after
they're gone.

Is this the expected behaviour? If we had information about when the
device was discovered, or when it was added, it would make it easier to
clean up that cache in the front-ends.

Cheers
