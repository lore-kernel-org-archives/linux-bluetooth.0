Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/32] Bluetooth: LE CoC support
Date: Thu,  5 Dec 2013 15:10:58 +0200
Message-Id: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's v2 of the patches with all comments taken into account.
Additionally I've fixed the permissions of the debugfs files, fixed the
credits calculation for max_credits == 1, and added a cleanup patch at
the end of the set for simplifying l2cap_chan initialization for LE CoC.

I've also updated user space l2test now to support the new BT_SNDMTU and
BT_RCVMTU socket options, i.e. the LE CoC functionality can now be
tested using upstream l2test.

Johan

----------------------------------------------------------------
Johan Hedberg (32):
      Bluetooth: Remove unnecessary braces from one-line if-statement
      Bluetooth: Add module parameter to enable LE CoC support
      Bluetooth: Update l2cap_global_chan_by_psm() to take a link type
      Bluetooth: Allow l2cap_chan_check_security() to be used for LE links.
      Bluetooth: Pass command length to LE signaling channel handlers
      Bluetooth: Move LE L2CAP initiator procedure to its own function
      Bluetooth: Add definitions for LE connection oriented channels
      Bluetooth: Add initial code for LE L2CAP Connect Request
      Bluetooth: Add smp_sufficient_security helper function
      Bluetooth: Refactor L2CAP connect rejection to its own function
      Bluetooth: Add basic LE L2CAP connect request receiving support
      Bluetooth: Fix L2CAP channel closing for LE connections
      Bluetooth: Add L2CAP Disconnect suppport for LE
      Bluetooth: Make l2cap_le_sig_cmd logic consistent
      Bluetooth: Add LE L2CAP flow control mode
      Bluetooth: Track LE L2CAP credits in l2cap_chan
      Bluetooth: Limit L2CAP_OPTIONS socket option usage with LE
      Bluetooth: Add new BT_SNDMTU and BT_RCVMTU socket options
      Bluetooth: Implement returning of LE L2CAP credits
      Bluetooth: Add LE flow control discipline
      Bluetooth: Reject LE CoC commands when the feature is not enabled
      Bluetooth: Introduce L2CAP channel callback for suspending
      Bluetooth: Add LE L2CAP segmentation support for outgoing data
      Bluetooth: Implement LE L2CAP reassembly
      Bluetooth: Fix LE L2CAP Connect Request handling together with SMP
      Bluetooth: Fix suspending the L2CAP socket if we start with 0 credits
      Bluetooth: Limit LE MPS to the MTU value
      Bluetooth: Fix clearing of chan->omtu for LE CoC channels
      Bluetooth: Fix CID ranges for LE CoC CID allocations
      Bluetooth: Fix validating LE PSM values
      Bluetooth: Add debugfs controls for LE CoC MPS and Credits
      Bluetooth: Simplify l2cap_chan initialization for LE CoC

 include/net/bluetooth/bluetooth.h |   3 +
 include/net/bluetooth/l2cap.h     |  45 +++
 net/bluetooth/l2cap_core.c        | 720 ++++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap_sock.c        | 157 +++++++-
 net/bluetooth/smp.c               |  16 +-
 net/bluetooth/smp.h               |   1 +
 6 files changed, 873 insertions(+), 69 deletions(-)

