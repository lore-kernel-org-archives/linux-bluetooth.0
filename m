Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1368C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88EED20DD4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 21:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgLUVnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLUVnC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 16:43:02 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003D6C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 13:42:21 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c12so7187318pfo.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhE4BC6kdnrOEEcnYWxaN2LcuXoQQU7eexE+hm97ukY=;
        b=AC+muQTtgibkhCiS/P0FnZhfdj6XJTe8oEKwDxAy2q4ha4/LkPecpQ8oBofTiwzodD
         ic1tBZcSPEawlR9Vne4lhsAkZ24zUrXrsi5rWmE2xRXCE8iiie8E8LBkMj5brwbKnXpJ
         +4aVUX3FdgR1Hj3BDPU3kmH6ntuR1x7guxbBerDND6G+M4Jqi/v6ttQ5I+FKyyI6R4xI
         Bj8c3Nwms+hQOPM3iIR4lNa88KPBiDNAZwaWg3wl9b2HWi96xFZATrHayj2aOMAyzr2+
         JCc77C2pjrRTs4nRx6x27cCr6pA2aATdgp04J+pbUny5gee9uDmA21a30ne/sGRj0Z3n
         lrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhE4BC6kdnrOEEcnYWxaN2LcuXoQQU7eexE+hm97ukY=;
        b=Y1rb17raI1Tj2Yu8ysuSh4F7UJWkMLg9FlsF2Z4st8KT72wuVaqj+rjtS3PJf9wC2O
         wNrrJBbDIlXBu/UR5jmCZJKBUsb8I0n15ebGDzwL9XtrNfPbYpeRFpSoAt1xXM5eg7Bz
         upNyl8lO+40rH2p7y7DqQ/nCYQcy6LAujmZ1JFhdFNa84hexZznBhAOyALu/aqMGlgqv
         mrz3jQF5FOBT5cy+ShsZTUPTtD4ztxpLXw0tO3txkHFebaz+fctd2fLXMCFA0tZ7eueM
         ARKqahrNlO7Cxi0X12h0uY/7qpXs9+rWU1FBApX+w/xgPLPuzOSg+KfBn7FLtV0yvp1p
         Izzw==
X-Gm-Message-State: AOAM533N+cZ1DlH3r/C/u0ezOz8gg81o5FAsCWPkcZzQxflQn2XepvwL
        BT05BuizY7bHuQ9EfFWT7iwLUEu4HVA=
X-Google-Smtp-Source: ABdhPJz9Ke73Q+B9p36WdWNanDgDeuixj/O+7qiYFN6wuw+07vN/t2pziDwtKPPvVGkGLebBeCfiUA==
X-Received: by 2002:aa7:90cf:0:b029:1a3:a176:f4d0 with SMTP id k15-20020aa790cf0000b02901a3a176f4d0mr16703021pfk.8.1608586940119;
        Mon, 21 Dec 2020 13:42:20 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 14sm17074840pjm.21.2020.12.21.13.42.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:42:18 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add initial implementation of CIS connections
Date:   Mon, 21 Dec 2020 13:42:15 -0800
Message-Id: <20201221214217.2093485-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial implementation of CIS connections and introduces
the ISO packets/links along with is enabled with use CONFIG_BT_ISO
Kconfig option.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  33 +++-
 include/net/bluetooth/hci.h       |  19 ++
 include/net/bluetooth/hci_core.h  |  84 ++++++++-
 include/net/bluetooth/hci_sock.h  |   2 +
 net/bluetooth/Kconfig             |   9 +
 net/bluetooth/af_bluetooth.c      |   4 +-
 net/bluetooth/hci_conn.c          | 286 ++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c          | 261 ++++++++++++++++++++++-----
 net/bluetooth/hci_event.c         | 242 +++++++++++++++++++++++++
 9 files changed, 888 insertions(+), 52 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..26ae85bdc589 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -55,6 +55,8 @@
 #define BTPROTO_CMTP	5
 #define BTPROTO_HIDP	6
 #define BTPROTO_AVDTP	7
+#define BTPROTO_ISO	8
+#define BTPROTO_LAST	BTPROTO_ISO
 
 #define SOL_HCI		0
 #define SOL_L2CAP	6
@@ -149,10 +151,39 @@ struct bt_voice {
 #define BT_MODE_LE_FLOWCTL	0x03
 #define BT_MODE_EXT_FLOWCTL	0x04
 
-#define BT_PKT_STATUS          16
+#define BT_PKT_STATUS           16
 
 #define BT_SCM_PKT_STATUS	0x03
 
+#define BT_ISO_QOS		17
+
+#define BT_ISO_QOS_CIG_UNSET	0xff
+#define BT_ISO_QOS_CIS_UNSET	0xff
+
+struct bt_iso_io_qos {
+	__u32 interval;
+	__u16 latency;
+	__u16 sdu;
+	__u8  phy;
+	__u8  rtn;
+};
+
+struct bt_iso_qos {
+	__u8  cig;
+	__u8  cis;
+	__u8  sca;
+	__u8  packing;
+	__u8  framing;
+	struct bt_iso_io_qos in;
+	struct bt_iso_io_qos out;
+};
+
+#define BT_ISO_PHY_1M		0x01
+#define BT_ISO_PHY_2M		0x02
+#define BT_ISO_PHY_CODED	0x04
+#define BT_ISO_PHY_ANY		(BT_ISO_PHY_1M | BT_ISO_PHY_2M | \
+				 BT_ISO_PHY_CODED)
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c1504aa3d9cf..f19b44bca3b0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1884,6 +1884,25 @@ struct hci_cp_le_reject_cis {
 	__u8    reason;
 } __packed;
 
+#define HCI_OP_LE_SETUP_ISO_PATH		0x206e
+struct hci_cp_le_setup_iso_path {
+	__le16  handle;
+	__u8    direction;
+	__u8    path;
+	__u8    codec;
+	__le16  codec_cid;
+	__le16  codec_vid;
+	__u8    delay[3];
+	__u8    codec_cfg_len;
+	__u8    codec_cfg[0];
+} __attribute__ ((packed));
+
+#define HCI_OP_LE_SET_HOST_FEATURE		0x2074
+struct hci_cp_le_set_host_feature {
+	__u8     bit_number;
+	__u8     bit_value;
+} __packed;
+
 /* ---- HCI Events ---- */
 #define HCI_EV_INQUIRY_COMPLETE		0x01
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 677a8c50b2ad..0d2fa4dc4107 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -119,6 +119,7 @@ struct hci_conn_hash {
 	unsigned int     acl_num;
 	unsigned int     amp_num;
 	unsigned int     sco_num;
+	unsigned int     iso_num;
 	unsigned int     le_num;
 	unsigned int     le_num_slave;
 };
@@ -419,13 +420,16 @@ struct hci_dev {
 	unsigned int	acl_cnt;
 	unsigned int	sco_cnt;
 	unsigned int	le_cnt;
+	unsigned int	iso_cnt;
 
 	unsigned int	acl_mtu;
 	unsigned int	sco_mtu;
 	unsigned int	le_mtu;
+	unsigned int	iso_mtu;
 	unsigned int	acl_pkts;
 	unsigned int	sco_pkts;
 	unsigned int	le_pkts;
+	unsigned int	iso_pkts;
 
 	__u16		block_len;
 	__u16		block_mtu;
@@ -589,6 +593,7 @@ enum conn_reasons {
 	CONN_REASON_PAIR_DEVICE,
 	CONN_REASON_L2CAP_CHAN,
 	CONN_REASON_SCO_CONNECT,
+        CONN_REASON_ISO_CONNECT,
 };
 
 struct hci_conn {
@@ -640,6 +645,7 @@ struct hci_conn {
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
+	struct bt_iso_qos iso_qos;
 	unsigned long	flags;
 
 	enum conn_reasons conn_reason;
@@ -670,6 +676,7 @@ struct hci_conn {
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
 	void		*sco_data;
+	void		*iso_data;
 	struct amp_mgr	*amp_mgr;
 
 	struct hci_conn	*link;
@@ -875,6 +882,9 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 	case ESCO_LINK:
 		h->sco_num++;
 		break;
+	case ISO_LINK:
+		h->iso_num++;
+		break;
 	}
 }
 
@@ -901,6 +911,9 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	case ESCO_LINK:
 		h->sco_num--;
 		break;
+	case ISO_LINK:
+		h->iso_num--;
+		break;
 	}
 }
 
@@ -917,6 +930,8 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	case SCO_LINK:
 	case ESCO_LINK:
 		return h->sco_num;
+	case ISO_LINK:
+		return h->iso_num;
 	default:
 		return 0;
 	}
@@ -926,7 +941,7 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *c = &hdev->conn_hash;
 
-	return c->acl_num + c->amp_num + c->sco_num + c->le_num;
+	return c->acl_num + c->amp_num + c->sco_num + c->le_num + c->iso_num;
 }
 
 static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
@@ -1012,6 +1027,30 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
+						        bdaddr_t *ba,
+						        __u8 ba_type)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != ISO_LINK)
+		       continue;
+
+		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 							__u8 type, __u16 state)
 {
@@ -1032,6 +1071,27 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 	return NULL;
 }
 
+typedef void (*hci_conn_func_t)(struct hci_conn *conn, void *data);
+static inline void hci_conn_hash_list_state(struct hci_dev *hdev,
+					    hci_conn_func_t func, __u8 type,
+					    __u16 state, void *data)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	if (!func)
+		return;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->state == state)
+			func(c, data);
+	}
+
+	rcu_read_unlock();
+}
+
 static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
@@ -1055,6 +1115,8 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
+bool hci_iso_setup_path(struct hci_conn *conn);
+bool hci_le_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role);
@@ -1079,6 +1141,10 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 enum conn_reasons conn_reason);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting);
+struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
+			      __u8 dst_type, struct bt_iso_qos *qos);
+struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
+				 __u8 dst_type, struct bt_iso_qos *qos);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
@@ -1395,6 +1461,17 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
+/* CIS Master/Slave support */
+#if IS_ENABLED(CONFIG_BT_ISO)
+#define cis_capable(dev) (cis_master_capable(dev) || cis_slave_capable(dev))
+#define cis_master_capable(dev) ((dev)->le_features[3] & HCI_LE_CIS_MASTER)
+#define cis_slave_capable(dev) ((dev)->le_features[3] & HCI_LE_CIS_SLAVE)
+#else
+#define cis_capable(dev) false
+#define cis_master_capable(dev) false
+#define cis_slave_capable(dev) false
+#endif
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
@@ -1409,6 +1486,10 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	case ESCO_LINK:
 		return sco_connect_ind(hdev, bdaddr, flags);
 
+	case ISO_LINK:
+		/* TODO: Handle connection indication */
+		return -EINVAL;
+
 	default:
 		BT_ERR("unknown link type %d", type);
 		return -EINVAL;
@@ -1657,6 +1738,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
+void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 
diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 9949870f7d78..0520e21ab698 100644
--- a/include/net/bluetooth/hci_sock.h
+++ b/include/net/bluetooth/hci_sock.h
@@ -124,6 +124,8 @@ struct hci_dev_info {
 	__u16 acl_pkts;
 	__u16 sco_mtu;
 	__u16 sco_pkts;
+	__u16 iso_mtu;
+	__u16 iso_pkts;
 
 	struct hci_dev_stats stat;
 };
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 64e669acd42f..bbe70c29ec62 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -29,6 +29,7 @@ menuconfig BT
 		SCO audio links
 		L2CAP (Logical Link Control and Adaptation Protocol)
 		SMP (Security Manager Protocol) on LE (Low Energy) links
+		ISO isochronous links
 	     HCI Device drivers (Interface to the hardware)
 	     RFCOMM Module (RFCOMM Protocol)  
 	     BNEP Module (Bluetooth Network Encapsulation Protocol)
@@ -77,6 +78,14 @@ config BT_LE
 	  Bluetooth Low Energy includes support low-energy physical
 	  layer available with Bluetooth version 4.0 or later.
 
+config BT_ISO
+	bool "Bluetooth Isochronous (ISO) Channels support (Experimental)"
+	depends on BT_LE
+	help
+	  Bluetooth Isochronous Channels includes support for
+	  Connected Isochronous Stream (CIS) and Broadcast Isochronous Stream
+	  (BIS).
+
 config BT_6LOWPAN
 	tristate "Bluetooth 6LoWPAN support"
 	depends on BT_LE && 6LOWPAN
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 4ef6a54403aa..fd4e1b40da9b 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -38,7 +38,7 @@
 #include "selftest.h"
 
 /* Bluetooth sockets */
-#define BT_MAX_PROTO	8
+#define BT_MAX_PROTO	BTPROTO_LAST + 1
 static const struct net_proto_family *bt_proto[BT_MAX_PROTO];
 static DEFINE_RWLOCK(bt_proto_lock);
 
@@ -52,6 +52,7 @@ static const char *const bt_key_strings[BT_MAX_PROTO] = {
 	"sk_lock-AF_BLUETOOTH-BTPROTO_CMTP",
 	"sk_lock-AF_BLUETOOTH-BTPROTO_HIDP",
 	"sk_lock-AF_BLUETOOTH-BTPROTO_AVDTP",
+	"sk_lock-AF_BLUETOOTH-BTPROTO_ISO",
 };
 
 static struct lock_class_key bt_slock_key[BT_MAX_PROTO];
@@ -64,6 +65,7 @@ static const char *const bt_slock_key_strings[BT_MAX_PROTO] = {
 	"slock-AF_BLUETOOTH-BTPROTO_CMTP",
 	"slock-AF_BLUETOOTH-BTPROTO_HIDP",
 	"slock-AF_BLUETOOTH-BTPROTO_AVDTP",
+	"slock-AF_BLUETOOTH-BTPROTO_ISO",
 };
 
 void bt_sock_reclassify_lock(struct sock *sk, int proto)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 23c0d77ea737..b04482e277df 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -572,6 +572,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
 		break;
 	case LE_LINK:
+	case ISO_LINK:
 		/* conn->src should reflect the local identity address */
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
 		break;
@@ -1336,6 +1337,291 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
+struct iso_list_data {
+	u8  cig;
+	u8  cis;
+	int count;
+	struct {
+		struct hci_cp_le_set_cig_params cp;
+		struct hci_cis_params cis[0x11];
+	} pdu;
+};
+
+static void cis_add(struct iso_list_data *d, struct bt_iso_qos *qos)
+{
+	struct hci_cis_params *cis = &d->pdu.cis[d->pdu.cp.num_cis];
+
+	cis->cis_id = qos->cis;
+	cis->m_sdu  = qos->out.sdu;
+	cis->s_sdu  = qos->in.sdu;
+	cis->m_phy  = qos->out.phy;
+	cis->s_phy  = qos->in.phy;
+	cis->m_rtn  = qos->out.rtn;
+	cis->s_rtn  = qos->in.rtn;
+
+	d->pdu.cp.num_cis++;
+}
+
+static void cis_list(struct hci_conn *conn, void *data)
+{
+	struct iso_list_data *d = data;
+
+	if (d->cig != conn->iso_qos.cig || d->cis == BT_ISO_QOS_CIS_UNSET ||
+	    d->cis != conn->iso_qos.cis)
+		return;
+
+	d->count++;
+
+	if (d->pdu.cp.cig_id == BT_ISO_QOS_CIG_UNSET ||
+	    d->count >= ARRAY_SIZE(d->pdu.cis))
+		return;
+
+	cis_add(d, &conn->iso_qos);
+}
+
+static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct iso_list_data data;
+
+	memset(&data, 0, sizeof(data));
+
+	/* Allocate a CIG if not set */
+	if (qos->cig == BT_ISO_QOS_CIG_UNSET) {
+		for (data.cig = 0x00; data.cig < 0xff; data.cig++) {
+			data.count = 0;
+			data.cis = 0xff;
+
+			hci_conn_hash_list_state(hdev, cis_list, ISO_LINK,
+						 BT_BOUND, &data);
+			if (data.count)
+				continue;
+
+			hci_conn_hash_list_state(hdev, cis_list, ISO_LINK,
+						 BT_CONNECTED, &data);
+			if (!data.count)
+				break;
+		}
+
+		if (data.cig == 0xff)
+			return false;
+
+		/* Update CIG */
+		qos->cig = data.cig;
+	}
+
+	data.pdu.cp.cig_id = qos->cig;
+	hci_cpu_to_le24(qos->out.interval, data.pdu.cp.m_interval);
+	hci_cpu_to_le24(qos->in.interval, data.pdu.cp.s_interval);
+	data.pdu.cp.sca = qos->sca;
+	data.pdu.cp.packing = qos->packing;
+	data.pdu.cp.framing = qos->framing;
+	data.pdu.cp.m_latency = cpu_to_le16(qos->out.latency);
+	data.pdu.cp.s_latency = cpu_to_le16(qos->in.latency);
+
+	/* List all CIS(s) with the same CIG */
+	for (data.cig = qos->cig, data.cis = 0x00; data.cis < 0x11;
+	     data.cis++) {
+		data.count = 0;
+
+		hci_conn_hash_list_state(hdev, cis_list, ISO_LINK,
+					 BT_BOUND, &data);
+		if (data.count)
+			continue;
+
+		/* Allocate a CIS if not set */
+		if (qos->cis == BT_ISO_QOS_CIG_UNSET) {
+			/* Update CIS */
+			qos->cis = data.cis;
+			cis_add(&data, qos);
+		}
+	}
+
+	if (qos->cis == BT_ISO_QOS_CIG_UNSET || !data.pdu.cp.num_cis)
+		return false;
+
+	if (hci_send_cmd(hdev, HCI_OP_LE_SET_CIG_PARAMS,
+			 sizeof(data.pdu.cp) +
+			 (data.pdu.cp.num_cis * sizeof(*data.pdu.cis)),
+			 &data.pdu) < 0)
+		return false;
+
+	return true;
+}
+
+struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
+			      __u8 dst_type, struct bt_iso_qos *qos)
+{
+	struct hci_conn *cis;
+
+	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type);
+	if (!cis) {
+		cis = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
+		if (!cis) {
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	if (cis->state == BT_CONNECTED)
+		return cis;
+
+	/* Check if CIS has been set and the settings matches */
+	if (cis->state == BT_BOUND &&
+	    !memcmp(&cis->iso_qos, qos, sizeof(*qos)))
+		return cis;
+
+	/* Update LINK PHYs according to QoS preference */
+	cis->le_tx_phy = qos->out.phy;
+	cis->le_rx_phy = qos->in.phy;
+
+	/* Mirror PHYs that are disabled as SDU will be set to 0 */
+	if (!qos->in.phy)
+		qos->in.phy = qos->out.phy;
+
+	if (!qos->out.phy)
+		qos->out.phy = qos->in.phy;
+
+	if (!hci_le_set_cig_params(cis, qos)) {
+		hci_conn_drop(cis);
+		return NULL;
+	}
+
+	cis->iso_qos = *qos;
+	cis->state = BT_BOUND;
+
+	return cis;
+}
+
+bool hci_iso_setup_path(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_setup_iso_path cmd;
+
+	/* TODO: Remove this check since it is mandatory to support Setup ISO
+	 * Path when ISO is supported by the controller.
+	 */
+	if (!(hdev->commands[43] & (0x08)))
+		return false;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.handle    = cpu_to_le16(conn->handle);
+	cmd.direction = 0x00; /* Input (Host to Controller) */
+	cmd.path      = conn->le_tx_phy ? 0x00 : 0xff; /* HCI path if enabled */
+	cmd.codec     = 0x03; /* Transparent Data */
+
+	if (hci_send_cmd(hdev, HCI_OP_LE_SETUP_ISO_PATH, sizeof(cmd), &cmd) < 0)
+		return false;
+
+	cmd.direction = 0x01; /* Output (Controller to Host) */
+	cmd.path      = conn->le_rx_phy ? 0x00 : 0xff; /* HCI path if enabled */
+
+	if (hci_send_cmd(hdev, HCI_OP_LE_SETUP_ISO_PATH, sizeof(cmd), &cmd) < 0)
+		return false;
+
+	return true;
+}
+
+bool hci_le_create_cis(struct hci_conn *conn)
+{
+	struct hci_conn *cis;
+	struct hci_dev *hdev = conn->hdev;
+	struct {
+		struct hci_cp_le_create_cis cp;
+		struct hci_cis cis;
+	} cmd;
+
+	if (conn->type != LE_LINK || !conn->link || conn->state != BT_CONNECTED)
+		return false;
+
+	cis = conn->link;
+
+	if (cis->state == BT_CONNECT)
+		return true;
+
+	cmd.cp.num_cis = 0x01;
+	cmd.cis.acl_handle = cpu_to_le16(conn->handle);
+	cmd.cis.cis_handle = cpu_to_le16(cis->handle);
+
+	if (hci_send_cmd(hdev, HCI_OP_LE_CREATE_CIS, sizeof(cmd), &cmd) < 0)
+		return false;
+
+	cis->state = BT_CONNECT;
+
+	return true;
+}
+
+static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
+			      struct bt_iso_io_qos *qos, __u8 phy)
+{
+	/* Only set MTU if PHY is enabled */
+	if (!qos->sdu && qos->phy) {
+		if (hdev->iso_mtu > 0)
+			qos->sdu = hdev->iso_mtu;
+		else if (hdev->le_mtu > 0)
+			qos->sdu = hdev->le_mtu;
+		else
+			qos->sdu = hdev->acl_mtu;
+	}
+
+	/* Use the same PHY as ACL if set to any */
+	if (qos->phy == BT_ISO_PHY_ANY)
+		qos->phy = phy;
+
+	/* Use LE ACL connection interval if not set */
+	if (!qos->interval)
+		/* ACL interval unit in 1.25 ms to us */
+		qos->interval = conn->le_conn_interval * 1250;
+
+	/* Use LE ACL connection latency if not set */
+	if (!qos->latency)
+		qos->latency = conn->le_conn_latency;
+}
+
+struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
+				 __u8 dst_type, struct bt_iso_qos *qos)
+{
+	struct hci_conn *le;
+	struct hci_conn *cis;
+
+	/* Convert from ISO socket address type to HCI address type  */
+	if (dst_type == BDADDR_LE_PUBLIC)
+		dst_type = ADDR_LE_DEV_PUBLIC;
+	else
+		dst_type = ADDR_LE_DEV_RANDOM;
+
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		le = hci_connect_le(hdev, dst, dst_type,
+				    BT_SECURITY_LOW,
+				    HCI_LE_CONN_TIMEOUT,
+				    HCI_ROLE_SLAVE, NULL);
+	else
+		le = hci_connect_le_scan(hdev, dst, dst_type,
+					  BT_SECURITY_LOW,
+					  HCI_LE_CONN_TIMEOUT,
+                                          CONN_REASON_ISO_CONNECT);
+	if (IS_ERR(le))
+		return le;
+
+	hci_iso_qos_setup(hdev, le, &qos->out,
+			  le->le_tx_phy ? le->le_tx_phy : hdev->le_tx_def_phys);
+	hci_iso_qos_setup(hdev, le, &qos->in,
+			  le->le_rx_phy ? le->le_rx_phy : hdev->le_rx_def_phys);
+
+	cis = hci_bind_cis(hdev, dst, dst_type, qos);
+	if (!cis) {
+		hci_conn_drop(le);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	le->link = cis;
+	cis->link = le;
+
+	hci_conn_hold(cis);
+
+	return cis;
+}
+
 /* Check link security requirement */
 int hci_conn_check_link_mode(struct hci_conn *conn)
 {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d2c9a1c552f..fc0011c3a71d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -304,8 +304,12 @@ static void le_setup(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 
-	/* Read LE Buffer Size */
-	hci_req_add(req, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
+	if (cis_capable(req->hdev))
+		/* Read LE Buffer Size V2 */
+		hci_req_add(req, HCI_OP_LE_READ_BUFFER_SIZE_V2, 0, NULL);
+	else
+		/* Read LE Buffer Size */
+		hci_req_add(req, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
 
 	/* Read LE Local Supported Features */
 	hci_req_add(req, HCI_OP_LE_READ_LOCAL_FEATURES, 0, NULL);
@@ -727,6 +731,28 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 						 * Terminated
 						 */
 
+		if (cis_capable(hdev)) {
+			/* TODO: Remove this check since it is mandatory to
+			 * support Set Host Feature when ISO is supported by
+			 * the controller.
+			 */
+			if (hdev->commands[44] & (0x01)) {
+				struct hci_cp_le_set_host_feature cp;
+
+				/* Isochronous Channels (Host Support) */
+				cp.bit_number = 32;
+				cp.bit_value = 1;
+
+				/* LE Set Host Features */
+				hci_req_add(req, HCI_OP_LE_SET_HOST_FEATURE,
+					    sizeof(cp), &cp);
+			}
+
+			events[3] |= 0x01; /* LE CIS Established */
+			if (cis_slave_capable(hdev))
+				events[3] |= 0x02; /* LE CIS Request */
+		}
+
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
@@ -1887,7 +1913,10 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 		hdev->flush(hdev);
 
 	atomic_set(&hdev->cmd_cnt, 1);
-	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
+	hdev->acl_cnt = 0;
+	hdev->sco_cnt = 0;
+	hdev->le_cnt = 0;
+	hdev->iso_cnt = 0;
 
 	ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT, NULL);
 
@@ -4283,9 +4312,117 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
+/* Send ISO data */
+static void hci_add_iso_hdr(struct sk_buff *skb, __u16 handle, __u8 flags)
+{
+	struct hci_iso_hdr *hdr;
+	int len = skb->len;
+
+	skb_push(skb, HCI_ISO_HDR_SIZE);
+	skb_reset_transport_header(skb);
+	hdr = (struct hci_iso_hdr *)skb_transport_header(skb);
+	hdr->handle = cpu_to_le16(hci_handle_pack(handle, flags));
+	hdr->dlen   = cpu_to_le16(len);
+}
+
+static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
+			  struct sk_buff *skb)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct sk_buff *list;
+	__u16 flags;
+
+	skb->len = skb_headlen(skb);
+	skb->data_len = 0;
+
+	hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
+
+	list = skb_shinfo(skb)->frag_list;
+
+	flags = hci_iso_flags_pack(list ? ISO_START : ISO_SINGLE, 0x00);
+	hci_add_iso_hdr(skb, conn->handle, flags);
+
+	if (!list) {
+		/* Non fragmented */
+		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
+
+		skb_queue_tail(queue, skb);
+	} else {
+		/* Fragmented */
+		BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
+
+		skb_shinfo(skb)->frag_list = NULL;
+
+		__skb_queue_tail(queue, skb);
+
+		do {
+			skb = list; list = list->next;
+
+			hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
+			flags = hci_iso_flags_pack(list ? ISO_CONT : ISO_END,
+						   0x00);
+			hci_add_iso_hdr(skb, conn->handle, flags);
+
+			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
+
+			__skb_queue_tail(queue, skb);
+		} while (list);
+	}
+}
+
+void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb)
+{
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("%s len %d", hdev->name, skb->len);
+
+	hci_queue_iso(conn, &conn->data_q, skb);
+
+	queue_work(hdev->workqueue, &hdev->tx_work);
+}
+
 /* ---- HCI TX task (outgoing data) ---- */
 
 /* HCI Connection scheduler */
+static inline void hci_quote_sent(struct hci_conn *conn, int num, int *quote)
+{
+	struct hci_dev *hdev;
+	int cnt, q;
+
+	if (!conn) {
+		*quote = 0;
+		return;
+	}
+
+	hdev = conn->hdev;
+
+	switch (conn->type) {
+	case ACL_LINK:
+		cnt = hdev->acl_cnt;
+		break;
+	case AMP_LINK:
+		cnt = hdev->block_cnt;
+		break;
+	case SCO_LINK:
+	case ESCO_LINK:
+		cnt = hdev->sco_cnt;
+		break;
+	case LE_LINK:
+		cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
+		break;
+	case ISO_LINK:
+		cnt = hdev->iso_mtu ? hdev->iso_cnt :
+			hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
+		break;
+	default:
+		cnt = 0;
+		bt_dev_err(hdev, "unknown link type %d", conn->type);
+	}
+
+	q = cnt / num;
+	*quote = q ? q : 1;
+}
+
 static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 				     int *quote)
 {
@@ -4318,29 +4455,7 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 
 	rcu_read_unlock();
 
-	if (conn) {
-		int cnt, q;
-
-		switch (conn->type) {
-		case ACL_LINK:
-			cnt = hdev->acl_cnt;
-			break;
-		case SCO_LINK:
-		case ESCO_LINK:
-			cnt = hdev->sco_cnt;
-			break;
-		case LE_LINK:
-			cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
-			break;
-		default:
-			cnt = 0;
-			bt_dev_err(hdev, "unknown link type %d", conn->type);
-		}
-
-		q = cnt / num;
-		*quote = q ? q : 1;
-	} else
-		*quote = 0;
+	hci_quote_sent(conn, num, quote);
 
 	BT_DBG("conn %p quote %d", conn, *quote);
 	return conn;
@@ -4374,7 +4489,7 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 	struct hci_chan *chan = NULL;
 	unsigned int num = 0, min = ~0, cur_prio = 0;
 	struct hci_conn *conn;
-	int cnt, q, conn_num = 0;
+	int conn_num = 0;
 
 	BT_DBG("%s", hdev->name);
 
@@ -4424,27 +4539,8 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 	if (!chan)
 		return NULL;
 
-	switch (chan->conn->type) {
-	case ACL_LINK:
-		cnt = hdev->acl_cnt;
-		break;
-	case AMP_LINK:
-		cnt = hdev->block_cnt;
-		break;
-	case SCO_LINK:
-	case ESCO_LINK:
-		cnt = hdev->sco_cnt;
-		break;
-	case LE_LINK:
-		cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
-		break;
-	default:
-		cnt = 0;
-		bt_dev_err(hdev, "unknown link type %d", chan->conn->type);
-	}
+	hci_quote_sent(chan->conn, num, quote);
 
-	q = cnt / num;
-	*quote = q ? q : 1;
 	BT_DBG("chan %p quote %d", chan, *quote);
 	return chan;
 }
@@ -4733,13 +4829,40 @@ static void hci_sched_le(struct hci_dev *hdev)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
 
+/* Schedule CIS */
+static void hci_sched_iso(struct hci_dev *hdev)
+{
+	struct hci_conn *conn;
+	struct sk_buff *skb;
+	int quote, *cnt;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!hci_conn_num(hdev, ISO_LINK))
+		return;
+
+	cnt = hdev->iso_pkts ? &hdev->iso_cnt :
+		hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
+	while (*cnt && (conn = hci_low_sent(hdev, ISO_LINK, &quote))) {
+		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+			BT_DBG("skb %p len %d", skb, skb->len);
+			hci_send_frame(hdev, skb);
+
+			conn->sent++;
+			if (conn->sent == ~0)
+				conn->sent = 0;
+			(*cnt)--;
+		}
+	}
+}
+
 static void hci_tx_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, tx_work);
 	struct sk_buff *skb;
 
-	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
-	       hdev->sco_cnt, hdev->le_cnt);
+	BT_DBG("%s acl %d sco %d le %d iso %d", hdev->name, hdev->acl_cnt,
+	       hdev->sco_cnt, hdev->le_cnt, hdev->iso_cnt);
 
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Schedule queues and send stuff to HCI driver */
@@ -4747,6 +4870,9 @@ static void hci_tx_work(struct work_struct *work)
 		hci_sched_esco(hdev);
 		hci_sched_acl(hdev);
 		hci_sched_le(hdev);
+
+		if (IS_ENABLED(CONFIG_BT_ISO))
+			hci_sched_iso(hdev);
 	}
 
 	/* Send next queued raw (unknown type) packet */
@@ -4827,6 +4953,34 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_iso_hdr *hdr = (void *) skb->data;
+	struct hci_conn *conn;
+	__u16 handle, flags;
+
+	skb_pull(skb, HCI_ISO_HDR_SIZE);
+
+	handle = __le16_to_cpu(hdr->handle);
+	flags  = hci_flags(handle);
+	handle = hci_handle(handle);
+
+	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
+	       handle, flags);
+
+	hci_dev_lock(hdev);
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	hci_dev_unlock(hdev);
+
+	/* TODO: Send to upper protocol */
+	if (!conn) {
+		bt_dev_err(hdev, "ISO packet for unknown connection handle %d",
+			   handle);
+	}
+
+	kfree_skb(skb);
+}
+
 static bool hci_req_is_complete(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -4981,6 +5135,15 @@ static void hci_rx_work(struct work_struct *work)
 			hci_scodata_packet(hdev, skb);
 			break;
 
+		case HCI_ISODATA_PKT:
+			BT_DBG("%s ISO data packet", hdev->name);
+
+			if (IS_ENABLED(CONFIG_BT_ISO)) {
+				hci_isodata_packet(hdev, skb);
+				break;
+			}
+
+		/* Fall through */
 		default:
 			kfree_skb(skb);
 			break;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 67668be3461e..5a446e883e55 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1030,13 +1030,22 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
 	struct hci_rp_le_read_local_features *rp = (void *) skb->data;
+	bool cis;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
 		return;
 
+	/* Check current stored flags */
+	cis = cis_capable(hdev);
+
 	memcpy(hdev->le_features, rp->features, 8);
+
+	/* Attempt to use Read Buffer Size V2 if CIS becomes supported */
+	if (!cis && cis_capable(hdev))
+		/* Read LE Buffer Size V2 */
+		hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE_V2, 0, NULL);
 }
 
 static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
@@ -3247,6 +3256,105 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev,
+					  struct sk_buff *skb)
+{
+	struct hci_rp_le_read_buffer_size_v2 *rp = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hdev->le_mtu   = __le16_to_cpu(rp->acl_mtu);
+	hdev->le_pkts  = __le16_to_cpu(rp->acl_max_pkt);
+	hdev->iso_mtu  = __le16_to_cpu(rp->iso_mtu);
+	hdev->iso_pkts = __le16_to_cpu(rp->iso_max_pkt);
+
+	hdev->le_cnt  = hdev->le_pkts;
+	hdev->iso_cnt = hdev->iso_pkts;
+
+	BT_DBG("%s acl mtu %d:%d iso mtu %d:%d", hdev->name, hdev->acl_mtu,
+	       hdev->acl_pkts, hdev->iso_mtu, hdev->iso_pkts);
+}
+
+static void hci_cc_le_set_cig_params(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_le_set_cig_params *rp = (void *) skb->data;
+	struct hci_conn *conn;
+	int i = 0;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	hci_dev_lock(hdev);
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (conn->type != ISO_LINK || conn->iso_qos.cig != rp->cig_id ||
+		    conn->state == BT_CONNECTED)
+			continue;
+
+		if (rp->status) {
+			conn->state = BT_CLOSED;
+			hci_connect_cfm(conn, rp->status);
+			hci_conn_del(conn);
+			goto unlock;
+		}
+
+		conn->handle = __le16_to_cpu(rp->handle[i++]);
+
+		BT_DBG("%p handle 0x%4.4x link %p state %u", conn, conn->handle,
+		       conn->link, conn->link->state);
+
+		/* Create CIS if LE is already connected */
+		if (conn->link->state == BT_CONNECTED)
+			hci_le_create_cis(conn->link);
+
+		if (i == rp->num_handles)
+			break;
+	}
+
+unlock:
+	rcu_read_unlock();
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_create_cis *cp;
+	int i;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	if (!status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_CREATE_CIS);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	/* Remove connection if command failed */
+	for (i = 0; cp->num_cis; cp->num_cis--, i++) {
+		struct hci_conn *conn;
+		u16 handle;
+
+		handle = __le16_to_cpu(cp->cis[i].cis_handle);
+
+		conn = hci_conn_hash_lookup_handle(hdev, handle);
+		if (conn) {
+			conn->state = BT_CLOSED;
+			hci_connect_cfm(conn, status);
+			hci_conn_del(conn);
+		}
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 				 u16 *opcode, u8 *status,
 				 hci_req_complete_t *req_complete,
@@ -3600,6 +3708,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_read_transmit_power(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_BUFFER_SIZE_V2:
+		hci_cc_le_read_buffer_size_v2(hdev, skb);
+		break;
+
+	case HCI_OP_LE_SET_CIG_PARAMS:
+		hci_cc_le_set_cig_params(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
@@ -3705,6 +3821,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cs_le_ext_create_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_LE_CREATE_CIS:
+		hci_cs_le_create_cis(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
@@ -3825,6 +3945,22 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				hdev->sco_cnt = hdev->sco_pkts;
 			break;
 
+		case ISO_LINK:
+			if (hdev->iso_pkts) {
+				hdev->iso_cnt += count;
+				if (hdev->iso_cnt > hdev->iso_pkts)
+					hdev->iso_cnt = hdev->iso_pkts;
+			} if (hdev->le_pkts) {
+				hdev->le_cnt += count;
+				if (hdev->le_cnt > hdev->le_pkts)
+					hdev->le_cnt = hdev->le_pkts;
+			} else {
+				hdev->acl_cnt += count;
+				if (hdev->acl_cnt > hdev->acl_pkts)
+					hdev->acl_cnt = hdev->acl_pkts;
+			}
+			break;
+
 		default:
 			bt_dev_err(hdev, "unknown type %d conn %p",
 				   conn->type, conn);
@@ -5927,6 +6063,101 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_cis_estabilished_evt(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_evt_le_cis_established *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	if (!ev->status) {
+		conn->state = BT_CONNECTED;
+		hci_debugfs_create_conn(conn);
+		hci_conn_add_sysfs(conn);
+		hci_iso_setup_path(conn);
+	}
+
+	/* TODO: report the event parameter? */
+	hci_connect_cfm(conn, ev->status);
+	if (ev->status)
+		hci_conn_del(conn);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void hci_le_reject_cis(struct hci_dev *hdev, __le16 handle)
+{
+	struct hci_cp_le_reject_cis cp;
+
+	cp.handle = handle;
+	cp.reason = HCI_ERROR_REJ_BAD_ADDR;
+	hci_send_cmd(hdev, HCI_OP_LE_REJECT_CIS, sizeof(cp), &cp);
+}
+
+static void hci_le_accept_cis(struct hci_dev *hdev, __le16 handle)
+{
+	struct hci_cp_le_accept_cis cp;
+
+	cp.handle = handle;
+	hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
+}
+
+static void hci_le_cis_req_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_evt_le_cis_req *ev = (void *) skb->data;
+	u16 acl_handle, cis_handle;
+	struct hci_conn *acl, *cis;
+	int mask = hdev->link_mode;
+	__u8 flags = 0;
+
+	acl_handle = __le16_to_cpu(ev->acl_handle);
+	cis_handle = __le16_to_cpu(ev->cis_handle);
+
+	BT_DBG("%s acl_handle 0x%4.4x cis_handle 0x%4.4x cig_id 0x%2.2x "
+	       "cis_id 0x%2.2x", hdev->name, acl_handle, cis_handle,
+	       ev->cig_id, ev->cis_id);
+
+	hci_dev_lock(hdev);
+
+	acl = hci_conn_hash_lookup_handle(hdev, acl_handle);
+	if (!acl)
+		goto unlock;
+
+	mask |= hci_proto_connect_ind(hdev, &acl->dst, ISO_LINK, &flags);
+	if (!(mask & HCI_LM_ACCEPT)) {
+		hci_le_reject_cis(hdev, ev->cis_handle);
+		goto unlock;
+	}
+
+	cis = hci_conn_hash_lookup_handle(hdev, cis_handle);
+	if (!cis) {
+		cis = hci_conn_add(hdev, ISO_LINK, &acl->dst, HCI_ROLE_SLAVE);
+		if (!cis) {
+			hci_le_reject_cis(hdev, ev->cis_handle);
+			goto unlock;
+		}
+		cis->handle = cis_handle;
+	}
+
+	if (!(flags & HCI_PROTO_DEFER)) {
+		hci_le_accept_cis(hdev, ev->cis_handle);
+	} else {
+		cis->state = BT_CONNECT2;
+		hci_connect_cfm(cis, 0);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_meta *le_ev = (void *) skb->data;
@@ -5978,7 +6209,18 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_ext_adv_term_evt(hdev, skb);
 		break;
 
+	case HCI_EVT_LE_CIS_ESTABLISHED:
+		if (IS_ENABLED(CONFIG_BT_ISO))
+			hci_le_cis_estabilished_evt(hdev, skb);
+		break;
+
+	case HCI_EVT_LE_CIS_REQ:
+		if (IS_ENABLED(CONFIG_BT_ISO))
+			hci_le_cis_req_evt(hdev, skb);
+		break;
+
 	default:
+		BT_DBG("%s event 0x%2.2x", hdev->name, le_ev->subevent);
 		break;
 	}
 }
-- 
2.26.2

