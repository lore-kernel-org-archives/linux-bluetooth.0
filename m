Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1B3EF0C2;
	Fri, 10 Jul 2026 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671845; cv=pass; b=eaoe7MiC4y9YFs617LdH+4CBcOKjTYG9paMeb6+mLKsHr8bFKQFow8b5Im+W4gafOxRjTnbxgcJIfkh6GwnmWY2VxFRUCcI+jjBFHj37W52OYPTpErwdhu3GWJjkwHZ/9dxMO+70g6fgTOzijt6pJ6OEXJ9S6EBnkphwHZmWSls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671845; c=relaxed/simple;
	bh=PgEsgQfp5WTswf2UXoexyFmK2Cw9h3dNPEUqcjowinU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+QfEg+C02/44vm1f+xQixj9hGTbi8uWOa4HDnCk/r9rE4VWB9RRkTVfpwogPg1GbcWZzZwRjINv9E0syIHZRpWRbmd15y1ZHgPa8+WwJCujFSgmZLWCNDGthCcyNamzO7dLIZqlEwNfkJdrQ5Rtsot6mVdvBPFp8GNrpX3/ozs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uTkSzRMH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uTkSzRMH"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gxPxS0qXpzyWl;
	Fri, 10 Jul 2026 11:23:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783671836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oqLO94tAjhpPOZ+UPy92XW9OWXF2NUhjRa5+sh9AcM=;
	b=uTkSzRMHf9IkxOlG70qmiv9WLdWIr6ibOZbdOuSUZPcfPDHqcHCS96tZIbfjerS3ayNf3/
	B+BRHtnW9j/cy8ccnqN7ZBOtYvarQ3J9Q5llE9HR0NofzBqTl3+Sxpf20l/tmi5Lcpu8J5
	NlOEq1hofl0GNvAJNM/r+YJMedOgIvc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783671836;
	b=GfSjXzBelU1Ywo/SohlsRezT595Vbzv5id0qwxa3ZeIJ10K5kxsIAFVkCWhRGh9VaLRJmc
	qJn7qf1xQs9QYlA5Ay3+PwcXgs2vIHyEIGfp/wrr3rWThbAHH4noC3aPeq4iQU1iakXNwN
	MaWTXl3QDjQ/PHJZ1XS6bFBDTwlS5jE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783671836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0oqLO94tAjhpPOZ+UPy92XW9OWXF2NUhjRa5+sh9AcM=;
	b=xoitilhqCMlhSy4uHwfzlq9yyvDQKgnLIHdAqx2fTV/6Kzt7yvd3Un+q9yQFSJsJt4G6qI
	mx0Mt28UFmb3zTY/pCyXGvHP3JSkxF8CDh3oQq41fw3BxU5n3+rxTdF2kJ31cEBw/0hbyD
	vVaj2y69yTwWDDjFkutFob1CJPv4dO4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] Bluetooth: mgmt: fix locking in unpair_device/disconnect_sync
Date: Fri, 10 Jul 2026 11:23:41 +0300
Message-ID: <6288c79564bca6dfbf9e4ad87a99247cf7bcff2d.1783671570.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783671570.git.pav@iki.fi>
References: <cover.1783671570.git.pav@iki.fi>
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
    v3:
    - no change
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

