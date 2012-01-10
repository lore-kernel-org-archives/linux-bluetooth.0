Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/7] MGMT Start Discovery command LE-Only Support
Date: Tue, 10 Jan 2012 18:20:48 -0300
Message-Id: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series is basically a rebased version of the previous
series.

Coming patch series:
  * MGMT Stop Discovery command LE-Only support
  * Interleaved discovery support to MGMT Discovery commands

BR,

Andre

Andre Guedes (7):
  Bluetooth: Add 'eir_len' param to mgmt_device_found()
  Bluetooth: Report LE devices
  Bluetooth: LE scan should send Discovering events
  Bluetooth: Add helper functions to send LE scan commands
  Bluetooth: LE scan infrastructure
  Bluetooth: Add hci_do_le_scan() to hci_core
  Bluetooth: MGMT start discovery LE-Only support

 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   18 ++++++-
 net/bluetooth/hci_core.c         |  106 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   35 ++++++++++---
 net/bluetooth/mgmt.c             |   30 +++++++++--
 5 files changed, 178 insertions(+), 12 deletions(-)

-- 
1.7.8.1

