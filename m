Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115F3A7D73;
	Sun, 28 Jun 2026 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652849; cv=pass; b=fgzFM6j6eQkl+jA5miwAIxoXC816WWcTFKKFNarkez4lh9tetOmJ6PHW9qQsM0WbX2uhwykpoDcnXjYW+/5aqroRIRmJFe+KwWELlPRQZpjh7FKKbpqRgRttVj60vzqCmqTJWUEqbdkj0BLFDcnZm+MGLXuyt6zB0skKdihmYf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652849; c=relaxed/simple;
	bh=cPv2TUm7gF47rk9cJUCD4EAKmw5IDyh/cidcCNqACZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUI9VqWweQAntEXWsb4hHL2P6pVAcJS6P51ZLhQWlUq3a5LyreP8axuPq+xXv8m+XsV87q65Wk7J4VLRo8bpWcJ3ipq5UL+7xvNuyWY0us/O5SapZHSwLh6/IqWikwlSSmorsb2cHbpAtlhZThJG3/kQw+mbfBdS990AA9de+l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=C0u/zVNK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="C0u/zVNK"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp95Q5NqYzyth;
	Sun, 28 Jun 2026 16:20:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782652843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQTcMxS+sICGQM5Q+DzLt4boD18VHPm/e4MqFBU5Lsg=;
	b=C0u/zVNKBmj7f+ShBH5xxfntyrjmWnJTtGgrFoGV1slzHmpui2ewbr4OPcjCqkL7iknJdY
	1F1psht0tWn6UJijVcDF1hVppf8482B6ErYgcsiaJkwNUT4CQuPVY7ehEBnK7QJWG5ULPK
	FoWPnsJv5x5lzn7xIL2jekOf8MSF8QU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782652843;
	b=EHi5qDFbPYJkgUMDXYYmaP6kJzQJaf7iSlTyOqAEl8LJCy22DcbqfQyc5iRBWWYsyjh2iC
	Qpj1tv+p/sm+8HRXTBlCuKmcmU+yECIFBO2FheEO6BSgcvz3ybJZbSUvyCdgj8u1mbRtvI
	1XOWmKz4alCa3AuQ5SYdzA/VWeiqdro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782652843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQTcMxS+sICGQM5Q+DzLt4boD18VHPm/e4MqFBU5Lsg=;
	b=evmnT0GdAvdf7tS9Vo2gZd7am5hVVFMmgxHY72KCFfestDpdJa47um3tazUFcraODDIbw9
	XZPwhyw/vuL6sloqhpWmBC9cOYTx5tgYhYIuOlN8r1l4gseaZXoLHxo2eC1M3d0A773bX2
	wEj4CNdSQQyrMXKCjHdeshpoFImBn7A=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
Date: Sun, 28 Jun 2026 16:20:29 +0300
Message-ID: <a7d72f59dcb605234849ea0c38e84471daced808.1782652695.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782652695.git.pav@iki.fi>
References: <cover.1782652695.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is theoretical UAF if the conn is freed while the hci_sync task is
running.

Hold refcount to avoid that.

Fixes: 6d0417e4e1cf ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4:
    - no change
    v3:
    - split to multiple patches per different Fixes:

 net/bluetooth/hci_sync.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d8efd143135a..56018214120b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7198,7 +7198,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
@@ -7222,6 +7222,8 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
@@ -7360,8 +7362,11 @@ int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync,
+				      hci_conn_get(conn),
 				      create_pa_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.54.0

