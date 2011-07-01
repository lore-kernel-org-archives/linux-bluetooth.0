Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 00/12] Bluetooth: SMP Keys exchange and storage
Date: Fri,  1 Jul 2011 16:07:35 -0300
Message-Id: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch series implement the so called SMP phase 3, where after
encryption has been estabilished, keys may be exchanged and, if
requested also stored.

Some notes about this series:
 - the linkkeys list is also used for SMP keys;
 - new fields were added to the mgmt_key_info structure;
 - the size of the key used for encryption is exported through the BT_SECURITY
 socket option, upper layers may reject some connections on that basis;

Cheers,

Vinicius Costa Gomes (12):
  Bluetooth: Add support for SMP phase 3 (key distribution)
  Bluetooth: Add new structures for supporting SM key distribution
  Bluetooth: Add functions to manipulate the link key list for SMP
  Bluetooth: Reject an encryption request when the key isn't found
  Bluetooth: Fix SM pairing parameters negotiation
  Bluetooth: Add support for storing the LTK
  Bluetooth: Use the link key list to temporarily store the STK
  Bluetooth: Use the stored LTK for restabilishing security
  Bluetooth: Remove unused field in hci_conn
  Bluetooth: Add support for communicating keys with userspace
  Bluetooth: Add support for storing the key size
  Bluetooth: Add support for returning the encryption key size

 include/net/bluetooth/bluetooth.h |    1 +
 include/net/bluetooth/hci.h       |    4 +
 include/net/bluetooth/hci_core.h  |   23 ++++-
 include/net/bluetooth/mgmt.h      |    2 +
 include/net/bluetooth/smp.h       |    1 +
 net/bluetooth/hci_core.c          |   82 +++++++++++++++
 net/bluetooth/hci_event.c         |   19 +++-
 net/bluetooth/l2cap_core.c        |    1 +
 net/bluetooth/l2cap_sock.c        |    4 +
 net/bluetooth/mgmt.c              |   60 ++++++++---
 net/bluetooth/smp.c               |  202 +++++++++++++++++++++++++++++++++----
 11 files changed, 361 insertions(+), 38 deletions(-)

--
1.7.6

