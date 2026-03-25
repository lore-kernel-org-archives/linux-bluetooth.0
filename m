Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023C405ACD
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460077; cv=pass; b=ZiknwX9+2OcOKLNObTZv7yJTdROfAwlXWpj0lr0fZXdnGP+1aAgcDV2sOHxyzt530KnSdMMk+2AIvLjKr6x3mhkvXSn4g5nFEiN0QUvnKs3e1p/BvxzD22H1ifr7fjbTNdIeVyFRE/iqa7eDZg2VmLgbhknz6nDVnxNhq4+JCBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460077; c=relaxed/simple;
	bh=471cp833IJUoSCBKWIGWCkYEaX5cyhzjdqQJpnmxs5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/OJjUSZ+RkT3of16RyUZTe/rd8GSEXW1GfK9iuXqGnS5PD9O0eFtwB3hVjwVgWCy2UogsozB44xWYtXoQdcwuvzswiY3Q0MzaF6PK3AT76EmLZel+HayaZP0cDvJz8gTlimeJGVkdwK5OndTu63nP4t3uP2apl1sQe/a/hl3Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=EEjHaNje; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="EEjHaNje"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fgvD86vz7zyw4;
	Wed, 25 Mar 2026 19:34:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774460073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+WXHcJrZOty6QsvKx2jfC+io1vqFgb4+nuboaFKqo=;
	b=EEjHaNjeLKhfJ0Q9Xpq/nkZwNn5T6AmmEhpndosg0SRpWp+1RzMi6OjlDWhHqhfqMhMsWZ
	Y1M5ykm2mJItGVXHgPuh6DoAefg6lSFYYGG8lzzp9WI49jsTLEMPNFNVGKMRu7z8Iiuh8p
	snPlTsp/Ez5bMQwK1N76hXCni66ieHk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774460073;
	b=VQLE/HX6paX17s++DQzxOxPmiTM1P20WYB9tYrSTwQ1kqWqeAawUMcY7VeCydxVC2ke1GY
	4s+0xq6Pw2WuypzVwtEIy1IppflFuM3WK2t8MPQDgfGO1TG7k9prGs07F05dxSpr7aSBoJ
	xEmszChkc1FUYPp6s+4784hgFzhjSNU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774460073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJ+WXHcJrZOty6QsvKx2jfC+io1vqFgb4+nuboaFKqo=;
	b=xNl0Os/L3+Clk49fwuddztQR71Sl0Rseze4xBUoqS9GQd7O7yC3Yhe6Bf+9fmVmLYaJS+2
	G9NDTWYP2eagYgixmuf7gsREur0bzV+5ABtHsUYXPJfjAreD3T5Nbteru1CFaBzlzzDKfP
	AEBm/4PqUfbB0ojPyPkesbYhYMHp/uw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 3/3] Bluetooth: hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
Date: Wed, 25 Mar 2026 19:34:23 +0200
Message-ID: <1eec5447ed02666ef9463bbc96c25971ce9c0d1f.1774459946.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774459946.git.pav@iki.fi>
References: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774459946.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_run_once() needs to indicate whether a queue item was
added, so caller can know if callbacks are called, so it can avoid
leaking resources.

Change the function to return -EEXIST if queue item already exists.

hci_cmd_sync_run() may run the work immediately. If so, make it behave
as if item was queued successfully. Change it to call also destroy() and
return 0.

Modify all callsites vs. the changes.

The only callsite is hci_abort_conn(), and this changes its return
value. However, its return value is not used except as the return value
for hci_disconnect(), and nothing uses the return value of
hci_disconnect(). Hence there should be no behavior change anywhere.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c |  4 +++-
 net/bluetooth/hci_sync.c | 13 ++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e6393f17576b..8cc2cc58c3f8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3077,6 +3077,7 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
+	int err;
 
 	/* If abort_reason has already been set it means the connection is
 	 * already being aborted so don't attempt to overwrite it.
@@ -3113,7 +3114,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
 	 * already queue its callback on cmd_sync_work.
 	 */
-	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0b28495197c2..47d902310b19 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -801,8 +801,15 @@ int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		return -ENETDOWN;
 
 	/* If on cmd_sync_work then run immediately otherwise queue */
-	if (current_work() == &hdev->cmd_sync_work)
-		return func(hdev, data);
+	if (current_work() == &hdev->cmd_sync_work) {
+		int err;
+
+		err = func(hdev, data);
+		if (destroy)
+			destroy(hdev, data, err);
+
+		return 0;
+	}
 
 	return hci_cmd_sync_submit(hdev, func, data, destroy);
 }
@@ -818,7 +825,7 @@ int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
-		return 0;
+		return -EEXIST;
 
 	return hci_cmd_sync_run(hdev, func, data, destroy);
 }
-- 
2.53.0

