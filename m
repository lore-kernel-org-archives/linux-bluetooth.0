Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 0/2] GATT/ATT Cleanup
Date: Thu, 22 Mar 2012 15:24:38 +0200
Message-Id: <1332422680-20162-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Move gatt related primary and characteristic definitions
from the att.h to gatt.h (ATT does not define services and)
characteristics - those are GATT terms.

Chen Ganir (2):
  GATT: Rename service and char structs
  GATT: replace start/end with att_range

 attrib/att.h         |   13 -------------
 attrib/client.c      |   22 +++++++++++-----------
 attrib/gatt.c        |   12 ++++++------
 attrib/gatt.h        |   12 ++++++++++++
 attrib/gatttool.c    |    6 +++---
 attrib/interactive.c |    6 +++---
 src/adapter.c        |   11 ++++++-----
 src/device.c         |   14 +++++++-------
 8 files changed, 48 insertions(+), 48 deletions(-)

-- 
1.7.4.1

