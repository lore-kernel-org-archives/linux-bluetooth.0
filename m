Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/2] L2CAP: Locking and refcnt fixes 
Date: Fri, 13 Jul 2012 15:07:44 +0300
Message-Id: <1342181266-26323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340978315-4700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340978315-4700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add refcnt to l2cap_conn and locking to L2CAP sockopt handling.

Changes:
	* v1: change refcnt printing to similar used for l2cap_chan.

Andrei Emeltchenko (2):
  Bluetooth: Add refcnt to l2cap_conn
  Bluetooth: Lock l2cap chan in sockopt

 include/net/bluetooth/l2cap.h |    6 ++
 net/bluetooth/l2cap_core.c    |  126 +++++++++++++++++++++++++++++++++--------
 net/bluetooth/l2cap_sock.c    |   12 ++++
 net/bluetooth/smp.c           |    7 +--
 4 files changed, 123 insertions(+), 28 deletions(-)

-- 
1.7.9.5

