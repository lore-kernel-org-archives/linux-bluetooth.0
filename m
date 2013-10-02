Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: Add a new mgmt_set_bredr command
Date: Wed,  2 Oct 2013 13:43:12 +0300
Message-Id: <1380710594-24555-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Yet another update with error code fixes in both patches based on
feedback. I also removed the unnecessary val and enabled variables as
suggested by Andrei Emeltchenko.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Introduce a new HCI_BREDR_ENABLED flag
      Bluetooth: Add a new mgmt_set_bredr command

 include/net/bluetooth/hci.h  |   1 +
 include/net/bluetooth/mgmt.h |   2 +
 net/bluetooth/hci_conn.c     |   3 +
 net/bluetooth/hci_core.c     |  21 +++++-
 net/bluetooth/hci_event.c    |   5 ++
 net/bluetooth/mgmt.c         | 144 ++++++++++++++++++++++++++++++++++++++----
 6 files changed, 163 insertions(+), 13 deletions(-)

