Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B3288C2E
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677351; cv=none; b=XaSqWdIWwNL7dXuvPsswoeOTpcQhxl/J2J98ywtCXZnGQXbouZFU10NpVhAFeNx5P/QGKFrO8BAuPSlUJy6nhhyViEdtPaazldgW/UPgIcb+qt4bhDwLfSUNGNs9sirWIvA5JEK0GttnIUMPodr1wrNq2zRRUPMfiKUfgs0XBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677351; c=relaxed/simple;
	bh=lKxaL20oePCv2sFpFvvHCRuTKgfHvhloMG8dCtAyTd4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ml6JptiPWzB6teFywR6OAmeTPZThK1YEQtRH247obxutkB45r75SDCceG8xfvNheS2ugJKkmpkmDOiYhCN7fKszFcLZXc8v8fYi0yUbwOIne9RnG0wbRCg8v04Qu7B1q7YklGoTKA9grfgpz84HrZXR/QI7kKMBCwTHUiVBcnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XydYtKxL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XydYtKxL"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74019695377so3718119b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747677348; x=1748282148; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sKX0qFCazqK+sqPKqdarJX3eV/xPw53izpe4xOOXTKY=;
        b=XydYtKxLtumGP/THRnQ9ORhAydblCwy/JAF/2uXbBllVWNhYRxtSpehmaW96Y6C4xu
         D3or6PY/f4kR+R7qkHCN4lsjrlKEeps0SUQZfpOA6/t/uS9iZDKdmw4DYJb15MujZsiA
         r+/eLWkO/fGmFxP7hHTLJ62a1F2Wqrrsd2fo56FOHKmntVsOUwX5y0vRCA71BQaMB6WE
         K2Xt2mSiWh4+V52Wk6qQRCGdWYN4z4wpefGe5SDOVzQAbx7YfJ0ftLsojI+UIAY90ss8
         OZC3+ykhoEczBxrh37o35e1FPoZSX75t3KXrWCoOjqMe+Rtt3Wkh5QNn76VD/5hpU5Xr
         6beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747677348; x=1748282148;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKX0qFCazqK+sqPKqdarJX3eV/xPw53izpe4xOOXTKY=;
        b=H/E4DehOerJ8zgyCqb1pMeyfnp0PvJQuRGib8yVdbx1zlmfFeVc5FY4miWS/mb2mc4
         hwl8bFexLirTqQaqg0kzhi3dOkWmFSV0rk5QCIPhFprPj5Ni1qHfgyABPh3qzSRV/HUz
         1Q4kNuwZM3ZGeLJclKLGT1bR8HQwX9/Kw1GybAMtaHCVOJTD8fmiq6ILweT+jw7KOpNX
         R4hJ7860rv8pH1Ku/lDGZTav+SFXhCmrK21ix3dCN0Osm5xqj38PV88untxJNa8jCZkq
         5W5a45G4OhKFNztaMRHV9wcLXbq8wZtMDUILBWc9UJxB4KYoV+K4Ti/u29qU0QWSv+J2
         RI6A==
X-Gm-Message-State: AOJu0YxeTMT4tvOgEFcML5Dr+im60TEwzrCsvxNktu+P2VwSXek/162v
	EvpAxFhANa+XTGZ+Fb+xCALCehsyQFx1J4utK0UQ2+dfuR8qLGkRMgW5PxXJiKKoEYr7Eh3mheL
	TgXhydh+SxVIYnsPlNP5vah0MAZY4eJolaO6sSDQ=
X-Gm-Gg: ASbGncsYSCXNt9BPUBmg7ITA4pznIox5znqbJhpkxud/P+BG3ArGBr9GzyinaMQ4xio
	jrXU0kOg+8TWyHsHi9cm07b1vRMyfk5PMwQ077mxxFgLi7Bo4IJo8EJ86zglyDpFoP42i6pO1Y7
	LpKROu9I2eAO9Q2kKoglAFVo2vF6cv6nOCobYri54z8awqF2hE1W0NRzQznzGhdhR0
X-Google-Smtp-Source: AGHT+IHeSIjhdAVrRtyXebhIw5dWmDk+er1kBl1hu9TZ2RPoXuKEgawI12bmdwOwXHFTSls76xJDWsrzFGgJ7k97K18=
X-Received: by 2002:a17:90b:3e8e:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-30e7d507dd1mr19623791a91.3.1747677348369; Mon, 19 May 2025
 10:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mokshraj <mokshraj20@gmail.com>
Date: Mon, 19 May 2025 23:25:37 +0530
X-Gm-Features: AX0GCFvbXiOtZIjZ5eSSKzkoFNtxgJ0th6Ym7VGrbcLSHgq9ezJ8H8THC20r2a8
Message-ID: <CAJRNte7O33P24v5o9C3K=tpwtP_h2Ohg2arYguF=C6-4Ga8pRA@mail.gmail.com>
Subject: [PATCH] Bluetooth (btusb): Add quirk for Realtek USB device
 (0x13d3:0x3601) for proper detection and connection
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: mokshraj <mokshraj20@gmail.com>
Date: Mon, 19 May 2025 20:07:26 +0530

Dear Linux Bluetooth Maintainers,

I am experiencing an issue with my Bluetooth USB adapter after
installing Linux on my Acer Aspire Lite AL15-41 laptop. While
Bluetooth can be turned on and is visible in settings, my system is
unable to detect other Bluetooth devices, and other devices cannot
detect or connect to my system.

My Bluetooth adapter has the USB ID 0x13d3:0x3601, which appears to be
a Realtek chipset.

Here is some information about my system:

Problem: Bluetooth is enabled but cannot detect other devices or be
detected by them.
When it started: Immediately after installing Linux.
Bluetooth Adapter USB ID: USB_DEVICE(0x13d3, 0x3601)
Computer: Acer Aspire Lite AL15-41
Linux Distribution and Version: OS: CachyOS x86_64
Kernel Version: 6.10.2-rt14-arch1-6-rt
BlueZ Version: 5.82

Through some investigation, I found a potential fix which involves
adding a quirk for my specific USB device ID to the btusb.c driver.
The suggested patch is as follows:

Diff
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -555,6 +555,8 @@ static const struct usb_device_id quirks
  BTUSB_WIDEBAND_SPEECH },
  { USB_DEVICE(0x13d3, 0x3572), .driver_info = BTUSB_REALTEK |
  BTUSB_WIDEBAND_SPEECH },
+ { USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK |
+ BTUSB_WIDEBAND_SPEECH },

  /* Realtek 8852BT/8852BE-VT Bluetooth devices */
  { USB_DEVICE(0x0bda, 0x8520), .driver_info = BTUSB_REALTEK |

This patch adds my device ID (0x13d3:0x3601) to the list of Realtek
devices that require the BTUSB_WIDEBAND_SPEECH flag. Applying this
patch manually has resolved the issue on my system, allowing Bluetooth
to detect and connect to other devices.

I understand that the individual who provided this patch does not have
the time to create a DKMS module for Arch Linux users. Therefore, I am
submitting this patch for inclusion in the btusb.c driver. I believe
this would benefit other users with the same Bluetooth adapter by
providing a default fix.

For further information about my device, you can refer to this Linux
Hardware Probe URL: https://linux-hardware.org/?probe=b58f50ee34

Thank you for your time and consideration.

Sincerely,

Baymax(moskhraj)
