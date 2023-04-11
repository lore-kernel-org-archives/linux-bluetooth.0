Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A2C76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Apr 2023 23:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjDKXTg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Apr 2023 19:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDKXTe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Apr 2023 19:19:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1743E3C11
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 16:19:29 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id kh6so7872680plb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681255168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8VRPe6TW2w6fmcvWplNLrBM6gUfWDBzF27F+imk7YQ=;
        b=JdCr5Gp1eLz5SwPgOc5x/osxbmQ2Xb5sIiT+r37KCDzuqUS/ZndSScbI91rr/S5YD0
         ZnNMIZku1jBryk8eMSQte5NTlDbyAKfvtPgGvJcTFefRsIKQAMofwDYfnNVWZ0fl0CPK
         XECb5gynmaeElI598FdWSIJY4YWcybllyk4uAmd/QbQJdiQNp7n2ToXfk8fb0JE/0kzh
         O9Xqh+1y1iHBqMsEV4IXJmthMNiIkVOJ9fNH5zK6pzqaeLKIoD3Cl9xmk2G5Us1l9Wzv
         BElxBfIMqS7sp7ce2pRuvyHwQ3yA5pgHQH+EpQ9TJ4VK33c9mqCzI/NzuKCOZuyQ4NGc
         ZOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681255168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8VRPe6TW2w6fmcvWplNLrBM6gUfWDBzF27F+imk7YQ=;
        b=E/7qty+5IyGyqXYbPUi/kQwPP5zN1VP6AFZBy0Voj//ftAYJ0FJQGNgrK7m2gHpi6k
         5VhGnATVMIUAXF/U2Ik1I8NXSNqBoO12IPyVBd0vj7xOskXOjqsIe8d7rYlnvJ+/r1Xi
         vhhTPth8jJ8hf3ZHd42fAuAWMOx08Pcz5TxB6oA/RORKi86W9s3ip1rfAtcqfGyQPNwn
         Iite4XyF1YxN9ZRgC3WpCq03//UjvqHCcDr19/Bw8gtlnvgXi6cZn7zPZkGI372vWDLj
         5ZmwjZig5qxf1KF3dBLSR4fs2+cqrR+CTqN3fBeSxcUV1TjZU7gqceIXMKe2XsH8Roo/
         4uaA==
X-Gm-Message-State: AAQBX9eSOLGlaidM9wiyubpC04OCIlq0LHd/COrzaMTP6zAEbYgsCndm
        Cv5u14WifhaU9kwfz6XyeUnBVmZBLzU=
X-Google-Smtp-Source: AKy350bQ+cp+FWwh97TmST+0lg5EI7PGSZKr9aD46qLw4bPqqy5CKls3JrF3FK3q+adcd0uxk3FG/A==
X-Received: by 2002:a17:90b:164f:b0:23f:6830:568e with SMTP id il15-20020a17090b164f00b0023f6830568emr20672273pjb.8.1681255167561;
        Tue, 11 Apr 2023 16:19:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id em3-20020a17090b014300b00246b7b8b43asm112556pjb.49.2023.04.11.16.19.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:19:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Bluetooth: hci_conn: Add support for linking multiple hcon
Date:   Tue, 11 Apr 2023 16:19:24 -0700
Message-Id: <20230411231925.361066-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since it is required for some configurations to have multiple CIS with
the same peer (e.g. BAP - 4.4.6. Audio Configuration 6(i)).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  14 ++-
 net/bluetooth/hci_conn.c         | 155 ++++++++++++++++++++++---------
 net/bluetooth/hci_event.c        |  94 +++++++++----------
 net/bluetooth/iso.c              |   8 +-
 4 files changed, 173 insertions(+), 98 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 827e67159523..4fe1e71cb9d8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -770,7 +770,10 @@ struct hci_conn {
 	void		*iso_data;
 	struct amp_mgr	*amp_mgr;
 
-	struct hci_conn	*link;
+	struct list_head link_list;
+	struct hci_conn	*parent;
+	struct hci_link *link;
+
 	struct bt_codec codec;
 
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
@@ -780,6 +783,11 @@ struct hci_conn {
 	void (*cleanup)(struct hci_conn *conn);
 };
 
+struct hci_link {
+	struct list_head list;
+	struct hci_conn *conn;
+};
+
 struct hci_chan {
 	struct list_head list;
 	__u16 handle;
@@ -1383,12 +1391,14 @@ static inline void hci_conn_put(struct hci_conn *conn)
 	put_device(&conn->dev);
 }
 
-static inline void hci_conn_hold(struct hci_conn *conn)
+static inline struct hci_conn *hci_conn_hold(struct hci_conn *conn)
 {
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
 
 	atomic_inc(&conn->refcnt);
 	cancel_delayed_work(&conn->disc_work);
+
+	return conn;
 }
 
 static inline void hci_conn_drop(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5672b4924572..8b8ebd3e2585 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -330,8 +330,11 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 static bool find_next_esco_param(struct hci_conn *conn,
 				 const struct sco_param *esco_param, int size)
 {
+	if (!conn->parent)
+		return false;
+
 	for (; conn->attempt <= size; conn->attempt++) {
-		if (lmp_esco_2m_capable(conn->link) ||
+		if (lmp_esco_2m_capable(conn->parent) ||
 		    (esco_param[conn->attempt - 1].pkt_type & ESCO_2EV3))
 			break;
 		BT_DBG("hcon %p skipped attempt %d, eSCO 2M not supported",
@@ -461,7 +464,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		break;
 
 	case BT_CODEC_CVSD:
-		if (lmp_esco_capable(conn->link)) {
+		if (conn->parent && lmp_esco_capable(conn->parent)) {
 			if (!find_next_esco_param(conn, esco_param_cvsd,
 						  ARRAY_SIZE(esco_param_cvsd)))
 				return -EINVAL;
@@ -531,7 +534,7 @@ static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 		param = &esco_param_msbc[conn->attempt - 1];
 		break;
 	case SCO_AIRMODE_CVSD:
-		if (lmp_esco_capable(conn->link)) {
+		if (conn->parent && lmp_esco_capable(conn->parent)) {
 			if (!find_next_esco_param(conn, esco_param_cvsd,
 						  ARRAY_SIZE(esco_param_cvsd)))
 				return false;
@@ -637,21 +640,22 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 /* Device _must_ be locked */
 void hci_sco_setup(struct hci_conn *conn, __u8 status)
 {
-	struct hci_conn *sco = conn->link;
+	struct hci_link *link;
 
-	if (!sco)
+	link = list_first_entry_or_null(&conn->link_list, struct hci_link, list);
+	if (!link || !link->conn)
 		return;
 
 	BT_DBG("hcon %p", conn);
 
 	if (!status) {
 		if (lmp_esco_capable(conn->hdev))
-			hci_setup_sync(sco, conn->handle);
+			hci_setup_sync(link->conn, conn->handle);
 		else
-			hci_add_sco(sco, conn->handle);
+			hci_add_sco(link->conn, conn->handle);
 	} else {
-		hci_connect_cfm(sco, status);
-		hci_conn_del(sco);
+		hci_connect_cfm(link->conn, status);
+		hci_conn_del(link->conn);
 	}
 }
 
@@ -1042,6 +1046,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	skb_queue_head_init(&conn->data_q);
 
 	INIT_LIST_HEAD(&conn->chan_list);
+	INIT_LIST_HEAD(&conn->link_list);
 
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
@@ -1069,15 +1074,39 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return conn;
 }
 
-static bool hci_conn_unlink(struct hci_conn *conn)
+static void hci_conn_unlink(struct hci_conn *conn)
 {
-	if (!conn->link)
-		return false;
+	struct hci_dev *hdev = conn->hdev;
 
-	conn->link->link = NULL;
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
+	if (!conn->parent) {
+		struct hci_link *link, *t;
+
+		list_for_each_entry_safe(link, t, &conn->link_list, list)
+			hci_conn_unlink(link->conn);
+
+		return;
+	}
+
+	if (!conn->link)
+		return;
+
+	hci_conn_put(conn->parent);
+	conn->parent = NULL;
+
+	list_del_rcu(&conn->link->list);
+	synchronize_rcu();
+
+	kfree(conn->link);
 	conn->link = NULL;
 
-	return true;
+	/* Due to race, SCO connection might be not established
+	 * yet at this point. Delete it now, otherwise it is
+	 * possible for it to be stuck and can't be deleted.
+	 */
+	if (conn->handle == HCI_CONN_HANDLE_UNSET)
+		hci_conn_del(conn);
 }
 
 int hci_conn_del(struct hci_conn *conn)
@@ -1091,18 +1120,7 @@ int hci_conn_del(struct hci_conn *conn)
 	cancel_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
-		struct hci_conn *link = conn->link;
-
-		if (link) {
-			hci_conn_unlink(conn);
-			/* Due to race, SCO connection might be not established
-			 * yet at this point. Delete it now, otherwise it is
-			 * possible for it to be stuck and can't be deleted.
-			 */
-			if (link->handle == HCI_CONN_HANDLE_UNSET)
-				hci_conn_del(link);
-		}
-
+		hci_conn_unlink(conn);
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
 	} else if (conn->type == LE_LINK) {
@@ -1113,7 +1131,7 @@ int hci_conn_del(struct hci_conn *conn)
 		else
 			hdev->acl_cnt += conn->sent;
 	} else {
-		struct hci_conn *acl = conn->link;
+		struct hci_conn *acl = conn->parent;
 
 		if (acl) {
 			hci_conn_unlink(conn);
@@ -1600,11 +1618,40 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	return acl;
 }
 
+static struct hci_link *hci_conn_link(struct hci_conn *parent,
+				      struct hci_conn *conn)
+{
+	struct hci_dev *hdev = parent->hdev;
+	struct hci_link *link;
+
+	bt_dev_dbg(hdev, "parent %p hcon %p", parent, conn);
+
+	if (conn->link)
+		return conn->link;
+
+	if (conn->parent)
+		return NULL;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return NULL;
+
+	link->conn = hci_conn_hold(conn);
+	conn->link = link;
+	conn->parent = hci_conn_get(parent);
+
+	/* Use list_add_tail_rcu append to the list */
+	list_add_tail_rcu(&link->list, &parent->link_list);
+
+	return link;
+}
+
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting, struct bt_codec *codec)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
+	struct hci_link *link;
 
 	acl = hci_connect_acl(hdev, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING,
 			      CONN_REASON_SCO_CONNECT);
@@ -1620,10 +1667,12 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		}
 	}
 
-	acl->link = sco;
-	sco->link = acl;
-
-	hci_conn_hold(sco);
+	link = hci_conn_link(acl, sco);
+	if (!link) {
+		hci_conn_drop(acl);
+		hci_conn_drop(sco);
+		return NULL;
+	}
 
 	sco->setting = setting;
 	sco->codec = *codec;
@@ -1891,7 +1940,7 @@ static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 	u8 cig;
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.cis[0].acl_handle = cpu_to_le16(conn->link->handle);
+	cmd.cis[0].acl_handle = cpu_to_le16(conn->parent->handle);
 	cmd.cis[0].cis_handle = cpu_to_le16(conn->handle);
 	cmd.cp.num_cis++;
 	cig = conn->iso_qos.ucast.cig;
@@ -1904,11 +1953,12 @@ static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 		struct hci_cis *cis = &cmd.cis[cmd.cp.num_cis];
 
 		if (conn == data || conn->type != ISO_LINK ||
-		    conn->state == BT_CONNECTED || conn->iso_qos.ucast.cig != cig)
+		    conn->state == BT_CONNECTED ||
+		    conn->iso_qos.ucast.cig != cig)
 			continue;
 
 		/* Check if all CIS(s) belonging to a CIG are ready */
-		if (!conn->link || conn->link->state != BT_CONNECTED ||
+		if (!conn->parent || conn->parent->state != BT_CONNECTED ||
 		    conn->state != BT_CONNECT) {
 			cmd.cp.num_cis = 0;
 			break;
@@ -1925,7 +1975,7 @@ static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 		 * command have been generated, the Controller shall return the
 		 * error code Command Disallowed (0x0C).
 		 */
-		cis->acl_handle = cpu_to_le16(conn->link->handle);
+		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
 		cmd.cp.num_cis++;
 	}
@@ -1944,14 +1994,32 @@ static int hci_create_cis_sync(struct hci_dev *hdev, void *data)
 int hci_le_create_cis(struct hci_conn *conn)
 {
 	struct hci_conn *cis;
+	struct hci_link *link, *t;
 	struct hci_dev *hdev = conn->hdev;
 	int err;
 
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
 	switch (conn->type) {
 	case LE_LINK:
-		if (!conn->link || conn->state != BT_CONNECTED)
+		if (conn->state != BT_CONNECTED || list_empty(&conn->link_list))
 			return -EINVAL;
-		cis = conn->link;
+
+		cis = NULL;
+
+		/* hci_conn_link uses list_add_tail_rcu so the list is in
+		 * the same order as the connections are requested.
+		 */
+		list_for_each_entry_safe(link, t, &conn->link_list, list) {
+			if (link->conn->state == BT_BOUND) {
+				cis = link->conn;
+				break;
+			}
+		}
+
+		if (!cis)
+			return -EINVAL;
+
 		break;
 	case ISO_LINK:
 		cis = conn;
@@ -2173,6 +2241,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *le;
 	struct hci_conn *cis;
+	struct hci_link *link;
 
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		le = hci_connect_le(hdev, dst, dst_type, false,
@@ -2198,16 +2267,18 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		return cis;
 	}
 
-	le->link = cis;
-	cis->link = le;
-
-	hci_conn_hold(cis);
+	link = hci_conn_link(le, cis);
+	if (!link) {
+		hci_conn_drop(le);
+		hci_conn_drop(cis);
+		return NULL;
+	}
 
 	/* If LE is already connected and CIS handle is already set proceed to
 	 * Create CIS immediately.
 	 */
 	if (le->state == BT_CONNECTED && cis->handle != HCI_CONN_HANDLE_UNSET)
-		hci_le_create_cis(le);
+		hci_le_create_cis(cis);
 
 	return cis;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0e0a93cc1218..d00ef6e3fc45 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2345,7 +2345,8 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_add_sco *cp;
-	struct hci_conn *acl, *sco;
+	struct hci_conn *acl;
+	struct hci_link *link;
 	__u16 handle;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
@@ -2365,12 +2366,13 @@ static void hci_cs_add_sco(struct hci_dev *hdev, __u8 status)
 
 	acl = hci_conn_hash_lookup_handle(hdev, handle);
 	if (acl) {
-		sco = acl->link;
-		if (sco) {
-			sco->state = BT_CLOSED;
+		link = list_first_entry_or_null(&acl->link_list,
+						struct hci_link, list);
+		if (link && link->conn) {
+			link->conn->state = BT_CLOSED;
 
-			hci_connect_cfm(sco, status);
-			hci_conn_del(sco);
+			hci_connect_cfm(link->conn, status);
+			hci_conn_del(link->conn);
 		}
 	}
 
@@ -2637,11 +2639,34 @@ static void hci_cs_read_remote_ext_features(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_setup_sync_conn_status(struct hci_dev *hdev, __u16 handle,
+				       __u8 status)
+{
+	struct hci_conn *acl;
+	struct hci_link *link;
+
+	bt_dev_dbg(hdev, "handle 0x%4.4x status 0x%2.2x", handle, status);
+
+	hci_dev_lock(hdev);
+
+	acl = hci_conn_hash_lookup_handle(hdev, handle);
+	if (acl) {
+		link = list_first_entry_or_null(&acl->link_list,
+						struct hci_link, list);
+		if (link && link->conn) {
+			link->conn->state = BT_CLOSED;
+
+			hci_connect_cfm(link->conn, status);
+			hci_conn_del(link->conn);
+		}
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_setup_sync_conn *cp;
-	struct hci_conn *acl, *sco;
-	__u16 handle;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
@@ -2652,31 +2677,12 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 	if (!cp)
 		return;
 
-	handle = __le16_to_cpu(cp->handle);
-
-	bt_dev_dbg(hdev, "handle 0x%4.4x", handle);
-
-	hci_dev_lock(hdev);
-
-	acl = hci_conn_hash_lookup_handle(hdev, handle);
-	if (acl) {
-		sco = acl->link;
-		if (sco) {
-			sco->state = BT_CLOSED;
-
-			hci_connect_cfm(sco, status);
-			hci_conn_del(sco);
-		}
-	}
-
-	hci_dev_unlock(hdev);
+	hci_setup_sync_conn_status(hdev, __le16_to_cpu(cp->handle), status);
 }
 
 static void hci_cs_enhanced_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_enhanced_setup_sync_conn *cp;
-	struct hci_conn *acl, *sco;
-	__u16 handle;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
@@ -2687,24 +2693,7 @@ static void hci_cs_enhanced_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 	if (!cp)
 		return;
 
-	handle = __le16_to_cpu(cp->handle);
-
-	bt_dev_dbg(hdev, "handle 0x%4.4x", handle);
-
-	hci_dev_lock(hdev);
-
-	acl = hci_conn_hash_lookup_handle(hdev, handle);
-	if (acl) {
-		sco = acl->link;
-		if (sco) {
-			sco->state = BT_CLOSED;
-
-			hci_connect_cfm(sco, status);
-			hci_conn_del(sco);
-		}
-	}
-
-	hci_dev_unlock(hdev);
+	hci_setup_sync_conn_status(hdev, __le16_to_cpu(cp->handle), status);
 }
 
 static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
@@ -3834,19 +3823,20 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (conn->type != ISO_LINK || conn->iso_qos.ucast.cig != rp->cig_id ||
+		if (conn->type != ISO_LINK ||
+		    conn->iso_qos.ucast.cig != rp->cig_id ||
 		    conn->state == BT_CONNECTED)
 			continue;
 
 		conn->handle = __le16_to_cpu(rp->handle[i++]);
 
-		bt_dev_dbg(hdev, "%p handle 0x%4.4x link %p", conn,
-			   conn->handle, conn->link);
+		bt_dev_dbg(hdev, "%p handle 0x%4.4x parent %p", conn,
+			   conn->handle, conn->parent);
 
 		/* Create CIS if LE is already connected */
-		if (conn->link && conn->link->state == BT_CONNECTED) {
+		if (conn->parent && conn->parent->state == BT_CONNECTED) {
 			rcu_read_unlock();
-			hci_le_create_cis(conn->link);
+			hci_le_create_cis(conn);
 			rcu_read_lock();
 		}
 
@@ -5031,7 +5021,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (conn->out) {
 			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
 					(hdev->esco_type & EDR_ESCO_MASK);
-			if (hci_setup_sync(conn, conn->link->handle))
+			if (hci_setup_sync(conn, conn->parent->handle))
 				goto unlock;
 		}
 		fallthrough;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 74117df03a3f..34d55a85d8f6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1657,8 +1657,12 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 		/* Check if LE link has failed */
 		if (status) {
-			if (hcon->link)
-				iso_conn_del(hcon->link, bt_to_errno(status));
+			struct hci_link *link, *t;
+
+			list_for_each_entry_safe(link, t, &hcon->link_list,
+						 list)
+				iso_conn_del(link->conn, bt_to_errno(status));
+
 			return;
 		}
 
-- 
2.39.2

