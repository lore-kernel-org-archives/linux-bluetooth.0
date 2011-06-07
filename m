Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v3 00/16] SMP Just Works implementation
Date: Tue,  7 Jun 2011 18:46:29 -0300
Message-Id: <1307483205-1518-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes from last version:
 - The issues reported by Luiz and Johan are fixed;
 - Changing to the same security level doesn't cause the LTK to be
   requested again;

--
Cheers,

Anderson Briglia (6):
  Bluetooth: Implement the first SMP commands
  Bluetooth: Start SMP procedure
  Bluetooth: Add simple SMP pairing negotiation
  Bluetooth: Add LE SMP Cryptoolbox functions
  Bluetooth: Add SMP confirmation structs
  Bluetooth: Add SMP confirmation checks methods

Vinicius Costa Gomes (10):
  Bluetooth: Add support for using the crypto subsystem
  Bluetooth: Add support for LE Start Encryption
  Bluetooth: Remove debug statements
  Bluetooth: Add support for resuming socket when SMP is finished
  Bluetooth: Fix initial security level of LE links
  Bluetooth: Update the security level when link is encrypted
  Bluetooth: Add support for building pairing commands
  Bluetooth: Add support for Pairing features exchange
  Bluetooth: Add support for SMP timeout
  Bluetooth: Add key size checks for SMP

 include/net/bluetooth/hci.h      |   34 +++
 include/net/bluetooth/hci_core.h |   10 +
 include/net/bluetooth/l2cap.h    |    9 +
 include/net/bluetooth/smp.h      |   46 ++++
 net/bluetooth/Kconfig            |    8 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/hci_conn.c         |   47 ++++
 net/bluetooth/hci_core.c         |   22 ++
 net/bluetooth/hci_event.c        |   69 +++++
 net/bluetooth/l2cap_core.c       |  141 ++++++-----
 net/bluetooth/l2cap_sock.c       |   16 ++
 net/bluetooth/smp.c              |  525 ++++++++++++++++++++++++++++++++++++++
 12 files changed, 869 insertions(+), 60 deletions(-)
 create mode 100644 net/bluetooth/smp.c

--
1.7.5.4

