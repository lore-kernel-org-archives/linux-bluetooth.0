Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F532149DEF
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310917; cv=none; b=YVAx7SMafTxXHuq73wj1YSNkJ1Igofmk35ImyZUFF2fTtd3SXL2iDX5NR4B5NKLqMJ+djFDcBe5KJu+/pNf1nIEz475i+l8LXt/RuAO42afhekqJhiKILev4AgzXkLfdxO4eCR2EwLKjMmFm1cHs0nLF1uSkiDsljNavAXWII9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310917; c=relaxed/simple;
	bh=7eV+FC8D6zjFgWnptjlUDQlEzJ1ee9CaqujklxBCwc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/pGtbEbU6EGkubLgOxnUCrNSmE/GJKoovCVEHjOZsOzn7/PMy0IFs/bDaKCixG7tljMrkJfClUu6j9IgX105bxPmYV+Z+ElO0FCYbBqIzWCmsYCsVlmuILrp+WYYvn07p/RZT6zDfurSE2dq8dy7129WjSYp8B3XYAn7h9evK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L/DsslZ1; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L/DsslZ1"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1f70c457823so37358465ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719310915; x=1719915715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+VjACVZoPp7eN7kJksXj5MfvnAImL5JxKUjwBijavO4=;
        b=L/DsslZ1xJ/RcgZWEc4OFvYGI9wRjWwxXzhejYpuLjnS7POewgUElXfrxZntPaE5PR
         Ja3ClYsYtcgZ2UkoK0N5VbfR64dV/slOPgJerqFKlo2IhArYLZ/sAOoHUAK3wP4gOSlB
         H/qSzk0q5H8BZy+UeSGvfJiem4mYTBKsDUhbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719310915; x=1719915715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VjACVZoPp7eN7kJksXj5MfvnAImL5JxKUjwBijavO4=;
        b=egv78hzXT19xnHH0A6CqziwtUBykjUoObzJAKqQkoNe5+aqPGIYTlgsxbA1YUL3nsA
         8p/tjtcuHZNwsf2GzvONShp5W+PwY0/cLkdSNKkY7BJOaahtx/RienouYk4TwCfTa65f
         MoZTZXuuTJhXxCiGpylFSIyy1153vzdXbvQ9Fqs5VIutV3WfFnW7Y9iSDLpeTrHIDyNr
         5H1XWwAg/9MemHlkfPdg248tBGiojGawcp9+PSw0NvG1LChekUKMiVN0JXha9CiEDGE5
         cImTdHoKP6kieD+CQjo+hqpPN4fSvvjisW0PNqpgckUN6ReSwVY7mgVju7gaiQnDhv9j
         MXqA==
X-Forwarded-Encrypted: i=1; AJvYcCXUtrMN3O13unzZ6gBrGPW2gJwCzjMMDChF8haGc2YGuHRuIGnf/Vx9CdcadNT0lRisFXzJvaQuAmpTnVtTzMso8fmd1Rs0T5QAEa7OuCFd
X-Gm-Message-State: AOJu0YwXK3KpTuLOklBXpsPZwrRNSu8VImV23M31zaiMTzY8wgq6E+2h
	PGpRMc39RmxnSR5XhBksrlycBL4YYMA8pQvc11nYMZRoJ+XoAdpD5srCm/8Wkg==
X-Google-Smtp-Source: AGHT+IGncBwvYK00pVmw01gvxPmXxXQ/V/u6BoVJ3vRhjdCIb8ngRmdVTYU+9aqp9QEJNIvJV3icOw==
X-Received: by 2002:a17:902:d50b:b0:1f7:4ff:d03 with SMTP id d9443c01a7336-1fa23f4a0e0mr73386365ad.67.1719310915385;
        Tue, 25 Jun 2024 03:21:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ea5a:67dd:bd1e:edef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm77590855ad.110.2024.06.25.03.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:21:54 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@kernel.org>
Subject: [PATCH] Bluetooth: btmtksdio: Lookup device node only as fallback
Date: Tue, 25 Jun 2024 18:21:45 +0800
Message-ID: <20240625102147.3496597-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the device tree is properly written, the SDIO function device node
should be correctly defined, and the mmc core in Linux should correctly
tie it to the device being probed.

Only fall back to searching for the device node by compatible if the
original device node tied to the device is incorrect, as seen in older
device trees.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This follows up on the MT7921S bluetooth binding and DT fixup patches [1].
This should not be backported.

[1] https://lore.kernel.org/linux-bluetooth/20240412073046.1192744-1-wenst@chromium.org/

 drivers/bluetooth/btmtksdio.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b4e560a17aa6..d81fa8dacb4e 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1330,6 +1330,8 @@ static int btmtksdio_probe(struct sdio_func *func,
 {
 	struct btmtksdio_dev *bdev;
 	struct hci_dev *hdev;
+	struct device_node *old_node;
+	bool restore_node;
 	int err;
 
 	bdev = devm_kzalloc(&func->dev, sizeof(*bdev), GFP_KERNEL);
@@ -1413,13 +1415,24 @@ static int btmtksdio_probe(struct sdio_func *func,
 	if (err)
 		bt_dev_err(hdev, "failed to initialize device wakeup");
 
-	bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
-						     "mediatek,mt7921s-bluetooth");
+	restore_node = false;
+	if (!of_device_is_compatible(bdev->dev->of_node, "mediatek,mt7921s-bluetooth")) {
+		restore_node = true;
+		old_node = bdev->dev->of_node;
+		bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
+							     "mediatek,mt7921s-bluetooth");
+	}
+
 	bdev->reset = devm_gpiod_get_optional(bdev->dev, "reset",
 					      GPIOD_OUT_LOW);
 	if (IS_ERR(bdev->reset))
 		err = PTR_ERR(bdev->reset);
 
+	if (restore_node) {
+		of_node_put(bdev->dev->of_node);
+		bdev->dev->of_node = old_node;
+	}
+
 	return err;
 }
 
-- 
2.45.2.741.gdbec12cfda-goog

