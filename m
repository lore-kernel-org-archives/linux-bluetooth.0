Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 00/16] l2cap.c split
Date: Fri,  4 Feb 2011 04:01:42 -0200
Message-Id: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here is the first real split of l2cap.c file. That file was getting so big that
we really need to split it in two or more. By now we have two file:
l2cap_sock.c and l2cap_core.c. In l2cap_sock.c we have all functions that deals
with sockets, in l2cap_core.c the rest.

Side efects are that I had to move the declaration of many functions to l2cap.h
along the l2cap socket list.

There are more steps on this, but this is surely a big one.

Gustavo F. Padovan (16):
  Bluetooth: Rename l2cap.c to l2cap_core.c
  Bluetooth: Initial work for L2CAP split.
  Bluetooth: move l2cap_sock_ops to l2cap_sock.c
  Bluetooth: move l2cap_sock_release() to l2cap_sock.c
  Bluetooth: move l2cap_sock_bind()/listen() to l2cap_sock.c
  Bluetooth: move l2cap_sock_accept() to l2cap_sock.c
  Bluetooth: move l2cap_sock_getname() to l2cap_sock.c
  Bluetooth: move l2cap_sock_setsockopt() to l2cap_sock.c
  Bluetooth: move l2cap_sock_getsockopt() to l2cap_sock.c
  Bluetooth: move l2cap_sock_connect() to l2cap_sock.c
  Bluetooth: move l2cap_sock_recvmsg() to l2cap_sock.c
  Bluetooth: move l2cap_sock_shutdown() to l2cap_sock.c
  Bluetooth: move l2cap_sock_sendmsg() to l2cap_sock.c
  Bluetooth: move L2CAP sock timers function to l2cap_sock.c
  Bluetooth: move l2cap_sock_kill() to l2cap_sock.c
  Bluetooth: move __l2cap_sock_close() to l2cap_sock.c

 include/net/bluetooth/l2cap.h |   31 +
 net/bluetooth/Makefile        |    1 +
 net/bluetooth/l2cap.c         | 4983 -----------------------------------------
 net/bluetooth/l2cap_core.c    | 3879 ++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c    | 1150 ++++++++++
 5 files changed, 5061 insertions(+), 4983 deletions(-)
 delete mode 100644 net/bluetooth/l2cap.c
 create mode 100644 net/bluetooth/l2cap_core.c
 create mode 100644 net/bluetooth/l2cap_sock.c

-- 
1.7.4.rc3

