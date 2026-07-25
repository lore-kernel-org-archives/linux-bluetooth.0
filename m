Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622F35C181;
	Sat, 25 Jul 2026 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973574; cv=pass; b=Jj2lFuVVR9hm6hgoXfrKeaBld6ihmGaO2a4iWOUFmZ9L2GaYljLB+J48fbG1fvQRoOAiSscqC+46sdNMjPyc8I47CSGjXkSO4bcLZC0YVUqm2uNKkYa7rhT3DGDWZtJJbsIfFl3jYZ+w6lMZeM/ZpKN9Mv8yO6Zc7gbIICIaCH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973574; c=relaxed/simple;
	bh=iCm2q7CYAYsk2ZYPp0CMVzr44za0HAKGU00s0/XyWT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlHsMyEW+gklCK9A4Y4URf7HEqAIeuvddnTqC/j4By1RcuZBLh4urMHuGpzX6as8gpsXh4Sdmj0cof5/BAueSAZ9FHsFbUnqJyMJINwsjkBaJc2dkwQPgJS8Xm6ijGTH6IPIkRyk4wulXCoiy5/qKiq1s16neaHtnDwrBDKEX3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qV99zUj/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qV99zUj/"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6gLp41Srzyx1;
	Sat, 25 Jul 2026 12:59:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784973571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHU2iVNB3BwJVVtT8l+yWvqI/iPWnQJ+56rgwcFd3lA=;
	b=qV99zUj/6KqlM3DkCqREAqduho/2PinM44KPfmVBlHE6aY50zxLmcdm0IPY4MZ4nOcu9AC
	TwKf1AFNNfnzpnW0ATtunGZm8t96zuPpMdOhG4E7FKahTWwYJrZ5HrpbAz/ieQpQLWeArw
	8rTd7c6VlbcPpiK+INB4LCro62CNMS8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784973571;
	b=N71eHWwslCPfW5lujTLO4i3SoR6qWM59MVxC4IjT1H3VUPRBSAMZnyMVsu+wAzRlZ8Ug6P
	WNHb4BQTwMOPee0SOPlUdwBa1uSf2ieNHKGxR0Mct/k89VEuDuTQo7aOZbpdw2xl8e2vLg
	Ch9R3EjxbF4YhxV1EFQrF6shpENFzYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784973571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PHU2iVNB3BwJVVtT8l+yWvqI/iPWnQJ+56rgwcFd3lA=;
	b=DBwTX8nvmtcmEI3ZOmSBlb3IDRiSTmtQYbuxFyKQRNFEPAzWxCndAkc4/TxJ1SE9Fyuw4F
	fvj8tOqmiuvombqUfc1LRuJVaJoFaEDc+Vvy2SZsOWrFOnnXFVKrodrB5Z5Kjo0dMgBiXX
	WQBsRsX1Tt52fRYUm85wu60s0LT/5lU=
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
Subject: [PATCH v5 2/7] Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
Date: Sat, 25 Jul 2026 12:59:18 +0300
Message-ID: <0974596d74cd0e8ba860529572a31b9f41121d5e.1784973264.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784973264.git.pav@iki.fi>
References: <cover.1784973264.git.pav@iki.fi>
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
    v5:
    - no change
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
index d5554fbf3129..83efca415eaf 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7128,12 +7128,23 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
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
 
@@ -7144,36 +7155,41 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
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
2.55.0

