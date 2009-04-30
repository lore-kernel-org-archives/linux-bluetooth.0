Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH 01/10] Add #defines for enhanced L2CAP constants.
Date: Thu, 30 Apr 2009 17:16:38 -0400
Message-Id: <1241126207-19996-2-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
References: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

This patch #defines the constants needed for implementation of Enhanced
Retranmission and Streaming modes within L2CAP.

Signed-off-by: Nathan Holstein <nathan@lampreynetworks.com>
---
 include/net/bluetooth/l2cap.h |   50 +++++++++++++++++++++++++++++++++++++---
 net/bluetooth/l2cap.c         |    6 ++--
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 18dcb33..21e84fb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -26,12 +26,24 @@
 #define __L2CAP_H
 
 /* L2CAP defaults */
-#define L2CAP_DEFAULT_MTU	672
-#define L2CAP_DEFAULT_FLUSH_TO	0xFFFF
+#define L2CAP_DEFAULT_MTU		672
+#define L2CAP_DEFAULT_MIN_MTU		48
+#define L2CAP_DEFAULT_FLUSH_TO		0xFFFF
+#define L2CAP_DEFAULT_RX_WINDOW		1
+#define L2CAP_DEFAULT_MAX_RECEIVE	1
+#define L2CAP_DEFAULT_RETRANS_TO	300    /* 300 milliseconds */
+#define L2CAP_DEFAULT_MONITOR_TO	1000   /* 1 second */
+#define L2CAP_DEFAULT_MAX_RX_APDU	0xFFF7
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
 
+/* L2CAP feature bits */
+#define L2CAP_FEAT_ERTM		0x00000008
+#define L2CAP_FEAT_STREAM	0x00000010
+#define L2CAP_FEAT_FCS		0x00000020
+#define L2CAP_FEAT_FIXED_CHAN	0x00000080
+
 /* L2CAP socket address */
 struct sockaddr_l2 {
 	sa_family_t	l2_family;
@@ -76,6 +88,35 @@ struct l2cap_conninfo {
 #define L2CAP_INFO_REQ    0x0a
 #define L2CAP_INFO_RSP    0x0b
 
+/* L2CAP Control Field bit masks */
+#define L2CAP_CONTROL_SAR_MASK		0xC000
+#define L2CAP_CONTROL_REQSEQ_MASK	0x3F00
+#define L2CAP_CONTROL_TXSEQ_MASK	0x007E
+#define L2CAP_CONTROL_RETRANS_MASK	0x0080
+#define L2CAP_CONTROL_FINAL_MASK	0x0080
+#define L2CAP_CONTROL_POLL_MASK		0x0010
+#define L2CAP_CONTROL_SUPERVISE_MASK	0x000C
+#define L2CAP_CONTROL_TYPE_MASK		0x0001 /* I- or S-Frame */
+
+#define L2CAP_CONTROL_TXSEQ_SHIFT	1
+#define L2CAP_CONTROL_REQSEQ_SHIFT	8
+
+/* L2CAP Segmentation and Reassembly */
+#define L2CAP_SAR_UNSEGMENTED	0x0000
+#define L2CAP_SAR_SDU_START	0x4000
+#define L2CAP_SAR_SDU_END	0x8000
+#define L2CAP_SAR_SDU_CONTINUE	0xC000
+
+/* L2CAP Supervisory Function */
+#define L2CAP_SUPER_RCV_READY		0x0000
+#define L2CAP_SUPER_REJECT		0x0004
+#define L2CAP_SUPER_RCV_NOT_READY	0x0008
+#define L2CAP_SUPER_SELECT_REJECT	0x000C
+
+/* L2CAP Optional FCS */
+#define L2CAP_FCS_NONE		0x00
+#define L2CAP_FCS_CRC16		0x01
+
 /* L2CAP structures */
 struct l2cap_hdr {
 	__le16     len;
@@ -155,6 +196,7 @@ struct l2cap_conf_opt {
 #define L2CAP_CONF_FLUSH_TO	0x02
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
+#define L2CAP_CONF_FCS		0x05
 
 #define L2CAP_CONF_MAX_SIZE	22
 
@@ -168,8 +210,8 @@ struct l2cap_conf_rfc {
 } __attribute__ ((packed));
 
 #define L2CAP_MODE_BASIC	0x00
-#define L2CAP_MODE_RETRANS	0x01
-#define L2CAP_MODE_FLOWCTL	0x02
+#define L2CAP_MODE_ERTM		0x03
+#define L2CAP_MODE_STREAM	0x04
 
 struct l2cap_disconn_req {
 	__le16     dcid;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index f6a82f2..31901be 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -52,7 +52,7 @@
 
 #define VERSION "2.13"
 
-static u32 l2cap_feat_mask = 0x0080;
+static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
 
 static const struct proto_ops l2cap_sock_ops;
@@ -1747,7 +1747,7 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
 
 		hint  = type & L2CAP_CONF_HINT;
-		type &= 0x7f;
+		type &= (0xFF ^ L2CAP_CONF_HINT);
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -2244,7 +2244,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct l2cap_cm
 	if (type == L2CAP_IT_FEAT_MASK) {
 		conn->feat_mask = get_unaligned_le32(rsp->data);
 
-		if (conn->feat_mask & 0x0080) {
+		if (conn->feat_mask & L2CAP_FEAT_FIXED_CHAN) {
 			struct l2cap_info_req req;
 			req.type = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
 
-- 
1.6.0.6

