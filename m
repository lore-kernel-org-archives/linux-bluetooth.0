Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/4] MGMT Start Discovery interleaved support
Date: Thu, 16 Feb 2012 18:50:37 -0300
Message-Id: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This RFC series adds interleaved discovery support to MGMT Start Discovery
command.

As previously discussed (see [PATCH] Don't set LE flags in mgmt_start_
discovery), if an interleaved Start Discovery command is issued but the
device is not dual mode, we perform a regular BR/EDR or LE-only discovery
(according to device capabilities) instead of returning error.

BR,

Andre


Andre Guedes (4):
  Bluetooth: Prepare start_discovery
  Bluetooth: Track discovery type
  Bluetooth: Merge INQUIRY and LE_SCAN discovery states
  Bluetooth: Interleaved discovery support

 include/net/bluetooth/hci_core.h |   10 +++++-
 net/bluetooth/hci_core.c         |    8 ++--
 net/bluetooth/hci_event.c        |   19 +++++++----
 net/bluetooth/mgmt.c             |   64 ++++++++++++++++++++++++++++++++++---
 4 files changed, 82 insertions(+), 19 deletions(-)

-- 
1.7.9.1

