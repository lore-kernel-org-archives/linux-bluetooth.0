Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] L2CAP: Locking and refcnt fixes 
Date: Fri, 29 Jun 2012 16:58:33 +0300
Message-Id: <1340978315-4700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add refcnt to l2cap_conn and locking to L2CAP sockopt handling.

Andrei Emeltchenko (2):
  Bluetooth: Add refcnt to l2cap_conn
  Bluetooth: Lock l2cap chan in sockopt

 include/net/bluetooth/l2cap.h |    6 ++
 net/bluetooth/l2cap_core.c    |  128 +++++++++++++++++++++++++++++++++--------
 net/bluetooth/l2cap_sock.c    |   12 ++++
 net/bluetooth/smp.c           |    7 +--
 4 files changed, 125 insertions(+), 28 deletions(-)

-- 
1.7.9.5

