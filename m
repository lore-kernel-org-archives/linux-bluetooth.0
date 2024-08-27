Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE31C2DD2
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767537; cv=none; b=NHGBlr7qugwY6a8nd5Ry/K+PdzUslrZRj3CGTdVZuE/AI8COjUZeryUe749W5IdouLh6CoTB8GW16+BfCyLh/+gwreiAT82TeX8ry6jQoZJaHE6fxY0kd4euFQ3XPovPr4I3E5Xo0HlLb5Xh/Fujj4dQDKwyh86J4KKVPAQQRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767537; c=relaxed/simple;
	bh=tYWiJB3FFvvKY7adclel90QIadRob5gNsZZshXF1U0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/rcinsu9BJqnhehNApPrWqEu7/ZrFQRpduiwgESh9rccNtbB7rEInFHiJVRhYPEeNO31Bm50YM61pr0W3XKVjZIXBD6Dp/HJRZh2YEyqxvFbdoRmzHVhe40noTuDyRogqCxnkCFh6cN8rNnZHglETaJ4UGZDmGHq2++K5oB+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZOepVq4; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZOepVq4"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70949118d26so5354311a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 07:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724767534; x=1725372334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjJdEl5AT6J1BuWbSqMkMF6NiTwobOH4bPxD+wa1/ks=;
        b=cZOepVq4i++JeJlk053B3lp101le9GCPoCysQpFEoNEfQABWlvwZNOzSdxxteQvTbg
         vM+GeDhNHu9ITXLFerFocKjf09MfH3SuaxnJWNZ+cnan6x1IARJFT5PcoDiBQDwoBQsU
         Nh4a2N2Uujow8ORMEX2giqaGFmQbgbreO/sZEKH5Ngd4E95WR0SOV4vnh6jFvEQjkm3r
         KoFIroLVqbMowtiaL3ItjY/nwpme+zC22H1FRUFuT4vB5bGNCWBmjpc4qbf/9mpzv2Ml
         K2/iQwv7ETj9usAuX1nTXz4YMXMiSHydn5cRZSEGMxdxU2cXKUn0ohfQhwaTxtvft11D
         VTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767534; x=1725372334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjJdEl5AT6J1BuWbSqMkMF6NiTwobOH4bPxD+wa1/ks=;
        b=OTzedn3N73QqUbK44PMc+GgHPss3Tysdb43yhCc1CK5nONI7eTY1/YJs82+bKZWI5t
         wUsnDH8XFT1jzlGSCLmaE0OjsxVl2Rsr+0VYLdlNkSfchhvNQlXz6wDmpKO8tNAVcQ1m
         dwV+tmDWuBShI09hY6Nd6gQAhAt98AyHqABZw136ArfMSyNnN/kbSdq3owvBH3/oSqS0
         KiBdCJPYY9zC1/QrT4GbnupNg79QcjP5liG9FAtjtWzwHf+v1WKiG3Hn82cf9xZuCVg+
         HY+rbGhdHQwadzfi67v+rfxEQ1D5vtmu3T3C9W+OxEHUDQWODhZCFiSeRstBExh0xNVL
         dfEg==
X-Gm-Message-State: AOJu0YxxF83zWDF3y/Z6tOVufxV2wt9ipKikqIY2YACOGdaOUB19kmhS
	Z299NgLDXoYxBxWccrfY8aQeofDbklLvTEuIjHDAz0BpaOOmuAyJmgalWQ==
X-Google-Smtp-Source: AGHT+IF2KQSMtTvA9SloH9Z1d+2QQra1aP8w6wTom4xAoJl3IOvvnQ14Gqtj3Ou8YwM8j70cqsovfA==
X-Received: by 2002:a05:6358:528a:b0:1ac:efb0:fb2d with SMTP id e5c5f4694b2df-1b5ebf3abbbmr354655055d.4.1724767533767;
        Tue, 27 Aug 2024 07:05:33 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-498e48f8c7esm1539433137.28.2024.08.27.07.05.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:05:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT
Date: Tue, 27 Aug 2024 10:05:29 -0400
Message-ID: <20240827140529.635522-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827140529.635522-1-luiz.dentz@gmail.com>
References: <20240827140529.635522-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MGMT_OP_DISCONNECT can be called while mgmt_device_connected has not
been called yet, which will cause the connection procedure to be
aborted, so mgmt_device_disconnected shall still respond with command
complete to MGMT_OP_DISCONNECT and just not emit
MGMT_EV_DEVICE_DISCONNECTED since MGMT_EV_DEVICE_CONNECTED was never
sent.

To fix this MGMT_OP_DISCONNECT is changed to work similarly to other
command which do use hci_cmd_sync_queue and then use hci_conn_abort to
disconnect and returns the result, in order for hci_conn_abort to be
used from hci_cmd_sync context it now uses hci_cmd_sync_run_once.

Link: https://github.com/bluez/bluez/issues/932
Fixes: 12d4a3b ("Bluetooth: Move check for MGMT_CONNECTED flag into mgmt.c")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c |  6 ++-
 net/bluetooth/mgmt.c     | 84 ++++++++++++++++++++--------------------
 2 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8f0c9322eadb..d51d8dbea631 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2951,5 +2951,9 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 		return 0;
 	}
 
-	return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
+	/* Run immediately if on cmd_sync_work since this maybe called
+	 * as a result to MGMT_OP_DISCONNECT and MGMT_OP_UNPAIR which does
+	 * already queue its callback on cmd_sync_work.
+	 */
+	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25979f4283a6..59f9d457ca31 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2921,7 +2921,12 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	if (!conn)
 		return 0;
 
-	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
+	/* Disregard any possible error since the likes of hci_abort_conn_sync
+	 * will cleanup the connection no matter the error.
+	 */
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
+	return 0;
 }
 
 static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3053,13 +3058,44 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void disconnect_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	cmd->cmd_complete(cmd, mgmt_status(err));
+	mgmt_pending_free(cmd);
+}
+
+static int disconnect_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_disconnect *cp = cmd->param;
+	struct hci_conn *conn;
+
+	if (cp->addr.type == BDADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+	else
+		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
+					       le_addr_type(cp->addr.type));
+
+	if (!conn)
+		return -ENOTCONN;
+
+	/* Disregard any possible error since the likes of hci_abort_conn_sync
+	 * will cleanup the connection no matter the error.
+	 */
+	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+
+	return 0;
+}
+
 static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		      u16 len)
 {
 	struct mgmt_cp_disconnect *cp = data;
 	struct mgmt_rp_disconnect rp;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_conn *conn;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -3082,27 +3118,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (pending_find(MGMT_OP_DISCONNECT, hdev)) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-					MGMT_STATUS_BUSY, &rp, sizeof(rp));
-		goto failed;
-	}
-
-	if (cp->addr.type == BDADDR_BREDR)
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
-					       &cp->addr.bdaddr);
-	else
-		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
-					       le_addr_type(cp->addr.type));
-
-	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
-					MGMT_STATUS_NOT_CONNECTED, &rp,
-					sizeof(rp));
-		goto failed;
-	}
-
-	cmd = mgmt_pending_add(sk, MGMT_OP_DISCONNECT, hdev, data, len);
+	cmd = mgmt_pending_new(sk, MGMT_OP_DISCONNECT, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -3110,9 +3126,10 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	cmd->cmd_complete = generic_cmd_complete;
 
-	err = hci_disconnect(conn, HCI_ERROR_REMOTE_USER_TERM);
+	err = hci_cmd_sync_queue(hdev, disconnect_sync, cmd,
+				 disconnect_complete);
 	if (err < 0)
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 
 failed:
 	hci_dev_unlock(hdev);
@@ -9689,18 +9706,6 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	mgmt_event_skb(skb, NULL);
 }
 
-static void disconnect_rsp(struct mgmt_pending_cmd *cmd, void *data)
-{
-	struct sock **sk = data;
-
-	cmd->cmd_complete(cmd, 0);
-
-	*sk = cmd->sk;
-	sock_hold(*sk);
-
-	mgmt_pending_remove(cmd);
-}
-
 static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct hci_dev *hdev = data;
@@ -9744,8 +9749,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (link_type != ACL_LINK && link_type != LE_LINK)
 		return;
 
-	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
-
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.reason = reason;
@@ -9758,9 +9761,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	if (sk)
 		sock_put(sk);
-
-	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
-			     hdev);
 }
 
 void mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
-- 
2.46.0

