Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E469368D5F
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Sep 2026 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638280; cv=none; b=LzSfOVGyyVQWJVXrfKRVqv8HkT476rayTgywIlm1UvRaSMAhSMRe0mhJ9zIM2IxzHoW262yCiA3SDACs+7P3IB/G6i+x9ja3jT6/qFpHV6za3/MiWNKy0IKHrwJLKxzEnuybNYTSIaxcsF3V/Xd49j9VmK+9/ZfHhzc3nWId2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638280; c=relaxed/simple;
	bh=R5/B5vGlSNPc0+3npUkTgg42Qnkjn1wNspAqrjKe4II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RtPDKhsbWgP7KbUwk7Nlzmpg/MiJCDzJyjlb0u/U56kHrMUzX3x+ngWwSSMM5hVA68I7nFtENqZJr+mo4GgqQ8nPzXLv8FtaK9J4TgMdv6k0RP5DH3/S/p03FGyrpGRtcEbp3G6kzdHqECCAODgbGimgytDowaaHTER8IiYj180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMnWaWEC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMnWaWEC"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a1a3bb6c5dso18401101fa.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2026 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788638276; x=1789243076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ss06BnBaR9nq6gnp+WtomXwyK13rwnEDu5T/dImWHuQ=;
        b=KMnWaWEC3dsqwV+EQYRFiQ+y4JQJ2pDh6Wt1oNd/GRZMJKqNdgpYFxzoVHf2gNgO87
         Nvi5fk8fNwMbmdq7WRRndd0jFC2NB6zm0lop/hoJGPRpaHQEzNS+9JRhq9DHbT2mqBUC
         t9qMcKpDF9KUi6q01BEhQLZXbb8SNcjf0fYGzT0zCJ0oESaY70OyuYoecxmb3A9JjsyB
         8/NoSIMXN4OYIqzPYX/mpg2hsUxESuucdB+oZedoJ+cdzqpt0jOW/+rQlualsAe8mxQa
         amXDyiP2JohhpGS/l0ntgQeLzp06rnaoJ9e67UZ2sgjKm2Piu+IDUvbflY+FKAHo3Q/x
         cwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788638276; x=1789243076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ss06BnBaR9nq6gnp+WtomXwyK13rwnEDu5T/dImWHuQ=;
        b=dJ0wNjorNNNlUIorOeT/V8RscYnbiFJDAdIyJVPSQOPQY+9APH1Py7XHYtj6L8NY9R
         R0wyFrbzELB7uQfiyswjgQlZj4Chg4mf+ADfHW5VdZloL3jQpoxHGy2vKUdHb3qSTqcW
         zCp96UJ+ldba47zuF6bzFRgxYNMRw5233GxGgFRwwGl8Bj1SCuGIUv7CGwhXR9kVFOLm
         EGHmsIu14zqhKDU4dzqK1PFulSOn8ZfgyPhvHgw0ELlf5Z+tkr6ZohZBTK+h9i09hrB+
         8CzDYCqAv1L0WJ5rkiSuL57E98+1+gvdNgS/KunO/WmKatZxUE01K8jTA6rpwqno0E5c
         n24A==
X-Forwarded-Encrypted: i=1; AKwUvBwJy7t2ue907fd/V0QeHSoGcEWhPqK5p7wiAhW5JBz1TxtEyDyhuhQ2NXAEeO4i+0RvQ27ifiIsrleG5QT3CJs=@vger.kernel.org
X-Gm-Message-State: AFuF++kgZGTh264f2RCrwX5vnlJ4DJJo0PyOZ5PGN5PaQ5Id3VuElUWn
	iRLwvTO5GW4JKL0YVNKq4jiSu5XTPYmin3E48/J3KZ4GmnutXAKwHJOv
X-Gm-Gg: AYBFou1W6yVUIQFPyXN55Q1Fb+2MxShi8qRpZt0cgVt+Wq1iq3t5lXSfYSs5o28ytug
	ZFcTmV8B16o22ccdHfnL+ZvF9xMbEzWS1DvpC/M1XPCtWdg/vJEtge7IPYmGDEKUlOqfWYKwvh2
	SzA9BNQCzjTlSxTBIByxejMgnMGqctFa+ZFLI5G2Tkc10hwPhkYtQRg83nicLxN7UucDlioSO+5
	MHmbDOqfAKKMfuKxv0MWH7JLtID6rSxZwKb8k0Ovg/x1cP1Bu5hB3e6Lfd3brtWkPuI/XZxvUeD
	FSGwpXoky8S2+9bKcDRGxtA/MWtm4805FZDezIT2Rd0xM8KnKb/9WUSnrLBtdzwUvUqCvlTuBhV
	DAj/W5kUTh4cVlXdJqVA1sbQh8nwu9td41VmPbpUNiHtgxuhklQ4r64GKYjBRzvXAQWT1JuNi4a
	hDHZ78uNc9K7/NShy0EYzJpyS9sHYQCOcao0jAEjgTE793jy2FrU3yNYCE9bo5KyXZVnuvKbx7g
	vUiH9WsqYz6g43QyQ==
X-Received: by 2002:a05:651c:a322:b0:3a3:7680:67fe with SMTP id 38308e7fff4ca-3a3768069a9mr10429151fa.29.1788638275969;
        Sat, 05 Sep 2026 12:57:55 -0700 (PDT)
Received: from White (84-253-240-120.bb.dnainternet.fi. [84.253.240.120])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a37059973bsm14985831fa.26.2026.09.05.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 12:57:55 -0700 (PDT)
From: Samuel Alhovuori <samuel.alhovuori@gmail.com>
X-Google-Original-From: Samuel Alhovuori <samuel.alhovuori@pm.me>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: pmenzel@molgen.mpg.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Alhovuori <samuel.alhovuori@pm.me>
Subject: [PATCH v2] Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)
Date: Sat,  5 Sep 2026 22:57:46 +0300
Message-ID: <20260905195746.244134-1-samuel.alhovuori@pm.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the USB ID 13d3:3631 for the MediaTek MT7925 Bluetooth module
found on AzureWave / Mercusys MA37BE PCIe Wi-Fi 7 cards.

T:  Bus=01 Lev=02 Prnt=04 Port=03 Cnt=03 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3631 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Samuel Alhovuori <samuel.alhovuori@pm.me>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03039ceaa..11c62ef1f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -816,6 +816,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3630), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3631), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2c7c, 0x7009), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-- 
2.55.0

