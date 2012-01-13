Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 0/8] New MGMT messages for SMP Long Term Keys
Date: Fri, 13 Jan 2012 16:39:32 -0300
Message-Id: <1326483580-11243-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the last version of the code that will allow the permanent
storage of SMP Long Term Keys.

The main changes from the last version are:
* In the structure that represents a LTK the field pin_length was
  replaced by the information whether or not that key is
  authenticated;

* Still on that structure, it was added information about the role in
  which the key should be used, e.g. a key marked as master should
  only be used when the host is in the master role;

* More specific types for each type and role of key, previously it was
  used the address field of the key to indentify the role of the key.

* The address type of the remote is sent with the LTK, this information
  will be useful for userspace when recreating the device from storage.

Marcel, as I changed the key format in the patch "Bluetooth: Add
structures for the new LTK exchange messages" I decided to remove your
Ack from it.

Cheers,
--

Vinicius Costa Gomes (8):
  Bluetooth: Add structures for the new LTK exchange messages
  Bluetooth: Rename smp_key_size to enc_key_size
  Bluetooth: Add new structures for handling SMP Long Term Keys
  Bluetooth: Use the updated key structures for handling LTKs
  Bluetooth: Add MGMT handlers for dealing with SMP LTK's
  Bluetooth: Add support for removing LTK's when pairing is removed
  Bluetooth: Clean up structures left unused
  Bluetooth: Add support for notifying userspace of new LTK's

 include/net/bluetooth/hci.h      |    9 ++--
 include/net/bluetooth/hci_core.h |   35 +++++++------
 include/net/bluetooth/mgmt.h     |   22 ++++++++
 include/net/bluetooth/smp.h      |    2 +-
 net/bluetooth/hci_core.c         |  111 ++++++++++++++++++++++++--------------
 net/bluetooth/hci_event.c        |    9 +++-
 net/bluetooth/mgmt.c             |   88 ++++++++++++++++++++++++++++++
 net/bluetooth/smp.c              |   50 ++++++++++-------
 8 files changed, 241 insertions(+), 85 deletions(-)

--
1.7.8.1

