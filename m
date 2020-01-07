Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666BBC32771
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 00:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E2A2073D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 00:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hj0oBoft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgAGAni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:43:38 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35688 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgAGAni (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 19:43:38 -0500
Received: by mail-ua1-f65.google.com with SMTP id y23so17839260ual.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 16:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJGP8z6ylGmyPiwgmuHIJRuMWtWZYEhx76SCHr8kfpM=;
        b=hj0oBoftdPigFSRSlqD/vyXWxYia85xir0/DQZc/aFl/cUgK92n3ZmCrUp02RjQlLi
         RtLFpy5CcGoso2sHD8A47/DCw85RO/Ot3orWUSG1IpJJWeb5LIlFM6NmZvIajF+ysi7h
         qgl0u68J2GSX9k3iD7EBYs7S9Qvg/hWIQxaZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJGP8z6ylGmyPiwgmuHIJRuMWtWZYEhx76SCHr8kfpM=;
        b=MSpcyj1yjTlGoPKhKS+VEVvBRANf3SLZgutplkzNTweXI8Xwy66KLNMaY4U3iA1own
         GgBKMbLChsq1DzAHASj+GgPtdU6RECxU3ZdAEPkkso2Wv0TBN736NNYWZuFU3qP1vM1A
         wHgHvyxpfDcszORM6HC/ondIkVuKbi7hXyjGYJy/qRKGivX1GdyvV5cW/arvLGE9e+5F
         jZmus6vJoSfAtxMzU76+Z9P805Cgni8l8UyOZL7AE+WD0LNm8rTLAdC4sBkLpPoHpnTx
         3h6bSK2wHf3IqVhoVVgd5I1V1DtcXDgUQlEFhhPbukobhRwJBjl2wjbbRHk/engsIQu1
         Rd9w==
X-Gm-Message-State: APjAAAVl/Nm1mGz6qFFVABCK/+MOl2yK/OLFg4xp/+u8pyibFjEexeZN
        zKbMfL1B7nkBe+3OxtgtFijRwOnSIfU=
X-Google-Smtp-Source: APXvYqzi2SPNyI0FczQAtI112IpsDRj4PyBPLZcGTBpT5qeQceRWEKlHNKGF3mkWHiobUIMglR8yyQ==
X-Received: by 2002:ab0:7049:: with SMTP id v9mr60971365ual.95.1578357815982;
        Mon, 06 Jan 2020 16:43:35 -0800 (PST)
Received: from alain.c.googlers.com.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id k1sm6305244ual.2.2020.01.06.16.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 16:43:35 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH v5 2/2] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
Date:   Tue,  7 Jan 2020 00:43:17 +0000
Message-Id: <20200107004317.152792-2-alainm@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200107004317.152792-1-alainm@chromium.org>
References: <20200107004317.152792-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

MGMT command is added to receive the list of blocked keys from
user-space.

The list is used to:
1) Block keys from being distributed by the device during
   the ke distribution phase of SMP.
2) Filter out any keys that were previously saved so
   they are no longer used.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci_core.h | 10 ++++
 include/net/bluetooth/mgmt.h     | 17 +++++++
 net/bluetooth/hci_core.c         | 85 +++++++++++++++++++++++++++++---
 net/bluetooth/hci_debugfs.c      | 17 +++++++
 net/bluetooth/mgmt.c             | 76 ++++++++++++++++++++++++++++
 net/bluetooth/smp.c              | 18 +++++++
 6 files changed, 215 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb636b..9020fa3c4d30 100644
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
 
@@ -1121,6 +1129,8 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 val[16], bdaddr_t *rpa);
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
+bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
+void hci_blocked_keys_clear(struct hci_dev *hdev);
 void hci_smp_irks_clear(struct hci_dev *hdev);
 
 bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9cee7ddc6741..a90666af05bd 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -654,6 +654,23 @@ struct mgmt_cp_set_phy_confguration {
 } __packed;
 #define MGMT_SET_PHY_CONFIGURATION_SIZE	4
 
+#define MGMT_OP_SET_BLOCKED_KEYS	0x0046
+
+#define HCI_BLOCKED_KEY_TYPE_LINKKEY	0x00
+#define HCI_BLOCKED_KEY_TYPE_LTK	0x01
+#define HCI_BLOCKED_KEY_TYPE_IRK	0x02
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
+#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9e19d5a3aac8..f0298db26dc3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2311,6 +2311,33 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
 	}
 }
 
+void hci_blocked_keys_clear(struct hci_dev *hdev)
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
@@ -2319,6 +2346,16 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	list_for_each_entry_rcu(k, &hdev->link_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) == 0) {
 			rcu_read_unlock();
+
+			if (hci_is_blocked_key(hdev,
+					       HCI_BLOCKED_KEY_TYPE_LINKKEY,
+					       k->val)) {
+				bt_dev_warn_ratelimited(hdev,
+							"Link key blocked for %pMR",
+							&k->bdaddr);
+				return NULL;
+			}
+
 			return k;
 		}
 	}
@@ -2387,6 +2424,15 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 		if (smp_ltk_is_sc(k) || ltk_role(k->type) == role) {
 			rcu_read_unlock();
+
+			if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LTK,
+					       k->val)) {
+				bt_dev_warn_ratelimited(hdev,
+							"LTK blocked for %pMR",
+							&k->bdaddr);
+				return NULL;
+			}
+
 			return k;
 		}
 	}
@@ -2397,31 +2443,42 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa)
 {
+	struct smp_irk *irk_to_return = NULL;
 	struct smp_irk *irk;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
 		if (!bacmp(&irk->rpa, rpa)) {
-			rcu_read_unlock();
-			return irk;
+			irk_to_return = irk;
+			goto done;
 		}
 	}
 
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
 		if (smp_irk_matches(hdev, irk->val, rpa)) {
 			bacpy(&irk->rpa, rpa);
-			rcu_read_unlock();
-			return irk;
+			irk_to_return = irk;
+			goto done;
 		}
 	}
+
+done:
+	if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
+						irk_to_return->val)) {
+		bt_dev_warn_ratelimited(hdev, "Identity key blocked for %pMR",
+					&irk_to_return->bdaddr);
+		irk_to_return = NULL;
+	}
+
 	rcu_read_unlock();
 
-	return NULL;
+	return irk_to_return;
 }
 
 struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type)
 {
+	struct smp_irk *irk_to_return = NULL;
 	struct smp_irk *irk;
 
 	/* Identity Address must be public or static random */
@@ -2432,13 +2489,23 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
 		if (addr_type == irk->addr_type &&
 		    bacmp(bdaddr, &irk->bdaddr) == 0) {
-			rcu_read_unlock();
-			return irk;
+			irk_to_return = irk;
+			goto done;
 		}
 	}
+
+done:
+
+	if (irk_to_return && hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
+						irk_to_return->val)) {
+		bt_dev_warn_ratelimited(hdev, "Identity key blocked for %pMR",
+					&irk_to_return->bdaddr);
+		irk_to_return = NULL;
+	}
+
 	rcu_read_unlock();
 
-	return NULL;
+	return irk_to_return;
 }
 
 struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
@@ -3244,6 +3311,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->pend_le_reports);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 	INIT_LIST_HEAD(&hdev->adv_instances);
+	INIT_LIST_HEAD(&hdev->blocked_keys);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -3443,6 +3511,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
+	hci_blocked_keys_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 402e2cc54044..1c8100bc4e04 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -152,6 +152,21 @@ static int blacklist_show(struct seq_file *f, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(blacklist);
 
+static int blocked_keys_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct blocked_key *key;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(key, &hdev->blocked_keys, list)
+		seq_printf(f, "%u %*phN\n", key->type, 16, key->val);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(blocked_keys);
+
 static int uuids_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -308,6 +323,8 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 			    &device_list_fops);
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
 			    &blacklist_fops);
+	debugfs_create_file("blocked_keys", 0444, hdev->debugfs, hdev,
+			    &blocked_keys_fops);
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 	debugfs_create_file("remote_oob", 0400, hdev->debugfs, hdev,
 			    &remote_oob_fops);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index acb7c6d5643f..339c762eb6fd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
+	MGMT_OP_SET_BLOCKED_KEYS,
 };
 
 static const u16 mgmt_events[] = {
@@ -2341,6 +2342,14 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
+		if (hci_is_blocked_key(hdev,
+				       HCI_BLOCKED_KEY_TYPE_LINKKEY,
+				       key->val)) {
+			bt_dev_warn(hdev, "Skipping blocked link key for %pMR",
+				    &key->addr.bdaddr);
+			continue;
+		}
+
 		/* Always ignore debug keys and require a new pairing if
 		 * the user wants to use them.
 		 */
@@ -3531,6 +3540,55 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
+			    u16 len)
+{
+	int err = MGMT_STATUS_SUCCESS;
+	struct mgmt_cp_set_blocked_keys *keys = data;
+	const u16 max_key_count = ((U16_MAX - sizeof(*keys)) /
+				   sizeof(struct mgmt_blocked_key_info));
+	u16 key_count, expected_len;
+	int i;
+
+	BT_DBG("request for %s", hdev->name);
+
+	key_count = __le16_to_cpu(keys->key_count);
+	if (key_count > max_key_count) {
+		bt_dev_err(hdev, "too big key_count value %u", key_count);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	expected_len = struct_size(keys, keys, key_count);
+	if (expected_len != len) {
+		bt_dev_err(hdev, "expected %u bytes, got %u bytes",
+			   expected_len, len);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	hci_dev_lock(hdev);
+
+	hci_blocked_keys_clear(hdev);
+
+	for (i = 0; i < keys->key_count; ++i) {
+		struct blocked_key *b = kzalloc(sizeof(*b), GFP_KERNEL);
+
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
@@ -5051,6 +5109,14 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
 
+		if (hci_is_blocked_key(hdev,
+				       HCI_BLOCKED_KEY_TYPE_IRK,
+				       irk->val)) {
+			bt_dev_warn(hdev, "Skipping blocked IRK for %pMR",
+				    &irk->addr.bdaddr);
+			continue;
+		}
+
 		hci_add_irk(hdev, &irk->addr.bdaddr,
 			    le_addr_type(irk->addr.type), irk->val,
 			    BDADDR_ANY);
@@ -5134,6 +5200,14 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type, authenticated;
 
+		if (hci_is_blocked_key(hdev,
+				       HCI_BLOCKED_KEY_TYPE_LTK,
+				       key->val)) {
+			bt_dev_warn(hdev, "Skipping blocked LTK for %pMR",
+				    &key->addr.bdaddr);
+			continue;
+		}
+
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
 			authenticated = 0x00;
@@ -6914,6 +6988,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
+	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
+						HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6b42be4b5861..4ece170c518e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2453,6 +2453,15 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
+	/* Pairing is aborted if any blocked keys are distributed */
+	if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_LTK,
+			       rp->ltk)) {
+		bt_dev_warn_ratelimited(conn->hcon->hdev,
+					"LTK blocked for %pMR",
+					&conn->hcon->dst);
+		return SMP_INVALID_PARAMS;
+	}
+
 	SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
 
 	skb_pull(skb, sizeof(*rp));
@@ -2509,6 +2518,15 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
 
+	/* Pairing is aborted if any blocked keys are distributed */
+	if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_IRK,
+			       info->irk)) {
+		bt_dev_warn_ratelimited(conn->hcon->hdev,
+					"Identity key blocked for %pMR",
+					&conn->hcon->dst);
+		return SMP_INVALID_PARAMS;
+	}
+
 	SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
 
 	skb_pull(skb, sizeof(*info));
-- 
2.24.1.735.g03f4e72817-goog

