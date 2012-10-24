Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 0/9] Add LE broadcaser and observer functionality
Date: Wed, 24 Oct 2012 12:58:06 -0300
Message-Id: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series adds broadcaster and observer funcionality.

Yesterday, Johan Hedberg sent "Improved single-mode and LE peripheral support"
patch series, that has lots of conflicts with this implementation. Such patches
raised some discussions about LE roles interaction and advertising behavior.

The main intention of this submission is to show the implemenation progress of
broadcast and observer features and try to find the best way to merge them with
peripheral role implementation.

Aloisio Almeida Jr (5):
  Bluetooth: Set advertising parameters on LE setup
  Bluetooth: Add set controller data MGMT command
  Bluetooth: Add set broadcaster MGMT command
  Bluetooth: Refactor le scan helpers to enable observer support
  Bluetooth: Add set observer MGMT command

Jefferson Delfes (4):
  Bluetooth: Add HCI command to set advertising parameters
  Bluetooth: Add HCI command to set advertising data
  Bluetooth: Add unset controller data MGMT command
  Bluetooth: Add HCI command to enable/disable advertising

 include/net/bluetooth/hci.h      |   31 ++++
 include/net/bluetooth/hci_core.h |   33 +++-
 include/net/bluetooth/mgmt.h     |   21 +++
 net/bluetooth/hci_core.c         |  134 +++++++++++---
 net/bluetooth/hci_event.c        |   95 +++++++---
 net/bluetooth/mgmt.c             |  371 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 623 insertions(+), 62 deletions(-)

-- 
1.7.10.4

