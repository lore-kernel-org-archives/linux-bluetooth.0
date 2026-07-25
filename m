Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234AD3A48CA;
	Sat, 25 Jul 2026 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973578; cv=pass; b=iSv5stZwZgn7fya7BQQdv3tm6ffcU3cNemInrJkzALc9M1N145VtrRqVDgGRYgk5wP0mTmxN3mrlXMQeW+TYr5SzZC3foSYKS9hGdUPWDgf1Qdx9Jx9d7rMBRTG9OwyyFyTAHHNLPsSEtiAa85B5IVvilqxPvmK4OijQ/LOsCrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973578; c=relaxed/simple;
	bh=gstbHEFeGNXwoqvbw6aG4xp+KCcWao12xqDPNA+4GhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyxpZUCYQ2sjL4F3uLMdDLXs+lyR8W9lRB2IwiQ7W8UumFI3cPGKvd3hPogTi4QESySPEcaa212LDEJEGCXxFDMzeQLstBgtowY7fWa5E74E9yKP0QtiZgMR2c0FvpC8KRZ9izJzy+iWjBXItQo2nfs3JZbOk6Kyj7fQvv+fe1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=oZRPu9NK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="oZRPu9NK"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6gLt2k8HzyWx;
	Sat, 25 Jul 2026 12:59:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784973575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNL63PimvWpnXb9NzLGeo7vap0pdJyfxowUhjsfacjI=;
	b=oZRPu9NK+vofL/WXnLTt83xi6t7mm6d9itNgvM0HfM9XlfWjB0eWWZ+x4k8bxBZ1pgbuJ1
	2ZrkJFxc1z/08yKy149sjlQBL/0yAktbdCs0SyDqFPJA+7/WtxG1i955htUPX6JijzD5HX
	EF3GO4Oi5fz71NfOaGDZDQs8WUGevtk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784973575;
	b=MS0hgf99ZaQsalcO6A9rATe16An2T4ftxRew+JvdSnw87w+mj/NRnLV/9wTKOPs3HmU/kC
	26bWmpgwHyqA1KkGk7zEp5zL2A3aqFw+iQhUntp+le3IJqpvm9hiRWU7eglKHR9eY37BG8
	83trXYGT5e6FABR0oXO+DZga56JpcV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784973575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qNL63PimvWpnXb9NzLGeo7vap0pdJyfxowUhjsfacjI=;
	b=Q/J0/nTXFZxk1F30shDXWUT58vV+bGjZ6IRAFHL9P8jGMy2PwsTG3sU08m7dfm2J1xK08c
	JYSVnchYxVCh3/zjJI0lQdMumPBtMbeLqYc9Y8xQGar9y1Qh3Jm82mxf3dt01npz341Q+Q
	oHGTZsQos/CDeKZ5FFS0/LFg0hssKcg=
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
Subject: [PATCH v5 5/7] Bluetooth: hci_sync: hold conn in hci_past_sync() callback
Date: Sat, 25 Jul 2026 12:59:21 +0300
Message-ID: <dc93370834489159e95b53ddbf3185690e29c530.1784973264.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784973264.git.pav@iki.fi>
References: <cover.1784973264.git.pav@iki.fi>
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
    v5:
    - no change
    v4:
    - no change
    v3:
    - split to multiple patches per different Fixes:

 net/bluetooth/hci_sync.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 86c865306d21..63d0b89a88f3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7582,6 +7582,8 @@ static void past_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
+	hci_conn_put(past->conn);
+	hci_conn_put(past->le);
 	kfree(past);
 }
 
@@ -7646,8 +7648,8 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 	if (!data)
 		return -ENOMEM;
 
-	data->conn = conn;
-	data->le = le;
+	data->conn = hci_conn_get(conn);
+	data->le = hci_conn_get(le);
 
 	if (conn->role == HCI_ROLE_MASTER)
 		err = hci_cmd_sync_queue_once(conn->hdev,
@@ -7657,8 +7659,11 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
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
2.55.0

