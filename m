Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/2] LE connection refactoring and fixes
Date: Mon,  7 Oct 2013 13:59:06 -0300
Message-Id: <1381165148-14156-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v3 implements Marcel's comments from the previous patchset. It is rebased
on top of current bluetooth-next tree.

Regards,

Andre


Andre Guedes (2):
  Bluetooth: Use HCI request for LE connection
  Bluetooth: Refactor hci_connect_le

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_conn.c         | 75 +++++++++++++++++++---------------------
 net/bluetooth/hci_core.c         | 55 +++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 31 -----------------
 4 files changed, 93 insertions(+), 70 deletions(-)

-- 
1.8.4

