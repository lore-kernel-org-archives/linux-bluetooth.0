Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662326E708
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482189; cv=pass; b=qDqpuZStmgDaiZlXWMZDJo0S3NBzXZA9YXMm5Jwq4qTz6qh17hRLst6NRDZBqr39/14NYzJCR8iCs/FW3c8heQYGwqlT2Bs2PVVEcnTxPllOMniTRLycfAmhiMUFX7Nj/ccOXlFzhFfjhYZ1U1U1OKokPZuzV1iPnZhOBNxzwO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482189; c=relaxed/simple;
	bh=K+IyUd+KtD504tXLv3B4em2gSWE1PHarbsc9+EupIik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sd3jdi6HYPTOeHvQQgW/OSLr8YHYtn3jhKbHit6fPyqcvedOuZvNaEw42UX8tvmQnoNZg7T6IfXlxCwD18ZS4/9VNwqCK2B0zEGybzksMj3cKhbZw1bynNdYDT5E3+XJuGzJJ40kCfSEzz4HZc5AnCYG+9fdDPmZL44SfsufgLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SLpkocr6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SLpkocr6"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGF246Jrz49QKm;
	Sun, 21 Sep 2025 22:16:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgctL1QaSVzoDXS7S7ldc7AgBdd5KLA5mX2gADBq0zI=;
	b=SLpkocr6PESgo4KXCwlr100qB8HCexFzO6B6ggGrzff/l2hQu3lbr1xehA3lutl3fBmLcb
	zg0zT+GNrEccl209oHxbbrP+wZ6GGnL92r1bEETcbEFMVamL81LPcBRPzu7H1fTgl0LqkQ
	30T268DlsBI9lWTnYceJYcx1iRlnI55JEEpZUua4/On9BXv3w0kaJGMweFVQUURwmwpuZd
	npXQR1GRUuoHJnRS+z6f6PDTbpXvtCxwNyP0esN6o0bkMnxoo96ELD4JV7G6nsu3YFd2t4
	pJBk8dxAi1BYE0alBNSwTr1YoaUfx51DV1Rdt83dTaFg9ilJxdy/r+T0CrYOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgctL1QaSVzoDXS7S7ldc7AgBdd5KLA5mX2gADBq0zI=;
	b=ohlZhWUFbCerk/D4CcO6nZyI3Jm1irvZF9PlANkFA3Px8V6cTFMZFjmMUkiIlK6wnBGhUj
	VEYYcV7jx12TLX7MqkX4/EjjbaC7kQzHO/e3N39BgKubjgNbWJ1opsxyC2taQK02plIAMA
	JWE68EyPgjG2nRZUc26C8uyipbf7u5kz/sCIR9ivUGdtXNeOp2nfNq5B0irDb9iu2kICja
	QzF0WDU3pSMa+fz6nxKTKS1Fe5yNTiBHJWjV3C40h/P3EOHvhX+jJvgiUHIfCVSUuIBv1f
	klY6q/fwfLBwyssROcrR34omSSZcPfwVFGosA5ac2USR9Y6q6Ji5VK/syrd0BA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482182; a=rsa-sha256;
	cv=none;
	b=BZlPmbyKhgrj8e5TQ98MOlEXU/88ne1FOnU8DF8UXgCv7oE5JwyX4WqVok5xEXfq9FLPm9
	boJC6EsFzEUu/nhCMoeLb2WuLG63s5p14eD1fg0QJhq6+RYEIMfXu2Q4IGrYzKOAqru2ee
	8ibLef0YnlcNkxVDUp69tremDdhEmZ65e8Ffoh5jLCLJ5fNO2egfZOouoQSMPwPUswrbDy
	Cu0o6SOTlF9f7lUWNuTGe0Yqrr8Y9KxH7Ekm+YkGgBWLaLNHB38CMz53payB1ikMiTFQqm
	pqL0Uc/U/lIa9yv4XUjYnsKT2lCpWyXiCy4FysgTY4wZqg3ErvRR1AV7OKwhbg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 20/24] Bluetooth: hci_sync: add hdev lock lockdep asserts in subroutines
Date: Sun, 21 Sep 2025 22:16:04 +0300
Message-ID: <4eb414164ef56dc3ad61abcc2bcbbe76d3a5ce43.1758481869.git.pav@iki.fi>
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

Subroutines taking hci_conn* arguments require hci_dev_lock_sync() is
held.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3f0f9d9d8071..f4d984cee655 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5575,6 +5575,8 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct hci_cp_disconnect cp;
 
+	hci_assert_lock_sync_held(hdev);
+
 	if (conn->type == BIS_LINK || conn->type == PA_LINK) {
 		/* This is a BIS connection, hci_conn_del will
 		 * do the necessary cleanup.
@@ -5608,6 +5610,8 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
 				      struct hci_conn *conn, u8 reason)
 {
+	hci_assert_lock_sync_held(hdev);
+
 	/* Return reason if scanning since the connection shall probably be
 	 * cleanup directly.
 	 */
@@ -5625,6 +5629,8 @@ static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
 static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
 				   u8 reason)
 {
+	hci_assert_lock_sync_held(hdev);
+
 	if (conn->type == LE_LINK)
 		return hci_le_connect_cancel_sync(hdev, conn, reason);
 
@@ -5674,6 +5680,8 @@ static int hci_reject_sco_sync(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct hci_cp_reject_sync_conn_req cp;
 
+	hci_assert_lock_sync_held(hdev);
+
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.bdaddr, &conn->dst);
 	cp.reason = reason;
@@ -5693,6 +5701,8 @@ static int hci_le_reject_cis_sync(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct hci_cp_le_reject_cis cp;
 
+	hci_assert_lock_sync_held(hdev);
+
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = cpu_to_le16(conn->handle);
 	cp.reason = reason;
@@ -5706,6 +5716,8 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 {
 	struct hci_cp_reject_conn_req cp;
 
+	hci_assert_lock_sync_held(hdev);
+
 	if (conn->type == CIS_LINK)
 		return hci_le_reject_cis_sync(hdev, conn, reason);
 
@@ -5730,6 +5742,8 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	bool disconnect = false;
 	struct hci_conn *c;
 
+	hci_assert_lock_sync_held(hdev);
+
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
@@ -6407,6 +6421,8 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 	bdaddr_t random_addr;
 	u8 own_addr_type;
 
+	hci_assert_lock_sync_held(hdev);
+
 	err = hci_update_random_address_sync(hdev, false, conn_use_rpa(conn),
 					     &own_addr_type);
 	if (err)
@@ -6474,6 +6490,8 @@ static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
 	u8 own_addr_type;
 	u8 enable;
 
+	hci_assert_lock_sync_held(hdev);
+
 	if (ext_adv_capable(hdev))
 		return hci_le_ext_directed_advertising_sync(hdev, conn);
 
@@ -6543,6 +6561,8 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 	u8 data[sizeof(*cp) + sizeof(*p) * 3];
 	u32 plen;
 
+	hci_assert_lock_sync_held(hdev);
+
 	cp = (void *)data;
 	p = (void *)cp->data;
 
-- 
2.51.0

