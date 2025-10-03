Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB142D8DA7
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511354; cv=pass; b=rp20bAG6ph5HbYv3K8qxeXzZ+8WtYevoXp65cpIKvqSnwZT4lya9ccJJqPtv/eNV6kWofhKV+rebIOPVRGoa1AEJwF0CJp9Fb7bE8ZGBzVcmi+hUE3wRubISvXli26lmzy6Q0GfvLPT1TxhDqmg+Au4iMZmSGmII9MUKSV6eg0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511354; c=relaxed/simple;
	bh=Jy4IttjxJPEl9KpUw4kEH/+boGUGt1oeP/nVS2iIXhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb6G5hwEBrN50TuChWOkKVY6Kg/Eq3CouLDbZIDJHdRyBG0DMF3YqU5/5vzsIC5iV4dPTsPGG+1FqbnBUN8NNveJ7R+kgN/WXHxAmH9fMUfItQHpByifYjl/8vrw9eyaKqL894t//i9a3cn4P4KgV0/W+CwospzAD0jhx7KuMAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GXqC66HZ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GXqC66HZ"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cdZrY0xRYz10BK;
	Fri,  3 Oct 2025 20:09:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759511341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacZwXiYX9lq6QfwdaUPn8mRnjzRxH5qyHXxQhdZdNw=;
	b=GXqC66HZz0lMrG91cjW5z8sRLroePCJLls4F7wV5KkyGflpNZyheGQObva9GlcZO6RDzgU
	l5lAgsMnpclCnmIabVOg++YqtWB7p8TDNuCTZkuKcNiKXdAjiL3acb+XCfnZ1LAAKISEox
	MHaLV4XgXQko73kPRngKOp8xE8EySp0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759511341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WacZwXiYX9lq6QfwdaUPn8mRnjzRxH5qyHXxQhdZdNw=;
	b=HGevIH1ewbY7d9upsXA+R+RGvZDJasC/ccWBdkH8bmQNdHKJ4bYoD6hKydrMlxzC2kdI8Q
	5zMKADZA5usY07OXuHdMJ9BaPpXyk1KmScuf00Nl8ibe/V9cxtuqenblmzR64fWf7/aqX8
	JGyRi1LKEx7YK2ryrcTCnfTKNoBgOSU=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759511341; a=rsa-sha256; cv=none;
	b=NOj2HEwABDMWGg5LccDaWiPEnOS7PzaFgCuH3mKaZXMN+a9yYueVtvMHKdMlZI+4qp9aDi
	k94ygwt570+i5Tf3i0r5nK0ADZLbpCCTMselqMJOZDSeyByX6D/RyOtbdMRAhvTW+wJWZu
	aT1v0aG7vW977LS2r5T9KZNjzvIQnOs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 7/9] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
Date: Fri,  3 Oct 2025 20:08:50 +0300
Message-ID: <af365be23583fb8060f03af477cea24fdcd8f5d6.1759511032.git.pav@iki.fi>
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

hci_cmd_sync_queue_once() needs to indicate whether a queue item was
added, so caller can know if callbacks are called.

Change the function to return -EEXIST if queue item already exists.
Modify all callsites to handle that.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1764f61fc520..c5a618b30131 100644
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
@@ -6954,8 +6957,11 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
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
@@ -6991,8 +6997,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
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
@@ -7150,8 +7159,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
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
@@ -7213,6 +7225,9 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 
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

