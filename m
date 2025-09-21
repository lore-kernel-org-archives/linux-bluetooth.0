Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AE273D8F
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482099; cv=pass; b=KD+xy+sU96B9OnjlGntTrxK49dRf2wIBc9fT4pXa6BxZ++egncko3Gok25qVK81uSIp/wHbILY/BRd78e8YWhC6cGKgTh1zlASu2Tj4RLth2BaDZrDA9WZQTNgEo5sSXqsG4lwQWhjrKYvRnRE+Vv/ncmhHhFUTYDZYOgfG6mhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482099; c=relaxed/simple;
	bh=lEaGTTnSNXErEGxkINwrOLDh9qxnypymLnyBTT7Uv7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrjysSYlAQ7QtPbzuH2gfdo4v9EKePeryu/bfjesxLDFT+WOfuPTliEmTr8SH5JE1RMyVJ5E0lvyzWQKQltbsz2XyIOOei06wGydEcFYYaBO31mksEi0BhC8CRv+CFlul37/k/45CfXYZ0aSIUlXhiDnDKYAiNTFOijT9EESJt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iP8lkKE1; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iP8lkKE1"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCD4XvzzySx;
	Sun, 21 Sep 2025 22:14:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBEFb/1L+osmE8HylX4YdhzYmUmtLhnLepCzjxeHa+U=;
	b=iP8lkKE1vZIpvyhprP8MeolgGUsJ4LH+OXY3DWxpeuYmIOBS+w+b68xC/+RoItAPmtmqqJ
	4WSfb2gmahbaCfXfv4Fxwwo36bA7MNQekWwVC3BBsLwJFpO3NqEQ4aiWqHTXFKblfA4a83
	QvBN2GEzAnlLhCodxpo8ClumiAdZHrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBEFb/1L+osmE8HylX4YdhzYmUmtLhnLepCzjxeHa+U=;
	b=U5P6UACJ/BdvnMW3Su3aGMXFWzHMfdk/9CI0VCOhdd/n/ic//4h2Ixx1RGrbXyYULMzaOr
	N6WzOzZh2caGCtlnkUEqb46aI1qojXXw1clysg9ee7xxfw/Nlq3T87O0ptKm5m4I7s0Ye/
	+6Jr2UwpCJpXlkd15FoEGcdXCD45Ni4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482088; a=rsa-sha256; cv=none;
	b=HxC1qMk2RukhN0CTwdc8jIwDaUMtzQlY8diNwZuknBUENW2nluMAUElgx7N5+NMi7MPFMb
	67bA04NZoT8//Z60mqHV0YMyQ6OmSQDRO5FHEfFDBOhcilWP+Rlci+w3NfCzsaaHSPSWER
	Ac7dcUsXckVTHsvOWSNky89nkb0ZEFI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 09/24] Bluetooth: mgmt: extend conn_hash lookup RCU critical sections
Date: Sun, 21 Sep 2025 22:14:24 +0300
Message-ID: <2ad7b70768615c40184299e1c8c9a51e9c91a773.1758481869.git.pav@iki.fi>
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

When doing hci_conn_hash lookups with only RCU, extend critical section
to cover also the handling of the return value.

This avoids any concurrent hci_conn_del from deleting the conn before we
are done dereferencing it.

Use hci_dev_lock instead of just RCU when we are reading conn fields, as
it's probably more correct.

Fixes: 227a0cdf4a028 ("Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/mgmt.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ee7068fb9fb5..c18ce1aeb34f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3214,6 +3214,8 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_cp_disconnect *cp = cmd->param;
 	struct hci_conn *conn;
 
+	hci_dev_lock(hdev);
+
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
 					       &cp->addr.bdaddr);
@@ -3221,15 +3223,15 @@ static int disconnect_sync(struct hci_dev *hdev, void *data)
 		conn = hci_conn_hash_lookup_le(hdev, &cp->addr.bdaddr,
 					       le_addr_type(cp->addr.type));
 
-	if (!conn)
-		return -ENOTCONN;
+	hci_dev_unlock(hdev);
 
 	/* Disregard any possible error since the likes of hci_abort_conn_sync
 	 * will clean up the connection no matter the error.
 	 */
-	hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
+	if (conn)
+		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 
-	return 0;
+	return conn ? 0 : -ENOTCONN;
 }
 
 static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -7273,6 +7275,9 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 		rp.max_tx_power = HCI_TX_POWER_INVALID;
 	}
 
+	if (conn)
+		hci_conn_put(conn);
+
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_GET_CONN_INFO, status,
 			  &rp, sizeof(rp));
 
@@ -7287,6 +7292,8 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
 	int err;
 	__le16   handle;
 
+	hci_dev_lock(hdev);
+
 	/* Make sure we are still connected */
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
@@ -7294,12 +7301,16 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
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
 
@@ -7428,11 +7439,16 @@ static void get_clock_info_complete(struct hci_dev *hdev, void *data, int err)
 	rp.local_clock = cpu_to_le32(hdev->clock);
 
 	if (conn) {
+		hci_dev_lock(hdev);
 		rp.piconet_clock = cpu_to_le32(conn->clock);
 		rp.accuracy = cpu_to_le16(conn->clock_accuracy);
+		hci_dev_unlock(hdev);
 	}
 
 complete:
+	if (conn)
+		hci_conn_put(conn);
+
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status, &rp,
 			  sizeof(rp));
 
@@ -7449,15 +7465,21 @@ static int get_clock_info_sync(struct hci_dev *hdev, void *data)
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
2.51.0

