Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CD013D89D
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Apr 2025 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743970225; cv=none; b=KVhuDZfsNv6YelJFuSpw/a2Ey0gFy6YE02pBlkFaTJw/Uw1Rba5M56gJMf/WvYytilKFO+g5waF3ketbGPCQHYdNUSonwu3LcRWT3WS/pKKMN43ut5Wi8bRjzFfVA5QH9xcOZQCMW4iMMPF8kRRTtyZCxdBAe3tj460CR8GZuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743970225; c=relaxed/simple;
	bh=GV1Dls+xp1Io3K00PjLejG1tcKpA8NBFUjY9f+e2188=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3DAG8+n20EeAa2b+8H8IbdO3zHAsFif4UJfMLOWNRpKZjxyC87ZUsAIhB70oWhjkxwa9cvrYx6bxvJwFXFZdBZRWmVhUVZJboqfwA7ov3YkKILLJiqriHEYu7wdR9LPXwj+zqVoNACUtDR89HVbAc/kd1iXwzKFORuxq7v/wck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OGL4CRkl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGL4CRkl"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c2688e2bbso470596f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Apr 2025 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743970222; x=1744575022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0bCgywlp6kaDxRJG12fl3NMTv2SIFaAtl9wSse2RnE=;
        b=OGL4CRklPjxVIKUoVVQ48pxX+wai46dk4JJ7Z69kTZecrle768XHB02UXPlaUkKt89
         igpyEPPpyY387H6SvIWuC63ez8xKnwmdfNKgUUoFMUYzrsM5f0uYNQvEYyvOaJtWczzs
         tHFaODPKZjTGh0doynNtEyh0CICqQHP4/AtyltkCGNDF1K4vioni+9CXelomriAJoNIf
         56w9YHOGm8Hy7ZyNUGT4x1f2I5NHLve8DTlUCFtxQ+zxKV5qUf+2rM2D16KGqqn0BRD1
         ud9Izh4iGepibj6dWhPafvZ1TtfUOB5YeRZhE/n8PTVAdOq6rrcYVlTX2fmMkALqVncf
         eYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743970222; x=1744575022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0bCgywlp6kaDxRJG12fl3NMTv2SIFaAtl9wSse2RnE=;
        b=wS5q/BP2RBZG82P7tMQQ9oC6JYoDZjDuP8FglhOIVHTB5e+MU9umYJ8OAwyUos8erl
         mT9PnxG3guTLHF2y6P1aXQDQp3YpH4jBLNBZCv9zV0/886UbTOb+tVbI0FrKooTFN2oR
         iZf2IvZII5B8BfL29QBY36SxE0EOOJ/+2ZdTTB+LOlHeTPMDjxraM5VLKbh9AyjZT1ql
         ozcGn13V0+l3GCcIV18CfE1PS75ZPcsKxI8zUxZL61fbrsJro3hRbV4zIbU+zcXHuWDy
         20r9ean4Lr+B+5Jtjj/8tgeNAW3K0P5hjKsnx3/vmu6Dk8+w5UjNvslTXwD0ceDj4HBY
         FmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXNT/GtXy2YohsqurXzIqTqyxDJrS1nH4D4jUIFt8Fde77U0Q/3uojRukkeAm1im1WKI7rQs3LZmH2SySCqEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGL/9HoWDzGmlQzm9eAryG0PHbt1wIxZwfvuk4kNfbfLlqmkc
	U9SnSQdFLARR2jSm/TvgZAl0D2FF9+kI27ZywK11m1XP9bDxZWbNagghLKz1+qM=
X-Gm-Gg: ASbGncv6cpiuBXx+Hh0rGXxCOCV4QrpdGbcKp6oveAKapVmM9hY8e64pOLyAeTSr91T
	94wYs0DWYmr//29fjampTt90jma26G+WTADRMNuW/i6mWoUgCcOJuPu7Q903qlGq6WDoKRdsZPo
	3lp1S4o+8jG7kvBddB6d7kFGw5Ro/iYvZduHBpD/x2WHB6J5K8UqgihdSjcp8dB9/QGhUDmVF7R
	7wwrNqPE1uSGE7hhPG3fT18E+N8UpWKFEZ9dWzfSfc2n5ktcM2oSO0I20QM9jxwl48bFpdubjam
	e8ikkTKkNAbk+1mLM4HHu+XbsKuYkMjsGyxY9oiLNVZxRgT+cx56Iw==
X-Google-Smtp-Source: AGHT+IHX4ogO0j9l/DVFfDe0o53qqxRjbgFXh9pHpQJLcNqGVqDaNvFPF3GPRIgR8kG8COOn0609yQ==
X-Received: by 2002:a05:6000:4022:b0:391:319c:193f with SMTP id ffacd0b85a97d-39cba93cfc3mr3063727f8f.13.1743970222445;
        Sun, 06 Apr 2025 13:10:22 -0700 (PDT)
Received: from shite.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301acec9sm10080656f8f.40.2025.04.06.13.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:10:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] Bluetooth: btmtksdio: Fix wakeup source leaks on device unbind
Date: Sun,  6 Apr 2025 22:10:17 +0200
Message-ID: <20250406201017.47727-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250406201017.47727-1-krzysztof.kozlowski@linaro.org>
References: <20250406201017.47727-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device can be unbound or probe can fail, so driver must also release
memory for the wakeup source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index edd5eead1e93..566c136e83bf 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1410,7 +1410,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	 */
 	pm_runtime_put_noidle(bdev->dev);
 
-	err = device_init_wakeup(bdev->dev, true);
+	err = devm_device_init_wakeup(bdev->dev);
 	if (err)
 		bt_dev_err(hdev, "failed to initialize device wakeup");
 
-- 
2.45.2

