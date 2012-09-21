Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v7 00/13] Heart Rate Profile plugin
Date: Fri, 21 Sep 2012 17:15:57 +0200
Message-ID: <1348240570-7532-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since v6:
- rebased to latest upstream master
- fixed issues pointed out by Johan
  (except double const stuff as discussed on IRC)


Andrzej Kaczmarek (6):
  heartrate: Add attio callbacks
  heartrate: Discover HRS characteristics
  heartrate: Discover Heart Rate Measurement CCC
  heartrate: Add support to enable notifications
  heartrate: Process measurement notifications
  heartrate: Add support to reset Energy Expended

Rafal Garbat (6):
  heartrate: Add initial HRP client support
  heartrate: Read Body Sensor Location characteristics
  heartrate: Add HeartRateManager interface
  heartrate: Add GetProperties method
  heartrate: Add HeartRateWatcher interface to default policy
  heartrate: Add test script

Santiago Carot-Nemesio (1):
  Heart Rate Profile (HRP) client API

 Makefile.am                    |   9 +-
 Makefile.tools                 |   4 +-
 doc/heartrate-api.txt          |  84 +++++
 lib/uuid.h                     |   5 +
 profiles/heartrate/heartrate.c | 826 +++++++++++++++++++++++++++++++++++++++++
 profiles/heartrate/heartrate.h |  27 ++
 profiles/heartrate/main.c      |  52 +++
 profiles/heartrate/manager.c   |  93 +++++
 profiles/heartrate/manager.h   |  24 ++
 src/bluetooth.conf             |   1 +
 test/test-heartrate            | 103 +++++
 11 files changed, 1224 insertions(+), 4 deletions(-)
 create mode 100644 doc/heartrate-api.txt
 create mode 100644 profiles/heartrate/heartrate.c
 create mode 100644 profiles/heartrate/heartrate.h
 create mode 100644 profiles/heartrate/main.c
 create mode 100644 profiles/heartrate/manager.c
 create mode 100644 profiles/heartrate/manager.h
 create mode 100755 test/test-heartrate

-- 
1.7.11.3

