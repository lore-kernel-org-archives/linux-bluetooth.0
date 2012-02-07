Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 0/3] Advertising cache locking code refactoring
Date: Tue,  7 Feb 2012 01:29:54 -0300
Message-Id: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series does some code refactoring in advertising cache locking
related code. This work is a small effort to improve locking usage in
Bluetooth subsystem.

BR,

Andre

Andre Guedes (3):
  Bluetooth: Add prefix "__" to advertising cache functions
  Bluetooth: Create thread-safe advertising cache functions
  Bluetooth: Use advertising cache thread-safe functions

 include/net/bluetooth/hci_core.h |    4 +++
 net/bluetooth/hci_conn.c         |    2 +-
 net/bluetooth/hci_core.c         |   51 +++++++++++++++++++++++++++++++------
 net/bluetooth/hci_event.c        |    6 +---
 4 files changed, 48 insertions(+), 15 deletions(-)

-- 
1.7.9

