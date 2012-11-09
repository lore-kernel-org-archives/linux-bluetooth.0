Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 00/15] thermometer plugin updates
Date: Fri, 9 Nov 2012 09:55:42 +0100
Message-ID: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are few patches to update thermometer plugin with features already
implemented in other plugins:
- store attributes handles directly in thermometer structure instead of
  nested lists of structures which we need to traverse later (and we
  only need 3 handles stored to support all use cases)
- register attio handlers for specific handles instead of one ind and
  notif handler globally
- change properties handling to DBus.Properties
- and some minor fixes

This is tested with PTS 4.5.3. There's only problem with patch #9 which
"breaks" testcase TP/THF/CO/BV-09-I - this is because PTS sends invalid
properties for Measurement Interval characteristic (it does not have
indicate property so we do not register ind handler for it). I already
filled issue on PTS.

Comments are welcome.


Andrzej Kaczmarek (15):
  thermometer: Store Temperature Measurement CCC handle in struct
  thermometer: Store Intermediate Temperature CCC handle in struct
  thermometer: Store Measurement Interval value handle in struct
  thermometer: Use dedicated handler for Intermediate Temperature
  thermometer: Use dedicated handler for Temperature Measurement
  thermometer: Use dedicated handler for Measurement Interval
  thermometer: Remove descriptor structure
  thermometer: Remove storage of all discovered characteristics
  thermometer: Discover Measurement Interval descriptors only if needed
  thermometer: Always write CCC value when connecting
  thermometer: Make temp_type array static
  thermometer: Add DBus.Properties support
  thermometer: Remove legacy properties code
  doc: Update thermometer API document
  test: Update test-thermometer for DBus.Properties

 doc/thermometer-api.txt            |   18 -
 profiles/thermometer/thermometer.c | 1008 +++++++++++++++++-------------------
 test/test-thermometer              |   13 +-
 3 files changed, 478 insertions(+), 561 deletions(-)

-- 
1.8.0

