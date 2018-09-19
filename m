Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mallikarjun Phulari <mallikarjun.phulari@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth : Errata Service Release 8 Erratum 3253
Date: Wed, 19 Sep 2018 15:21:54 +0530
Message-Id: <1537350714-32105-1-git-send-email-mallikarjun.phulari@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

L2CAP: Changes include the new result codes for the l2cap channel
create/connect request. The new result code are:
0x0006 - sent in the response when the CID is not in valid dynamic range.
0x0007 sent in the response when the CID is already allocated.
---
 include/net/bluetooth/l2cap.h |  6 ++++++
 net/bluetooth/l2cap_core.c    | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0697fd4..eb0c8d0 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -284,6 +284,12 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_INVALID_SCID	0x0009
 #define L2CAP_CR_SCID_IN_USE	0x000A
 
+/* connect/create channel results
+ * As per Erratum 3253
+ */
+#define L2CAP_CR_BREDR_INVALID_SCID	0x0006
+#define L2CAP_CR_BREDR_SCID_IN_USE	0x0007
+
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
 #define L2CAP_CS_AUTHEN_PEND	0x0001
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9b7907e..85887df 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3814,9 +3814,21 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	}
 
 	result = L2CAP_CR_NO_MEM;
+	/* As per Erratum 3253, check the CID is in valid dynamic range and
+	 *  is not allocated already. Send the new result codes accordingly
+	 */
+
+	/* Check for valid dynamic CID range */
+	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {
+		result = L2CAP_CR_BREDR_INVALID_SCID;
+		chan = NULL;
+		goto response;
+	}
 
 	/* Check if we already have channel with that dcid */
 	if (__l2cap_get_chan_by_dcid(conn, scid))
+		result = L2CAP_CR_BREDR_SCID_IN_USE;
+		chan = NULL;
 		goto response;
 
 	chan = pchan->ops->new_connection(pchan);
-- 
2.7.4
