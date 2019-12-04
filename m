Return-Path: <SRS0=DiUs=Z2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF12C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34F3206DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 01:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RD076z49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLDBeN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:34:13 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:39213 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLDBeN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Dec 2019 20:34:13 -0500
Received: by mail-ua1-f54.google.com with SMTP id r13so2174628uan.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Dec 2019 17:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb33YOqOQg6k231XHghVLP8kWK4jXt1bYEOPLTrfiFs=;
        b=RD076z49Yp0BtfS0XL0+00c9xJKCsHyYipZ4iaDYaCnzv/4Y4NS1i6NjgRalR4TEgH
         1OJnIVE6xonYL3AZgNyKikGpqE+bVSUWT1+LOBDkdNFDe4TM4FaE2lHA0UUw5hJc3bjw
         d7g8zfvBBk3EAv5JPRuEYWfxvdtwVyb7Ifqoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb33YOqOQg6k231XHghVLP8kWK4jXt1bYEOPLTrfiFs=;
        b=njLiolzJa6n7keN5DqRyM54q3iulrw9CRTnFedWaNGMi8VZ7XrSKEhW7W9kKOf8+Bj
         RTfrTZubLHhVGFXdvGjuBrqtrTt59y7xMY6J4jcdOY3d6MrPEDVwbP4FT3RW5LseWDn7
         4Tw6zIrvMUsXMaF74mprlVmUtTkAoj/J4wZURuA3FTiNlXoHhXdE5VjPfvOaU9KOXc+1
         EJCpugcjaL+73TkDabbtrnReprNWtjgODc0elA7lfCcIXXh9mzo1gPrbo5RR+tCdB5W1
         MblylQFNLwUn46z+S0wgzrT+HDQWyE1ObdGREgeYRghwVrTwXbrCVjNL4QnalPVTe52V
         OWXg==
X-Gm-Message-State: APjAAAUbmcIMfFijoDReeb1VNliAI4UWUBa+xygOpH7N8VR/fVQf9h+Y
        C+9SYO6QdNc5q77N1725qhhYG4a4Tnk=
X-Google-Smtp-Source: APXvYqxl/kUtYi30O2N1OO4T8/nK5CxlN2+fagkYeWlqPj43GxvKqhbBUgLNENB5mLpGlrw1bJKOrg==
X-Received: by 2002:ab0:69d4:: with SMTP id u20mr908057uaq.1.1575423251408;
        Tue, 03 Dec 2019 17:34:11 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id l3sm1122078vsp.26.2019.12.03.17.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 17:34:11 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [RFC] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
Date:   Wed,  4 Dec 2019 01:34:07 +0000
Message-Id: <20191204013407.30221-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Would love comments on this.  Corresponding user mode changes also
submitted for comments.

---
 include/net/bluetooth/hci_core.h | 15 ++++++++++
 include/net/bluetooth/mgmt.h     | 13 +++++++++
 net/bluetooth/hci_core.c         | 50 ++++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c             | 50 ++++++++++++++++++++++++++++++++
 net/bluetooth/smp.c              |  8 +++++
 5 files changed, 133 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b689aceb636b..4de9e3a21e7d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -118,6 +118,19 @@ struct bt_uuid {
 	u8 svc_hint;
 };
 
+enum hci_blocked_key_type {
+	HCI_BLOCKED_KEY_TYPE_LINKKEY	= 0x00,
+	HCI_BLOCKED_KEY_TYPE_LTK		= 0x01,
+	HCI_BLOCKED_KEY_TYPE_IRK		= 0x02,
+};
+
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
@@ -397,6 +410,7 @@ struct hci_dev {
 	struct list_head	le_conn_params;
 	struct list_head	pend_le_conns;
 	struct list_head	pend_le_reports;
+	struct list_head	blocked_keys;
 
 	struct hci_dev_stats	stat;
 
@@ -1121,6 +1135,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 val[16], bdaddr_t *rpa);
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
+bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
 void hci_smp_irks_clear(struct hci_dev *hdev);
 
 bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9cee7ddc6741..3d780da835fc 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -654,6 +654,19 @@ struct mgmt_cp_set_phy_confguration {
 } __packed;
 #define MGMT_SET_PHY_CONFIGURATION_SIZE	4
 
+#define MGMT_OP_SET_BLOCKED_KEYS	0x0046
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
index 9e19d5a3aac8..e72434258c39 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2311,6 +2311,16 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
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
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *k;
@@ -2319,6 +2329,12 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	list_for_each_entry_rcu(k, &hdev->link_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) == 0) {
 			rcu_read_unlock();
+
+			if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LINKKEY, k->val))
+				/* The device may have refreshed it to a new one which
+				 * would imply a second key is in the list */
+				continue;
+
 			return k;
 		}
 	}
@@ -2387,6 +2403,10 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 		if (smp_ltk_is_sc(k) || ltk_role(k->type) == role) {
 			rcu_read_unlock();
+
+			if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LTK, k->val))
+				return NULL;
+
 			return k;
 		}
 	}
@@ -2540,6 +2560,25 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return irk;
 }
 
+bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16])
+{
+	bool blocked = false;
+	struct blocked_key *b;
+
+	rcu_read_lock();
+	list_for_each_entry(b, &hdev->blocked_keys, list) {
+		if (b->type == type &&
+				!memcmp(b->val, val, sizeof(b->val))) {
+			blocked = true;
+			goto done;
+		}
+	}
+
+done:
+	rcu_read_unlock();
+	return blocked;
+}
+
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *key;
@@ -2548,10 +2587,13 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	if (!key)
 		return -ENOENT;
 
-	BT_DBG("%s removing %pMR", hdev->name, bdaddr);
+	do {
+		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
 
-	list_del_rcu(&key->list);
-	kfree_rcu(key, rcu);
+		list_del_rcu(&key->list);
+		kfree_rcu(key, rcu);
+		key = hci_find_link_key(hdev, bdaddr);
+	} while (key);
 
 	return 0;
 }
@@ -3244,6 +3286,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->pend_le_reports);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 	INIT_LIST_HEAD(&hdev->adv_instances);
+	INIT_LIST_HEAD(&hdev->blocked_keys);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -3443,6 +3486,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
+	hci_blocked_keys_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index acb7c6d5643f..f45475a7c854 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
+	MGMT_OP_SET_BLOCKED_KEYS,
 };
 
 static const u16 mgmt_events[] = {
@@ -3531,6 +3532,54 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
+			  u16 len)
+{
+	int err = MGMT_STATUS_SUCCESS;
+
+	if (len < sizeof (struct mgmt_cp_set_blocked_keys) ||
+		((len - offsetof(struct mgmt_cp_set_blocked_keys, keys)) %
+			sizeof(struct mgmt_blocked_key_info))) {
+		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
+				MGMT_STATUS_INVALID_PARAMS, NULL, 0);
+	}
+
+	hci_dev_lock(hdev);
+	{
+		struct mgmt_cp_set_blocked_keys *keys = data;
+		int i;
+		for (i = 0; i < keys->key_count; ++i) {
+			bool alreadyBlocked = false;
+			struct blocked_key *b;
+			list_for_each_entry(b, &hdev->blocked_keys, list) {
+				if (keys->keys[i].type == b->type &&
+					!memcmp(keys->keys[i].val, b->val,
+							sizeof(keys->keys[i].val))) {
+					alreadyBlocked = true;
+					break;
+				}
+			}
+
+			if (alreadyBlocked)
+				continue;
+
+			b = kzalloc(sizeof(*b), GFP_KERNEL);
+			if (!b) {
+				err = MGMT_STATUS_NO_RESOURCES;
+				break;
+			}
+
+			b->type = keys->keys[i].type;
+			memcpy(b->val, keys->keys[i].val, sizeof(b->val));
+			list_add_rcu(&b->list, &hdev->blocked_keys);
+		}
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
@@ -6914,6 +6963,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
+	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6b42be4b5861..f61c78d81168 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2453,6 +2453,10 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
+	if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_LTK,
+			rp->ltk))
+		return SMP_INVALID_PARAMS;
+
 	SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
 
 	skb_pull(skb, sizeof(*rp));
@@ -2509,6 +2513,10 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*info))
 		return SMP_INVALID_PARAMS;
 
+	if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_IRK,
+			info->irk))
+		return SMP_INVALID_PARAMS;
+
 	SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
 
 	skb_pull(skb, sizeof(*info));
-- 
2.24.0.393.g34dc348eaf-goog

