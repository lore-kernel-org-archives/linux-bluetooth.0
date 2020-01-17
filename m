Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D7C33CAF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 00:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C959206E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 00:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrUQjdD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgAQABl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:01:41 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39922 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAQABk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 19:01:40 -0500
Received: by mail-pj1-f65.google.com with SMTP id e11so2437736pjt.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 16:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OaupClCTZMlpv+snNW3M5ZwbPWAFojdkuzSCoEo+tkE=;
        b=KrUQjdD87nT5t7Y3PeNWz50R+pgCz5pMmV/Mq7otpc2bmsTkzC1CWwCLOLONntZNuQ
         hPEY2Ttv2opMH4qaSkhHMy1JOOAcGx3CjZ7VKqLI69L/CEmqkOdAVBwkQNaUQYXsr7dq
         DOscQZ2sD5VKX/goeFXFnJUH9gkxucorlvWVaBgWT82ysMRXOf1C9OwQei9WaMrNkl+M
         PuRMvMhtuFwmHWynpaar2nGGTcWtAqIYA00B5pLM6+QFAK5WK5vsa3qWQXIrCSHoBGpz
         L2aKgCp5NvRiNf469+p7+biWvFfQhbJF+jCm/ITnC5Cyu1gcrsiF5iJnPEX0+zRq6QAk
         SCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OaupClCTZMlpv+snNW3M5ZwbPWAFojdkuzSCoEo+tkE=;
        b=nKYLuEAMcTqoZKc3FC24doEEN2nyF1LLbvoe/4nWyDmubX6AsMQnYDYlzlNZoz7GQO
         cibUqCe68JegrY5jT4DKG5DFulfknlEywnvi0ck5ZvtwJW2cCSw/n3qwmFETroGWutnu
         uZ/thOp0O0zoABA2YGvwAO40J9CuUZxO4UjKeEt4aSEH31Jt8mHjtj4nRylI6a3MQzCk
         fXtyaFBkq+zJmo6nj4mebaya85v1OKdh5m0QAc6xpB85LvwF/iG0uM7Z8a0I1BBsL3gm
         KZ93cLJoF+QEpxPdzOO4+j95dwj5bkjhMdd+F2QEHXiDuQrCZFEj7qTJAfAwQ6yxT5YT
         Uw1A==
X-Gm-Message-State: APjAAAVL87Tz9nxEkktN9pIajC/dYqaDpyfzlkgtAqXFEs8Ipw4Io31t
        ncTmxAZJsah2Wc0dDg4IAVtwRBGA+5A=
X-Google-Smtp-Source: APXvYqwiUs7cnHoXa0RZXs/hnvZpGfwswLHeNsI7BfnUSzRbi7GuuBhy3Lq9b7wcOIo38aWZIm8JUw==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr33807052pld.250.1579219298711;
        Thu, 16 Jan 2020 16:01:38 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.39])
        by smtp.gmail.com with ESMTPSA id v8sm26405055pff.151.2020.01.16.16.01.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 16:01:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add initial implementation of CIS connections
Date:   Thu, 16 Jan 2020 16:01:36 -0800
Message-Id: <20200117000137.29166-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial implementation of CIS connections and introduces
the ISO packets/links.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  21 +++
 include/net/bluetooth/hci_core.h  |  54 ++++++-
 include/net/bluetooth/hci_sock.h  |   2 +
 net/bluetooth/Kconfig             |   1 +
 net/bluetooth/af_bluetooth.c      |   4 +-
 net/bluetooth/hci_conn.c          | 169 +++++++++++++++++++++
 net/bluetooth/hci_core.c          | 240 ++++++++++++++++++++++++------
 net/bluetooth/hci_event.c         | 230 ++++++++++++++++++++++++++++
 8 files changed, 670 insertions(+), 51 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e42bb8e03c09..ac3432796a4a 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -53,6 +53,8 @@
 #define BTPROTO_CMTP	5
 #define BTPROTO_HIDP	6
 #define BTPROTO_AVDTP	7
+#define BTPROTO_ISO	8
+#define BTPROTO_LAST	BTPROTO_ISO
 
 #define SOL_HCI		0
 #define SOL_L2CAP	6
@@ -122,6 +124,25 @@ struct bt_voice {
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
 
+#define BT_ISO_IN_QOS		15
+#define BT_ISO_OUT_QOS		16
+struct bt_iso_qos {
+	__u8  sca;
+	__u8  packing;
+	__u8  framing;
+	__u32 interval;
+	__u16 latency;
+	__u16 mtu;
+	__u8  phy;
+	__u8  rtn;
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
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 89ecf0a80aa1..5bbed4bd6b43 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -93,6 +93,7 @@ struct hci_conn_hash {
 	unsigned int     acl_num;
 	unsigned int     amp_num;
 	unsigned int     sco_num;
+	unsigned int     iso_num;
 	unsigned int     le_num;
 	unsigned int     le_num_slave;
 };
@@ -327,13 +328,16 @@ struct hci_dev {
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
@@ -534,6 +538,7 @@ struct hci_conn {
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
 	void		*sco_data;
+	void		*iso_data;
 	struct amp_mgr	*amp_mgr;
 
 	struct hci_conn	*link;
@@ -737,6 +742,9 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 	case ESCO_LINK:
 		h->sco_num++;
 		break;
+	case ISO_LINK:
+		h->iso_num++;
+		break;
 	}
 }
 
@@ -763,6 +771,9 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	case ESCO_LINK:
 		h->sco_num--;
 		break;
+	case ISO_LINK:
+		h->iso_num--;
+		break;
 	}
 }
 
@@ -779,6 +790,8 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	case SCO_LINK:
 	case ESCO_LINK:
 		return h->sco_num;
+	case ISO_LINK:
+		return h->iso_num;
 	default:
 		return 0;
 	}
@@ -788,7 +801,7 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *c = &hdev->conn_hash;
 
-	return c->acl_num + c->amp_num + c->sco_num + c->le_num;
+	return c->acl_num + c->amp_num + c->sco_num + c->le_num + c->iso_num;
 }
 
 static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
@@ -874,6 +887,30 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
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
@@ -917,6 +954,7 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
+bool hci_le_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role);
@@ -939,6 +977,10 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting);
+struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
+				 __u8 dst_type,
+				 struct bt_iso_qos *in_qos,
+				 struct bt_iso_qos *out_qos);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
@@ -1227,6 +1269,11 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
+/* CIS Master/Slave support */
+#define cis_capable(dev) (cis_master_capable(dev) || cis_slave_capable(dev))
+#define cis_master_capable(dev) ((dev)->le_features[3] & HCI_LE_CIS_MASTER)
+#define cis_slave_capable(dev) ((dev)->le_features[3] & HCI_LE_CIS_SLAVE)
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
@@ -1241,6 +1288,10 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	case ESCO_LINK:
 		return sco_connect_ind(hdev, bdaddr, flags);
 
+	case ISO_LINK:
+		/* TODO: Handle connection indication */
+		return -EINVAL;
+
 	default:
 		BT_ERR("unknown link type %d", type);
 		return -EINVAL;
@@ -1471,6 +1522,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
+void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 
diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
index 8e9138acdae1..91c88355f2e8 100644
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
index 165148c7c4ce..6d1ebb271654 100644
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
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 3fd124927d4d..efed33261ac3 100644
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
index 87691404d0c6..607f9e2a8e42 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -531,6 +531,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
 		break;
 	case LE_LINK:
+	case ISO_LINK:
 		/* conn->src should reflect the local identity address */
 		hci_copy_identity_address(hdev, &conn->src, &conn->src_type);
 		break;
@@ -1269,6 +1270,174 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
+static bool hci_le_set_cig_params(struct hci_conn *conn,
+				  struct bt_iso_qos *in_qos,
+				  struct bt_iso_qos *out_qos)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct {
+		struct hci_cp_le_set_cig_params cp;
+		struct hci_cis_params cis;
+	} cig;
+	u32 interval;
+
+	cig.cp.cig_id = 0x00;
+	interval = cpu_to_le32(out_qos->interval);
+	memcpy(cig.cp.m_interval, &interval, sizeof(cig.cp.m_interval));
+	interval = cpu_to_le32(in_qos->interval);
+	memcpy(cig.cp.s_interval, &interval, sizeof(cig.cp.s_interval));
+	cig.cp.sca = in_qos->sca;
+	cig.cp.packing = out_qos->packing;
+	cig.cp.framing = out_qos->framing;
+	cig.cp.m_latency = cpu_to_le16(out_qos->latency);
+	cig.cp.s_latency = cpu_to_le16(in_qos->latency);
+	/* TODO: Allow multiple CIS to be programed? */
+	cig.cp.num_cis = 0x01;
+
+	cig.cis.cis_id = 0x00;
+	cig.cis.m_sdu = out_qos->mtu;
+	cig.cis.s_sdu = in_qos->mtu;
+	cig.cis.m_phy = out_qos->phy;
+	cig.cis.s_phy = in_qos->phy;
+	cig.cis.m_rtn = out_qos->rtn;
+	cig.cis.s_rtn = in_qos->rtn;
+
+	if (hci_send_cmd(hdev, HCI_OP_LE_SET_CIG_PARAMS, sizeof(cig), &cig) < 0)
+		return false;
+
+	return true;
+}
+
+static struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
+				     __u8 dst_type,
+				      struct bt_iso_qos *in_qos,
+				      struct bt_iso_qos *out_qos)
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
+	if (cis->state == BT_BOUND)
+		return cis;
+
+	if (!hci_le_set_cig_params(cis, in_qos, out_qos)) {
+		hci_conn_drop(cis);
+		return NULL;
+	}
+
+	cis->state = BT_BOUND;
+
+	return cis;
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
+	if (conn->type != LE_LINK || !conn->link)
+		return false;
+
+	cis = conn->link;
+
+	cmd.cp.num_cis = 0x01;
+	cmd.cis.acl_handle = cpu_to_le16(conn->handle);
+	cmd.cis.cis_handle = cpu_to_le16(cis->handle);
+
+	if (hci_send_cmd(hdev, HCI_OP_LE_CREATE_CIS, sizeof(cmd), &cmd) < 0)
+		return false;
+
+	return true;
+}
+
+static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
+			      struct bt_iso_qos *qos, __u8 phy)
+{
+	if (!qos->mtu) {
+		if (hdev->iso_mtu > 0)
+			qos->mtu = hdev->iso_mtu;
+		else if (hdev->le_mtu > 0)
+			qos->mtu = hdev->le_mtu;
+		else
+			qos->mtu = hdev->acl_mtu;
+	}
+
+	/* Use LE ACL PHY if not set */
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
+				 __u8 dst_type,
+				 struct bt_iso_qos *in_qos,
+				 struct bt_iso_qos *out_qos)
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
+					  HCI_LE_CONN_TIMEOUT);
+	if (IS_ERR(le))
+		return le;
+
+	hci_iso_qos_setup(hdev, le, out_qos,
+			  le->le_tx_phy ? le->le_tx_phy : hdev->le_tx_def_phys);
+	hci_iso_qos_setup(hdev, le, in_qos,
+			  le->le_rx_phy ? le->le_rx_phy : hdev->le_rx_def_phys);
+
+	/* Mirror PHYs when disabled as SDU will be set to 0 */
+	if (!in_qos->phy)
+		in_qos->phy = out_qos->phy;
+
+	if (!out_qos->phy)
+		out_qos->phy = in_qos->phy;
+
+	cis = hci_bind_cis(hdev, dst, dst_type, in_qos, out_qos);
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
index 1ca7508b6ca7..b07b94fd335d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -303,7 +303,10 @@ static void le_setup(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 
 	/* Read LE Buffer Size */
-	hci_req_add(req, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
+	if (cis_capable(req->hdev))
+		hci_req_add(req, HCI_OP_LE_READ_BUFFER_SIZE_V2, 0, NULL);
+	else
+		hci_req_add(req, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
 
 	/* Read LE Local Supported Features */
 	hci_req_add(req, HCI_OP_LE_READ_LOCAL_FEATURES, 0, NULL);
@@ -721,6 +724,12 @@ static int hci_init3_req(struct hci_request *req, unsigned long opt)
 						 * Terminated
 						 */
 
+		if (cis_capable(hdev)) {
+			events[3] |= 0x01; /* LE CIS Established */
+			if (cis_slave_capable(hdev))
+				events[3] |= 0x02; /* LE CIS Request */
+		}
+
 		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK, sizeof(events),
 			    events);
 
@@ -1835,7 +1844,10 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 		hdev->flush(hdev);
 
 	atomic_set(&hdev->cmd_cnt, 1);
-	hdev->acl_cnt = 0; hdev->sco_cnt = 0; hdev->le_cnt = 0;
+	hdev->acl_cnt = 0;
+	hdev->sco_cnt = 0;
+	hdev->le_cnt = 0;
+	hdev->iso_cnt = 0;
 
 	ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT, NULL);
 
@@ -3565,7 +3577,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
 	    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
-	    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT) {
+	    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
+	    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -3880,9 +3893,117 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
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
@@ -3915,29 +4036,7 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 
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
@@ -3971,7 +4070,7 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 	struct hci_chan *chan = NULL;
 	unsigned int num = 0, min = ~0, cur_prio = 0;
 	struct hci_conn *conn;
-	int cnt, q, conn_num = 0;
+	int conn_num = 0;
 
 	BT_DBG("%s", hdev->name);
 
@@ -4021,27 +4120,8 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
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
@@ -4322,13 +4402,40 @@ static void hci_sched_le(struct hci_dev *hdev)
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
@@ -4336,6 +4443,7 @@ static void hci_tx_work(struct work_struct *work)
 		hci_sched_sco(hdev);
 		hci_sched_esco(hdev);
 		hci_sched_le(hdev);
+		hci_sched_iso(hdev);
 	}
 
 	/* Send next queued raw (unknown type) packet */
@@ -4412,6 +4520,34 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -4543,6 +4679,7 @@ static void hci_rx_work(struct work_struct *work)
 			switch (hci_skb_pkt_type(skb)) {
 			case HCI_ACLDATA_PKT:
 			case HCI_SCODATA_PKT:
+			case HCI_ISODATA_PKT:
 				kfree_skb(skb);
 				continue;
 			}
@@ -4565,6 +4702,11 @@ static void hci_rx_work(struct work_struct *work)
 			hci_scodata_packet(hdev, skb);
 			break;
 
+		case HCI_ISODATA_PKT:
+			BT_DBG("%s ISO data packet", hdev->name);
+			hci_isodata_packet(hdev, skb);
+			break;
+
 		default:
 			kfree_skb(skb);
 			break;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6ddc4a74a5e4..c40ae10e7b9a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3125,6 +3125,102 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
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
+		if (conn->type != ISO_LINK || conn->handle ||
+		    conn->state == BT_CONNECTED)
+			continue;
+
+		if (rp->status) {
+			conn->state = BT_CLOSED;
+			hci_connect_cfm(conn, rp->status);
+			hci_conn_del(conn);
+			return;
+		}
+
+		conn->handle = __le16_to_cpu(rp->handle[i++]);
+
+		BT_DBG("%p handle 0x%4.4x", conn, conn->handle);
+
+		/* Create CIS if LE is already connected */
+		if (conn->link->state == BT_CONNECTED)
+			hci_le_create_cis(conn->link);
+
+		if (i == rp->num_handles)
+			break;
+	}
+
+	rcu_read_unlock();
+
+	hci_dev_unlock(hdev);
+}
+
+static void hci_cs_le_create_cis(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_create_cis *cp;
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
+	while (cp->num_cis--) {
+		struct hci_conn *conn;
+		u16 handle;
+
+		handle = __le16_to_cpu(cp->cis[cp->num_cis - 1].cis_handle);
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
@@ -3462,6 +3558,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_set_adv_set_random_addr(hdev, skb);
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
@@ -3567,6 +3671,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cs_le_ext_create_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_LE_CREATE_CIS:
+		hci_cs_le_create_cis(hdev, ev->status);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
@@ -3687,6 +3795,22 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -5021,6 +5145,9 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
 
+	/* Create CIS if pending */
+	hci_le_create_cis(conn);
+
 	/* The remote features procedure is defined for master
 	 * role only. So only in case of an initiated connection
 	 * request the remote features.
@@ -5741,6 +5868,100 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
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
+		cis = hci_conn_add(hdev, ISO_LINK, &acl->dst, HCI_ROLE_MASTER);
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
@@ -5792,7 +6013,16 @@ static void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_le_ext_adv_term_evt(hdev, skb);
 		break;
 
+	case HCI_EVT_LE_CIS_ESTABLISHED:
+		hci_le_cis_estabilished_evt(hdev, skb);
+		break;
+
+	case HCI_EVT_LE_CIS_REQ:
+		hci_le_cis_req_evt(hdev, skb);
+		break;
+
 	default:
+		BT_DBG("%s event 0x%2.2x", hdev->name, le_ev->subevent);
 		break;
 	}
 }
-- 
2.21.0

