Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: Add dedicated SMP (de)initialization functions
Date: Fri,  8 Aug 2014 09:32:47 +0300
Message-Id: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

For us to have a clean way to create the root (per-adapter) SMP L2CAP
channel it's best to move the code responsible for this to specialized
functions in smp.c. For now this only involves the AES crypto context
creation and destruction.

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Fix hci_update_random_address() error return for no crypto
      Bluetooth: Fix IRK lookup when tfm_aes is not available
      Bluetooth: Refactor SMP (de)initialization into separate functions
      Bluetooth: Move SMP initialization after HCI init
      Bluetooth: Move SMP (de)initialization to smp.c

 net/bluetooth/hci_core.c | 27 +++++++++++++--------------
 net/bluetooth/smp.c      | 26 ++++++++++++++++++++++++++
 net/bluetooth/smp.h      |  3 +++
 3 files changed, 42 insertions(+), 14 deletions(-)

