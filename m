Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 0/7] Bluetooth: LE Pairing support
Date: Fri, 19 Aug 2011 21:06:49 -0300
Message-Id: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch series add support for LE devices using the mgmt interface.

The greatest change is that we now have to allow LE connections to be reused,
the restriction that we should only have one user for each LE Channel ID is
now in the L2CAP level.

If this patch series is to be applied, it should be applied first. I messed up
here when sending the patches. My bad.


--

Vinicius Costa Gomes (7):
  Bluetooth: Reset the security timer when a command is queued
  Bluetooth: Add a flag to indicate that SMP is going on
  Bluetooth: Use the same timeouts for both ACL and LE links
  Bluetooth: Add support for reusing the same hci_conn for LE links
  Bluetooth: Add support for pairing via mgmt over LE
  Bluetooth: Add support for running SMP without a socket
  Bluetooth: Add link_type information to the mgmt Connected event

 include/net/bluetooth/hci_core.h |    5 ++-
 include/net/bluetooth/mgmt.h     |    1 +
 net/bluetooth/hci_conn.c         |   31 +++++++++--------
 net/bluetooth/hci_event.c        |    4 +-
 net/bluetooth/l2cap_core.c       |   70 +++++++++++++++++++++++++++-----------
 net/bluetooth/mgmt.c             |   18 ++++++++--
 net/bluetooth/smp.c              |   59 ++++++++++++++++++++------------
 7 files changed, 124 insertions(+), 64 deletions(-)

--
1.7.6

