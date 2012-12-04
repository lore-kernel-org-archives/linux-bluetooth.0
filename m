Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 00/20] CSCP plugin
Date: Tue, 4 Dec 2012 13:43:26 +0100
Message-ID: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since v2:
- rebased to latest upstream master
- moved all code to cyclingspeed.c to avoid "empty" calls across files

No changes in functionality.


Andrzej Kaczmarek (20):
  cyclingspeed: Add CSC profile plugin skeleton
  cyclingspeed: Add attio callbacks
  cyclingspeed: Discover CSCS characteristics
  cyclingspeed: Discover characteristics CCC
  cyclingspeed: Read CSC Feature characteristic value
  cyclingspeed: Read Sensor Location characteristic value
  cyclingspeed: Add CyclingSpeedManager interface
  cyclingspeed: Add support to enable measurement notifications
  cyclingspeed: Process measurement notifications
  cyclingspeed: Add DBus.Properties for org.bluez.CyclingSpeed
    interface
  cyclingspeed: Add stub to use SC Control Point
  cyclingspeed: Add support for Request Supported Sensor Locations
  cyclingspeed: Add support for Update Sensor Location
  cyclingspeed: Add support for Set Cumulative Value
  core: Add CyclingSpeedWatcher interface to default policy
  doc: Remove Get-/SetProperties from CSC API document
  doc: Rename cycling API to cyclingspeed
  build: Add CSCP API document to EXTRA_DIST
  test: Add cyclingspeed test script
  test: Enable speed and cadence calculation in test-cyclingspeed

 Makefile.am                          |    8 +-
 Makefile.tools                       |    3 +-
 doc/cycling-api.txt                  |  118 ----
 doc/cyclingspeed-api.txt             |  100 +++
 lib/uuid.h                           |    6 +
 profiles/cyclingspeed/cyclingspeed.c | 1285 ++++++++++++++++++++++++++++++++++
 src/bluetooth.conf                   |    1 +
 test/test-cyclingspeed               |  191 +++++
 8 files changed, 1590 insertions(+), 122 deletions(-)
 delete mode 100644 doc/cycling-api.txt
 create mode 100644 doc/cyclingspeed-api.txt
 create mode 100644 profiles/cyclingspeed/cyclingspeed.c
 create mode 100755 test/test-cyclingspeed

-- 
1.8.0

