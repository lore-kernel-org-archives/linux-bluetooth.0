Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 00/18] CSCP plugin
Date: Thu, 25 Oct 2012 16:43:30 +0200
Message-ID: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are patches to add cyclingspeed plugin which is CSC profile
implementation. All features for Collector Role are implemented.

It's not yet fully tested so sending this as RFC. Reason for this
is that PTS testcases for CSCP are buggy and I'm not able to verify
my implementation reliably. I already filled few issues and hopefully
they will be addressed soon.

Anyway, it works fine with Wahoo BlueSC (but it does not support all
features).

Comments are welcome.


Andrzej Kaczmarek (18):
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
  doc: Remove Get-/SetProperties from CSC API document
  cyclingspeed: Add stub to use SC Control Point
  cyclingspeed: Add support for Request Supported Sensor Locations
  cyclingspeed: Add support for Update Sensor Location
  cyclingspeed: Add support for Set Cumulative Value
  core: Add CyclingSpeedWatcher interface to default policy
  test: Add cyclingspeed test script
  doc: Rename cycling API to cyclingspeed

 Makefile.am                          |    9 +-
 Makefile.tools                       |    2 +-
 doc/cycling-api.txt                  |  118 ----
 doc/cyclingspeed-api.txt             |  100 +++
 lib/uuid.h                           |    6 +
 profiles/cyclingspeed/cyclingspeed.c | 1225 ++++++++++++++++++++++++++++++++++
 profiles/cyclingspeed/cyclingspeed.h |   26 +
 profiles/cyclingspeed/main.c         |   53 ++
 profiles/cyclingspeed/manager.c      |   96 +++
 profiles/cyclingspeed/manager.h      |   24 +
 src/bluetooth.conf                   |    1 +
 test/test-cyclingspeed               |  115 ++++
 12 files changed, 1654 insertions(+), 121 deletions(-)
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

