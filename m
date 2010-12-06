Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC v2 0/9] SMP Implementation
Date: Mon,  6 Dec 2010 18:43:43 -0300
Message-Id: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


Here goes just the SMP implementation (excluding Ville's LE patches).

Ville, I took the liberty of making the changes that Gustavo suggested to your
patches, the final result is here:

git://git.infradead.org/users/vcgomes/linux-2.6.git for-next

This tree is rebased on top of bluetooth-next.


Cheers
--

Anderson Briglia (3):
  Bluetooth: Start SMP procedure
  Bluetooth: simple SMP pairing negotiation
  Bluetooth: LE SMP Cryptoolbox functions

Ville Tervo (1):
  Bluetooth: Add SMP command structures

Vinicius Costa Gomes (5):
  Bluetooth: Implement the first SMP commands
  Bluetooth: Add support for using the crypto subsystem
  Bluetooth: Add support for SMP confirmation checks
  Bluetooth: Add support for LE Start Encryption
  Bluetooth: Add support for resuming socket when SMP is finished

 include/net/bluetooth/hci.h             |   34 +++
 include/net/bluetooth/hci_core.h        |    7 +
 include/net/bluetooth/l2cap.h           |    5 +
 include/net/bluetooth/smp.h             |   80 ++++++
 net/bluetooth/Makefile                  |    1 +
 net/bluetooth/hci_conn.c                |   47 +++
 net/bluetooth/hci_core.c                |   10 +
 net/bluetooth/hci_event.c               |   67 +++++
 net/bluetooth/{l2cap.c => l2cap_core.c} |   78 ++++--
 net/bluetooth/smp.c                     |  469 +++++++++++++++++++++++++++++++
 10 files changed, 769 insertions(+), 29 deletions(-)
 create mode 100644 include/net/bluetooth/smp.h
 rename net/bluetooth/{l2cap.c => l2cap_core.c} (99%)
 create mode 100644 net/bluetooth/smp.c

-- 
1.7.3.2

