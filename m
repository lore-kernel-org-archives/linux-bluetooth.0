Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C673EFFA1;
	Fri, 10 Jul 2026 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671846; cv=pass; b=toUdaDGC3xQsvAF1PnMH8vXM07j1gHr321Xm2vWbJddE6kQgarX4YmJgNLYElK7QH/G0rbeE8jyA9dIb0Tgt0BtU3CvvvXZqlQWUfoww4QSG6Cmu5nnKVM2hJW5DegcVVC5PUKlzZAbxtyiwQWlofcb50WRq3a+eGJUghmKT55E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671846; c=relaxed/simple;
	bh=g1ImQy1vuGqWTQQgW3En/Th6zW/2Z1D7+gOQwqKiXsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0sW5zTyRBD6No1bycA2InHZ8uupGlU1tNfr1rbVEJDF2TnupId3t7XfDYv4KZWo1CrCWWr5r/Om3po+gnczxgmAlIxlC6B6FtEsJ62QgoJGNrGJBo3Fp4UPBoWChl8XsvqU4FLBkbRYsp7gKUBUWWIVLNz9jQxDAlogiNvOw+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=F66VdIMe; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="F66VdIMe"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gxPxS4nPCzyvg;
	Fri, 10 Jul 2026 11:23:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783671837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=884Qbk6aAhZ5jB1/V9NFJtofiSnkEMDDqf2HFjscPaA=;
	b=F66VdIMeUJMpFrONO4XbTgpuAuDm8rqpcRc9+KlI+9eTtmOAF5HtGV+9W0MCbEMpwGxw50
	jyxOeAN7WiICuB2lhJ8C2iqvps3ppi4ueC5LX5I3EWj+B2gVSOLCOfQmujD3N+mgDdftlW
	jeufg4urDVWiDVhKD3trhEqxlQLCm8A=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783671837;
	b=J70qlUpVHJzmg7GOyhbxo58aAye0FNJsAgsaxwx5Hs4AQRav8xVNKmTJYsLKzMl0dJDlTz
	AUKb2vFCAJtjdzGukBUCWpXCbSDCgmY4MXrQF55hZLTbNBouNUusifHnSgi6WGkL8dE2fJ
	JTEq+Ar1u0q4IpceSaFD6wOlZZG4NoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783671837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=884Qbk6aAhZ5jB1/V9NFJtofiSnkEMDDqf2HFjscPaA=;
	b=jTH+zhikpPqm8yOVcGJj/SVGxys2bLKl9LodKy4U80FGH8JSFmGdNMK0SKD6y8C7w0AY9q
	D03ERuzLtXP3IiIiPwWUxxDlYkQ1J2FlmUozrNCkTY+N9AO4yeRM0e3YtfogFoQQVqRcfp
	6WLLx1TxN31KTmbHzuxEN5EZwOzfaAY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
Date: Fri, 10 Jul 2026 11:23:42 +0300
Message-ID: <292363bfecaa083d3a8aa1b5a9f29041cb7eb826.1783671570.git.pav@iki.fi>
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

Notes:
    v3:
    - no change
    v2:
    - no change

 net/bluetooth/mgmt.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39268f58a49d..c61cb9750872 100644
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

