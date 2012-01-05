Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/9] Bluetooth: Legacy name discovery support for mgmt
Date: Thu,  5 Jan 2012 17:16:13 +0200
Message-Id: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches implement initial legacy name resolving support as it is
currently specified in the mgmt API. This is one of the last bigger
pieces missing in order to be able to abandon hciops for good. There's
still possibly going to be some API changes to this (e.g. we've been
discussing of getting rid of mgmt_ev_remote_name) and some optimizations
(e.g. the "resolve" list should really be sorted by RSSI) but these
patches at least enable basic support of legacy resolving together with
the latest user-space git.

Johan Hedberg (9):
      Bluetooth: Fix persistency of the HCI_MGMT flag
      Bluetooth: Convert inquiry cache to use standard list types
      Bluetooth: Move Extended Inquiry Response defines to hci.h
      Bluetooth: Add initial mgmt_confirm_name support
      Bluetooth: Return updated name state with hci_inquiry_cache_update
      Bluetooth: Flush inquiry cache when starting mgmt triggered inquiry
      Bluetooth: Rename hdev->inq_cache to hdev->discovery
      Bluetooth: Add discovery state tracking
      Bluetooth: Add name resolving support for mgmt based discovery

 include/net/bluetooth/hci.h      |   13 +++
 include/net/bluetooth/hci_core.h |   54 ++++++++++---
 net/bluetooth/hci_core.c         |  155 +++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_event.c        |  141 +++++++++++++++++++++++++++++++---
 net/bluetooth/hci_sysfs.c        |    4 +-
 net/bluetooth/mgmt.c             |  112 +++++++++++++++++++++++----
 6 files changed, 409 insertions(+), 70 deletions(-)

