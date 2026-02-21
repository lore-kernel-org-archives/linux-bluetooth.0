Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DE51C28E
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Feb 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771681085; cv=none; b=V1D1jTcEDvQ2qORMVepoP3yCWGtRnCGmDx4JpGj9G8fMHcwBlVd2+g3HvW7Kse24g7QuM0Hdxs5MfLknYpTZq///S5lkny0dn2aEA5vCgTWUELTticVB/C78wMklB3VbJsl5iMwCYDz39eAREh4D1aNGgua4J9wEHNAFt04b9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771681085; c=relaxed/simple;
	bh=z6zf5bZnGhemRs/rm0HDlDXkI65kNH5qErAtFJBDB/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWm1TfWrzsA3TWWDIDsX8adgZUVA3FmLdQZwVFnRNghfuZsW8ohppWEc/GOSx1UOTlhz3xuXAUzKRCxDDoE3maBmGjvRqU8Z44d5xBp2zPqhBvj4GEQp1NyHQnFYM2AIO+HOIt2byJS5bLPNSKfXeMTKMRTHurfvpoI1vx2L3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzPXRB9r; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzPXRB9r"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aad1dc8856so20013855ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Feb 2026 05:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771681082; x=1772285882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyk6Z+VoDuJMdL4eJZ3cKHVL9+OM0IxwS6L8hXr1m84=;
        b=GzPXRB9rERwgIdqyW3Oi6pYjmZP97qvhi/XB4tBntWOGaiDhQOfNxjiYxA5DMX4C2x
         tOmUVv8nWAA+Ik1zavjUJOg2Vrwq2zV0qehg2P5I8sM+t/vaL5dy3kN9j4Vct11o6xAq
         1F6RQ8KLz1txtEBa+x3VKO//otxxTbVKTbrE1cRvQDC/9a/M3mGxGAxFi8cLaWGm+vP5
         cU10CeOw0TJKnv7BapChIyO9VmM0m7CGgENJI5u/XFBvtb+00xR25CJZPQXaehZfF3lK
         XXceOuDMDJLcm9bEvlhV7W7eErNLOBAwJIc/U1ftIWAlNFmhI07oF8/w1rNz+yqZk2Eh
         fsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771681082; x=1772285882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pyk6Z+VoDuJMdL4eJZ3cKHVL9+OM0IxwS6L8hXr1m84=;
        b=l0WxoJN9/EdgHu5EAZo4nNu7YsrqhRDNRban279BI+axi4bVs7FibFEwyb7wNfBxeC
         Putv5HCYsVtmlI1/laSJpboUFRVf8e31ninjS1xzPOlxqhbVQY9k1JSXPDwu3LALceQH
         af7XpGMLZSyH/7PylXYwFMs+d6yYZQiZRBaEk5p4NhxDTLeUeC/YETOBfWWiuynWpLKF
         hb/TjbuujF9vOW2fJaE9TL3RdsbeNQFXUfTNOi/jSt9vHNfiCvwOimpHCUucheyRwGSw
         N5WLbhmC88fyZECBo7psFAwFgA66fHLVfnqnVgO4J1cY7796GOkoV4CA0qCxcEoG5gNX
         MkMw==
X-Gm-Message-State: AOJu0YyI98aGaKC5QSabnYLko8Tnvv9FAJEexYtpPzLKSPN6m6VVWaUl
	rUbpHbT+XGvFWLnmiaPBeOHf80it8h3sIoapPBgsKZpGMR+g0Rb+mUam
X-Gm-Gg: AZuq6aLiB7LF8j8eFaJVWGF/AJUXSUTV6rZoNJdjpmvrEyDgj2sZeKhCeWcSzBXNJB3
	duELbwAcvMGcr15cn2e9cgNloweUim/ytaAyprZpbabmShl1ip3lnQvPW7KkHdSi4oe992PgPJx
	gsGIieEey3N1bc2ptGwx+DfLHaiyhjmq9lTz/hyKOZi5UQ8N2PCJ65bZ7JLKcMGLzzbV76PqrPm
	+8R7uHMVWk3Xbq2aO/kN0e+l9fTPcHmvvFIPYXaGFTf8s45kz82c/7t8UB3s9l/SDSV/NxaF1FF
	7q3kPCl13TR+zKBoUmJA8E2+B5J52/4aqKCOys6gAz1hYdyF3lmjgYu2tSYDOBdAV6ItPiK90LS
	heuKQfpMLYyqyfZkMOfLsl0FDyyfpiJvJzPNTGnEaQAwsQZbLBDKYnWXEZlvQrMQ/4YNVZLFe9P
	CH7rlM6vHnv8tXQBSmkSoWNt5iud50Mu+oUGJFSuM=
X-Received: by 2002:a17:903:11cc:b0:2ab:344e:1400 with SMTP id d9443c01a7336-2ad74515cccmr29318235ad.37.1771681081793;
        Sat, 21 Feb 2026 05:38:01 -0800 (PST)
Received: from kush-pc.lan ([2409:40d4:420d:708c:4402:953d:ce2d:1659])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e29asm21493075ad.44.2026.02.21.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 05:38:01 -0800 (PST)
From: OnlineLearningTutorials <kush.kulshrestha5@gmail.com>
X-Google-Original-From: OnlineLearningTutorials <kush.kulshrestha.5@gmail.com>
To: sean.wang@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	sean.wang@mediatek.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH 3/4] Bluetooth: btusb: Add new VID/PID 13d3/3579 for MT7902
Date: Sat, 21 Feb 2026 19:07:48 +0530
Message-ID: <20260221133748.309045-1-kush.kulshrestha.5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219231624.8226-3-sean.wang@kernel.org>
References: <20260219231624.8226-3-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sean,

Thanks for helping me to add driver for mt7902 chip.

I have checked the wifi driver for mt7902 and it is working correctly with new firmware,
earlier I have issue with old firmware, thanks.

For Bluetooth driver, you already added VID/PID 13d3/3579 for MT7902
There are some other VID/PID which are part of mt7902 bluetooth chip
	13d3/3580 - (my chip)
	13d3/3594 - https://github.com/OnlineLearningTutorials/mt7902_temp/commit/f94e0075ca04e50629852adbb567e130f8784873
	13d3/3596 - https://github.com/OnlineLearningTutorials/mt7902_temp/commit/2a3db89c7a87241846d166defa17ebd22d4be337
	
Please add these VID/PID or instruct me to add, 
below are device debug - cat /sys/kernel/debug/usb/devices


cat /sys/kernel/debug/usb/devices

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3580 Rev= 1.00
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



cat /sys/kernel/debug/usb/devices

T: Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#= 3 Spd=480 MxCh= 0
D: Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs= 1
P: Vendor=13d3 ProdID=3594 Rev= 1.00
S: Manufacturer=MediaTek Inc.
S: Product=Wireless_Device
S: SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A: FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=125us
E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
I: If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS= 63 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS= 63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E: Ad=8a(I) Atr=03(Int.) MxPS= 64 Ivl=125us
E: Ad=0a(O) Atr=03(Int.) MxPS= 64 Ivl=125us
I: If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E: Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E: Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us


cat /sys/kernel/debug/usb/devices

T:  Bus=07 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3596 Rev= 1.00
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
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us


Thanks

