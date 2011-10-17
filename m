Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: convert spaces to tabs in l2cap
Date: Mon, 17 Oct 2011 16:50:23 +0300
Message-Id: <1318859423-26489-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |  108 ++++++++++++++++++++--------------------
 1 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5a0fdc1..e07a964 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -59,19 +59,19 @@ struct sockaddr_l2 {
 /* L2CAP socket options */
 #define L2CAP_OPTIONS	0x01
 struct l2cap_options {
-	__u16 omtu;
-	__u16 imtu;
-	__u16 flush_to;
-	__u8  mode;
-	__u8  fcs;
-	__u8  max_tx;
-	__u16 txwin_size;
+	__u16	omtu;
+	__u16	imtu;
+	__u16	flush_to;
+	__u8	mode;
+	__u8	fcs;
+	__u8	max_tx;
+	__u16	txwin_size;
 };
 
 #define L2CAP_CONNINFO	0x02
 struct l2cap_conninfo {
-	__u16 hci_handle;
-	__u8  dev_class[3];
+	__u16	hci_handle;
+	__u8	dev_class[3];
 };
 
 #define L2CAP_LM	0x03
@@ -169,8 +169,8 @@ struct l2cap_conninfo {
 
 /* L2CAP structures */
 struct l2cap_hdr {
-	__le16     len;
-	__le16     cid;
+	__le16	len;
+	__le16	cid;
 } __packed;
 #define L2CAP_HDR_SIZE		4
 #define L2CAP_ENH_HDR_SIZE	6
@@ -181,36 +181,36 @@ struct l2cap_hdr {
 #define L2CAP_PSMLEN_SIZE	2
 
 struct l2cap_cmd_hdr {
-	__u8       code;
-	__u8       ident;
-	__le16     len;
+	__u8	code;
+	__u8	ident;
+	__le16	len;
 } __packed;
 #define L2CAP_CMD_HDR_SIZE	4
 
 struct l2cap_cmd_rej_unk {
-	__le16     reason;
+	__le16	reason;
 } __packed;
 
 struct l2cap_cmd_rej_mtu {
-	__le16     reason;
-	__le16     max_mtu;
+	__le16	reason;
+	__le16	max_mtu;
 } __packed;
 
 struct l2cap_cmd_rej_cid {
-	__le16     reason;
-	__le16     scid;
-	__le16     dcid;
+	__le16	reason;
+	__le16	scid;
+	__le16	dcid;
 } __packed;
 
 struct l2cap_conn_req {
-	__le16     psm;
-	__le16     scid;
+	__le16	psm;
+	__le16	scid;
 } __packed;
 
 struct l2cap_conn_rsp {
-	__le16     dcid;
-	__le16     scid;
-	__le16     result;
+	__le16	dcid;
+	__le16	scid;
+	__le16	result;
 	__le16     status;
 } __packed;
 
@@ -237,16 +237,16 @@ struct l2cap_conn_rsp {
 #define L2CAP_CS_AUTHOR_PEND	0x0002
 
 struct l2cap_conf_req {
-	__le16     dcid;
-	__le16     flags;
-	__u8       data[0];
+	__le16	dcid;
+	__le16	flags;
+	__u8	data[0];
 } __packed;
 
 struct l2cap_conf_rsp {
-	__le16     scid;
-	__le16     flags;
-	__le16     result;
-	__u8       data[0];
+	__le16	scid;
+	__le16	flags;
+	__le16	result;
+	__u8	data[0];
 } __packed;
 
 #define L2CAP_CONF_SUCCESS	0x0000
@@ -256,9 +256,9 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_EFS_REJECT	0x0005
 
 struct l2cap_conf_opt {
-	__u8       type;
-	__u8       len;
-	__u8       val[0];
+	__u8	type;
+	__u8	len;
+	__u8	val[0];
 } __packed;
 #define L2CAP_CONF_OPT_SIZE	2
 
@@ -276,12 +276,12 @@ struct l2cap_conf_opt {
 #define L2CAP_CONF_MAX_SIZE	22
 
 struct l2cap_conf_rfc {
-	__u8       mode;
-	__u8       txwin_size;
-	__u8       max_transmit;
-	__le16     retrans_timeout;
-	__le16     monitor_timeout;
-	__le16     max_pdu_size;
+	__u8	mode;
+	__u8	txwin_size;
+	__u8	max_transmit;
+	__le16	retrans_timeout;
+	__le16	monitor_timeout;
+	__le16	max_pdu_size;
 } __packed;
 
 #define L2CAP_MODE_BASIC	0x00
@@ -306,23 +306,23 @@ struct l2cap_conf_efs {
 #define L2CAP_BESTEFFORT_ID	0x01
 
 struct l2cap_disconn_req {
-	__le16     dcid;
-	__le16     scid;
+	__le16	dcid;
+	__le16	scid;
 } __packed;
 
 struct l2cap_disconn_rsp {
-	__le16     dcid;
-	__le16     scid;
+	__le16	dcid;
+	__le16	scid;
 } __packed;
 
 struct l2cap_info_req {
-	__le16      type;
+	__le16	type;
 } __packed;
 
 struct l2cap_info_rsp {
-	__le16      type;
-	__le16      result;
-	__u8        data[0];
+	__le16	type;
+	__le16	result;
+	__u8	data[0];
 } __packed;
 
 struct l2cap_create_chan_req {
@@ -348,14 +348,14 @@ struct l2cap_create_chan_rsp {
 #define L2CAP_IR_NOTSUPP	0x0001
 
 struct l2cap_conn_param_update_req {
-	__le16      min;
-	__le16      max;
-	__le16      latency;
-	__le16      to_multiplier;
+	__le16	min;
+	__le16	max;
+	__le16	latency;
+	__le16	to_multiplier;
 } __packed;
 
 struct l2cap_conn_param_update_rsp {
-	__le16      result;
+	__le16	result;
 } __packed;
 
 /* Connection Parameters result */
-- 
1.7.4.1

