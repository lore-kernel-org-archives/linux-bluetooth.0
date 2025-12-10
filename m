Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AAD32E137
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765401458; cv=none; b=FqBNpJrtl2JwFeeNgopvO6T7gkO3ipkXs7ZDXMDP8/okPBuUY8z4/poLMWQyOVuJtg+YN8CrTxW77wijW/CbNfZAebyBu+TpoDOm9v5wzfe1GEdhbkD8WJtPdObbtPF2M6bPRI48VVF/+idKt/taYNf3W45m/Bsf3ytSVhaZ7UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765401458; c=relaxed/simple;
	bh=TGnIFeubVY7VeY994lX8aOuQktK904Czk8dQrCal58c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/flBypXx+uBOhtUCI8o1d2vo+xgU+ZA9EZFtwm7eysKxmBsRckmgtwNIJC0ZI6xctM9hlr/Qp3rd1UFhjCIS94Mkam2SyIrGcg+qjAVgPnsFmpcUJLylo3gtc2OQ/kGFF4yYZYChAsBYgyuNaSFO4RS10lxwwDiL6y16yMdHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUSe8LzF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUSe8LzF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so2756175e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765401455; x=1766006255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOfFY77gZCltiZjkrHeQ4oE/3Skq9gP62li7AIVP3wU=;
        b=aUSe8LzFZAZ2QfpvEagHuotgsoG81zEDjOhDuERcADIpYjMN+o48HMbB0t9gfWDF7g
         idiiaF/a6Ie+xFnUBQT7skrZi4QAMHt1B+DJHEipWcxgCwdpzs4rjsy8Qv8GXdnpcMJo
         g/mjt32ymMp221ogQGhn0qaxS3Ws6pWqKUGHAtpq1AUxbKWohp44VhyBZdIn2a1Qhk83
         8odwNaUcWlnAocHfoNqkcWWmOM1nV19bj6kZwBY1fqw/sq6EkkL5ejU4OBWB5mbaJ44B
         Bakz4ZNwqzr5TgGXLGx2NOD389lMxix6nHVaIW9C/CK/JhnyGrDY/XmlurjD40Lc06ea
         NKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765401455; x=1766006255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOfFY77gZCltiZjkrHeQ4oE/3Skq9gP62li7AIVP3wU=;
        b=CpDUYuylSXXwF7DAfOL0n+2uZG5CM27jXSjPr5tJL/cQad6chSsrV+PYOC1Gv1px6F
         y1MFCFo8fVWYUkwiH86O/SVBd7pHTMaHg1sufvtlC2RTqocBUkJ+GSqFP7qxC8BKIQN9
         zOjCebO7Z9TI1yb5mnsg5DZ2TRpDYNGPF22PtrSqvpW5rWdG55qfH2JqtHSGo24YQtKs
         5ApS7WJcozyACeX2N1nyYEgciITWmIxbIKEF4f9rkLc4WRsKt4jADqMrM8GPRQq9SzZu
         TxwBzI0o1OuqGPTIksAe8/Lda0LmSDviZtEafGw1QjB1saIrKEIvJ4iNcE89iZ16edbY
         LLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6DFwhliaOG2yaYVdtswUTxnf50469a8+vCrJ23JEaoQypdnhWiz5QmQiiVeusS78CaiVYhXjWSp0enf0V+3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOJLQZO15J2/OeQXO7DlOtdDRmr9Lz1Y5FlyKiUKjH1v2yGaE
	rB6XGkqDdueWg0eq2WaGfE8jNt1OELswNcqy/d3JfMZIGC2idHDlJaLp
X-Gm-Gg: ASbGnctmWK9TyulLu+4AHTKyT27XMi66VJX4ThP8IzidEaMbonefAREAB+RIaezqAyy
	GKmxkWjn0MUwatcYyx/VGsivGgmk3weugp6yunPRhvuTy4O/dTcajtwyED/JG5oI4c7U5xBtKkP
	OzRtG/5z/hp3C5veFaRbgw3QV3o30cFWuQpvMD06KwhPUzwnR81D4/kd4L22gizJMsteojoIFAR
	v7t/rA8UKIPDzj9FM/dC0MFs1Db5sORC6fjeEnc5vzcde5I/qhSwtvpXTuCOESgLW0zq447h6xY
	KlTBGW9R5tQyVt3Lg54k1v6uIOYQbdAMWH56Ap5NzEhdxd5Gcsx03g1jMDNV1GveK+0I0aNUf3L
	z6GP8OU13dhBAUtZaIXWBnb/dv/J/QMlNxm5aUtbn2rvFAxpQxhgG8pb0qeIbACYnrexkaAY3oS
	FFXLaHywxmL1hNYLXi2JYZCi6QgNVUHVCu7HYFsbpQPDU=
X-Google-Smtp-Source: AGHT+IEllRKC6NDjpHfpSYxwBWFGd/XV/21Iks7SFysobBhsAwJQ/2swNyMn8d0YVqdg6M9x4r2d4A==
X-Received: by 2002:a05:600c:8b16:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-47a8375ab5fmr38139825e9.15.1765401455052;
        Wed, 10 Dec 2025 13:17:35 -0800 (PST)
Received: from dev-linux.homserver.local ([51.154.248.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a66614sm1113198f8f.5.2025.12.10.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:17:34 -0800 (PST)
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
Subject: [PATCH v1 1/2] Bluetooth: hci_bcm4377: Use generic power management
Date: Wed, 10 Dec 2025 21:17:25 +0000
Message-ID: <20251210211728.544677-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.51.0
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

