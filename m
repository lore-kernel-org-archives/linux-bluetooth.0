Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 00/26] Bluetooth: Management interface fixes
Date: Fri, 15 Mar 2013 17:06:50 -0500
Message-Id: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's hopefully the last send of this set. v5 includes the flags mask
fix suggested by Marcel as well as updates to all those patches that
the mask inversion affects.

Johan

----------------------------------------------------------------
Johan Hedberg (26):
      Bluetooth: Move power on HCI command updates to their own function
      Bluetooth: Update mgmt powered HCI commands to use async requests
      Bluetooth: Wait for HCI command completion with mgmt_set_powered
      Bluetooth: Fix busy condition testing for EIR and class updates
      Bluetooth: Fix UUID/class mgmt command response synchronization
      Bluetooth: Remove useless HCI_PENDING_CLASS flag
      Bluetooth: Add a define for the HCI persistent flags mask
      Bluetooth: Clear non-persistent flags when closing HCI device
      Bluetooth: Fix clearing flags on power off before notifying mgmt
      Bluetooth: Fix waiting for EIR update when setting local name
      Bluetooth: Handle AD updating through an async request
      Bluetooth: Fix local name setting for LE-only controllers
      Bluetooth: Fix setting local name to the existing value
      Bluetooth: Use an async request for mgmt_set_connectable
      Bluetooth: Fix fast connectable response sending
      Bluetooth: Limit fast connectable support to >= 1.2 controllers
      Bluetooth: Fix error response for simultaneous fast connectable commands
      Bluetooth: Add proper flag for fast connectable mode
      Bluetooth: Refactor fast connectable HCI commands
      Bluetooth: Disable fast connectable when disabling connectable
      Bluetooth: Add reading of page scan parameters
      Bluetooth: Update page scan parameters after successful write commands
      Bluetooth: Fix updating page scan parameters when not necessary
      Bluetooth: Fix fast connectable state when enabling page scan
      Bluetooth: Simplify address parameters of user_pairing_resp()
      Bluetooth: Fix PIN/Confirm/Passkey response parameters

 include/net/bluetooth/hci.h      |   21 +-
 include/net/bluetooth/hci_core.h |    8 +-
 net/bluetooth/hci_core.c         |   42 ++-
 net/bluetooth/hci_event.c        |   97 +++++-
 net/bluetooth/mgmt.c             |  680 ++++++++++++++++++++++++++------------
 5 files changed, 599 insertions(+), 249 deletions(-)

