Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13A37B02A;
	Sat, 25 Jul 2026 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973575; cv=pass; b=W3zkesRx9RGKIyD5ISepY6ka7TAjXsWwNPsteTlvUUURfhnnVxt3hExIJxpFUIyalv3eMt8dKC1hEfE+2nBUQgXlsuqQkAkmeeMsuoKfIp4PQ8/8Cc7myhmkkRGpf7YqtChpIwXp6vGFMvlznHmKp5uVAH9ABOmXPSk4fd/LcX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973575; c=relaxed/simple;
	bh=IJvwNA8VB3618ZpT87og8k/Ql1qWv6neL+UqWEeygSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBRz56eEdPaShNP57t2Lm7fdphx7QE89lNgWMOHDH18/DkudmYUF4SnyWxAlcbgr55iJuODcOxNhDCzSNtIdoufnVRiARdmuV4RHw/+coQubrmxk+CQGIHv6IhXKU600kLp193V5BPPlDCxd5LzV7T7nZ4xWRXHPgzTVwrTd6fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uPu2ubdN; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uPu2ubdN"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6gLq69hWzyxH;
	Sat, 25 Jul 2026 12:59:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784973572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U52dx7hQAXu7gka1OfeAy4/i7FbwPPDjGJvxGedOdh8=;
	b=uPu2ubdNgGZpbUNsXR4y2V/eXW2kR/tqsWBJJAgWU+IYt4hT2pYxl858fYa4/yKS5zhxJ7
	pd139pYB0Lr1CZxNyOeJ8z4tndM2BCYXJdZONO+swLn67Nym2jmWHA2M6PWFwf/rgvagFf
	NF1sHUie12T/ihPU3oL7WoxMPzG68VY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784973572;
	b=jlMf4tAUjDi5RbBn4vZU59h+b3SUWmTjIaCXD2/81BhCCFynsG6YvPz7Nw084S8RMx8wVu
	9592h4CqkoA5pJNeolPfhuuDase04eOelnS5PKBNlLY5mwJ+9vOMhUvEprb72ZUFQYYjD6
	5Y4N13aqxm1MDQvzkukltpbDlXkqUfw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784973572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U52dx7hQAXu7gka1OfeAy4/i7FbwPPDjGJvxGedOdh8=;
	b=tUkeAHXPyu03AxjOFkkHJ5cDuhzXd+5JpNpyAQ5DSlCmp3NkJ0MPmuXYJjQKIPUCD6DFB4
	vOOweycIm6VH2d0/DGRezH2V2IaeKT47CNJlN45QATSJsGQpClxT4Pg11Sfr7NDEF4MU3l
	RLf3nl7Xj1eDe2KjmFVzgwotQnqYheA=
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
Subject: [PATCH v5 3/7] Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
Date: Sat, 25 Jul 2026 12:59:19 +0300
Message-ID: <ce281a9415e997ae35fbacbd92e73034ca3083ba.1784973264.git.pav@iki.fi>
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

There is theoretical UAF if the conn is freed while the hci_sync task is
running.

Hold refcount to avoid that. Handle NULL hcon, return 0 + do nothing to
match the previous behavior.

Fixes: 024421cf3992 ("Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v5:
    - clear_bit() without hci_conn_valid check, we hold reference
    v4:
    - check for conn == NULL before hci_conn_get(), since it appears
      iso.c may end up calling this with NULL
    v3:
    - split to multiple patches per different Fixes:
    - hold RCU instead of hdev->lock

 net/bluetooth/hci_sync.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 83efca415eaf..5610ef00fd0f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7498,10 +7498,12 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
-	if (hci_conn_valid(hdev, conn))
-		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+	clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
@@ -7553,8 +7555,14 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
+	if (!conn)
+		return 0;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync,
+				      hci_conn_get(conn),
 				      create_big_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.55.0

