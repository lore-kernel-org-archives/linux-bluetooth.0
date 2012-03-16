Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v3 0/6] Implement ProximityReporter profiles
Date: Fri, 16 Mar 2012 11:45:58 +0200
Message-Id: <1331891164-24588-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch-set implements the Link loss and Immediate Alert GATT
server profiles.

A few API calls are added/changed in preparation, the most notable of
which is the addition of the remote-device to each GATT read/write callback.

The new profiles are separated into their own files for clarity.

A ProximityReporter D-Bus interface is registered for each remote device.
Property queries and PropertyChanged notifications are implemented, in
accordance to doc/proximity-api.txt.

v2->3: Minor function renames and commit message changes

Arik Nemtsov (6):
  att: add remote btd_device to ATT read/write callbacks
  proximity: reporter: save global D-Bus connection
  proximity: reporter: move definitions to .h and add util function
  proximity: link loss: implement link loss server
  proximity: immediate alert: implement immediate alert server
  proximity: reporter: implement D-Bus API

 Makefile.am            |    4 +-
 attrib/att.h           |    6 +-
 plugins/gatt-example.c |    3 +-
 proximity/immalert.c   |  288 +++++++++++++++++++++++++++++++++++++++++
 proximity/immalert.h   |   26 ++++
 proximity/linkloss.c   |  336 ++++++++++++++++++++++++++++++++++++++++++++++++
 proximity/linkloss.h   |   26 ++++
 proximity/reporter.c   |  250 ++++++++++++++++++++++++++----------
 proximity/reporter.h   |   16 +++
 src/attrib-server.c    |   19 ++-
 time/server.c          |    6 +-
 11 files changed, 900 insertions(+), 80 deletions(-)
 create mode 100644 proximity/immalert.c
 create mode 100644 proximity/immalert.h
 create mode 100644 proximity/linkloss.c
 create mode 100644 proximity/linkloss.h

-- 
1.7.5.4

