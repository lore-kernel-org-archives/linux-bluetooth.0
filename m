Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5734D4C1
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450032; cv=none; b=QSDJgA7TWfT+necCpTmE0URzemhlwNmqy7XxD7LGEnqdT4hMYiw/jZKKTKqbBrPDJEh/npjiDbcmheKflbDMysYAiKkgPLhTHuhQ6I47Me+Urts8Lgu3Vjos8yQnuv84tUXqinqrd8mM/jc9FI3eqrcAclBAzlHmUaA6777TpsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450032; c=relaxed/simple;
	bh=Lm4NFbmxhWhxPRnwA/3UqiudUth9O2wxzDg+alt+FuI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PmFA1Wfb5d7JHSZ+c+wFPwaMI4o6GVrkhDZNRx28ejFr97YQ41fN6pAkBG3cWmtXn3m/Scgrbt+QBjj2O8qtxLE5N+p/74QHwwQnxeZroAD4JNRQBtCE+UdXCnuOldoid0iVc0zFMyZ/IhaUH6u74NI1BvUBndWf/yOBkjZHCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAKhRadg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAKhRadg"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790992528f6so45622757b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 09:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769450030; x=1770054830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w6QAQ/7IJJPMK2zTUP8XvMXGkjbycGZBr0MEKirlS+Q=;
        b=gAKhRadgqGzrkhd8tzlc7yVehzYwPNbgEtaR09TSU40b3m1E5nAfvyWlP8nbw4OMEo
         4HApPtK9B4PHnVhnMwyUTZkI1/G6kldwajjuPb3LTsWIQvFnIh3Po6JCAXRaHrnow5zx
         /JtqJdHZB2O6HZ+0w0tYH32fxKKOEEt0b4BP1wDK+XyqhH4Kmsl+EPojXLDg9OK8HUlf
         fdRMcz3fimdhbueYZzXBMWRS6N3GJ+HkmVmEzPH7SlDD2ZveXR526yByBgMMjezI/xEg
         CyrH8YIBEMnKROc4R/FEhv7zsCiREBxh7e6BU2FLoGg9BgPg/n0C/WB3gTvoTVQLmegv
         cMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769450030; x=1770054830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6QAQ/7IJJPMK2zTUP8XvMXGkjbycGZBr0MEKirlS+Q=;
        b=i+v2/TiQ11rt2ac7LVV7yHWKK4XWbReKjgA5loSrpiAzafosKbKK12YHstqSmxD3iq
         UpOrSuw6+FXdyGM0gBzhHKjbQzVTlQqdYTyhhazam2iV7Z9JGEUGqPjOQPTSnyVC/oKc
         RZUTmV56e3HDzblK15xglD0DT5k1VZIWnPehV4QgUfCI78nwDBJ6rvQnui1QgjE/dQ18
         zMjI0hTLXluesJ5dAUG43s7AsEvu2mIEic7QU/4MeML9jp2XkPzIrov4w3O7FsQABpL3
         QzDZyV9ZouEpn/qT2UBIspPeFhm3OhXGCKrIaawJrO5CXFBYxdH0Jj0WnwNtAO/xTO1+
         7Wuw==
X-Gm-Message-State: AOJu0YzbTzKsJjXqEds8KLB1ieHbwJ5nFnjcYL5PZolVy+rqYJTu0Tff
	sC2WfvOIGlv7rdbfzI3Ql2LnntYr1krwzPDMwgvLo+Zl5Evta3Ehc1tR+YeWVaXw
X-Gm-Gg: AZuq6aIPpmpcugjNgNj4ltpi4/fstDSpP88I5IBtuXlZfYroyMKjCSYZVwW9btTtksk
	tktS16OZm7yTQFdbrNmBxJq9oxsiJkpYfqgWOeH1Vqs7/XQS/2v1qO/Kwh/JJeO2GRvjX76pUmz
	dsvQA74e/ZdfZXnwqUH+2XHiWUwGB4NWKv8LYAl0Jv3fpwhJXLy17kYIbTbudpMJw6AltYmL4Ug
	NELSxZlODpq2aaKZ257L502vUZNzC7PW/S+OLwSwrwmfVyVIovc1CoTJ9D3l1A3RvetG0NmF0zG
	MFTxPkZNIEmWelmL2+wK0p0hLFOipzCDBpT00L6tvlJnns96DR4w6OjRarMVdRtVQf35a0KEGkM
	4C+OPnft0eKusv0hFRKaWQmTYN0FTMzNRoe3svRyZ72MM6iJm5gSYtRJiWAKydBOmn172nWUDVh
	/BEqcTyP0jbv4WjpbE5D5nnf1VetgBqevqN++vye8u93DmBM0tVB6Xf/kGAABmlsbK0xF9SiX1M
	iGo0g==
X-Received: by 2002:a05:690c:e3cb:b0:78f:a8cb:6366 with SMTP id 00721157ae682-7945a826f81mr40447907b3.13.1769450030193;
        Mon, 26 Jan 2026 09:53:50 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2a2985sm49961657b3.28.2026.01.26.09.53.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:53:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
Date: Mon, 26 Jan 2026 12:53:40 -0500
Message-ID: <20260126175340.3576865-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to proper track outstanding request by using struct ida
and allocating from it in l2cap_get_ident using ida_alloc_range which
would reuse ids as they are free, then upon completion release
the id using ida_free.

This fixes the qualification test case L2CAP/COS/CED/BI-29-C which
attempts to check if the host stack is able to work after 256 attempts
to connect which would for Ident field to use the full range.

Link: https://github.com/bluez/bluez/issues/1829
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  3 +--
 net/bluetooth/l2cap_core.c    | 46 ++++++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 00e182a22720..ec3af01e4db9 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -655,8 +655,7 @@ struct l2cap_conn {
 
 	struct sk_buff		*rx_skb;
 	__u32			rx_len;
-	__u8			tx_ident;
-	struct mutex		ident_lock;
+	struct ida		tx_ida;
 
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 07b493331fd7..b628b0fa39b2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -924,26 +924,18 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
 				 initiator);
 }
 
-static u8 l2cap_get_ident(struct l2cap_conn *conn)
+static int l2cap_get_ident(struct l2cap_conn *conn)
 {
-	u8 id;
+	/* LE link does not support tools like l2ping so use the full range */
+	if (conn->hcon->type == LE_LINK)
+		return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMIC);
 
 	/* Get next available identificator.
 	 *    1 - 128 are used by kernel.
 	 *  129 - 199 are reserved.
 	 *  200 - 254 are used by utilities like l2ping, etc.
 	 */
-
-	mutex_lock(&conn->ident_lock);
-
-	if (++conn->tx_ident > 128)
-		conn->tx_ident = 1;
-
-	id = conn->tx_ident;
-
-	mutex_unlock(&conn->ident_lock);
-
-	return id;
+	return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
 }
 
 static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
@@ -1773,6 +1765,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (work_pending(&conn->pending_rx_work))
 		cancel_work_sync(&conn->pending_rx_work);
 
+	ida_destroy(&conn->tx_ida);
+
 	cancel_delayed_work_sync(&conn->id_addr_timer);
 
 	l2cap_unregister_all_users(conn);
@@ -4782,12 +4776,34 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	return err;
 }
 
+static void l2cap_put_ident(struct l2cap_conn *conn, u8 code, u8 id)
+{
+	switch (code) {
+	case L2CAP_COMMAND_REJ:
+	case L2CAP_CONN_RSP:
+	case L2CAP_CONF_RSP:
+	case L2CAP_DISCONN_RSP:
+	case L2CAP_ECHO_RSP:
+	case L2CAP_INFO_RSP:
+	case L2CAP_CONN_PARAM_UPDATE_RSP:
+	case L2CAP_ECRED_CONN_RSP:
+	case L2CAP_ECRED_RECONF_RSP:
+		/* First do a lookup since the remote may send bogus ids that
+		 * would make ida_free to generate warnings.
+		 */
+		if (ida_find_first_range(&conn->tx_ida, id, id) >= 0)
+			ida_free(&conn->tx_ida, id);
+	}
+}
+
 static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
 				      struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				      u8 *data)
 {
 	int err = 0;
 
+	l2cap_put_ident(conn, cmd->code, cmd->ident);
+
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		l2cap_command_rej(conn, cmd, cmd_len, data);
@@ -5419,6 +5435,8 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 {
 	int err = 0;
 
+	l2cap_put_ident(conn, cmd->code, cmd->ident);
+
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		l2cap_le_command_rej(conn, cmd, cmd_len, data);
@@ -6907,13 +6925,13 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	     hci_dev_test_flag(hcon->hdev, HCI_FORCE_BREDR_SMP)))
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
 
-	mutex_init(&conn->ident_lock);
 	mutex_init(&conn->lock);
 
 	INIT_LIST_HEAD(&conn->chan_l);
 	INIT_LIST_HEAD(&conn->users);
 
 	INIT_DELAYED_WORK(&conn->info_timer, l2cap_info_timeout);
+	ida_init(&conn->tx_ida);
 
 	skb_queue_head_init(&conn->pending_rx);
 	INIT_WORK(&conn->pending_rx_work, process_pending_rx);
-- 
2.52.0

