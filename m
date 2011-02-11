Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next -v2 00/24] Just Works SMP implementation
Date: Thu, 10 Feb 2011 22:38:45 -0300
Message-Id: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch series adds support for making (and receiving) LE connections
and the simplest SMP pairing method.

Fixed from v1:
- Ville's comments;
- Receiving LE connections (sorry);

What is (should be) working:
- Creating LE connections;
- Receiving LE connections;
- Creating LE connections with higher security levels (MEDIUM and HIGH);
- Changing security level during the connection;

This code is also on my personal repositories:
http://git.infradead.org/users/vcgomes/linux-2.6.git (branch for-next)
http://gitorious.org/bluetooth-next/bluetooth-next (branch for-next)


Cheers,
--

Anderson Briglia (7):
  Bluetooth: Implement the first SMP commands
  Bluetooth: Start SMP procedure
  Bluetooth: simple SMP pairing negotiation
  Bluetooth: LE SMP Cryptoolbox functions
  Bluetooth: Add SMP confirmation structs
  Bluetooth: Add SMP confirmation checks methods
  Bluetooth: Minor fix in SMP methods

Ville Tervo (8):
  Bluetooth: Add low energy commands and events
  Bluetooth: Add LE connect support
  Bluetooth: Use LE buffers for LE traffic
  Bluetooth: Add LE connection support to L2CAP
  Bluetooth: Add server socket support for LE connection
  Bluetooth: Do not send disconn comand over LE links
  Bluetooth: Treat LE and ACL links separately on timeout
  Bluetooth: Add SMP command structures

Vinicius Costa Gomes (9):
  Bluetooth: Fix initiated LE connections
  Bluetooth: Add support for using the crypto subsystem
  Bluetooth: Add support for LE Start Encryption
  Bluetooth: Add support for resuming socket when SMP is finished
  Bluetooth: Fix initial security level of LE links
  Bluetooth: Update the security level when link is encrypted
  Bluetooth: Add support for Pairing features exchange
  Bluetooth: Add support for SMP timeout
  Bluetooth: Add key size checks for SMP

 include/net/bluetooth/hci.h      |   85 ++++++
 include/net/bluetooth/hci_core.h |   40 +++-
 include/net/bluetooth/l2cap.h    |   13 +
 include/net/bluetooth/smp.h      |  122 +++++++++
 net/bluetooth/Kconfig            |   12 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/hci_conn.c         |  105 ++++++++-
 net/bluetooth/hci_core.c         |  101 +++++++-
 net/bluetooth/hci_event.c        |  201 ++++++++++++++
 net/bluetooth/l2cap_core.c       |  242 +++++++++++++----
 net/bluetooth/l2cap_sock.c       |   46 +++-
 net/bluetooth/smp.c              |  534 ++++++++++++++++++++++++++++++++++++++
 12 files changed, 1416 insertions(+), 87 deletions(-)
 create mode 100644 include/net/bluetooth/smp.h
 create mode 100644 net/bluetooth/smp.c

--
1.7.4

