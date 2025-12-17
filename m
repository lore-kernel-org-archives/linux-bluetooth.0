Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2DF1D5ADE
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970456; cv=none; b=pl3Bn+K262PlXkB9g2bg7GqtzAlG2AhHoK3by0TWWj6SIQwvNEAigobv649Buotn7Bz3hahJlYC8TPhlKblKcfVKyW8Sw+o/OOrUYf47EG+0iZEvKOTxb3QES1WdJBX2aaedVp7wdxr2R6c7wVXt4CjfZbfWPAdTpV3MXP1/Q1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970456; c=relaxed/simple;
	bh=ip0toTFqPEpK+4s0Rx5RGWhl8GI5wCxXBuwM4DUFaEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBXvoEG8oCCFhC8QCjR1FfznYnq72f6e7vWBDlzcDA2so4jDpZEW85HK0v7NExFThfGX4Rye0fP/9NtQgB3HRjyQ/LbJHByNCcywmtYdZ+3qz9JCYBiMaGZES3WxyeIkUXyqMoD8ScIh9OyRFPXS1Mk2TxkhuYQeITwemByxg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nfxyqgJf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nfxyqgJf"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b713c7096f9so937434366b.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 03:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765970452; x=1766575252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTcwQN3kMfRwn0MOtZPrgw4H2EwbAELatd4tH4NVBgE=;
        b=nfxyqgJfJ4pzzrgHtYHETqzjh66mPvQ/nhgpribaGYsWlFIinJPeaRlzuEvEj+t3Pb
         bZ9yXIPLSjOjRht3ARz7koHBI62JPiDkrkuhkW4ru0vVIH3t2UhOdzArs642sx8+tciT
         XzhdogkPyMPnC094YTl1mEqQDE3tZ3tVMoTebjaFNfAjIf2RTSpJOSFeb+EuyOB8Gs91
         EzYjwF5rOBt8AQqqG0ss6/cbzIMHPaBowfCgsN7aPDeeFA9jrbgkKOlL5DbfPW/Euba+
         HInuinghHuyyK/KKWQ0drXBN2dt2pc/b2RuO1p8rielXTKsOTeeVz0yqaxHo+QP6tDmq
         9jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970452; x=1766575252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTcwQN3kMfRwn0MOtZPrgw4H2EwbAELatd4tH4NVBgE=;
        b=o4FDOb2G50+I4wYTzTbp3GkRXMs7aojsUcJOxVTTqmTEJ9H0H+MZkk9S/7jPgoKMva
         fPdd38m6kgHfQOqUjXpi/QW5kS/VIJKAe7VHVCB0hUSdb4DifuKzB/RU8z1zy8+6T/hc
         1AeqIcA41HCqshcsGHTNPgjEky0QIi1xAWtoNsJLlVHSVq7W1MSLYcSqpgutiOqtEiQg
         6aN4mEd9r4mCojUTmVKoxAsaYkKc4b+vVqq8HG5tkYzWWOHpagA4fRvR268eZAa2tAt+
         gLSaKF+CTQ6K4AE8EokMMo0vMEVDZwtrKjorm4WMzuWDzS8DpgoUq4Bf0htHIxa9nkxA
         xWHQ==
X-Gm-Message-State: AOJu0YxmQU34f66WrwVBt12P+RSm0PEG04S48I0TPhg/SIRKGBs3vrxY
	WqYHxPNu8zs0qRvbtX5A2afhq74DIVx7fLKP095kQs2lqanN8YRcVuFhqLJiTPVriJw=
X-Gm-Gg: AY/fxX4PFPRCBymiWpVqnVlyowV41V3P3bF2iT+9i7jnggZgS3kV4PClPzzOniFXPRk
	eZM5V8kd8o5D1XT5PzlbQ8H7WNj7hb6f259tWkcnvKOR/wJbk0uyXA7uwAXOAIelQbiFkS+audW
	unnIcUrAQRBujs8r8LCBDthvfSvPSMIgO74OZsStyo12DYMJk0NhVrcWYEWFi6+gli86yJx5w37
	SBIMmVBqSSAgZbPZO+7+69KEMc9CKYHcr9aRQI6qwQ5Xr7clMTGWzUfYU19F9K07aIrVX9vszUN
	FiFf1sWqcjLLXV2v6ss7baTsSPbNg+Dkc/BrVt0s1YUEtEegy2udQhAexuB0kklOvSYAporelng
	SfEB7qDavVaCU2/IHdvTz4G05o10I7SKkZWf8hWCAnAh0UXqJjDxmAhtJ+sybPbPvJbXOGeNopB
	fCq/7gRCgDa15zW8s1s/MJOzZd9ls=
X-Google-Smtp-Source: AGHT+IEagpbs4HyNCpsx7OlTFhT0q9uoh62JevUfquHGVnwzeKSmc61VVn5TagHQj0mzzpbxTuoklg==
X-Received: by 2002:a17:907:bb49:b0:b7f:eb45:f572 with SMTP id a640c23a62f3a-b7feb45f993mr603953966b.55.1765970452008;
        Wed, 17 Dec 2025 03:20:52 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7ff725efd8sm417291266b.27.2025.12.17.03.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:20:51 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Bluetooth: btmtksdio: Use pm_ptr instead of #ifdef CONFIG_PM
Date: Wed, 17 Dec 2025 12:20:33 +0100
Message-ID: <20251217112033.3309281-3-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=ip0toTFqPEpK+4s0Rx5RGWhl8GI5wCxXBuwM4DUFaEw=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGlCkgGiATO5RL0sh3KYGWs49kKJWdWd4V/InvAHNjCL/KJfD okBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJpQpIBAAoJEI+A+1h9Ev5O0cUH/Aoc wZfGf5D7k2Y3xp+Eq2OKaDjC4SdZdn1wPRyKoxuxJ6Tw777evLx2xaxOJa8gtNq3XXkl1d5ytJb wVedpUMeon8lBhvLxJIQnb5LneH9ERGhyVon+g65nMM/ncWgUyT+mQx9vl3gF/6wa1uz9rJUB8E iio65wqGEYu8Q7cWuo2o8sf62CaSimzLrnFiwIbD5k156AgQJIbnBB6+bahGKu1Cmebl6ZtC6CQ 1a3CoPsf+je0wTNPMlCc3Ze1MxMrEJ2spZdTy/SbYZQIG8OuMf/BsLcjij9wWnmYSQ8fcKxhOhU V130qUndlr9XefXvOApYyIOHzdPIUJjQkSphjic=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This increases build coverage and allows to drop an #ifdef.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I found the patch opportunity while looking in this driver for a different
reason.

Best regards
Uwe

 drivers/bluetooth/btmtksdio.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index fba3ab6d30a5..e986e5af51ae 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1472,7 +1472,6 @@ static void btmtksdio_remove(struct sdio_func *func)
 	hci_free_dev(hdev);
 }
 
-#ifdef CONFIG_PM
 static int btmtksdio_runtime_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
@@ -1542,18 +1541,13 @@ static const struct dev_pm_ops btmtksdio_pm_ops = {
 	RUNTIME_PM_OPS(btmtksdio_runtime_suspend, btmtksdio_runtime_resume, NULL)
 };
 
-#define BTMTKSDIO_PM_OPS (&btmtksdio_pm_ops)
-#else	/* CONFIG_PM */
-#define BTMTKSDIO_PM_OPS NULL
-#endif	/* CONFIG_PM */
-
 static struct sdio_driver btmtksdio_driver = {
 	.name		= "btmtksdio",
 	.probe		= btmtksdio_probe,
 	.remove		= btmtksdio_remove,
 	.id_table	= btmtksdio_table,
 	.drv = {
-		.pm = BTMTKSDIO_PM_OPS,
+		.pm = pm_ptr(&btmtksdio_pm_ops),
 	}
 };
 

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3

