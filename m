Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F02BDC1C;
	Sun,  5 Jul 2026 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783291389; cv=pass; b=TaPd9lbRUC4yJlsmNbakmND2RxOJ8NdZY90qGscBufc1uDkVE0zw6PM2BcJMXssuZp7StXcKZhdcAZgWNbN/3FwfFpK6NuZER3blt/Fv7bDtcV8lFBqg1A4N3i32nU9oSuZYR8G4II8br11MIquzQe0i8C2QQeaFv4a9pdMXVfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783291389; c=relaxed/simple;
	bh=dSEQ0BsulvYvPAWVTKTEFoaRtcCPwV3hFdlE95STI98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVqk3Iie6J5v2hGJLqzsiplNJjOdHLIe36PYbM+edeXPVe5qpPNCKnPwxBgwvu8+5oArRPaT8jsPBwic9NcNW0piI5/oIw+WSBCTvgxNnPQr2c1pTD0GteS7V2mHZmpqDj/jo2Mflo4UfhLeRmDjR+zXlSEiZJB9sgCMASxvrC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cphJUUO3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cphJUUO3"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtjF4627MzyfS;
	Mon, 06 Jul 2026 01:43:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783291385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E08dmO4wyKRnZKBcH+4FmWGEJmRICGCy18x7sgnaBnk=;
	b=cphJUUO3cf8e/xuQKrJZXFAxc5ZewM6xNSot1y68yOlB5Xg/Y303ehi+5OvDYinjOHRUvD
	D3jGImoUhBPsNjBYCHnUl15RXoNN4MFjNY6zgQ0WWpIuTr44mhos3n3wCyRqKMuh3IOpsP
	z0z7KMaB3YCGJGYc6RIWlqFchmcO0uw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783291385;
	b=aKz1l/Frfs9SQl49YFnpifNXypbYakm9C2baJKUpxHf5yXDXbWNWrWonXX2HYR43IRs0q4
	5PfHJim5X2wBrvgEkg4oiuZVkpyBgrzrGuWzYU6Glo6A677J44LUtizeEebaI2of4K5ZD6
	DgGITw3lGDlNTF1wMvuAl7uzPpZu7Rs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783291385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E08dmO4wyKRnZKBcH+4FmWGEJmRICGCy18x7sgnaBnk=;
	b=rNojCVBzB08U09hot9/DGc1aHnbi4zUtS10E7SEuw3hhbB1aFFkhHnRppEtkwEdwQlWYI/
	c57n0yRi9BclKzacYcm+djJAlqIQd1IDKgZGJoYV//ABIwbHxtAAw7e8Mrt5fLYzlseIgu
	cbFe1PGq28AxIO6SYQCro/do1ZS6+Bo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
Date: Mon,  6 Jul 2026 01:42:45 +0300
Message-ID: <6288c79564bca6dfbf9e4ad87a99247cf7bcff2d.1783275015.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783275015.git.pav@iki.fi>
References: <cover.1783275015.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dereferencing RCU-protected pointers outside critical sections is
invalid and may lead to UAF.

Take hdev->lock for hci_conn lookup and hci_abort_conn().  Don't use RCU
to ensure the conn is fully initialized at this point.

Fixes: 227a0cdf4a028 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - take hdev->lock instead of RCU, to make sure the conn object
      is fully initialized before hci_conn_abort_sync()
    
      hci_conn_abort_sync() may not be called with hdev->lock held
      when called from hci_sync workqueue.

 net/bluetooth/mgmt.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 733a4b70e10c..39268f58a49d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3091,6 +3091,8 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_unpair_device *cp = cmd->param;
 	struct hci_conn *conn;
 
+	hci_dev_lock(hdev);
+
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
@@ -3098,6 +3100,11 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
 					       le_addr_type(cp->addr.type));
 
+	if (conn)
+		hci_conn_get(conn);
+
+	hci_dev_unlock(hdev);
+
 	if (!conn)
 		return 0;
 
@@ -3105,6 +3112,7 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	 * will clean up the connection no matter the error.
 	 */
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+	hci_conn_put(conn);
 
 	return 0;
 }
@@ -3252,6 +3260,8 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_disconnect *cp = cmd->param;
 	struct hci_conn *conn;
 
+	hci_dev_lock(hdev);
+
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
@@ -3259,6 +3269,11 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
 					       le_addr_type(cp->addr.type));
 
+	if (conn)
+		hci_conn_get(conn);
+
+	hci_dev_unlock(hdev);
+
 	if (!conn)
 		return -ENOTCONN;
 
@@ -3266,6 +3281,7 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 	 * will clean up the connection no matter the error.
 	 */
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+	hci_conn_put(conn);
 
 	return 0;
 }
-- 
2.55.0

