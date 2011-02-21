Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 00/15] SMP Just Works Implementation
Date: Mon, 21 Feb 2011 14:23:47 -0300
Message-Id: <cover.1298307667.git.vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch series implement the Just Works SMP procedures for LE links.

These patches can also be reached from here[1].


Cheers,
--
Vinicius

[1] http://git.infradead.org/users/vcgomes/linux-2.6.git (for-next branch)

Anderson Briglia (7):
  Bluetooth: Implement the first SMP commands
  Bluetooth: Start SMP procedure
  Bluetooth: simple SMP pairing negotiation
  Bluetooth: LE SMP Cryptoolbox functions
  Bluetooth: Add SMP confirmation structs
  Bluetooth: Add SMP confirmation checks methods
  Bluetooth: Minor fix in SMP methods

Vinicius Costa Gomes (8):
  Bluetooth: Add support for using the crypto subsystem
  Bluetooth: Add support for LE Start Encryption
  Bluetooth: Add support for resuming socket when SMP is finished
  Bluetooth: Fix initial security level of LE links
  Bluetooth: Update the security level when link is encrypted
  Bluetooth: Add support for Pairing features exchange
  Bluetooth: Add support for SMP timeout
  Bluetooth: Add key size checks for SMP

 include/net/bluetooth/hci.h      |   34 +++
 include/net/bluetooth/hci_core.h |   10 +
 include/net/bluetooth/l2cap.h    |    9 +
 include/net/bluetooth/smp.h      |   46 ++++
 net/bluetooth/Kconfig            |    6 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/hci_conn.c         |   47 ++++
 net/bluetooth/hci_core.c         |   22 ++
 net/bluetooth/hci_event.c        |   69 +++++
 net/bluetooth/l2cap_core.c       |  137 ++++++----
 net/bluetooth/l2cap_sock.c       |   17 ++
 net/bluetooth/smp.c              |  535 ++++++++++++++++++++++++++++++++++++++
 12 files changed, 876 insertions(+), 58 deletions(-)
 create mode 100644 net/bluetooth/smp.c

--
1.7.4.1

