Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/6] Bluetooth: EFS: assign default values in chan add
Date: Thu, 13 Oct 2011 16:18:54 +0300
Message-Id: <1318511938-24311-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Assign default EFS values when creating L2CAP channel

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    9 +++++++++
 net/bluetooth/l2cap_core.c    |    7 +++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 860b36f..aa3de2f9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -41,6 +41,9 @@
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1009    /* Sized for 3-DH5 packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_LE_DEFAULT_MTU		23
+#define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
+#define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
+#define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
@@ -296,6 +299,12 @@ struct l2cap_conf_efs {
 	__le32	flush_to;
 } __packed;
 
+#define L2CAP_SERV_NOTRAFIC	0x00
+#define L2CAP_SERV_BESTEFFORT	0x01
+#define L2CAP_SERV_GUARANTEED	0x02
+
+#define L2CAP_BESTEFFORT_ID	0x01
+
 struct l2cap_disconn_req {
 	__le16     dcid;
 	__le16     scid;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 152b68f..a73f77e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -338,6 +338,13 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		chan->omtu = L2CAP_DEFAULT_MTU;
 	}
 
+	chan->local_id		= L2CAP_BESTEFFORT_ID;
+	chan->local_stype	= L2CAP_SERV_BESTEFFORT;
+	chan->local_msdu	= L2CAP_DEFAULT_MAX_SDU_SIZE;
+	chan->local_sdu_itime	= L2CAP_DEFAULT_SDU_ITIME;
+	chan->local_acc_lat	= L2CAP_DEFAULT_ACC_LAT;
+	chan->local_flush_to	= L2CAP_DEFAULT_FLUSH_TO;
+
 	chan_hold(chan);
 
 	list_add(&chan->list, &conn->chan_l);
-- 
1.7.4.1

