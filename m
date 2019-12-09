Return-Path: <SRS0=WaXy=Z7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CD2C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E6820721
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 22:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ktGV910A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLIWGA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:06:00 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42639 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIWF7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 17:05:59 -0500
Received: by mail-vk1-f195.google.com with SMTP id u123so4955559vkb.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2019 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aO2glSMhR+zyNUUroFVGMmyDKapgGDlZgl+abjeDQds=;
        b=ktGV910AOERKLwm3OtCtwzu/sKXt0yyQpQzGw/LnUynel0D3xucF1N7fLzIMq3ztgC
         GIWgeNG7HcBGUAVC+o9cm0Ha6evgrG8nOcbJzfB1iYkT9QK5fj4yhNHJImgFDhbmZgti
         DSrDbIvcp1CSE0eu1UTrDyPM0b+b7t2MRXY/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aO2glSMhR+zyNUUroFVGMmyDKapgGDlZgl+abjeDQds=;
        b=GfD+5gp+M9JcrrnZ7w+wYxkQoj9KaNrJNii+QwQZ9Oz6puLWrxSWWG1+1xwjYxVx2L
         2HW8F8ATdY0spmjnbQqE6VTBfqiWMMQvu9043oLO+Sc6ThmSxihgzkUN8YXlTz7aioot
         9Y7uHbaiYKHGFtrPQYYPZBcK+UIVo9ogZfNDrnU3rH/LLMpmgqY39Vlu3SvXJvmEDzF5
         9rHIKUBq1E5OIlsX67lTJ5FEsIiAbZ3V9LZObAwSHCj52dGXJ5ZKOOIciq0aox0WVpEs
         h7h51Rzak6FbFtNDtsl5hm1NA48OJRxBGDPlzlVeZ06LSc5SwY1YSK1PaBz365gk92tL
         xwaw==
X-Gm-Message-State: APjAAAU0RDiWlj4xfm3NnGeL1hFZme2nIWMWwGnl7pmrDmZWVM5m8Pgz
        xwFFZTqFImS/FVIjNcZBp8KcZ3u3ehI=
X-Google-Smtp-Source: APXvYqwp/sQDAyGDtqyt3fNAte2L2tM8+xLgRaTqOrnfkP4sNLb1rA2UMSHo7tZJjPGujyTGgO8/PQ==
X-Received: by 2002:ac5:c283:: with SMTP id h3mr11058982vkk.93.1575929157596;
        Mon, 09 Dec 2019 14:05:57 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id t36sm729373uat.10.2019.12.09.14.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 14:05:57 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
Date:   Mon,  9 Dec 2019 22:05:51 +0000
Message-Id: <20191209220551.117763-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

MGMT command is added to receive the list of blocked keys from user-space.
The list is used to:
1) Block keys from being distributed by the device during the key
distribution phase of SMP.
2) Filter out any keys that were previously saved so they are no longer
used.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/bluetooth.h |  4 +++
 include/net/bluetooth/hci_core.h  |  9 +++++
 include/net/bluetooth/mgmt.h      | 17 +++++++++
 net/bluetooth/hci_core.c          | 57 +++++++++++++++++++++++++++++++
 net/bluetooth/lib.c               | 16 +++++++++
 net/bluetooth/mgmt.c              | 48 ++++++++++++++++++++++++++
 net/bluetooth/smp.c               | 11 ++++++
 7 files changed, 162 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index fabee6db0abb..92b0e6889f8c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -127,12 +127,16 @@ void bt_info(const char *fmt, ...);
 __printf(1, 2)
 void bt_warn(const char *fmt, ...);
 __printf(1, 2)
+void bt_warn_ratelimited(const char *fmt, ...);
+__printf(1, 2)
 void bt_err(const char *fmt, ...);
 __printf(1, 2)
 void bt_err_ratelimited(const char *fmt, ...);
 
 #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
 #define BT_WARN(fmt, ...)	bt_warn(fmt "\n", ##__VA_ARGS__)
+#define BT_WARN_RATELIMITED(fmt, ...)		\
+	bt_warn_ratelimited(fmt "\n", ##__VA_ARGS__)
 #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
 #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb636b..e9a789e11493 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -118,6 +118,13 @@ struct bt_uuid {
 	u8 svc_hint;
 };
 
+struct blocked_key {
+	struct list_head list;
+	struct rcu_head rcu;
+	u8 type;
+	u8 val[16];
+};
+
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
@@ -397,6 +404,7 @@ struct hci_dev {
 	struct list_head	le_conn_params;
 	struct list_head	pend_le_conns;
 	struct list_head	pend_le_reports;
+	struct list_head	blocked_keys;
 
 	struct hci_dev_stats	stat;
 
@@ -1121,6 +1129,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 val[16], bdaddr_t *rpa);
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
+bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
 void hci_smp_irks_clear(struct hci_dev *hdev);
 
 bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9cee7ddc6741..c9b1d39d6d6c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -654,6 +654,23 @@ struct mgmt_cp_set_phy_confguration {
 } __packed;
 #define MGMT_SET_PHY_CONFIGURATION_SIZE	4
 
+#define MGMT_OP_SET_BLOCKED_KEYS	0x0046
+
+#define HCI_BLOCKED_KEY_TYPE_LINKKEY	0x00
+#define HCI_BLOCKED_KEY_TYPE_LTK		0x01
+#define HCI_BLOCKED_KEY_TYPE_IRK		0x02
+
+struct mgmt_blocked_key_info {
+	__u8 type;
+	__u8 val[16];
+} __packed;
+
+struct mgmt_cp_set_blocked_keys {
+	__le16 key_count;
+	struct mgmt_blocked_key_info keys[0];
+} __packed;
+#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9e19d5a3aac8..d6fab1e5d879 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2311,6 +2311,33 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
 	}
 }
 
+static void hci_blocked_keys_clear(struct hci_dev *hdev)
+{
+	struct blocked_key *b;
+
+	list_for_each_entry_rcu(b, &hdev->blocked_keys, list) {
+		list_del_rcu(&b->list);
+		kfree_rcu(b, rcu);
+	}
+}
+
+bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16])
+{
+	bool blocked = false;
+	struct blocked_key *b;
+
+	rcu_read_lock();
+	list_for_each_entry(b, &hdev->blocked_keys, list) {
+		if (b->type == type && !memcmp(b->val, val, sizeof(b->val))) {
+			blocked = true;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+	return blocked;
+}
+
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *k;
@@ -2319,6 +2346,14 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	list_for_each_entry_rcu(k, &hdev->link_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) == 0) {
 			rcu_read_unlock();
+
+			if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LINKKEY,
+									k->val)) {
+				BT_WARN_RATELIMITED("Key blocked for %pMR", &k->bdaddr);
+
+				return NULL;
+			}
+
 			return k;
 		}
 	}
@@ -2387,6 +2422,12 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 		if (smp_ltk_is_sc(k) || ltk_role(k->type) == role) {
 			rcu_read_unlock();
+
+			if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LTK, k->val)) {
+				BT_WARN_RATELIMITED("Key blocked for %pMR", &k->bdaddr);
+				return NULL;
+			}
+
 			return k;
 		}
 	}
@@ -2401,6 +2442,11 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK, irk->val)) {
+			BT_WARN_RATELIMITED("Key blocked for %pMR", &irk->bdaddr);
+			continue;
+		}
+
 		if (!bacmp(&irk->rpa, rpa)) {
 			rcu_read_unlock();
 			return irk;
@@ -2408,6 +2454,11 @@ struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 	}
 
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK, irk->val)) {
+			BT_WARN_RATELIMITED("Key blocked for %pMR", &irk->bdaddr);
+			continue;
+		}
+
 		if (smp_irk_matches(hdev, irk->val, rpa)) {
 			bacpy(&irk->rpa, rpa);
 			rcu_read_unlock();
@@ -2430,6 +2481,10 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
+		if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
+								irk->val))
+			continue;
+
 		if (addr_type == irk->addr_type &&
 		    bacmp(bdaddr, &irk->bdaddr) == 0) {
 			rcu_read_unlock();
@@ -3244,6 +3299,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->pend_le_reports);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 	INIT_LIST_HEAD(&hdev->adv_instances);
+	INIT_LIST_HEAD(&hdev->blocked_keys);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -3443,6 +3499,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
+	hci_blocked_keys_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 63e65d9b4b24..755bc7c12e2d 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -167,6 +167,22 @@ void bt_warn(const char *format, ...)
 }
 EXPORT_SYMBOL(bt_warn);
 
+void bt_warn_ratelimited(const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	pr_warn_ratelimited("%pV", &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(bt_warn_ratelimited);
+
 void bt_err(const char *format, ...)
 {
 	struct va_format vaf;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index acb7c6d5643f..a29e92a575e8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
+	MGMT_OP_SET_BLOCKED_KEYS,
 };
 
 static const u16 mgmt_events[] = {
@@ -3531,6 +3532,52 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
+							u16 len)
+{
+	int err = MGMT_STATUS_SUCCESS;
+	struct mgmt_cp_set_blocked_keys *keys = data;
+	int i;
+
+	if (len < sizeof(struct mgmt_cp_set_blocked_keys) ||
+	    ((len - offsetof(struct mgmt_cp_set_blocked_keys, keys)) %
+			sizeof(struct mgmt_blocked_key_info))) {
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
+				MGMT_STATUS_INVALID_PARAMS, NULL, 0);
+	}
+
+	hci_dev_lock(hdev);
+	for (i = 0; i < keys->key_count; ++i) {
+		bool already_blocked = false;
+		struct blocked_key *b;
+
+		list_for_each_entry(b, &hdev->blocked_keys, list) {
+			if (keys->keys[i].type == b->type &&
+				!memcmp(keys->keys[i].val, b->val, sizeof(keys->keys[i].val))) {
+				already_blocked = true;
+				break;
+			}
+		}
+
+		if (already_blocked)
+			continue;
+
+		b = kzalloc(sizeof(*b), GFP_KERNEL);
+		if (!b) {
+			err = MGMT_STATUS_NO_RESOURCES;
+			break;
+		}
+
+		b->type = keys->keys[i].type;
+		memcpy(b->val, keys->keys[i].val, sizeof(b->val));
+		list_add_rcu(&b->list, &hdev->blocked_keys);
+	}
+	hci_dev_unlock(hdev);
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
+				err, NULL, 0);
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -6914,6 +6961,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
+	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6b42be4b5861..8bc4d1586d4b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2453,6 +2453,10 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
+	if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_LTK,
+							rp->ltk))
+		return SMP_INVALID_PARAMS;
+
 	SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
 
 	skb_pull(skb, sizeof(*rp));
@@ -2509,6 +2513,13 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
 
+	if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_IRK,
+							info->irk)) {
+		BT_WARN_RATELIMITED("Irk key blocked for %pMR", &conn->hcon->dst);
+
+		return SMP_INVALID_PARAMS;
+	}
+
 	SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
 
 	skb_pull(skb, sizeof(*info));
-- 
2.24.0.393.g34dc348eaf-goog

