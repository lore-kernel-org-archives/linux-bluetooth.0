Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BD47ECD8
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498392; cv=none; b=Wfd7u5eRzeEkNB2NtWrgXS/zJkyU+q0L8/w3Koi1of4sigklB++VqJpD/A7ckM+wvfYHe8ezszBNCfEINhGIsZoCo8raAsOeKukVh2QeBhYvYDV2djPyNMXWDpfBPwgF9M5QSQYCygxEs2xhBcbq6CQaIaSQuhqUqj7/lDfZw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498392; c=relaxed/simple;
	bh=wZ6CozmUkheyMWSqRGV6kcV+PJZj5pgj7ODypAQ9KPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCWCMPTGRDm3jL8ftsjPYxEFhpkyKw6MEPqSyW6brtRwveAir4FZVN0ErcuXFhwLVKCggcQ8pGY8Xq/k98m8GUcUgs116VPxbKz7hwgK/+f/Z5XY5QXpyGPu+xF1y05Hw+QWKEicInqoUNrZ11rniNrDPX1oZ2jyUlVaLZgmaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaXd3nQ0; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaXd3nQ0"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-34c522572bfso203171eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791498391; x=1792103191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozb/59ScS84H3e/TnN2LeOjW0OQv9TZinl1O9+31lFs=;
        b=UaXd3nQ09iOw1lFAqRXmtEj1DSmAZBscnVUrNv3ht0i/EjoF/tbmQQ/BWuvXrBoVjk
         noMbgx+ssYP8fm8+v5mIKlMC6ObGD0xRmca+1FHCwWu2qHZ8ZOdCAXekj4ezAqaLQ1Es
         tTASPrzJIHFMkvp0bE4TAVFhthGF9ww5Mgh9Ibsp6dh5lCjogzbc0+1M3vHGGTgoiDR8
         r+tJKmb9eV84zL4+Yfd9R/WWcYUBL3GfzfnvxVndsalIbl+63mbsl1vqnJZ9V+2V3wQK
         4oXhJaYxzghRVE1oXlUejenxKYcytQ+UR8Idq2x+TR53X5Z+FU2v0a9+ioR6W09kK8Nf
         RK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498391; x=1792103191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ozb/59ScS84H3e/TnN2LeOjW0OQv9TZinl1O9+31lFs=;
        b=pab1NCuIHJXLK0TOCXg1orZaXXrv7jrLvAiHojyzFXRU1JwmKxdQEo3xuOR6csTWtp
         570PE71/sjT5qzol5cwg1Al64URhtFtSnAqVGmbrVUr28xycKxHVZS+DB4lcI1RWOTf6
         irF/L+WPC4ov0sBBXdmdGSXVAAQVRI+o8d62TGlxUH7YfO09gWj34KvvgNsXtT0Rujau
         7MJAFxYW2WrLyZzbVe5sJ3QNuRY9a2G4gBxiBQpe17yuVjLNc1r1Df6lG24QGAokT1nV
         p1i1kGLkpFXqA+/JQSpuCznxx8SQV9Zd7UJE1lls/g7N3a5Y5oJlpbWdd8g6/e7NxRrI
         0lQw==
X-Gm-Message-State: AFuF++nYpns1rFK4RY63glJYyJ2OxcYmN83CFSzj+NBIjsLey8CM5ldB
	Axm3EP7Yv0wGhMpGy9VkxP9wkkgke+a5WremoR+OYAGwJQOO2SInjUItEf1qvcoK8q8=
X-Gm-Gg: AYBFou3uv4ftDCFa4HvgX01c+6xR87JtVzOqVKZqo8Gip64k7KlA/mVWaEGaYA3C7Rq
	Cya+6HexPyigw9x+xfu0uQcUUFK2xFwyofhNDK70rtHrifwxiMUm2wVsNVj5zwbMlaBucCDBsu2
	uBE1gu+Wpv7WTzSy5100zwXgfyBipuh/SACUYvnRAv3zOyp0ItC3Yt/1Y+FgtSKwewZU6oRrBI4
	Ax5AjwHuz/VIZqfsoL2v5/TcwHq+xWMHmudkTsQKVqAD+2ziPpJEJZ4v52F0Rtm7pekjUe7+sdh
	w2azO/L1XNvCnxRwcGscnOKpLOOC6FtSyyr2O8vwETjqTETUcDJKLWIRq0OfE+gaejDfiysksWO
	2MvP3Qq2LiLnw1kD1jdHtGnC42oyHa+RD5NBAYH1DDXdFGFSRWNJ+v5xLSHFuLzpphKx9mPghLL
	yE2LDWRmIdax0XpNcaADC5OxjczZmQBsGTKAVum4JThnjP//tCnBZGkZRo6b1yVYkjmHrPH+TTe
	U2BzzxZjEu0rQrWpxUUBXnkvD1bASvS5a/dl3DN
X-Received: by 2002:a05:7301:4547:b0:34c:f181:85e4 with SMTP id 5a478bee46e88-3537dfe9152mr522839eec.1.1791498390464;
        Thu, 08 Oct 2026 15:26:30 -0700 (PDT)
Received: from hitalo (208-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1d6e6sm985148eec.24.2026.10.08.15.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:26:30 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v3 2/6] Bluetooth: hci_conn: Don't set up a SCO link that is already up
Date: Thu,  8 Oct 2026 18:26:12 -0400
Message-ID: <20261008222616.2780570-3-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008222616.2780570-1-enghitalo@gmail.com>
References: <20261008222616.2780570-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
aborting connections"), a SCO/eSCO setup abandoned while pending can
complete after a new connection to the same device was made, and it is
then matched to that connection by address. The new connection's own
setup may not have been sent yet at that point: Enhanced Setup
Synchronous Connection is sent later from the cmd_sync queue, and any
setup is deferred while the ACL leaves sniff mode. When it runs, it
sets the connection back to BT_CONNECT and sends a second setup, which
the controller rejects since a link already exists. The connection that
is up is then failed by the rejection, or left in BT_CONNECT and later
deleted without a Disconnect when its socket is closed.

This is the order of events in the report: the second Enhanced Setup
Synchronous Connection was sent after the first setup had completed,
and was rejected with Invalid HCI Command Parameters.

Don't send a setup for a connection that already has a handle. In
hci_enhanced_setup_sync(), take hdev->lock before checking that, and
check under it that the connection still exists, as
configure_datapath_sync() runs without the lock.

Closes: https://github.com/bluez/bluez/issues/2562
Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_conn.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 29da3fe2b..399c7db77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -290,6 +290,22 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 
 	configure_datapath_sync(hdev, &conn->codec);
 
+	hci_dev_lock(hdev);
+
+	/* configure_datapath_sync() runs without the lock */
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock(hdev);
+		return -ECANCELED;
+	}
+
+	/* The link may have come up while this was queued, see
+	 * hci_sco_setup().
+	 */
+	if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
+		hci_dev_unlock(hdev);
+		return 0;
+	}
+
 	conn->state = BT_CONNECT;
 	conn->out = true;
 
@@ -302,8 +318,6 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
 
-	hci_dev_lock(hdev);
-
 	switch (conn->codec.id) {
 	case BT_CODEC_MSBC:
 		if (!find_next_esco_param(conn, esco_param_msbc,
@@ -625,6 +639,12 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	if (!link || !link->conn)
 		return;
 
+	/* The link may already be up: a setup abandoned while pending can
+	 * complete after a new connection was made and be matched to it.
+	 */
+	if (!HCI_CONN_HANDLE_UNSET(link->conn->handle))
+		return;
+
 	BT_DBG("hcon %p", conn);
 
 	if (!status) {
-- 
2.55.0

