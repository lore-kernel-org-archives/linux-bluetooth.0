Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AD82890
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736998651; cv=none; b=Z8fmMAlSKJ2hhSicjChx+0jOTbam+4oYUGn8LSwLcND1othz4bu9PjWrVckXfYMu66bjF29mBlxT41PkVPUd8d4WTMWPX4wdGhDVnrVNBS0ezJYYdn+IXgI3cfBnyujt80s+F9f/9y4a7KYI7PaT1hVqRqjelphxCqdNnnmQ7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736998651; c=relaxed/simple;
	bh=E7WVfIoqzabC6mXWmDhl2Wpx7yRmk6LWAEIR0rWoAPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njM7JIf/o0ZQJkHPQiYjGqrmRtL+PM8/pBF0MhpJ++x+vnOvbLYGWucU1G8VR3Do509SrW2JLYmLmlS7EqHmaFJjFw0Jcs6OtDLkKVInaZdiPOLiVJHo9U1yehVQQrgeXVI4YtxjfmFj7Qb0tGm/ln4BflOO1bxjgz/5vJjYC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ow6Hq1WC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ow6Hq1WC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso6200915ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 19:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736998649; x=1737603449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHN8VwPtCZBq9Z4WoEOrhUz545+6IZdCnpT0dOgO/wY=;
        b=Ow6Hq1WC1XY3hewjy7L/aahcywaU3A+0hNpOh9Y1ToZ7Ywc/PJyB0CRox8xVwTjG1k
         CfJUQQFKUX4ZUWR1YKwz72DbnlMIUYaT0tpjxRXIazxhuVzPiAYyHCaN/+TrdRFGMhRl
         /Ib36Q+BTiZjHTJveV+KykUEHm86ttspVpGQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736998649; x=1737603449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHN8VwPtCZBq9Z4WoEOrhUz545+6IZdCnpT0dOgO/wY=;
        b=FT+n+mCQHRPi3mKKWZsxmBGf8sYLQZKQdQz99Hh4GiCrsbbxmGaBlzYax2E2dGhkpk
         GXwDT1h5mQGEc/iIMDT4v0AoPLpOlxrI2JA9kcLCjEqZCxfWJqBQfTtx+2tAmsBA5N3+
         S7f9W/I5GDGuWeXUAz9JEBhSlFsF2sQEXKzmJhaUfe/JXxJHuDUBA9h+7RyhFtqSOPzS
         Ly1G4kkoXzE2tIlx5uOu+UQT32FksinbIcT4py0vRQeiz5hqGOhXh5IMrmbT/+FQ6Smr
         y6xVJcxYNkZUrRrQYtxsLtYV2rhstMLvqMY6pWMPa4ILGu4cbk7aCZnYCsA/nNvfQSd1
         2Y7A==
X-Forwarded-Encrypted: i=1; AJvYcCU5Zzm7u9UkB/1I3U1kpkigtJSxv3MBhfZ9n2y0MXnFbVhiFtTBxUnG27xZs4GHW0ETihJQQh1VIQOVaf+c5oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9CyPSG35x+fcEQvKEEDd3iPOPh+fhYcLWVVeg5J0c1KYhoC+H
	MpRdCdVHvfn5fdT0QZfCbipsPqos43CqBXMotI8nOOtJSZ0kyiUdRG5xaAYu7A==
X-Gm-Gg: ASbGnct357g7vOm4QYY4qewp6sb/HxvVUeDZ3tvd0OBqbrIyFIO3uqPI30rNWhw9z1n
	QFA8s8WBHUZx1ojvQnslygFKC2AzgW9QBaeJayZ5DarhGxUCdksA9LLse9YSUEn7SpIODlrtuln
	tjJCsQVbX1VeTLWYvemDDCPg/6bITXW7KMc7voLEOsofmLodYP97FSKIHiBiTJlT1vXxdXY8wRg
	n8AKKDLwT5u77bxD7xHlwhZFCeFAjyjhWeujMM12U7moMfNJ0DcGy+28hgEsPVcpII3Vnmz4VZj
X-Google-Smtp-Source: AGHT+IGPHIlyquGny12YcL75NXc3XgLlu5eAhXbesmptiMTKimMfUbrOU/zhdc5d6pmMnPuAyOKk6g==
X-Received: by 2002:a17:902:c951:b0:216:5b64:90f6 with SMTP id d9443c01a7336-21a83fd28e4mr487517675ad.45.1736998649039;
        Wed, 15 Jan 2025 19:37:29 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:534a:ac09:3752:7758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2339dasm87714485ad.177.2025.01.15.19.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 19:37:28 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()
Date: Wed, 15 Jan 2025 19:36:36 -0800
Message-ID: <20250115193636.1.If8b655b5c6877bd9a1136ba0f1cd61cc6a4b6e9c@changeid>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for usb_driver_claim_interface() says that "the
device lock" is needed when the function is called from places other
than probe(). This appears to be the lock for the USB interface
device. The Mediatek btusb code gets called via this path:

  Workqueue: hci0 hci_power_on [bluetooth]
  Call trace:
   usb_driver_claim_interface
   btusb_mtk_claim_iso_intf
   btusb_mtk_setup
   hci_dev_open_sync
   hci_power_on
   process_scheduled_works
   worker_thread
   kthread

With the above call trace the device lock hasn't been claimed. Claim
it.

Without this fix, we'd sometimes see the error "Failed to claim iso
interface". Sometimes we'd even see worse errors, like a NULL pointer
dereference (where `intf->dev.driver` was NULL) with a trace like:

  Call trace:
   usb_suspend_both
   usb_runtime_suspend
   __rpm_callback
   rpm_suspend
   pm_runtime_work
   process_scheduled_works

Both errors appear to be fixed with the proper locking.

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..f69df515d668 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2638,8 +2638,15 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
 	int err;
 
+	/*
+	 * The function usb_driver_claim_interface() is documented to need
+	 * locks held if it's not called from a probe routine. The code here
+	 * is called from the hci_power_on workqueue, so grab the lock.
+	 */
+	device_lock(&btmtk_data->isopkt_intf->dev);
 	err = usb_driver_claim_interface(&btusb_driver,
 					 btmtk_data->isopkt_intf, data);
+	device_unlock(&btmtk_data->isopkt_intf->dev);
 	if (err < 0) {
 		btmtk_data->isopkt_intf = NULL;
 		bt_dev_err(data->hdev, "Failed to claim iso interface");
-- 
2.48.0.rc2.279.g1de40edade-goog

