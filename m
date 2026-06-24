Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189333A8738
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289207; cv=none; b=GcFnyY8J3kxGw9oQaS4eVRQwwwGzRkLU5XWIktR1Hqe2ZMYD3KVCx9fJqSCeY5mAZU9nQ7yifuUw/lWowxnG5pyS5Sw+rHAfOQxM55Sa8Zn0XOH9gSJOdOrFBeApVogXX7EmutgMeAqfXs0luEOgsa6/noNNJSci+VAbEvprTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289207; c=relaxed/simple;
	bh=og06g3tIebt6G47dNNiAnfY0eDZVTjjEAMcT/oDPC14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5whgtFAA7OP4XqsHD75ksBGRqE9fQy9e7dH4s1hTgG79c73rXHpczQsVKXR+jV/huMHpLkGh28Uoc3FzoxLINaiTKWXPldQIu0S16+joFh0XvURYtb5JtkjmsPgWHjA7rS7Gu0g8sasBv3ZRXzuaOFljCaH2sjiKdNgNdoeomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=oAFkkGBp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="oAFkkGBp"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f236418so487661b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 01:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1782289204; x=1782894004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bo9LKgqUhPxYnRr7VaPH+Y+O7zLYtvsuon8V54p1Bc=;
        b=oAFkkGBpm0pbhpPP9ghWre6tAxv3J7X4WP55bDmwG/pHZYZ/4OusXLzOfnNuaHg8Xa
         cWHCP6NihQkZRFFHHa/r/JigIwqxNX4W7vN/c0jgyp8Imh1oZsaiKrhd7ekr1TJ/6QX+
         DpPRW/PZ4xVwzcYTlWq087dxGJsAMItLLuB7MqZFs3VuArU5ABe1iMNmIrl60lnq5M7H
         unfQL7wC+VeNnzLyyl3h4u4XPGZi/O5Svp0V4FT0gYV8QVjE78VvoJBbIolSNDCH2jZ6
         7N08R0ZebK0w02RtNRLgndpuDl/mHCv8gkUt4IbVZkKS9fIfIg+BFnl+i9YM6ZGIuo9z
         0bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289204; x=1782894004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bo9LKgqUhPxYnRr7VaPH+Y+O7zLYtvsuon8V54p1Bc=;
        b=iAY7s2qHBWgpFgcayUVqSKYz4dEvPkOzqmSSoBH+YIFj1cacdJ28LBq9eqJDn3dqOM
         hR7IiixjvgCnst6F8mYuHMr7MA66xZjwFAf5ipL5LfGJlvY3Fx+uurlSAng7rmHknv1o
         T4K2cLUicOyM7gjxfZVdCfYhpyKdQhUqVwfmOc97Z5SiH0LoImyUuhozx+/3GZObMwmT
         2VCSHiNMQcG2OCDO2SJe1oPuMDf6iXlGAQaXUbVJA8a/xJJeApKd+8N8NNS17E9Jo7UL
         q2Lhi92/Q/Z6o3m/ysz2vPTHsslc3lO3X0/Uxr96+bq7g46OF5sM0OnV9hcK0U7poFEG
         ZShA==
X-Gm-Message-State: AOJu0YwTI1iiAO1J2ivlHq37avKXufHPx64me1kbilT44RxTyWTAd9W1
	ajfAAwYbbvWorH04uk0gtJ8uv9PM92fjuduXLhArF16BaA81d7ma0FuIDUIVB7hCYXNXolwmciA
	8nz0=
X-Gm-Gg: AfdE7ckQ41dhaWeu+hVpDKyKJ6GPQoIH8XJjD2Q7uqqqEWucetYdUMGLa/XdxWTtGmr
	U7n7/zlvA5c0NltCWZxiTWUQlWYmWjwQPlXs04i77N8K8AMIzebx4hAl2VTZpCriYntUsqMgR+g
	Xu4crAIkrHdmF7fCsCns8caJgvJvaJ7o7KoKezQtTLybxAiGQ9ZDVqZZs02bmP0HJ80yqtQsJ2m
	zOMyPEiXlMFIKKpEFCIpgVBq8Zq+hWYNCbvB2H4wX8te53EDhMxxScUq5s0vvJMizsWMpoyr+8y
	PDFYYie4AyQxyY++19c1HG0cOzOSvLpl2Y6wSw4SxGYpEclngJzttZNvINkNs/QOrBIjU5Xrwri
	XVp7m1BM2xGoq/JBFgolQ1j/SAprE6xgDeKEz/Mk1+/Zym/DRi/PZvPIN3D66OY8lvKY1YtTQaH
	CKqnV7QVeC/H+Sge3LWV2Y7y9Adnt0Zb82H2ib8HzfveVrNKrS0qEMHNClZ7Pkxg7AeHCk5cg2b
	d1FuzTZLKpv4Fti0g==
X-Received: by 2002:a05:6a00:140d:b0:82d:62ed:b01d with SMTP id d2e1a72fcca58-845a2ca4fd0mr3024238b3a.45.1782289204296;
        Wed, 24 Jun 2026 01:20:04 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3ec0ec9sm1494732b3a.0.2026.06.24.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:20:03 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v8] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Wed, 24 Jun 2026 16:19:47 +0800
Message-ID: <20260624081947.2495351-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Synaptics 4384 Bluetooth controller
by adding the corresponding chip IDs.

Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
---
 drivers/bluetooth/btbcm.c   | 6 +++++-
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 463d59890bef..1caa1c9468d8 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -31,6 +31,7 @@
 #define BDADDR_BCM4334B0 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb0, 0x34, 0x43}})
 #define BDADDR_BCM4345C5 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc5, 0x45, 0x43}})
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
+#define BDADDR_BCM4384B0 (&(bdaddr_t) {{0x93, 0x76, 0x00, 0xb0, 0x84, 0x43}})
 
 #define BCM_FW_NAME_LEN			64
 #define BCM_FW_NAME_COUNT_MAX		4
@@ -130,7 +131,8 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A1) ||
-	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4384B0)) {
 		/* Try falling back to BDADDR EFI variable */
 		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
 			bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
@@ -514,6 +516,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
+	{ 0x2128, "BCM4384A0" },/* 001.001.040 */
+	{ 0x4119, "BCM4384B0"},/* 002.001.025 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a4fc3882fd2..d306da6a46ff 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1594,6 +1594,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4335a0" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
+	{ .compatible = "brcm,bcm4384-bt" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-- 
2.43.0

