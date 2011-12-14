Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] MGMT Start Discovery command LE-Only Support
Date: Wed, 14 Dec 2011 13:25:19 -0300
Message-Id: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I've split discovery patches series into smaller series so we keep easier
to review and apply these patches. This first patch series adds LE-Only
discovery support to MGMT Start Discovery command.

About the comments from previous series, hci_request/hci_req_complete
mechanism was replaced by a simpler one where we just wait for the commands
results to go ahead with LE scanning.

Coming patch series are:
   * Stop Discovery LE-Only support
   * Interleaved discovery support to MGMT Discovery commands

BR,

Andre

Andre Guedes (7):
  Bluetooth: Add 'eir_len' param to mgmt_device_found()
  Bluetooth: Report LE devices
  Bluetooth: LE scan should send MGMT Discovering events
  Bluetooth: Add helper functions to send LE scan commands
  Bluetooth: LE scan infra-structure
  Bluetooth: Add hci_do_le_scan() to hci_core
  Bluetooth: MGMT start discovery LE-Only support

 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   18 ++++++-
 net/bluetooth/hci_core.c         |  104 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   37 +++++++++++---
 net/bluetooth/mgmt.c             |   31 ++++++++++--
 5 files changed, 179 insertions(+), 12 deletions(-)

-- 
1.7.8

