Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 May 2016 15:06:25 -0700
Message-ID: <CAE1tnCy4qcTmwxj_rnpxC3yFFgU2bOPA94WJeuvatNjWU-wu8A@mail.gmail.com>
Subject: Disabling passive scanning for LE connections
From: mike mike <majormail999@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> All LE connections are now triggered through a preceding passive scan
> and waiting for a connectable advertising report. This means we've got
> the best possible guarantee that the device is within range and should
> be able to request the controller to perform continuous scanning. This
> way we minimize the risk that we miss out on any advertising packets.

My code manages 100's of BLE devices with long advertising periods.
I need to connect to devices (sometime multiples devices at the same
time) as quickly as possible.  My current implementation usually catches
and connects to the first advertising event (average connect time is < 7
seconds)

I have my own code using the HCI interface for doing this.  This code
has worked well for a while, but since the passive LE scanning was
added as part of the kernel connection processes (kernel 4.4.4?) I
have a problems with the process:

- occasionally conflicting with my access to the whitelist
- occasionally deleting all entries in my whitelist.

Is it possible to disable passive scanning, or will I need a kludge to
catch and work around these events?
