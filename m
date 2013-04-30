Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 00/14] Update Discovery to use HCI request framework
Date: Tue, 30 Apr 2013 15:29:26 -0300
Message-Id: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v3 is very similar to the previous patch set, except it has some minor
changes Johan suggested.

This patch set requires the patch "Bluetooth: Fix checks for LE support on
LE-only controllers" in order to apply (this patch is already acked).

Regards,

Andre


Andre Guedes (14):
  Bluetooth: Make inquiry_cache_flush non-static
  Bluetooth: Update start_discovery to use HCI request
  Bluetooth: Remove start discovery handling from hci_event.c
  Bluetooth: Make mgmt_start_discovery_failed static
  Bluetooth: Move discovery macros to hci_core.h
  Bluetooth: Use HCI request in interleaved discovery
  Bluetooth: Update stop_discovery to use HCI request
  Bluetooth: Remove stop discovery handling from hci_event.c
  Bluetooth: Make mgmt_stop_discovery_failed static
  Bluetooth: Refactor hci_cc_le_set_scan_enable
  Bluetooth: Remove LE scan helpers
  Bluetooth: Remove inquiry helpers
  Bluetooth: Remove empty event handler
  Bluetooth: Mgmt Device Found Event

 include/net/bluetooth/hci_core.h |  29 ++---
 net/bluetooth/hci_core.c         | 182 +++++++++----------------------
 net/bluetooth/hci_event.c        |  67 +-----------
 net/bluetooth/mgmt.c             | 227 ++++++++++++++++++++++++++-------------
 4 files changed, 221 insertions(+), 284 deletions(-)

-- 
1.8.2.1

