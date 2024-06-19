Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD6433C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777578; cv=none; b=nEClrh8BNLz7nZFLyamPCda0RYO1sZBAU5u6xsAA3QXN1V8E7dWK4J8iuIFWZYSE9TULFq+WsjHZ3e5eFITz1bVSBzibRMOy0UWrKZd0j6VNXOl0n1hPEOs1E6TvPczLffhsah5VayogNkCfNQuKsh6G23nrrzN8UqoEXyNB3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777578; c=relaxed/simple;
	bh=3L3Q7sJFZVQlDjRTnhD9iuFPDXMjIzoXOTUUc/cP8Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/sRufgrwxzyVcfoqawjEWsEyC9wvgIWpSt71kQp4hH2PiSGkq4dZ2+GaOMx+yvXaR9ODs5iWYuuOEtl2KBc9eKT9VqLGdJ9a3P/5HcCxpfOc0cM8RE2vnGdCqcN1wh+JLrFCzLXd+ngywwhfc0+aeHOF4IAlsMUEt2+O75Kcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1IvqoPl; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1IvqoPl"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d2255f84e9so219579b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718777575; x=1719382375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrO20zwv4ciLkCcnPnld9qFJwc7lrc44jjmj47nkTzc=;
        b=a1IvqoPlo8dlYWO0+973w15McT/7/CG3q19Ebv5PgBjNqOeGWt1ftfrqENJNGP637S
         HLh4IYChF8IGFDg5noM+iXqiLo8MpHntm9DPUV7VppmLKScHyjSbHeoNB7Ek7fpWrWr7
         zpRV3tCk4gz5/rIAUDjK3SPYIpMUBbkiZUHdDLPryEU0NvIa4ASQWEP+dwmpdmoImGWH
         vcZ8lTG9zTU8kTzZOocfeXEdJwcDKpjaPu3f8+sBr2ZFsiawxqrBccYM3iRQcMtCsh4r
         mogaN1dB+7535D2LWLIUe9ax3VValHzNTlxq7Wp9Yrv3nTSEOWQ91UlucnUJKvBqLcVf
         SxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718777575; x=1719382375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrO20zwv4ciLkCcnPnld9qFJwc7lrc44jjmj47nkTzc=;
        b=mY7UsN5J1/kMb2m8DKi0v/ga9BAxi3jRyhWs1VKmv6ah9LBFt3J0z0nMxMF1RdVPsD
         3nmafLRqhhgYeEBkpuTwmkj6NFEcR7A8P+j7VvrOkvPJ4FRlE2ZQvIR6WIq4w9qOgf3r
         uuwJkxEIbfIyhF+z6myFwRpG0hIgVM6euAb9LtWjSnRdGTBmS80KtmHrBo6xYjj4DGdd
         mjLJM5MYB1BTwbAob+Luj/VewLPjfnfR7KgeN67ojeVUg3l/33V3b09fP08gf0aR2e9f
         5Knbwg8hTpnT0L/AKq2fmjdjXZF/E+vt650xHV9AetPTZuCZGccudDAyZM7YV9Vp0ApJ
         7IJA==
X-Gm-Message-State: AOJu0YzzdH0hDf/hpHWQSjtEICa2HLRurrcIMqS8gdG90gfiKuK6Geww
	LPaCV6ysPhj5N3ZJBh72Bc2mSrNLWb8aGKIb5QQ3dYYi737uXnqcBTljPrFmEZ4=
X-Google-Smtp-Source: AGHT+IExsTkWQjPanSbbWRGda2EtyWc14CI0TjG7KXqTBxNFU4CLGKlIJa++idc8iqgRaL0VKa7OVA==
X-Received: by 2002:a05:6808:130c:b0:3d2:2fb5:b477 with SMTP id 5614622812f47-3d51b5d7b41mr1040774b6e.9.1718777575179;
        Tue, 18 Jun 2024 23:12:55 -0700 (PDT)
Received: from OPEN-HORIZONS.attlocal.net ([2600:1700:65a0:8110::3e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d247606016sm2057693b6e.21.2024.06.18.23.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:12:54 -0700 (PDT)
From: ultrabear <bearodark@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alexander Hall <bearodark@gmail.com>
Subject: [PATCH] bluetooth/btusb.c: Add extra mediatek btusb target
Date: Tue, 18 Jun 2024 22:23:03 -0700
Message-ID: <20240619052300.233657-4-bearodark@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Hall <bearodark@gmail.com>

This patch fixes bluetooth support on the MediaTek MT7925 WiFi 7 +
BT 5.3 M.2 chipset that I purchased from aliexpress (and which 
arrived today). The PCB states that it is an MT7925B22M.

I tested that this patch did fix my problem; bluetooth now works.

The chipset was purchased from here, though the storefront image does 
not match the PCB that was recieved:
https://www.aliexpress.com/item/3256806821207897.html

Signed-off-by: Alexander Hall <bearodark@gmail.com>
---
This is my first submitted patch to the linux kernel, apologies if I
have misunderstood any portion of the process.

 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e384ef6ff..2ea46a0e6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -691,6 +691,9 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3603), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3604), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.45.1

