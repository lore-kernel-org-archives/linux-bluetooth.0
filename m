Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177793A2566
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431490; cv=none; b=fNtouOvSk/24o61yxVpm77ZfrytgKDhADbos+hi9lk6GaW0Epo9mUBQqAbUe9GXnu+X1ZGqsSIa7arDrQwG2cgV21El/1pj7UEu8OJ05Gz7nnL24ZL9eaigdmq5FxFGsihftNDZ9q6DyY9Dy8J0ThChQ7fcnWlrLVf5WzwdVb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431490; c=relaxed/simple;
	bh=bvAJHksTfDk71mNNT7RHOppXcgzqFa+7JEkklg/iQus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfF9+eMySmTw7kKRW25jHByHgwtEwBi6Ga/fZITyRMIaG70AEz4tOm2iCLZ0+Okn98rAsJTPwc3gRhE6oYUabqydRkJYF1jwjscW+/Jvd2eHDUmpAgyHtH39/4d7515KWbbtT0BCIKXXPHa9BqvOOk6cvW4LMzqurcf8p3iOWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=N7Ixws2s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="N7Ixws2s"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso17304325e9.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776431487; x=1777036287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyDIpCgO+MvLXyp9uNgUQ/B36SV/tE2KaLWygaHVkwE=;
        b=N7Ixws2sdOw2LJlsBX/IAJOsODuO9jUsqbLoO2krAF4wHh6scjw0IlyQ8GNI5zHgKm
         wsrN+22jMxgAy0sc3u4ykby6f8b873N3uuen9kpwsrfUVGGh/y+t2ddyC6CvRvvKiN+h
         sdW2prDOtj3WaCg8C0Nt0jQDPTactO8Dw9RrhyWPsCi9cpD9TMPSzGfijQBHkw/5YsHb
         UR4UOxzt9CI8rzL5dkEwtlpui8LnnXvLITojvosSmFK0X9EcAPkDT7RbCrd16ft1iNOq
         DOvbxe+ktJzTkSs/g2Q7VnT/4zHGNNVwt0I82P38r0+AwktFMMmDYB2PSJ6EPJzNJJV1
         sM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776431487; x=1777036287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OyDIpCgO+MvLXyp9uNgUQ/B36SV/tE2KaLWygaHVkwE=;
        b=jC0JM+LWaAN+8e4uxeZu69l6CnBQhvnjwT7h8+VJEoDqWguHg0Amgs9wabygkDkRIr
         8JSKpAqQiWr8+Lo6NtvJIf4FY95GXwlP9LeBdzRfnU/6aMUd+7Oq9oHSD6FvEofCKFq/
         zh0HLxvU8zGqcsJD48rPizMEDW0IT9OlR4CpINbBCfljFyLrIFYkjk77ICbr/n/2hDe+
         iBn0+LvnKnrlnEFlSPec0WZtgpPvnVE+kXpbu6zV0THqHvpk5YWfmywD9GJGQKpJe7zJ
         mtq4dFxMirflfNqdVz6Xm949RPGauYjlZ2W4MlB7RJaSseyfKv8ygdq9ruZDyx82Fu++
         Y9Fw==
X-Forwarded-Encrypted: i=1; AFNElJ8FCfmHePvX5AcldILxNCUrF2jawXhKhQQ2ozGLsodoJjA/u3e/7BVpfEAl+eZzfb/HKGYeiL+A308q59bUot4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/ccWO24A5xauDAynWfiQCD8uzM3Kwg27IpclaDGWYYW6DlyI
	VJnSwopt26M5OSIreF1Am3E0bqMmM1dKW8bPyavDdnTkAPd4K/jSvJNsdCDn/n+g1Ic=
X-Gm-Gg: AeBDietcNbVmzyiKNe/77NFupUAEBeyBY0JT1GUn6Wsj2CuBLvFyUs/nHzFQL1qr+9k
	MBOS1Hk5y05BsK/z9+FgQqCUO5zJoXNhLvPjISUMq9V80vDsWPpxkZmcBhQjzn3DJLWlsmY2Jx0
	RZXoMUeFnqFbKsmO46F5FCf+hS0x5PL57meue2lw/uc9C2dtASeCE5P9+CWJHF85XcuSsWnk214
	wcT2MLxHYtUPoDMc6fYJK809utn9VH5McduwXQVmRHgg7k6640WqQ5Pt03dkOsncb+etr1RZUHI
	Eb/3bTL3BpJ6qzfDFjzzGHhP0xFb0pmmOAq/XXuu+ZwqSa/7o3Xbj+WmtHqdWkcvH1w4Rvo2ckF
	JrlxjZ1OUCqfomKB2i204WXvIlKeZrOY8Rjt9i5QBXTo4pUcQVqCTgsU8qx8dLqnuHoFEq4zzlg
	vD8B/0seNsxFYSOPK0g79Qj/iUKnSLQSGpflvj2mWJ5OwFwpxH2e6jNSCLzXaxTRWuDwFRPzyFc
	qf0iEfW8YX3yB4rRpQXBWQ8
X-Received: by 2002:a05:600c:a411:b0:488:c239:d498 with SMTP id 5b1f17b1804b1-488fb89e84fmr28335545e9.8.1776431487458;
        Fri, 17 Apr 2026 06:11:27 -0700 (PDT)
Received: from localhost (p200300f65f20eb08db61cfc60d8aa232.dip0.t-ipconnect.de. [2003:f6:5f20:eb08:db61:cfc6:d8a:a232])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb7a0745sm21388425e9.9.2026.04.17.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:11:27 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/6] Bluetooth: btmrvl_sdio: Make use of driver data pointer in sdio_device_id
Date: Fri, 17 Apr 2026 15:10:48 +0200
Message-ID:  <73699b58d6a9edaf3d71862d7c480baaac390179.1776429984.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3112; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=bvAJHksTfDk71mNNT7RHOppXcgzqFa+7JEkklg/iQus=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp4jFcVxihCGbUmETP5eFHZb6TwK1qp+L+H4Bih jyGIZDpIOuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaeIxXAAKCRCPgPtYfRL+ TkzmB/4nPhfVHaj4OOPuoi4xKGsOhTPtybr3HUsz4FJELuj4ojIFsSGWKpWT+ZXzi7z5Ro/pxia xhIKkAQ8yS8AXCO9McCpmahdFOD8+51MfgugN9ibCvcr/TRtlC1wDAlDZqTQInOCFDqNVhlfQ4f Tt+Q6hhq6bbya5LIK7gvq0jI8cb/jDGIwoE/CaYPu/j9WuqCV++ug+mvWsw+b9iFM2fzXR1FIwl VEAXCFAYoieW0UHV1X/NnA3GSQCvj1097tGQV7TWX8u+9ALMPkTunZ6/Kta4kKLBoAl0QGUB+rN ac1VBr0Da2dDFmstDxfAr044SVnB/KnumMsr98s6TpEKDfrf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Recently struct sdio_device_id gained a new member to store a pointer to
driver data. Make use of that to get rid of a bunch of casts.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 93932a0d8625..ad28bee56961 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -301,31 +301,31 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8997 = {
 static const struct sdio_device_id btmrvl_sdio_ids[] = {
 	/* Marvell SD8688 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8688_BT),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8688 },
+			.driver_data_ptr = &btmrvl_sdio_sd8688 },
 	/* Marvell SD8787 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787_BT),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
+			.driver_data_ptr = &btmrvl_sdio_sd8787 },
 	/* Marvell SD8787 Bluetooth AMP device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787_BT_AMP),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
+			.driver_data_ptr = &btmrvl_sdio_sd8787 },
 	/* Marvell SD8797 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797_BT),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8797 },
+			.driver_data_ptr = &btmrvl_sdio_sd8797 },
 	/* Marvell SD8887 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887_BT),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8887 },
+			.driver_data_ptr = &btmrvl_sdio_sd8887 },
 	/* Marvell SD8897 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8897_BT),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8897 },
+			.driver_data_ptr = &btmrvl_sdio_sd8897 },
 	/* Marvell SD8977 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8977_BT),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8977 },
+			.driver_data_ptr = &btmrvl_sdio_sd8977 },
 	/* Marvell SD8987 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8987_BT),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8987 },
+			.driver_data_ptr = &btmrvl_sdio_sd8987 },
 	/* Marvell SD8997 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8997_BT),
-			.driver_data = (unsigned long)&btmrvl_sdio_sd8997 },
+			.driver_data_ptr = &btmrvl_sdio_sd8997 },
 
 	{ }	/* Terminating entry */
 };
@@ -1523,8 +1523,8 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 
 	card->func = func;
 
-	if (id->driver_data) {
-		struct btmrvl_sdio_device *data = (void *) id->driver_data;
+	if (id->driver_data_ptr) {
+		const struct btmrvl_sdio_device *data = id->driver_data_ptr;
 		card->helper = data->helper;
 		card->firmware = data->firmware;
 		card->reg = data->reg;
-- 
2.47.3

