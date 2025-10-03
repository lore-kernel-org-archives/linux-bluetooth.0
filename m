Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE22D8DA3
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511354; cv=pass; b=hg0Ali27XoQiShVClO5kI9bsMnZHgb/xGyK+D7VgSq0gQ9te2cEjpt8w1tDKAgBcirLM0NC8xuQNiQro/iruUM600u3BYYBYO3VHT8gFO4tTP1VC4nTal7GNQ9213qt7EOsi2UW6BMuBdu5MTKHwFdabWYUhbNILyA5mIPzpZpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511354; c=relaxed/simple;
	bh=nBDdp6W36jqff+p4De6X620mf5ZkxiT1+hwTluYiffI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVt0k5WOi5vppqs9fEzK+1nuW0LaMruGHebFiEHo5N2J2XGbAQZsB5bkdWyC9JicvzrWJZKva62gOMlmXfmoVyjTPRpJ5ubzpanLqmSiIHmHOPZFZgV0Jbf48fp6+plAg9PZH+gbTql19hMHz/I2dSxOE7s9zPxPvWDKHSRo6UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nk0erPTW; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nk0erPTW"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cdZrX6S29z10BH;
	Fri,  3 Oct 2025 20:09:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759511341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpNY/35KpAMkA77dJzjufTjsC1KNZWcwDuCssy1kjbE=;
	b=nk0erPTWI9niL/DCpg473F3ue9k/hdy4eKNUJNr47L3Dq7ff8HH2v/S7R31HT5hGYsjL6J
	ee2iVLVPxcMbS4BDucuJ6JQpkY0JGfwsfgjIswa4mRL1HNrM+SwqWUR6E005Kxq23LjVKb
	Gk41EwCbQq3rZGPG95m/tM7J1ERG7+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759511341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpNY/35KpAMkA77dJzjufTjsC1KNZWcwDuCssy1kjbE=;
	b=YJ8eTlJCppQzQAVRluWPOSMQ5k9vC3rsYrn/FFV6/bTx5J+sRtJkyerlXivVDVs3L3kejB
	xs8XJRL9fVKQuAiScbX3M2wGbbzkOGseUeSFaULX+SMyvTj9A8VvTB4+xnXSGyhtZfKt8o
	ROmVY/YdBHn3D1Fc57DfxF4puSH8P+Y=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759511341; a=rsa-sha256; cv=none;
	b=Kgwvncc6dYQzwtKlW8ekCoGCiQFIfen8imRwtCEq2vopy2stFPy1TUsnNhzGNRsr6cvh6D
	LW+kaW6gjlcFr/xH0W1tGl5DxulLhSG+1MwNpbFobU/2Yq3rlhg/bOA2bVrjtehW3mUvc8
	wnpNUJ/BKhvptB70OFe9RONA1izvizM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 6/9] Bluetooth: hci_sync: make hci_cmd_sync_run* indicate if item was added
Date: Fri,  3 Oct 2025 20:08:49 +0300
Message-ID: <2764d5a03e98718b6208fa4082d42ac86dda697b.1759511032.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759511032.git.pav@iki.fi>
References: <cover.1759511032.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_run_once() needs to indicate whether a queue item was
added, so caller can know if callbacks are called.  Change the function
to return -EEXIST if queue item already exists.

hci_cmd_sync_run() may run the work immediately. If so, make it behave
as if item was queued successfully. Change it to call also destroy() and
return 0.

Modify all callsites vs. the changes.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c |  4 +++-
 net/bluetooth/hci_sync.c | 13 ++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index af17884fdf75..10dba0cac78b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2936,6 +2936,7 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
+	int err;
 
 	/* If abort_reason has already been set it means the connection is
 	 * already being aborted so don't attempt to overwrite it.
@@ -2972,7 +2973,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
 	 * already queue its callback on cmd_sync_work.
 	 */
-	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bf68da42e664..1764f61fc520 100644
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
2.51.0

