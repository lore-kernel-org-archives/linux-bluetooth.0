Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 0/3] Set of patches fixing kernel crash
Date: Thu, 24 Mar 2011 17:16:05 +0200
Message-Id: <1300979768-31963-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Kernel crash can happen in l2cap_conn_start as it was already
reported in:
http://www.spinics.net/lists/linux-bluetooth/msg11026.html
and:
http://www.spinics.net/lists/linux-bluetooth/msg10962.html

In my case crash happens when two devices connect to each other
at the same time and unbound L2CAP Information Requests mess up
req/rsp sequence. Patch makes sure that we do not process
out of the sequence packet. info_timer clean up hanging connections.

Andrei Emeltchenko (3):
  Bluetooth: check info_rsp ident and states
  Bluetooth: remove duplicated code
  Bluetooth: delete hanging L2CAP channel

 net/bluetooth/l2cap_core.c |   18 +++++++++++-------
 net/bluetooth/l2cap_sock.c |    5 +++--
 2 files changed, 14 insertions(+), 9 deletions(-)

