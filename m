Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 00/20] CSCP plugin
Date: Mon, 5 Nov 2012 09:54:45 +0100
Message-ID: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are v2 patches for CSC profile implementation (cyclingspeed plugin).

Changes since v1:
- signal is emited when Location property is changed
- supported locations CP procedure is done only once (see notes below)
- test script can now calculate instantenous speed and cadence
- few minor fixes found during testing and review

It's now also tested with PTS - can pass all CSCP testcases but there are
few things to remember if someone want to retest:
- testcases in 4.5.3 are broken, look into erratas for updated ets file
- TP/SPL/CO/BV-01-I shall be run after device is removed because Request
  Supported Sensor Location procedure is done only once and then result
  is cached - this is because running it every time device is connected
  will make other testcases using SC Control Point fail due to unexpected
  opcode written (and CSCP spec requires this value to be cached anyway)
- as for now watcher shall be registered before running testcases using
  SC Control Point to make them work - this is because PTS expects that
  measurement notifications are enabled before control point indications,
  otherwise it will wait for writing control point CCC even though it
  was written before. Errata for this is already accepted and TS will be
  changed so both CCC can be written in any order.
- TP/SPS/CO/BV-02-I seems to be broken as it expected different value to
  be written than what is displayed to tester - issue in PTS for this is
  in progress


Comments are welcome.


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

 Makefile.am                          |   11 +-
 Makefile.tools                       |    2 +-
 doc/cycling-api.txt                  |  118 ----
 doc/cyclingspeed-api.txt             |  100 +++
 lib/uuid.h                           |    6 +
 profiles/cyclingspeed/cyclingspeed.c | 1237 ++++++++++++++++++++++++++++++++++
 profiles/cyclingspeed/cyclingspeed.h |   26 +
 profiles/cyclingspeed/main.c         |   53 ++
 profiles/cyclingspeed/manager.c      |   96 +++
 profiles/cyclingspeed/manager.h      |   24 +
 src/bluetooth.conf                   |    1 +
 test/test-cyclingspeed               |  191 ++++++
 12 files changed, 1743 insertions(+), 122 deletions(-)
 delete mode 100644 doc/cycling-api.txt
 create mode 100644 doc/cyclingspeed-api.txt
 create mode 100644 profiles/cyclingspeed/cyclingspeed.c
 create mode 100644 profiles/cyclingspeed/cyclingspeed.h
 create mode 100644 profiles/cyclingspeed/main.c
 create mode 100644 profiles/cyclingspeed/manager.c
 create mode 100644 profiles/cyclingspeed/manager.h
 create mode 100755 test/test-cyclingspeed

-- 
1.8.0

