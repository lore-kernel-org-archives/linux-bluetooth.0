Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 0/3] Implement TPS profile
Date: Sun, 11 Mar 2012 11:23:16 +0200
Message-Id: <1331457799-26506-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We replace the TPS stub in reporter.c with a fully functional
implementation. The Tx power level for each LE device is read on
connection and cached (as it cannot change). When a remote device
requests it the cached value is returned.

This series depends on the kernel patch:
"Bluetooth: Implement Read Transmit Power Level command"

It also depends the bluez series "Implement ProximityReporter profiles",
mostly for the ATT patch adding the remote-device to each ATT read/write
callback.

Arik Nemtsov (3):
  mgmt: implement read tx power
  adapter: implement API to read Tx power
  proximity: tx power: implement tx power server

 Makefile.am          |    3 +-
 lib/mgmt.h           |   11 ++
 plugins/mgmtops.c    |   64 +++++++++++
 proximity/reporter.c |   48 +--------
 proximity/txpower.c  |  292 ++++++++++++++++++++++++++++++++++++++++++++++++++
 proximity/txpower.h  |   24 ++++
 src/adapter.c        |   75 +++++++++++++
 src/adapter.h        |   17 +++
 8 files changed, 488 insertions(+), 46 deletions(-)
 create mode 100644 proximity/txpower.c
 create mode 100644 proximity/txpower.h

-- 
1.7.5.4

