Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6073A451B;
	Sun, 28 Jun 2026 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652849; cv=pass; b=fVv+PSQsnzjgmw5m8sALNs2+DGA1hiiNDLA8lbd6daBinCSomjhSdlicAGpXayfdAMN2La+P4cpQHkKG9FtyGl3kUc69Il5Ng2ffPY8eVf3EldHhK3LX82v8qxHNVE6o8Czgxp0FOKEhqDRlz8psCF6GZhroX8IuWw+wyprR4mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652849; c=relaxed/simple;
	bh=wYms/ryN1fzhs8P+Z5HZ2Pv4rrFUhueNo2tmIEtB20Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hd7uR+vI6FpJH/tg2zDasZmhsCwNAljcavVoyTEQLPzswZIEjjkm45DfZH0yZdCCnUY+VU5MMgw8m3c0/tZAd/4ZPGcH0SMU5YMtZ9UzCEmqTHyGNHKDWt0A33Cw3wGnrkdsNkePsRiqV37gbBHMegOMa74LDdPcwcsTQ3PVoc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Nv+2upYr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Nv+2upYr"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gp95P3381zyZ5;
	Sun, 28 Jun 2026 16:20:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1782652842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIjkjl/qTH4hmCJ7w+nH6kIMdcPgVkPI0Jg11Ov/x90=;
	b=Nv+2upYr8AxID3vI2x+WWQBV3X0j2ZO49zUelGdbxtkZmuHCLSV1pBffvqY2aIGPXdOiM9
	7+68nWYG9g+bAfwfFhGTKjOobPXOn4mzZs0SnsDNm9zI6Fs9A5Wdlihj7cO9bnVWXcdGOE
	BTbhWRKq9cWRrCU47tYr2P8GNv0Sh4E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782652842;
	b=ubcccwRxl88bDI9U8cEMZPM9xFkwZtgo08YYFxmlAWyECFW9EimqweUP/dshAb9gPx+IJ+
	4CW8Yhoe2ZpM/TjYXIoQOd4EedxFEdcuMxHwBs1bucOTdzYAcdAiJfnkNVECRsEj4w8Il5
	jG/WVvo1gC0D/1Suk4zloQArYEHunI0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1782652842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIjkjl/qTH4hmCJ7w+nH6kIMdcPgVkPI0Jg11Ov/x90=;
	b=I4K0BQGc3xtmtP4GU1GxRiMvsnuXOW91amz/3fhLqPh8AXkr4lvF3jm+dupbDfFCeLRj7K
	lDr3eirS5d9AavmrrOb3O9JXQH9av44960PgmSxbxCo/22EpgcmmkbNdCGjRJlU3n1ygwA
	WBj3DTFgE1cn2gSMvYwL7eXln8BhDnk=
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
Subject: [PATCH v4 3/7] Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
Date: Sun, 28 Jun 2026 16:20:28 +0300
Message-ID: <559fbe0e8989a5cb2ff892065c925f8fc1b7de56.1782652695.git.pav@iki.fi>
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

Hold refcount to avoid that. Handle NULL hcon, return 0 + do nothing to
match the previous behavior.

Also hold RCU for hci_conn_valid(), otherwise the return value is
meaningless.

Fixes: 024421cf3992 ("Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v4:
    - check for conn == NULL before hci_conn_get(), since it appears
      iso.c may end up calling this with NULL
    v3:
    - split to multiple patches per different Fixes:
    - hold RCU instead of hdev->lock

 net/bluetooth/hci_sync.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 66f42a3dc5a1..d8efd143135a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7372,10 +7372,17 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
+
+	rcu_read_lock();
 
 	if (hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	rcu_read_unlock();
+
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
@@ -7427,8 +7434,14 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
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
2.54.0

