Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798A2D838A
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511351; cv=pass; b=flf9UI5FmsXCqWW3fP06RolLwSvo5PRrK8Mh6Zv/x2e1cVFlLZGGxTt2+CNHIv4VnSOTy8WlJK+WvQ7OcjofPMBS9o//9HjVNsnHUTvYZJv0VwIVZCAxVXZfE773M9tYTYJkgmWc8/32qtoWI6jeJsey/doHQn/EK7C4o2Y/V6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511351; c=relaxed/simple;
	bh=PeHklEXfMLmHDfuEGHlYS0yc2yOjdfvcLTxAznoHBnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBws9ZcBIYXSKG/o2uA6pdUAOX/EiZOoJfeVrCoOyrydNaiJqDCQ1Ot7louPlkAe8quKqqX4OUoezXxMUcEY5tpbUPy1EnYaxCAjnrDXJt/bmAdH5NBLrO0YF2Sh+/NUTJzLbnEgcZEnkfwU/Dg8znOlE92nv29R+80RnMKAQsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=pV/JlZEE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="pV/JlZEE"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cdZrW2TbzzyT7;
	Fri,  3 Oct 2025 20:08:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759511339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4BFaq6Qb9TqOmTvUt19qGCV0zJv4d8GPP+5R1SZHVo=;
	b=pV/JlZEEd3594pv9Uil88wmNMTddmmW2D74t4onvPk0CRX5qfviN+Dqsw/niNg3wGh39JX
	Gxja6qeb9e//ZaKryJt97ggLXyw56glRjWXaKkfedjOJjgthWkOWajDDzTerTBodiaZ/O9
	wzwKjS8Z5VdIiOFQoF4Vhl2E//PPa1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759511339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4BFaq6Qb9TqOmTvUt19qGCV0zJv4d8GPP+5R1SZHVo=;
	b=H/oBMtD7G+3vfq1O+gUQbL/x9szd7RXQ3QMVhf5tFXj3pk9XRjpV6jth1sfoxKgcc7nLJA
	N27qfef6U20wfQgx4BJnIm3cjzaanTBWSj9lQKZ8aZE/F2zSC16w/5mhOYwzqQNNy+Hy5O
	RXUxqFhYM8Tsa0eqLG0r9MqgSI0csJg=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759511339; a=rsa-sha256; cv=none;
	b=a1THRXDnaVwBFXJEqZw1S854+pXnx27S4cOw24mmgWN/vXZKRUC3lG8D4Tcbgy31h/cjF6
	5vOkMU32PeNcKLrNTM//OpNoskOAV6BmYTKuvpaN/8QHgf9dIsTASyKcqfs/j0UIGpGK0T
	En9GZbUfKeqOThSSL0t/Erl0AExJ5ms=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/9] Bluetooth: hci_event: extend hdev lock in hci_le_remote_conn_param_req_evt
Date: Fri,  3 Oct 2025 20:08:44 +0300
Message-ID: <b0de78d5d1cced515f680d7323aae09c31586884.1759511032.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759511032.git.pav@iki.fi>
References: <cover.1759511032.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover conn lookup and field access with hdev lock in
hci_le_remote_conn_param_req_evt.

This avoids any concurrent deletion of the conn before we are done
dereferencing it.

Fixes: 95118dd4edfec ("Bluetooth: hci_event: Use of a function table to handle LE subevents")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_event.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1dabf5a7ae18..91da067e7997 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6620,25 +6620,31 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 	latency = le16_to_cpu(ev->latency);
 	timeout = le16_to_cpu(ev->timeout);
 
+	hci_dev_lock(hdev);
+
 	hcon = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!hcon || hcon->state != BT_CONNECTED)
-		return send_conn_param_neg_reply(hdev, handle,
-						 HCI_ERROR_UNKNOWN_CONN_ID);
+	if (!hcon || hcon->state != BT_CONNECTED) {
+		send_conn_param_neg_reply(hdev, handle,
+					  HCI_ERROR_UNKNOWN_CONN_ID);
+		goto unlock;
+	}
 
-	if (max > hcon->le_conn_max_interval)
-		return send_conn_param_neg_reply(hdev, handle,
-						 HCI_ERROR_INVALID_LL_PARAMS);
+	if (max > hcon->le_conn_max_interval) {
+		send_conn_param_neg_reply(hdev, handle,
+					  HCI_ERROR_INVALID_LL_PARAMS);
+		goto unlock;
+	}
 
-	if (hci_check_conn_params(min, max, latency, timeout))
-		return send_conn_param_neg_reply(hdev, handle,
-						 HCI_ERROR_INVALID_LL_PARAMS);
+	if (hci_check_conn_params(min, max, latency, timeout)) {
+		send_conn_param_neg_reply(hdev, handle,
+					  HCI_ERROR_INVALID_LL_PARAMS);
+		goto unlock;
+	}
 
 	if (hcon->role == HCI_ROLE_MASTER) {
 		struct hci_conn_params *params;
 		u8 store_hint;
 
-		hci_dev_lock(hdev);
-
 		params = hci_conn_params_lookup(hdev, &hcon->dst,
 						hcon->dst_type);
 		if (params) {
@@ -6651,8 +6657,6 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 			store_hint = 0x00;
 		}
 
-		hci_dev_unlock(hdev);
-
 		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type,
 				    store_hint, min, max, latency, timeout);
 	}
@@ -6666,6 +6670,9 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 	cp.max_ce_len = 0;
 
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_PARAM_REQ_REPLY, sizeof(cp), &cp);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
-- 
2.51.0

