Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/4] Clean up sco, rfcomm and hci code
Date: Fri, 26 Nov 2010 17:22:41 +0200
Message-Id: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Remove extra spaces, do not use assignments in "if" statements,
remove initialization to zero static vars, other errors
reported by checkpatch.

Andrei Emeltchenko (4):
  Bluetooth: cleanup sco code
  Bluetooth: clean up rfcomm code
  Bluetooth: clean up l2cap code
  Bluetooth: clean up hci code

 include/net/bluetooth/hci.h      |   16 +++++-----
 include/net/bluetooth/hci_core.h |   14 ++++----
 include/net/bluetooth/l2cap.h    |   22 +++++++-------
 include/net/bluetooth/rfcomm.h   |   18 ++++++------
 include/net/bluetooth/sco.h      |   20 ++++++------
 net/bluetooth/hci_conn.c         |   23 ++++++++++-----
 net/bluetooth/hci_core.c         |   57 ++++++++++++++++++++++++--------------
 net/bluetooth/hci_event.c        |    8 +++--
 net/bluetooth/hci_sock.c         |   17 +++++++----
 net/bluetooth/l2cap.c            |    7 ++--
 net/bluetooth/rfcomm/core.c      |    8 ++--
 net/bluetooth/rfcomm/sock.c      |    5 ++-
 net/bluetooth/rfcomm/tty.c       |   28 ++++++++++--------
 net/bluetooth/sco.c              |   22 ++++++++------
 14 files changed, 151 insertions(+), 114 deletions(-)

