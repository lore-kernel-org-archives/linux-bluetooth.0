Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC v2 0/6] LE advertising cache
Date: Fri, 11 Mar 2011 10:32:51 -0300
Message-Id: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During a LE connection establishment, the host should be able to infer the
bdaddr type from a given bdaddr.

To achieve that, during the LE scanning, the host stores the bdaddr and the
bdaddr type gathered from advertising reports. The host keeps a list of
advertising entry (bdaddr and bdaddr_type) for later lookup. This list will
be called Advertising Cache.

Since the penality to connect to an unreachable device is relatively high,
we must keep only fresh advertising entries on the advertising cache. So,
before each LE scanning the advertising cache is cleared. Also, after the LE
scanning, a timer is set to clear the cache.

Next steps include removing all advertising cache from userspace and
implementing a mechanism to sync kernel and userspace advertising cache.

Patches are rebased using Vinicius SMP patches, repo:
git://git.infradead.org/users/vcgomes/linux-2.6.git for-next

Anderson Briglia (1):
  Bluetooth: Implement advertising report meta event

Andre Guedes (5):
  Bluetooth: LE advertising info caching
  Bluetooth: Protect adv_entries with a RW semaphore
  Bluetooth: Check advertising cache in hci_connect()
  Bluetooth: Clear advertising cache before scanning
  Bluetooth: Add a timer to clear the advertising cache

 include/net/bluetooth/hci.h      |   20 ++++++++
 include/net/bluetooth/hci_core.h |   16 +++++++
 net/bluetooth/hci_conn.c         |   12 ++++-
 net/bluetooth/hci_core.c         |   92 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   47 +++++++++++++++++++
 5 files changed, 184 insertions(+), 3 deletions(-)

