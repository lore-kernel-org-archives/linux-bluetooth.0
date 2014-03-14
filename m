Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Direct advertising support through connect()
Date: Fri, 14 Mar 2014 11:43:11 +0200
Message-Id: <1394790195-4109-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set adds support for triggering direct advertising when the
HCI_ADVERTISING flag is set and connect() is called on a socket.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Move local identity address setting to a central place
      Bluetooth: Fix LE responder/initiator address setting
      Bluetooth: Add error mapping for Directed Advertising Timeout
      Bluetooth: Add directed advertising support through connect()

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_conn.c    | 87 +++++++++++++++++++++++++++++++++++++++----
 net/bluetooth/hci_event.c   | 54 ++++++++++++++-------------
 net/bluetooth/lib.c         |  1 +
 4 files changed, 110 insertions(+), 33 deletions(-)


