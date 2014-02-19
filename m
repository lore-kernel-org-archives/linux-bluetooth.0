Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: Add support for New IRK mgmt event
Date: Wed, 19 Feb 2014 14:57:42 +0200
Message-Id: <1392814668-4830-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set adds support for the New IRK mgmt event and moves the
sending of New LTK events after that event (ensuring they all contain
the Identity Address insted of the RPA).

Johan

----------------------------------------------------------------
Johan Hedberg (6):
      Bluetooth: Avoid using GFP_ATOMIC where not necessary
      Bluetooth: Return added key when adding LTKs and IRKs
      Bluetooth: Move New LTK store hint evaluation into mgmt_new_ltk
      Bluetooth: Track SMP keys in the SMP context
      Bluetooth: Move SMP LTK notification after key distribution
      Bluetooth: Add support for sending New IRK event

 include/net/bluetooth/hci_core.h | 13 ++++++-----
 include/net/bluetooth/mgmt.h     |  7 ++++++
 net/bluetooth/hci_core.c         | 38 +++++++++++--------------------
 net/bluetooth/mgmt.c             | 30 ++++++++++++++++++++-----
 net/bluetooth/smp.c              | 45 +++++++++++++++++++++++++++++--------
 net/bluetooth/smp.h              |  3 +++
 6 files changed, 91 insertions(+), 45 deletions(-)

