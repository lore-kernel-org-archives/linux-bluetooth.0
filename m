Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5742D8387
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511354; cv=pass; b=rDrZ8j6rcoALscoMz9Q5JTVqe0qvHYx+yPBqm3Bx6RW0Zm/PjMRKWFUUVXH0s9Y86PCSgpr8i+LgnJMWxygRP7Ucgd0JJK50Z1P73MvxB9oWOVBquLyF+6rvOE48QiNuPvZDY+a/BYfrOtLGjj27ufmuJF3uS5wfwos0OlJhFGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511354; c=relaxed/simple;
	bh=aWOP7BNFXzlnprPXih+WM4QGQC7nnUoPQxaHNoLCFb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIOscVw2oaMP7Y8tLIKtlJ4oDAQHby74soR8PqFsk9hap213B9PvaCNPKoiAduIno56jwclS/ToeCfSZKYv/xsZz+EahiG+o0o0OKDmAy+MuQ1MWdmgkzeDtG9q4bizU8X6ywxGz/IGcXpjdckrHAL6zbuZfSXYmMCyK2ksZavk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NmnGMrhK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NmnGMrhK"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cdZrY2bw6zySF;
	Fri,  3 Oct 2025 20:09:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759511341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSpTaeyDmjhJ1TAV9eSKwgqnOg+WXWSvV2xqyUivqSU=;
	b=NmnGMrhKQJnt8gOiA+9HGtVCkYBOZfpKjx388nMzAxeKyXJ7yQZZra9zf3UVtuB2ToZn6r
	JHVnvhCK0l6HoxUqESzwewcuzWA7PrQ3poCNaSiiAaTqtWtDt9eMro/Jl1/9ff7tVUrsAU
	45OXRWAKOpMxzMFcsbfR08sOonUTsr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759511341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSpTaeyDmjhJ1TAV9eSKwgqnOg+WXWSvV2xqyUivqSU=;
	b=t9E9oIYB/GH9447lufoCOl7Fo+C9vJuwGK2OZCiaO4gxxiyg3BXnkKmadLr34ldanZ22PH
	mecaMVLN0gd5frKOvnE1OKVOn8tU5hmEXCO0PZUFsndyW/0cOf5OkIs//Dubco3Hq3PB6w
	pYIAS3KcHxFGRjmwsX5ZLRDiuK3ToW8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759511341; a=rsa-sha256; cv=none;
	b=d1yxqnfhcgJPPij5WKb+EJEohhacQHQtcUIFY1M71wrZhWj0+6VvyOcGd2ameV0nWElvNx
	dOD3qdFp2moE7nr8wm4YnIlrRL2GaPXDHi/DdlbHH1YswxxUey0seZc1g9Qjj7LnTzIDJ8
	1zJUeIvoHDpP79Os7aB5ZHyKDPBin74=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 8/9] Bluetooth: hci_conn: hold reference in abort_conn_sync
Date: Fri,  3 Oct 2025 20:08:51 +0300
Message-ID: <11051c427367f5f086e7bc81e64912e616c6197c.1759511032.git.pav@iki.fi>
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

hci_conn_valid() should not be used on potentially freed hci_conn
pointers, as relying on kalloc not reusing addresses is bad practice.

Hold a hci_conn reference for the queue job so the pointer is not freed
too early.

This also avoids potential UAF during abort_conn_sync().

Fixes: 881559af5f5c5 ("Bluetooth: hci_sync: Attempt to dequeue connection attempt")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 10dba0cac78b..2e12c918da0a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2933,6 +2933,13 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
 }
 
+static void abort_conn_destroy(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	hci_conn_put(conn);
+}
+
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -2973,7 +2980,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
 	 * already queue its callback on cmd_sync_work.
 	 */
-	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, hci_conn_get(conn),
+				    abort_conn_destroy);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.51.0

