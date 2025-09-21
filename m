Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194022332E
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482097; cv=pass; b=YoTYl7hroyqB7izZUdD9lj5SR7tPt+kRBG3iVxVC6IvsrzKia8PuuFUnu1YDSoXU3Tif1Gm2U8SrNlL6iqkhrlFi+t83+T+AGIeCyd1qEM0DCEu6uNS3Vs2IHp7WXNV5oLUtPviPLDQRKSgfYz0JsaVwzdy5SunTfIt4FebHcwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482097; c=relaxed/simple;
	bh=YSywxIIhkPP/MU51AXNQ20fCOMy3ZHCf4E15e5YSUaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdhN7mbqG3TmWoFgvBPJzKrgUVyN8RZFR1ljUbZ75sF9aqwM2Q0G8Xtjxh9ZqcaCm2H+6Fdz0t+bBbPegqUGHlwVu5K/o8JHkuzvbEpIr5KTk2vA5Xu1y8FaVAKKn30CFovYViTUKe+3eMD5U+q895W/fWSlAFHr3P8L49spGk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=bTZCVaz/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="bTZCVaz/"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCC1g89z107f;
	Sun, 21 Sep 2025 22:14:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NS2y/wzJ8rvyv1b78MGY3BGT9sCcJH6GwjqD/8KYLVI=;
	b=bTZCVaz/swa88z0e3sfntfOdkRpFcCfZ9+A40ZFDKrt3Ci0pM7m9IM1QIEHeY6kt3QwNGH
	PgauGKzOH9Wz/f+6lR9DGeCR2+iGCRzsxdP666qcDe6aosZejCqb8+Yhol6cDuPFCNK+EO
	EJL9UYXpJW8NwVEKfdEXujdUjGvOxzQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NS2y/wzJ8rvyv1b78MGY3BGT9sCcJH6GwjqD/8KYLVI=;
	b=rLqbS/XOuab5nZb7tGDgErJXVQ0zkBXOc+hnuiWbHbTXTCdk80+R+2wlIFSnYm/3LSk/jD
	GF6taJGmn1AaxRzo00ubYWXHnvnmoVmQEvaA616LjMs3jUTI98KscZ1xEivrHOq7Mc697/
	ru71S1fCy5Ono5i6B+/1zfCiAqEOook=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482087; a=rsa-sha256; cv=none;
	b=ylW80Tqaw5d/bDRMT92J2ub9XtjapZMTc7Wc/zd1NezdplNKUhxoMx0p2OGwI+79WcaALI
	3sQ0zHfodHG0FNlC/QZgADJQH3ygAeOcgPUFEVcE3h13zKUMMABjfB42dL/dIaauscXiVN
	OMHt8fm6gG00r6hDx4m99g7XluYPZUE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 04/24] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
Date: Sun, 21 Sep 2025 22:14:19 +0300
Message-ID: <5dc5f5691f7a8fb6a79f607caaefcdb2c9a734cd.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_queue_once() needs to indicate whether a queue item was
added, so caller can know if callbacks will be called.

Change the function to return -EEXIST if queue item already exists, and
modify all callsites to handle that.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 78af430be381..64e26fbf1543 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -780,7 +780,7 @@ int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			    void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
-		return 0;
+		return -EEXIST;
 
 	return hci_cmd_sync_queue(hdev, func, data, destroy);
 }
@@ -3255,6 +3255,8 @@ static int update_passive_scan_sync(struct hci_dev *hdev, void *data)
 
 int hci_update_passive_scan(struct hci_dev *hdev)
 {
+	int err;
+
 	/* Only queue if it would have any effect */
 	if (!test_bit(HCI_UP, &hdev->flags) ||
 	    test_bit(HCI_INIT, &hdev->flags) ||
@@ -3264,8 +3266,9 @@ int hci_update_passive_scan(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return 0;
 
-	return hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
-				       NULL);
+	err = hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
+				      NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
@@ -6910,8 +6913,11 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
-				       NULL);
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
+				      NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
@@ -6947,8 +6953,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
-				       create_le_conn_complete);
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
+				      create_le_conn_complete);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -7106,8 +7115,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
-				       create_pa_complete);
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+				      create_pa_complete);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
@@ -7169,6 +7181,9 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
-				       create_big_complete);
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
+				      create_big_complete);
+	return (err == -EEXIST) ? 0 : err;
 }
-- 
2.51.0

