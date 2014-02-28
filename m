Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/4] Bluetooth: Fix initiator/responder addresses for SMP
Date: Fri, 28 Feb 2014 12:54:13 +0200
Message-Id: <1393584857-30375-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a second attempt to fix the initiator/responder addresses when
using privacy. The main difference to the previous attempt is an added
protection to HCI_Set_Random_Address so we don't do that while
connecting or advertising, and a clarification for the white list corner
case in aptch 3/4 that we're taking a "best effort" approach while
lacking full tracking of white list initiated connections.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Add protections for updating local random address
      Bluetooth: Fix updating connection state to BT_CONNECT too early
      Bluetooth: Track LE initiator and responder address information
      Bluetooth: Use hdev->init/resp_addr values for smp_c1 function

 include/net/bluetooth/hci_core.h |  4 ++
 net/bluetooth/hci_conn.c         |  3 +-
 net/bluetooth/hci_core.c         | 27 ++++++++++++-
 net/bluetooth/hci_event.c        | 78 ++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  7 ++++
 net/bluetooth/smp.c              | 22 +++-------
 6 files changed, 122 insertions(+), 19 deletions(-)

