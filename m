Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	Andrei.Emeltchenko.news@gmail.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv4 4/9] Bluetooth: Add AMP-related data and structures for channel signals
Date: Wed,  2 Nov 2011 16:18:31 -0700
Message-Id: <1320275916-32103-5-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
References: <1320275916-32103-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AMP channel creation and channel moves are coordinated using the L2CAP
signaling channel.  These definitions cover the "create channel",
"move channel", and "move channel confirm" signals.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   54 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0b021c0..f822ab9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -97,6 +97,12 @@ struct l2cap_conninfo {
 #define L2CAP_ECHO_RSP		0x09
 #define L2CAP_INFO_REQ		0x0a
 #define L2CAP_INFO_RSP		0x0b
+#define L2CAP_CREATE_CHAN_REQ	0x0c
+#define L2CAP_CREATE_CHAN_RSP	0x0d
+#define L2CAP_MOVE_CHAN_REQ	0x0e
+#define L2CAP_MOVE_CHAN_RSP	0x0f
+#define L2CAP_MOVE_CHAN_CFM	0x10
+#define L2CAP_MOVE_CHAN_CFM_RSP	0x11
 #define L2CAP_CONN_PARAM_UPDATE_REQ	0x12
 #define L2CAP_CONN_PARAM_UPDATE_RSP	0x13
 
@@ -220,14 +226,15 @@ struct l2cap_conn_rsp {
 #define L2CAP_CID_DYN_START	0x0040
 #define L2CAP_CID_DYN_END	0xffff
 
-/* connect result */
+/* connect/create channel results */
 #define L2CAP_CR_SUCCESS	0x0000
 #define L2CAP_CR_PEND		0x0001
 #define L2CAP_CR_BAD_PSM	0x0002
 #define L2CAP_CR_SEC_BLOCK	0x0003
 #define L2CAP_CR_NO_MEM		0x0004
+#define L2CAP_CR_BAD_AMP	0x0005
 
-/* connect status */
+/* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
 #define L2CAP_CS_AUTHEN_PEND	0x0001
 #define L2CAP_CS_AUTHOR_PEND	0x0002
@@ -322,6 +329,49 @@ struct l2cap_info_rsp {
 	__u8        data[0];
 } __packed;
 
+struct l2cap_create_chan_req {
+	__le16      psm;
+	__le16      scid;
+	__u8        amp_id;
+} __packed;
+
+struct l2cap_create_chan_rsp {
+	__le16      dcid;
+	__le16      scid;
+	__le16      result;
+	__le16      status;
+} __packed;
+
+struct l2cap_move_chan_req {
+	__le16      icid;
+	__u8        dest_amp_id;
+} __packed;
+
+struct l2cap_move_chan_rsp {
+	__le16      icid;
+	__le16      result;
+} __packed;
+
+#define L2CAP_MR_SUCCESS	0x0000
+#define L2CAP_MR_PEND		0x0001
+#define L2CAP_MR_BAD_ID		0x0002
+#define L2CAP_MR_SAME_ID	0x0003
+#define L2CAP_MR_NOT_SUPP	0x0004
+#define L2CAP_MR_COLLISION	0x0005
+#define L2CAP_MR_NOT_ALLOWED	0x0006
+
+struct l2cap_move_chan_cfm {
+	__le16      icid;
+	__le16      result;
+} __packed;
+
+#define L2CAP_MC_CONFIRMED	0x0000
+#define L2CAP_MC_UNCONFIRMED	0x0001
+
+struct l2cap_move_chan_cfm_rsp {
+	__le16      icid;
+} __packed;
+
 /* info type */
 #define L2CAP_IT_CL_MTU		0x0001
 #define L2CAP_IT_FEAT_MASK	0x0002
-- 
1.7.7.1

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
