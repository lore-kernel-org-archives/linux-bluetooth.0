Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DA214A9B
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482097; cv=pass; b=a+60ScijQ7O3r3Ro7nIeBuGwTUPA3DUwvW7ydrxoVuMphp0Z/Vo8/fOnJS2mZaysFxZ/lVS8MCs+SxVszUVd2Jw6z4d3v8Rtl8SveN/3J7LaQAIWqx0cnz2Kh1TdkbLXFDq7raHCYq7RENLKUifbrfEgqn9H7z/x3w6w45ddHhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482097; c=relaxed/simple;
	bh=oU29Pa7nN6hOu4C6og7gI/LXiYcA0dNwcm8cPw9psAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKPwp0WgiUGZ3NGtWbIVbdPocIy8sfbvlu4raxVcDTRnbZy2DhR8LMz9GhmBitNIMPA/qQMlhZYeoxWGS8BSNniOvkz6sJ5ivkuttxmpuST/3NJ7+rVQaN9l3aiC9JhWtcwatUvgn7RBhV1gnylyiUSIutSMwSz1j1/IpJSWqwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=J1eKWLB9; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="J1eKWLB9"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCB6tBWz107d;
	Sun, 21 Sep 2025 22:14:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBYI5c5dXkXNarvSdJF5NsHdMZHHC9pZS5IunviS7Nw=;
	b=J1eKWLB9y1YR+67t3ap9wG28H2C3vwWkPMWRnjZFqmwnER2TudEVwBUl4qa6Q96R1wYASY
	Lq4MNppGXdMvecD53OSKYx7aPDwNxYJTsjA8UFY1J8xMP7g7oIO5JOcdoy9MIwCLF7D+28
	LK3kHimu0XzGxaH8VAd3NSQ5QqNlRYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBYI5c5dXkXNarvSdJF5NsHdMZHHC9pZS5IunviS7Nw=;
	b=LjQ0hMEeEQKMwudc9H+9b4pwipe61Jo/7wcS2wD8hCyPyze4EulaoDRZsSsm8CzgYHX3ja
	zoBzVtcUTP7XA/blkh6LcziF1k3oICpH3NKjUEC4RQSMGZL52bW1QCxSyhE8++qeeoL9pX
	U26E7P2IDksD0SFTNX9uFq2pUqywM9E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482087; a=rsa-sha256; cv=none;
	b=IetxahG7FEpRp7jKExEvIeyd8dUxOzO1NwRXddzxyE8oLc2Ne0XkEN1qKTs3G0NTsvKUkA
	qO3C/1f+8kRfzYiMG6ksn557dLx7uHr45H8HFuZbdukb8S4k2Fmcmg8bH4vea8A7YIcZ0R
	AE0zl9dg3CJ4y326oK/vAStVrV/NpSc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 03/24] Bluetooth: hci_sync: make hci_cmd_sync_run* indicate if item was added
Date: Sun, 21 Sep 2025 22:14:18 +0300
Message-ID: <26a48f02ec5b791829ec9a5c71fbde23a4e960ef.1758481869.git.pav@iki.fi>
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

hci_cmd_sync_run_once() needs to indicate whether a queue item was
added, so caller can know if callbacks will be called.  Change the
function to return -EEXIST if queue item already exists.

hci_cmd_sync_run() may run the work immediately. If so, it shall behave
as if item was queued successfully. Change it to call also destroy() and
return 0.

Modify all callsites vs. the changes.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c |  4 +++-
 net/bluetooth/hci_sync.c | 13 ++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 111f0e37b672..4a9067b2e87f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2930,6 +2930,7 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
+	int err;
 
 	/* If abort_reason has already been set it means the connection is
 	 * already being aborted so don't attempt to overwrite it.
@@ -2966,7 +2967,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
 	 * already queue its callback on cmd_sync_work.
 	 */
-	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7a7d49890858..78af430be381 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -801,8 +801,15 @@ int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		return -ENETDOWN;
 
 	/* If on cmd_sync_work then run immediately otherwise queue */
-	if (current_work() == &hdev->cmd_sync_work)
-		return func(hdev, data);
+	if (current_work() == &hdev->cmd_sync_work) {
+		int err;
+
+		err = func(hdev, data);
+		if (destroy)
+			destroy(hdev, data, err);
+
+		return 0;
+	}
 
 	return hci_cmd_sync_submit(hdev, func, data, destroy);
 }
@@ -818,7 +825,7 @@ int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
-		return 0;
+		return -EEXIST;
 
 	return hci_cmd_sync_run(hdev, func, data, destroy);
 }
-- 
2.51.0

