Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/7] Bluetooth: EFS: definitions and headers
Date: Wed,  7 Sep 2011 17:04:06 +0300
Message-Id: <1315404251-11960-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1315404251-11960-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1315404251-11960-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Based upon haijun.liu <haijun.liu@atheros.com> series of patches
(sent Sun, 22 Aug 2010)

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9850cb5..1f26a39 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -38,6 +38,9 @@
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1009    /* Sized for 3-DH5 packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_LE_DEFAULT_MTU		23
+#define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
+#define L2CAP_DEFAULT_SDU_ARRIVAL_TIME	0xFFFFFFFF
+#define L2CAP_DEFAULT_ACCESS_LATENCY	0xFFFFFFFF
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
@@ -218,6 +221,8 @@ struct l2cap_conf_rsp {
 #define L2CAP_CONF_UNACCEPT	0x0001
 #define L2CAP_CONF_REJECT	0x0002
 #define L2CAP_CONF_UNKNOWN	0x0003
+#define L2CAP_CONF_PENDING	0x0004
+#define L2CAP_CONF_EFS_REJECT	0x0005
 
 struct l2cap_conf_opt {
 	__u8       type;
@@ -234,6 +239,7 @@ struct l2cap_conf_opt {
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_FCS		0x05
+#define L2CAP_CONF_EFS		0x06
 
 #define L2CAP_CONF_MAX_SIZE	22
 
@@ -252,6 +258,19 @@ struct l2cap_conf_rfc {
 #define L2CAP_MODE_ERTM		0x03
 #define L2CAP_MODE_STREAMING	0x04
 
+struct l2cap_conf_efs {
+	__u8       id;
+	__u8       service_type;
+	__le16     max_sdu_size;
+	__le32     sdu_inter_time;
+	__le32     access_latency;
+	__le32     flush_timeout;
+} __packed;
+
+#define L2CAP_SERV_NOTRAFIC	0x00
+#define L2CAP_SERV_BESTEFFORT	0x01
+#define L2CAP_SERV_GUARANTEED	0x02
+
 struct l2cap_disconn_req {
 	__le16     dcid;
 	__le16     scid;
@@ -346,6 +365,7 @@ struct l2cap_chan {
 
 	unsigned long	conf_state;
 	unsigned long	conn_state;
+	unsigned long	flags;
 
 	__u8		next_tx_seq;
 	__u8		expected_ack_seq;
@@ -365,6 +385,20 @@ struct l2cap_chan {
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
@@ -452,6 +486,8 @@ enum {
 	CONF_CONNECT_PEND,
 	CONF_NO_FCS_RECV,
 	CONF_STATE2_DEVICE,
+	CONF_LOCAL_PEND,
+	CONF_REMOTE_PEND,
 };
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
@@ -469,6 +505,11 @@ enum {
 	CONN_RNR_SENT,
 };
 
+/* Definitions for flags in l2cap_chan */
+enum {
+	FLAG_EFS_ENABLE,
+};
+
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
 #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
 #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
-- 
1.7.4.1

