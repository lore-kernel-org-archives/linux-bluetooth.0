Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86A3A63FB;
	Sun, 28 Jun 2026 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648777; cv=pass; b=ZF3rbkQXFIz5weiTDwsH2zVEaQ8fi9ppeX0hrl0s2OHdPRA1ULqqjr3cDRojmGTpwr1vax/AMhr/7EngwXkMY/GZ5Qm1bC48+vGN3yk4oY/oA+AnV4YbKwp51lx/VWxXCpZMNolQxdvvXczLvzL2ymMB4FuxJ3oSYTXu7vDRrbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648777; c=relaxed/simple;
	bh=fsWx186f8kb1kc/FF7T7o6KSgxfYEBu/1DwB171YEUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3oEC1mXo8b6uj1ZkLF6B39o47pnF27uDCNrnvcYu1F1wVcdpaBkxJRUENUwpwyoIXiBZ1E2vnixH58MR5RvYXL7uzD6yUpp5IkAapa439tUpJxVEkixvBpRZZCazS0kpQaiY6PY1XunP5q4OIT0fJ5kxW5/GhwKIH+QhNDIteY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XGbMgh2Z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XGbMgh2Z"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp7b43CnCzyth;
	Sun, 28 Jun 2026 15:12:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782648769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y6Ubd8guFNKwLlQbFlLfmxEGBQgQssUSl90FrWBW24=;
	b=XGbMgh2ZRUHnLKLNlurmI3LL3FzgLug1sJ4YatNW7GKV9fngvtUmtjYXm/e5tKucTQyPUZ
	0e2aSjxxt0BxF+w+hyFHrJmo3OYrNISmLPP17n5dl7Kj6cmY8yBC91EZWGK8gAFD4oZ9ur
	X48KNTaLz+5gbvLGFxJvRw/+PXkZbms=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782648769;
	b=IKQO9gDokfSEOLbv4TMhp5sBkv+Q0cSuW9avIOoaaHS1FQRvhqswQFWXId34o2Vi7p30ly
	IrSwwx816rtVH8EgEZ88rIm4yW+yZlvzdiPdRiADsfmevb1IWwal7pKD4iDw+QHNqqi1C9
	tooDwVUO69LxPxBrgH4pj2E3skpJA/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782648769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Y6Ubd8guFNKwLlQbFlLfmxEGBQgQssUSl90FrWBW24=;
	b=tjwwEhow3xzDOa9s2X5s2LEMRLIo/PYPgZ/0GdISLeV0Yyd5Xt7MmGwz94ONmjeOEfWIDr
	ShsK3oVB578WbVInXFEJO3sDzQmpOlPEtiSQTSrOcHjo6WQQJO8LBm8vZrFqXz9iJebHXo
	yD4ZNVw3Plpr8HxJXo62yP7gyLg+KxU=
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
Subject: [PATCH v3 5/7] Bluetooth: hci_sync: hold conn in hci_past_sync() callback
Date: Sun, 28 Jun 2026 15:12:36 +0300
Message-ID: <d85a71e81a389bcbe93ad987c1d0210d9ccc953b.1782645211.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
References: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782645211.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids giving freed pointers to hci_conn_valid(), which kmalloc may have
reused.

Hold refcount to avoid that.

Fixes: d3413703d5f8 ("Bluetooth: ISO: Add support to bind to trigger PAST")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3:
    - split to multiple patches per different Fixes:

 net/bluetooth/hci_sync.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bb59952779dd..0bbc57792206 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7458,6 +7458,8 @@ static void past_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
+	hci_conn_put(past->conn);
+	hci_conn_put(past->le);
 	kfree(past);
 }
 
@@ -7522,8 +7524,8 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 	if (!data)
 		return -ENOMEM;
 
-	data->conn = conn;
-	data->le = le;
+	data->conn = hci_conn_get(conn);
+	data->le = hci_conn_get(le);
 
 	if (conn->role == HCI_ROLE_MASTER)
 		err = hci_cmd_sync_queue_once(conn->hdev,
@@ -7533,8 +7535,11 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 		err = hci_cmd_sync_queue_once(conn->hdev, hci_le_past_sync,
 					      data, past_complete);
 
-	if (err)
+	if (err) {
+		hci_conn_put(data->conn);
+		hci_conn_put(data->le);
 		kfree(data);
+	}
 
 	return (err == -EEXIST) ? 0 : err;
 }
-- 
2.54.0

