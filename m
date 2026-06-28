Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5C3A4F34;
	Sun, 28 Jun 2026 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648776; cv=pass; b=nFqq05Ku4rU7PaeIP6qTt4J1a7q2OdASrvj8eftFscH8r0a/OjZnXJ1zKdXUuE3MosuxFMd68Z6yE9wnwKt1iUKsXGKytLdXXFTiGl8coMBCGYeuC6Yok+9K9wJFGaRJiYIXv9g+pWYwTyKs/tke8EuJ4fG8OWYm09YMSD3/hcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648776; c=relaxed/simple;
	bh=RYaEDsgmCNSLEku7x2U6FCdltuwITCi/XBowp+11Q/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAILsia0awe2h01jYAGLK6YjR5ReISg+LZqeHfnUh5Bj9pmSlEVUsBP6N0sALdmWpPCv5DaJ2ws03VzH/UAItmSiMamVKs9C6Sh4GprZB+Gzf/PTSa4Brco5ZxFf+f5HBHZ5OGqdg8oMhgBVASzckfv2FOMaMQyoe6KNjZV1Qac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JostyA/S; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JostyA/S"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp7b32wC6zycB;
	Sun, 28 Jun 2026 15:12:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782648768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1azlxFCV0ibxJMv5tueXhHtnrmYXSQP3EwCzkWUzIE=;
	b=JostyA/SLqurGNoBxSm7P+KeJnU3msN0NJnoxzExbN3k99L7s6HJeT3f9s+JAZx4ZQGi0J
	//2ukF4I2YLT3fZQGO82DMutQJ/xjqT7l2Zd+RBVSSrT+sHaU6ReJbMP3H8wBox04x+7A7
	93XgW9Ots6NCzlQKFccZgHjnOqERKOk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782648768;
	b=VUKC/QkpSwemv4SXf9L4QYnOpxyPEWnarY9yF/ziPyn7AkBokyIvdZ+fzvaRy+TK1Wuh5I
	uB9Dy3CcVgmJK3J4cphTXqrxzFIiGPqCat5KrisHjdi9eMVg+aeN1iDDxkVTKpa5ruUD5D
	akFxy3EgXRi5kFJ1LunBts93EQk42xI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782648768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1azlxFCV0ibxJMv5tueXhHtnrmYXSQP3EwCzkWUzIE=;
	b=um0Wsn38m25Ah9Rxfi9urfKbiWJCS3SbUZANd239mu1rOaWzL6icl3Zk/ljPVg7xl/otHQ
	07UC754KfvTRxol0vhFrET927YdDix92iO7WxGSwgNfQZkRpF2Op6ztDv9A1xc083EbxFM
	zrhSl8UotVwUYrUjd0JATBIxzyYxWeg=
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
Subject: [PATCH v3 4/7] Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
Date: Sun, 28 Jun 2026 15:12:35 +0300
Message-ID: <3241f586d8c8f553abcac69117d88c526c1e8450.1782645211.git.pav@iki.fi>
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

There is theoretical UAF if the conn is freed while the hci_sync task is
running.

Hold refcount to avoid that.

Fixes: 6d0417e4e1cf ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3:
    - split to multiple patches per different Fixes:

 net/bluetooth/hci_sync.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1ec37f6db213..bb59952779dd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7198,7 +7198,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
@@ -7222,6 +7222,8 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
@@ -7360,8 +7362,11 @@ int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync,
+				      hci_conn_get(conn),
 				      create_pa_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.54.0

