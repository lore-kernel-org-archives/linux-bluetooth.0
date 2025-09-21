Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B62F37
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482188; cv=pass; b=tEVOxiQtg7qiNMMz/wtB42TRqA4bcvWI9flKAtwt2nLPwklC0Uy372GQoEHGTHDowLVnEmDwBLYYi6TZ/4UyIhZ/ELZihq7aN3trpmeKUw1zt4UHJByUEofKWbf213Q5ZS63ciqav7wvaf9SKOjR6RT1arwLayvvUkhYKaHCQ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482188; c=relaxed/simple;
	bh=J9AGxjyMXkfaEL0XELxlfmoPoDKedldfBDbMTbbvIV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afgyS3dt0k7ITm1EJAoyaCe8YhWB8YwmdAoYematMBiXBhiAytEinFaFduAEhMTP8FU/SfozEcH+AhUCTYt4RBd2GMj539SfnYDJiSh1m5bjh7tfq+LyaVJPHLJlg9vyMb2tj3bAtua9v/wyzM3tqqQrL4qlEByLpfrq0A4HLpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AUHetMAD; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AUHetMAD"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGF26FmZz49QMh;
	Sun, 21 Sep 2025 22:16:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao1/U3YWDMQBhoOl/mwnjELq3upwDLxV570cbArlqpk=;
	b=AUHetMADBFpNkH4gbiFJ26M4DJzyRopns8JSJhQk5k51TkfuAmsNUyV/GVNX+R1p8es2UE
	NgMXzuG0l854V3cS9MZ6xH4uzmbGcob4fja+awraiDoJvz7zjroI0Y82xXkU8tKF78K+Dt
	2kKMMADc2IPc6DuvEQcy5G733xk9nVTWi+IbcEiQ44W1NnK7t9QE8kovjuY/n414LRegkD
	tyNtIFNcSAaa8T02SOkknjc0gFaubrpfsP5J7pwQ4Pp5jEUFy95dniITIIvevrglTuf9+B
	IKP7hT7j0PlBK5/9+88RKV89Uafp0eYr2couDDj2+XuyfqJ/F9MaOVISzD6X6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ao1/U3YWDMQBhoOl/mwnjELq3upwDLxV570cbArlqpk=;
	b=ilQTEZDvATy1tIxn4kdoWxRa5eIzOTxd/HHgFqYbcChc5ir7LUi1jttYgy9fWmzk018TQY
	vTqd1RGgiqigmS/wl7S/Li8WP6r5nzJIi9oiFRZHUUJz+vOEoKlZzGneDfFAjNcDbq4Xow
	UmULsEnC8hHNIz0v3IVkhp/MTWFKvbgCuo/9jNf5BUwkr04jWO0XqZdmcWLG3ySSDr3Ykz
	jZwfZHJg0m3OUCTR/ASEwu0d/VXSZW+lbyK7LI7CfKtkzM2U8uqsjU5T3XG/o/tBNyJYYQ
	7jZMekmt1y2Y+nWLGDYP69GImbHuY/Xb40t+hw4n8hi6Fv69TnEBQdvE5/nf8Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482182; a=rsa-sha256;
	cv=none;
	b=WDg2iMoF0iJYg0/ZAbhSoUbDo3/FS9bp3ObtglnGVfhvqhHIngtQATTsfarBjGcdBxh6NF
	zkH67HpRMcISA0X9zgJOKAIhTSfXqzCBa5TkixqDXc1k76vIGZUSWnnUA6gk2xaL1MMKBd
	11x++g1uuEZP0o39ggxbSkxZFMoxzC/UIfND8tXpccxP+Xk91/OTaTUfyN7kDesOliNc9E
	7IjjW89oqs1xTLaYqelK+kLaeACIWQN2pTWCsUgMwoidwhtEza+xA98o6uIWLqoI3Kqlvm
	sZF8QpmMF4WQpzYpDAEuSomdwSPGRam28OjofSZiarpuEUThWRIzi2jLwnYp1A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 22/24] Bluetooth: hci_sync: lock properly in hci_le_pa/big_create_sync
Date: Sun, 21 Sep 2025 22:16:06 +0300
Message-ID: <72b17f12919aa7be73df14ff607e7c8d94ea8f4c.1758481869.git.pav@iki.fi>
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

hci_dev_lock_sync() should be held while accessing hci_conn, and its
validity needs to be checked after any waiting subroutines.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2d79667f16cd..0717d53c2e33 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7153,14 +7153,22 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	struct bt_iso_qos *qos = &conn->iso_qos;
 	int err;
 
-	if (!hci_conn_valid(hdev, conn))
+	hci_dev_lock_sync(hdev);
+
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock_sync(hdev);
 		return -ECANCELED;
+	}
 
-	if (conn->sync_handle != HCI_SYNC_HANDLE_INVALID)
+	if (conn->sync_handle != HCI_SYNC_HANDLE_INVALID) {
+		hci_dev_unlock_sync(hdev);
 		return -EINVAL;
+	}
 
-	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
+	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC)) {
+		hci_dev_unlock_sync(hdev);
 		return -EBUSY;
+	}
 
 	/* Stop scanning if SID has not been set and active scanning is enabled
 	 * so we use passive scanning which will be scanning using the allow
@@ -7173,6 +7181,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
+	if (!hci_conn_valid(hdev, conn)) {
+		err = -ECANCELED;
+		goto done;
+	}
+
 	/* Mark HCI_CONN_CREATE_PA_SYNC so hci_update_passive_scan_sync can
 	 * program the address in the allow list so PA advertisements can be
 	 * received.
@@ -7181,6 +7194,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 	hci_update_passive_scan_sync(hdev);
 
+	if (!hci_conn_valid(hdev, conn)) {
+		err = -ECANCELED;
+		goto done;
+	}
+
 	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
 	 * it.
 	 */
@@ -7192,6 +7210,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 			goto done;
 	}
 
+	if (!hci_conn_valid(hdev, conn)) {
+		err = -ECANCELED;
+		goto done;
+	}
+
 	memset(&cp, 0, sizeof(cp));
 	cp.options = qos->bcast.options;
 	cp.sid = conn->sid;
@@ -7221,6 +7244,8 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 				      0, NULL, HCI_CMD_TIMEOUT);
 
 done:
+	hci_dev_unlock_sync(hdev);
+
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
 	/* Update passive scan since HCI_PA_SYNC flag has been cleared */
@@ -7268,8 +7293,12 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 	struct bt_iso_qos *qos = &conn->iso_qos;
 	int err;
 
-	if (!hci_conn_valid(hdev, conn))
+	hci_dev_lock_sync(hdev);
+
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock_sync(hdev);
 		return -ECANCELED;
+	}
 
 	set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
 
@@ -7302,6 +7331,8 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 	if (err == -ETIMEDOUT)
 		hci_le_big_terminate_sync(hdev, cp->handle);
 
+	hci_dev_unlock_sync(hdev);
+
 	return err;
 }
 
-- 
2.51.0

