Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 00/10] GAP Plugin
Date: Wed, 15 Aug 2012 11:19:57 -0300
Message-Id: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series adds a new GATT based plugin for GAP service. The
objective is cleanup: moving some GATT related operations from the
device(core) to a GATT based plugin.

Claudio Takahasi (10):
  gap: Add Generic Access Profile plugin skeleton
  gap: Add GAP device registration
  gap: Add read Appearance characteristic
  gap: Add storing Appearance
  core: Remove Appearance characteristic read
  gap: Emit PropertyChanged for Appearance
  core: PropertyChanged signal for Icon/class
  core: PropertyChanged signal for Icon/Appearance
  gap: Map Appearance value 0x0000 to unknown
  gap: Don't store Appearance if value is "unknown"

 Makefile.am            |    7 ++-
 profiles/gap/gap.c     |  174 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/gap/gap.h     |   24 +++++++
 profiles/gap/main.c    |   52 ++++++++++++++
 profiles/gap/manager.c |   75 +++++++++++++++++++++
 profiles/gap/manager.h |   24 +++++++
 src/dbus-common.c      |    2 +
 src/device.c           |   74 +++++---------------
 src/device.h           |    1 +
 9 files changed, 376 insertions(+), 57 deletions(-)
 create mode 100644 profiles/gap/gap.c
 create mode 100644 profiles/gap/gap.h
 create mode 100644 profiles/gap/main.c
 create mode 100644 profiles/gap/manager.c
 create mode 100644 profiles/gap/manager.h

-- 
1.7.8.6

