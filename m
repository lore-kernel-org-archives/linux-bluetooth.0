Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E2313552
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791793; cv=pass; b=IYCEPCcC4IvO//+GpsOQ0DZ31ohIrflES3nwCiEMJjiMN2eW8MNK32VtDfGKzSkIR+RswOzq70j8DJGWbBlFk3g4vnDNcVmkgJIIF4ycS0R8f2hSF0kUqAxvB7SEf4P5/bE6O0qWvdoFuOCFbIDccy075zWVhr3l7Vq8YTtqprE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791793; c=relaxed/simple;
	bh=ukvr0bc2jrmV9VuZiW8MCaYftl9GQTBc+JwasyhjCBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRtj0UiXt4vay2t9VT96ivdArOuCTYApn7xBDB6hE46RLez8HHtPPaDvO0p+XL+D5bN49NzG/8SkStOvDzNfOJBxYLA0KlN25DDkegWswQJijMtX4yBG7Tx9sMkGh9kqGXD5ZnN3GcYjMhyC37j3LbelXZy9GrD8f0WzBZEekxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=lK21zNDC; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="lK21zNDC"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fkFvL5wTpzyvJ;
	Sun, 29 Mar 2026 16:43:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774791791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rh/8Zc5fSeY4kL61hr4t09MNVa84UTkNNUGYMrdcBmI=;
	b=lK21zNDCD8XnuXg+cU4g+ZZ15jL+Kouu7+JlRHSpO8qvciSiqEGRYwIplk3SSY3qWOV1ho
	41o7v8orOAwpfG+uacdauFoF0rfl4zAyez7Gr8IS1mV9jxgCBcWt5eH0I8itfGGMAZM62X
	0FLwwCn20vbN0EjBfI3FTNmA/UgTqso=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774791791;
	b=jGDHXgsBC7D6h3aPGSMg01+ysIsymMVlbYKlRT/U4G3wx1bJkq7Q8uDbpIw0WGQh9dsi9g
	6r85csNLwHy640gyZUW3tx0drbgfH+SzWboEZLvPwX0QJy0ulQq4BgkeC8Ak65hkVsSMUb
	sdI4RiYozOYmySFRqmD6jzf3Ab2o1ZM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774791791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rh/8Zc5fSeY4kL61hr4t09MNVa84UTkNNUGYMrdcBmI=;
	b=uYA+86tF43cfeCcSLa2HkGKV+wOGmXCC03//9C0Vy7HUaAt51IaMD3pv+6WPEpsq6Ap/YZ
	BO47soIeHbyrJlgRsllnTvq9v6vivGQYdyhFqxPTMiH6HeYPP8u2qvFJt8Dl/hdIFy/SUF
	FLVAPswNbAkCZwycEp+ugdUrA+VuLkc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v3] Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt
Date: Sun, 29 Mar 2026 16:43:02 +0300
Message-ID: <17828eea9008f1b9e03c7e234fbf6be4ca9f8f91.1774787574.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
References: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn lookup and field access must be covered by hdev lock in
hci_le_remote_conn_param_req_evt, otherwise it's possible it is freed
concurrently.

Extend the hci_dev_lock critical section to cover all conn usage.

Fixes: 95118dd4edfec ("Bluetooth: hci_event: Use of a function table to handle LE subevents")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3:
    - no code changes, clearer commit message
    v2:
    - no change

 net/bluetooth/hci_event.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 81d2f9a3eec9..3ebc5e6d45d9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6784,25 +6784,31 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
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
@@ -6815,8 +6821,6 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 			store_hint = 0x00;
 		}
 
-		hci_dev_unlock(hdev);
-
 		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type,
 				    store_hint, min, max, latency, timeout);
 	}
@@ -6830,6 +6834,9 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 	cp.max_ce_len = 0;
 
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_PARAM_REQ_REPLY, sizeof(cp), &cp);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
-- 
2.53.0

