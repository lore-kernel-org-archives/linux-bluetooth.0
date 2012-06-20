Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 00/10] ATT MTU: cosmetic changes
Date: Wed, 20 Jun 2012 14:27:42 -0300
Message-Id: <1340213272-2853-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series contains minor improvements related to ATT MTU and
GAttrib buffer usage.

Claudio Takahasi (10):
  ATT: Avoid invalid memory access for large PDU
  dis: Reduce array size for PnP ID
  thermometer: Use GAttrib buffer
  gatttool: Use GAttrib buffer
  thermometer: Reduce the array for Valid Range
  thermometer: Reduce the array for temperature type
  thermometer: Reduce array size for Measurement Interval
  proximity: Reduce array size for Tx Power Level
  generic attribute: Use GAttrib buffer
  attrib-server: Fix MTU for GATT

 attrib/att.c              |   17 +++++++++--------
 attrib/att.h              |    2 +-
 attrib/client.c           |    6 ++++--
 attrib/gatttool.c         |   13 +++++++++----
 attrib/interactive.c      |   12 ++++++++----
 deviceinfo/deviceinfo.c   |    9 ++++++---
 proximity/monitor.c       |   10 ++++++----
 src/attrib-server.c       |    2 +-
 thermometer/thermometer.c |   31 ++++++++++++++++++++-----------
 9 files changed, 64 insertions(+), 38 deletions(-)

-- 
1.7.8.6

