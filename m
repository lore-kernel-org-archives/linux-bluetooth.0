Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA150211A14
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771542999; cv=none; b=CnwzJ9TCR09JUSN4Qa6ugnhTfGUiNAfNoQRVeoEP8sQvN1/sm90I2mL+QlyXBs2QgqO4il3iP9XRYRw3iETDVIddTBcOSovhHeVEzbWTKCtoTlE2y0u8m3MPfj7aD8c+y3ztb0HWb6/Bi2Pr13d/9MBM2y0Z4ZA+f7xACJq+Jrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771542999; c=relaxed/simple;
	bh=7dZorciU2KP9lG1fvNnp7Hzt933HofYs8gLFRF2PDy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAcfjFCDsr2IIgq9PgWnqjm1pmv2uPYdR2l571TJ+9bq7M4nyNHCWlgT+aPHfIPxPUtt2y8pfeqOXkY33f1zSExb6VzPalifGloVNMzMzYwG549ZApumLrD1jGZ5zeBmnffLzwL58E4IdvgGiH7HVcDTMY8pkF96s04deBcR20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-404254ffe8aso955190fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 15:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771542997; x=1772147797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Os50U/6oPIcjA2CMN1raoU5d+8qh4ZaifQVvl0ajsGs=;
        b=MOWEBjIfw3f9kuj9BhljknDVrgx8c6P6/FsmPVgGIkvP+Z3Fgx/okZz5L34YSllvMb
         9H5uXIkA1i8Xa/7YRwlx7ILgIsWLTOnULqp7k0btfGKZQEGMeD/roweW3pvQ219VUBwk
         f9jQYTY5SNsQPA8MsfWReaFfsPXfZeApv0K8dMcwG6qNPXG4SxeWt8M9FjVUDJ3DjGsc
         cd8cMwG9Ami9QtZRldMg+UBxDWnPPPAjC6r0czkQLvCAQSjTsDlefXw2Nwz3VEVdjFLr
         L1F6p5mCJpJZfSF+SZlaGtsOML26PqNM4tiU5Y+xnxBQPTFFRpqwMkyNDkX4Iw74EDnO
         LFaQ==
X-Gm-Message-State: AOJu0YwLLsn5hUxCXRiXkRwmatzizDz/C+paA+jR28fqxazOFy/wGZ1x
	Ov0dOz2yP6j8WKehrYKihmCHgZjl43VwXz0VBgVevGwgqNFv7x5qvNU2cZysGQ==
X-Gm-Gg: AZuq6aKBgM9+fM/mVJK3dEf1vp16QmMbN+HeMj+Aa+QDqzqZzWfy4jUqTPBKaxQq26m
	LVzokp3bxFWPWvHy8hWxBoY/kOmMh+CYpcpSDpAgLsj/lnI0vb5gAzJxpQgv62ygdaNoLmfFIV9
	nx5uwX5zYsJwG7/sLVQ37IrK9s1M9g+Z6mVxYzCbbIhIRuYHaTdQd9PCprTHnzQ/axJmC6v/Hqn
	spybXHkDBr7ffjtmFgui9qrgCTADVi7r3HBKaY1TBd6zes3YQrAaSZS1+MIBU6QdiAkRyWjZ6Bg
	8z104c61z/+1Jowcj7rJ8pVoMFcgTYkJzdiqINQ5j/KrVX4LFYmX9Hn137bPu1TcS1RPeGTeXV6
	k4ZzpT6lpfKzT1p/d3zwA5npwhTzDKbuJ6iXrn1atFP1Ozqc1n96eFKMWSprydGfpP9QNrSzFz8
	gOspizCQe7DXokOjvqn2lvrInF11P2tvms+bqE9w1RmmZJzYc=
X-Received: by 2002:a05:6870:21d0:b0:40e:deac:4248 with SMTP id 586e51a60fabf-4154539da2emr2009359fac.3.1771542997672;
        Thu, 19 Feb 2026 15:16:37 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm26719644fac.1.2026.02.19.15.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:16:37 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4/4] Bluetooth: btmtk: add MT7902 SDIO support
Date: Thu, 19 Feb 2026 17:16:24 -0600
Message-ID: <20260219231624.8226-4-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219231624.8226-1-sean.wang@kernel.org>
References: <20260219231624.8226-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add MT7902 Bluetooth SDIO support by introducing chip data and
registering the device ID.

Runtime PM is not yet supported by the driver, but normal operation
is unaffected.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 42 ++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index e986e5af51ae..042064464d34 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -42,24 +42,35 @@ struct btmtksdio_data {
 	const char *fwname;
 	u16 chipid;
 	bool lp_mbox_supported;
+	bool pm_runtime_supported;
 };
 
 static const struct btmtksdio_data mt7663_data = {
 	.fwname = FIRMWARE_MT7663,
 	.chipid = 0x7663,
 	.lp_mbox_supported = false,
+	.pm_runtime_supported = true,
 };
 
 static const struct btmtksdio_data mt7668_data = {
 	.fwname = FIRMWARE_MT7668,
 	.chipid = 0x7668,
 	.lp_mbox_supported = false,
+	.pm_runtime_supported = true,
 };
 
 static const struct btmtksdio_data mt7921_data = {
 	.fwname = FIRMWARE_MT7961,
 	.chipid = 0x7921,
 	.lp_mbox_supported = true,
+	.pm_runtime_supported = true,
+};
+
+static const struct btmtksdio_data mt7902_data = {
+	.fwname = FIRMWARE_MT7902,
+	.chipid = 0x7902,
+	.lp_mbox_supported = false,
+	.pm_runtime_supported = false,
 };
 
 static const struct sdio_device_id btmtksdio_table[] = {
@@ -69,6 +80,8 @@ static const struct sdio_device_id btmtksdio_table[] = {
 	 .driver_data = (kernel_ulong_t)&mt7668_data },
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7961),
 	 .driver_data = (kernel_ulong_t)&mt7921_data },
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7902),
+	.driver_data = (kernel_ulong_t)&mt7902_data },
 	{ }	/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
@@ -1090,6 +1103,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	set_bit(BTMTKSDIO_HW_TX_READY, &bdev->tx_state);
 
 	switch (bdev->data->chipid) {
+	case 0x7902:
 	case 0x7921:
 		if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state)) {
 			err = btmtksdio_mtk_reg_read(hdev, MT7921_DLSTATUS,
@@ -1167,22 +1181,24 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
 
-	pm_runtime_set_autosuspend_delay(bdev->dev,
-					 MTKBTSDIO_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(bdev->dev);
+	if (bdev->data->pm_runtime_supported) {
+		pm_runtime_set_autosuspend_delay(bdev->dev,
+						 MTKBTSDIO_AUTOSUSPEND_DELAY);
+		pm_runtime_use_autosuspend(bdev->dev);
 
-	err = pm_runtime_set_active(bdev->dev);
-	if (err < 0)
-		return err;
+		err = pm_runtime_set_active(bdev->dev);
+		if (err < 0)
+			return err;
 
-	/* Default forbid runtime auto suspend, that can be allowed by
-	 * enable_autosuspend flag or the PM runtime entry under sysfs.
-	 */
-	pm_runtime_forbid(bdev->dev);
-	pm_runtime_enable(bdev->dev);
+		/* Default forbid runtime auto suspend, that can be allowed by
+		 * enable_autosuspend flag or the PM runtime entry under sysfs.
+		 */
+		pm_runtime_forbid(bdev->dev);
+		pm_runtime_enable(bdev->dev);
 
-	if (enable_autosuspend)
-		pm_runtime_allow(bdev->dev);
+		if (enable_autosuspend)
+			pm_runtime_allow(bdev->dev);
+	}
 
 	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
 
-- 
2.43.0

