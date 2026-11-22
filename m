Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378435;
	b=zP4zTWLIXxwGvhpGJU3xyIAuv0PtW6sJ1N7kuG3OxqkVDh15SVdfcNwuqVbLGQ4R+XL8
	 B8LK0YUBuCQ+AZXqV7xmC2Hh4RbxIjXClAoyVYYsow+njZpMjStEJTx5MhuWGF5jO2+KO
	 GXKZP+p/NvIDGhTpCfDQgbKirRCNrraVnSTSxq0CfqxIE7ZQxQF+lpqNr/nsu7QYylYNP
	 5MeJFCuq8ihjp26Lxka5wzvyCWarSkJLlZC9YHo+K9Tt7fGJBf6KTVzmaZn7k8qYjEdUr
	 E9LJ/4ZxAymogZELHXsQYU8P3wZbSxZVYHoiRBUSu2yL/rP2ZGQbaVUxxJaDrOBZWMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zGxB9qpR8V6B4eA4vMaAQ5zeOTn8Jc0XIl5eU+LUSmE=;
	b=KzF5xoJS3psKfEzOn2J6EYTP9Tp8suj1ImTiNVK071m6fkWm6fTEBZwZV3ww99ikyXiE
	 Qe1RJU5o0W6HMpYH9zZs8Jr2PiyS1fl/sWGpqwYvckmNI9D+QGsuCISa1/tPAXYEylKpB
	 GjHgjJaDDqWSj1w2xuvOzDIBlbaddAitD6m4ABGYsNLaQk8YS/pjJDZCmEVyrXugMgSSD
	 S0AwjNELN1Jk3gqHopym9FUhjTAy738PdfR8C30ijiT6+od3RmT0JKr5JpDe6Nyk2qjmj
	 3fzzPwoYCJSgtuW4PRV0aLMQYmOLeyNs6mwoslAFFu2vgQzSvZ8OW0xzK7wwKkwKdKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Y7bZYvD6;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB9606A31D
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAB9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Y7bZYvD6
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so24747325e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378433; x=1795983233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGxB9qpR8V6B4eA4vMaAQ5zeOTn8Jc0XIl5eU+LUSmE=;
        b=Y7bZYvD6Tt1Exh4wmD15HKb6lPEYDN1kMJIticBptm9XRUMZ+N9Cx0gE2xABTgLZU/
         mR5EdwICD2jVrC623Ul+USdkgEAQV0By/VOr3eUheSnDxsPgM8DYjzLIgLdCsslTxWle
         txwd+tgdtPyoxHKgboDt1fwo6ZcXMUanETqIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378433; x=1795983233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGxB9qpR8V6B4eA4vMaAQ5zeOTn8Jc0XIl5eU+LUSmE=;
        b=DczkOpH/Aw2kD0Exy4MhFXFpuUyt05oR7SUlsBSX7d4HDH2QBsLPMAMEPNeucYgvaW
         3jtk3uKp+JQ/o6CipLMDmqrdhVvOJu5iB3emTAmq82pXpA95V2QanWe11bYqHpbh8nvc
         NOJBOsAFPMTdEdGNPSyygTYMKLaXcRT8fB3Ibr04G0+2YVAxvxOc8WFvQ8+mf0DK1PoP
         tc1gWpLPgRWQHMD3JtcbfYSQoDRWYg7+/GQ+K1lEL+hN1Gs2RvmnW+3+kaxMShiM86xy
         1lQSzl7/134Yye8Yi4QvOvnvdAl1kf1Au2c59sS5FJ+XCoM4AAEEE9s29pGyyZ65tfdA
         B0uQ==
X-Gm-Message-State: APuU4Z+IkPDv3wPJ51RyeOIEwgVSL9+rAhX6mRdo9yhePzp08h7KIKzi
	eKIIjGnhD2qcNjidMAKiWPcuhhtyfJYVnxv//klUU9vqwksXGwNeo9lzVWDbLL9rEuqqq9MI7Wq
	karuL
X-Gm-Gg: AZFdTZdlNtS1MgV0gweH+6RDrOaCq4Eax9BVN0g8Do3QpjfErMnMxZIjbpk2F9AG1WH
	fWleYfca1zbLeX3nZ5Pkb8fwVQj1by9ZXGuHAsmchi8pnY3RkQp7k4oiCgsMc+ZUdzeHN3jE6te
	S9eSpIFIMEhhkmwAOTg62zCRpZb83SfT6pJ3RTC6Y/9TSTamIPZxo2l8fMHsWSIHcFm2p+d6yDx
	MwnvcuwaIenSOvGB/WUHeNWmjQ3AcGKHJp7T90mib6cZKmC33EYdeNL1txPjf2rmWvQJqEl0oPV
	ktay51IRPAVbHfX28qHFk7OUvRlcvUzeq87kwLwfHqghyB/h2APj3zVra4vAKqDI4EQurNnLzSw
	7KvkVgYMBVHgrjqgnjJqGfu5hyJX5jo1fDQ5zFRfB9YLTJURlPwu7KD/1yCdRhy1oz7DiLNBH7e
	MFLelBvM90RdB9t7JHRx/wxTbHmRMppvNE3w20HJTnYkVbSAfEAkA700osmLfnDYIsdugJbQQ/M
	Z+LbPh9bbFX9q9p6z9UV/wUM7aqNt12aLTKPbt4UAhbIo6YpFawkvt10N3r5tzYIwYehWLWuSfg
	//LiuQ15GnkOL6cc3rNVRB4+Od6cWvyGMOM9Gw5xT2ARzdCPRg==
X-Received: by 2002:a05:600c:64c7:b0:4bb:68b9:f610 with SMTP id 5b1f17b1804b1-4bb887ffee2mr190319645e9.9.1795378433342;
        Sun, 22 Nov 2026 12:13:53 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm18812737f8f.16.2026.11.22.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:13:53 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH 2/3] Bluetooth: hci_conn: Terminate a BIG before its periodic advertising
Date: Sun, 22 Nov 2026 21:13:49 +0100
Message-ID: <20261122201351.2854661-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122201351.2854661-1-simon.mikuda@streamunlimited.com>
References: <20261122201351.2854661-1-simon.mikuda@streamunlimited.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Dzik <michal.dzik@streamunlimited.com>

terminate_big_sync() disables the periodic advertising of a broadcast
source and removes its advertising set first, and only then terminates
the BIG: the same order in which they are created rather than the
reverse. Every BIG has an associated periodic advertising train, which
carries its BIGInfo ([Vol 6] Part B, Section 4.4.6.9), and the BIG
exists until the controller reports HCI_LE_Terminate_BIG_Complete
([Vol 4] Part E, Section 7.8.105), so removing the set first leaves a
BIG without its train. An AMPAK controller then fails to terminate the
BIG; its vendor requires terminating the BIG, waiting for
HCI_LE_Terminate_BIG_Complete and only then terminating the advertising.

Terminate the BIG first, and make hci_le_terminate_big_sync() wait for
HCI_LE_Terminate_BIG_Complete, as hci_disconnect_sync() waits for
HCI_Disconnection_Complete, before the advertising is disabled and
removed. A controller that does not send the event delays the teardown
by HCI_CMD_TIMEOUT, after which the advertising is disabled and removed
as before. hci_iso_term_big_sync(), which terminates a BIG created after
its BISes were closed, waits for the event too.

The wait is done in the cmd_sync work, not by removing the advertising
set from the event handler: a removal queued from there would run after
a new broadcast started on the same advertising set right away. It
would turn off the periodic advertising and remove the set of the new
BIG, and receivers would no longer find the new broadcast.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Michal Dzik <michal.dzik@streamunlimited.com>
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 include/net/bluetooth/hci.h |  6 ++++++
 net/bluetooth/hci_conn.c    | 17 +++++++++++------
 net/bluetooth/hci_sync.c    |  9 +++++++--
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index efb85c781e4e..36a5668779a5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -3335,6 +3335,12 @@ struct hci_evt_le_create_big_complete {
 	__le16  bis_handle[];
 } __packed;
 
+#define HCI_EVT_LE_TERM_BIG_COMPLETE	0x1c
+struct hci_evt_le_term_big_complete {
+	__u8    handle;
+	__u8    reason;
+} __packed;
+
 #define HCI_EVT_LE_BIG_SYNC_ESTABLISHED 0x1d
 struct hci_evt_le_big_sync_established {
 	__u8    status;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8024fc4223e9..5710234bffc3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -769,18 +769,23 @@ static void bis_list(struct hci_conn *conn, void *data)
 static int terminate_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct iso_list_data *d = data;
+	int err = 0;
 
 	bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", d->big, d->bis);
 
+	/* Only terminate BIG if it has been created. Terminate it before the
+	 * periodic advertising that carries its BIGInfo, in the reverse order
+	 * of creating them: some controllers fail to terminate a BIG whose
+	 * periodic advertising has already been disabled.
+	 */
+	if (d->big_term)
+		err = hci_le_terminate_big_sync(hdev, d->big,
+						HCI_ERROR_LOCAL_HOST_TERM);
+
 	hci_disable_per_advertising_sync(hdev, d->bis);
 	hci_remove_ext_adv_instance_sync(hdev, d->bis, NULL);
 
-	/* Only terminate BIG if it has been created */
-	if (!d->big_term)
-		return 0;
-
-	return hci_le_terminate_big_sync(hdev, d->big,
-					 HCI_ERROR_LOCAL_HOST_TERM);
+	return err;
 }
 
 static void terminate_big_destroy(struct hci_dev *hdev, void *data, int err)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ea2014e74d32..bdb173440176 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2314,8 +2314,13 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 	cp.handle = handle;
 	cp.reason = reason;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_TERM_BIG,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	/* Wait for HCI_LE_Terminate_BIG_Complete, so the periodic advertising
+	 * of the BIG is not disabled while the BIG is still being terminated.
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_TERM_BIG,
+					sizeof(cp), &cp,
+					HCI_EVT_LE_TERM_BIG_COMPLETE,
+					HCI_CMD_TIMEOUT, NULL);
 }
 
 int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
-- 
2.43.0

