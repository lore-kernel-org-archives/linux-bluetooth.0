Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 0/6] HoG Suspend/Resume
Date: Mon,  3 Sep 2012 15:23:08 -0300
Message-Id: <1346696594-1062-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series adds HID Control Point support. This control point
allows the report host(BlueZ) to notify the report device(HoG device)
when the host is entering or leaving the Suspend Mode.

The low power Suspend Mode concept is implementation specific. This
proposal adds a selectable back-end for HoG Suspend/Resume control.
Each platform is free to write it's own HoG suspend back-end.
A dummy back-end based on a FIFO (/tmp/hogsuspend) is proposed for
reference and testing purpose only. Writting "suspend" or "resume"
in this FIFO will trigger the update of the HID Control Point.

Notify the HoG device is useful to save power. Devices can implement
different actions (diff than disconnect) when commands are written
on the HID control point. The HoG capable device cab reduce the key
press detection frequency or disable LEDs.

*** v1 changes:
Replaces UPower by a dummy selectable back-end. As discussed in IRC
tracking UPower "suspending" or "resuming" signals are not suitable
for desktops since the connection is dropped right after detecting
suspend.

*** v2 changes:
Code rebased and fixed conflicts with the recent changes. Due the
new profile abstraction (btd_device drivers replaces) v1 doesn't apply.

Claudio Takahasi (6):
  hog: Add initial files for suspend support
  hog: Add suspend back-end selection
  hog: Add suspend/resume callbacks declaration
  hog: Create a FIFO for dummy suspend
  hog: Move HoG device list to manager
  hog: Add writting Control Point

 Makefile.am                    |   6 +-
 acinclude.m4                   |   7 ++
 profiles/input/hog_device.c    |  73 ++++++++++++++-------
 profiles/input/hog_device.h    |   9 ++-
 profiles/input/hog_manager.c   |  62 ++++++++++++++++-
 profiles/input/suspend-dummy.c | 146 +++++++++++++++++++++++++++++++++++++++++
 profiles/input/suspend.h       |  29 ++++++++
 7 files changed, 302 insertions(+), 30 deletions(-)
 create mode 100644 profiles/input/suspend-dummy.c
 create mode 100644 profiles/input/suspend.h

-- 
1.7.12

