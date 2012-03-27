Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/3] LE Connection
Date: Tue, 27 Mar 2012 20:59:33 -0300
Message-Id: <1332892776-12060-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

In order to establish a LE connection, we need to know the address type
(public or random) from the remote device. Since this information was not
exposed to user-space and we were not sure about changing the Bluetooth ABI
at that time, we came up with a in-kernel solution to enable LE connections.

We store sensitive information (bdaddr and bdaddr_type) gathered from LE
advertising report events. Once we get a connection request from user-space,
we search the destination address in the advertising cache to get its type
and then start the connection establishment.

Nevertheless, today, the remote device address type is exposed to user-space
through management interface events. We can use this information to establish
LE connection and drop the advertising cache in kernel.

To achieve that, we may add the address type field to struct sockaddr_l2.
This new field would be used for LE connection only. BR/EDR sockets would just
ignore it. We wouldn't even need to set this field for BR/EDR sockets.

These changes would be taken in four steps:
1. Kernel: add address type info to struct sockaddr_l2 
2. User-space: set the address type field for LE connections
3. Kernel: use address type info from user-space instead of checking
   advertising cache
4. Kernel: remove advertising cache code

This RFC series implements steps 1 and 3. User-space work is still under
development and we'll send a RFC soon. Step 4 would be started as soon as
we have steps 1, 2 and 3 done.

These RFC patches are just to you guys take a look how the code looks like
and provide some comments. They are still under testing.

Feedback are very welcome.

Regards,

Andre Guedes


Andre Guedes (3):
  Bluetooth: Add address type to struct sockaddr_l2
  Bluetooth: Add dst_type parameter to hci_connect
  Bluetooth: Use address type info from User-space

 include/net/bluetooth/hci_core.h |    2 +-
 include/net/bluetooth/l2cap.h    |    3 ++-
 net/bluetooth/hci_conn.c         |   12 ++++--------
 net/bluetooth/l2cap_core.c       |   11 ++++++-----
 net/bluetooth/l2cap_sock.c       |    2 +-
 net/bluetooth/mgmt.c             |    8 ++++----
 net/bluetooth/sco.c              |    3 ++-
 7 files changed, 20 insertions(+), 21 deletions(-)

-- 
1.7.9.4

