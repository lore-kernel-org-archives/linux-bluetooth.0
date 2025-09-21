Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98F267AF1
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482189; cv=pass; b=lXqjBNntOi0AiL909R7avQdaRDNeTsPBKIcPQAwPkZdTNyIsCAuAZrAYDfiuYm50fUVrnSFVzHqBdjPgEhyCUlfETupTSgMkuIp78wO51lNDJB2GK6mkuqMjIP2jxyaMiRu/s8uLLKUpQ92VQvpQXh20/QXb2Gd3gP1w0uZlenI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482189; c=relaxed/simple;
	bh=gP5Z11yBRQCNDRYRmt1/09znJxIYQKDcju3h4PJhUP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My2Ofiu2PzrlnpyPtAf2E9nEVKYDHA+ipyXQ8nXcS3oRtcOlbYudIhV4vgg6x85FyqIJNK1z7Q5sENCzsKXQhCzKMvLrkzFWbIVdAjJEuM54PlVDgrHahl4wYmiRUzQXLAN8ezWP8vo4CBqDsXAIafZsGGCqxUetjHynnetY+gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Y6w/mV5y; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Y6w/mV5y"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVGF25Bfpz49QMJ;
	Sun, 21 Sep 2025 22:16:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tc10q/mQLX72pBPsFCyxZE/Ms+taAgwcvFdmh8NY0jo=;
	b=Y6w/mV5yIsgtkSB+P39XLyEtucMYbKmdbsRxuVEZ72j7vTCptkhbhW/EGckEhPoVa0IVGU
	Q6sI/bk6WJC4DwVClptQyEPo86FE1AbWQClp32J12LhxdVoFYcoFbSjYCT2QqQcQlPhtre
	Zot5GobMHAXIGIfQJ26Oli2ttYezh/rAYow+D+2osvXS0fVw5VO4GP+V3DQopF3R7tXzvv
	sEF55CHhKEStPWtySQhHL8lk6TEYTvXHcLrbWVJ0ncpQoV3Zvag9Q93zrT+iTXa5xcfKmr
	0zXZfWc2xcoFXz5LtD+hJiyJmsuMFdPrgbJ1b8PEHluEm4scBWW3Zdnpqxtflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758482182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tc10q/mQLX72pBPsFCyxZE/Ms+taAgwcvFdmh8NY0jo=;
	b=c3h5guAOW8Pl/JNm5WNE3qUS1J+6TOaLjb29O51gT1kcH08IeufjZUqpA54pnzb/XJ5fJw
	YO6VsieJYYc8OgYixhSVgp1y5khSe2jY47NpAL8zTFXGIRPoV+gWppuJ+nxARi8LUm/JtE
	0yI9RVDTPjWFwWMEe/bkJsHVS18JpTXKXEYiseYQZcIfd5xJ6w8cbsOHdCN5Pwb6ESa2Gh
	GlQ9iDsxC8CO9+7zHoArtydnqtdM1COVo2TgeA9eS5XGOHZjNEZ+xyCiLaO8LY2xsHMit9
	D+FfgTUn4ddY/IDJX5JCkPxAvw3ce67ebrPXhhJAblbpjfF+79Z5UAZn8ih8hg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758482182; a=rsa-sha256;
	cv=none;
	b=M//sGVwC07uwmriHBQ9dq3YbYQOCJF4aCLVuYVn1hSqQDA/ekyCbeGVEBAuhCAZDgSizfh
	vQZdl54/7z2e7bKDfVZqPmO1k2iuD8EA+MimSk5xzmPJsZnWtrSk3DMmIvyJJWBI+vyjBU
	al2mA0OuhNM3ZA1+i2HQHA+7Y4DUIc+CEnFx6u/hGjLI7gWPrYN+hb/9eaONOEsbn/aJjo
	f9TU0pCsJFukOylIYvYWGgpvlJ4prC9ecwXxS6cE2iNM2NSbtdHCFk7pqwl8t7DRyO0lGz
	atLxbmMB8mRPlLsZgGtVQ/qJfjQXyP/OA/evXtqDGf4m+/gYtbNJ63FMds0y3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 21/24] Bluetooth: fix locking for hci_abort_conn_sync()
Date: Sun, 21 Sep 2025 22:16:05 +0300
Message-ID: <5a31cb6512bd21b2b7a0fc0706f32fed2240d633.1758481869.git.pav@iki.fi>
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

The function should hold hdev->lock except when waiting for events, to
avoid hci_conn* races.

Move locking to callers, which shall hold hci_dev_lock_sync()

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 13 +++++++++++--
 net/bluetooth/hci_sync.c | 42 +++++++++++++++-------------------------
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b6c3ee60024f..b39fb6843fad 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2926,11 +2926,20 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
+	int err;
 
-	if (!hci_conn_valid(hdev, conn))
+	hci_dev_lock_sync(hdev);
+
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock_sync(hdev);
 		return -ECANCELED;
+	}
 
-	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
+	err = hci_abort_conn_sync(hdev, conn, conn->abort_reason);
+
+	hci_dev_unlock_sync(hdev);
+
+	return err;
 }
 
 static void abort_conn_destroy(struct hci_dev *hdev, void *data, int err)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f4d984cee655..2d79667f16cd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5738,12 +5738,12 @@ static int hci_reject_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err = 0;
-	u16 handle = conn->handle;
 	bool disconnect = false;
-	struct hci_conn *c;
 
 	hci_assert_lock_sync_held(hdev);
 
+	hci_conn_get(conn);
+
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
@@ -5763,30 +5763,23 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		break;
 	}
 
-	hci_dev_lock(hdev);
-
-	/* Check if the connection has been cleaned up concurrently */
-	c = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!c || c != conn) {
-		err = 0;
-		goto unlock;
-	}
-
 	/* Cleanup hci_conn object if it cannot be cancelled as it
 	 * likely means the controller and host stack are out of sync
 	 * or in case of LE it was still scanning so it can be cleanup
 	 * safely.
 	 */
-	if (disconnect) {
-		conn->state = BT_CLOSED;
-		hci_disconn_cfm(conn, reason);
-		hci_conn_del(conn);
-	} else {
-		hci_conn_failed(conn, reason);
+	if (hci_conn_valid(hdev, conn)) {
+		if (disconnect) {
+			conn->state = BT_CLOSED;
+			hci_disconn_cfm(conn, reason);
+			hci_conn_del(conn);
+		} else {
+			hci_conn_failed(conn, reason);
+		}
 	}
 
-unlock:
-	hci_dev_unlock(hdev);
+	hci_conn_put(conn);
+
 	return err;
 }
 
@@ -5795,21 +5788,18 @@ static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 	struct list_head *head = &hdev->conn_hash.list;
 	struct hci_conn *conn;
 
-	rcu_read_lock();
+	hci_dev_lock_sync(hdev);
+
 	while ((conn = list_first_or_null_rcu(head, struct hci_conn, list))) {
-		/* Make sure the connection is not freed while unlocking */
-		conn = hci_conn_get(conn);
-		rcu_read_unlock();
 		/* Disregard possible errors since hci_conn_del shall have been
 		 * called even in case of errors had occurred since it would
 		 * then cause hci_conn_failed to be called which calls
 		 * hci_conn_del internally.
 		 */
 		hci_abort_conn_sync(hdev, conn, reason);
-		hci_conn_put(conn);
-		rcu_read_lock();
 	}
-	rcu_read_unlock();
+
+	hci_dev_unlock_sync(hdev);
 
 	return 0;
 }
-- 
2.51.0

