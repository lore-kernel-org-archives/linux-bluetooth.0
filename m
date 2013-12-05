Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/32] Bluetooth: Add definitions for LE connection oriented channels
Date: Thu,  5 Dec 2013 15:11:05 +0200
Message-Id: <1386249090-10236-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the necessary defines and structs for LE connection
oriented channels.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 94645d56fea7..b9e3240edf02 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -112,6 +112,9 @@ struct l2cap_conninfo {
 #define L2CAP_MOVE_CHAN_CFM_RSP	0x11
 #define L2CAP_CONN_PARAM_UPDATE_REQ	0x12
 #define L2CAP_CONN_PARAM_UPDATE_RSP	0x13
+#define L2CAP_LE_CONN_REQ	0x14
+#define L2CAP_LE_CONN_RSP	0x15
+#define L2CAP_LE_CREDITS	0x16
 
 /* L2CAP extended feature mask */
 #define L2CAP_FEAT_FLOWCTL	0x00000001
@@ -257,6 +260,10 @@ struct l2cap_conn_rsp {
 #define L2CAP_CR_SEC_BLOCK	0x0003
 #define L2CAP_CR_NO_MEM		0x0004
 #define L2CAP_CR_BAD_AMP	0x0005
+#define L2CAP_CR_AUTHENTICATION	0x0005
+#define L2CAP_CR_AUTHORIZATION	0x0006
+#define L2CAP_CR_BAD_KEY_SIZE	0x0007
+#define L2CAP_CR_ENCRYPTION	0x0008
 
 /* connect/create channel status */
 #define L2CAP_CS_NO_INFO	0x0000
@@ -423,6 +430,30 @@ struct l2cap_conn_param_update_rsp {
 #define L2CAP_CONN_PARAM_ACCEPTED	0x0000
 #define L2CAP_CONN_PARAM_REJECTED	0x0001
 
+#define L2CAP_LE_MAX_CREDITS		10
+#define L2CAP_LE_DEFAULT_MPS		5400
+
+struct l2cap_le_conn_req {
+	__le16     psm;
+	__le16     scid;
+	__le16     mtu;
+	__le16     mps;
+	__le16     credits;
+} __packed;
+
+struct l2cap_le_conn_rsp {
+	__le16     dcid;
+	__le16     mtu;
+	__le16     mps;
+	__le16     credits;
+	__le16     result;
+} __packed;
+
+struct l2cap_le_credits {
+	__le16     cid;
+	__le16     credits;
+} __packed;
+
 /* ----- L2CAP channels and connections ----- */
 struct l2cap_seq_list {
 	__u16	head;
-- 
1.8.4.2

