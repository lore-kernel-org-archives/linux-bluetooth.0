Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC81DFE31
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376049; cv=none; b=dXKBSuxx36iRhAh8LdjuRfMDEX9p2cV+IYckGQOaF2uwJt75hRcKJkDiaUTIlMdT89G9Z4p+/6e+3kyLW4v5nSRaU/TvfnCXfcOTnoOHlApxFSeYhBowG0NchOiRfpghUfRN84XL93+mlrPGKE21dboNBQGU2TRgMeIuqlOCDQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376049; c=relaxed/simple;
	bh=MlbPLAxkvwZsTWPOyVQBhMDn+iBHmh/0oEb+zU0KYbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlQrjuC4i/zSKr93X2SZQ1yplIzk0JnxucMfArdwt8gPHHc4fRmwK/VlPsXC0k1Gzp2Z31IziVIg9P/2BerMOD6V+5bHFmpDQTezcMsVVL8pKlCPXNpYnQX6mSHodcptfLGXVIYtWy0aCcVZjybT8vuv5+Y4So8oUuBG6TqonLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eSTBdxyQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eSTBdxyQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71dff3b3c66so1376650b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2024 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728376046; x=1728980846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq171djiWsbLsNt0VEXIRjKVcrKk+cVbMiitNVgUkz4=;
        b=eSTBdxyQJvGE9Z/i6jxocjF0OX/vFRA2DKzOwpT2tOddJet2ad7dVXuTZOmIc7ROLJ
         1+SOHrruj+wvbYJswBCbuAI+Pwzhe4FVs2MaZPr12H3i5Z8C+YbBYwd7v4uxZGVSy8vn
         q1+l5Oqac8w4SVMvngQgQRY52Cu80WG9O3pwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376046; x=1728980846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pq171djiWsbLsNt0VEXIRjKVcrKk+cVbMiitNVgUkz4=;
        b=XDaO0PkWe8Jaqt1iTX9A62lWgnWGusinb+DJNzgwUIxN+l4WfYJUvfuijRfaNOsuag
         bI3KrA0fuqfJDN8I/2X+9b/qutLB6kv/vZ2pqC9oDNhHQFZa01nzeMvmZVMQ+OLMdT5T
         F8xUmz9snOb0RAsEf79ZnjqNkCpPSprkJZRKVKcMTBC2jd+wBjGx44/uCLOLqVOjjGLh
         FVoIKX6IYyA4/l0KjsmY44xgbVBOK/I+aHhpJ02iSL+cTLWvkibg6HH2ADB8u5YWHjao
         4UPXCGlrtz7nsWIhtt+2V0qR0uPWz70bOrG+skb/bj86A/+BTBPJ0NbRGYyHglatbUz5
         r5+A==
X-Forwarded-Encrypted: i=1; AJvYcCVsQQIwqCm8HtdewkMGj6ksFf/8+4dSOi+k18dRVEKC26taG2sCmKGiIcczRA28kc3x1vLgjioQtFplunfYLRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyVtqUNOQNJc49t5PY7JMTZ3Nx5u2RJbu2crNZo0DMNDm28iq
	xi2mUqnyVjytr5eS/KaglZPL4x4I3rTdCXW1xD3NYx7zHPWgjU8cMg6hxCvtZw==
X-Google-Smtp-Source: AGHT+IEIqHr8weWKtCaAJsfbtil8i9+5MevvrhAdF+gVjtuB5zYMPSCsi2ViwB6KvpVNE65ouqmCNQ==
X-Received: by 2002:a05:6a00:180a:b0:71d:ffef:c165 with SMTP id d2e1a72fcca58-71dffefc803mr10731949b3a.25.1728376046347;
        Tue, 08 Oct 2024 01:27:26 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:10df:d27e:8d4b:6740])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f680cd4fsm5286236a12.17.2024.10.08.01.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:27:25 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Sean Wang <sean.wang@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND] Bluetooth: btmtksdio: Lookup device node only as fallback
Date: Tue,  8 Oct 2024 16:27:20 +0800
Message-ID: <20241008082721.4004100-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
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
Resending after three and a half months.

This follows up on the MT7921S bluetooth binding and DT fixup patches [1].
This should not be backported.

[1] https://lore.kernel.org/linux-bluetooth/20240412073046.1192744-1-wenst@chromium.org/

 drivers/bluetooth/btmtksdio.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index cc097aedc1e1..a1dfcfe43d3a 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1328,6 +1328,8 @@ static int btmtksdio_probe(struct sdio_func *func,
 {
 	struct btmtksdio_dev *bdev;
 	struct hci_dev *hdev;
+	struct device_node *old_node;
+	bool restore_node;
 	int err;
 
 	bdev = devm_kzalloc(&func->dev, sizeof(*bdev), GFP_KERNEL);
@@ -1411,13 +1413,24 @@ static int btmtksdio_probe(struct sdio_func *func,
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
2.47.0.rc0.187.ge670bccf7e-goog

