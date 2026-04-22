Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8735BDCE
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893215; cv=none; b=KsKpTVRfylNaXtQ2LIRM/vdjszmyNPLT59x1uQjqQDIh7Ny4/YHNFJ8aJsk5spQK/6+xgZP19Dt9nb2irze7r1uH7mnkIrblnDwFnItJVOCQVa6DFbCzidBQyCJkVsJm4qRjWMyQhr+FlMqBS+Z7Iiece7rXroWsZvTpeLiCM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893215; c=relaxed/simple;
	bh=XTk8g8X3wtjzteCeVYRgIJXAjwaWlmPL527c/WbUMIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4zuN0fDibt2R+AMltdLcUy64CSav3SWFYVM1G3LDBMRP1X7KxTRCKWC1pq5yzxTFREYCiGbq849qsJRbKpD1Sk2Q6FZ68X8WBtrVMJ7D9DEMmV0WdhMTsDFB5ZIpTTucUK1dALRYDU7fj0Q50qxWzCpXdZnH86oJcMD+/KixPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UelY3AKA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UelY3AKA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48909558b3aso51181775e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776893213; x=1777498013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TAcZUFW4BdZqs/bflYGJoIbHq6Un6l+B8p1BTsJzVC8=;
        b=UelY3AKA69ljDmfpLWHJxPN81HEVMV4RJBBMWi6koZa2GeGaVqioCMPgQUviuyopYs
         3eVZ6cZFGiJNxhTDlK4Y3SPl4KUZjcZVxDLDvECHara94GqziEM/FkLxcarZpFDuDBkm
         i0uEu4kdG1ShVb1eGa6lfDurcQl8ZMEU4tLYkUSC0JcAgddXvZJiO0GWj7RUMytTbt/a
         oa1c7qFR63RjBuPAiWnUpJY2v+vqfd2976AaioqGMYbmEZ1mDcWeIajU6oSY/5AsGYZN
         J5tLfba0ykuqzrqHY64IdD2KvWkBNVN2IWlG7703y7SYrRwp7zPS405HoCfSITeFsdqF
         c+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776893213; x=1777498013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAcZUFW4BdZqs/bflYGJoIbHq6Un6l+B8p1BTsJzVC8=;
        b=a1ySup+GTVS+eM+NbTKUanM5aBpRa5n5k4ke1goKA5MF1TQHxNVOoO7ZV5o8Z2hIpx
         zd/oh5r+N4ep3b+P8lDMUzJGpJbqWZbmCyAun/JYJ4Ay4nI1RsuShgVLNYhUNqH5mduR
         mw7U15Zojnp4sdFvhi+nkkfM/Fo/ERXdvhcEPBawXjYUihuj+J15re25G0bmXnJ564NP
         nyxb+NbL9IJt4I6aNiGMr647vmrF//sqs0ah9wT1d3jY+oh8aNo8niptWpxB8YVvAqer
         5IkMtCgxqzWxyE1JCkWtZw7KDC+wxsNR0+cEQu/u7/zUrQHSY6R+xJt5mWri4kM/A5dS
         JF1g==
X-Gm-Message-State: AOJu0YzSzXudsqB+rrI+C9JK/AlUWBLWxJJ9WnNjI9OJxtyYZVYFsGs0
	k1M8HI1qniKtt+xPrzyIIOVUbWpmCFdxfoX5mqHJQoo2Ea9foUHGFYKh
X-Gm-Gg: AeBDiess7P9RcdBBPQElMuQVUw/90Vmk/W+ORgkbRFhLQOgBhgu0u5wsfsmfYodQuDJ
	rWHhuZhrJHafZN+YTuxkfigjt8BKV9ziPRSWhzuLhT5pXbAL0B8f///DxnFKg0dCRNRXXWMdHSH
	WoUBXv4OdzBLMq7CiLRMeG7NdyQQwU3JOcltoKiMhQG14bDyEYLGqA1Abs5FeY671W1h5Are1L1
	PEpZhQYyk+po8lWp9BaDeq/ZQXA0h+2f6VBPZl/2stXkdNF1SFmkcy2QgDmhmgKC5SJtSGLqeN4
	Cr0tky/tsmPHesfES3fFeiI36ax8gsX0ryBX0O+8xKL33SYueNjKN2RPDroe8un6Qaz2IZ0hILe
	UXqyojSnh3YVhGKq9qdC58MVbHAnzw2WCuSe+w9tBTEs547S56glC9AL/XC4SikURH0HP0zEoYH
	CbNgBFwWWXWDG/tMxYkGZC+wt73NZqfzBW3UEbWKqpvNy5CCnwZfXqnXBwMQ8D
X-Received: by 2002:a05:600c:620d:b0:489:1d23:4524 with SMTP id 5b1f17b1804b1-4891d23468bmr204832865e9.5.1776893212387;
        Wed, 22 Apr 2026 14:26:52 -0700 (PDT)
Received: from Hrvoje.lan (78-3-31-174.adsl.net.t-com.hr. [78.3.31.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5499b0edsm160801045e9.14.2026.04.22.14.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:26:51 -0700 (PDT)
From: Hrvoje Nuic <hrvoje.nuic@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hrvoje Nuic <hrvoje.nuic@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add Mercusys MA530 for Realtek RTL8761BUV
Date: Wed, 22 Apr 2026 23:26:47 +0200
Message-Id: <20260422212647.62497-1-hrvoje.nuic@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the USB ID for the Mercusys MA530 Bluetooth adapter. The device uses
a Realtek RTL8761BUV controller and works with the existing Realtek setup
path.

The device reports vendor ID 0x2c4e and product ID 0x0115, and loads the
rtl_bt/rtl8761bu_fw.bin firmware successfully with this quirk.

Signed-off-by: Hrvoje Nuic <hrvoje.nuic@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f57953393be..a0a7da498466 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -818,6 +818,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8761BUV Bluetooth devices */
+	{ USB_DEVICE(0x2c4e, 0x0115), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
-- 
2.34.1

