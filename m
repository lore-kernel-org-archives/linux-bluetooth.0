Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 0/5] LE Connection
Date: Wed,  4 Apr 2012 17:16:05 -0300
Message-Id: <1333570570-1288-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This RFC v2 series implements all comments from previous version sent last
week. It also implements the remaining kernel changes (step 4).

The main changes are:
1. Move and rename address type macros to bluetooth.h
2. Remove advertising cache code

Claudio is about to send the user-space RFC series (step 2). It basically
set the address type info for LE connect() calls. This RFC series and
Claudio's RFC series implement all four steps (described in previous cover
letter) which enable user-space informing the address type to kernel in order
to properly establish LE connections.

>From previous cover letter:
----- cut -----
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
----- cut -----

BTW, this series depends on "[PATCH] Bluetooth: Remove MGMT_ADDR_INVALID macro"
already sent to the ML.

Regards,

Andre Guedes


Andre Guedes (5):
  Bluetooth: Add address type to struct sockaddr_l2
  Bluetooth: Move address type macros to bluetooth.h
  Bluetooth: Add dst_type parameter to hci_connect
  Bluetooth: Use address type info from User-space
  Bluetooth: Remove advertising cache

 include/net/bluetooth/bluetooth.h |    5 +++
 include/net/bluetooth/hci_core.h  |   27 ++++---------
 include/net/bluetooth/l2cap.h     |    3 +-
 net/bluetooth/hci_conn.c          |   12 ++----
 net/bluetooth/hci_core.c          |   75 -------------------------------------
 net/bluetooth/hci_event.c         |    7 ----
 net/bluetooth/l2cap_core.c        |   11 +++---
 net/bluetooth/l2cap_sock.c        |    2 +-
 net/bluetooth/mgmt.c              |   36 +++++++++---------
 net/bluetooth/sco.c               |    3 +-
 10 files changed, 45 insertions(+), 136 deletions(-)

-- 
1.7.9.4

