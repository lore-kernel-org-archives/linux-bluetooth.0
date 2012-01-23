Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove old unused lock
Date: Mon, 23 Jan 2012 11:11:03 +0200
Message-Id: <1327309863-12696-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f6d5134..c21e37a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -544,7 +544,6 @@ struct l2cap_conn {
 	struct smp_chan *smp_chan;
 
 	struct list_head chan_l;
-	struct mutex	chan_lock;
 };
 
 #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01
-- 
1.7.4.1

