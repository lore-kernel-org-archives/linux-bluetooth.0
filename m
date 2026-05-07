Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA8200110
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186075; cv=none; b=YHWSUzZpa8UFhauPqfESxixa17Ik6wAF9GHn8Z0ZMp38RM9adg+J6MVtgDYcD/Bw8uoO7rKQHqU4X5aZCUpgns0b7jLBRnMzAapw2w2TN55O7rX5MFRdqPNQchpVEnghIqcl4Os1NVIq9qgTmN6nm2S9epGkzMPWS6b3FLL8lXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186075; c=relaxed/simple;
	bh=FHKgbUS335BLJP0j9Kh9ePsKhQ8PcyBIv3BdoJ41K7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9TycUI+F16V6rBvn1XR0SE8bLatJSx1L+OU0fN7iTDsOsIUzmXUuNfstbe8+m1XY9fIB1MPXAVOyH/7DjFgPIoY7lT0IA+e/xfsiGhPX/cVsVMI5Dmy2MWHtoXqoIIyEfv5zE74pny7M42/RDjB9/QYrL4t7a9bUA6DMNkhEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP2lBXT4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP2lBXT4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so11660715e9.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778186072; x=1778790872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UFF0Rirex427kO1ZXdEYtmclVMtl5FBu+WCptqJ5C9c=;
        b=KP2lBXT4f5i2GOlwuzRfvoHTe8DS9iq+a1OUL54nBjg8d+ivxFtCBUo9QJKewj9qmh
         dIyV9EGaQXn1VsE2JZm6JxFrJRoweMV8bOxKVbCj4SVsIemOEwk6A8oCdwhJNuNIHRNP
         /2MZ2VppZTYlZE6v4oebHuy7SQ4NsZSIhd1qfySh6fQoygjZejeQR/AdYuXky636H8Hf
         h63wxJjEyS54Drjt6666Ut5CJUlWMq5oFoZ4pyXTxdQZalFyaKoY73RcqbTvX1IfTS6e
         1K5zowajVl1qOp6J+GqMzdn5UULXA8K0lScuwpcWRmaK7V1hX8QaSObCcz4WMZt1e7IE
         NsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186072; x=1778790872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFF0Rirex427kO1ZXdEYtmclVMtl5FBu+WCptqJ5C9c=;
        b=DXxNIRYmWV8svs3MMkhw6HLhW1Y4lEbLPXybZF982KJZr7HoY/Tj9Xm0PDEOy+NaNM
         ev8D8kAx+t3sNbNbfOoMaQ4NFFf+pM3oUuC1JCu3xn6DZjcrBh8p2reNDIGoCnhzOBnN
         3/fPQJyotqeDICiGnQXyrcYyFioGgjUU20rZQTDN19+ZFURwnJVEYEvL/2/W3+HOrSOh
         Q6XHT6arGLtlve/tUK/LCxpnZQpDmJr+ztTdKft5V8H3oSd+ES9vbUbIDBxiD8uCKHM6
         JdAvmsyb45flXVTqNA4Ltxk7md3tSt2WDGlhJcQcWXsHhvYYLp9OpDpqGWkeMXPiN4fx
         MUZg==
X-Forwarded-Encrypted: i=1; AFNElJ/fxAkg7YL6JSZ0GsZg1qUm+3zK1+eadHrilrMU9Xquc4y/GQQrUULRsqnCAuEW10DbXPjo+RxaO6epG862giI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5HmXcRZN1r4lhNseMe/8E5A38Z2M5/OsTF4CAPuUgSlLbIcRb
	qsrIxBtfZQ3Eia82yC56ihoKitfLtZ3AnDGtkQYVd9luJM+B4rOtU8bDTMsp0j6gGEY=
X-Gm-Gg: AeBDiesoZifoICsdG3WBx86hTPitL/CCtp5A3D96IBKJ+uMS57gqeoRm6z0gwyFmCDG
	Xtj8ETK35oV3BqOQj/b1DqbXSePah4iLhypH+6ZUtSHx5ZLZJ8pBwt2W6ul3WQ26+HW5sk1adc6
	tFPSFsWbIIMZBlz86GCztUjtYRrt5NDRsV1oatSc5OZLwlewLsftdBncB0AIFyDbKDg1R9vDMu3
	lui98d09x2wHN3jitipLzv9SEm6GR6SNFcAiRILwcaXx9L/KSPsEvmjy+/6AcotWyD5n439Qk/Z
	6zunX6IiWfUejtlu+mjnS8vlxAxkIAbfF0++i0+Y7xQnKb6kJhcnRqpNTqooMzMuRV4GEu+B1Ke
	zZvMlFTZy5NwWvDAMHUtZv5Zv5fElThwLaWypLL/YYiWDrrlWK+X07uUVtRht1mxfO9Aem+DO0b
	bf3oxsk0hneyeuekry4slM0wlKnTIyCVUTs4IMB5fJn5UKth05pgVs8TG5G5v1h4L52WC0p8jh7
	nI=
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id 5b1f17b1804b1-48e51f32ac3mr157177425e9.14.1778186071944;
        Thu, 07 May 2026 13:34:31 -0700 (PDT)
Received: from cdev ([2a02:8071:5a94:e220::97ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e539109b7sm137175725e9.15.2026.05.07.13.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:34:31 -0700 (PDT)
From: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>
Subject: [PATCH] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Date: Thu,  7 May 2026 22:34:26 +0200
Message-ID: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_set_dxstate() falls back to checking the controller state via
btintel_pcie_in_d3/d0() when the alive interrupt is missed. However, these
helpers read boot_stage_cache, which is only updated by the interrupt
handler. As such, if the interrupt was missed, the cache is stale and the
fallback check always fails, exhausting all retries and returning -EBUSY,
causing suspend to abort.

The fix involves re-reading the hardware register before the fallback state
check, consistent with btintel_pcie_resume().

Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")

Signed-off-by: Vladimir V. Kondratyev <vladimirkondratyev2@gmail.com>
---
 drivers/bluetooth/btintel_pcie.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index fda474406003..7fca8eea6e01 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2778,9 +2778,13 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 					  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
 
 		/* A hardware bug may cause the alive interrupt to be missed.
-		 * Check if the controller reached the expected state and retry
-		 * the operation only if it hasn't.
+		 * Refresh boot_stage_cache from hardware since it is only
+		 * updated by the interrupt handler, then check if the
+		 * controller reached the expected state and retry the
+		 * operation only if it hasn't.
 		 */
+		data->boot_stage_cache = btintel_pcie_rd_reg32(data,
+							       BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
 		if (dxstate == BTINTEL_PCIE_STATE_D0) {
 			if (btintel_pcie_in_d0(data))
 				return 0;
-- 
2.54.0

