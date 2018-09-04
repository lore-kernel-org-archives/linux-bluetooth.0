Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] Bluetooth: L2CAP: Improve credits logic
Date: Tue,  4 Sep 2018 13:39:19 +0300
Message-Id: <20180904103922.25504-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These changes replace the existing threshold logic with a limpler logic
that gives back credits after receiving an SDU. It also removes the
debugfs entries to configure the MPS and credits with auto selected one
derived from the MTU and MPS.

v2: Account from the SDU length when adjusting the MPS.

Luiz Augusto von Dentz (3):
  Bluetooth: L2CAP: Derive MPS from connection MTU
  Bluetooth: L2CAP: Derive rx credits from MTU and MPS
  Bluetooth: L2CAP: Detect if remote is not able to use the whole MPS

 include/net/bluetooth/l2cap.h |  3 --
 net/bluetooth/l2cap_core.c    | 66 +++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 25 deletions(-)

-- 
2.17.1
