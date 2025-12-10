Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5162FAC0A
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408889; cv=none; b=g383EN+MWHX/AQeNILzoltHo5mpqQ0ao4WO2U5Ln4KgwT8ghn0eG/vgmSIpNU0UGVWoytAZwvnO1417dmcOFr/a/AJfQCZiKTGpkNjIkw2Mep+Xfneuek2MZl8kYmAni9XEmtyyWv/e7UIqpxQH49sUe82qfK9OI7u9Pr7KJpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408889; c=relaxed/simple;
	bh=7U6Hf0CN4Pzn/d+Dmrxb012ZiCGtKjQudcOEFKhWfgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/zUL6LAl/5p643P1wopaCYSEUmIqfNJC21xpM+shi1eUdP5+lT0Mc+ER1+q+zrROIq7dX2Y0pAawsPoONz412dbkVfih0JIs/lDbR5NVxJvBVBkdanM4xOHeZWZ6bMT2ySDxLnb8z/NOhc5bKw6eMeEhrv+VksPajPCiFcu9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmWHvfJ7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmWHvfJ7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so1947425e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765408885; x=1766013685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L08jHXpXjen58cg14Adrr2f98WJp67FFgA9qD2YXBHU=;
        b=YmWHvfJ78XWy0tgjXo1NcrTeVrmvUk9zr6aph0VUPcXF2BIf9rg0vDy111OToOolSy
         c1x3A2AISxATOAI39GFIM2FYc/D92E/DYK/t1CriigOhymbppGsEY0Wim6BMebrf7xxl
         TncGrjqHM6Sb9H483rnAh6Hv5bDVT5q73lUhd1w3t41Gu3xMqn7YtqNugMyv64luKruo
         AxCzoU2jS+sGGtdNWx23nCh+Fya5vKsQgFJjppQq7N/ufwSz2Na0O++cWpmnza9NTdpN
         AUfQGlIRILlPBiZTy/305Lavw1ZQdcfzhN65CfFZ1Qy+Yc4U5jqUL1mRR4OoWBwXzjD6
         GT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765408885; x=1766013685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L08jHXpXjen58cg14Adrr2f98WJp67FFgA9qD2YXBHU=;
        b=fW2WOTmvZcHyvAYAXotIyF/57IuOoJLkHUCjhrvsFpU1FToxPWJRdOpCwpsGMO6V5a
         jQnoclqI2UdAPXT2jJ8I0kDsDzNyCFCbMxcH5adXSBPUCzmTISkYy1h90kYJc2obvJV9
         e+51hV20PWgfKJZF3JAP05s419+aqspaUZfB9mmmZFn3UGvoI/gaCDWNBVyjUQR4dcvZ
         1ASnQiYVkvcZO65f2O329cw9Sevh4fa8jZ5068k32+zSFclA4Xtlx0cGy9+a0EDA/OuJ
         fo6F/Ar+2+RaViSLSrnGB5uve9ziXcjaRbrPl4OgbX55zOKFQLFEAgw7GBD7etLk9J58
         EjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Afr9FrmlGNbO7iyiQ9ysve9I9pcnJvcM8NxtRCjDfEmZ0iBkwqsyW1JIn7Kia8zuRDe90LLSc4SGjarxkzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Z3R4OGYpT3iFb3j8HzBSfaopVkVBy12b2lg1wH38McFjTOBo
	S2lYD07Cp5nwNSYm8mwYh3T/RPI2agWwl+ndZqF9PO6Z9IESr9M8Ze0XWyJYmQ==
X-Gm-Gg: ASbGncu8GgMlK2TMlRWvDE/nedk7HXv/+Bws4V8k7bECUutvcBuFKy4LFz+o6nfwsyf
	0v4Oqc8WXtbjt+k8u8mOVZQJ1LN0eLxY1h7XPxvBOGU1KSH1W/BI/Zbn2AXFTEUSdlwGnEpSEWe
	+liuxUPTfudQi/oxrBH5LCNLCQccOYma1ZtRiD/kBDGPIX76pUzpvy21P/HQ4CgtLxB0n71PXYP
	bMU4TpihFW/nY2k2TkOywUX6BWYb5q4oFQMyFEzpAOjpjx/8nnFIUoElLUy6lXp1NxdYwIjBqbA
	JVztRKjm4Ic0MHtBlAL6iSYXaIInZdqknN/QnohGrhZBb6GyKt+l2Ig2i5OZXKRFAxHZwuQP0Lv
	2kfjGNTibOE5zRFL51F0EIZzFkePDKgqHyLT0C7KWWsExGW/qkyGamZ0KljrDs+pFzIjCcj9+s6
	bGP39EAHCfk6nuz6vP2qQYcTrNy8uCGb/YLw==
X-Google-Smtp-Source: AGHT+IGHScSlL9cu47vMGSsn/jos8nO6lMKdreWx01YeiMB6yIIL90yCPe3N5A1FoFFavDktLuDS7g==
X-Received: by 2002:a05:600c:1c93:b0:471:d2f:7987 with SMTP id 5b1f17b1804b1-47a837b9a4cmr42271815e9.26.1765408885028;
        Wed, 10 Dec 2025 15:21:25 -0800 (PST)
Received: from dev-linux.homserver.local ([51.154.248.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f742a4sm654425e9.10.2025.12.10.15.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 15:21:24 -0800 (PST)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Neal Gompa <neal@gompa.dev>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_bcm4377: Use generic power management
Date: Wed, 10 Dec 2025 23:21:09 +0000
Message-ID: <20251210232115.547729-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251210211728.544677-1-vaibhavgupta40@gmail.com>
References: <20251210211728.544677-1-vaibhavgupta40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to the generic PCI power management framework and remove legacy
callbacks like .suspend() and .resume(). With the generic framework, the
standard PCI related work like:
        - pci_save/restore_state()
        - pci_enable/disable_device()
        - pci_set_power_state()
is handled by the PCI core and this driver should implement only
hci_bcm4377 specific operations in its respective callback functions.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
v2: v1 has a typo in its subject. This patch is not part of a series. So
there should be no '[.... 1/2]'.
---
 drivers/bluetooth/hci_bcm4377.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 45e6d84224ee..925d0a635945 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2416,8 +2416,9 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 					hdev);
 }
 
-static int bcm4377_suspend(struct pci_dev *pdev, pm_message_t state)
+static int bcm4377_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct bcm4377_data *bcm4377 = pci_get_drvdata(pdev);
 	int ret;
 
@@ -2431,8 +2432,9 @@ static int bcm4377_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int bcm4377_resume(struct pci_dev *pdev)
+static int bcm4377_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct bcm4377_data *bcm4377 = pci_get_drvdata(pdev);
 
 	iowrite32(BCM4377_BAR0_SLEEP_CONTROL_UNQUIESCE,
@@ -2441,6 +2443,8 @@ static int bcm4377_resume(struct pci_dev *pdev)
 	return hci_resume_dev(bcm4377->hdev);
 }
 
+static DEFINE_SIMPLE_DEV_PM_OPS(bcm4377_ops, bcm4377_suspend, bcm4377_resume);
+
 static const struct dmi_system_id bcm4377_dmi_board_table[] = {
 	{
 		.matches = {
@@ -2541,8 +2545,7 @@ static struct pci_driver bcm4377_pci_driver = {
 	.name = "hci_bcm4377",
 	.id_table = bcm4377_devid_table,
 	.probe = bcm4377_probe,
-	.suspend = bcm4377_suspend,
-	.resume = bcm4377_resume,
+	.driver.pm = &bcm4377_ops,
 };
 module_pci_driver(bcm4377_pci_driver);
 
-- 
2.51.0

