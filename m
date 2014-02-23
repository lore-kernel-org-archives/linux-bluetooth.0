Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/10] LE Privacy support
Date: Sun, 23 Feb 2014 16:23:48 +0200
Message-Id: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a new set of patches for the ones that didn't go through from the
initial set.

Johan

----------------------------------------------------------------
Johan Hedberg (10):
      Bluetooth: Set the correct address type in Identity Address Information
      Bluetooth: Add SMP function for generating RPAs
      Bluetooth: Add timer for regenerating local RPA
      Bluetooth: Add hci_get_own_address_type() convenience function
      Bluetooth: Use hci_get_own_address_type() when connecting LE
      Bluetooth: Use hci_get_own_address_type() for enabling advertising
      Bluetooth: Use hci_get_own_address_type() for initiating LE scan
      Bluetooth: Don't write static address during power on
      Bluetooth: Add debugfs entry for RPA regeneration timeout
      Bluetooth: Add support for Set Privacy command

 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  7 ++++
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 75 +++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 80 ++++++++++++++++++++++++++++++++----
 net/bluetooth/smp.c              | 21 +++++++++-
 net/bluetooth/smp.h              |  1 +
 7 files changed, 176 insertions(+), 11 deletions(-)

