Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 00/12] Caching LE advertising information
Date: Fri,  6 May 2011 14:05:09 -0300
Message-Id: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patchset implements the LE advertising cache which is used
to establish LE connections.

Today, we cannot establish LE connections (via l2cap socket) with
devices which use random address type. To achieve that, we came up
with a solution where the host should be able to infer the address
type (public or random) from the device it wants to connect to.

The approach this patchset implements is: during the LE scanning,
the host stores the address and the address type gathered from
advertising reports. These information are stored at the advertising
cache. So, during a LE connection, the host looks up the advertising
cache and gets the address type from the device it wants to connect
to.

Since the penality to connect to an unreachable device is relatively
high, we must keep only fresh advertising entries in the advertising
cache. So, before each LE scanning the advertising cache is cleared.
Also, after the LE scanning, a timer is set to clear the cache.

Thanks,

Andre Guedes.

Anderson Briglia (2):
  Bluetooth: Add advertising report meta event structs
  Bluetooth: Add advertising report meta event handler

Andre Guedes (10):
  Bluetooth: LE advertising cache
  Bluetooth: Protect 'adv_entries' with a RW lock
  Bluetooth: LE Set Scan Enable command complete event
  Bluetooth: Clear advertising cache before scanning
  Bluetooth: Advertising entries lifetime
  Bluetooth: Add 'dst_type' field to struct hci_conn
  Bluetooth: Add hci_le_conn_add()
  Bluetooth: Remove useless check in hci_connect()
  Bluetooth: Check advertising cache in hci_connect()
  Bluetooth: Set 'peer_addr_type' in hci_le_connect()

 include/net/bluetooth/hci.h      |   21 ++++++++
 include/net/bluetooth/hci_core.h |   19 ++++++++
 net/bluetooth/hci_conn.c         |   26 +++++++++-
 net/bluetooth/hci_core.c         |   96 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   56 +++++++++++++++++++++-
 5 files changed, 213 insertions(+), 5 deletions(-)

