Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/15] L2CAP Rewrite (or create proper struct l2cap_chan)
Date: Fri,  1 Apr 2011 19:33:05 -0300
Message-Id: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset is the very beginning of a series of patches to remove the
socket dependence from the core l2cap operations. The main motivation around
this is to have a clear separation between L2CAP socket operations and L2CAP
channels operations.

By fixing this we will be able to fix the RFCOMM's L2CAP usage, that today is
via the socket calls from inside the kernel. This approach is totally mess
and have been a headache for almost ten years now due to inumerous locking
bugs that we had.

Next step is keep cleaning l2cap_core.c by removing socket references from it.
In short, we will be done, when l2cap_core.c is clean of any socket reference
and we write a API to access L2CAP core from l2cap_sock.c, RFCOMM and in the
future AMP Manager.

These first changes are very simple, hopefully, it's not breaking anything.
But of course I'll test all the changes against PTS, before they reach Linus'
tree. Please review.

Gustavo F. Padovan (15):
  Bluetooth: Create struct l2cap_chan
  Bluetooth: Use struct list_head for L2CAP channels list
  Bluetooth: Remove struct del_list
  Bluetooth: Move ident to struct l2cap_chan
  Bluetooth: Move conf_{req,rsp} stuff to struct l2cap_chan
  Bluetooth: clean up l2cap_sock_recvmsg()
  Bluetooth: Move conn_state to struct l2cap_chan
  Bluetooth: Move of ERTM *_seq vars to struct l2cap_chan
  Bluetooth: Move more ERTM stuff to struct l2cap_chan
  Bluetooth: Move SDU related vars to struct l2cap_chan
  Bluetooth: Move remote info to struct l2cap_chan
  Bluetooth: Move ERTM timers to struct l2cap_chan
  Bluetooth: Move srej and busy queues to struct l2cap_chan
  Bluetooth: Move busy workqueue to struct l2cap_chan
  Bluetooth: Fix lockdep warning with skb list lock

 include/net/bluetooth/l2cap.h |  113 ++--
 net/bluetooth/l2cap_core.c    | 1226 ++++++++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c    |   62 +--
 3 files changed, 730 insertions(+), 671 deletions(-)

-- 
1.7.4.1

