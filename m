Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D93749E6;
	Sun,  5 Jul 2026 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783291390; cv=pass; b=sAPqnJgEzPwQd4QePikH3vYn+pso2VGMGcAMDNzZhHvnwT9coQbwM9uLOwhkDH6QivFpDFPVzWXH4Z+3CifS+1woaaRyyhQgqejpyLDNHmtacLplUbEoiBzV/Gh/4vhdgw9tRPpEmlHyj76CyxpK6mwG6OinZ3N1KPTfZtejzQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783291390; c=relaxed/simple;
	bh=dDzFNcmHxHhhSREAerjfrHaRN6HLfcFAQgsoBb3WSZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmrQJQazgEE6dPZvu9pIBn2mc9rpTN/YFdEczpd6GsYClFKZUMLvBx8VHeCOh6cbUueydl5c1hZuBDXkCW+Cl/6zN/1/xGy1ODBdbzLkb+T8H3yo8duKdzL39woIfSkgKvtJpa9ETYY/F1NWSIjILwMYGwEpf0V1o51kcDpRxLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DhcCgDZ9; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DhcCgDZ9"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtjF61VVpzyff;
	Mon, 06 Jul 2026 01:43:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783291387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8pgyL3pDp0HNqi4lqma9rfgvxkZq9yJocw+1k7lHWI=;
	b=DhcCgDZ9aqrDzHSaXl+hLT4cAhnwy2G023CbF4S8oM5unvKUnKicEg7xXIhCkVMGmjC3rS
	Q+nbyZStlZhnZFzSsw2AgRikvLD1PE6F+1rocAlQIX2U4DZpjSlWM91oFrVrmOsCTgi9it
	lfN87A+Sf+VET1TwFocqQoqeW/83qGk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783291387;
	b=uh63o6YFxsZteSv7D9zqXkaI4v0EENvh90AvHaa26TAWJrG5Z7HXRabQ1OPclPmmzzlOhm
	3NBW4cZPqY7FsOMfeDvv2d8OgUXPOph14K+bex5wu3AxdQiEQrIV23ax0hSatHh6EaHvX2
	ETAE50+QS9BQ1/EGhTrUztNE5xy8sVo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783291387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8pgyL3pDp0HNqi4lqma9rfgvxkZq9yJocw+1k7lHWI=;
	b=v3C9dJDqKihyKG7EjQeFk696dp7Nb/yQh/oJ2HgMdL/XtHvuMM8rP996xPUulSbUQSf7v/
	Fqu49fgy9iOMyKQi2ahy3zQ2osEEkiXEeXkBhbw9C2pduqEZHK56TVLHQlT/eGqWLZ8gfh
	66ot64NtDxfmkfgfPeGbUpW7vMSxOJw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: mgmt: hold reference for hci_conn in mgmt_pending_cmds
Date: Mon,  6 Jul 2026 01:42:46 +0300
Message-ID: <292363bfecaa083d3a8aa1b5a9f29041cb7eb826.1783275015.git.pav@iki.fi>
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

