Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40327FB37;
	Sun,  2 Nov 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100591; cv=pass; b=FeoebexS53p4ziqLov77ouhcVhmi+Pgdj3cHJg7tN6wWQ7Sg3IMA1vWj+s4gtLJmvgWHaNhBguLAHGkEHd69oqu46SKqWIkY2yL66+aXMQaSUUTf7HBZaS51KUPB8Sd/OVN6Y4qrywdn1N33SciwRuTBNDl29MFb6+ohC2GV9ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100591; c=relaxed/simple;
	bh=feCd1Rll9IOJWSQ4ff9DtjV6rbROULO5UoVlOec8REk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXEkLA0xvDRdcN+1eh/V0WsOzRXpgZdMrffoZCyM9hK6BHe284pWXyGTRrSuijxDOQd6garFv4Ytf4K+VFWumLpwJRLquvS1lEgm/dtHj96iz9oDzWpsEcgrl0eApxr4mCM7mSd61rnr0s2KQhYQKButOJuXyEpfByzXSuU/E6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=i8KBa7In; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="i8KBa7In"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d00Pd2VfSz105W;
	Sun,  2 Nov 2025 18:23:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762100582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3A8w4CxIAWNB9uOrOB/CxGjEbP+wZBMGlAPgjry/hHU=;
	b=i8KBa7In0tv8lICL3uIlOLNakxEMbNHVPuDgiP6qP0dbI9IjZxcsG8KavpdCuHQT5CEiBx
	yOVJWlK/7MMn9FmNXVw25IUhNP/JSCPlndS/1wbC5ofx0lZQ065gOYEDIWOIR7ssdDiUYV
	69aA++fGpoIPCmBchPdHj0oSDoc+Nus=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762100582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3A8w4CxIAWNB9uOrOB/CxGjEbP+wZBMGlAPgjry/hHU=;
	b=I+egJTvYmrisybX/GlgvurRsmkC/dkt/bf8RT31gsk6/WukUoLrXSejOXmOOQPy9XzIOgT
	jke2WByk5VRE0rkHaw8FPmKjINO4fA+WweZj6XUnI9AWhffszlhhXcXlfHuzvEY7L5slhY
	8Z5VXzBGaUPx45BJL2VOwW20w4EGnc0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762100582; a=rsa-sha256; cv=none;
	b=j3+AuEDNjCB/+jd0uFv+TBv04sSjsxFobKJu607lEd8SMoziLfycft0KyZMbsNRFzdnq9K
	IksVmYBCpe0jfgzaw4wguk822nK/YeY7musIZkjUy/GTxF+Gsq3poM8uiKWSlADJ9Z3xuc
	Dv7H2cZ3azq7M02EVcs7ftwNofpBvkQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
Date: Sun,  2 Nov 2025 18:19:38 +0200
Message-ID: <5098558edc32358dc58ebf65964c6640b77d9e73.1762100290.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1762100290.git.pav@iki.fi>
References: <cover.1762100290.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_queue_once() needs to indicate whether a queue item was
added, so caller can know if callbacks are called, so it can avoid
leaking resources.

Change the function to return -EEXIST if queue item already exists.

Modify all callsites to handle that.

Fixes leak in hci_past_sync() if command already queued.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - fix also hci_past_sync

 net/bluetooth/hci_sync.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6c4c736cf93a..dc95a1ebe65e 100644
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
@@ -3294,6 +3294,8 @@ static int update_passive_scan_sync(struct hci_dev *hdev, void *data)
 
 int hci_update_passive_scan(struct hci_dev *hdev)
 {
+	int err;
+
 	/* Only queue if it would have any effect */
 	if (!test_bit(HCI_UP, &hdev->flags) ||
 	    test_bit(HCI_INIT, &hdev->flags) ||
@@ -3303,8 +3305,9 @@ int hci_update_passive_scan(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return 0;
 
-	return hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
-				       NULL);
+	err = hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
+				      NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
@@ -6961,8 +6964,11 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
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
@@ -6998,8 +7004,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
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
@@ -7206,8 +7215,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
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
@@ -7269,8 +7281,11 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 
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
 
 struct past_data {
@@ -7362,5 +7377,5 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 	if (err)
 		kfree(data);
 
-	return err;
+	return (err == -EEXIST) ? 0 : err;
 }
-- 
2.51.1

