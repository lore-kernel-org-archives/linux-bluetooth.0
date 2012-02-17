Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 0/4] MGMT Start Discovery interleaved support
Date: Fri, 17 Feb 2012 20:39:34 -0300
Message-Id: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This RFCv2 series implements Marcel's and Johan's comments from previous
version. The changes are:
1. Use MGMT_ADDR_* macros instead of hard-coded values to define discovery
type macros;
2. Fix locking in mgmt_interleaved_discovery

Marcel, I removed your ack from patch 1/4 because I changed it a little
bit. MGMT_ADDR_* macros were moved to hci_core.h since they are needed to
define discovery type macros.

BR,

Andre


Andre Guedes (4):
  Bluetooth: Prepare start_discovery
  Bluetooth: Track discovery type
  Bluetooth: Merge INQUIRY and LE_SCAN discovery states
  Bluetooth: Interleaved discovery support

 include/net/bluetooth/hci_core.h |   18 +++++++++-
 include/net/bluetooth/mgmt.h     |    5 ---
 net/bluetooth/hci_core.c         |    8 ++--
 net/bluetooth/hci_event.c        |   19 +++++++----
 net/bluetooth/mgmt.c             |   64 ++++++++++++++++++++++++++++++++++---
 5 files changed, 90 insertions(+), 24 deletions(-)

-- 
1.7.9.1

