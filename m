Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9930C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587712467C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 06:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHcBqPex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAOGfa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:35:30 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:44171 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgAOGf3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 01:35:29 -0500
Received: by mail-pg1-f173.google.com with SMTP id x7so7708590pgl.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 22:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zb1Zpcm1nbv4nSBX+pFQK6fBeJ7BmpQd7ro4P3NzJbA=;
        b=WHcBqPexbxw0TD77LJam1j0CnY3K+i7EWIcstGu4w5bcKsqUwGXvcNJ30DiTaIPR/5
         z+LgVi+GBOhovNR8eWTBwOBkqP5qeelVEzXkX7zpJb+NttfEVRaX5reLc9RBU6L9YwiD
         /oW4gaBpaMz556yYnv4ybVIFHf8Yjj/wNVIfLLL3sHzXF/X3p7I7SlVJ1Brrttr+K7fz
         Nwp27UXC3RjTRyiimrjf0RVFNt6Os6dS3VgfdcKEf9USYWcLsOjNkrGdSyQBZZxhZNsq
         lsKJNkYqVTcX8lIP61l8z9ZKj23uVlNK05QnHUCZs0+H/JZiQQCmuDO8CzJm31+kkWh8
         97Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zb1Zpcm1nbv4nSBX+pFQK6fBeJ7BmpQd7ro4P3NzJbA=;
        b=X1cS1VutHI0rCfOkTKgiEyqaA8toiypYa4clyGDFCSrQ8ZLuLO9mYAKuDbVGrE5HNq
         1L2gosznZAKA2GWekjZ3LedwZjHW8m1CsonaXzVlurBHdlOKAdPBaL07ZfGgdX8Xv7Yf
         ph4562+u6nssJosIZMajEx2wcgTsrS5mVzggtgQ8cdzDNmGK7YZ/tmr3apFBrTHx172n
         hbXdHaD2AWwsvdQeTnh98kXIN5/4UToX87OJBPIO9YChAyy15q5cmRiuHJrznO0dLL5z
         d2sb0gWdZ+lrrP7+sL3fF1zqynCPfdHCAwSTGS6F+KNH/ixl5IQ5wNruo+v1aU5B2exJ
         FMkQ==
X-Gm-Message-State: APjAAAVOk/myRYI7SqR8Qd64orHSPekvUaI4qpYBmKBLDFSw4LmnW5Jc
        Ei66Z2rw43/eArDwolt5O5PBY8RvQgY=
X-Google-Smtp-Source: APXvYqzP99r+aj6kvc5nwxpkOVSdQPzbuSaHszCawKTMCSAlxOAtDA+Kyjn+7uL5xyjMx2eIgGHdIg==
X-Received: by 2002:aa7:98ca:: with SMTP id e10mr29999852pfm.24.1579070127087;
        Tue, 14 Jan 2020 22:35:27 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id q21sm19637469pff.105.2020.01.14.22.35.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 22:35:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 02/11] Bluetooth: Add initial implementation of CIS connections
Date:   Tue, 14 Jan 2020 22:35:10 -0800
Message-Id: <20200115063523.32127-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115063523.32127-1-luiz.dentz@gmail.com>
References: <20200115063523.32127-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial implementation of CIS connections along with a new
socket type BTPROTO_ISO to make use of it.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |   35 +
 include/net/bluetooth/hci_core.h  |   68 +-
 include/net/bluetooth/hci_sock.h  |    2 +
 include/net/bluetooth/iso.h       |   36 +
 net/bluetooth/Kconfig             |    1 +
 net/bluetooth/Makefile            |    1 +
 net/bluetooth/af_bluetooth.c      |   12 +-
 net/bluetooth/hci_conn.c          |  169 ++++
 net/bluetooth/hci_core.c          |  243 ++++-
 net/bluetooth/hci_event.c         |  230 +++++
 net/bluetooth/iso.c               | 1393 +++++++++++++++++++++++++++++
 11 files changed, 2138 insertions(+), 52 deletions(-)
 create mode 100644 include/net/bluetooth/iso.h
 create mode 100644 net/bluetooth/iso.c

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e42bb8e03c09..af969f250b7d 100644
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
@@ -410,6 +431,20 @@ static inline void sco_exit(void)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BT_LE)
+int iso_init(void);
+void iso_exit(void);
+#else
+static inline int iso_init(void)
+{
+	return 0;
+}
+
+static inline void iso_exit(void)
+{
+}
+#endif
+
 int mgmt_init(void);
 void mgmt_exit(void);
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index faebe3859931..ef68041d279a 100644
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
@@ -320,13 +321,16 @@ struct hci_dev {
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
@@ -526,6 +530,7 @@ struct hci_conn {
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
 	void		*sco_data;
+	void		*iso_data;
 	struct amp_mgr	*amp_mgr;
 
 	struct hci_conn	*link;
@@ -609,6 +614,21 @@ static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BT_LE)
+int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
+void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+#else
+static inline int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				  __u8 *flags)
+{
+	return 0;
+}
+static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
+			    u16 flags)
+{
+}
+#endif
+
 /* ----- Inquiry cache ----- */
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
 #define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   /* 60 seconds */
@@ -729,6 +749,9 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 	case ESCO_LINK:
 		h->sco_num++;
 		break;
+	case ISO_LINK:
+		h->iso_num++;
+		break;
 	}
 }
 
@@ -755,6 +778,9 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	case ESCO_LINK:
 		h->sco_num--;
 		break;
+	case ISO_LINK:
+		h->iso_num--;
+		break;
 	}
 }
 
@@ -771,6 +797,8 @@ static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 	case SCO_LINK:
 	case ESCO_LINK:
 		return h->sco_num;
+	case ISO_LINK:
+		return h->iso_num;
 	default:
 		return 0;
 	}
@@ -780,7 +808,7 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *c = &hdev->conn_hash;
 
-	return c->acl_num + c->amp_num + c->sco_num + c->le_num;
+	return c->acl_num + c->amp_num + c->sco_num + c->le_num + c->iso_num;
 }
 
 static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
@@ -866,6 +894,30 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
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
@@ -909,6 +961,7 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
+bool hci_le_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role);
@@ -931,6 +984,10 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
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
@@ -1217,6 +1274,11 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
+/* CIS Master/Slave support */
+#define cis_capable(dev) (cis_master_capable(dev) || cis_slave_capable(dev))
+#define cis_master_capable(dev) ((dev)->le_features[3] & HCI_LE_CIS_MASTER)
+#define cis_slave_capable(dev) ((dev)->le_features[3] & HCI_LE_CIS_SLAVE)
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
@@ -1231,6 +1293,9 @@ static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	case ESCO_LINK:
 		return sco_connect_ind(hdev, bdaddr, flags);
 
+	case ISO_LINK:
+		return iso_connect_ind(hdev, bdaddr, flags);
+
 	default:
 		BT_ERR("unknown link type %d", type);
 		return -EINVAL;
@@ -1461,6 +1526,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
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
diff --git a/include/net/bluetooth/iso.h b/include/net/bluetooth/iso.h
new file mode 100644
index 000000000000..dd0bfccc0e28
--- /dev/null
+++ b/include/net/bluetooth/iso.h
@@ -0,0 +1,36 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2019 Intel Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+#ifndef __ISO_H
+#define __ISO_H
+
+/* ISO defaults */
+#define ISO_DEFAULT_MTU		251
+
+/* ISO socket address */
+struct sockaddr_iso {
+	sa_family_t	iso_family;
+	bdaddr_t	iso_bdaddr;
+	__u8		iso_bdaddr_type;
+};
+
+#endif /* __ISO_H */
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
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index fda41c0b4781..9f1f669b8c7e 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -17,6 +17,7 @@ bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	ecdh_helper.o hci_request.o mgmt_util.o
 
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
+bluetooth-$(CONFIG_BT_LE) += iso.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
 bluetooth-$(CONFIG_BT_LEDS) += leds.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 3fd124927d4d..94a55eed6b77 100644
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
@@ -755,12 +757,18 @@ static int __init bt_init(void)
 	if (err)
 		goto cleanup_cap;
 
-	err = mgmt_init();
+	err = iso_init();
 	if (err)
 		goto cleanup_sco;
 
+	err = mgmt_init();
+	if (err)
+		goto cleanup_iso;
+
 	return 0;
 
+cleanup_iso:
+	iso_exit();
 cleanup_sco:
 	sco_exit();
 cleanup_cap:
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
index 9e19d5a3aac8..cc78fcc3672c 100644
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
 
@@ -3496,7 +3508,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
 	    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
-	    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT) {
+	    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
+	    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -3811,9 +3824,117 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
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
@@ -3846,29 +3967,7 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 
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
@@ -3902,7 +4001,7 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 	struct hci_chan *chan = NULL;
 	unsigned int num = 0, min = ~0, cur_prio = 0;
 	struct hci_conn *conn;
-	int cnt, q, conn_num = 0;
+	int conn_num = 0;
 
 	BT_DBG("%s", hdev->name);
 
@@ -3952,27 +4051,8 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
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
@@ -4258,13 +4338,40 @@ static void hci_sched_le(struct hci_dev *hdev)
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
@@ -4272,6 +4379,7 @@ static void hci_tx_work(struct work_struct *work)
 		hci_sched_sco(hdev);
 		hci_sched_esco(hdev);
 		hci_sched_le(hdev);
+		hci_sched_iso(hdev);
 	}
 
 	/* Send next queued raw (unknown type) packet */
@@ -4348,6 +4456,37 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
+	if (conn) {
+		/* Send to upper protocol */
+		iso_recv(conn, skb, flags);
+		return;
+	} else {
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
@@ -4479,6 +4618,7 @@ static void hci_rx_work(struct work_struct *work)
 			switch (hci_skb_pkt_type(skb)) {
 			case HCI_ACLDATA_PKT:
 			case HCI_SCODATA_PKT:
+			case HCI_ISODATA_PKT:
 				kfree_skb(skb);
 				continue;
 			}
@@ -4501,6 +4641,11 @@ static void hci_rx_work(struct work_struct *work)
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
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
new file mode 100644
index 000000000000..bf50f60f8919
--- /dev/null
+++ b/net/bluetooth/iso.c
@@ -0,0 +1,1393 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2019 Intel Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+/* Bluetooth ISO sockets. */
+
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/sched/signal.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/iso.h>
+
+static const struct proto_ops iso_sock_ops;
+
+static struct bt_sock_list iso_sk_list = {
+	.lock = __RW_LOCK_UNLOCKED(iso_sk_list.lock)
+};
+
+/* ---- ISO connections ---- */
+struct iso_conn {
+	struct hci_conn	*hcon;
+
+	spinlock_t	lock;
+	struct sock	*sk;
+
+	struct sk_buff	*rx_skb;
+	__u32		rx_len;
+};
+
+#define iso_conn_lock(c)	spin_lock(&c->lock);
+#define iso_conn_unlock(c)	spin_unlock(&c->lock);
+
+static void iso_sock_close(struct sock *sk);
+static void iso_sock_kill(struct sock *sk);
+
+/* ----- ISO socket info ----- */
+#define iso_pi(sk) ((struct iso_pinfo *) sk)
+
+struct iso_pinfo {
+	struct bt_sock		bt;
+	bdaddr_t		src;
+	__u8			src_type;
+	bdaddr_t		dst;
+	__u8			dst_type;
+	__u32			flags;
+	struct bt_iso_qos	in_qos;
+	struct bt_iso_qos	out_qos;
+	struct iso_conn		*conn;
+};
+
+/* ---- ISO timers ---- */
+#define ISO_CONN_TIMEOUT	(HZ * 40)
+#define ISO_DISCONN_TIMEOUT	(HZ * 2)
+
+static void iso_sock_timeout(struct timer_list *t)
+{
+	struct sock *sk = from_timer(sk, t, sk_timer);
+
+	BT_DBG("sock %p state %d", sk, sk->sk_state);
+
+	bh_lock_sock(sk);
+	sk->sk_err = ETIMEDOUT;
+	sk->sk_state_change(sk);
+	bh_unlock_sock(sk);
+
+	iso_sock_kill(sk);
+	sock_put(sk);
+}
+
+static void iso_sock_set_timer(struct sock *sk, long timeout)
+{
+	BT_DBG("sock %p state %d timeout %ld", sk, sk->sk_state, timeout);
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + timeout);
+}
+
+static void iso_sock_clear_timer(struct sock *sk)
+{
+	BT_DBG("sock %p state %d", sk, sk->sk_state);
+	sk_stop_timer(sk, &sk->sk_timer);
+}
+
+/* ---- ISO connections ---- */
+static struct iso_conn *iso_conn_add(struct hci_conn *hcon)
+{
+	struct iso_conn *conn = hcon->iso_data;
+
+	if (conn)
+		return conn;
+
+	conn = kzalloc(sizeof(struct iso_conn), GFP_KERNEL);
+	if (!conn)
+		return NULL;
+
+	spin_lock_init(&conn->lock);
+
+	hcon->iso_data = conn;
+	conn->hcon = hcon;
+
+	BT_DBG("hcon %p conn %p", hcon, conn);
+
+	return conn;
+}
+
+/* Delete channel.
+ * Must be called on the locked socket. */
+static void iso_chan_del(struct sock *sk, int err)
+{
+	struct iso_conn *conn;
+
+	conn = iso_pi(sk)->conn;
+
+	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
+
+	if (conn) {
+		iso_conn_lock(conn);
+		conn->sk = NULL;
+		iso_pi(sk)->conn = NULL;
+		iso_conn_unlock(conn);
+
+		if (conn->hcon)
+			hci_conn_drop(conn->hcon);
+	}
+
+	sk->sk_state = BT_CLOSED;
+	sk->sk_err   = err;
+	sk->sk_state_change(sk);
+
+	sock_set_flag(sk, SOCK_ZAPPED);
+}
+
+static void iso_conn_del(struct hci_conn *hcon, int err)
+{
+	struct iso_conn *conn = hcon->iso_data;
+	struct sock *sk;
+
+	if (!conn)
+		return;
+
+	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
+
+	/* Kill socket */
+	iso_conn_lock(conn);
+	sk = conn->sk;
+	iso_conn_unlock(conn);
+
+	if (sk) {
+		sock_hold(sk);
+		bh_lock_sock(sk);
+		iso_sock_clear_timer(sk);
+		iso_chan_del(sk, err);
+		bh_unlock_sock(sk);
+		iso_sock_kill(sk);
+		sock_put(sk);
+	}
+
+	hcon->iso_data = NULL;
+	kfree(conn);
+}
+
+static void __iso_chan_add(struct iso_conn *conn, struct sock *sk,
+			   struct sock *parent)
+{
+	BT_DBG("conn %p", conn);
+
+	iso_pi(sk)->conn = conn;
+	conn->sk = sk;
+
+	if (parent)
+		bt_accept_enqueue(parent, sk, true);
+}
+
+static int iso_chan_add(struct iso_conn *conn, struct sock *sk,
+			struct sock *parent)
+{
+	int err = 0;
+
+	iso_conn_lock(conn);
+	if (conn->sk)
+		err = -EBUSY;
+	else
+		__iso_chan_add(conn, sk, parent);
+
+	iso_conn_unlock(conn);
+	return err;
+}
+
+static int iso_connect(struct sock *sk)
+{
+	struct iso_conn *conn;
+	struct hci_conn *hcon;
+	struct hci_dev  *hdev;
+	int err;
+
+	BT_DBG("%pMR -> %pMR", &iso_pi(sk)->src, &iso_pi(sk)->dst);
+
+	hdev = hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
+			     iso_pi(sk)->dst_type);
+	if (!hdev)
+		return -EHOSTUNREACH;
+
+	hci_dev_lock(hdev);
+
+	if (!cis_master_capable(hdev)) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
+	/* Fail if either PHYs are marked as disabled */
+	if (!iso_pi(sk)->in_qos.phy && !iso_pi(sk)->out_qos.phy) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	hcon = hci_connect_cis(hdev, &iso_pi(sk)->dst, iso_pi(sk)->dst_type,
+			       &iso_pi(sk)->in_qos, &iso_pi(sk)->out_qos);
+	if (IS_ERR(hcon)) {
+		err = PTR_ERR(hcon);
+		goto done;
+	}
+
+	conn = iso_conn_add(hcon);
+	if (!conn) {
+		hci_conn_drop(hcon);
+		err = -ENOMEM;
+		goto done;
+	}
+
+	/* Update source addr of the socket */
+	bacpy(&iso_pi(sk)->src, &hcon->src);
+
+	err = iso_chan_add(conn, sk, NULL);
+	if (err)
+		goto done;
+
+	if (hcon->state == BT_CONNECTED) {
+		iso_sock_clear_timer(sk);
+		sk->sk_state = BT_CONNECTED;
+	} else {
+		sk->sk_state = BT_CONNECT;
+		iso_sock_set_timer(sk, sk->sk_sndtimeo);
+	}
+
+done:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+	return err;
+}
+
+static int iso_send_frame(struct sock *sk, struct msghdr *msg, int len)
+{
+	struct iso_conn *conn = iso_pi(sk)->conn;
+	struct sk_buff *skb, **frag;
+	struct hci_iso_data_hdr *hdr;
+	int err, sent = 0;
+	unsigned int count;
+	static __u16 sn;
+
+	BT_DBG("sk %p len %d", sk, len);
+
+	count = min_t(unsigned int, iso_pi(sk)->out_qos.mtu, len);
+
+	skb = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
+	if (!skb)
+		return err;
+
+	/* Create ISO data header */
+	hdr = skb_put(skb, HCI_ISO_DATA_HDR_SIZE);
+	hdr->sn = cpu_to_le16(sn++);
+	hdr->slen = cpu_to_le16(hci_iso_data_len_pack(len,
+						      HCI_ISO_STATUS_VALID));
+
+	if (!copy_from_iter_full(skb_put(skb, count), count, &msg->msg_iter)) {
+		kfree_skb(skb);
+		return -EFAULT;
+	}
+
+	sent += count;
+	len -= count;
+
+	BT_DBG("skb %p len %d", sk, count);
+
+	/* Continuation fragments */
+	frag = &skb_shinfo(skb)->frag_list;
+	while (len) {
+		struct sk_buff *tmp;
+
+		count = min_t(unsigned int, iso_pi(sk)->out_qos.mtu, len);
+
+		tmp = bt_skb_send_alloc(sk, count,
+					msg->msg_flags & MSG_DONTWAIT, &err);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+
+		*frag = tmp;
+
+		if (!copy_from_iter_full(skb_put(skb, count), count,
+					 &msg->msg_iter)) {
+			kfree_skb(skb);
+			return -EFAULT;
+		}
+
+		sent += count;
+		len  -= count;
+
+		BT_DBG("frag %p len %d", *frag, count);
+
+		skb->len += (*frag)->len;
+		skb->data_len += (*frag)->len;
+
+		frag = &(*frag)->next;
+	}
+
+	hci_send_iso(conn->hcon, skb);
+
+	return sent;
+}
+
+static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
+{
+	struct sock *sk;
+
+	iso_conn_lock(conn);
+	sk = conn->sk;
+	iso_conn_unlock(conn);
+
+	if (!sk)
+		goto drop;
+
+	BT_DBG("sk %p len %d", sk, skb->len);
+
+	if (sk->sk_state != BT_CONNECTED)
+		goto drop;
+
+	if (!sock_queue_rcv_skb(sk, skb))
+		return;
+
+drop:
+	kfree_skb(skb);
+}
+
+/* -------- Socket interface ---------- */
+static struct sock *__iso_get_sock_listen_by_addr(bdaddr_t *ba)
+{
+	struct sock *sk;
+
+	sk_for_each(sk, &iso_sk_list.head) {
+		if (sk->sk_state != BT_LISTEN)
+			continue;
+
+		if (!bacmp(&iso_pi(sk)->src, ba))
+			return sk;
+	}
+
+	return NULL;
+}
+
+/* Find socket listening on source bdaddr.
+ * Returns closest match.
+ */
+static struct sock *iso_get_sock_listen(bdaddr_t *src)
+{
+	struct sock *sk = NULL, *sk1 = NULL;
+
+	read_lock(&iso_sk_list.lock);
+
+	sk_for_each(sk, &iso_sk_list.head) {
+		if (sk->sk_state != BT_LISTEN)
+			continue;
+
+		/* Exact match. */
+		if (!bacmp(&iso_pi(sk)->src, src))
+			break;
+
+		/* Closest match */
+		if (!bacmp(&iso_pi(sk)->src, BDADDR_ANY))
+			sk1 = sk;
+	}
+
+	read_unlock(&iso_sk_list.lock);
+
+	return sk ? sk : sk1;
+}
+
+static void iso_sock_destruct(struct sock *sk)
+{
+	BT_DBG("sk %p", sk);
+
+	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge(&sk->sk_write_queue);
+}
+
+static void iso_sock_cleanup_listen(struct sock *parent)
+{
+	struct sock *sk;
+
+	BT_DBG("parent %p", parent);
+
+	/* Close not yet accepted channels */
+	while ((sk = bt_accept_dequeue(parent, NULL))) {
+		iso_sock_close(sk);
+		iso_sock_kill(sk);
+	}
+
+	parent->sk_state  = BT_CLOSED;
+	sock_set_flag(parent, SOCK_ZAPPED);
+}
+
+/* Kill socket (only if zapped and orphan)
+ * Must be called on unlocked socket.
+ */
+static void iso_sock_kill(struct sock *sk)
+{
+	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket ||
+	    sock_flag(sk, SOCK_DEAD))
+		return;
+
+	BT_DBG("sk %p state %d", sk, sk->sk_state);
+
+	/* Kill poor orphan */
+	bt_sock_unlink(&iso_sk_list, sk);
+	sock_set_flag(sk, SOCK_DEAD);
+	sock_put(sk);
+}
+
+static void __iso_sock_close(struct sock *sk)
+{
+	BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socket);
+
+	switch (sk->sk_state) {
+	case BT_LISTEN:
+		iso_sock_cleanup_listen(sk);
+		break;
+
+	case BT_CONNECTED:
+	case BT_CONFIG:
+		if (iso_pi(sk)->conn->hcon) {
+			sk->sk_state = BT_DISCONN;
+			iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
+			iso_conn_lock(iso_pi(sk)->conn);
+			hci_conn_drop(iso_pi(sk)->conn->hcon);
+			iso_pi(sk)->conn->hcon = NULL;
+			iso_conn_unlock(iso_pi(sk)->conn);
+		} else
+			iso_chan_del(sk, ECONNRESET);
+		break;
+
+	case BT_CONNECT2:
+	case BT_CONNECT:
+	case BT_DISCONN:
+		iso_chan_del(sk, ECONNRESET);
+		break;
+
+	default:
+		sock_set_flag(sk, SOCK_ZAPPED);
+		break;
+	}
+}
+
+/* Must be called on unlocked socket. */
+static void iso_sock_close(struct sock *sk)
+{
+	iso_sock_clear_timer(sk);
+	lock_sock(sk);
+	__iso_sock_close(sk);
+	release_sock(sk);
+	iso_sock_kill(sk);
+}
+
+static void iso_sock_init(struct sock *sk, struct sock *parent)
+{
+	BT_DBG("sk %p", sk);
+
+	if (parent) {
+		sk->sk_type = parent->sk_type;
+		bt_sk(sk)->flags = bt_sk(parent)->flags;
+		security_sk_clone(parent, sk);
+	}
+}
+
+static struct proto iso_proto = {
+	.name		= "ISO",
+	.owner		= THIS_MODULE,
+	.obj_size	= sizeof(struct iso_pinfo)
+};
+
+static struct bt_iso_qos default_qos = {
+	.sca		= 0x00,
+	.packing	= 0x00,
+	.framing	= 0x00,
+	.interval	= 0,
+	.latency	= 0,
+	.mtu		= 0,
+	.phy		= BT_ISO_PHY_ANY,
+	.rtn		= 0x00,
+};
+
+static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
+				   int proto, gfp_t prio, int kern)
+{
+	struct sock *sk;
+
+	sk = sk_alloc(net, PF_BLUETOOTH, prio, &iso_proto, kern);
+	if (!sk)
+		return NULL;
+
+	sock_init_data(sock, sk);
+	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+
+	sk->sk_destruct = iso_sock_destruct;
+	sk->sk_sndtimeo = ISO_CONN_TIMEOUT;
+
+	sock_reset_flag(sk, SOCK_ZAPPED);
+
+	sk->sk_protocol = proto;
+	sk->sk_state    = BT_OPEN;
+
+	/* Set address type as public as default src address is BDADDR_ANY */
+	iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
+
+	/* TODO: Add proper defaults */
+	iso_pi(sk)->in_qos = default_qos;
+	iso_pi(sk)->out_qos = default_qos;
+
+	timer_setup(&sk->sk_timer, iso_sock_timeout, 0);
+
+	bt_sock_link(&iso_sk_list, sk);
+	return sk;
+}
+
+static int iso_sock_create(struct net *net, struct socket *sock, int protocol,
+			   int kern)
+{
+	struct sock *sk;
+
+	BT_DBG("sock %p", sock);
+
+	sock->state = SS_UNCONNECTED;
+
+	if (sock->type != SOCK_SEQPACKET)
+		return -ESOCKTNOSUPPORT;
+
+	sock->ops = &iso_sock_ops;
+
+	sk = iso_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern);
+	if (!sk)
+		return -ENOMEM;
+
+	iso_sock_init(sk, NULL);
+	return 0;
+}
+
+static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
+			 int addr_len)
+{
+	struct sockaddr_iso *sa = (struct sockaddr_iso *) addr;
+	struct sock *sk = sock->sk;
+	int err = 0;
+
+	BT_DBG("sk %p %pMR type %u", sk, &sa->iso_bdaddr, sa->iso_bdaddr_type);
+
+	if (!addr || addr_len < sizeof(struct sockaddr_iso) ||
+	    addr->sa_family != AF_BLUETOOTH)
+		return -EINVAL;
+
+	lock_sock(sk);
+
+	if (sk->sk_state != BT_OPEN) {
+		err = -EBADFD;
+		goto done;
+	}
+
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	/* Check if the address type is of LE type */
+	if (!bdaddr_type_is_le(sa->iso_bdaddr_type)) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	bacpy(&iso_pi(sk)->src, &sa->iso_bdaddr);
+	iso_pi(sk)->src_type = sa->iso_bdaddr_type;
+
+	sk->sk_state = BT_BOUND;
+
+done:
+	release_sock(sk);
+	return err;
+}
+
+static int iso_sock_connect(struct socket *sock, struct sockaddr *addr,
+			    int alen, int flags)
+{
+	struct sockaddr_iso *sa = (struct sockaddr_iso *) addr;
+	struct sock *sk = sock->sk;
+	int err;
+
+	BT_DBG("sk %p", sk);
+
+	if (alen < sizeof(struct sockaddr_iso) ||
+	    addr->sa_family != AF_BLUETOOTH)
+		return -EINVAL;
+
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
+		return -EBADFD;
+
+	if (sk->sk_type != SOCK_SEQPACKET)
+		return -EINVAL;
+
+	/* Check if the address type is of LE type */
+	if (!bdaddr_type_is_le(sa->iso_bdaddr_type))
+		return -EINVAL;
+
+	lock_sock(sk);
+
+	bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
+	iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
+
+	err = iso_connect(sk);
+	if (err)
+		goto done;
+
+	err = bt_sock_wait_state(sk, BT_CONNECTED,
+				 sock_sndtimeo(sk, flags & O_NONBLOCK));
+
+done:
+	release_sock(sk);
+	return err;
+}
+
+static int iso_sock_listen(struct socket *sock, int backlog)
+{
+	struct sock *sk = sock->sk;
+	bdaddr_t *src = &iso_pi(sk)->src;
+	int err = 0;
+
+	BT_DBG("sk %p backlog %d", sk, backlog);
+
+	lock_sock(sk);
+
+	if (sk->sk_state != BT_BOUND) {
+		err = -EBADFD;
+		goto done;
+	}
+
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	write_lock(&iso_sk_list.lock);
+
+	if (__iso_get_sock_listen_by_addr(src)) {
+		err = -EADDRINUSE;
+		goto unlock;
+	}
+
+	sk->sk_max_ack_backlog = backlog;
+	sk->sk_ack_backlog = 0;
+
+	sk->sk_state = BT_LISTEN;
+
+unlock:
+	write_unlock(&iso_sk_list.lock);
+
+done:
+	release_sock(sk);
+	return err;
+}
+
+static int iso_sock_accept(struct socket *sock, struct socket *newsock,
+			   int flags, bool kern)
+{
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	struct sock *sk = sock->sk, *ch;
+	long timeo;
+	int err = 0;
+
+	lock_sock(sk);
+
+	timeo = sock_rcvtimeo(sk, flags & O_NONBLOCK);
+
+	BT_DBG("sk %p timeo %ld", sk, timeo);
+
+	/* Wait for an incoming connection. (wake-one). */
+	add_wait_queue_exclusive(sk_sleep(sk), &wait);
+	while (1) {
+		if (sk->sk_state != BT_LISTEN) {
+			err = -EBADFD;
+			break;
+		}
+
+		ch = bt_accept_dequeue(sk, newsock);
+		if (ch)
+			break;
+
+		if (!timeo) {
+			err = -EAGAIN;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			err = sock_intr_errno(timeo);
+			break;
+		}
+
+		release_sock(sk);
+
+		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
+		lock_sock(sk);
+	}
+	remove_wait_queue(sk_sleep(sk), &wait);
+
+	if (err)
+		goto done;
+
+	newsock->state = SS_CONNECTED;
+
+	BT_DBG("new socket %p", ch);
+
+done:
+	release_sock(sk);
+	return err;
+}
+
+static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
+			    int peer)
+{
+	struct sockaddr_iso *sa = (struct sockaddr_iso *) addr;
+	struct sock *sk = sock->sk;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	addr->sa_family = AF_BLUETOOTH;
+
+	if (peer) {
+		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->dst);
+		sa->iso_bdaddr_type = iso_pi(sk)->dst_type;
+	} else {
+		bacpy(&sa->iso_bdaddr, &iso_pi(sk)->src);
+		sa->iso_bdaddr_type = iso_pi(sk)->src_type;
+	}
+
+	return sizeof(struct sockaddr_iso);
+}
+
+static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
+			    size_t len)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	err = sock_error(sk);
+	if (err)
+		return err;
+
+	if (msg->msg_flags & MSG_OOB)
+		return -EOPNOTSUPP;
+
+	lock_sock(sk);
+
+	if (sk->sk_state == BT_CONNECTED)
+		err = iso_send_frame(sk, msg, len);
+	else
+		err = -ENOTCONN;
+
+	release_sock(sk);
+	return err;
+}
+
+static void iso_conn_defer_accept(struct hci_conn *conn)
+{
+	struct hci_cp_le_accept_cis cp;
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("conn %p", conn);
+
+	conn->state = BT_CONFIG;
+
+	cp.handle = cpu_to_le16(conn->handle);
+
+	hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
+}
+
+static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
+			    size_t len, int flags)
+{
+	struct sock *sk = sock->sk;
+	struct iso_pinfo *pi = iso_pi(sk);
+
+	lock_sock(sk);
+
+	if (sk->sk_state == BT_CONNECT2 &&
+	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
+		iso_conn_defer_accept(pi->conn->hcon);
+		sk->sk_state = BT_CONFIG;
+
+		release_sock(sk);
+		return 0;
+	}
+
+	release_sock(sk);
+
+	return bt_sock_recvmsg(sock, msg, len, flags);
+}
+
+static bool check_qos(struct bt_iso_qos *qos)
+{
+	/* If no PHY is enable MTU must be 0 */
+	if (!qos->phy && qos->mtu)
+		return false;
+
+	if (qos->interval && (qos->interval < 0xff || qos->interval > 0xfffff))
+		return false;
+
+	if (qos->sca > 0x07)
+		return false;
+
+	if (qos->packing > 0x01)
+		return false;
+
+	if (qos->framing > 0x01)
+		return false;
+
+	if (qos->latency && (qos->latency < 0x05 || qos->latency > 0xfa0))
+		return false;
+
+	if (qos->phy > BT_ISO_PHY_ANY)
+		return false;
+
+	return true;
+}
+
+static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	int len, err = 0;
+	struct bt_iso_qos qos;
+	u32 opt;
+
+	BT_DBG("sk %p", sk);
+
+	lock_sock(sk);
+
+	switch (optname) {
+
+	case BT_DEFER_SETUP:
+		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt)
+			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		else
+			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+		break;
+
+	case BT_ISO_IN_QOS:
+		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
+		    sk->sk_state != BT_CONNECT2) {
+			err = -EINVAL;
+			break;
+		}
+
+		qos = iso_pi(sk)->in_qos;
+
+		len = min_t(unsigned int, sizeof(qos), optlen);
+		if (copy_from_user((char *)&qos, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (!check_qos(&qos)) {
+			err = -EINVAL;
+			break;
+		}
+
+		iso_pi(sk)->in_qos = qos;
+		break;
+
+	case BT_ISO_OUT_QOS:
+		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
+		    sk->sk_state != BT_CONNECT2) {
+			err = -EINVAL;
+			break;
+		}
+
+		qos = iso_pi(sk)->out_qos;
+
+		len = min_t(unsigned int, sizeof(qos), optlen);
+		if (copy_from_user((char *)&qos, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (!check_qos(&qos)) {
+			err = -EINVAL;
+			break;
+		}
+
+		iso_pi(sk)->out_qos = qos;
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
+static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = sock->sk;
+	int len, err = 0;
+	struct bt_iso_qos qos;
+
+	BT_DBG("sk %p", sk);
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	lock_sock(sk);
+
+	switch (optname) {
+
+	case BT_DEFER_SETUP:
+		if (sk->sk_state != BT_BOUND && sk->sk_state != BT_LISTEN) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags),
+			     (u32 __user *)optval))
+			err = -EFAULT;
+
+		break;
+
+	case BT_ISO_IN_QOS:
+		qos = iso_pi(sk)->in_qos;
+
+		len = min_t(unsigned int, len, sizeof(qos));
+		if (copy_to_user(optval, (char *)&qos, len))
+			err = -EFAULT;
+
+		break;
+
+	case BT_ISO_OUT_QOS:
+		qos = iso_pi(sk)->out_qos;
+
+		len = min_t(unsigned int, len, sizeof(qos));
+		if (copy_to_user(optval, (char *)&qos, len))
+			err = -EFAULT;
+
+		break;
+
+	default:
+		err = -ENOPROTOOPT;
+		break;
+	}
+
+	release_sock(sk);
+	return err;
+}
+
+static int iso_sock_shutdown(struct socket *sock, int how)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	if (!sk)
+		return 0;
+
+	sock_hold(sk);
+	lock_sock(sk);
+
+	if (!sk->sk_shutdown) {
+		sk->sk_shutdown = SHUTDOWN_MASK;
+		iso_sock_clear_timer(sk);
+		__iso_sock_close(sk);
+
+		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+		    !(current->flags & PF_EXITING))
+			err = bt_sock_wait_state(sk, BT_CLOSED,
+						 sk->sk_lingertime);
+	}
+
+	release_sock(sk);
+	sock_put(sk);
+
+	return err;
+}
+
+static int iso_sock_release(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	int err = 0;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	if (!sk)
+		return 0;
+
+	iso_sock_close(sk);
+
+	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	    !(current->flags & PF_EXITING)) {
+		lock_sock(sk);
+		err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
+		release_sock(sk);
+	}
+
+	sock_orphan(sk);
+	iso_sock_kill(sk);
+	return err;
+}
+
+static void iso_conn_ready(struct iso_conn *conn)
+{
+	struct sock *parent;
+	struct sock *sk = conn->sk;
+
+	BT_DBG("conn %p", conn);
+
+	if (sk) {
+		iso_sock_clear_timer(sk);
+		bh_lock_sock(sk);
+		sk->sk_state = BT_CONNECTED;
+		sk->sk_state_change(sk);
+		bh_unlock_sock(sk);
+	} else {
+		iso_conn_lock(conn);
+
+		if (!conn->hcon) {
+			iso_conn_unlock(conn);
+			return;
+		}
+
+		parent = iso_get_sock_listen(&conn->hcon->src);
+		if (!parent) {
+			iso_conn_unlock(conn);
+			return;
+		}
+
+		bh_lock_sock(parent);
+
+		sk = iso_sock_alloc(sock_net(parent), NULL,
+				    BTPROTO_ISO, GFP_ATOMIC, 0);
+		if (!sk) {
+			bh_unlock_sock(parent);
+			iso_conn_unlock(conn);
+			return;
+		}
+
+		iso_sock_init(sk, parent);
+
+		bacpy(&iso_pi(sk)->src, &conn->hcon->src);
+		iso_pi(sk)->src_type = conn->hcon->src_type;
+		bacpy(&iso_pi(sk)->dst, &conn->hcon->dst);
+		iso_pi(sk)->dst_type = conn->hcon->dst_type;
+
+		hci_conn_hold(conn->hcon);
+		__iso_chan_add(conn, sk, parent);
+
+		if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
+			sk->sk_state = BT_CONNECT2;
+		else
+			sk->sk_state = BT_CONNECTED;
+
+		/* Wake up parent */
+		parent->sk_data_ready(parent);
+
+		bh_unlock_sock(parent);
+
+		iso_conn_unlock(conn);
+	}
+}
+
+/* ----- ISO interface with lower layer (HCI) ----- */
+int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
+{
+	struct sock *sk;
+	int lm = 0;
+
+	BT_DBG("hdev %s, bdaddr %pMR", hdev->name, bdaddr);
+
+	/* Find listening sockets */
+	read_lock(&iso_sk_list.lock);
+	sk_for_each(sk, &iso_sk_list.head) {
+		if (sk->sk_state != BT_LISTEN)
+			continue;
+
+		if (!bacmp(&iso_pi(sk)->src, &hdev->bdaddr) ||
+		    !bacmp(&iso_pi(sk)->src, BDADDR_ANY)) {
+			lm |= HCI_LM_ACCEPT;
+
+			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
+				*flags |= HCI_PROTO_DEFER;
+			break;
+		}
+	}
+	read_unlock(&iso_sk_list.lock);
+
+	return lm;
+}
+
+static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
+{
+	if (hcon->type != ISO_LINK)
+		return;
+
+	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
+
+	if (!status) {
+		struct iso_conn *conn;
+
+		conn = iso_conn_add(hcon);
+		if (conn)
+			iso_conn_ready(conn);
+	} else
+		iso_conn_del(hcon, bt_to_errno(status));
+}
+
+static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
+{
+	if (hcon->type != ISO_LINK)
+		return;
+
+	BT_DBG("hcon %p reason %d", hcon, reason);
+
+	iso_conn_del(hcon, bt_to_errno(reason));
+}
+
+void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+{
+	struct iso_conn *conn = hcon->iso_data;
+	struct hci_iso_data_hdr *hdr;
+	__u16 pb, ts, len;
+
+	if (!conn)
+		goto drop;
+
+	pb     = hci_iso_flags_pb(flags);
+	ts     = hci_iso_flags_ts(flags);
+
+	BT_DBG("conn %p len %d pb 0x%x ts 0x%x", conn, skb->len, pb, ts);
+
+	switch (pb) {
+	case ISO_START:
+	case ISO_SINGLE:
+		if (conn->rx_len) {
+			BT_ERR("Unexpected start frame (len %d)", skb->len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+		}
+
+		/* Start fragment always begin with ISO data header */
+		if ((ts && skb->len < HCI_ISO_TS_DATA_HDR_SIZE) ||
+		    skb->len < HCI_ISO_DATA_HDR_SIZE) {
+			BT_ERR("Frame is too short (len %d)", skb->len);
+			goto drop;
+		}
+
+		if (ts) {
+			/* TODO: add timestamp to the packet? */
+			hdr = (void *) skb->data + 4;
+			skb_pull(skb, HCI_ISO_TS_DATA_HDR_SIZE);
+		} else {
+			hdr = (void *) skb->data;
+			skb_pull(skb, HCI_ISO_DATA_HDR_SIZE);
+		}
+
+		len    = __le16_to_cpu(hdr->slen);
+		flags  = hci_iso_data_flags(len);
+		len    = hci_iso_data_len(len);
+
+		BT_DBG("Start: total len %d, frag len %d flags 0x%4.4x", len,
+		       skb->len, flags);
+
+		if (len == skb->len) {
+			/* Complete frame received */
+			iso_recv_frame(conn, skb);
+			return;
+		}
+
+		if (pb == ISO_SINGLE) {
+			BT_ERR("Frame malformed (len %d, expected len %d)",
+			       skb->len, len);
+			goto drop;
+		}
+
+		if (skb->len > len) {
+			BT_ERR("Frame is too long (len %d, expected len %d)",
+			       skb->len, len);
+			goto drop;
+		}
+
+		/* Allocate skb for the complete frame (with header) */
+		conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);
+		if (!conn->rx_skb)
+			goto drop;
+
+		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
+					  skb->len);
+		conn->rx_len = len - skb->len;
+		break;
+
+	case ISO_CONT:
+		BT_DBG("Cont: frag len %d (expecting %d)", skb->len,
+		       conn->rx_len);
+
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected continuation frame (len %d)",
+			       skb->len);
+			goto drop;
+		}
+
+		if (skb->len > conn->rx_len) {
+			BT_ERR("Fragment is too long (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
+		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
+					  skb->len);
+		conn->rx_len -= skb->len;
+		return;
+
+	case ISO_END:
+		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
+					  skb->len);
+		conn->rx_len -= skb->len;
+
+		if (!conn->rx_len) {
+			/* Complete frame received. iso_recv_frame
+			 * takes ownership of the skb so set the global
+			 * rx_skb pointer to NULL first.
+			 */
+			struct sk_buff *rx_skb = conn->rx_skb;
+			conn->rx_skb = NULL;
+			iso_recv_frame(conn, rx_skb);
+		}
+		break;
+	}
+
+drop:
+	kfree_skb(skb);
+}
+
+static struct hci_cb iso_cb = {
+	.name		= "ISO",
+	.connect_cfm	= iso_connect_cfm,
+	.disconn_cfm	= iso_disconn_cfm,
+};
+
+static int iso_debugfs_show(struct seq_file *f, void *p)
+{
+	struct sock *sk;
+
+	read_lock(&iso_sk_list.lock);
+
+	sk_for_each(sk, &iso_sk_list.head) {
+		seq_printf(f, "%pMR %pMR %d\n", &iso_pi(sk)->src,
+			   &iso_pi(sk)->dst, sk->sk_state);
+	}
+
+	read_unlock(&iso_sk_list.lock);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(iso_debugfs);
+
+static struct dentry *iso_debugfs;
+
+static const struct proto_ops iso_sock_ops = {
+	.family		= PF_BLUETOOTH,
+	.owner		= THIS_MODULE,
+	.release	= iso_sock_release,
+	.bind		= iso_sock_bind,
+	.connect	= iso_sock_connect,
+	.listen		= iso_sock_listen,
+	.accept		= iso_sock_accept,
+	.getname	= iso_sock_getname,
+	.sendmsg	= iso_sock_sendmsg,
+	.recvmsg	= iso_sock_recvmsg,
+	.poll		= bt_sock_poll,
+	.ioctl		= bt_sock_ioctl,
+	.mmap		= sock_no_mmap,
+	.socketpair	= sock_no_socketpair,
+	.shutdown	= iso_sock_shutdown,
+	.setsockopt	= iso_sock_setsockopt,
+	.getsockopt	= iso_sock_getsockopt
+};
+
+static const struct net_proto_family iso_sock_family_ops = {
+	.family	= PF_BLUETOOTH,
+	.owner	= THIS_MODULE,
+	.create	= iso_sock_create,
+};
+
+int __init iso_init(void)
+{
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct sockaddr_iso) > sizeof(struct sockaddr));
+
+	err = proto_register(&iso_proto, 0);
+	if (err < 0)
+		return err;
+
+	err = bt_sock_register(BTPROTO_ISO, &iso_sock_family_ops);
+	if (err < 0) {
+		BT_ERR("ISO socket registration failed");
+		goto error;
+	}
+
+	err = bt_procfs_init(&init_net, "iso", &iso_sk_list, NULL);
+	if (err < 0) {
+		BT_ERR("Failed to create ISO proc file");
+		bt_sock_unregister(BTPROTO_ISO);
+		goto error;
+	}
+
+	BT_INFO("ISO socket layer initialized");
+
+	hci_register_cb(&iso_cb);
+
+	if (IS_ERR_OR_NULL(bt_debugfs))
+		return 0;
+
+	iso_debugfs = debugfs_create_file("iso", 0444, bt_debugfs,
+					  NULL, &iso_debugfs_fops);
+
+	return 0;
+
+error:
+	proto_unregister(&iso_proto);
+	return err;
+}
+
+void iso_exit(void)
+{
+	bt_procfs_cleanup(&init_net, "iso");
+
+	debugfs_remove(iso_debugfs);
+
+	hci_unregister_cb(&iso_cb);
+
+	bt_sock_unregister(BTPROTO_ISO);
+
+	proto_unregister(&iso_proto);
+}
-- 
2.21.0

