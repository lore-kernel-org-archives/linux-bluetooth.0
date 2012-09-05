Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 00/17] Heart Rate Profile plugin
Date: Wed, 5 Sep 2012 15:05:31 +0200
Message-ID: <1346850348-21176-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's v2 of HRP plugin implementation. Changes from v1 include:
- update to btd_profile
- API change: make watchers per-adapter instead of per-device
  there's new interface registered for adapter HeartRateManager to (un)register
  watchers and MeasurementReceived method in HeartRateWatcher interface has
  additional parameter with device object path
- API change: make "Location" device property
  "Location" is now device property, previously it was send with every single
  measurement which does not make sense since it's not part of measurement
  (unlike Temperature Type in HTP) and cannot change
- other small fixes and some refactoring so patches can be split better

Comments are welcome.


Andrzej Kaczmarek (6):
  heartrate: Add attio callbacks
  heartrate: Enable measurement when watchers are registered
  heartrate: Read Heart Rate Control Point characteristics
  heartrate: Handle characteristics value changed notification
  heartrate: Process Heart Rate Measurement characteristics
  heartrate: Add Reset method

Rafal Garbat (10):
  heartrate: Add Heart Rate Profile client
  heartrate: Discover characteristics
  heartrate: Process characteristics
  heartrate: Discover characteristics descriptors
  heartrate: Process characteristics descriptors
  heartrate: Add HeartRateManager interface
  heartrate: Read Body Sensor Location characteristics
  heartrate: Add GetProperties method
  heartrate: Add HeartRateWatcher interface to default policy
  heartrate: Add test script

Santiago Carot-Nemesio (1):
  Heart Rate Profile API

 Makefile.am                    |   9 +-
 Makefile.tools                 |   4 +-
 doc/heartrate-api.txt          |  83 ++++
 lib/uuid.h                     |   5 +
 profiles/heartrate/heartrate.c | 971 +++++++++++++++++++++++++++++++++++++++++
 profiles/heartrate/heartrate.h |  27 ++
 profiles/heartrate/main.c      |  52 +++
 profiles/heartrate/manager.c   |  95 ++++
 profiles/heartrate/manager.h   |  24 +
 src/bluetooth.conf             |   1 +
 test/test-heartrate            | 103 +++++
 11 files changed, 1370 insertions(+), 4 deletions(-)
 create mode 100644 doc/heartrate-api.txt
 create mode 100644 profiles/heartrate/heartrate.c
 create mode 100644 profiles/heartrate/heartrate.h
 create mode 100644 profiles/heartrate/main.c
 create mode 100644 profiles/heartrate/manager.c
 create mode 100644 profiles/heartrate/manager.h
 create mode 100755 test/test-heartrate

-- 
1.7.11.3

