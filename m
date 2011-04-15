Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 0/2] Returning Encryption Key Size
Date: Thu, 14 Apr 2011 21:04:46 -0300
Message-Id: <1302825888-5359-1-git-send-email-vinicius.gomes@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Disclaimer: the code this is based on is still on review, so this is
is subject to change.

Having Encryption Key Size exported to userspace is needed because
some profiles might have some restrictions depending on the key size
used to encrypt the link.

This patch series implement exporting to userspace adding one more
field to the bt_security structure.

For now, this only is valid for LE links, for 3.0+HS controllers
the Read Encryption Key Size command is defined. The plan is to
use that command for reading the key size as soon as the link
is encrypted, and storing the value read in the field that was
added to hci_conn.

The related userspace patches should follow this series.

--
Cheers,

Vinicius Costa Gomes (2):
  Bluetooth: Add support for storing the key size
  Bluetooth: Add support for returning the encryption key size

 include/net/bluetooth/bluetooth.h |    1 +
 include/net/bluetooth/hci_core.h  |    3 ++-
 net/bluetooth/hci_core.c          |    3 ++-
 net/bluetooth/hci_event.c         |    1 +
 net/bluetooth/l2cap_sock.c        |    4 ++++
 net/bluetooth/mgmt.c              |    4 ++--
 net/bluetooth/smp.c               |   16 ++++++++++------
 7 files changed, 22 insertions(+), 10 deletions(-)

--
1.7.4.3
