Return-Path: <SRS0=lPNB=Z3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81346C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 18:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398F124651
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 18:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EdqTF+Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfLESUe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:20:34 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33282 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 13:20:33 -0500
Received: by mail-vs1-f65.google.com with SMTP id n27so3112365vsa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2019 10:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/HWcOQxTKi4/pJT4KTLLBintlrMTLXGb3Jh9uDHTJTo=;
        b=EdqTF+EqW/C/oq36MtGcRl6j8N03/l2wEmR9gxBg8IlsUIEEk1l0Dqqgl6r1Ljad6V
         Jjh/nzN1fTyhFMLIptYxHGAsvy7vf2sDVxhzHlWbyAhVIY7lNApIIwMnym6BGL9MOwYR
         EOY/xkZaF/vmCs1qA1kMdEFvC4NJmcbd4odm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/HWcOQxTKi4/pJT4KTLLBintlrMTLXGb3Jh9uDHTJTo=;
        b=ZlBzfWrTKsvHEG8RWNY7Ka3k8n47RzNrWV8vdbQQ76yv/uqu41+WwKtr1e75/f8+st
         evc4u3wBEi+4QQCrey4RjEsr59oKtRDvv2kIwYXDbKh+FHcbGtXiQf8O+DzNcv95zgG/
         poV3BUWyI5C4+KN8nId/TiGRIe0Y5qN2R6CdGXEa0LVewG6jf6uRix5T5mJJF1nbKPX4
         tihdc0Z8CLLCfdbDiiZm4H3nIX6kcO0ilkR2MFhxv6qhlz2wqvpfwrsrRsFgyla5eFI+
         1qJ0TIGntMNqqU+lIJXLQjoCEXqQiHpPAgQoRNhG6rNrN4SHXTP78WSw/nLjrknF2WLU
         8bLA==
X-Gm-Message-State: APjAAAV1ryfbE/lJ9DXJxef0cebu/qM+9ERUPSKf7wGT+IEcLrm7tMs7
        26FyaXag1bvzAWaqTT4m0+n5mh0KKGc=
X-Google-Smtp-Source: APXvYqwj/p2Wwv4jvD4DRjFNm0LgF9FvGLhYXraFZhKG5oDYSUFwFLiCKAzrxgd0qxlRAVG8qaomSA==
X-Received: by 2002:a67:f348:: with SMTP id p8mr6367581vsm.226.1575570030045;
        Thu, 05 Dec 2019 10:20:30 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id e22sm3972107vsh.19.2019.12.05.10.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 10:20:29 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] Fixing checkpatch noise.  No functional changes.
Date:   Thu,  5 Dec 2019 18:20:09 +0000
Message-Id: <20191205182009.154769-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 include/net/bluetooth/hci_core.h | 31 +++++++------
 include/net/bluetooth/mgmt.h     |  6 +--
 net/bluetooth/hci_core.c         | 45 +++++++++---------
 net/bluetooth/mgmt.c             | 49 ++++++++++++--------
 net/bluetooth/smp.c              | 78 ++++++++++++++++----------------
 5 files changed, 114 insertions(+), 95 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb636b..6e460c47bb1e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -181,7 +181,7 @@ struct adv_info {
 	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__s8	tx_power;
 	bdaddr_t	random_addr;
-	bool 		rpa_expired;
+	bool		rpa_expired;
 	struct delayed_work	rpa_expired_cb;
 };
 
@@ -528,9 +528,9 @@ struct hci_conn {
 
 	struct hci_conn	*link;
 
-	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
-	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
-	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
+	void (*connect_cfm_cb)(struct hci_conn *conn, u8 status);
+	void (*security_cfm_cb)(struct hci_conn *conn, u8 status);
+	void (*disconn_cfm_cb)(struct hci_conn *conn, u8 reason);
 };
 
 struct hci_chan {
@@ -645,6 +645,7 @@ static inline int inquiry_cache_empty(struct hci_dev *hdev)
 static inline long inquiry_cache_age(struct hci_dev *hdev)
 {
 	struct discovery_state *c = &hdev->discovery;
+
 	return jiffies - c->timestamp;
 }
 
@@ -696,6 +697,7 @@ enum {
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
+
 	return hci_dev_test_flag(hdev, HCI_SSP_ENABLED) &&
 	       test_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
 }
@@ -703,6 +705,7 @@ static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
 static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
+
 	return hci_dev_test_flag(hdev, HCI_SC_ENABLED) &&
 	       test_bit(HCI_CONN_SC_ENABLED, &conn->flags);
 }
@@ -710,6 +713,7 @@ static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
+
 	list_add_rcu(&c->list, &h->list);
 	switch (c->type) {
 	case ACL_LINK:
@@ -759,6 +763,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
+
 	switch (type) {
 	case ACL_LINK:
 		return h->acl_num;
@@ -851,7 +856,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 
 	list_for_each_entry_rcu(c, &h->list, list) {
 		if (c->type != LE_LINK)
-		       continue;
+		continue;
 
 		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
 			rcu_read_unlock();
@@ -1249,12 +1254,12 @@ struct hci_cb {
 
 	char *name;
 
-	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
-	void (*disconn_cfm)	(struct hci_conn *conn, __u8 status);
-	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
+	void (*connect_cfm)(struct hci_conn *conn, __u8 status);
+	void (*disconn_cfm)(struct hci_conn *conn, __u8 status);
+	void (*security_cfm)(struct hci_conn *conn, __u8 status,
 								__u8 encrypt);
-	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
-	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
+	void (*key_change_cfm)(struct hci_conn *conn, __u8 status);
+	void (*role_switch_cfm)(struct hci_conn *conn, __u8 status, __u8 role);
 };
 
 static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
@@ -1398,7 +1403,7 @@ static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
 		return false;
 
 	if ((bdaddr->b[5] & 0xc0) == 0x40)
-	       return true;
+	return true;
 
 	return false;
 }
@@ -1482,7 +1487,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define HCI_MGMT_UNCONFIGURED	BIT(3)
 
 struct hci_mgmt_handler {
-	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
+	int (*func)(struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
 	size_t data_len;
 	unsigned long flags;
@@ -1493,7 +1498,7 @@ struct hci_mgmt_chan {
 	unsigned short channel;
 	size_t handler_count;
 	const struct hci_mgmt_handler *handlers;
-	void (*hdev_init) (struct sock *sk, struct hci_dev *hdev);
+	void (*hdev_init)(struct sock *sk, struct hci_dev *hdev);
 };
 
 int hci_mgmt_chan_register(struct hci_mgmt_chan *c);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9cee7ddc6741..41068875385f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -562,9 +562,9 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_FLAG_TX_POWER		BIT(4)
 #define MGMT_ADV_FLAG_APPEARANCE	BIT(5)
 #define MGMT_ADV_FLAG_LOCAL_NAME	BIT(6)
-#define MGMT_ADV_FLAG_SEC_1M 		BIT(7)
-#define MGMT_ADV_FLAG_SEC_2M 		BIT(8)
-#define MGMT_ADV_FLAG_SEC_CODED 	BIT(9)
+#define MGMT_ADV_FLAG_SEC_1M		BIT(7)
+#define MGMT_ADV_FLAG_SEC_2M		BIT(8)
+#define MGMT_ADV_FLAG_SEC_CODED	BIT(9)
 
 #define MGMT_ADV_FLAG_SEC_MASK	(MGMT_ADV_FLAG_SEC_1M | MGMT_ADV_FLAG_SEC_2M | \
 				 MGMT_ADV_FLAG_SEC_CODED)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9e19d5a3aac8..1886ebbc97d6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -489,6 +489,7 @@ static int hci_init2_req(struct hci_request *req, unsigned long opt)
 
 	if (hci_dev_test_flag(hdev, HCI_LINK_SECURITY)) {
 		u8 enable = 1;
+
 		hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, sizeof(enable),
 			    &enable);
 	}
@@ -1216,7 +1217,7 @@ u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 {
 	struct discovery_state *cache = &hdev->discovery;
-	struct inquiry_info *info = (struct inquiry_info *) buf;
+	struct inquiry_info *info = (struct inquiry_info *)buf;
 	struct inquiry_entry *e;
 	int copied = 0;
 
@@ -1243,7 +1244,7 @@ static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 
 static int hci_inq_req(struct hci_request *req, unsigned long opt)
 {
-	struct hci_inquiry_req *ir = (struct hci_inquiry_req *) opt;
+	struct hci_inquiry_req *ir = (struct hci_inquiry_req *)opt;
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_inquiry cp;
 
@@ -1308,7 +1309,7 @@ int hci_inquiry(void __user *arg)
 	timeo = ir.length * msecs_to_jiffies(2000);
 
 	if (do_inquiry) {
-		err = hci_req_sync(hdev, hci_inq_req, (unsigned long) &ir,
+		err = hci_req_sync(hdev, hci_inq_req, (unsigned long)&ir,
 				   timeo, NULL);
 		if (err < 0)
 			goto done;
@@ -1406,7 +1407,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		}
 
 		/* Check for valid public address or a configured static
-		 * random adddress, but let the HCI setup proceed to
+		 * random address, but let the HCI setup proceed to
 		 * be able to determine if there is a public address
 		 * or not.
 		 *
@@ -2010,26 +2011,26 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		break;
 
 	case HCISETLINKMODE:
-		hdev->link_mode = ((__u16) dr.dev_opt) &
+		hdev->link_mode = ((__u16)dr.dev_opt) &
 					(HCI_LM_MASTER | HCI_LM_ACCEPT);
 		break;
 
 	case HCISETPTYPE:
-		if (hdev->pkt_type == (__u16) dr.dev_opt)
+		if (hdev->pkt_type == (__u16)dr.dev_opt)
 			break;
 
-		hdev->pkt_type = (__u16) dr.dev_opt;
+		hdev->pkt_type = (__u16)dr.dev_opt;
 		mgmt_phy_configuration_changed(hdev, NULL);
 		break;
 
 	case HCISETACLMTU:
-		hdev->acl_mtu  = *((__u16 *) &dr.dev_opt + 1);
-		hdev->acl_pkts = *((__u16 *) &dr.dev_opt + 0);
+		hdev->acl_mtu  = *((__u16 *)&dr.dev_opt + 1);
+		hdev->acl_pkts = *((__u16 *)&dr.dev_opt + 0);
 		break;
 
 	case HCISETSCOMTU:
-		hdev->sco_mtu  = *((__u16 *) &dr.dev_opt + 1);
-		hdev->sco_pkts = *((__u16 *) &dr.dev_opt + 0);
+		hdev->sco_mtu  = *((__u16 *)&dr.dev_opt + 1);
+		hdev->sco_pkts = *((__u16 *)&dr.dev_opt + 0);
 		break;
 
 	default:
@@ -2050,7 +2051,7 @@ int hci_get_dev_list(void __user *arg)
 	int n = 0, size, err;
 	__u16 dev_num;
 
-	if (get_user(dev_num, (__u16 __user *) arg))
+	if (get_user(dev_num, (__u16 __user *)arg))
 		return -EFAULT;
 
 	if (!dev_num || dev_num > (PAGE_SIZE * 2) / sizeof(*dr))
@@ -2633,7 +2634,7 @@ static void hci_cmd_timeout(struct work_struct *work)
 					    cmd_timer.work);
 
 	if (hdev->sent_cmd) {
-		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
+		struct hci_command_hdr *sent = (void *)hdev->sent_cmd->data;
 		u16 opcode = __le16_to_cpu(sent->opcode);
 
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
@@ -2893,7 +2894,7 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 }
 
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
-					 bdaddr_t *bdaddr, u8 type)
+					   bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *b;
 
@@ -2952,7 +2953,7 @@ int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 }
 
 int hci_bdaddr_list_add_with_irk(struct list_head *list, bdaddr_t *bdaddr,
-					u8 type, u8 *peer_irk, u8 *local_irk)
+				 u8 type, u8 *peer_irk, u8 *local_irk)
 {
 	struct bdaddr_list_with_irk *entry;
 
@@ -3000,7 +3001,7 @@ int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 }
 
 int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
-							u8 type)
+				 u8 type)
 {
 	struct bdaddr_list_with_irk *entry;
 
@@ -3675,7 +3676,7 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 	if (!hdev->sent_cmd)
 		return NULL;
 
-	hdr = (void *) hdev->sent_cmd->data;
+	hdr = (void *)hdev->sent_cmd->data;
 
 	if (hdr->opcode != cpu_to_le16(opcode))
 		return NULL;
@@ -4024,7 +4025,6 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 	}
 
 	rcu_read_unlock();
-
 }
 
 static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
@@ -4056,6 +4056,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 	while (hdev->acl_cnt &&
 	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
+
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
 			       skb->len, skb->priority);
@@ -4102,6 +4103,7 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 	while (hdev->block_cnt > 0 &&
 	       (chan = hci_chan_sent(hdev, type, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
+
 		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
 			int blocks;
 
@@ -4230,6 +4232,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 	tmp = cnt;
 	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
+
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
 			       skb->len, skb->priority);
@@ -4284,7 +4287,7 @@ static void hci_tx_work(struct work_struct *work)
 /* ACL data packet */
 static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_acl_hdr *hdr = (void *) skb->data;
+	struct hci_acl_hdr *hdr = (void *)skb->data;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
@@ -4320,7 +4323,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_sco_hdr *hdr = (void *) skb->data;
+	struct hci_sco_hdr *hdr = (void *)skb->data;
 	struct hci_conn *conn;
 	__u16 handle;
 
@@ -4368,7 +4371,7 @@ static void hci_resend_last(struct hci_dev *hdev)
 	if (!hdev->sent_cmd)
 		return;
 
-	sent = (void *) hdev->sent_cmd->data;
+	sent = (void *)hdev->sent_cmd->data;
 	opcode = __le16_to_cpu(sent->opcode);
 	if (opcode == HCI_OP_RESET)
 		return;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index acb7c6d5643f..5fcd3c450070 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -870,6 +870,7 @@ u8 mgmt_get_adv_discov_flags(struct hci_dev *hdev)
 	cmd = pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
 	if (cmd) {
 		struct mgmt_mode *cp = cmd->param;
+
 		if (cp->val == 0x01)
 			return LE_AD_GENERAL;
 		else if (cp->val == 0x02)
@@ -1038,7 +1039,6 @@ static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
 	rp->supported_settings = cpu_to_le32(get_supported_settings(hdev));
 	rp->current_settings = cpu_to_le32(get_current_settings(hdev));
 
-
 	eir_len = append_eir_data_to_buf(hdev, rp->eir);
 	rp->eir_len = cpu_to_le16(eir_len);
 
@@ -1130,6 +1130,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 	if (test_bit(HCI_ISCAN, &hdev->flags) ||
 	    test_bit(HCI_PSCAN, &hdev->flags)) {
 		u8 scan = 0x00;
+
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
@@ -1234,7 +1235,7 @@ static void settings_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 	list_del(&cmd->list);
 
-	if (match->sk == NULL) {
+	if (!match->sk) {
 		match->sk = cmd->sk;
 		sock_hold(match->sk);
 	}
@@ -1310,6 +1311,7 @@ void mgmt_set_discoverable_complete(struct hci_dev *hdev, u8 status)
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
+
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
 		hci_dev_clear_flag(hdev, HCI_LIMITED_DISCOVERABLE);
 		goto remove_cmd;
@@ -1318,6 +1320,7 @@ void mgmt_set_discoverable_complete(struct hci_dev *hdev, u8 status)
 	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE) &&
 	    hdev->discov_timeout > 0) {
 		int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
+
 		queue_delayed_work(hdev->req_workqueue, &hdev->discov_off, to);
 	}
 
@@ -1415,6 +1418,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (cp->val && hdev->discov_timeout > 0) {
 			int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
+
 			queue_delayed_work(hdev->req_workqueue,
 					   &hdev->discov_off, to);
 		}
@@ -1469,6 +1473,7 @@ void mgmt_set_connectable_complete(struct hci_dev *hdev, u8 status)
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
+
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
 		goto remove_cmd;
 	}
@@ -1847,6 +1852,7 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		struct hci_request req;
+
 		hci_req_init(&req, hdev);
 		if (ext_adv_capable(hdev)) {
 			int err;
@@ -2448,7 +2454,6 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto done;
 	}
 
-
 	/* Defer clearing up the connection parameters until closing to
 	 * give a chance of keeping them if a repairing happens.
 	 */
@@ -3193,7 +3198,7 @@ static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
-			        mgmt_status(status));
+				mgmt_status(status));
 	} else {
 		mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, 0,
 				  cp, sizeof(*cp));
@@ -3264,7 +3269,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	/* The name is stored in the scan response data and so
-	 * no need to udpate the advertising data here.
+	 * no need to update the advertising data here.
 	 */
 	if (lmp_le_capable(hdev) && hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		__hci_req_update_scan_rsp_data(&req, hdev->cur_adv_instance);
@@ -3532,7 +3537,7 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 }
 
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
-				         u16 opcode, struct sk_buff *skb)
+					 u16 opcode, struct sk_buff *skb)
 {
 	struct mgmt_rp_read_local_oob_data mgmt_rp;
 	size_t rp_size = sizeof(mgmt_rp);
@@ -3553,7 +3558,7 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 	memset(&mgmt_rp, 0, sizeof(mgmt_rp));
 
 	if (opcode == HCI_OP_READ_LOCAL_OOB_DATA) {
-		struct hci_rp_read_local_oob_data *rp = (void *) skb->data;
+		struct hci_rp_read_local_oob_data *rp = (void *)skb->data;
 
 		if (skb->len < sizeof(*rp)) {
 			mgmt_cmd_status(cmd->sk, hdev->id,
@@ -3567,7 +3572,7 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 
 		rp_size -= sizeof(mgmt_rp.hash256) + sizeof(mgmt_rp.rand256);
 	} else {
-		struct hci_rp_read_local_oob_ext_data *rp = (void *) skb->data;
+		struct hci_rp_read_local_oob_ext_data *rp = (void *)skb->data;
 
 		if (skb->len < sizeof(*rp)) {
 			mgmt_cmd_status(cmd->sk, hdev->id,
@@ -4521,7 +4526,7 @@ static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
 
 	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-			        mgmt_status(status));
+				mgmt_status(status));
 	} else {
 		struct mgmt_mode *cp = cmd->param;
 
@@ -4764,7 +4769,7 @@ static void sc_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	if (status) {
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
-			        mgmt_status(status));
+				mgmt_status(status));
 		goto remove;
 	}
 
@@ -4913,6 +4918,7 @@ static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
 	if (hdev_is_powered(hdev) && use_changed &&
 	    hci_dev_test_flag(hdev, HCI_SSP_ENABLED)) {
 		u8 mode = (cp->val == 0x02) ? 0x01 : 0x00;
+
 		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_DEBUG_MODE,
 			     sizeof(mode), &mode);
 	}
@@ -5165,7 +5171,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS, 0,
-			   NULL, 0);
+				NULL, 0);
 
 	hci_dev_unlock(hdev);
 
@@ -5426,6 +5432,7 @@ static void get_clock_info_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	if (hci_cp->which) {
 		u16 handle = __le16_to_cpu(hci_cp->handle);
+
 		conn = hci_conn_hash_lookup_handle(hdev, handle);
 	} else {
 		conn = NULL;
@@ -5443,7 +5450,7 @@ static void get_clock_info_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 }
 
 static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
-			 u16 len)
+			  u16 len)
 {
 	struct mgmt_cp_get_clock_info *cp = data;
 	struct mgmt_rp_get_clock_info rp;
@@ -5920,7 +5927,7 @@ static int set_external_config(struct sock *sk, struct hci_dev *hdev,
 
 	if (cp->config != 0x00 && cp->config != 0x01)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
-				         MGMT_STATUS_INVALID_PARAMS);
+					 MGMT_STATUS_INVALID_PARAMS);
 
 	if (!test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_EXTERNAL_CONFIG,
@@ -6242,7 +6249,7 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
-		   !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+		    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
 		   (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
 		    bacmp(&hdev->static_addr, BDADDR_ANY))) {
 			memcpy(addr, &hdev->static_addr, 6);
@@ -6909,7 +6916,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ remove_advertising,	   MGMT_REMOVE_ADVERTISING_SIZE },
 	{ get_adv_size_info,       MGMT_GET_ADV_SIZE_INFO_SIZE },
 	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
-	{ read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
+	{ read_ext_controller_info, MGMT_READ_EXT_INFO_SIZE,
 						HCI_MGMT_UNTRUSTED },
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
@@ -7234,7 +7241,7 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 			   u32 flags, u8 *name, u8 name_len)
 {
 	char buf[512];
-	struct mgmt_ev_device_connected *ev = (void *) buf;
+	struct mgmt_ev_device_connected *ev = (void *)buf;
 	u16 eir_len = 0;
 
 	bacpy(&ev->addr.bdaddr, &conn->dst);
@@ -7264,7 +7271,7 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	ev->eir_len = cpu_to_le16(eir_len);
 
 	mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, buf,
-		    sizeof(*ev) + eir_len, NULL);
+		   sizeof(*ev) + eir_len, NULL);
 }
 
 static void disconnect_rsp(struct mgmt_pending_cmd *cmd, void *data)
@@ -7531,7 +7538,7 @@ void mgmt_auth_failed(struct hci_conn *conn, u8 hci_status)
 	cmd = find_pairing(conn);
 
 	mgmt_event(MGMT_EV_AUTH_FAILED, conn->hdev, &ev, sizeof(ev),
-		    cmd ? cmd->sk : NULL);
+		   cmd ? cmd->sk : NULL);
 
 	if (cmd) {
 		cmd->cmd_complete(cmd, status);
@@ -7546,6 +7553,7 @@ void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
+
 		mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev,
 				     cmd_status_rsp, &mgmt_err);
 		return;
@@ -7638,7 +7646,7 @@ static void sk_lookup(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
 
-	if (match->sk == NULL) {
+	if (!match->sk) {
 		match->sk = cmd->sk;
 		sock_hold(match->sk);
 	}
@@ -7851,6 +7859,7 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 				return;
 		} else {
 			u8 *flags = eir_get_data(eir, eir_len, EIR_FLAGS, NULL);
+
 			if (!flags || !(flags[0] & LE_AD_LIMITED))
 				return;
 		}
@@ -7907,7 +7916,7 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	char buf[sizeof(*ev) + HCI_MAX_NAME_LENGTH + 2];
 	u16 eir_len;
 
-	ev = (struct mgmt_ev_device_found *) buf;
+	ev = (struct mgmt_ev_device_found *)buf;
 
 	memset(buf, 0, sizeof(buf));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6b42be4b5861..dd7164cd138c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -169,7 +169,7 @@ static inline void swap_buf(const u8 *src, u8 *dst, size_t len)
 static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
 		    size_t len, u8 mac[16])
 {
-	uint8_t tmp[16], mac_msb[16], msg_msb[CMAC_MSG_MAX];
+	u8 tmp[16], mac_msb[16], msg_msb[CMAC_MSG_MAX];
 	SHASH_DESC_ON_STACK(desc, tfm);
 	int err;
 
@@ -187,7 +187,7 @@ static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
 	swap_buf(k, tmp, 16);
 	swap_buf(m, msg_msb, len);
 
-	SMP_DBG("msg (len %zu) %*phN", len, (int) len, m);
+	SMP_DBG("msg (len %zu) %*phN", len, (int)len, m);
 	SMP_DBG("key %16phN", k);
 
 	err = crypto_shash_setkey(tfm, tmp, 16);
@@ -379,7 +379,7 @@ static int smp_h7(struct crypto_shash *tfm_cmac, const u8 w[16],
 static int smp_e(const u8 *k, u8 *r)
 {
 	struct crypto_aes_ctx ctx;
-	uint8_t tmp[16], data[16];
+	u8 tmp[16], data[16];
 	int err;
 
 	SMP_DBG("k %16phN r %16phN", k, r);
@@ -403,7 +403,7 @@ static int smp_e(const u8 *k, u8 *r)
 
 	SMP_DBG("r %16phN", r);
 
-	memzero_explicit(&ctx, sizeof (ctx));
+	memzero_explicit(&ctx, sizeof(ctx));
 	return err;
 }
 
@@ -446,7 +446,7 @@ static int smp_c1(const u8 k[16],
 	SMP_DBG("p2 %16phN", p2);
 
 	/* res = res XOR p2 */
-	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
+	u128_xor((u128 *)res, (u128 *) res, (u128 *) p2);
 
 	/* res = e(k, res) */
 	err = smp_e(k, res);
@@ -702,7 +702,7 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 		authreq &= ~SMP_AUTH_SC;
 	}
 
-	if (rsp == NULL) {
+	if (!rsp) {
 		req->io_capability = conn->hcon->io_capability;
 		req->oob_flag = oob_flag;
 		req->max_key_size = hdev->le_max_key_size;
@@ -848,7 +848,7 @@ static u8 get_auth_method(struct smp_chan *smp, u8 local_io, u8 remote_io)
 }
 
 static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
-						u8 local_io, u8 remote_io)
+		      u8 local_io, u8 remote_io)
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan = conn->smp;
@@ -931,7 +931,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 						passkey, 1);
 	else
 		ret = mgmt_user_passkey_notify(hcon->hdev, &hcon->dst,
-						hcon->type, hcon->dst_type,
+					       hcon->type, hcon->dst_type,
 						passkey, 0);
 
 	return ret;
@@ -980,8 +980,7 @@ static u8 smp_random(struct smp_chan *smp)
 		return SMP_UNSPECIFIED;
 
 	if (crypto_memneq(smp->pcnf, confirm, sizeof(smp->pcnf))) {
-		bt_dev_err(hcon->hdev, "pairing failed "
-			   "(confirmation values mismatch)");
+		bt_dev_err(hcon->hdev, "pairing failed (confirmation values mismatch)");
 		return SMP_CONFIRM_FAILED;
 	}
 
@@ -1030,8 +1029,8 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
-	struct smp_cmd_pairing *req = (void *) &smp->preq[1];
-	struct smp_cmd_pairing *rsp = (void *) &smp->prsp[1];
+	struct smp_cmd_pairing *req = (void *)&smp->preq[1];
+	struct smp_cmd_pairing *rsp = (void *)&smp->prsp[1];
 	bool persistent;
 
 	if (hcon->type == ACL_LINK) {
@@ -1232,7 +1231,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 
 	BT_DBG("conn %p", conn);
 
-	rsp = (void *) &smp->prsp[1];
+	rsp = (void *)&smp->prsp[1];
 
 	/* The responder sends its keys first */
 	if (hcon->out && (smp->remote_key_dist & KEY_DIST_MASK)) {
@@ -1240,7 +1239,7 @@ static void smp_distribute_keys(struct smp_chan *smp)
 		return;
 	}
 
-	req = (void *) &smp->preq[1];
+	req = (void *)&smp->preq[1];
 
 	if (hcon->out) {
 		keydist = &rsp->init_key_dist;
@@ -1667,6 +1666,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	/* If it is our turn to send Pairing Confirm, do so now */
 	if (test_bit(SMP_FLAG_CFM_PENDING, &smp->flags)) {
 		u8 rsp = smp_confirm(smp);
+
 		if (rsp)
 			smp_failure(conn, rsp);
 	}
@@ -1720,7 +1720,7 @@ static void build_bredr_pairing_cmd(struct smp_chan *smp,
 
 static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
+	struct smp_cmd_pairing rsp, *req = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct smp_chan *smp;
@@ -1911,7 +1911,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 
 static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_pairing *req, *rsp = (void *) skb->data;
+	struct smp_cmd_pairing *req, *rsp = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_dev *hdev = conn->hcon->hdev;
@@ -1928,7 +1928,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rsp));
 
-	req = (void *) &smp->preq[1];
+	req = (void *)&smp->preq[1];
 
 	key_size = min(req->max_key_size, rsp->max_key_size);
 	if (check_enc_key_size(conn, key_size))
@@ -2050,8 +2050,8 @@ static int fixup_sc_false_positive(struct smp_chan *smp)
 
 	bt_dev_err(hdev, "trying to fall back to legacy SMP");
 
-	req = (void *) &smp->preq[1];
-	rsp = (void *) &smp->prsp[1];
+	req = (void *)&smp->preq[1];
+	rsp = (void *)&smp->prsp[1];
 
 	/* Rebuild key dist flags which may have been cleared for SC */
 	smp->remote_key_dist = (req->init_key_dist & rsp->resp_key_dist);
@@ -2247,7 +2247,7 @@ bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_security_req *rp = (void *) skb->data;
+	struct smp_cmd_security_req *rp = (void *)skb->data;
 	struct smp_cmd_pairing cp;
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
@@ -2382,6 +2382,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_RSP);
 	} else {
 		struct smp_cmd_security_req cp;
+
 		cp.auth_req = authreq;
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_REQ);
@@ -2444,7 +2445,7 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_encrypt_info *rp = (void *) skb->data;
+	struct smp_cmd_encrypt_info *rp = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 
@@ -2464,7 +2465,7 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_master_ident *rp = (void *) skb->data;
+	struct smp_cmd_master_ident *rp = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_dev *hdev = conn->hcon->hdev;
@@ -2500,7 +2501,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_ident_info *info = (void *) skb->data;
+	struct smp_cmd_ident_info *info = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 
@@ -2521,7 +2522,7 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 				   struct sk_buff *skb)
 {
-	struct smp_cmd_ident_addr_info *info = (void *) skb->data;
+	struct smp_cmd_ident_addr_info *info = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
@@ -2589,7 +2590,7 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 
 static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_sign_info *rp = (void *) skb->data;
+	struct smp_cmd_sign_info *rp = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
 	struct smp_csrk *csrk;
@@ -2635,11 +2636,11 @@ static u8 sc_select_method(struct smp_chan *smp)
 	 * first byte which contains the opcode.
 	 */
 	if (hcon->out) {
-		local = (void *) &smp->preq[1];
-		remote = (void *) &smp->prsp[1];
+		local = (void *)&smp->preq[1];
+		remote = (void *)&smp->prsp[1];
 	} else {
-		local = (void *) &smp->prsp[1];
-		remote = (void *) &smp->preq[1];
+		local = (void *)&smp->prsp[1];
+		remote = (void *)&smp->preq[1];
 	}
 
 	local_io = local->io_capability;
@@ -2665,7 +2666,7 @@ static u8 sc_select_method(struct smp_chan *smp)
 
 static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_public_key *key = (void *) skb->data;
+	struct smp_cmd_public_key *key = (void *)skb->data;
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan = conn->smp;
 	struct smp_chan *smp = chan->data;
@@ -2796,7 +2797,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_dhkey_check *check = (void *) skb->data;
+	struct smp_cmd_dhkey_check *check = (void *)skb->data;
 	struct l2cap_chan *chan = conn->smp;
 	struct hci_conn *hcon = conn->hcon;
 	struct smp_chan *smp = chan->data;
@@ -2862,7 +2863,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
 				   struct sk_buff *skb)
 {
-	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
+	struct smp_cmd_keypress_notify *kp = (void *)skb->data;
 
 	BT_DBG("value 0x%02x", kp->value);
 
@@ -3306,7 +3307,7 @@ static ssize_t force_bredr_smp_read(struct file *file,
 	struct hci_dev *hdev = file->private_data;
 	char buf[3];
 
-	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y': 'N';
+	buf[0] = hci_dev_test_flag(hdev, HCI_FORCE_BREDR_SMP) ? 'Y' : 'N';
 	buf[1] = '\n';
 	buf[2] = '\0';
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
@@ -3356,7 +3357,7 @@ static const struct file_operations force_bredr_smp_fops = {
 };
 
 static ssize_t le_min_key_size_read(struct file *file,
-				     char __user *user_buf,
+				    char __user *user_buf,
 				     size_t count, loff_t *ppos)
 {
 	struct hci_dev *hdev = file->private_data;
@@ -3368,7 +3369,7 @@ static ssize_t le_min_key_size_read(struct file *file,
 }
 
 static ssize_t le_min_key_size_write(struct file *file,
-				      const char __user *user_buf,
+				     const char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
 	struct hci_dev *hdev = file->private_data;
@@ -3400,7 +3401,7 @@ static const struct file_operations le_min_key_size_fops = {
 };
 
 static ssize_t le_max_key_size_read(struct file *file,
-				     char __user *user_buf,
+				    char __user *user_buf,
 				     size_t count, loff_t *ppos)
 {
 	struct hci_dev *hdev = file->private_data;
@@ -3412,7 +3413,7 @@ static ssize_t le_max_key_size_read(struct file *file,
 }
 
 static ssize_t le_max_key_size_write(struct file *file,
-				      const char __user *user_buf,
+				     const char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
 	struct hci_dev *hdev = file->private_data;
@@ -3497,6 +3498,7 @@ int smp_register(struct hci_dev *hdev)
 	chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
 	if (IS_ERR(chan)) {
 		int err = PTR_ERR(chan);
+
 		chan = hdev->smp_data;
 		hdev->smp_data = NULL;
 		smp_del_chan(chan);
@@ -3857,7 +3859,7 @@ static int __init run_selftests(struct crypto_shash *tfm_cmac,
 
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
 
 	BT_INFO("SMP test passed in %llu usecs", duration);
 
-- 
2.24.0.393.g34dc348eaf-goog

