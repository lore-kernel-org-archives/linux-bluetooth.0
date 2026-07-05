Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB638A71B;
	Sun,  5 Jul 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262886; cv=pass; b=OA1osnGItYvF1FUiU/eeXkQNeuedHnY2hDbj3YOFqSyAECsqYOyBC9UYXtxGvcOkybLgCWaiW2x3DvoVgIJm6uNaT8i4p/dTJZe2p6bbv6mBq+dV2yi32qjhkwYsW0V4Q4agl6IdW4v3yZ/o3gy/UH8ySqCdswxUuGPGcJGfmKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262886; c=relaxed/simple;
	bh=Y11W0Ozq2LU8EHBPk4S+bCbHRarO5RpGYouDw8SzNmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzzxXXe7+DAeDE8+OfQCJpKjNw9i/FZaFKPOdIYUfoTEjMAylcEUrkozS3Rn7ez9Go1p8AsfvuVSF9phmd3itVZv5CYDSN3dFtUDd+Piry8KcO2nXY7YSU8WgPc4en1TerbBaCBWW56jNzF4VemrWTuUsoQPRA2e2nH4Xy9pY2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lTaQagJq; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=p+GrGnZe; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lTaQagJq";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="p+GrGnZe"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4gtVhs1J8yz49QBQ;
	Sun, 05 Jul 2026 17:47:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783262877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpvFyuAGMaPDM076uGMWlVk1LOJvvyM3DzARrYdRq+s=;
	b=lTaQagJqmJxviG4+jluI2N93NlCujqjvuWkV5pgcbtjvz5ssUGSFkQMaPzBIFmA9xUNyb8
	6cxDKsxqt9WJSKDUIpH8Zqt20+so19gCxxrQxeTRvUcuOsQX/ibSjMB1rHUyud1Cb1pt9w
	c10DrsR/Px9w5aKj57jdl9AB6Ir8UCh4RU8O8FNTbmBog6hENI+AwxX1dvoAOWcnd/o73h
	Umzk+yiuUwyLap58/yAC3yGmUTif6rQCW6dsO8H6rmFnRc5KwY5b4O0PcHdamJ3MuxiZ5j
	lJKq0yaMarVoQFoqaO3Sou2nCzLeoYmYYA8oYYA1f0LxheRscCQJBYzguLX7NA==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtVhh4JvTzyfF;
	Sun, 05 Jul 2026 17:47:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783262869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpvFyuAGMaPDM076uGMWlVk1LOJvvyM3DzARrYdRq+s=;
	b=p+GrGnZe3ArJsVyV7R9dtx9eY/Z0AfiBUc0IExIdAtKMLslXUJVAk2XAukLaE3FzH+Ffk/
	1sn7BO+BCwTstA13UvbzLLu6d62i3xn6XTW1zpRKDKf39gOhCk+5YPMjUJA03cFUv2btYs
	7Fvn+cEc2se8da8Bx+AAzXOdYv4p2Cs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783262869;
	b=VcB7uFoXcLI+NaobMHKhQSVECCrQq/EPX3/tVDMSdS0hpkLjlgkSNVPVel4cvgancRb6wx
	Su8EUF7STddICO90T1OPFYHvxlyf3guDxcefX+0Ga92VpfbwL5xaKljX+wmJONLKMh7Xnn
	vs7Kb2ICXxkXPMpoQUiMneKXh0XnBdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783262869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpvFyuAGMaPDM076uGMWlVk1LOJvvyM3DzARrYdRq+s=;
	b=xDfNG5JyBTzair9Nla+0HU1UemrDhvZYFb+yPNK78stBxeZxR8f47FNWeyJXxnnh5rkkej
	/emMRnzVGqmBry02mzmBqeD12xpA7eORH79M48YcO4n0kyo+EaQ+VLVjG92wVxYa3bGP8O
	6ySyFisLHRBoFxjG0KxWD5TpZTUkZSI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
Date: Sun,  5 Jul 2026 17:47:38 +0300
Message-ID: <354056568c907003389032bb9078d7d6c367d5ba.1783262689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783262689.git.pav@iki.fi>
References: <cover.1783262689.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dereferencing RCU-protected pointers outside critical sections is
invalid and may lead to UAF.  Use of hci_conn in hci_sync callbacks also
needs to hold refcount to avoid UAF.

Take appropriate locks for hci_conn lookups, and take refcount for
hci_conn pointers stored in mgmt_pending_cmd so that the pointer stays
valid.

When accessing conn->state, ensure hdev->lock is held to avoid data
race.

Fixes: 7b445e220db9 ("Bluetooth: MGMT: Fix holding hci_conn reference while command is queued")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/mgmt.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cfcb97badd02..c33751b6fbea 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7404,6 +7404,9 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 		rp.max_tx_power = HCI_TX_POWER_INVALID;
 	}
 
+	if (conn)
+		hci_conn_put(conn);
+
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, MGMT_OP_GET_CONN_INFO, status,
 			  &rp, sizeof(rp));
 
@@ -7418,6 +7421,8 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
 	int err;
 	__le16   handle;
 
+	hci_dev_lock(hdev);
+
 	/* Make sure we are still connected */
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
@@ -7425,12 +7430,16 @@ static int get_conn_info_sync(struct hci_dev *hdev, void *data)
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
 
@@ -7564,6 +7573,9 @@ static void get_clock_info_complete(struct hci_dev *hdev, void *data, int err)
 	}
 
 complete:
+	if (conn)
+		hci_conn_put(conn);
+
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, status, &rp,
 			  sizeof(rp));
 
@@ -7580,15 +7592,21 @@ static int get_clock_info_sync(struct hci_dev *hdev, void *data)
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
2.55.0

