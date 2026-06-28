Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66E35C1A6;
	Sun, 28 Jun 2026 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648774; cv=pass; b=bW6e9+RszJzmLYlz6lM1ccsgphH1lcPJffLLzJEylaDDSx16vRlhMm2ged45CAOIQ/hDQZVjzlhQIQik6OZyRJoD/nlg+nSF9r8Vi70SpxEx1zqZeF7qRTsYc7H0duBg5mtCf855XOPx9zkscJFLJ3qvsXJ1TU7/QkAYWM3u96w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648774; c=relaxed/simple;
	bh=Tqljn+90qcNTc2+0+pBkJbfNiqxdvBpsDUwo7MquOzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbGugY0GgL/70LBATC8PZz2cW97IgiJ6UO/l5YmC/BzuobGhk/FqXjt+vTbRGa4li8pzt1UP5QkXxx1kSDpyUUgN8onnEpmu2T+SijxQnFWA7fWoQb9A2v8L1m+R4zsim+Ufhi6kzRAqW6Yz0Ts7XOKkg1z3CxwjcOYDOlg9R5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Xwgb7uFD; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Xwgb7uFD"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp7b12111zyZ5;
	Sun, 28 Jun 2026 15:12:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782648766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYlVC4csD37Rqhvb6B0XSNJOK4zv3a5CSC3bITSQYqA=;
	b=Xwgb7uFDNjh2Zhll5av8dLZaGlTsLE9+ytSuAwAi/NpgngjXRFSufRF35aGkQ3+dg7soKx
	X1FoBqDZZIMGhDPWG7oJ9G6Qmk+Q3Ab0mSL6fo//3+icHXOLDddktg6TGcS4fmh0PDWOs/
	jF2jz0H8QtVbl78sb6zw9aXXu9DOsIc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782648766;
	b=msyvdG41NYnEBAugaaxt7st1Cv0ZJI4KTzTnFedldZNiXAzKTmRAHepG5ZgiUgRTF+g8ps
	WfnpnmznjKFoyBvBXv6XQ/pmpp35dnRM3pFm6SrZCEC9LBJJ8vLLPzs1SfBlr6i3xtQIW1
	XRxRjghXJppnUtD55QAFcZKr6HfbLTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782648766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYlVC4csD37Rqhvb6B0XSNJOK4zv3a5CSC3bITSQYqA=;
	b=UVbURGFf9sUHT93sAkpxv8Akn8gLiTy0teKYow5/q0mU9njfb5GnHs9lhU6+S8tHn/av6F
	gO7kfwYPp+BxntfKQm3o0Eo/63vLAVlkCOAlDajHwzMKsdTGdZ27kJLIrkaD4Nm7HhkU7w
	mWCBLZABq7IfwWVJCWa+orC/Go3VLdc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
Date: Sun, 28 Jun 2026 15:12:33 +0300
Message-ID: <0ec91c6904681af89011633ff81d31c46b0eac82.1782645211.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
References: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is theoretical UAF if the conn is freed while the hci_sync task
is running.

Hold refcount to avoid that.

Fixes: 881559af5f5c ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3:
    - split to multiple patches per different Fixes:
    
    hci_conn_get() was added inside hci_le_create_conn_sync()
    in commit 76c2d047410ba, but it is too late to do there as the
    hci_conn_get() itself may be UAF.

 net/bluetooth/hci_sync.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a693259dd3ee..66f42a3dc5a1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7014,12 +7014,23 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 	return err;
 }
 
+static void hci_acl_create_conn_sync_complete(struct hci_dev *hdev, void *data,
+					      int err)
+{
+	struct hci_conn *conn = data;
+
+	hci_conn_put(conn);
+}
+
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
-				      NULL);
+	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync,
+				      hci_conn_get(conn),
+				      hci_acl_create_conn_sync_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -7030,36 +7041,41 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
 	if (!hci_conn_valid(hdev, conn))
-		goto done;
+		goto unlock;
 
 	if (!err) {
 		hci_connect_le_scan_cleanup(conn, 0x00);
-		goto done;
+		goto unlock;
 	}
 
 	/* Check if connection is still pending */
 	if (conn != hci_lookup_le_connect(hdev))
-		goto done;
+		goto unlock;
 
 	/* Flush to make sure we send create conn cancel command if needed */
 	flush_delayed_work(&conn->le_conn_timeout);
 	hci_conn_failed(conn, bt_status(err));
 
-done:
+unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
+	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync,
+				      hci_conn_get(conn),
 				      create_le_conn_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.54.0

