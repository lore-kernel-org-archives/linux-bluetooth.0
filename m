Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03E29BD95
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913679; cv=none; b=LqBoAsiUYZETilNuyZjJv/W+vX5+3hDU5uV9jzI3XEbHXARYm8sIWrGdLK5QcCBuky/RuQzeYENYw/wEktQR8GLjr//sHgfV2n2n+0FjtsD7fV0KjgyCVh/WmEbirYO1m5N6RQ40J8O0rZGwDqdhtfKWTQubFBXmW0V5hkDxS+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913679; c=relaxed/simple;
	bh=0PBvdJqAbSRqDqNaFsvrlM8Zju0hcAR5wr7VhLHEc6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klvt9Qguqp/fBaNjZh+MLHOCMQcBE14H160fBbaAhVLe4RWfT6VILeyrPX7j8qGaYgpuZKjXNV08yTALAgYuduXaheS6rzapHmJYePzMThN2uDAP6A7k0cweezAiC7w3SKlVl8+eovPeQ38JNF6+5q+peCSVJcOxV845jOMboC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-679b072ed3aso2686294eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913677; x=1772518477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQv1yJimGlxvy4yGPgOsX/UNrk5wbgDTKKecRY0I1tE=;
        b=JPZLCkuywqcC8HcqiY/+OCem11zWWXyULydG43Dom61ijyCge4vW2Ip/s+yvACdhcO
         lpNNtP/3ifFI9HueCW6j2+FR7b5GdDChR94Nps02VfBWX/J3E0sDtBPSzgivHp7f4yRD
         JySu53nwVl8IhjkxZ4fQBxxZUx1fE4M6ooe9yfAsmfoFWhJSPgZv1P1fxaH+43xC1DhK
         jZiiYq0zmBV492buVkUw/MMKB/tbSYEscHcKKTrifiPa4CNlKWhBOYt575929WtniV4D
         DvCpjTfESOTWZhCciJnX4SmfxHZEdjAVVRotRBPgFjg5DDE83uqfFEng+hMGdJHu8Thb
         vEgQ==
X-Gm-Message-State: AOJu0Yy83Lr14OHhtymxtf7eiIq/TXuwRDjE7nRHxJWC0cyw/ZWnowD8
	CTAU1UJnIYH7AwEawmRonwXLyFL0/vyCP/8peIEHoUPOuGDqgWTt2I8B
X-Gm-Gg: AZuq6aITiOWxk4PxdZnb7uAYQOC/UzmhGumgIISEXOp7/oNxJ1E0sTfqkm7/dFOJWbe
	Fz273yZibju2SVscp7NBZybB8ttsGlJJaXF9WxMjg1/yOafMrKGKB1ogwlRSHY0kUYfbc2MEBbd
	BzpLN4hij76SkREVmvhMmV4d7Eb82WAB2rRnmaVNAUtmVqGlVIhQWfktHrepjZIXzDsOzwgjnN4
	zjfBTCe6XfIQ0lOW+t3OOrRnWZtJNgfpbL0ohmBG3ZYtZ4/72DIra/Ct2nsNa3hFTp0k54PiJnz
	Fo9s7qKwkSgyxtmr2doPnFKTVU6vZS0omKLpCoFxR2IP0m3WG4REY6VZdbBBCsGSgAGcebm4dXn
	Xql7exuArC15HfOowCu+QdDo+jTloeqJOPB7z3LuL1vcBiaL7t/xL05kG/2zcfEgVrXpsieALu1
	AxnqpFq/2KVVgVR3JyFQGkmAB1wGxDOgJOD9e5etqQe0SApS4tS1wrk7JSeoElhqE=
X-Received: by 2002:a05:6820:4c04:b0:661:1d0c:a5af with SMTP id 006d021491bc7-679c461247dmr5953555eaf.69.1771913677584;
        Mon, 23 Feb 2026 22:14:37 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:35 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 8/8] Bluetooth: btmtk: add MT7902 SDIO support
Date: Tue, 24 Feb 2026 00:13:25 -0600
Message-ID: <20260224061325.20189-8-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
References: <20260224061325.20189-1-sean.wang@kernel.org>
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
v2: no changes
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

