Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 4/4] Bluetooth: add A2MP fixed channel when hs_enabled
Date: Wed, 12 Oct 2011 10:53:59 +0300
Message-Id: <1318406039-24843-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318406039-24843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318406039-24843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds A2MP fixed channel in L2CAP fixed channel supported.
Remove magic numbers and simplify code as we need only 1 octet.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    5 +++++
 net/bluetooth/l2cap_core.c    |   12 ++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 45d1814..f195978 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -112,6 +112,10 @@ struct l2cap_conninfo {
 #define L2CAP_FCS_NONE		0x00
 #define L2CAP_FCS_CRC16		0x01
 
+/* L2CAP fixed channels */
+#define L2CAP_FC_L2CAP		0x02
+#define L2CAP_FC_A2MP		0x08
+
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR			0xC000
 #define L2CAP_CTRL_REQSEQ		0x3F00
@@ -441,6 +445,7 @@ struct l2cap_conn {
 	unsigned int	mtu;
 
 	__u32		feat_mask;
+	__u8		fc_mask;
 
 	__u8		info_state;
 	__u8		info_ident;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9144d70..152b68f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -60,7 +60,7 @@ int disable_ertm;
 int enable_hs;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
-static u8 l2cap_fixed_chan[8] = { 0x02, };
+static u8 l2cap_fixed_chan = L2CAP_FC_L2CAP;
 
 static LIST_HEAD(chan_list);
 static DEFINE_RWLOCK(chan_list_lock);
@@ -2891,9 +2891,16 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 	} else if (type == L2CAP_IT_FIXED_CHAN) {
 		u8 buf[12];
 		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
+
+		memset(buf, 0, sizeof(buf));
 		rsp->type   = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
 		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
-		memcpy(buf + 4, l2cap_fixed_chan, 8);
+
+		if (enable_hs)
+			l2cap_fixed_chan |= L2CAP_FC_A2MP;
+
+		rsp->data[0] = l2cap_fixed_chan;
+
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
 	} else {
@@ -2951,6 +2958,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 			l2cap_conn_start(conn);
 		}
 	} else if (type == L2CAP_IT_FIXED_CHAN) {
+		conn->fc_mask = rsp->data[0];
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
 
-- 
1.7.4.1

