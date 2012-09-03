Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 0/8] Scan Parameters Plugin
Date: Mon,  3 Sep 2012 15:12:37 -0300
Message-Id: <1346695965-25422-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series implements a new GATT based service/plugin for Scan
Parameters: Optional service for HID devices.

This service enables a GATT Client to store the LE scan parameters on
a GATT Server device, allowing the GATT Server to use this information
to adjust the scanning settings to optimize power consumption and/or
reconnection latency.

Changes from previous version: Using new profile abstraction (replaces
btd_device drivers)

Claudio Takahasi (8):
  scan: Add plugin skeleton
  scan: Register profile
  scan: Add ATTIO callbacks registration
  scan: Add write scan interval window
  scan: Enable Scan Refresh notification
  scan: Register notification handler
  scan: Write parameters when requested
  scan: Avoid discover if scan handle is known

 Makefile.am                  |   8 +-
 profiles/scanparam/main.c    |  55 +++++++++
 profiles/scanparam/manager.c |  90 ++++++++++++++
 profiles/scanparam/manager.h |  26 ++++
 profiles/scanparam/scan.c    | 274 +++++++++++++++++++++++++++++++++++++++++++
 profiles/scanparam/scan.h    |  26 ++++
 6 files changed, 477 insertions(+), 2 deletions(-)
 create mode 100644 profiles/scanparam/main.c
 create mode 100644 profiles/scanparam/manager.c
 create mode 100644 profiles/scanparam/manager.h
 create mode 100644 profiles/scanparam/scan.c
 create mode 100644 profiles/scanparam/scan.h

-- 
1.7.12

