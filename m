Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1915CA6B
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Apr 2025 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743970224; cv=none; b=gWST/QjIiVGXR/phGoQXSUr1mvKz1BGsTRaok/IOAkWFWIVrUfe40lnhGBF+ppNzeC7vM/tWsUdSTpN+HnBwX44caYidlIvLaSQt3raJmgeMP1xvObBFDJ8p9pOB44l845fGkjY1NpcMzYkspdWg2c/trH1Joh1igjfG2tS1cM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743970224; c=relaxed/simple;
	bh=jH2cvGtBsvpZMSJ6OaDrQFL28kzgcLYK9NbsocgnfaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLuyAFBaPCyT8JNjjbPJ94BAFhZ8q5TKDDQtFzSK+TGRcOb0H7voQFrxeK4yxUsx6HrTDm2sc5C7ETq1zsg86euts9+FmPIYI2lyrr5awe6wddibj7ag/t2M4tI5cmeKc9jMxmXasa0+u0ecs5mdYezkYvTM4wfpWxiIeyrzIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SNBLhkj3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNBLhkj3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so499591f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Apr 2025 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743970221; x=1744575021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DTqIB1KXItguWXeNYQcNwaI7W5L7sSNfK7n5CdOhYU=;
        b=SNBLhkj3LJ+9ok8ivRsJIjHka/YPKO8qeO8C5QmhQzsgLT6mMfwaUkDdrrluSBr4Mu
         qkQK/Bs9PLQI/qX7SUkCvd3IOjLQWzVe3JeHkerZmKR4HR43wOfp4XGLhzsfwwRxcTLu
         0RwdPQAlOwK9do8tE0UeUXaeNTT9NX+mmkObZNnyg4WqF0J76lEh0LY+OtL3YL2J1Tuo
         n9oA+hTni5Tl7HdE4usLu1fgYnEYnRWFy8tcI5WUezdOfVlXJVi/UaK2TUNOykqL3bfI
         +Mh7EIYWXAYEx3YW8UZSONXxvS2gUa6xpA0t9tEz5MSy3V1MDDUYUHJMHy35oodFc+c7
         7PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743970221; x=1744575021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DTqIB1KXItguWXeNYQcNwaI7W5L7sSNfK7n5CdOhYU=;
        b=jbAUfmBO5544zOLhgRJpGWL3uwvy9YtnvvaNCGoP2P6emjfFfuBB3/PRlmfdYf15Pw
         y786rjB4wPoAJn+bBL05EhMiYCcP4ayZr1h19EoOVs8ubyu2jbjpvdbjozxtqRLch2vs
         RLW6mzlbRABvo3b+NByxNSDmDYb36AKnzVCyD6c3NYl5ZhwSv1lZw0WyDIFHBjHrBhTJ
         ANqpAQWYUvYgaM0d0GAUdxbD0BxoYZQRh0PR/ByEKjKJxmg0i4EGdxFVWIS5ynvKF4UB
         s0IejYXu7vzPlsuKQn1DVpJ4WftqLR4Rrl8ik6sUXPZjhSPPeFWzOi57YCy+H7Dyhmnw
         3EyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlreCVI54YmH+MHPSvKRBA7yLHowza6DrMOGclsxEe/8SywAgClpryTNIV2hynW2+JIWVr/lE0RLVoqMXEOw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwodgZk4NPEL17jwHs1TOieI9jrVAAmdbGsioowsQwbE1eoyAAz
	IgxrBqYIlJGWcjqvnA7eow/t3G8+r9bO//3uDgw/C4CIl/UC8E/s/rYeDGgGNh0=
X-Gm-Gg: ASbGncuFb93JQ9UbwWiNqOSP+xluiS/Z5X3Eic4iQplEftbmpVNRn6G9vl557kGw1TW
	fKeTmGxCLTILHYWzkrFf99hBwC8qt5SBVfSPiPDXD6CUsZHfTCY/svh+8cFhbZ0ecTLziu0J89F
	2I5SR/JLR1rBLb+DwduzQZFe6+dbemKwjmpVCtbSLOK+W7HQ94OBxDSitzNrjRYGrOMKnxRF7ur
	lg6IcpUh6GX1+mwGpjY04ckgDMFlzecmR7XTB37FBA0ruedQFnC5OenkS9YMG5G78M9TcSW5oNv
	Y929UNzcZ+xmidfaT2Zs8Bf1zAQxHxi3Dzk8u0189sw5de/6C+b2cA==
X-Google-Smtp-Source: AGHT+IEaJAv7cq8up/ZJcJ41xkkrRi1H6wbFP+rMyncmJcukHJubfsFDxahu/j9T6NCNJr3cSnjNkA==
X-Received: by 2002:a05:600c:548c:b0:43b:bbb9:e25f with SMTP id 5b1f17b1804b1-43ecfa05765mr31050015e9.6.1743970221127;
        Sun, 06 Apr 2025 13:10:21 -0700 (PDT)
Received: from shite.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301acec9sm10080656f8f.40.2025.04.06.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:10:20 -0700 (PDT)
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
Subject: [PATCH 1/2] Bluetooth: btmrvl_sdio: Fix wakeup source leaks on device unbind
Date: Sun,  6 Apr 2025 22:10:16 +0200
Message-ID: <20250406201017.47727-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
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
 drivers/bluetooth/btmrvl_sdio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 07cd308f7abf..93932a0d8625 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -100,7 +100,9 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 			}
 
 			/* Configure wakeup (enabled by default) */
-			device_init_wakeup(dev, true);
+			ret = devm_device_init_wakeup(dev);
+			if (ret)
+				return dev_err_probe(dev, ret, "Failed to init wakeup\n");
 		}
 	}
 
-- 
2.45.2

