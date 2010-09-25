Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: Pull resquest review to 2.6.36-rc5
Date: Fri, 24 Sep 2010 22:01:38 -0300
Message-Id: <1285376504-3541-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

These are the patches we have queued for the Bluetooth subsystem intended to be
pushed into 2.6.36. We are bit late already, please make any comment as soon as
possible then  we can hurry and pull those to wireless-2.6 on Monday maybe.


The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:

  Linux 2.6.36-rc5 (2010-09-20 16:56:53 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-2.6.git master

Andrei Emeltchenko (1):
      Bluetooth: fix MTU L2CAP configuration parameter

Gustavo F. Padovan (4):
      Bluetooth: Simplify L2CAP Streaming mode sending
      Bluetooth: Fix inconsistent lock state with RFCOMM
      Revert "Bluetooth: Don't accept ConfigReq if we aren't in the BT_CONFIG state"
      Bluetooth: Fix deadlock in the ERTM logic

Mat Martineau (1):
      Bluetooth: Only enable for L2CAP FCS for ERTM or streaming

 include/net/bluetooth/bluetooth.h |   11 +++++++
 net/bluetooth/l2cap.c             |   57 +++++++++++++++---------------------
 net/bluetooth/rfcomm/sock.c       |    4 ++
 3 files changed, 39 insertions(+), 33 deletions(-)


