Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7F3890E7
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637228; cv=none; b=FHmO+6+hse1tHVZLUyPQwOuwK1YTft49Bqn4pC9ds7DvuPSN6mityzXJOK7Fpyd+V/xnq7fIHeNwqlxJ6XiZsSWoIBbDtHCz1w3VEUMK6IV08oziLV15kE35v66INk4zw20l/b7gsV42kEZzKVdyoHJ5EH1JPoaEQSUVrF7dZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637228; c=relaxed/simple;
	bh=kOh/NietnE9w53LB1cdEtfXJ5XrSHePHH6cZzAcS0yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRqA7PUqTH+JZriFSArf+vwIMDOB1fe2f4K8R/kD/O06+G8fUQ4bJO+BGPOwe1ygXc8e3g7x2KW2CbmOOHLjdx4zCHCnDyawMFBAUfw+8LsNppbE1yCS4Bt1Gcwh7lVLU+qYtDETyNP4qedr+jL8yByR0T7H0Bg5i8Ut3eMEJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=w88FAL32; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="w88FAL32"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82cf83bf375so2466748b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 01:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1775637226; x=1776242026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L907kyVxJfTy4ms6WZ8GS4RgVw2t70KnoctsJWpsaCo=;
        b=w88FAL32OJpJGSGQTc2sd2io1rvzDGA1ZXF3XZlzKE1K4B0yFGrLeN+ss3oHRlzuWK
         milIJh9Acr04G1MBPdUKgfTSHvF+1sIsmyQZHBkWGEkK1fyKq84qMkemqADMjeIs7OLh
         hvsNOIZpeNEmCjQW6FpI33PMT3oPz40ni4sFFMdWXtswktwNuXAyO1IwTuSrorftieHL
         u70vpaRYzvI14zGe9VkKU8dWc61E8RpF3LWHI1ofARcCjdxmeH2VRpZzxT652BuBH+UN
         aRauLz8d4paSbYIsDd/D1fpvKjUKGSQfhKonWQfAFnD1bV10bU2zD43AqhrBZitLdiuF
         HPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775637226; x=1776242026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L907kyVxJfTy4ms6WZ8GS4RgVw2t70KnoctsJWpsaCo=;
        b=WV4hPfZIxWXji5J+P5i1ygOOlJbj5Jbve3hlG74ydZ29USdMSlF3i/78zrUMn/Y0b8
         Yti3g1o8ez6zkVeeYZ/FEjboj3N+iS8xJ7U9oaaSQe9oy4+cGOyYPcRdtoruDL0ZeQG+
         GYN/jG6xh4xV2sTj3lhaSgO7LqxO+btjD7XopCMLibKI6ZamgoYgpJYfXbjyIHQ1gZ9W
         ttQvSRHCVU6xreE108fZPwr1nwCxH/ZA5qdybX90NduYaRtfEoY2MVdqYVFyyGfODQEX
         WcNNZq+XTRLOO5OmsM6t2eP2I2lpaeKZIkVRIO0WDFPbLu5Oy3swm6ImpmolaLeghdMV
         m9IQ==
X-Gm-Message-State: AOJu0YxSPw3D0nEk+3SoVvnbNcDMtw9H6CpjM3m7fMxwOUcc4veH2EX2
	EcNWZt00jItNi5YnjgTXIpXxu0/xx0Pk08qzcMy+M5CMgy2ycaFKKqDAa5UcBLf09MIuDdCV1/Q
	OBeg=
X-Gm-Gg: AeBDietHQdMDBp7WHYY9zuf1fNcbHMBy/qPT54jQPtSF0tNuuVKfWmmwdsmWyxKDeJT
	ZI8TxCnyJTqUCAlKvNEt04erDSHH0V0Wy9A4Ao+v/a+LD38BQ7byhYvaxGJ5GwjK5JMBshC552R
	yui1Md6rW7JEoZ6TkCRMacqDFbZLUPWlkk3uqU4RCx6JVC1+DdgKmRJ4vIWld4XXTn+IhfUMBEe
	S+cbJvfWkZaJbM+7lbip8M8MPJAMTMF87tkBWM9jPXxII4huIh0fcWkd8n5weU2FUPY19xHyicK
	elkAaAA7miX3raMbNhu6LeSjaYqo5BQEq4f0+E1xxvnoaZvRtUFc/ced5pVthsTH46vZNJPxsKv
	BANeyBvbO8xV4x4MlQi4upfLk7HEL/HoyAnyievLcSfI2aGvl/VtQCemc9lwHJRk9elG3IkS0if
	691YRP2l5MrZc/9h6Qe9uFOk8ybA/oMRSe0o54bp7JHmi21iULKpwcN8k8YT2UUZnr2SeAE5dED
	38CDE+HjuhN8FS6dKB7PL1zZ5F2
X-Received: by 2002:a05:6a00:a0f:b0:829:8a84:b9fc with SMTP id d2e1a72fcca58-82d0da33e8fmr19072261b3a.8.1775637226337;
        Wed, 08 Apr 2026 01:33:46 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9cf065asm18822427b3a.8.2026.04.08.01.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:33:45 -0700 (PDT)
From: kaihsin <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.von.dentz@intel.com,
	linux-kernel@vger.kernel.org,
	kaihsin <kaihsin.chung@synaptics.com>
Subject: [PATCH] Bluetooth: Add Synaptcis 4384 Chip Support
Date: Wed,  8 Apr 2026 16:32:17 +0800
Message-ID: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: kaihsin <kaihsin.chung@synaptics.com>
---
 drivers/bluetooth/btbcm.c   | 2 ++
 drivers/bluetooth/hci_bcm.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index f9a7c790d7e2..21ef875d6aa7 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -515,6 +515,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
+	{ 0x2128, "BCM4384A0_AP6684P" },/* 001.001.040 */
+	{ 0x4119, "BCM4384B0_AP6684PL"},/* 002.001.025 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 874d23089b39..972685e83b8a 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1609,7 +1609,8 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4335a0" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
-	{ },
+	{ .compatible = "brcm,bcm4384-bt" },
+	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
 #endif
-- 
2.43.0

