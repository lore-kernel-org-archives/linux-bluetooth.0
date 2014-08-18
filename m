Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Bluetooth: SMP & disconnection fixes
Date: Mon, 18 Aug 2014 20:33:26 +0300
Message-Id: <1408383214-16366-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The previous patches for SMP disconnection (that already got applied) do
indeed fix the hci_conn_hold/drop ballance and do ensure that we
disconnect the link when the SMP code wants it. Unfortunately the
patches introduce a regression to a third use case which is the one
where we want to bring the link down when there are no more active users
for it.

It turns out that relying on connection users to diligently call
hci_conn_drop() isn't a reliable way to ensure that the connection goes
away. Firstly, we can't have hci_chan own such a reference (since it's
"always there") and secondly there might not be any users at all
(besides SMP) in which case there will be no-one to call hci_conn_drop.

A simpler solution is to just do a direct disonnect from smp.c with the
help of the hci_disconnect() function. This has the side effect of not
sending any SMP Failure PDU first, but the cases needing a disconnection
do not really need that PDU to be sent (i.e. SMP timeout or garbage
data).

The last three patches in this set unify hci_disconnect() usage to also
cover the Disconnect Device mgmt command and move clock offset reading
into the function to ensure all users have this feature at their
disposal.

Johan

----------------------------------------------------------------
Johan Hedberg (8):
      Bluetooth: Remove hci_conn_hold/drop from hci_chan
      Bluetooth: Set discon_timeout to 0 in l2cap_conn_del
      Bluetooth: Use hci_disconnect for immediate disconnection from SMP
      Bluetooth: Remove unused l2cap_conn_shutdown API
      Bluetooth: Fix SMP error and response to be mutually exclusive
      Bluetooth: Update hci_disconnect() to return an error value
      Bluetooth: Use hci_disconnect() for mgmt_disconnect_device()
      Bluetooth: Move clock offset reading into hci_disconnect()

 include/net/bluetooth/hci_core.h |  2 +-
 include/net/bluetooth/l2cap.h    |  4 ----
 net/bluetooth/hci_conn.c         | 41 ++++++++++++++----------------------
 net/bluetooth/l2cap_core.c       | 28 +++---------------------
 net/bluetooth/mgmt.c             |  6 +-----
 net/bluetooth/smp.c              | 17 ++++++---------
 6 files changed, 28 insertions(+), 70 deletions(-)


