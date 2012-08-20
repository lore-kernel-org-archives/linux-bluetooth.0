Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 0/4] GATT & ATT cleanups
Date: Mon, 20 Aug 2012 14:32:18 -0300
Message-Id: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Minor GATT & ATT cleanups. Requires: "[PATCH BlueZ v0 00/10] GATT
plugin: Service Changed and MTU exchange"

Claudio Takahasi (4):
  att: Add Find Info Response Format constants
  att: Replace ATT magic number
  gatt: Return not found if characteritics is empty
  gatt: Don't raise error if declaration was found

 attrib/att.h                       |    4 ++++
 attrib/gatt.c                      |    7 ++++---
 profiles/gatt/gas.c                |    2 +-
 profiles/input/hog_device.c        |    2 +-
 profiles/thermometer/thermometer.c |    2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

-- 
1.7.8.6

