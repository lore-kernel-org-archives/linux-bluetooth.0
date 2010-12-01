Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/5] Clean up sco, rfcomm and hci code
Date: Wed,  1 Dec 2010 16:58:21 +0200
Message-Id: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Remove extra spaces, do not use assignments in "if" statements,
remove initialization to zero static vars, other errors
reported by checkpatch.
*v1 RFC
*v2 taken comments from Anderson, Marcel and Gustavo:
	- legal stuff moved to special patch
	- checking for do_inquiry before removing assignments

Andrei Emeltchenko (5):
  Bluetooth: clean up sco code
  Bluetooth: clean up rfcomm code
  Bluetooth: clean up l2cap code
  Bluetooth: clean up hci code
  Bluetooth: clean up legal text

 include/net/bluetooth/hci.h      |   16 ++++----
 include/net/bluetooth/hci_core.h |   14 ++++----
 include/net/bluetooth/l2cap.h    |   22 ++++++------
 include/net/bluetooth/rfcomm.h   |   18 +++++-----
 include/net/bluetooth/sco.h      |   20 ++++++------
 net/bluetooth/hci_conn.c         |   23 ++++++++----
 net/bluetooth/hci_core.c         |   66 ++++++++++++++++++++++++--------------
 net/bluetooth/hci_event.c        |    8 +++--
 net/bluetooth/hci_sock.c         |   17 ++++++---
 net/bluetooth/l2cap.c            |    7 ++--
 net/bluetooth/rfcomm/core.c      |    8 ++--
 net/bluetooth/rfcomm/sock.c      |    5 ++-
 net/bluetooth/rfcomm/tty.c       |   28 +++++++++-------
 net/bluetooth/sco.c              |   22 +++++++-----
 14 files changed, 157 insertions(+), 117 deletions(-)

