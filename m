Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 00/14] Userspace patches for RSSI threshold monitor
Date: Tue,  9 Aug 2011 18:00:27 -0300
Message-Id: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dependency: kernel patches sent from Anderson Briglia implementing the
RSSI threshold monitor in the kernel: "[PATCH 0/7] RSSI Monitor"

The following patches are implementing the userspace functions to handle
RSSI threshold monitor, required for Proximity Path Loss. The mgmt-api
changes was proposed by: "[PATCH] Add RSSI Monitor documentation API"
(sent to ML)

Initial RFC of this patch series: "[RFC BlueZ 0/8] Userspace patches
for RSSI threshold monitor".

Changes since the RFC: Included changes in the Proximity Monitor.
Initial RFC was including changes in the mgmtops and adapter only.

Claudio Takahasi (14):
  Add RSSI threshold monitor definition in mgmt
  Add RSSI threshold monitor implementation
  Add enable RSSI threshold monitoring
  Return FALSE if RSSI monitor is already enabled
  Add disable for RSSI threshold monitor
  Add adapter_ops calls for RSSI Enable/Disable
  Notify registered monitors when alert is triggered
  Add handle for RSSI monitor alert event in mgmt
  Add RSSI threshold monitor in Proximity Monitor
  Disable RSSI monitor when device is removed
  Disable RSSI threshold monitor when disconnected
  Emit SignalLevel when RSSI alert is received
  Define low/high RSSI threshold for Proximity
  Reset SignalLevel to unknown when disconnected

 lib/mgmt.h          |   18 ++++++++++
 plugins/hciops.c    |   13 +++++++
 plugins/mgmtops.c   |   85 ++++++++++++++++++++++++++++++++++++++++++++++++
 proximity/monitor.c |   75 +++++++++++++++++++++++++++++++++++++++++--
 src/adapter.c       |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h       |   13 +++++++
 src/event.c         |   14 ++++++++
 src/event.h         |    2 +
 8 files changed, 306 insertions(+), 3 deletions(-)

-- 
1.7.6

