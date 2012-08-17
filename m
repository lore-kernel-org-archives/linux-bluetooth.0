Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 0/5] HoG Suspend/Resume
Date: Fri, 17 Aug 2012 18:08:18 -0300
Message-Id: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series adds HID Control Point support. This control point
allows the report host(BlueZ) to notify the report device(HoG device)
when the host is entering or leaving the Suspend Mode.

The low power Suspend Mode concept is implementation specific. This
proposal adds the support for UPower backend. UPower signals Resuming
/Sleeping are used to trigger the control point writing.

Claudio Takahasi (5):
  hog: Adds initial files for suspend support
  hog: Add UPower Resuming/Suspending watch
  hog: Add Suspend/Resume callbacks
  hog: Move HoG device list to manager
  hog: Add writting Control Point

 Makefile.am                  |    3 +-
 profiles/input/hog_device.c  |   73 ++++++++++++++++++++----------
 profiles/input/hog_device.h  |    9 +++-
 profiles/input/hog_manager.c |   69 ++++++++++++++++++++++++++++-
 profiles/input/upower.c      |  101 ++++++++++++++++++++++++++++++++++++++++++
 profiles/input/upower.h      |   29 ++++++++++++
 6 files changed, 254 insertions(+), 30 deletions(-)
 create mode 100644 profiles/input/upower.c
 create mode 100644 profiles/input/upower.h

-- 
1.7.8.6

