Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: UPF cleanups & fixes
Date: Thu, 22 Oct 2015 09:38:30 +0300
Message-Id: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's the remaining 5 patches that weren't applied yet. The only change
is a fix to the SCO rejection reason code which has some special
limitations (see commit d41c15cf95bd91b9c333).

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Disable auto-connection parameters when unpairing
      Bluetooth: Introduce hci_req helper to abort a connection
      Bluetooth: Take advantage of connection abort helpers
      Bluetooth: Make hci_disconnect() behave correctly for all states
      Bluetooth: Fix crash in SMP when unpairing

 net/bluetooth/hci_conn.c    | 90 ++++++------------------------------------
 net/bluetooth/hci_request.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h |  4 ++
 net/bluetooth/mgmt.c        | 49 ++++++++---------------
 net/bluetooth/smp.c         | 26 +++++++++++++
 net/bluetooth/smp.h         |  1 +
 6 files changed, 151 insertions(+), 112 deletions(-)


