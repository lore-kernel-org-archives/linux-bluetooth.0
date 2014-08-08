Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: Convert SMP to use l2cap_chan
Date: Fri,  8 Aug 2014 09:37:14 +0300
Message-Id: <1407479838-5652-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

With this patches we do the initial conversion of SMP to use l2cap_chan
and its related callbacks. There are many more simplifications possible
after this, but to keep the conversion minimal I haven't done those yet.
To keep the code compiling and functional between each patch the code
that introduces the initial callbacks uses a custom 0x1f CID not to
intefere with the legacy SMP CID handling. Only in the last patch which
adds fully functional SMP handling through l2cap_chan is this custom CID
converted back to the proper L2CAP_CID_SMP.

Johan

----------------------------------------------------------------
Johan Hedberg (4):
      Bluetooth: Add more L2CAP convenience callbacks
      Bluetooth: Add SMP L2CAP channel skeleton
      Bluetooth: Make AES crypto context private to SMP
      Bluetooth: Convert SMP to use l2cap_chan infrastructure

 include/net/bluetooth/hci_core.h |   2 +-
 include/net/bluetooth/l2cap.h    |  27 +++-
 net/bluetooth/hci_core.c         |  13 +-
 net/bluetooth/l2cap_core.c       |  10 --
 net/bluetooth/smp.c              | 280 +++++++++++++++++++++++++++--------
 net/bluetooth/smp.h              |   6 +-
 6 files changed, 248 insertions(+), 90 deletions(-)

