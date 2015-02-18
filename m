Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: Clean up hci_cb usage
Date: Wed, 18 Feb 2015 14:53:53 +0200
Message-Id: <1424264038-32153-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches cleans up the usage of the hci_cb list as well as
the couple of unnecesasry layers of abstraction with hci_*_cb() calling
hci_proto_*_cb() functions. These patches also pave the way for other
modules, such as 6lowpan, to easily track the coming and going of
connections, now that connect_cfm & disconn_cfm are accessible through
the hci_cb list.

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Add new hci_cb entries to the tail rather than the head
      Bluetooth: Convert hci_cb_list_lock to a mutex
      Bluetooth: Convert L2CAP security callback to use hci_cb
      Bluetooth: Convert connect_cfm to be triggered through hci_cb
      Bluetooth: Convert disconn_cfm to be triggered through hci_cb

 include/net/bluetooth/hci_core.h | 140 ++++++++++++------------------------
 net/bluetooth/hci_conn.c         |   6 +-
 net/bluetooth/hci_core.c         |  12 ++--
 net/bluetooth/hci_event.c        |  38 +++++-----
 net/bluetooth/l2cap_core.c       |  26 +++++--
 net/bluetooth/sco.c              |  21 +++++-
 6 files changed, 113 insertions(+), 130 deletions(-)

