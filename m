Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/4] LE connection refactoring and fixes
Date: Thu,  3 Oct 2013 18:25:43 -0300
Message-Id: <1380835547-3640-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v2 takes in consideration comments from Marcel and Lizardo. This patchset
is smaller since I squashed 3 patches and removed the last two patches from
the previous patchset.

Regards,

Andre


Andre Guedes (4):
  Bluetooth: Rename hci_conn variable in hci_connect_le()
  Bluetooth: Initialize hci_conn fields in hci_connect_le
  Bluetooth: Use HCI request for LE connection
  Bluetooth: Refactor hci_connect_le

 include/net/bluetooth/hci_core.h |  2 +
 net/bluetooth/hci_conn.c         | 81 ++++++++++++++++++++--------------------
 net/bluetooth/hci_core.c         | 46 +++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 31 ---------------
 4 files changed, 89 insertions(+), 71 deletions(-)

-- 
1.8.4

