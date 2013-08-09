Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] LE parameters via debugfs 
Date: Fri,  9 Aug 2013 20:12:28 -0300
Message-Id: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patchset exports discovery and LE connection parameters via debugfs
filesystem. This might be useful for those who would like to do experiments
with different parameters.

BR,

Andre


Andre Guedes (3):
  Bluetooth: Discovery parameters per hci_dev
  Bluetooth: Export discovery parameters on debugfs
  Bluetooth: Set discovery parameters

Vinicius Costa Gomes (3):
  Bluetooth: Keep the LE connection parameters in its own structure
  Bluetooth: Add LE connection parameters to debugfs
  Bluetooth: Add support for setting LE connection parameters via
    debugfs

 include/net/bluetooth/hci_core.h |  23 ++++++
 net/bluetooth/hci_conn.c         |  11 +--
 net/bluetooth/hci_core.c         |  21 +++++-
 net/bluetooth/hci_sysfs.c        | 150 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  15 ++--
 5 files changed, 208 insertions(+), 12 deletions(-)

-- 
1.8.3.4

