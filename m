Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 0/8] Userspace patches for RSSI threshold monitor
Date: Tue,  2 Aug 2011 18:37:32 -0300
Message-Id: <1312321060-19283-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches are implementing the userspace functions to handle
RSSI threshold monitor. The mgmt-api changes was proposed by:
[PATCH] Add RSSI Monitor documentation API(see ML)


Claudio Takahasi (8):
  Add RSSI threshold monitor definition in mgmt
  Add RSSI threshold monitor implementation
  Add enable RSSI threshold monitoring
  Return FALSE if RSSI monitor is already enabled
  Add disable for RSSI threshold monitor
  Add adapter_ops calls for RSSI Enable/Disable
  Notify registered monitors when alert is triggered
  Add handle for RSSI monitor alert event in mgmt

 lib/mgmt.h        |   18 +++++++++++
 plugins/hciops.c  |   13 ++++++++
 plugins/mgmtops.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c     |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h     |   13 ++++++++
 src/event.c       |   14 ++++++++
 src/event.h       |    2 +
 7 files changed, 234 insertions(+), 0 deletions(-)

-- 
1.7.6

