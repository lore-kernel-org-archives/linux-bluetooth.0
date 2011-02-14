Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 0/5] Advertising reports cache
Date: Mon, 14 Feb 2011 18:59:55 -0300
Message-Id: <4d59a5fe.859ddc0a.46cb.5142@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

The following patches implement a list for advertising report events from LE
devices in order to store the bdaddr and bdaddr type.
Next steps include remove all advertising reports cache from userspace and
implement a mechanism to sync kernel advertising cache and userspace adv cache.

Patches are rebased using Vinicius SMP patches, repo:
git://git.infradead.org/users/vcgomes/linux-2.6.git for-next

Anderson Briglia (1):
  Bluetooth: Implement advertising report meta event

Andre Guedes (4):
  Bluetooth: Implement advertising reports cache
  Bluetooth: Add device addr type to hci_le_connect
  Bluetooth: limit size of advertising reports cache
  Bluetooth: hci_connect() should return status code

 include/net/bluetooth/hci.h      |   18 +++++++++
 include/net/bluetooth/hci_core.h |   20 ++++++++++-
 net/bluetooth/hci_conn.c         |   40 ++++++++++++++-------
 net/bluetooth/hci_core.c         |   73 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   24 ++++++++++++
 net/bluetooth/l2cap_core.c       |    9 ++---
 net/bluetooth/sco.c              |    8 ++--
 7 files changed, 169 insertions(+), 23 deletions(-)

