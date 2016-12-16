Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/3] Bluetooth: Don't force MGMT device connected
Date: Fri, 16 Dec 2016 14:19:26 +0200
Message-Id: <20161216121929.26476-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set attempt to fix a race where Read Name command is pending but
L2CAP connection request comes in which forced MGMT Device Connected event
to allow userspace to handle the incoming connection causing the device
to have no name.

In order to fix this the code will no longer send the event and instead
will put the socket into BT_CONNECT2 and respond with pending result, then
once Read Name completes it will continue the connection handling and
emit Device Connected event with a proper name.

Preliminary test did not show any regression but there could devices that
don't behave well if there are multiple responses with pending result so
this has to go more extensive testing thus why Im sending first as RFC.

Luiz Augusto von Dentz (3):
  Bluetooth: L2CAP: Use l2cap_request_info whenever requesting info
  Bluetooth: Don't force MGMT device connected on L2CAP connection
    request
  Bluetooth: L2CAP: Rework code around Connect Response

 include/net/bluetooth/hci_core.h |  13 ++
 include/net/bluetooth/l2cap.h    |   1 +
 net/bluetooth/hci_event.c        |  16 ++-
 net/bluetooth/l2cap_core.c       | 287 +++++++++++++++++++--------------------
 4 files changed, 168 insertions(+), 149 deletions(-)

-- 
2.9.3

