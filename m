Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/9] LE-Only discovery procedure support
Date: Fri, 25 Nov 2011 20:53:37 -0300
Message-Id: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This version implements Marcel's and Johan's comments from
the previous version.

BR,

Andre Guedes

Andre Guedes (9):
  Bluetooth: Add dev_flags to struct hci_dev
  Bluetooth: LE Set Scan Parameter Command
  Bluetooth: Add helper functions to send LE scan commands
  Bluetooth: Add structs to implement LE scan
  Bluetooth: LE scan infra-structure
  Bluetooth: Add LE scan functions to hci_core
  Bluetooth: Add 'eir_len' param to mgmt_device_found()
  Bluetooth: Report LE devices
  Bluetooth: Support LE-Only discovery procedure

 include/net/bluetooth/hci.h      |   18 +++++++
 include/net/bluetooth/hci_core.h |   19 +++++++-
 net/bluetooth/hci_core.c         |   94 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   61 ++++++++++++++++++++++---
 net/bluetooth/mgmt.c             |   39 ++++++++++++++--
 5 files changed, 218 insertions(+), 13 deletions(-)

-- 
1.7.7.1

