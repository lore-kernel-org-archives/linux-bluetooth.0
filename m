Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 0/8] Scan Parameters Plugin
Date: Wed, 22 Aug 2012 16:45:15 -0300
Message-Id: <1345664723-30814-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series implements a new GATT based service/plugin for Scan
Parameters: Optional service for HID devices.

This service enables a GATT Client to store the LE scan parameters on
a GATT Server device, allowing the GATT Server to utilize the information
to adjust behavior to optimize power consumption and/or reconnection
latency.

Claudio Takahasi (8):
  scan: Add plugin skeleton
  scan: Register device driver
  scan: Add ATTIO callbacks registration
  scan: Add write scan interval window
  scan: Enable Scan Refresh notification
  scan: Register notification handler
  scan: Write parameters when requested
  scan: Avoid discover if scan handle is known

 Makefile.am                  |   8 +-
 profiles/scanparam/main.c    |  55 +++++++++
 profiles/scanparam/manager.c |  89 ++++++++++++++
 profiles/scanparam/manager.h |  26 +++++
 profiles/scanparam/scan.c    | 272 +++++++++++++++++++++++++++++++++++++++++++
 profiles/scanparam/scan.h    |  26 +++++
 6 files changed, 474 insertions(+), 2 deletions(-)
 create mode 100644 profiles/scanparam/main.c
 create mode 100644 profiles/scanparam/manager.c
 create mode 100644 profiles/scanparam/manager.h
 create mode 100644 profiles/scanparam/scan.c
 create mode 100644 profiles/scanparam/scan.h

-- 
1.7.12

