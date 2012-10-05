Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/7] Bluetooth: L2CAP: Fix using default Flush Timeout for EFS
Date: Fri,  5 Oct 2012 16:56:52 +0300
Message-Id: <1349445419-16788-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

There are two Flush Timeouts: one is old Flush Timeot Option
which is 2 octets and the second is Flush Timeout inside EFS
which is 4 octets long.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    3 ++-
 net/bluetooth/l2cap_core.c    |   10 ++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ab58b81..83fb9c7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -32,7 +32,8 @@
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
 #define L2CAP_DEFAULT_MIN_MTU		48
-#define L2CAP_DEFAULT_FLUSH_TO		0xffff
+#define L2CAP_DEFAULT_FLUSH_TO		0xFFFF
+#define L2CAP_EFS_DEFAULT_FLUSH_TO	0xFFFFFFFF
 #define L2CAP_DEFAULT_TX_WINDOW		63
 #define L2CAP_DEFAULT_EXT_WINDOW	0x3FFF
 #define L2CAP_DEFAULT_MAX_TX		3
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b4e707b..ab6853d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -504,7 +504,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	chan->local_msdu	= L2CAP_DEFAULT_MAX_SDU_SIZE;
 	chan->local_sdu_itime	= L2CAP_DEFAULT_SDU_ITIME;
 	chan->local_acc_lat	= L2CAP_DEFAULT_ACC_LAT;
-	chan->local_flush_to	= L2CAP_DEFAULT_FLUSH_TO;
+	chan->local_flush_to	= L2CAP_EFS_DEFAULT_FLUSH_TO;
 
 	l2cap_chan_hold(chan);
 
@@ -2714,8 +2714,10 @@ static void l2cap_add_opt_efs(void **ptr, struct l2cap_chan *chan)
 		efs.stype	= chan->local_stype;
 		efs.msdu	= cpu_to_le16(chan->local_msdu);
 		efs.sdu_itime	= cpu_to_le32(chan->local_sdu_itime);
-		efs.acc_lat	= __constant_cpu_to_le32(L2CAP_DEFAULT_ACC_LAT);
-		efs.flush_to	= __constant_cpu_to_le32(L2CAP_DEFAULT_FLUSH_TO);
+		efs.acc_lat	=
+			__constant_cpu_to_le32(L2CAP_DEFAULT_ACC_LAT);
+		efs.flush_to	=
+			__constant_cpu_to_le32(L2CAP_EFS_DEFAULT_FLUSH_TO);
 		break;
 
 	case L2CAP_MODE_STREAMING:
@@ -2732,7 +2734,7 @@ static void l2cap_add_opt_efs(void **ptr, struct l2cap_chan *chan)
 	}
 
 	l2cap_add_conf_opt(ptr, L2CAP_CONF_EFS, sizeof(efs),
-							(unsigned long) &efs);
+			   (unsigned long) &efs);
 }
 
 static void l2cap_ack_timeout(struct work_struct *work)
-- 
1.7.9.5

