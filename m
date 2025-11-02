Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF08238C3A;
	Sun,  2 Nov 2025 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100589; cv=pass; b=guWYTdSthZQdaZ5vPX7oBHxA4MPpHwbIyO95wiHZTbVHxDqfyIobFkeQXgieYIE3l37sW7NsKoI+qH9EbED05SCO9q1auquuW/yCOjveaK19B8DkwsE5G8h8HFGSy/VQmd6C3pHSFGvYBuOdmPS+H8Hok4yP2S26kep1t3UWogI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100589; c=relaxed/simple;
	bh=b1Bqvssg5Cc/l/cZnFZ8hmu68j1M45X9GPS34ss0NKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKQDGV7/Ozu267lUiEMu9v3ayEnTtbHWX2i82L6mD1gKyfHYcDlZ3Z/yPmaGxEjsC9i0Jn0zodGzM2kvTAJVt3qubSjzyFdoQnUMZ5alV2rPvc8XHxzhoRQeUyh+Yp1nbxuFhQwSZeVcrzN/I5LBjgGmQs3h1Tgx8pPzsN7FBjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JHK3vqs6; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JHK3vqs6"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d00PZ2h5Dz104J;
	Sun,  2 Nov 2025 18:22:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762100579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRXtUfZ8HN2xVlwrSvzPOVXF2tdZAWQwGDdWKbCSI+8=;
	b=JHK3vqs6r7higKBWqTG0WO+ngTyu9G78Y6O+kES5O/f2hKG32gPa33lmPvQLil2IS33Iw9
	SZqlzL64oXJNvjc9VNRfpXktZycqX5Srh+uXwALXmliBO0U1tKzcqzJmpS/J/quy+N23D3
	DC1905cCCog0rP6m40FgZIHalnuV9e4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762100579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRXtUfZ8HN2xVlwrSvzPOVXF2tdZAWQwGDdWKbCSI+8=;
	b=w8ItkKwFgLjwnYdhUEuzg2ms8tWvcatm7zP8LrXwAu1nSiJWGAjOQFwzaUYJJEcUD3qLd+
	bWmmxZErSRP6tOmGw7OJUOJ+4Sp1QL9YIUE73PXxrg6AvScSAIfzlq74251k015l0LB3c/
	rGK2QS/c0b/XJhSfn7HAEmCGLaoRw3o=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762100579; a=rsa-sha256; cv=none;
	b=Gv7mTH+fKjrswdn1aVgEWf/C7eTzBefMUm84pNjHUCEWLIT/OUhkTciAeq8vq9xV6iHORa
	6VdLhCcXdad065wgygXQGeVtDxClbyW/QN9TAbmnfGl5ltTk7uRkFmUB9dgvon508qDpU2
	pgEsbSfACc6L1t5MlGGkCoHRm2pEqpc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] Bluetooth: mgmt: take lock and hold reference when handling hci_conn
Date: Sun,  2 Nov 2025 18:19:35 +0200
Message-ID: <1ac16b2d328ccef42d09e875c09232bd7f0e32da.1762100290.git.pav@iki.fi>
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

Take hdev/rcu lock to prevent concurrent deletion of the hci_conn we are
handling.

When using hci_conn* pointers across critical sections, always take
refcount to keep the pointer valid.

For hci_abort_conn() only hold refcount, as the function takes
hdev->lock itself.

Fixes: 227a0cdf4a028 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - no change

 net/bluetooth/mgmt.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 78b7af8bf45f..535c475c2d25 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3081,6 +3081,8 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_unpair_device *cp = cmd->param;
 	struct hci_conn *conn;
 
+	rcu_read_lock();
+
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
@@ -3088,6 +3090,11 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
 					       le_addr_type(cp->addr.type));
 
+	if (conn)
+		hci_conn_get(conn);
+
+	rcu_read_unlock();
+
 	if (!conn)
 		return 0;
 
@@ -3095,6 +3102,7 @@ static int unpair_device_sync(struct hci_dev *hdev, void *data)
 	 * will clean up the connection no matter the error.
 	 */
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+	hci_conn_put(conn);
 
 	return 0;
 }
@@ -3242,6 +3250,8 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_disconnect *cp = cmd->param;
 	struct hci_conn *conn;
 
+	rcu_read_lock();
+
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
@@ -3249,6 +3259,11 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
 					       le_addr_type(cp->addr.type));
 
+	if (conn)
+		hci_conn_get(conn);
+
+	rcu_read_unlock();
+
 	if (!conn)
 		return -ENOTCONN;
 
@@ -3256,6 +3271,7 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 	 * will clean up the connection no matter the error.
 	 */
 	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+	hci_conn_put(conn);
 
 	return 0;
 }
@@ -7372,6 +7388,9 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 		rp.max_tx_power = HCI_TX_POWER_INVALID;
 	}
 
+	if (conn)
+		hci_conn_put(conn);
+
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_GET_CONN_INFO, status,
 			  &rp, sizeof(rp));
 
@@ -7386,6 +7405,8 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
 	int err;
 	__le16   handle;
 
+	hci_dev_lock(hdev);
+
 	/* Make sure we are still connected */
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
@@ -7393,12 +7414,16 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
 	else
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
-	if (!conn || conn->state != BT_CONNECTED)
+	if (!conn || conn->state != BT_CONNECTED) {
+		hci_dev_unlock(hdev);
 		return MGMT_STATUS_NOT_CONNECTED;
+	}
 
-	cmd->user_data = conn;
+	cmd->user_data = hci_conn_get(conn);
 	handle = cpu_to_le16(conn->handle);
 
+	hci_dev_unlock(hdev);
+
 	/* Refresh RSSI each time */
 	err = hci_read_rssi_sync(hdev, handle);
 
@@ -7532,6 +7557,9 @@ static void get_clock_info_complete(struct hci_dev *hdev, void *data, int err)
 	}
 
 complete:
+	if (conn)
+		hci_conn_put(conn);
+
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status, &rp,
 			  sizeof(rp));
 
@@ -7548,15 +7576,21 @@ static int get_clock_info_sync(struct hci_dev *hdev, void *data)
 	memset(&hci_cp, 0, sizeof(hci_cp));
 	hci_read_clock_sync(hdev, &hci_cp);
 
+	hci_dev_lock(hdev);
+
 	/* Make sure connection still exists */
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
-	if (!conn || conn->state != BT_CONNECTED)
+	if (!conn || conn->state != BT_CONNECTED) {
+		hci_dev_unlock(hdev);
 		return MGMT_STATUS_NOT_CONNECTED;
+	}
 
-	cmd->user_data = conn;
+	cmd->user_data = hci_conn_get(conn);
 	hci_cp.handle = cpu_to_le16(conn->handle);
 	hci_cp.which = 0x01; /* Piconet clock */
 
+	hci_dev_unlock(hdev);
+
 	return hci_read_clock_sync(hdev, &hci_cp);
 }
 
-- 
2.51.1

