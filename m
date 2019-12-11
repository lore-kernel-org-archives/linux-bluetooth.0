Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92779C2D0BF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 01:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A9321D7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 01:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QZ87uoJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfLKBzQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:55:16 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37963 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfLKBzP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 20:55:15 -0500
Received: by mail-vs1-f66.google.com with SMTP id y195so14661526vsy.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2019 17:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NfAMCqpJznmBLf5vzQcgoSj9+A/w/CE9zM4JBJWvGRM=;
        b=QZ87uoJ8lMwZeJb1Y1yakhm9DDUX40z06alOQQKpM9tbcQGv0h4r+QomBBbZUoRlSx
         v7LBW7OClWLZ+pADpLYwRkq2SGFFwNpQ6ju1edtwiog/Yl/0XHy+yPBbuxWL0/SIetan
         b+31kNou1Q3Hj4w6kslgnEivjYI7Vth2i7Sjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfAMCqpJznmBLf5vzQcgoSj9+A/w/CE9zM4JBJWvGRM=;
        b=g4N+xkr3FSsm+0YVca1UKO+q93PdnSESWEU6gnH5vmzladBz8kbm2WD0l6/MgLK0VF
         rZBKJP69DPoxk0TFTWItklqm4+0jNRxjtsnmlFIYDVVom0/08CjW3NkkTzed0R4q9j5G
         lAQTYRotfBeqyj9XrIzgmLNXEYIpqhiDiQJ1vWh+OmAtEzQ2sPF2rV6UNELvJdmbqyA1
         WS4n9x5Ozrpy61fxi6XH30coWpHkpfMq0FTgMrX/43g36mWFEGVbq4bCcVQ5cc1/1yQ4
         ut5E/W/EamArq3WqI5e/Zkb8T5gPsifzyNleNhreDsgFVcJQxOJIyJXJvV2GD4i3GOxK
         Faow==
X-Gm-Message-State: APjAAAW4cbATmW0mMMOYHidYxKPfVQtLhAyBnsZjxKXslQ4ZgYZeNZIj
        e8VdqtJsos6KM9pYV4IjzXzHFvDTt3Y=
X-Google-Smtp-Source: APXvYqy+ie/E4Oh0S9/GhGYLkpvS8YYHWVq/rOiQc3CCT3ftkHh3Hjv2d4p9UgwK9hi4EXigmi9hsg==
X-Received: by 2002:a67:e205:: with SMTP id g5mr572082vsa.186.1576029313594;
        Tue, 10 Dec 2019 17:55:13 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id k45sm380511uae.9.2019.12.10.17.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 17:55:13 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 2/2] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
Date:   Wed, 11 Dec 2019 01:54:44 +0000
Message-Id: <20191211015444.143341-2-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
In-Reply-To: <20191211015444.143341-1-alainm@chromium.org>
References: <20191211015444.143341-1-alainm@chromium.org>
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
 net/bluetooth/hci_debugfs.c      | 18 +++++++
 net/bluetooth/mgmt.c             | 53 ++++++++++++++++++++
 net/bluetooth/smp.c              | 18 +++++++
 6 files changed, 193 insertions(+), 8 deletions(-)

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
index 9e19d5a3aac8..0598fa66037e 100644
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
+	if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
+			       irk_to_return->val)) {
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
+	if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_IRK,
+			       irk_to_return->val)) {
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
index 402e2cc54044..f9b4df56f166 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -152,6 +152,22 @@ static int blacklist_show(struct seq_file *f, void *p)
 
 DEFINE_SHOW_ATTRIBUTE(blacklist);
 
+static int blocked_keys_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct blocked_key *key;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(key, &hdev->blocked_keys, list)
+		seq_printf(f, "%u %*phN\n", key->type, (int)sizeof(key->val),
+			   key->val);
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
@@ -308,6 +324,8 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 			    &device_list_fops);
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
 			    &blacklist_fops);
+	debugfs_create_file("blocked_keys", 0444, hdev->debugfs, hdev,
+			    &blocked_keys_fops);
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 	debugfs_create_file("remote_oob", 0400, hdev->debugfs, hdev,
 			    &remote_oob_fops);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index acb7c6d5643f..78864cf645e3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
+	MGMT_OP_SET_BLOCKED_KEYS,
 };
 
 static const u16 mgmt_events[] = {
@@ -3531,6 +3532,57 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
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
+		bt_dev_err(hdev, "%s: too big key_count value %u", __func__,
+			   key_count);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	expected_len = struct_size(keys, keys, key_count);
+	if (expected_len != len) {
+		bt_dev_err(hdev,
+			   "%s: expected %u bytes, got %u bytes", __func__,
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
@@ -6914,6 +6966,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
+	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE },
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
2.24.0.525.g8f36a354ae-goog

