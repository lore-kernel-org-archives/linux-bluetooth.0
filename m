Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829492E6CCD
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786166154; cv=none; b=cV8X8f6W2pt6jvlhXmr3nRXwZm86gFapjM+T7w8JtXaGA69od5QRUXkltMY3iJa6eRCmE5pJmGh5UtQdhEhNaVtbGPpGwXbr5HC2AoSiSMnQ4Rh+NEPnrkN/chSqwroOCVeHO2VWWR4Tiqwsm/FjP//J8P5Oid9tDAvkxUIZRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786166154; c=relaxed/simple;
	bh=VkOrCT4YVQ8Wh4LRhDH5x3EtzvDG1US9Kzo2Smej2J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtgiSJgfILTcNEkZhi28H7+wlIlijI6pVn6jxoNB0dxXr4ff2sxw1uGJVhf0JQPOQhl+rNbgUOmW+lwO69B8gwmi+cFaCZOeICfn+GD/1v4KA8mlLyjAy5JRta703l7NJU1vmfaHKHslFa9ZuV+2qhHiVOgWkojURLuQeVqvhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiOiTO5B; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiOiTO5B"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so123552a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 22:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786166153; x=1786770953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qzluCRQ9VF2+ag54x4AO1QH0LAV6RpJxZbkPJPdf67Q=;
        b=IiOiTO5BmroBM/glFtxSoOUQuABTMc7GAx/etZXqGgZlwN8WSBHBSYKQPR2AFEDsAe
         TU/DR4vVkBOtaDas64t0NIcnJidEAPYhaCgRtHYpJxD/w5GrlG+UWOS+36Yc+pUUGoGi
         QNJEG59QTmsI3RkVAP/WiM80Ow6NHffe4ZFHFRtN4HvHKfrqqtESbSF0FmMiFURLFyFI
         Gr4pfgXWIozIPLSojZz9wrrigBhm3NHq+MM6cDS36ymkI3EGaenKouEU9kesIXRy+zs8
         R2XGlirS40Iqw8Gv5t21c2q1WS+FG96rKL5yIKAVQkoOxu/1K/4LYb+TTC3gCmAqQN1s
         ZdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786166153; x=1786770953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzluCRQ9VF2+ag54x4AO1QH0LAV6RpJxZbkPJPdf67Q=;
        b=mDiR3tbiLw8Uwo4dp824iLkm6WhAEmt13zFOBZ4wSQHWHIcALWigJ5yOeZaOZnyWyu
         X5kRSMA1zc2nCebN0/BDjn4UWkaiezAs4rzK315GY5IJHuRT5cLSrj1I4oUerQUNQSZE
         KLArB5aFQjCsZTn2rfMC8D/27jylVGZ7w6jzurgGtf+oQOPy3udK/WKQCh2rIN8BTDn9
         CbkLz761sZwfo2dN7QuDs8OZ/OIVZRzJRzu6ilY3bAF0ih7aDw8Tm/gwCZrr20kZSUeg
         UOZ2r4OHs2enefuU3ffWGhKz6nHaHBkuSBfFYM80dWA4hu+qMlMEV8jlqUcoLP0rvFxF
         AQ2A==
X-Forwarded-Encrypted: i=1; AHgh+RrP0xyspaEJ3SZ36LvVheP2Twh/JWq4ZJ6fDCUUknseSJ9HfnHJH8eB0h7guQfVpmBF4ozZJbT6Jov+/cirMYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ruOApWlrlp5xgAvEReqnku7Rt9ogT9nCdUSP+z2LN5ntpHbJ
	lQTwSiNW0HsOzujX/r2mNPuS9klDPTRInQy2iacCm3J9uTnjIkFv8dvG
X-Gm-Gg: AR+sD10ffcD7U48mUBZcrFKdsqzCmR9CO7Pei7TI1UUlDA77/tolT2+DUZqNtU00EJs
	CJR1WfB6K9MDeYluZafzBeaIbLLcQMMbnxjS5aXAVivPrkkq8FY98J/KpySTqtbSSSGfkaIyYgc
	w7rpHc17GhbtJsDupBKxlmaRtSpc4P/jZIjpo7e9wtz2IXIWZBg6ON3dsN0nXtqwveKLvMtyCIL
	B7DIo40XUfIHRTkudGYstQahrZTE0IT2Z3XqTrdJx46lwT1KgYVZXUq57u/TwNmSnR3YxOimtBn
	s1XaV+67LjEwafJkQwT/KX5oarDyhLCrw2tNP5Rx/Z4YZTCuFGvge3X6EI1mB+ROkDVc86ohp33
	KIEEmYEvSRtqacl3UGh3/3TDohhWwLLMBOlLMKGBz7yUWcDYBscEW9Sxgnt/fzxnuSyC8wJXf6w
	pTNUlavEklcMl2QIrZv0ewjr6XHUCuTSpbDsfBq5BwmuFiFRDY+A==
X-Received: by 2002:a17:90b:4d8c:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-3903c544f17mr23476693a91.6.1786166152704;
        Fri, 07 Aug 2026 22:15:52 -0700 (PDT)
Received: from lgs.. ([36.255.223.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b37eac8csm2200388a91.4.2026.08.07.22.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 22:15:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 13:15:32 +0800
Message-ID: <20260808051532.2553947-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm_request_irq() calls pm_runtime_use_autosuspend(), but bcm_close()
does not call the matching pm_runtime_dont_use_autosuspend() when
tearing down runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during driver teardown, this reference is not dropped and usage_count
remains unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before disabling
runtime PM.

This issue was found by manual code inspection.

Fixes: e88ab30d3669 ("Bluetooth: hci_bcm: Add suspend/resume runtime PM functions")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a4fc3882fd2..cc419e1960de 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -547,6 +547,7 @@ static int bcm_close(struct hci_uart *hu)
 		if (IS_ENABLED(CONFIG_PM) && bdev->irq_acquired) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
+			pm_runtime_dont_use_autosuspend(bdev->dev);
 			pm_runtime_disable(bdev->dev);
 		}
 
-- 
2.43.0

