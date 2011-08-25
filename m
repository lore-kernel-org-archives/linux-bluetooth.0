Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH v2 00/13] Bluetooth: New mgmt messages for SMP Keys
Date: Thu, 25 Aug 2011 20:02:26 -0300
Message-Id: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes from the last version:
- Add support for removing the SMP Keys using mgmt Remove Key command;
- Disconnect the link if the found LTK isn't accepted to encrypt the
  link;
- We still have no support for any key generation method that would give
  us MITM protection, so we shouldn't say that we require it.
- Changed the defines of the MGMT events, there was a conflict with the
  blocked device events.

Cheers,
--

Vinicius Costa Gomes (13):
  Bluetooth: Fix sending wrong authentication requirements
  Bluetooth: Use the LTK after receiving a LE Security Request
  Revert "Bluetooth: Add support for communicating keys with userspace"
  Bluetooth: Add structures for the new SMP messages
  Bluetooth: Add support for cleaning the SMP key list
  Bluetooth: Add handlers for the new mgmt messages
  Bluetooth: Rename smp_key_size to enc_size
  Bluetooth: Use the smp_keys list for accessing SMP keys
  Bluetooth: Fix not setting a pending security level
  Bluetooth: Fix setting the connection sec_level when encryption fails
  Bluetooth: Remove support for other SMP keys than the LTK
  Bluetooth: mgmt: Add support for removing SMP keys
  Bluetooth: Disconnect the link if Encryption on LE links fails

 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |   39 ++++++---
 include/net/bluetooth/mgmt.h     |   26 ++++++-
 net/bluetooth/hci_core.c         |  104 ++++++++++++++++--------
 net/bluetooth/hci_event.c        |   13 ++-
 net/bluetooth/l2cap_core.c       |    5 +-
 net/bluetooth/mgmt.c             |  165 +++++++++++++++++++++++++++----------
 net/bluetooth/smp.c              |   97 +++++++++++-----------
 8 files changed, 298 insertions(+), 152 deletions(-)

--
1.7.6

