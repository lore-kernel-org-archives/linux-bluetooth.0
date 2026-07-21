Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F63FF1C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644585; cv=none; b=Mb+4hCAa8IP+A0ebsYHo/jrIDVwl74AUq3kS2pV7q4iGDqkOqubrPhWN6+fGMf1bLGe/C8y1mfi9iMtXDyiNZ5GbeHAxLWCDc9lerLFVVKaH2tUR5LgqBsJuy2Ee3dLF+wxk9nYS/CtsTZ/HzxA5n2S2gfO9cNHdQgGRFU784ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644585; c=relaxed/simple;
	bh=bgL5tbxHzvFclB/B3PWFb5TCJTT05yx6BY4AiqxdJ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9aSGT50KGdhqd5xFcY7Wvm+cjZViZ/aPvGGR4mvnks0MoqhzMJNew4xRNrialUt6bSA6dDMwqKuP0N3hea/iY5zrOx0Av3IZJwn5H9A00wBZXoLaLWyylykxnNRJz2V4Nm4CVpkzv0dEhCBwrLpTgwYuiEJFmurbOkll7sW0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOE25jt4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOE25jt4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f236418so6155685b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644580; x=1785249380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFEFab7lU7rBQz5LFtG2fcooAxiIEXcDPE3vpaeJMHQ=;
        b=LOE25jt4RNTouIek1FThUFguT8TJsqaZrK4BibpeHZQbsCJchL1eGrDti/KksMAlTC
         AXj3AgRXm0WvBPitAzRBCVBXUaTGPXn+7gYXTKdm1XK4NaE5rxQFF/LcjSKtcTuOvpeJ
         8KeM0hYdJaL0u2AQavVNHlrTChLaKBaK0ImGXf+FPvFPmwqyccBO/8rvpCO8Yq9+pdXY
         Hq5mG3W+qCeFS+BAPU6h11w7nhmxQgRdKv1aPNHbJGEjldGXUcjlgNVPihQjiUvo80K9
         KUlgXpM6PvXvtOoT1UsTTrwfSH/s7q0wPikbrvsNRplKHD+yoMZ79d1LQr3Gteoj47e/
         FmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644580; x=1785249380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RFEFab7lU7rBQz5LFtG2fcooAxiIEXcDPE3vpaeJMHQ=;
        b=a+agYpIV9OW/YK+Qhhp103wRzyFd6tPUnlP7DUVgvP3cNW+JJGiz4Fo2ydme5lcemd
         JvkqjP0KBmfXZ3iOeoqb/ZSowVNDOAY8uhiXfyBtwbWpsbnClIJPo0TaTTAbvc1r97Qm
         9hhsRxsukDToys0QawVpIO35z63eTEYHquNaFFFkeDqJ5/RaJ+nNAcZwJaXIY2BJY2ti
         C7T8hHbpFMA3he5kIVB45D/NJ+DhBrxlxFCNqtQiH7bmZ3Q/zYR8f0BIARU5nBuqJv0S
         4BfFgauHeew8hJ0c++TxyDxWS6gm+L9+lHT69MwB1KGlycFWOZG9awBZKqGDQ7ldxfSR
         NKQA==
X-Gm-Message-State: AOJu0Yy7spXileMs2wDmHsylx3wBpSxpwhMJtp+fYW77G4tEekCiM+01
	VLwIrvE/7WXJVfOVcRSRF1eMtS7EjX02OLuD4qr7aaDN2UoD82qKubZ5LdFKBzqF
X-Gm-Gg: AR+sD12uauxuL6KoLyWDkZX0RTKiSwaEXbkUU6ppcID4mrkvztsBicfvZ8Lib6W2B+Y
	Pe5KHB2R91YFFjFsGWYVVgLMW7Ndko7s40uUYkghyJPU65FXbnd7cqIS7gerKBLoF2JC/KYqdlg
	fZDZ5H0zXWeadEjeqFH42I2s0RmBpxdKJoAX06hcPCEsJr6W3kTT2DRRG/Lj3K2W6n9YHXThmqr
	ceBOsWlT+1jxTBdzh/oTfwBKkGW7nRjQdDHbD+dOOHl4Pb2MFbHCtYj2xe0+pv/qcwtHR+lSPcz
	ogObbGiTwfUfdbJaZdCc1PEQffCAIkrZEgIFPqlHK0p98DozzcGU+V60rFNbD5dc5X2xcQ5OgI2
	sZCPiTXOBaaRYRdi91RGoBlzy3OVhFx0lqpHv0xKFeW/5HeFs0LP0Lxao0SvVPCMaggqyeVceMZ
	t/FNX6QqDW7jYdycy5BwYOwm0Yzwhw
X-Received: by 2002:a05:6a00:228e:b0:848:47db:a0ac with SMTP id d2e1a72fcca58-84c292ab554mr18485988b3a.27.1784644579964;
        Tue, 21 Jul 2026 07:36:19 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2e388aa7sm7420058b3a.5.2026.07.21.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:36:19 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	padovan@profusion.mobi,
	johan.hedberg@nokia.com,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] Bluetooth: mgmt: fix UAF in pair command cancellation
Date: Tue, 21 Jul 2026 22:36:07 +0800
Message-ID: <5f62804883f405b432f3b72656cc07dd5223e828.1784492458.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784492458.git.xizh2024@lzu.edu.cn>
References: <cover.1784492458.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

The pairing completion and authentication failure callbacks look up the
pending MGMT_OP_PAIR_DEVICE command by walking hdev->mgmt_pending. The
lookup returned a command that was still linked on the shared pending list,
without keeping mgmt_pending_lock held for the later dereference and
removal.

A concurrent MGMT_OP_CANCEL_PAIR_DEVICE request can remove and free the
same pending command before the callback uses it. The reverse race is also
possible when cancel_pair_device() gets a command from pending_find() and a
callback removes it before the cancel path dereferences it. This can lead
to a use-after-free and a second list_del().

Make the pairing lookup helpers transfer ownership of the pending command
by removing it from hdev->mgmt_pending while holding mgmt_pending_lock.
The callbacks and cancel path then complete the command and free it
directly, so racing paths cannot find or free the same command again. Take
a temporary hci_conn reference in cancel_pair_device() because the command
completion drops the reference stored in the pending command.

Fixes: e9a416b5ce0c ("Bluetooth: Add mgmt_pair_device command")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/bluetooth/mgmt.c | 64 +++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d23ca1dd0893..85e60cfd1b45 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3498,11 +3498,13 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 				 NULL, 0);
 }
 
-static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
+static struct mgmt_pending_cmd *remove_pairing(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct mgmt_pending_cmd *cmd;
 
+	mutex_lock(&hdev->mgmt_pending_lock);
+
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
 		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
 			continue;
@@ -3510,9 +3512,39 @@ static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
 		if (cmd->user_data != conn)
 			continue;
 
+		list_del(&cmd->list);
+		mutex_unlock(&hdev->mgmt_pending_lock);
 		return cmd;
 	}
 
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return NULL;
+}
+
+static struct mgmt_pending_cmd *remove_pairing_by_addr(struct hci_dev *hdev,
+						       bdaddr_t *bdaddr)
+{
+	struct mgmt_pending_cmd *cmd;
+	struct hci_conn *conn;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
+			continue;
+
+		conn = cmd->user_data;
+		if (bacmp(bdaddr, &conn->dst) != 0)
+			continue;
+
+		list_del(&cmd->list);
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return cmd;
+	}
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	return NULL;
 }
 
@@ -3550,10 +3582,10 @@ void mgmt_smp_complete(struct hci_conn *conn, bool complete)
 	u8 status = complete ? MGMT_STATUS_SUCCESS : MGMT_STATUS_FAILED;
 	struct mgmt_pending_cmd *cmd;
 
-	cmd = find_pairing(conn);
+	cmd = remove_pairing(conn);
 	if (cmd) {
 		cmd->cmd_complete(cmd, status);
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 	}
 }
 
@@ -3563,14 +3595,14 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 
 	BT_DBG("status %u", status);
 
-	cmd = find_pairing(conn);
+	cmd = remove_pairing(conn);
 	if (!cmd) {
 		BT_DBG("Unable to find a pending command");
 		return;
 	}
 
 	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
@@ -3582,14 +3614,14 @@ static void le_pairing_complete_cb(struct hci_conn *conn, u8 status)
 	if (!status)
 		return;
 
-	cmd = find_pairing(conn);
+	cmd = remove_pairing(conn);
 	if (!cmd) {
 		BT_DBG("Unable to find a pending command");
 		return;
 	}
 
 	cmd->cmd_complete(cmd, mgmt_status(status));
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -3746,23 +3778,17 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	cmd = pending_find(MGMT_OP_PAIR_DEVICE, hdev);
+	cmd = remove_pairing_by_addr(hdev, &addr->bdaddr);
 	if (!cmd) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
 				      MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
 
-	conn = cmd->user_data;
-
-	if (bacmp(&addr->bdaddr, &conn->dst) != 0) {
-		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
-				      MGMT_STATUS_INVALID_PARAMS);
-		goto unlock;
-	}
+	conn = hci_conn_get(cmd->user_data);
 
 	cmd->cmd_complete(cmd, MGMT_STATUS_CANCELLED);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
 				addr, sizeof(*addr));
@@ -3780,6 +3806,8 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
 		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 
+	hci_conn_put(conn);
+
 unlock:
 	hci_dev_unlock(hdev);
 	return err;
@@ -10055,14 +10083,14 @@ void mgmt_auth_failed(struct hci_conn *conn, u8 hci_status)
 	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 	ev.status = status;
 
-	cmd = find_pairing(conn);
+	cmd = remove_pairing(conn);
 
 	mgmt_event(MGMT_EV_AUTH_FAILED, conn->hdev, &ev, sizeof(ev),
 		    cmd ? cmd->sk : NULL);
 
 	if (cmd) {
 		cmd->cmd_complete(cmd, status);
-		mgmt_pending_remove(cmd);
+		mgmt_pending_free(cmd);
 	}
 }
 
-- 
2.43.0
