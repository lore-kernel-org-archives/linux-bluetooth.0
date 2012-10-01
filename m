Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 00/15] Thermometer watchers API changes + fixes
Date: Mon, 1 Oct 2012 11:23:42 +0200
Message-ID: <1349083437-23528-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since v1:
- fixed inconsistencies and issues in API document formatting
- changed string properties to lower-case (new patch)


Andrzej Kaczmarek (15):
  thermometer: Store thermometer devices per-adapter
  thermometer: Register ThermometerManager interface on adapter path
  thermometer: Move watcher logic to adapter interface
  thermometer: Include remote device information in MeasurementReceived
  thermometer: Update API document
  thermometer: Update test script
  thermometer: Reformat MeasurementReceived description
  thermometer: Change string properties to lower-case
  thermometer: Update driver naming style
  thermometer: Add constant definition for watcher interface name
  thermometer: Add common function to write characteristics CCC
  thermometer: Refactor processing of measurement characteristic value
  thermometer: Fix whitespace
  thermometer: Fix indentation
  thermometer: Fix missing braces

 doc/thermometer-api.txt            | 127 ++++-----
 profiles/thermometer/manager.c     |  24 +-
 profiles/thermometer/thermometer.c | 512 +++++++++++++++++++++----------------
 profiles/thermometer/thermometer.h |   2 +
 test/test-thermometer              |  16 +-
 5 files changed, 386 insertions(+), 295 deletions(-)

-- 
1.7.11.3

