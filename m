Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4F2FF642
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398431; cv=none; b=I9shoGLbZYNrAtNJ/CJ4ik1UPCFk5NTyOIRXRqFd9ji+JsDbXcVBuc+PkIHC9cCa9754ymg5PYL0orLd9xpI/fBcIzRF80RadKbYPab9s1M3GyjzSjcVHQUYfK37E2GCvuJ5pFeBXifQhQoIiGPSQsGcpSBM39sWLSVmIPGXJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398431; c=relaxed/simple;
	bh=b/ZPIAYf7o5aeKdR0Wa7PCHaK7ibBY0gOPzRYgHd2dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oY9uM8jBTmWYMO8nQZL0rG9oOs6BKOaEeoSoKFsG8ibDbsFefhEfEQXWAz/KhRnQfhMS9chVkakFzfVTnu0NCkW3I/BDR6Hqpz8TXM5HZB88B02oGnG4jnzcOuOAPdeR/eAEv0lYfVJYLqoMqcUfh0+N3vKDoUsKezXcKHoVEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeffT0l0; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeffT0l0"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8885aae52b1so2466996d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 12:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765398428; x=1766003228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJFqedgOD3b6T5OmpLiCgu4ibvGTC1lALXgForQmmoY=;
        b=KeffT0l0QgwPRpR+xsbPmkVMv2hsD7wwx3fcGqaUeBNTaD0yTcL6QpN/RiPuwsentu
         JXa54lIYx3kGrszdd4BoQPhwRbezUul91DEKj+Q00PQzndT+R0Oxaesh/JhfKlexoCGx
         dl5JDz9AjS76+wBzGJAtSaRLggDSd360ccqZ9lhqqNIuMgNDrb7UMRgI0iC+g6ugdOkS
         2kTFNjX5sWQNj9u4Fkx18lcWFkch/gpHxBexmyqHChC9ypDr5AkiEc16LqRtlK7+WstU
         2JUO7ZrqHSAZ1SCeHZexIIpHI5hr1LsutkWS/9lAnWCWsib73jhTssZTUOO2wkJaS3qM
         uzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765398428; x=1766003228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJFqedgOD3b6T5OmpLiCgu4ibvGTC1lALXgForQmmoY=;
        b=PgLfbzSDl3PD+KGL3v+04ULeQyKnU9wSgHfcMgY+6yN39tdEIdrijc39dPKXSvbOzt
         +3YJp99ggjogtKIH1mSDvlJIUxBc7eoTJp0adcLozNhNGxSucCPxXF70x6CYjgSSMlal
         tT32HSMotRX3jPqvh6435Ep3yaQFfhG0yRtfvXw05Jyr7N6ApjJK2ui7rtjjNjyVcDpW
         S2eWFvca8xLe8BMGEKvBAKotYoO9DVTv0LKf7mQQDQ3S2uuuqCnIP0RdqGYDnxn4s33c
         3Upe63qlmpRNdAXmb8X7iWK0MiY25Rtf7aqvoGnA0ZsgF8GZWKp+Nm9xJpgEzFqt5fea
         FSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFiF+EGwrysFXAYn6Ar5PWG7o7+cn1nWrzhw41oTX89MzFpaF1RcigXw6Os3uz4qI/mn/sNQmK0c+RNADOnYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIKNobzyq0eBo47CIJ6zMaR5tmvYbgyiUlw6da8Rez5umoO8c
	El8lDOfKQg+EZxk1AC7bGwC903CAy32SzZ7PNCXhPjVILg3pLHPm5/rT
X-Gm-Gg: AY/fxX6do7IYfLdU1J4l6fu8t0ffZIhgN0hX2z7rjGUczZZFaJZ5C3riTk2alYwzJJW
	C8oguln9OqSMVd0eXHgG4JIbsN5cJRKvB0CHz5ZU+gm5pkBzrW5yLBreEhG0k4+eMSwyFcVlrjO
	dZEXubyccnkqdo6AXMT43xUJwrb7oW77lahBS6v2XquKArWBGlM61MEKq5d8wLOzMr8kCfb8uIi
	SQiltxFLPVUKY/O6DWxItZmsUQfI/ogXqB/paB+dncqS6YOdjn2n4/gff335iwDey8r+mN/PhoN
	SHepVvufK6B4N6iUDxcK5PCAyXw+6DyTbd5suWsLyr7DSl2eLQhax8mmVTyBGuHDulV2Lt1Mn/P
	6JigcylDS4NgLgzxwLN9EMQ/HUkM/OlVxSicHh55mUyJmkpWfWGOygMXl19yAoWg3fnIIn5RPWw
	xBJrqkKpLUbol2G4dYK2/xi+uhnQ==
X-Google-Smtp-Source: AGHT+IGyYV5FcqzaMVDlmABo0DZ8sgEEj9IA0/Qgj+mKqZ5jOF90fZVePgOfbc3ld4wmMREILboRPg==
X-Received: by 2002:a05:6214:1c49:b0:880:527f:9493 with SMTP id 6a1803df08f44-88863a3e8acmr59793536d6.12.1765398428574;
        Wed, 10 Dec 2025 12:27:08 -0800 (PST)
Received: from archlinux ([89.169.15.126])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886ec55d55sm5217276d6.20.2025.12.10.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:27:08 -0800 (PST)
From: Bluecross <elantsew.andrew@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bluecross <elantsew.andrew@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for MediaTek7920 0489:e158
Date: Wed, 10 Dec 2025 23:22:25 +0300
Message-ID: <20251210202225.135637-1-elantsew.andrew@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for MediaTek7920 0489:e158

/sys/kernel/debug/usb/devices reports for that device:

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=03 Dev#=  5 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e158 Rev= 1.00
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

Signed-off-by: Andrew Elatsev <elantsew.andrew@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8ed3883ab8ee..f1943c6625b9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -637,6 +637,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3622), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe158), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional MediaTek MT7921 Bluetooth devices */
 	{ USB_DEVICE(0x0489, 0xe0c8), .driver_info = BTUSB_MEDIATEK |
-- 
2.52.0

