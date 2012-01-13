Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] MGMT Stop Discovery command LE-Only support
Date: Fri, 13 Jan 2012 18:03:49 -0300
Message-Id: <1326488632-16759-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series adds LE-only support to Stop Discovery MGMT
command.

This series depends on the last series sent "MGMT Start Discovery
command LE-Only Support"

BR,

Andre

Andre Guedes (3):
  Bluetooth: Add hci_cancel_le_scan() to hci_core
  Bluetooth: Consider DISCOVERY_LE_SCAN state in hci_discovery_active
  Bluetooth: MGMT stop discovery LE support

 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   19 +++++++++++++++++++
 net/bluetooth/mgmt.c             |    9 +++++++++
 3 files changed, 29 insertions(+), 0 deletions(-)

-- 
1.7.8.3

