Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548119995E
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550086; cv=none; b=D0Jf5oFgykkFcjzkm7ugflcO/Qzy+XQyTqjlkTnqF+dQraIiLBQ1I5Lsyg2piGPu9QVo+fDGpnUwLesruYg591QXLTX4A/BU0fQ9aVps/mwG9MW03//S26lU/0xe37SztivI/qO5E7tBu6qC5gDBgma65SM99FmKnb0Dw5Lvxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550086; c=relaxed/simple;
	bh=0GMNz6Lzo0O+4w6YB5l4mGMRnmjFQFBseyny+6cG8JM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0aIik42VBbTE/CmSEZCPBCHbh9lslRO/IMlkWYFHl68b/MBbTskbM0wqnKkOm2k+vLKjNTC5/KXnNQ/1aXn9NNJnSfOr2gfR+nXvc+ytYaJVC52EIvC365IHVsa4ExbRb/B7NTwKqhIFvsCt4WIIiyI3mVe/mP8lOG9JDYIwcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS4wgPRp; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS4wgPRp"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-53b17498109so1619044e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755550083; x=1756154883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f773MTCsDkxYVSB4zhokCXc/Rip0xf0fM0YLkB6AI38=;
        b=mS4wgPRp+gxE747XIvv25yGd93262vU2/3pHkSRwNtDKCOsRf1Q8SAbNUe8jWOsru8
         j35fQc9NK381Tp4coDJ4wN7CGSW78gJG3NUUxvFd2T6POb+Pv1ADJ8VYAyij9zAD3Rb0
         TvVuZ2JtlPxkgmx0sElR9oVYnsPKVsCg0HxkNvCx3eE9GbXz+bUnzkfYMJrkmk0OykC8
         h9K3NdRU8w4txMjOefWx0gdyzhiqYcseF3I0NukCZGuuBk/hE3SSA4uK1+aMR3gGsia8
         OANGNwAd/9k/GLJeAvPMDGGzXgLs1l8MYYHEU+Abp7IouXx41m89XhWq6XLZ+N4aDStL
         ffmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550083; x=1756154883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f773MTCsDkxYVSB4zhokCXc/Rip0xf0fM0YLkB6AI38=;
        b=gnCqZDX4JEiKQbxFU1FRbcggltKCsYFHZWl5RLNxsDI4Qg/OWSai7Os3I+Cr3pd7tA
         7+semxSAINrJsmoGMUN0jsS8HWnomW/uJphD2cfxejLGfQ4mAiqKI2ZLJMexOZR/Bkkq
         VweYgOq/KB9qRbL4ucH3/N9N4PI3fRWv0Zervtoqjo5/BOgANUX1c2FjtXdDfRrdxd6h
         H3pH0NqVs34kYcsBM5na9iBzUEryq9OCUQ2VxDD+2TFnk2ANiFmKXBO7qe22WST1G9zg
         Uqs/oIT89GjAELavP6uxlCrnLkBdBhpQ2ixfBhWGnmp3v4Bk0/p3/9r3yjZPCP3egfDO
         ybhA==
X-Gm-Message-State: AOJu0Yy6CfuniP9+7KWWLmPjQ7IRyAbbm0m5NOnU3eslnGAsrbGvGDZn
	M1ecrs6VIS1DZKiXVDQszij5C6kRp7ev+bzttBmkYrz5rIK/GQlIuQ/HnjoHqtmG
X-Gm-Gg: ASbGncuaAUBVRYazeGM5EamMdoE6o6oIrtBThfpXQaKcER7JrTvmL1GV+zmXASrTxEJ
	hIQ9gkOeo/zwAZzVQs9mmmQZKKXKuP9Ls/Xj8cZtI3ZKl4+UCJ9v4JDUIts+a8qZ8NoX0gQMun1
	sc7iXn5i5cEX4LqfGgf7n5rTkqXvsdZzKeOQjIy5YPyWXVzm4BU+/ghwduQX8yBHVH2LuX5oWeW
	0EV5aQfZ/BMN0ptigGSZjh0qe00mtFE8jdqkgRZ3COumCMg2HovP5IqTizPQfPyG0/54n9yH+OA
	O6bz83fuy3PA+CVXm3iBQ7QjZ5rEP9GBgRxiS0bDV80T8/wx8QWSlk8YEjw3chq+D0VyeZA5YVr
	FuNVFL8LNQp9Q+kaP717DWk59wA1oDP1cf1KzF15CBnvfU76EqkrRtRenWU+q28oF0FwvkYXKzW
	A=
X-Google-Smtp-Source: AGHT+IGUHXJVOhY4uHuWEGEbulvdm7g4wSP62Cry7h7zpVdmVwQ1S48Eyqdwsz2JwuAqvHQD9RQskg==
X-Received: by 2002:a05:6122:65a3:b0:537:3e51:eb98 with SMTP id 71dfb90a1353d-53b5d315d5dmr67123e0c.12.1755550082658;
        Mon, 18 Aug 2025 13:48:02 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd553casm2101079e0c.2.2025.08.18.13.48.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:48:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/8] Bluetooth: hci_conn: Convert instances of BT_DBG to bt_dev_dbg
Date: Mon, 18 Aug 2025 16:47:47 -0400
Message-ID: <20250818204753.1203949-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818204753.1203949-1-luiz.dentz@gmail.com>
References: <20250818204753.1203949-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This converts instances of BT_DBG to bt_dev_dbg when logging to a
specific hci_dev this is preferable since it does prints the name by
default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 63 ++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 111f0e37b672..9b23865244b4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -177,7 +177,7 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	/* When we are central of an established connection and it enters
 	 * the disconnect timeout, then go ahead and try to read the
@@ -202,7 +202,7 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_add_sco cp;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
@@ -225,8 +225,9 @@ static bool find_next_esco_param(struct hci_conn *conn,
 		if (lmp_esco_2m_capable(conn->parent) ||
 		    (esco_param[conn->attempt - 1].pkt_type & ESCO_2EV3))
 			break;
-		BT_DBG("hcon %p skipped attempt %d, eSCO 2M not supported",
-		       conn, conn->attempt);
+		bt_dev_dbg(conn->hdev,
+			   "hcon %p skipped attempt %d, eSCO 2M not supported",
+			   conn, conn->attempt);
 	}
 
 	return conn->attempt <= size;
@@ -522,7 +523,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_start_enc cp;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	memset(&cp, 0, sizeof(cp));
 
@@ -543,7 +544,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	if (!link || !link->conn)
 		return;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	if (!status) {
 		if (lmp_esco_capable(conn->hdev))
@@ -562,7 +563,8 @@ static void hci_conn_timeout(struct work_struct *work)
 					     disc_work.work);
 	int refcnt = atomic_read(&conn->refcnt);
 
-	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));
+	bt_dev_dbg(conn->hdev, "hcon %p state %s", conn,
+		   state_to_string(conn->state));
 
 	WARN_ON(refcnt < 0);
 
@@ -586,7 +588,7 @@ static void hci_conn_idle(struct work_struct *work)
 					     idle_work.work);
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("hcon %p mode %d", conn, conn->mode);
+	bt_dev_dbg(hdev, "hcon %p mode %d", conn, conn->mode);
 
 	if (!lmp_sniff_capable(hdev) || !lmp_sniff_capable(conn))
 		return;
@@ -646,7 +648,7 @@ static void le_conn_timeout(struct work_struct *work)
 					     le_conn_timeout.work);
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("");
+	bt_dev_dbg(hdev, "");
 
 	/* We could end up here due to having done directed advertising,
 	 * so clean up the state if necessary. This should however only
@@ -774,7 +776,8 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 	struct iso_list_data *d;
 	int ret;
 
-	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, conn->sync_handle);
+	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big,
+		   conn->sync_handle);
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
@@ -820,7 +823,7 @@ static void bis_cleanup(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_conn *bis;
 
-	bt_dev_dbg(hdev, "conn %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	if (conn->role == HCI_ROLE_MASTER) {
 		if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
@@ -1141,7 +1144,7 @@ void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
+	bt_dev_dbg(hdev, "hcon %p handle %d", conn, conn->handle);
 
 	hci_conn_unlink(conn);
 
@@ -1466,8 +1469,8 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 
 	params->explicit_connect = true;
 
-	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
-	       params->auto_connect);
+	bt_dev_dbg(hdev, "addr %pMR (type %u) auto_connect %u", addr, addr_type,
+		   params->auto_connect);
 
 	return 0;
 }
@@ -1619,7 +1622,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 		goto done;
 	}
 
-	BT_DBG("requesting refresh of dst_addr");
+	bt_dev_dbg(hdev, "requesting refresh of dst_addr");
 
 	conn = hci_conn_add_unset(hdev, LE_LINK, dst, HCI_ROLE_MASTER);
 	if (IS_ERR(conn))
@@ -2167,7 +2170,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn = data;
 
-	bt_dev_dbg(hdev, "conn %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
@@ -2349,7 +2352,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 /* Check link security requirement */
 int hci_conn_check_link_mode(struct hci_conn *conn)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	/* In Secure Connections Only mode, it is required that Secure
 	 * Connections is used and the link is encrypted with AES-CCM
@@ -2389,7 +2392,7 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 /* Authenticate remote device */
 static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	if (conn->pending_sec_level > sec_level)
 		sec_level = conn->pending_sec_level;
@@ -2424,7 +2427,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 /* Encrypt the link */
 static void hci_conn_encrypt(struct hci_conn *conn)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	if (!test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags)) {
 		struct hci_cp_set_conn_encrypt cp;
@@ -2439,7 +2442,8 @@ static void hci_conn_encrypt(struct hci_conn *conn)
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 		      bool initiator)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p sec_level %d auth_type %d initiator %d",
+		   conn, sec_level, auth_type, initiator);
 
 	if (conn->type == LE_LINK)
 		return smp_conn_security(conn, sec_level);
@@ -2523,7 +2527,7 @@ EXPORT_SYMBOL(hci_conn_security);
 /* Check secure link requirement */
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p sec_level %u", conn, sec_level);
 
 	/* Accept if non-secure or higher security level is required */
 	if (sec_level != BT_SECURITY_HIGH && sec_level != BT_SECURITY_FIPS)
@@ -2542,7 +2546,7 @@ EXPORT_SYMBOL(hci_conn_check_secure);
 /* Switch role */
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p role %u", conn, role);
 
 	if (role == conn->role)
 		return 1;
@@ -2563,7 +2567,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("hcon %p mode %d", conn, conn->mode);
+	bt_dev_dbg(hdev, "hcon %p mode %d", conn, conn->mode);
 
 	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
@@ -2589,7 +2593,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 	struct list_head *head = &hdev->conn_hash.list;
 	struct hci_conn *conn;
 
-	BT_DBG("hdev %s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	/* We should not traverse the list here, because hci_conn_del
 	 * can remove extra links, which may cause the list traversal
@@ -2732,10 +2736,10 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_chan *chan;
 
-	BT_DBG("%s hcon %p", hdev->name, conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	if (test_bit(HCI_CONN_DROP, &conn->flags)) {
-		BT_DBG("Refusing to create new hci_chan");
+		bt_dev_dbg(hdev, "Refusing to create new hci_chan");
 		return NULL;
 	}
 
@@ -2757,7 +2761,7 @@ void hci_chan_del(struct hci_chan *chan)
 	struct hci_conn *conn = chan->conn;
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("%s hcon %p chan %p", hdev->name, conn, chan);
+	bt_dev_dbg(hdev, "hcon %p chan %p", conn, chan);
 
 	list_del_rcu(&chan->list);
 
@@ -2776,7 +2780,7 @@ void hci_chan_list_flush(struct hci_conn *conn)
 {
 	struct hci_chan *chan, *n;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	list_for_each_entry_safe(chan, n, &conn->chan_list, list)
 		hci_chan_del(chan);
@@ -2937,7 +2941,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	if (conn->abort_reason)
 		return 0;
 
-	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
+	bt_dev_dbg(hdev, "hcon %p handle 0x%2.2x reason 0x%2.2x", conn,
+		   conn->handle, reason);
 
 	conn->abort_reason = reason;
 
-- 
2.50.1

