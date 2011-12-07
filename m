Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 0/8] Bluetooth: SMP Key Exchange
Date: Tue,  6 Dec 2011 21:48:04 -0300
Message-Id: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the newest version of SMP key exchange.

For this to work, this depends on userspace having the address type of an
LE device, so there is a functional dependency on Andre's LE Discovery
series (patches 7/9 and 8/9 from his last series more specifically).

What's new:
 - hci_add_ltk() now expects hdev to be locked;

--
Cheers,


Vinicius Costa Gomes (8):
  Bluetooth: Add structures for the new LTK exchange messages
  Bluetooth: Add a custom type for Short Term Keys
  Bluetooth: Rename smp_key_size to enc_key_size
  Bluetooth: Change SMP procedures to use the new key structures
  Bluetooth: Add new mgmt handlers for Long Term Keys
  Bluetooth: Add support for reusing the same hci_conn for LE links
  Bluetooth: Disconnect the link if encryption fails
  Bluetooth: Only increase the connection sec-level if encryption is
    successful

 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   34 ++++++------
 include/net/bluetooth/mgmt.h     |   21 +++++++
 include/net/bluetooth/smp.h      |    2 +-
 net/bluetooth/hci_conn.c         |   33 ++++++-----
 net/bluetooth/hci_core.c         |  107 +++++++++++++++++++++++--------------
 net/bluetooth/hci_event.c        |    5 ++-
 net/bluetooth/l2cap_core.c       |   58 ++++++++++++++-------
 net/bluetooth/mgmt.c             |   77 +++++++++++++++++++++++++++
 net/bluetooth/smp.c              |   41 +++++++-------
 10 files changed, 265 insertions(+), 114 deletions(-)

--
1.7.8

