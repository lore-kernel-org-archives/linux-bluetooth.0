Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 0/8] New LTK messages
Date: Thu, 10 Nov 2011 22:03:48 -0300
Message-Id: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These are the new version of the messages needed for permanent key
storage (and allows a more permanent pairing).

Changes from the last version:
- new messages strutures;
- support for only the LTK;
- the LTKs are kept on their own list;

The last three patches are improvements needed for proper pairing.

As the mgmt interface in the kernel and in userspace are different,
I wasn't able to test these patches with the latest userspace. To not
pollute the list even more I will send the userspace side of things
(already implemented) as soon as it seems that this the way to go.

Cheers,
--

Vinicius Costa Gomes (8):
  Bluetooth: Add structures for the new LTK exchange messages
  Bluetooth: Add a custom type for Short Term Keys
  Bluetooth: Rename smp_key_size to enc_size
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
 net/bluetooth/hci_conn.c         |   27 +++++-----
 net/bluetooth/hci_core.c         |  107 +++++++++++++++++++++++--------------
 net/bluetooth/hci_event.c        |    5 ++-
 net/bluetooth/l2cap_core.c       |   58 ++++++++++++++-------
 net/bluetooth/mgmt.c             |   77 +++++++++++++++++++++++++++
 net/bluetooth/smp.c              |   44 +++++++++-------
 10 files changed, 264 insertions(+), 112 deletions(-)

--
1.7.7

