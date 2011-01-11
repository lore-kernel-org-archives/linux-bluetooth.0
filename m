Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Jan 2011 21:38:11 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi
Subject: pull request git://git.infradead.org/users/vcgomes/linux-2.6.git
 for-next
Message-ID: <20110111003811.GB26935@piper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

Here is the SMP implementation. Changes from the last RFC include:

- the fixes requested in the previous round of review;
- support for a simple pairing features exchange;
- SMP timeout;
- a new Kconfig option;

Any problems or improvements let me know, also, if you prefer this as a patch
series.


The following changes since commit 33af88138b859f515b365a074e0a014d7cdbf846:

  ath9k: correct MODULE_PARM_DESC parameters for force_new_ani (2011-01-05 14:36:33 -0500)

are available in the git repository at:
  git://git.infradead.org/users/vcgomes/linux-2.6.git for-next

Anderson Briglia (8):
      Bluetooth: Rename l2cap.c
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

Vinicius Costa Gomes (6):
      Bluetooth: Fix initiated LE connections
      Bluetooth: Add support for using the crypto subsystem
      Bluetooth: Add support for LE Start Encryption
      Bluetooth: Add support for resuming socket when SMP is finished
      Bluetooth: Add support for Pairing features exchange
      Bluetooth: Add support for SMP timeout

 include/net/bluetooth/hci.h             |   86 +++++
 include/net/bluetooth/hci_core.h        |   37 ++-
 include/net/bluetooth/l2cap.h           |   11 +
 include/net/bluetooth/smp.h             |   97 ++++++
 net/bluetooth/Kconfig                   |   12 +
 net/bluetooth/Makefile                  |    1 +
 net/bluetooth/hci_conn.c                |  110 ++++++-
 net/bluetooth/hci_core.c                |  102 ++++++-
 net/bluetooth/hci_event.c               |  200 ++++++++++++
 net/bluetooth/{l2cap.c => l2cap_core.c} |  293 +++++++++++++-----
 net/bluetooth/smp.c                     |  518 +++++++++++++++++++++++++++++++
 11 files changed, 1377 insertions(+), 90 deletions(-)
 create mode 100644 include/net/bluetooth/smp.h
 rename net/bluetooth/{l2cap.c => l2cap_core.c} (96%)
 create mode 100644 net/bluetooth/smp.c


Cheers,
-- 
Vinicius
