Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/6] Bluetooth: EFS: definitions and headers
Date: Thu, 13 Oct 2011 16:18:53 +0300
Message-Id: <1318511938-24311-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define Extended Flow Specification structures and default values.
Based upon haijun.liu <haijun.liu@atheros.com> series of patches
(sent Sun, 22 Aug 2010)

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f195978..860b36f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -250,6 +250,7 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_UNACCEPT	0x0001
 #define L2CAP_CONF_REJECT	0x0002
 #define L2CAP_CONF_UNKNOWN	0x0003
+#define L2CAP_CONF_EFS_REJECT	0x0005
 
 struct l2cap_conf_opt {
 	__u8       type;
@@ -266,6 +267,7 @@ struct l2cap_conf_opt {
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_FCS		0x05
+#define L2CAP_CONF_EFS		0x06
 #define L2CAP_CONF_EWS		0x07
 
 #define L2CAP_CONF_MAX_SIZE	22
@@ -285,6 +287,15 @@ struct l2cap_conf_rfc {
 #define L2CAP_MODE_ERTM		0x03
 #define L2CAP_MODE_STREAMING	0x04
 
+struct l2cap_conf_efs {
+	__u8	id;
+	__u8	stype;
+	__le16	msdu;
+	__le32	sdu_itime;
+	__le32	acc_lat;
+	__le32	flush_to;
+} __packed;
+
 struct l2cap_disconn_req {
 	__le16     dcid;
 	__le16     scid;
@@ -411,6 +422,20 @@ struct l2cap_chan {
 	__u8		remote_max_tx;
 	__u16		remote_mps;
 
+	__u8		local_id;
+	__u8		local_stype;
+	__u16		local_msdu;
+	__u32		local_sdu_itime;
+	__u32		local_acc_lat;
+	__u32		local_flush_to;
+
+	__u8		remote_id;
+	__u8		remote_stype;
+	__u16		remote_msdu;
+	__u32		remote_sdu_itime;
+	__u32		remote_acc_lat;
+	__u32		remote_flush_to;
+
 	struct timer_list	chan_timer;
 	struct timer_list	retrans_timer;
 	struct timer_list	monitor_timer;
@@ -518,6 +543,7 @@ enum {
 	FLAG_FORCE_RELIABLE,
 	FLAG_FLUSHABLE,
 	FLAG_EXT_CTRL,
+	FLAG_EFS_ENABLE,
 };
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
-- 
1.7.4.1

