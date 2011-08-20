Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 00/11] Bluetooth: New mgmt messages for SMP Keys
Date: Fri, 19 Aug 2011 21:08:04 -0300
Message-Id: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Using new messages for SMP keys allow for simpler code as it is always
clear from context the kind of key that is necessary.

Along with this are some fixes for problems found while implementing the
Proximity Profile.

--

Vinicius Costa Gomes (11):
  Bluetooth: Use the LTK after receiving a LE Security Request
  Revert "Bluetooth: Add support for communicating keys with userspace"
  Bluetooth: Add structures for the new SMP messages
  Bluetooth: Add support for cleaning the SMP key list
  Bluetooth: Add handlers for the new mgmt messages
  Bluetooth: Rename smp_key_size to enc_size
  Bluetooth: Use the smp_keys list for accessing SMP keys
  Bluetooth: Remove the link key if LE pairing fails
  Bluetooth: Fix not setting a pending security level
  Bluetooth: Fix setting the connection sec_level when encryption fails
  Bluetooth: Remove support for other SMP keys than the LTK

 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   39 ++++++---
 include/net/bluetooth/mgmt.h     |   26 ++++++-
 net/bluetooth/hci_core.c         |  103 ++++++++++++++++---------
 net/bluetooth/hci_event.c        |   13 ++-
 net/bluetooth/l2cap_core.c       |    6 +-
 net/bluetooth/mgmt.c             |  159 +++++++++++++++++++++++++++-----------
 net/bluetooth/smp.c              |   78 +++++++++++--------
 8 files changed, 291 insertions(+), 134 deletions(-)

--
1.7.6

