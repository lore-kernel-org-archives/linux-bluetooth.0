Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332E38AC75;
	Sun,  5 Jul 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262886; cv=pass; b=T3gbceeJIb9qXHJc/JYbkQO5Qhy8jE3nxmWFbEqQfDZnDqmEnTyXNaZZs9YpNS3EXu+5jcXOs6YqgQp4RMr8CqlNhbH5e+i1JyHVDViTmL23ZcCSwnL98d7F3NphG12BzWusugLfJfSPfqYZR8UcdJKYe6gDERQEU2FzFu/3Tl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262886; c=relaxed/simple;
	bh=0gj6CJnXKLshkom8CdH3+Yyb8P3e/JBv3Hsi9v/LsMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNcpgU3kS/hbHy+AbbeDrRYqia+m+25UmURxDljl4nSwsmmx2iVAiOu1SFGs0jILfdGHsXuHOHDweiysD5M+Yb0AxAJMT5xLiTPDYvWYwAtgmtRJP6i6jGdYehJi9aUBDu5snLKw8voZyq+pFD2yirkoB3/JRLKZaD9fsbi913k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Sfy4Rt1K; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=tSzlSN4I; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Sfy4Rt1K";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="tSzlSN4I"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4gtVht6XBTz49QBq;
	Sun, 05 Jul 2026 17:47:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783262878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zor25fKe9cp2tEtneuk3saWEQYbGi0cJ+eEvxqRbQpI=;
	b=Sfy4Rt1KuHTrhnvITKLztWKWD+Lcq6kQbwW2mRFhTTS1idgswvz4JPZdNLSCvb05f//NQL
	iQJeIKkYp3f3ua+7oBa6XXn95Jaja/3e/CG0V2KRVQLy+PVV3H/qo6vhv7mPewhmmUebXE
	ftQuY1XqA0YGmPpVtLxuWstsh3jztYkpMwjRgWcwlkpJcurQqe6+5u7Qp/r2rkWcJ08QxO
	CmC6Sv+b2wFuLZuckUSju74X8Z9X6wlWR4JI/Bii7uKanqLRD5BbcVQWyGU4ZzdnPL8K/3
	AA2LQdxdEZSKKtqifvqaSw5yGl9OvUzdA5w15vSZ8JKnq8LZIHswr8PP3fPN9A==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtVhj6V2LzyfS;
	Sun, 05 Jul 2026 17:47:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783262870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zor25fKe9cp2tEtneuk3saWEQYbGi0cJ+eEvxqRbQpI=;
	b=tSzlSN4IiSZuKeE7RC7cX/+wYxL89uvoRd+Juh1hxZw6wfjClJUuyo2AjcZQw/tRQpJRas
	VB1azj/jWlj6Pc1+J0evqhoaRUvEc7haFlhcX6hQijunv0hmncAHN8Zk5odiIy6RzvKIgm
	1p5DXryM4hFQaSjZrLopEqI7XLrxPV0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783262870;
	b=T1uYBeI7IkmSbqrGRj+/yQBP5fstktCJyxbwnsVpM/lw/pg3icIPzswsk69nvpzxCrLX70
	HOq47a0Dh2QlPelsN+KERfeh2sdntzIAEagl/LpXnf/ydy9BMpcwo2l3qtgEG7YqnTfC1F
	ZXAhyo6grmZFNIqkBPONhBFyKfEFM3Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783262870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zor25fKe9cp2tEtneuk3saWEQYbGi0cJ+eEvxqRbQpI=;
	b=ARjaAg3vAnwniFIzPeKkJyBocpL+pzYp/7aV6u8UwkU5KPSWUMgzMH73ikgQKr+VAfPgWq
	6sMEiCAhdcd9yGxnEi5QpxZElfik45mBwWqlPvrim06xlwqSpUjLNSPq89EEgIONaY9dzj
	OCmHHOYif////sqdJYUO89YszDJ6AnI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: hci_sync: hold hdev->lock for hci_conn_params lookups
Date: Sun,  5 Jul 2026 17:47:39 +0300
Message-ID: <6206dcbbf04123f3c80a8fb5ce7d502e94c38143.1783262690.git.pav@iki.fi>
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

hci_conn_params_lookup requires hdev->lock be held, otherwise the list
iteration or param access is not safe.

Hold hdev->lock for params lookups in hci_sync.

Fixes: c530569adc19 ("Bluetooth: hci_core: Introduce HCI_CONN_FLAG_PAST")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a614bab77119..dfc4cdafe14b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6676,6 +6676,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	if (!hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES))
 		hci_pause_advertising_sync(hdev);
 
+	hci_dev_lock(hdev);
+
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
 		conn->le_conn_min_interval = params->conn_min_interval;
@@ -6689,6 +6691,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		conn->le_supv_timeout = hdev->le_supv_timeout;
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* If controller is scanning, we stop it since some controllers are
 	 * not able to scan and connect at the same time. Also set the
 	 * HCI_LE_SCAN_INTERRUPTED flag so that the command complete
@@ -7246,13 +7250,13 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
-				   struct hci_conn *acl, struct bt_iso_qos *qos)
+				   u16 acl_handle, struct bt_iso_qos *qos)
 {
 	struct hci_cp_le_past_params cp;
 	int err;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.handle = cpu_to_le16(acl->handle);
+	cp.handle = cpu_to_le16(acl_handle);
 	/* An HCI_LE_Periodic_Advertising_Sync_Transfer_Received event is sent
 	 * to the Host. HCI_LE_Periodic_Advertising_Report events will be
 	 * enabled with duplicate filtering enabled.
@@ -7317,16 +7321,26 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	 * 2. Check if that HCI_CONN_FLAG_PAST has been set which indicates that
 	 *    user really intended to use PAST.
 	 */
+	hci_dev_lock(hdev);
+
 	le = hci_conn_hash_lookup_le(hdev, &conn->dst, conn->dst_type);
 	if (le) {
 		struct hci_conn_params *params;
+		u16 le_handle = le->handle;
 
 		params = hci_conn_params_lookup(hdev, &le->dst, le->dst_type);
 		if (params && params->flags & HCI_CONN_FLAG_PAST) {
-			err = hci_le_past_params_sync(hdev, conn, le, qos);
+			hci_dev_unlock(hdev);
+
+			err = hci_le_past_params_sync(hdev, conn, le_handle,
+						      qos);
 			if (!err)
 				goto done;
+		} else {
+			hci_dev_unlock(hdev);
 		}
+	} else {
+		hci_dev_unlock(hdev);
 	}
 
 	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
-- 
2.55.0

