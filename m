Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A865436370
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031603; cv=none; b=O+sqNIkiMVyeAH/yXtEBQ/g420vntcx1BBmJT3wBY0lFK8TjsOQv8m2gKG0SWlnZXOis2+z+D1S9IgWMPZOU8Jprki7ZIRX5/uKVPLKUqqwXvT0+fw9HpI/YrouKzjL2dBchWqR5R0UqaWElWfE1cJQdSeOQOjs5ACXeQj8E9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031603; c=relaxed/simple;
	bh=Klan+JpQofgatmFDaGZVn6dWbouq2dVqTawTvklkFS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eduI0foM5aIpXIZq6xw4tm7ZlVmvzhaQJLB8UFcmEIdUds4ESN4w7tSzvVMjIN0/W9lTwWN9n9lBL+dQD+bm1f0NqSmFdSQMNZNU9zpAHPii/+PNYAxHvAinnA0ehoeGK/qi1CugJkrU/Iurq/tK9kJWLGUJmalm9b5byKnBXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXAbiMaw; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXAbiMaw"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7927261a3acso3865227b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 13:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769031595; x=1769636395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9iTd+Dc1IIHPAGZpIenO/tIsk+buVlc+vnEgzjy0uw=;
        b=fXAbiMawQgRJ8eEgnBqvQLx940OF97NOuxOsk4vu7wWNPxlxoF0KFLVeYFTE8CsIq9
         Loo6OK5u/EOFPrsT24W2swvryX1MWXCsTtVZEoTvrzzzFUBnQFtf+imDCydX/t4SltYR
         9rC65/pr5dmgkmTlId68yM0ewvhMzH3+mqONg9p+cLQfrblguGmgbsgU11uuw68iiTKO
         zPpm+DYurQ4yYapm7BT+InOamkbh0FH5cdxWNyQdIOBjOBsAqTKi2ijr5VWIEDlsKTW9
         Lrr1Ic5oeFdYNd9YFox0XLVl/i5ST6mhsEvH18EbfCn4JD0Lua+cCSZPqLRGReasKkN4
         0oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769031595; x=1769636395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9iTd+Dc1IIHPAGZpIenO/tIsk+buVlc+vnEgzjy0uw=;
        b=PvFcGD8ZlyOjhTZQmY9+fj9PXPvHF+0XlVPZBQyK+T9k811yT4d30yEf5wlapL2RC9
         7p7DnzwQvNIC7NwMQ2lSp1MkDZD/HXNlcNSRiQ7stxiwv0jXjnmPi3OWuQ6lTCJtqV6J
         D4uBPXBJAf4YoeNicpUNbKc7Nik5gl2HYaF+6BgKFP33WOEEzk+A3cAiQnFWrLO+kYrZ
         xU+3ymU0uTpoKVobzTKH+trxH80KfllF1AJOiDg8cpX7sYfubDPe1lkvsn1s0VLx41Vr
         vFDHTCAaSwzf1qX0QZps5PkfZTqWJTX3C+uwyb9GRt/ABMJOEQsw+GP+/0NbjBEQAU1m
         uApQ==
X-Gm-Message-State: AOJu0YwhjhH5W4STo4fpruKAJCau2ROEPs4IEgXUCJJwcJEb/lsvqcud
	PECrhBp92C9H5vZaR7sDNKlZSuOkqplxixqGav1qGTkvRTCoZKbeD80uBStOT4Ij
X-Gm-Gg: AZuq6aIUUpU9k4IH0W2sSvYxS0n6g5d0UEVCD4sXEHOX7gStdHOHn/wzuS37kHCt68r
	oComdqerBwA1PPSb/BO1Pp6Q+wtltWY1Z+QhwSrp6jVdzUnkctUznbgqQ9cqRRAkTm79n5F+jEo
	SxUJoAJkdlfFab3L1hP5W9urspbaNdvt0Y0dfTjKZf9M7ywcPQnslTR2gsggvjztpMetZiRKh3X
	sOwiB9afOpT7fhhk0aBZuo+z7HLY56yHxLHNolf/QIGYf5WVczN/WQ/HXDzpCEQUvVRsfRB2jMC
	ghe4ApUUITNQ4yHkbyTOfagif8Hs02RKM9BD50kQSs1eQ2kxLCMtJWONw9z/zEyNe4Y8rXfKa1U
	WbfLjT3ym5/Vmhf2Ffjj9/yqpefXIe7JbFjZOzvKcBZ0Cu5yN6FzCWnV43JwJkjfsGiJzOD3qtv
	j+4M4WF1iTJWS3qdnw3GwmzEY1kA/+9sJwwzQd9k6caRNEr8WAtxeM2/BAG1ZEndeYX4lqcKePV
	Riuww==
X-Received: by 2002:a05:690e:144e:b0:641:f5bc:6990 with SMTP id 956f58d0204a3-64917762772mr14075377d50.76.1769031594671;
        Wed, 21 Jan 2026 13:39:54 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649396c68b7sm3518078d50.6.2026.01.21.13.39.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:39:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
Date: Wed, 21 Jan 2026 16:39:44 -0500
Message-ID: <20260121213944.2686506-1-luiz.dentz@gmail.com>
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

