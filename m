Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0313B5A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735022134; cv=none; b=lVTs4lhm/pv1c4mKnB55VKOV7Dzv9YicTgk8pUyo7y0vgUKpLHs5vK8vZtk8cnsw44fNtAuUbO+c5jtpd8rCyC/eISIaiFIvCvUsmS5Q0F5P+D4SoorAZMoscC/PgKnN45lqsGGS2Klfwcjrb877LpOZ+EKY9k7/FukWEIQdrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735022134; c=relaxed/simple;
	bh=Fc//BvLtNzucggJF05op7cNgpfTea16gVJpVd23Rre8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y0NAblNbXOhq0D+UJnPQXe7yje/rPyg97z8FFiwa45y7p+a/FaVV7VWy4lZ4rDFQXzBTA0Td4m06f0g+Ush3MUpbZWWN+62mVerVTWhqzJePJuujQV8NtPkOYaRABGyDV2UAVt6M7GcTOHQRYcEZ/0uzTDBh3xn0zfL6rgwCGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qS7vcaL1; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qS7vcaL1"
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7758D40F32
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1735022127;
	bh=QHsr9mK/yFLgkCZbDNzHrvtRXwxS+ZRBie/IoJEYUVM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qS7vcaL1ZGPmeDH4DFTE6YftZQ2IE9z7uiTSMb7TlyT8znzbNF7dVrYtC3gvtKGmw
	 e0FuDyRD97OKXzbRZQ6NSHICOztHvlsSECwY9R6w+z6zGk0vDsQWvW8s1lgNgy59X3
	 Q/7PABqc1PCw4V2vhxfvjYDqx++xIXjZYI8dklVzyx41RcONlXBUP+8x30uWQP0SCi
	 cZkVIyjrF1Fq6/fYIMkW8sjlhEfzrMCHm0d5s3KHo0213hOv/+iapErkyKJB0jfwJ1
	 +HLi/W0ivEse1ulTI3h9Uogf7Jdb3u2OVRn56Np8kOsOL1CuKc+Izcby0cPwU+Q8FS
	 +zOkEe5C3Y63w==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2163c2f32fdso78691905ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2024 22:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735022126; x=1735626926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHsr9mK/yFLgkCZbDNzHrvtRXwxS+ZRBie/IoJEYUVM=;
        b=AgDraI7ITQZWAvosIrGCmckXHHHKaP8zg9E9Mx6d9RECdLA/gKr5PI5XG/uovF0cEw
         IjhYh28U1SLmvt1IR1eqOQjjzLxlij5Eek6J81h2s7iBkl8g8z03cbklmDPO5Iv6a3uB
         7eg7YUszCAdwF2SNl6TuDUcLX/6A4YFH6SO/45m4QvYyDCqvMcMAWQENgJP6YrCh9lde
         ZGhaw/REq4fEOSIj0VNqoGfHzNJ7dB4mmxQkt3n/mpXS6xTnIXK4XVHz2KLMJA5i/BHH
         Wt5I465CIn8qYvbDgjIWawHp5N4PI7qv0bWllNL8ztef/DhN5L2Pk7tcAyTyhlYcF3va
         8nMA==
X-Forwarded-Encrypted: i=1; AJvYcCV56J0WxwbuObOEauvVtanx9NniiRjsZuo+qsPaztNy7Tv6DCRUlqTNxhhFHbkox6W5ToBPj3YIr+UX8HxG3x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+l2vVwIZUJNPWoOfMRycM22P0Xx+KW0zUTYU1qhKJ6p8oPCX
	4nusTC6FixFY/m0Ik1Fbz0ozjpm52GmdyalNyJGe94U0CICWtfBFUBh1eXWQMeovVEQhp0+UaWE
	SPWjkegvjQHcwhqiUDSN742c9YLfpbzSIktvPgCxwsotl8DsvAd7LABFhe9eU8WvyL+bbJPMRFI
	shK4PE3VpSGu2kQA==
X-Gm-Gg: ASbGncsiSN9m1PCqgUpGEi7o76dMX2hCDrv+mNhed9D91nvG4n3kZOf5OmTQFLXD+DP
	J2B1A/BG5En5qUppuLryoBxWMyfrBUAdlNL73Gdpp7ecLxIihR7S9GJZhuurFpqDjOryQ/DdMMp
	QCLVRCM5p8wEHYZTjo54twHQZds8bYg5QD/WSgDNlU9s+yhxb+Dd5jFIHg9k5jV4wkuRzwE1feY
	FfHo5fTlYZavKg4ErWxRKQzKuVK7cJCgiND31wTjnVBZLzA5zzZhUzioAN+Cd3MdG3baQ5AmLsc
	YqW3dwBkHWLpTl5aMPC4Xa22b4QKu+Xq7Kgf6tqtKiD5aKFt0yqtVoLLeo4=
X-Received: by 2002:a17:903:234e:b0:216:46f4:7e3d with SMTP id d9443c01a7336-219e6e9fa68mr209031135ad.15.1735022125759;
        Mon, 23 Dec 2024 22:35:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgc7Th6s0aA0dnxlepxZMUh6gLN/w2mRq3nR4KRNzR4ZyXxFtGBfkam9v0cukTcBQWw51TNw==
X-Received: by 2002:a17:903:234e:b0:216:46f4:7e3d with SMTP id d9443c01a7336-219e6e9fa68mr209030965ad.15.1735022125458;
        Mon, 23 Dec 2024 22:35:25 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02e3dsm81305515ad.282.2024.12.23.22.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 22:35:25 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3628 for MT7925
Date: Tue, 24 Dec 2024 14:35:22 +0800
Message-ID: <20241224063522.82004-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add VID 13d3 & PID 3628 for MediaTek MT7925 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3628 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..f7a4ae5ff3d2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -674,6 +674,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3628), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.43.0

