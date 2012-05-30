Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Rename L2CAP_LE_DEFAULT_MTU
Date: Wed, 30 May 2012 15:08:49 -0300
Message-Id: <1338401329-31429-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1338401329-31429-1-git-send-email-andre.guedes@openbossa.org>
References: <1338401329-31429-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames L2CAP_LE_DEFAULT_MTU macro to L2CAP_LE_MIN_MTU
since it represents the minimum MTU value, not the default MTU
value for LE.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_sock.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a00b43e..ce99c56 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -40,11 +40,11 @@
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1009    /* Sized for 3-DH5 packet */
 #define L2CAP_DEFAULT_ACK_TO		200
-#define L2CAP_LE_DEFAULT_MTU		23
 #define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
 #define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
 #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
 #define L2CAP_BREDR_MAX_PAYLOAD		1019    /* 3-DH5 packet */
+#define L2CAP_LE_MIN_MTU		23
 
 #define L2CAP_DISC_TIMEOUT		msecs_to_jiffies(100)
 #define L2CAP_DISC_REJ_TIMEOUT		msecs_to_jiffies(5000)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a7ac747..3ee7995 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -449,7 +449,7 @@ static bool is_valid_mtu(struct l2cap_chan *chan, u16 mtu)
 {
 	switch (chan->scid) {
 	case L2CAP_CID_LE_DATA:
-		if (mtu < L2CAP_LE_DEFAULT_MTU)
+		if (mtu < L2CAP_LE_MIN_MTU)
 			return 0;
 		break;
 
-- 
1.7.10.2

