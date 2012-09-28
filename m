Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 0/4] Remove profile specific storage
Date: Fri, 28 Sep 2012 17:01:30 -0300
Message-Id: <1348862494-16911-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the current implementation it is not possible to detect in the
profile driver remove callback if the device is being removed from
the system or if bluetoothd is exiting.

This patch series allows the profile to identify when a given device
is being removed from the system, allowing the profiles to execute
actions or remove stored data before being removed.

Another possible approach could be add a new callback in the profile
indicating that the device is being removed.

There is also a TODO file item: "Convert storage to user per-remote
device directories and ini-file format". What is the idea? Should the
core remove everything under the remote device address directory?

Claudio Takahasi (4):
  core: Add purge parameter to profile remove
  proximity: Remove alert level storage
  proximity: Store Bluetooth Address type
  gatt: Remove Service Changed handle from storage

 audio/manager.c                |  3 ++-
 profiles/deviceinfo/manager.c  |  2 +-
 profiles/gatt/gas.c            | 26 +++++++++++++++++++++++++-
 profiles/gatt/gas.h            |  2 +-
 profiles/gatt/manager.c        |  4 ++--
 profiles/health/hdp_manager.c  |  3 ++-
 profiles/heartrate/manager.c   |  2 +-
 profiles/input/hog_manager.c   |  3 ++-
 profiles/input/manager.c       |  3 ++-
 profiles/network/manager.c     |  3 ++-
 profiles/proximity/manager.c   |  4 ++--
 profiles/proximity/monitor.c   | 41 +++++++++++++++++++++++++++++------------
 profiles/proximity/monitor.h   |  2 +-
 profiles/proximity/reporter.c  |  3 ++-
 profiles/proximity/reporter.h  |  3 ++-
 profiles/scanparam/manager.c   |  3 ++-
 profiles/thermometer/manager.c |  2 +-
 src/device.c                   | 26 +++++++++++++++++---------
 src/profile.h                  |  2 +-
 19 files changed, 97 insertions(+), 40 deletions(-)

-- 
1.7.12

