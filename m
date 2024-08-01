Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9621B3F2C
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527946; cv=none; b=gPcnjBRfEQMviQluOvJyj095MKiyiC2UnXB2bvwaJ4fd3g09d8duwDUubr8z6MDNvM0YzxcAZlQtt2HABbOGLLKkjeFlH95PI6ab6+P8Q+K1Ev/WJfawjEqFdsbofZijJSt94VbuNAoUcjDzgTqrHg9ST2apHY6Jd63KPzWiFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527946; c=relaxed/simple;
	bh=Omcj2xWQwt6NtgOQkDGWvmMiPdAy1FRwJRfuq8HYeCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnxCu6u+PaHMvD9r3r8i+9quEjEB+FQ2ht7+L2jcHN4FLKwHPAdC9qEeKuhOASCjO8zONCKenkrgqJ/dhvWJe0QJe0WY1GccKhNX3NLRAfww7MZTz653U7Q6GyxvF7Edh/c9PJcxaEncluGPHVDTxHqKbP+9RtwF9bUfyp8nPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qOVvoYSj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qOVvoYSj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428101fa30aso47369695e9.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722527943; x=1723132743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5i/CoqWPo0A33bWnp2WK+u0zZkl20goXzr8vooyPLw=;
        b=qOVvoYSjDY+qN0ew3Vh1ST5RHysrvq14/pXzEceygec6tohb5ojFI/HVWzAph3tv0k
         cXsy8khrctnna4QydcBzg8DLNgXzqwGXh8oAqnHsr8TNheSEhuSnE64MiTzEQ4ADS43l
         q/loIJA9x2zWxHJpiTUdanmo3vGPpsulRtglvMLTQvT99ArqhFZJGK/qV9M42RXLn6Ga
         zm6lhDFp0A0LH2A+cUpV9d0O5o25BzuOva35zajI5um2do1xj48ZFaIoe1v6JtmPfleP
         GTaGdeY/k2eD/O3PnYwZp+8DwBuwoMNZoWukvncNoXEWo+xUJsxVhNOkcH6/dhZ3zEW8
         Fzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527943; x=1723132743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5i/CoqWPo0A33bWnp2WK+u0zZkl20goXzr8vooyPLw=;
        b=aBBv1UpSSk6bZtBShDAlOm4RrCWpqzsrGg17bKGlg3MT05hWY693eG4MzVqplG0ciO
         pAZRVEKvOony4O0htij9i5pX3gTL97QvFQdtEhR/Do+BPFtViorxze22J5HIWpp5dD1N
         EOvgg1NiliKXar9l8o5Q68PQ6vDjs4nt7ui07ilKZV4q2bNBhLLckCro+KWEv+dKVa2U
         RMsmwXdpozRo06viwD6cBHR9CIeEB1FvSiJhLV8USU5kTuajm4sTfyuWumJDc/bEBT62
         /60ii39m+dcbFK36x1v3w2qrX/Ko83g4/lKJhCi8UHmf4CwQ2/4awqsS6NqcnaN+0iE1
         4GJA==
X-Forwarded-Encrypted: i=1; AJvYcCUt1T7FdtvvpYDJfWQoWmiZQOUAHR3/LyMHQNVKvO+IQs/cUhhzhaYE9/+k2nKyjH8D3CJmimNh/1jHfb3L8j90vmIZ2aipLJ1+GPEsurZW
X-Gm-Message-State: AOJu0YwCbbPZS2r4MPUtQh7v7T2k78xdsbkhNSR6E+NcBaSIi/HtUqiI
	FyIvUOXycAdJmlj7aAs99f0WApx3oj9HLVvRaQpph26GVjQBc47mN4+QlLk3kFU=
X-Google-Smtp-Source: AGHT+IFIRyYV8wMpFEMoJ9mEI29GrIsoNHi74Ep547kloryWVfmLguZuTbUrIBagLig+4xgxpoADpw==
X-Received: by 2002:a05:600c:458b:b0:428:1dac:1890 with SMTP id 5b1f17b1804b1-428e6b9388fmr2368255e9.32.1722527942515;
        Thu, 01 Aug 2024 08:59:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:9895:bf13:f4de:f316])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7d615sm1393875e9.29.2024.08.01.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:59:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 01 Aug 2024 17:58:50 +0200
Subject: [PATCH RFC 2/2] Bluetooth: hci_qca: use
 devm_clk_get_optional_enabled_with_rate()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-clk-new-helper-v1-2-81e9338b7b17@linaro.org>
References: <20240801-clk-new-helper-v1-0-81e9338b7b17@linaro.org>
In-Reply-To: <20240801-clk-new-helper-v1-0-81e9338b7b17@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=P/Xbs1jF3li1v+zlwL+edbl5plqFHRk4jCw7biA6/os=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmq7DDH3C6eXuOAHHcbUdtceaK1dhjfbYwCeF7r
 5U3Y6TxXHSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZquwwwAKCRARpy6gFHHX
 ci4iD/4qInYT/hTR/ISAtD63aPZ6kdsTJ0DRSJT1AaffUMNUj26XEXUOhPxWGgPFeNMD/ySusmV
 1cbkeJIPVaGTfRstR7tP8dGrlTeL5sspUUYv8NWqXKzH0qq54SZO7ZCqKTEbenqdGqxo1gdadcK
 +TOeLfkzGsEzhO1n9USOt9X2php2JnrO/rMgKEdJuNpbeP6fGof+mhKkgw9CjW/Rvm4s95DlZn3
 22sOnAv8qdnX/uwZRudiR8/h0GSLSinxVBrsoSKjMQgC2epKVtGv+0QrNDab3nHUNVgUaCs/MqS
 BE0bAvaJrJwIgSDyYrmbCnxj89A2IwfV1IdRbUmO1VfwOFzeyPBLIBOjpcibJtkWZI4wtXdf/oB
 HL7h497eRfDbcsynrcK8JpqLaZ9+1dHkbq8dLVd4xI9/MM/xFgCPT4eCfrYMiolWYVJS9Ycrwst
 d7hMiSK1pszU4ho2GcwjZfI/0kSHFtGa8qEtND3EvF/2ipjeFv1hTk8sRpEU+O7WW97U7z1LgeA
 92WqlNz8JuODFgDdxTpaBN1QapJKVJiPukJXWRoUV3U1ILqIF2+V7VlnVxc6x8N3LY3EoW1BH7l
 TvWsQi4cG7fm9TQu7mJZobBcAvYfg15CZsFyTFBzOMoN7KGUZeIw91L6N5inFg1LPK03SaoKUb1
 zp3wa/Fo1LdxacQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the new devm_clk_get_optional_enabled_with_rate() clock helper to
shrink the code a bit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ca6466676902..0670f527909c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2297,13 +2297,6 @@ static int qca_init_regulators(struct qca_power *qca,
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

