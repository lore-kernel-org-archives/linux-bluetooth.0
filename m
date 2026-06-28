Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99E3A6418;
	Sun, 28 Jun 2026 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652844; cv=pass; b=HdaG9oknLtNf9atbhcxIrn0ZmJwpopG9Wzz62PJKdwCCCTaNVi7zKr5WTfV5LXPye8g/57Sat8Bkcy8/evQbOjtWH8nn+1Bqs/wOjvMs77ck59MM5ufQguwxDlyGH6YA/Ma7eEKvJe9mlbDhDmmv8zCvmdjBkn9vKq2tnmsrCrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652844; c=relaxed/simple;
	bh=AP/V99rpXy5MRBYg/dAtuY+INiijBU0lyet2/mpWey4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqswnoQN+fpLQHBHvrwqY2bUetC27/qE1cnsKFaTCBfhuNMA4jHBKj0txgh4X4L8R4mF95dxPTXrbUEPZSwZ/T9vr7tPIM1UQvvV/gdjr9I5wnFJAGAedxLabwLVgrMhUdPqEqVgY1gRPoSORRo7qKwzBaiW6GEGz0BF8xZK40E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=baFSV0nx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="baFSV0nx"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp95N1RPczytg;
	Sun, 28 Jun 2026 16:20:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782652841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnoiwwH9jZ3IwfMueT8vBcEF3Xw3XRXp5669KzTN1/w=;
	b=baFSV0nxhWEROzK2vhc+UQsZuyjeBxEwxGijHcj3yiWkc4ocFXZZIaODGG3cVDP/AhwWEY
	nt4jNPyW4Mk8eTY+AhCp/jV93UZbxNdDN7BrabYnsT8TzeKNZdFYV+lA06Y4MxBPkmUBLP
	th7DyyzFNzDCKMfygnk1Kxiahbl+loM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782652841;
	b=gJ+3gtSnogmUpn3DHvTJZi8vc51c5fZ8cPP4Ly8YSw74thDOJLB5Azq/njXcxTaadJi4sW
	YCNmNr5bnwKb8hCRHOXU2Oy/tQSVSbI882tZMmXwvQwAPNqvw8WhKippNZe0QTDAMFKLGE
	m1Ev3ubAIUU+EcjgNWWoCnppL1YgUgw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782652841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnoiwwH9jZ3IwfMueT8vBcEF3Xw3XRXp5669KzTN1/w=;
	b=Wkis/6U75Booe/ONY+iNTGcK4BLJHhVlpFWZQcO3M0kgEcF0mcbdzhyP3p34SdhiZaeq+F
	YNP7tuYrA2K1HCZAIGJ3WWGttOrinQtNQfN8rFFPhWcvadt8AuN0lexiTG4lYdunkdic3+
	8pxdTKFwLIJkn4peX82DtHrmKpk3yGk=
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
Subject: [PATCH v4 2/7] Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
Date: Sun, 28 Jun 2026 16:20:27 +0300
Message-ID: <0ec91c6904681af89011633ff81d31c46b0eac82.1782652695.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782652695.git.pav@iki.fi>
References: <cover.1782652695.git.pav@iki.fi>
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
    v4:
    - no change
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

