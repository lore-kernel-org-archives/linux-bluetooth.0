Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: [PATCH v3 0/6] MGMT Start Discovery command LE-Only Support
Date: Wed, 25 Jan 2012 19:52:23 -0300
Message-Id: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series is basically a rebased version of the previous
series.

Patches 2 and 3 define functions used in patch 4 so these patches
should be applied together to avoid compiler warnings.

BR,

Andre

Andre Guedes (6):
  Bluetooth: LE scan should send Discovering events
  Bluetooth: Add helper functions to send LE scan commands
  Bluetooth: Add hci_do_le_scan()
  Bluetooth: Add hci_le_scan()
  Bluetooth: MGMT start discovery LE-Only support
  Bluetooth: Fix indentation

 include/net/bluetooth/hci_core.h |   18 ++++++
 net/bluetooth/hci_core.c         |  116 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   31 +++++++++-
 net/bluetooth/mgmt.c             |   22 +++++++-
 4 files changed, 182 insertions(+), 5 deletions(-)

-- 
1.7.8.4
