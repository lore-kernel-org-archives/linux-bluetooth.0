Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485872367AD
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482099; cv=pass; b=mfd2fFHiio4rbwJ4dJjWt8ybGCuXYWkKRgS8zTFgy120/RlhcVxIdLJPaxdN64X7QTvdim+b5Uol5nCNOErWAa+pu65Dv6kSLfr7VzLVicTdTwiwVBRx+nfrvZ0Jw2ippU+RzQQMv7lQIDo9/a92j+TezQhqD97IdeALqVEIlpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482099; c=relaxed/simple;
	bh=GU6yWcZ7BpmEPwflXuX2Uwh6vSdVpm1t93c4KMRuOug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ydw8b9V0uTlJUyX14zcMmyK4oRdKWap5oRWfgxX6umumqgHYsGHPyCGnocq8m43i9CFKe+vZxt/JriW93ZWLPOTyMefnSmtg3jbh/X1whoB20k9X1DAiVGg5BH5vO0ZHKXzE/xi1lZXwbFuQq/BiG1aHy2dlOU8SIW2zFjDiy+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=upIRhbeo; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="upIRhbeo"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCD0vsBz10FB;
	Sun, 21 Sep 2025 22:14:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uybWzJ79SmFxYswaF/6OAP1vNtTIvMSV8cphJieLFJ0=;
	b=upIRhbeoYfSrFLxkcmWgYBM8n5Y0MTonRBrugKoX97ZUhcTSp9diC1sDjB/+xXRiojSwyR
	n0JRJyyJsNA0Y1iIgVZSiPgRIS0bh/xz+YrRLPZBbehgqbbs1V75OVKSTjiwbMynEfUWAT
	a6vzog4BxCbg5qduN6/CijK5M55CW0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uybWzJ79SmFxYswaF/6OAP1vNtTIvMSV8cphJieLFJ0=;
	b=KcAk1kvruE2vxTOMCZHbNd/ICMkDJl5O56Fiw/XbaHyzpV+O5WME7Rr49yI6Er105n5r1g
	3fYJ6oxUR81BK5sTeMp7E2vVUQ7oIhHvr/Vw2uCjmCZvnGKEmIzEvngrJrmi5oUfqojV/Q
	P7yhFOqIhzF2sEHjDTzuaXLfx6BpoUg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482088; a=rsa-sha256; cv=none;
	b=TyM7hltZ8FR1ltJOcVyWsEjgiytcQmQ8sBMMqOG4vz6Fw7OQ/7B6NmX534cXCcXv4NKHuw
	amRaME4jyNuMP0As9nUgBWRTACDdE9mmKLSNdTVqLJYSIdmssnsx0VdvBS06fyI0TTdt4k
	VDhHn8jl5KKSBPn0+8OwzWwqGJdXa1k=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 07/24] Bluetooth: hci_event: extend conn_hash lookup RCU critical sections
Date: Sun, 21 Sep 2025 22:14:22 +0300
Message-ID: <5084aac899a44776ff8e31d3a4035557a72c953a.1758481869.git.pav@iki.fi>
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

Fixes: 95118dd4edfec ("Bluetooth: hci_event: Use of a function table to handle LE subevents")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_event.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d790b0d4eb9a..56f3f69404c6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6616,25 +6616,31 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
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
@@ -6647,8 +6653,6 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 			store_hint = 0x00;
 		}
 
-		hci_dev_unlock(hdev);
-
 		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type,
 				    store_hint, min, max, latency, timeout);
 	}
@@ -6662,6 +6666,9 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 	cp.max_ce_len = 0;
 
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_PARAM_REQ_REPLY, sizeof(cp), &cp);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
-- 
2.51.0

