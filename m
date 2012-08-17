Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 00/10] GATT Plugin
Date: Fri, 17 Aug 2012 11:43:21 -0300
Message-Id: <1345214611-9071-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series adds a new GATT based plugin for GAP and GATT service.
The objective is cleanup: moving some GATT related operations from the
device(core) to a GATT based plugin.

This first part is related to GAP appearance characteristic. A second
patch will be sent soon to manage Service Changed and GATT/ATT MTU.

Changes from v1: Removes direct access to appearance storage.

Claudio Takahasi (10):
  gatt: Add Generic Access/Attribute Profile plugin
  gatt: Add GAP/GATT device registration
  core: Add device method to access "Appearance"
  gatt: Add read Appearance characteristic
  core: Remove Appearance characteristic read
  gatt: Emit PropertyChanged for Appearance
  core: PropertyChanged signal for Icon/class
  core: PropertyChanged signal for Icon/Appearance
  core: Add storing Appearance
  gatt: Map Appearance value 0x0000 to "unknown"

 Makefile.am             |    8 ++-
 profiles/gatt/gas.c     |  163 +++++++++++++++++++++++++++++++++++++++++++++++
 profiles/gatt/gas.h     |   25 +++++++
 profiles/gatt/main.c    |   52 +++++++++++++++
 profiles/gatt/manager.c |   82 ++++++++++++++++++++++++
 profiles/gatt/manager.h |   24 +++++++
 src/dbus-common.c       |    2 +
 src/device.c            |   98 ++++++++++++----------------
 src/device.h            |    2 +
 9 files changed, 399 insertions(+), 57 deletions(-)
 create mode 100644 profiles/gatt/gas.c
 create mode 100644 profiles/gatt/gas.h
 create mode 100644 profiles/gatt/main.c
 create mode 100644 profiles/gatt/manager.c
 create mode 100644 profiles/gatt/manager.h

-- 
1.7.8.6

