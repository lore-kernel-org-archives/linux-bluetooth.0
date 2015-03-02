Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 2 Mar 2015 15:25:58 -0500
Message-ID: <CAGxYWpZ8cfgtdO8ZX39cPBOs4OZ=PaO5pOHotjBt0u7HsnVXFA@mail.gmail.com>
Subject: bt dongle goes awry after too many connections
From: Tim Tisdall <tisdall@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a "0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0" usb
bluetooth dongle I'm using to connect to multiple BLE devices.  It
used to be that I could connect to 7 devices with no issues and then
when I tried to connect to the 8th device I'd get a
CONNECTION_LIMIT_EXCEEDED error.  In my code I would then tag that
dongle as having a connection limit of 7 and limit the number of
connections.

Recently I was using this code and found that it no longer works.  The
dongle seems to "successfully" connect to ~13 devices but things don't
work properly.  At least half of the devices no longer respond to GATT
commands sent to it.  I issue a GATT command after connecting to each
device to read some attributes and most simply do nothing (no error,
no response, nothing).

Any way, I'm not really familiar with how things are laid out in the
kernel so I'm not really sure where that CONNECTION_LIMIT_EXCEEDED was
being created before and why it's no longer working as expected.  I
tried looking through the git logs in "btusb" and "bluetooth" modules
and didn't really see anything pertinent.

-Tim
