Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v2 0/2] GATT/ATT Cleanup
Date: Mon, 26 Mar 2012 09:35:57 +0200
Message-Id: <1332747359-15647-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Move gatt related primary and characteristic definitions
from the att.h to gatt.h (ATT does not define services and
characteristics - those are GATT terms).

This is v2 of the patch set, fixing compilation errors.

Chen Ganir (2):
  GATT: Rename service and char structs
  GATT: replace start/end with att_range

 attrib/att.h              |   13 -------------
 attrib/client.c           |   22 +++++++++++-----------
 attrib/gatt.c             |   12 ++++++------
 attrib/gatt.h             |   12 ++++++++++++
 attrib/gatttool.c         |    6 +++---
 attrib/interactive.c      |    6 +++---
 proximity/manager.c       |    6 ++++--
 proximity/monitor.c       |   22 +++++++++++-----------
 proximity/monitor.h       |    4 ++--
 src/adapter.c             |   11 ++++++-----
 src/device.c              |   14 +++++++-------
 thermometer/manager.c     |    6 ++++--
 thermometer/thermometer.c |   12 ++++++------
 thermometer/thermometer.h |    2 +-
 14 files changed, 76 insertions(+), 72 deletions(-)

-- 
1.7.4.1

