Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980F3A8722;
	Sun, 28 Jun 2026 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652859; cv=pass; b=cBx+GEw/QdfkFxBEulDsXvEOi0RloRWqcP6/9z46WXCqxGGpXqyG53xkZc/ToWqRNiivWLfpzTePye3TYaJMOYe1exxeb4ZtbMOP6P9t65q5INIIRFWMKiOYng60itX4b+KBX2Ian/qscmUuozCxvgRTSl+8raWPq7HilQowOPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652859; c=relaxed/simple;
	bh=7VVyn7jOE4AzW7sNg23KehD6B3ut8PAMrn+6gwJcKaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHwllYxxMZT2KRgVcLcHBSH98L8YFcZ9C4BhD9VKyBEnVnsmw1pitqgjfwygCv0YPTugzSFnkU8W81TxDk0CBdmzO2DCdHLOt6cbJZkBWtX29ETR71yYXOj2xbFASEGpLZl2gl9nkVlODzt4OPyXtrm6cW+DCdKJy2kGwOX8g/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=tVUG87aD; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="tVUG87aD"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp95R6Jr3zycB;
	Sun, 28 Jun 2026 16:20:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782652844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AF/xq+my/bsQC92dvufOfJ7/94hr4Ea7GkeNbucBM+Y=;
	b=tVUG87aD7AJpoeQ7m/hxnqzQqN6eJCvXV2fsAppdzz7cAQejA26/lA9mKmMPEbfP6Aq4+B
	nZdwM6R/lU5Nl95xPuNSVDOFTURJcs47aJUuFYZq+OVPd7URWHNvSomjzddSVYI7XE6c1h
	WmiNeQ3QVDwSk3k+5Yk+WLf0iOEyXVU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782652844;
	b=Tpy0IKt5tsx+C2PG5d0+6bpCl1pdJYt6hHl/n7IElxU3vuJyfnGqz9vuNRnzDDEmy5mOfh
	BpEi4HIbPj5Tmbn7TRdo5UjKfWmVP2bNyH3osrCFYE1kEUfv4O3lw7X8icrQFmC4jTbjCV
	qCWGt9+U+BB9NsMylt6GR0hAxb3C5Hc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782652844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AF/xq+my/bsQC92dvufOfJ7/94hr4Ea7GkeNbucBM+Y=;
	b=GDPzrN6dBVSFiWJ+Og7MPGd7DqJdP3RZKZhow7dsbXnPNBQvYPKvoxbPKZpvFKP2sUY6pf
	FbmAQaJ4OrJIBjg5VzqvnIuDsf7n3FSMrIPvroED8DGZ94xbTlSFXigaGj/zRc4fNfFFy4
	J+xWVasHWgsynevxwU4B/Q/dxafZUR4=
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
Subject: [PATCH v4 5/7] Bluetooth: hci_sync: hold conn in hci_past_sync() callback
Date: Sun, 28 Jun 2026 16:20:30 +0300
Message-ID: <ae9d799a5862d2efa7315e0de35064d53aec6ca0.1782652695.git.pav@iki.fi>
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

Avoids giving freed pointers to hci_conn_valid(), which kmalloc may have
reused.

Hold refcount to avoid that.

Fixes: d3413703d5f8 ("Bluetooth: ISO: Add support to bind to trigger PAST")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4:
    - no change
    v3:
    - split to multiple patches per different Fixes:

 net/bluetooth/hci_sync.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 56018214120b..88572e52c860 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7461,6 +7461,8 @@ static void past_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
+	hci_conn_put(past->conn);
+	hci_conn_put(past->le);
 	kfree(past);
 }
 
@@ -7525,8 +7527,8 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 	if (!data)
 		return -ENOMEM;
 
-	data->conn = conn;
-	data->le = le;
+	data->conn = hci_conn_get(conn);
+	data->le = hci_conn_get(le);
 
 	if (conn->role == HCI_ROLE_MASTER)
 		err = hci_cmd_sync_queue_once(conn->hdev,
@@ -7536,8 +7538,11 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
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

