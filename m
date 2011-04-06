Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 00/15] SM Phase 3 patches
Date: Tue,  5 Apr 2011 23:11:13 -0300
Message-Id: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Disclaimer: these patches are implememented on top of the previous
SM work, so they are subject to change.

These patches start support for generating and storing the keys
produced during SM Phase 3. These patches will open the way for
having proper pairing over Low Energy connections.

As standard HCI commands don't provide any way for being notified
of new Low Energy keys, these patches extend some commands and
events from the Management Interface.

I still don't like the way that the STK is stored:
"Bluetooth: Use the link key list to temporarily store the STK"
I would like very much to hear some alternative ideas.

Another thing that I would like your opinion on is that some LE
profiles have some restrictions on the size of the key that was
used for encryption. I added a new field to struct bt_security
for this purpose:
"Bluetooth: Add support for returning the encryption key size"

The associated userspace patches can be found here[1].

--
Cheers,

[1] git://git.infradead.org/users/vcgomes/bluez.git mgmt
    http://git.infradead.org/users/vcgomes/bluez.git (branch mgmt)

Vinicius Costa Gomes (15):
  Bluetooth: Add support for SMP phase 3 (key distribution)
  Bluetooth: Fix sending wrong IO Capabilities value
  Bluetooth: Add new structures for supporting SM key distribution
  Bluetooth: Add functions to manipulate the link key list for SMP
  Bluetooth: Reject an encryption request when the key isn't found
  Bluetooth: Add support for providing parameters to LE Start
    Encryption
  Bluetooth: Fix SM pairing parameters negotiation
  Bluetooth: Add support for storing the LTK
  Bluetooth: Use the link key list to temporarily store the STK
  Bluetooth: Use the stored LTK for restabilishing security
  Bluetooth: Remove unused field in hci_conn
  Bluetooth: Add support for communicating keys with userspace
  Bluetooth: Fix style issues reported by checkpatch.pl
  Bluetooth: Add support for storing the key length
  Bluetooth: Add support for returning the encryption key size

 include/net/bluetooth/bluetooth.h |   34 +++---
 include/net/bluetooth/hci_core.h  |   29 +++++-
 include/net/bluetooth/mgmt.h      |    4 +-
 include/net/bluetooth/smp.h       |    1 +
 net/bluetooth/hci_conn.c          |    5 +-
 net/bluetooth/hci_core.c          |   82 +++++++++++++
 net/bluetooth/hci_event.c         |   19 +++-
 net/bluetooth/l2cap_core.c        |    1 +
 net/bluetooth/l2cap_sock.c        |    4 +
 net/bluetooth/mgmt.c              |   60 ++++++++---
 net/bluetooth/smp.c               |  227 ++++++++++++++++++++++++++++++++++---
 11 files changed, 412 insertions(+), 54 deletions(-)

--
1.7.4.1
