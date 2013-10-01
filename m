Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/3] Bluetooth: Add a new mgmt_set_bredr command
Date: Tue,  1 Oct 2013 18:21:59 +0300
Message-Id: <1380640922-18647-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set adds a new mgmt_set_bredr command that can be used to
make a dual mode controller behave like a single mode one. I'm sending
it as RFC since I haven't had the chance to test it properly yet.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Introduce a new HCI_BREDR_ENABLED flag
      Bluetooth: Move set_bredr_scan() to a more convenient location
      Bluetooth: Add a new mgmt_set_bredr command

 include/net/bluetooth/hci.h  |   1 +
 include/net/bluetooth/mgmt.h |   2 +
 net/bluetooth/hci_conn.c     |   3 +
 net/bluetooth/hci_core.c     |  21 ++++-
 net/bluetooth/mgmt.c         | 186 ++++++++++++++++++++++++++++++++++-------
 5 files changed, 180 insertions(+), 33 deletions(-)

