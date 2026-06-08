Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5A366566
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917853; cv=none; b=eecSCWkSUcVR4S4ZhASMpGSwaiIni0rcfE7lQzrgNmfF0/4oMkdfmiOuGcBBesJLY2cfj6OS0Djed4943rM4aiQ853PnGmrx3ugzin94hqJUP7r34nR4f8iMASBUTR+0/O2BrNDaapekQyHTl3FxFxPpR+F5/uFOLyqKstSNg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917853; c=relaxed/simple;
	bh=4rXq9qW7/EiMPkd5SsageHbopzlcz1cEyMNkPseffSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rd4YYgNhxnjbllXBSN2jG/vG0qKHVpnkSezPRa8dXMMNZrc7g9UOyZUWH28q9g77m07T/h/MhuAI4X5xSjIvUHt6gecME3lPKQ1Id87NIdCnEdnQyWnQq6xmnWhBpZJsP8FbVk1ZG/uplCmHinGqxMuDYczNNFpyqomZQPssooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=JojPIQfm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="JojPIQfm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b915ded5so35300025e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780917850; x=1781522650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVFDoZLpD7ldCZHNHISOrqKvkJ+jhCvIyZMORA1/Sw0=;
        b=JojPIQfmlZfVHkflI0zlwAHm44Sqf8efQt6IeOb9CFPpgRgDYoCGwX5ZHBAR9a3MsH
         DenAZ8GC7RFja7YcAJ7qH0tObFu2pQQixM0q00/7/LOx0tToHwAli9SS4xa0joEmNrU5
         lVD/Thf5h383r4asbiU9aq2KtEWxCLtDQwwv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780917850; x=1781522650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVFDoZLpD7ldCZHNHISOrqKvkJ+jhCvIyZMORA1/Sw0=;
        b=OnsfkKNitOrdsnb5zvZTsiv67neaBgdl9Lgst///RVAIcH+QnxTUK7EvAWN/PxlBQG
         wsBY7zPn1z/iSf37Y6Rg8iozM5ehMh5B6cjy4i3whQQBu1m55MYMjSX0/W7st93ZCY87
         krtbVJirVsLFOAme52+WfQ4cya8gGQ5cIj97I3wycJMRG6ZkSlLumnobnoRiaPNN10Sh
         HooY7yDhsgdM6bpfH/Ul2N2zyMUofoedzsoEqI8q6oBHIDINU1FNuHxV/zY2kEeTp8Pz
         6ar47wWxdqLQ3tQMaTzAlrSIDhvRoZh/xnRpibQlrQ4pwvRC4l8Tfw550Whv/7aXTqi+
         5l2w==
X-Gm-Message-State: AOJu0YwUgADe9OyWgq/TeE4NZZjwY4MopZy0FSTx7ozsjJyQtrIfxWBq
	wFyKYybpfCxrjuaLKFvta9O9KA/BI1if2+w5QMEL7bbFaE5yN9zKDjx+CXV9/05H9WxT73BL8aU
	a7o4F
X-Gm-Gg: Acq92OFYOcFRt5BAUtXJBlnwso7S8kTAfUp1lYh+3ZrGxuECNLdweuQjTF5GV+Hur1+
	i0zBdWX10OQu2mg7od6A8DdRS4masrmbS04AICHMd1drOWYqQVz0EjBnEifyKALPCIaHLQyPofI
	ntPdg3h0AVKW1XUdhykNMopEY19G3f2feDOo5DRpmNPaec9WdWJ0pW1dFNqK4vKFCzUbaOuk560
	6btxFLUPahmL3/W3nKtPDi0tSWDoECgX87XXZ0TGUEN5D9HjEgB3Ef6bD8i0i60o7V0Ku9Ddljx
	afljVKwVexBUWtB7Rok8uspp6P/gwH0HwqDiPq5a9ox0uCOt79TUMU88qQEwEtgQw2JhDNLH0Lc
	p3HgYU6hv9pzx6taLHcAFUKYjhZHEl5PJRMWw2Rj5ED9zJZ0wcNpCEe6tB4uR7LL9MF1MDzW07V
	K6qx1lGlyRZLv6r1kIJa44hMOC5Rzxpt630/HRMAeOKSH+QUtWntl4nA==
X-Received: by 2002:a05:600c:35cc:b0:48f:d5a0:284e with SMTP id 5b1f17b1804b1-490c263fd13mr294434235e9.28.1780917850205;
        Mon, 08 Jun 2026 04:24:10 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc0f8sm385841585e9.8.2026.06.08.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:24:09 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] device: Fix auth_retry timeout not being removed on reconnect
Date: Mon,  8 Jun 2026 13:24:03 +0200
Message-ID: <20260608112403.3720840-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

timeout_remove() was called with 0 instead of the actual timer ID
because auth_retry_id was zeroed before the call.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index bea893301..8f7ec5654 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3810,8 +3810,8 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
 	struct bearer_state *state = get_state(dev, bdaddr_type);
 
 	if (dev->auth_retry_id) {
-		dev->auth_retry_id = 0;
 		timeout_remove(dev->auth_retry_id);
+		dev->auth_retry_id = 0;
 		dev->auth_failures = 0;
 	}
 
-- 
2.43.0

