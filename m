Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 00/14] Thermometer watchers API change + fixes
Date: Tue, 25 Sep 2012 16:52:29 +0200
Message-ID: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's series of patches to move watchers from per-device to per-adapter
interface (basically the same as done for HRP, see other series of patches).
This applies to both final and intermediate temperature watchers - once
watcher is registered, all connected devices are setup to send measurement
notifications and the opposite when last watcher is unregistered.

This major change is done in patches 1-6.

Patches 7-11 contain some code and documentation refactoring, i.e. to
remove duplicated code.

Patches 12-14 are trival coding style fixes.

Unfortunately, I wasn't able to fully test this code due to lack of proper
thermometer device and sample device from CC2540 devkit does not quite
work as expected (e.g. I can see CCC is written properly when watcher is
registered but remote does not send any indications for unknown reason).



Andrzej Kaczmarek (14):
  thermometer: Store thermometer devices per-adapter
  thermometer: Register ThermometerManager interface on adapter path
  thermometer: Move watcher logic to adapter interface
  thermometer: Include remote device information in MeasurementReceived
  thermometer: Update API document
  thermometer: Update test script
  thermometer: Reformat MeasurementReceived description
  thermometer: Update driver naming style
  thermometer: Add constant definition for watcher interface name
  thermometer: Add common function to write characteristics CCC
  thermometer: Refactor processing of measurement characteristic value
  thermometer: Fix whitespace
  thermometer: Fix indentation
  thermometer: Fix missing braces

 doc/thermometer-api.txt            | 126 +++++-----
 profiles/thermometer/manager.c     |  24 +-
 profiles/thermometer/thermometer.c | 486 +++++++++++++++++++++----------------
 profiles/thermometer/thermometer.h |   2 +
 test/test-thermometer              |  16 +-
 5 files changed, 372 insertions(+), 282 deletions(-)

-- 
1.7.11.3

