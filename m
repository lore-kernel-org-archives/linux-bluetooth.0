Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] LE-Only discovery procedure support
Date: Fri, 11 Nov 2011 19:50:18 -0300
Message-Id: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series implements the LE-Only discovery procedure.

These patches are based on the last patches I sent to ML (already
acked by Marcel) but not upstream yet.

BTW, I'm still working on interleaved discovery and should send
its patches soon.

BR,

Andre

Andre Guedes (6):
  Bluetooth: Add hci_flags to struct hci_dev
  Bluetooth: Add LE Set Scan Parameter Command
  Bluetooth: LE scan infra-structure
  Bluetooth: Add 'eir_len' param to mgmt_device_found()
  Bluetooth: Report LE devices
  Bluetooth: Support LE-Only discovery procedure

 include/net/bluetooth/hci.h      |   18 ++++++++++
 include/net/bluetooth/hci_core.h |   11 +++++-
 net/bluetooth/hci_core.c         |   70 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   45 ++++++++++++++++++++----
 net/bluetooth/mgmt.c             |   33 ++++++++++++++++--
 5 files changed, 165 insertions(+), 12 deletions(-)

-- 
1.7.7.1

