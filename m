Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: James Baker <j.baker@outlook.com>
Date: Fri, 26 Jul 2013 00:42:34 +0100
Message-ID: <CAGoJ=AsOk=TPHoc3S+qs-0ukTjsf057cEA5DuMBp5zbsrz0AZg@mail.gmail.com>
Subject: Accessing information transmitted by Ble tag.
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As part of my summer placement, I've been introduced to some
non-connectable Ble tags. These are effectively beacons - advertising
and transmitting data every 250ms.

Now, this is where I'm less clear:
I am something of a bluetooth newbie as it were, but I know for sure
they're transmitting more than just the address and name of the device
(as displayed in hcidump when running hcitool lescan). I know this
because the data is picked up on an iPhone app I have lying around.

My question is, how would I read data from a connectionless Ble broadcaster?

I was originally looking for some kind of observer-broadcaster api and
in fact found patches on this list regarding it, and even an orphaned
branch at http://gitorious.org/~jdelfes/bluez/jdelfes-bluez/commits/bo-new,
but those APIs don't seem to have made it into the official
repository.

Do you know which part of the API I should start looking, or in which
one of the provided tools?

Sorry for any kind of trouble I may be causing.
Many thanks,

James
