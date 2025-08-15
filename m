Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3C1E2602
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294262; cv=none; b=MvGN5x5OQrRJEhWLcJkSKKEASbXsxKDMaAGagxJ7PzYU2KQM4IYn+c48rkbiMrIdLv7q8PeNsCiq0Ifn8tCUf5d49A60Ot0hxzU3xa4tyanS5s2j7Vqc6RfkvIt7NlZ0V3vQPS4H7wuBfa1qzaJxh4Ym1CN8fUJC03bN3T4logo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294262; c=relaxed/simple;
	bh=a7ljEQOkFzafwjiyXASaWDXkUw3Pfo5lbwKBw234zmQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6z+9ZMXTtvWazC4YbPZ69HJ1tmTxpromaKVdRdVqpA+Yu+H2qOunJDWfTqSBaX1tYhFsUD/GzbmYOjaQ+Ws0PL2Cacgo4AgdXkoRQV95bfTk5Noj20BL1Qy4xeIH/YjlHbwnz2thhQXZi679sdtIXeYVp80o0m6LDVvdLPsB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8oY5BQg; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8oY5BQg"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-53b17531009so839785e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755294259; x=1755899059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2j6sYVlqTrlwEbxIhsSWkq+49gvJlsq19bNpypWRaII=;
        b=T8oY5BQgoh5ZYRimtfMYTftetrJSF4oGRVJDgakiVGsx36MPdHQ+BIL1Vqj9i+ilrH
         eVFuLttzSe0+TzbJ/pzuhT9E3EhlFCEKQh+UO9KJ6LmvabhEeStNa0qV6wiWUBsQkuts
         OVnX1Uc/xWYDLbE53+BMEH1xHzMC1qxASoZcva671N2VQXl5k65rDHjna1pRFsvuMiWE
         L4SK83t+z9WPp5IGwBTVVvNZswgK9WAhpzohbJfz0703YjUjix6W+KaJxx+LAjJlSk7Z
         jyslQgha59AD0mpC+SImhhzKLO39IBENx02FoUmYblkjSzcqGorab49H2EI0OF832eTW
         n3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755294259; x=1755899059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j6sYVlqTrlwEbxIhsSWkq+49gvJlsq19bNpypWRaII=;
        b=E/kzAZvtMQrcoLW4g9dfJ1OpyhfX/HrVZhHyP1UfSR7k/QUGIiX9sBQlV5kpzAJGLf
         N/cZoDlV7I4NDK7pAyl+fxT0M7JoByAifl73EkpGlznLBHdnpKbhfpR8MYeMJn/n2iYU
         lONbSg4KgpJRv1v6B8A2Y5iDsHznP0V3z6rovJSwj33PUTLM7W7p94o9vjuSxd31jTET
         dBzC+7/m843lNq5qy+tswCp0DPCONa47JPAeFkBoy/mzDUJcGX32X9QVq7LUwqVNq/R2
         LVIKbIVD7xUy5bo1tR0/UTE87sJKEQ1gLRJ0jkz+7Vz114zuSgsYHnsIvqyK58QwRGY8
         yRTw==
X-Gm-Message-State: AOJu0Yx9Z0+ZpEfZ/kTzssg8BzpzlHWA0zyWpRrKGXBdKbLINdn+U2ID
	MuCynuf8b3QyMlnqCgdzEBGpsii6ZLd7cFgo/lNJS2PplZS1FCcSPxNfRvmougwc
X-Gm-Gg: ASbGnctgTAIWVlYPHFr/9JtJh9CoSu+EFTQTVG9oOTj1UHDMkdALHDuFDqctAJXqtmy
	KHvx54cpMUBnj39OcTz8M2IoJRIt0Ux8M1eMy9pZKa2lBD5odMzazUR1yWE5Cb+JCudLP+sYyd0
	DjNtt01V5EcTapSzQaVELUntLQc4ob+lrQTQiVSVZoXlJ99sww7/hDjGVE0kKbk99nBbMEilwQK
	rCFwCNXinxR0KY+QGw4pxO/0/6+2dX1yNfky9jBgDrm1FWFnxZpT3pnU4JPNxXmyoYxtNR/zrsq
	1gV+GC1x5Nf01wDxcDgi96xi7ifEG34KHoDAOkcw5KH4nkJRhkTd3MNnD1EkJSuu4jutwy/S37f
	k6dknflZG+/T7NVE6oXV6ohfFc1Ymd4JBkC9rK/FrjR1d8x5E67QLlgHeScgVZRap
X-Google-Smtp-Source: AGHT+IHt7Df/y5R8VdkGnUUGDnPrAfX0B+Eh+xphgLDeTyffPbRGJLP0VE7TdyBHNQY0O4ySoH3lBA==
X-Received: by 2002:a05:6122:1805:b0:538:dbd2:2ece with SMTP id 71dfb90a1353d-53b2b8b2140mr1421370e0c.11.1755294259061;
        Fri, 15 Aug 2025 14:44:19 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2beff1c1sm472053e0c.24.2025.08.15.14.44.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 14:44:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/6] Bluetooth: hci_conn: Convert instances of BT_DBG to bt_dev_dbg
Date: Fri, 15 Aug 2025 17:44:01 -0400
Message-ID: <20250815214406.514260-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815214406.514260-1-luiz.dentz@gmail.com>
References: <20250815214406.514260-1-luiz.dentz@gmail.com>
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
index 7a879290dd28..2cafdc2d6f2b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -179,7 +179,7 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	/* When we are central of an established connection and it enters
 	 * the disconnect timeout, then go ahead and try to read the
@@ -204,7 +204,7 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_add_sco cp;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
@@ -227,8 +227,9 @@ static bool find_next_esco_param(struct hci_conn *conn,
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
@@ -524,7 +525,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_start_enc cp;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	memset(&cp, 0, sizeof(cp));
 
@@ -545,7 +546,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	if (!link || !link->conn)
 		return;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	if (!status) {
 		if (lmp_esco_capable(conn->hdev))
@@ -564,7 +565,8 @@ static void hci_conn_timeout(struct work_struct *work)
 					     disc_work.work);
 	int refcnt = atomic_read(&conn->refcnt);
 
-	BT_DBG("hcon %p state %s", conn, state_to_string(conn->state));
+	bt_dev_dbg(conn->hdev, "hcon %p state %s", conn,
+		   state_to_string(conn->state));
 
 	WARN_ON(refcnt < 0);
 
@@ -588,7 +590,7 @@ static void hci_conn_idle(struct work_struct *work)
 					     idle_work.work);
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("hcon %p mode %d", conn, conn->mode);
+	bt_dev_dbg(hdev, "hcon %p mode %d", conn, conn->mode);
 
 	if (!lmp_sniff_capable(hdev) || !lmp_sniff_capable(conn))
 		return;
@@ -648,7 +650,7 @@ static void le_conn_timeout(struct work_struct *work)
 					     le_conn_timeout.work);
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("");
+	bt_dev_dbg(hdev, "");
 
 	/* We could end up here due to having done directed advertising,
 	 * so clean up the state if necessary. This should however only
@@ -776,7 +778,8 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct hci_conn *c
 	struct iso_list_data *d;
 	int ret;
 
-	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big, conn->sync_handle);
+	bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big,
+		   conn->sync_handle);
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
@@ -822,7 +825,7 @@ static void bis_cleanup(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_conn *bis;
 
-	bt_dev_dbg(hdev, "conn %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	if (conn->role == HCI_ROLE_MASTER) {
 		if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
@@ -1144,7 +1147,7 @@ void hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);
+	bt_dev_dbg(hdev, "hcon %p handle %d", conn, conn->handle);
 
 	hci_conn_unlink(conn);
 
@@ -1443,8 +1446,8 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 
 	params->explicit_connect = true;
 
-	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
-	       params->auto_connect);
+	bt_dev_dbg(hdev, "addr %pMR (type %u) auto_connect %u", addr, addr_type,
+		   params->auto_connect);
 
 	return 0;
 }
@@ -1595,7 +1598,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 		goto done;
 	}
 
-	BT_DBG("requesting refresh of dst_addr");
+	bt_dev_dbg(hdev, "requesting refresh of dst_addr");
 
 	conn = hci_conn_add_unset(hdev, LE_LINK, dst, HCI_ROLE_MASTER);
 	if (IS_ERR(conn))
@@ -2141,7 +2144,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn = data;
 
-	bt_dev_dbg(hdev, "conn %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
@@ -2322,7 +2325,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 /* Check link security requirement */
 int hci_conn_check_link_mode(struct hci_conn *conn)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	/* In Secure Connections Only mode, it is required that Secure
 	 * Connections is used and the link is encrypted with AES-CCM
@@ -2362,7 +2365,7 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 /* Authenticate remote device */
 static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	if (conn->pending_sec_level > sec_level)
 		sec_level = conn->pending_sec_level;
@@ -2397,7 +2400,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 /* Encrypt the link */
 static void hci_conn_encrypt(struct hci_conn *conn)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	if (!test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags)) {
 		struct hci_cp_set_conn_encrypt cp;
@@ -2412,7 +2415,8 @@ static void hci_conn_encrypt(struct hci_conn *conn)
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 		      bool initiator)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p sec_level %d auth_type %d initiator %d",
+		   conn, sec_level, auth_type, initiator);
 
 	if (conn->type == LE_LINK)
 		return smp_conn_security(conn, sec_level);
@@ -2496,7 +2500,7 @@ EXPORT_SYMBOL(hci_conn_security);
 /* Check secure link requirement */
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p sec_level %u", conn, sec_level);
 
 	/* Accept if non-secure or higher security level is required */
 	if (sec_level != BT_SECURITY_HIGH && sec_level != BT_SECURITY_FIPS)
@@ -2515,7 +2519,7 @@ EXPORT_SYMBOL(hci_conn_check_secure);
 /* Switch role */
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
 {
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p role %u", conn, role);
 
 	if (role == conn->role)
 		return 1;
@@ -2536,7 +2540,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("hcon %p mode %d", conn, conn->mode);
+	bt_dev_dbg(hdev, "hcon %p mode %d", conn, conn->mode);
 
 	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
@@ -2562,7 +2566,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 	struct list_head *head = &hdev->conn_hash.list;
 	struct hci_conn *conn;
 
-	BT_DBG("hdev %s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	/* We should not traverse the list here, because hci_conn_del
 	 * can remove extra links, which may cause the list traversal
@@ -2705,10 +2709,10 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_chan *chan;
 
-	BT_DBG("%s hcon %p", hdev->name, conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	if (test_bit(HCI_CONN_DROP, &conn->flags)) {
-		BT_DBG("Refusing to create new hci_chan");
+		bt_dev_dbg(hdev, "Refusing to create new hci_chan");
 		return NULL;
 	}
 
@@ -2730,7 +2734,7 @@ void hci_chan_del(struct hci_chan *chan)
 	struct hci_conn *conn = chan->conn;
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("%s hcon %p chan %p", hdev->name, conn, chan);
+	bt_dev_dbg(hdev, "hcon %p chan %p", conn, chan);
 
 	list_del_rcu(&chan->list);
 
@@ -2749,7 +2753,7 @@ void hci_chan_list_flush(struct hci_conn *conn)
 {
 	struct hci_chan *chan, *n;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(conn->hdev, "hcon %p", conn);
 
 	list_for_each_entry_safe(chan, n, &conn->chan_list, list)
 		hci_chan_del(chan);
@@ -2910,7 +2914,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	if (conn->abort_reason)
 		return 0;
 
-	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
+	bt_dev_dbg(hdev, "hcon %p handle 0x%2.2x reason 0x%2.2x", conn,
+		   conn->handle, reason);
 
 	conn->abort_reason = reason;
 
-- 
2.50.1

