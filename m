Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC681684A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683787; cv=none; b=PBjiBr1FgeJiqygxzEyVAXWyixGT2Ke7P4MlqOXmnmKSshNM1UFAXKwOHEyrkE1Tgh/R7C5ozJFIRZf4jefiIj8sZotDkb3lqeaee+7CuqktCeJvyt2ijuiOtqBIUzdtahKyeKVujxxr3PHw1j8dUq7ZppQybJ3jGtwg5uQBiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683787; c=relaxed/simple;
	bh=eJWJ5O7IhSzIyCjxLeR9OylqZkh5gY0V+stMheEKz2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muRE8V1togysb69qYFjHzxrS/8Kcnpy8gqQ6YaZYx248RHhkJ42nqi2j2xIMml/kTcxo2s+ku0teWiv0EOffvuIv9+i1Oa0GDupm9+EZLZ9bsJn+4GsxDrZz6YWxtOyrbnbzKx1zRoPZfyxNZF3Kl5uHEar2OCbRWkzMgRb0r+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R5lf32x0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R5lf32x0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cca239886so2337396f8f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727683782; x=1728288582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3cG+kWNy0aWF/w1xI6GPRKYc2TRij9cCl7c9R+dadU=;
        b=R5lf32x0rWEJ9SkjDTI9tNTFIfqZ4iBPKvcugL5mJPBg0cL1sCSAS6lXvNaUzRoggO
         RpHOeS1zHejl/AiB1MCs7RIdXC7sDyDOYX6Fa+wpOzbbLxK9yQtTvE2KjneceqVefSZa
         yqWqvw3FjtpDYURDvsETVSNXfFSMDJ1TgvjbYD8/+KTi4gPCisaX9tkqDzVgKYfbkmPJ
         rm6SltDAbTUhal1HJVksSGUQzlJrgxOgR3K4G/rSGgnyFVU+6b1chmrCazmm6IusggNS
         avCkPSmQ7RN4T30uxv8K7v5/xPCprxkKVXYj/1PhGcwS9Cyr2OrxpMKqCxmje5AZunUd
         /2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727683782; x=1728288582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3cG+kWNy0aWF/w1xI6GPRKYc2TRij9cCl7c9R+dadU=;
        b=fV9+8iogHRlcc2Zl2d//XO4qEVHkzsx8Ob6pBsCmRKJ3X9vdD0iWVzh5f44v0jjbCH
         hNooNDfTIJ5FCW0cDNxcdyRXeB1mE32VdXjsTZaAKcIH10+TtX7GMXBhcUvuaFcE72zF
         b6emsqf546tbWObRwGgbDfMRk8IZHoE9kgXS5QiX0Vhj+OhWeW2fxaTmlXE9Sf+RpSlk
         Z/VWlHC6ivgHBNo2fqhyohY5ZTxvOSV7YYu9jwMTiesihLC75unvjtDmu4PmG3VMJKUi
         K5JlwWuVTktZbOfQlX0dOKYB9NNngMp7a0ZOXfB06Bf1CGi90qI82Rx1FWK3Jw6o+lkx
         sn5w==
X-Gm-Message-State: AOJu0YxLN4mNZr25VvoDMJvEpvxIoUKWTzOvDkcUh7LEI36/509QzAWN
	HcDO73pHlScwBMXsG1m/6ChZClgjviPSEa1MOxjBbBOPFnALnfYDY9k2A4KdRng=
X-Google-Smtp-Source: AGHT+IGdNfSheQTh+ej2FO2pI5eUxUQadxS7l9tN6fT0khbGP+eIx+6Q+BdPZ4OvlzHCqNBKewtGng==
X-Received: by 2002:a5d:480e:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-37cd5b31988mr5870067f8f.45.1727683782297;
        Mon, 30 Sep 2024 01:09:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5742499sm8306463f8f.93.2024.09.30.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:09:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH] Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()
Date: Mon, 30 Sep 2024 10:09:38 +0200
Message-ID: <20240930080938.12505-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the new devm_clk_get_optional_enabled_with_rate() clock helper to
shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Resending now that devm_clk_get_optional_enabled_with_rate() is in
mainline.

 drivers/bluetooth/hci_qca.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 678f150229e7..ad40118c9f82 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2294,13 +2294,6 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
-static void qca_clk_disable_unprepare(void *data)
-{
-	struct clk *clk = data;
-
-	clk_disable_unprepare(clk);
-}
-
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2433,25 +2426,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (!qcadev->bt_en)
 			power_ctrl_enabled = false;
 
-		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
+		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
+					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");
 			return PTR_ERR(qcadev->susclk);
 		}
-		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
-		if (err)
-			return err;
-
-		err = clk_prepare_enable(qcadev->susclk);
-		if (err)
-			return err;
-
-		err = devm_add_action_or_reset(&serdev->dev,
-					       qca_clk_disable_unprepare,
-					       qcadev->susclk);
-		if (err)
-			return err;
-
 	}
 	
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-- 
2.43.0

