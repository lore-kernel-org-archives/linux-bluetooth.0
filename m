Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] DBus OutOfBand API update
Date: Wed, 25 Jul 2012 16:25:07 +0200
Message-ID: <1343226308-443-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is an initial proposal for dbus oob api update for 5.0.
I tried to include all comments from previous discussions.

I was trying to keep dictionary keys close to what is described in "Bluetooth
Secure Simple Pairing Using NFC" whitepaper. But EIR can have other data as well
e.g. short name instead of full name, should we distinguish that to know if name
resolution should be done in band? Or is this overkill?
What about EIR flags? Is it usefull in any sense?

Adding data result in DeviceFound signal being emitted, should DeviceDisappeared
be emitted when removing oob data (if device was found via oob)?

Also, should oob interface be disabled for 2.0 (and for >2.1 with ssp
disabled) adapters?


Comments?

-- 
BR
Szymon Janc

Szymon Janc (1):
  dbusoob: Update API

 doc/oob-api.txt |   57 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

-- 
1.7.9.5

