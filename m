Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AE1D88B4
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736984105; cv=none; b=aXbYpVhAfnTapyGcUjBMO7mo/iYEvrLunD/ssDeJe4I2Qtv4q4B/Q9BOykFZjedJS5YKvx+jMrpXKAPKEf7MzZiXUDTkSAaCxVMWvwBm60WKhgrhuy9mps+jhirWgHFg6l3/X+ezIbSJU0iEfZHAFOiGn4Xzc2myE1dwKhWskGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736984105; c=relaxed/simple;
	bh=nbPCnOyIly/Ub/1Vfbdh9QCPImdQUYQJRwi4nF8Sm5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tT5XIn7t2yxpmsLvAzmVzK8jDCWaiel5XQ5vEj9t94ikqM000LEbPetsUBzz1QEp0F6e7t1qV3Et09qMCnR9GqbJjxookbRBGBpiF53AeBRZWQ8LiRDG3eXoXJUzPNSgW37Dg8PqihMXKoYOb+9Mgpnm7u+OP/Ns+1S3JR9DAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9q+TTsm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9q+TTsm"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so207178f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 15:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736984102; x=1737588902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmWy2HAAfgt1fIQfpSYqgiZblpv2H/U1weouhPv1D2I=;
        b=S9q+TTsmqWzkOdA/jsp5jSzf0cqGbhUsbeMAO/mSl/6MC3bp/ySfAWZlBsIoJep2l8
         lzdWj0noXU1wAflIBUiRsnlZu8a4ip7JkFaMTkBONEB0cKED3R5x7fXA/Mr4lfrnsWAw
         vEC8k2F4cdBWWZIiSQhDsNGpIz7ajHfs341U0RT7EYNrRtwQW+oACKkZeWmA1IBfGV0I
         yCOCL1pBIAGzA9h7Jgtp27TOJsAT6wKvm0xKEU7ix1u6nB7y2A2icCVtd+3gf7cP/qXB
         mIexXwc8wTDJG3b3DPH66llP/h4B4edBorqkxBdPoztvdBP125mkTqXSm+0gnlaUXbne
         BKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736984102; x=1737588902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmWy2HAAfgt1fIQfpSYqgiZblpv2H/U1weouhPv1D2I=;
        b=NHSqh2dFglZvXJu0uaPEZd3wOJFHjJ12bzqdMDPWfAxOad39MTTws/w7q1RxTl1raH
         LO6QbT3rUOcg902SA5m0VsTeGalJS9+SJX+lySz+Fr685SmsXUOJ0lJ9+q78PCkFtFPM
         M803jjwUvn7LaECVrsK7thAcQEgSeZeodqpS+Q3mwD3t8rKrEWb2RMNUf2srBwrfjhvT
         QdtL0XDyDw1FJxv3JE/b8CSLci1+bBn6oZmaSlU8o8F00NvmuJoCdFZjEiB9VRE6eNYn
         IteY9mAMk8ZLvuHqbjKbb0FXB/+O3vgwMxFwX7h1kBmFt+0zKkc+V9c437efDQ0SA8zo
         Fohg==
X-Forwarded-Encrypted: i=1; AJvYcCXU2LunhXsTI9Ae5aGnXr6Sm/wsMZ72/0gJY/2S6ylUiQZsPeZomhHxl5lhrp9czqztsG4/+6zeWl9aY0HqqnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaDY9lhOy6OU0XzP1U78k8Y7ZOJtYECvB15/Q3XiBt3idNUGHd
	Ui+rI4T02Xgr4SPE9S0MIaRhZn1OPb1Md+Pu3qM/As3dwkUiv/E2
X-Gm-Gg: ASbGncty6pCo2G9PdShz1xXREBf7+Tz79ZeudMU1Olb0STPpZ3wo/Eo5u7+4MPKi9td
	ZPebhmhGs9rysjOIS30n/yk8RXd11A1c6woPwjYtEuU3ZupyaCAHCASRMXR2+Vww729DJYeMHal
	ZLbHnnLKAosvH6fYeo1C5zxMlBjJSnxWCBJMSncaQMgQKemc2r7mynizM0RiJl42KQhanIcrmaf
	vA0r1yFl8wfDM76dSxRfU0Umk7W5eyqNQEnLtDp+v/8VM60ctbDZWbgMIXIM9mKyG9lO8KLjfwg
	b4K4dZIHtzJDG7NOnCMawdOybhngJkSyBw==
X-Google-Smtp-Source: AGHT+IGBUTKBJvOElv0lBfmQaYf/7evk5jNIWjywdOxPVFqBhS0wUwNOfMy8qG//nQl4gk7TiLp46Q==
X-Received: by 2002:a5d:59ab:0:b0:38a:624b:e37b with SMTP id ffacd0b85a97d-38a873564a7mr28068877f8f.53.1736984101591;
        Wed, 15 Jan 2025 15:35:01 -0800 (PST)
Received: from localhost.localdomain (193.89.65.81.rev.sfr.net. [81.65.89.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1dc6sm18919513f8f.96.2025.01.15.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 15:35:01 -0800 (PST)
From: Dorian Cruveiller <doriancruveiller@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: Dorian Cruveiller <doriancruveiller@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add new VID/PID for WCN785x
Date: Thu, 16 Jan 2025 00:34:31 +0100
Message-ID: <20250115233449.59046-1-doriancruveiller@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add VID 0489 & PID e10d for Qualcomm WCN785x USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e10d Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
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
I:  If#= 1 Alt= 7 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  65 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  65 Ivl=1ms
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9aa018d4f6f5..4e5cce4d6a1b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -375,6 +375,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe0f3), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe10d), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3623), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info = BTUSB_QCA_WCN6855 |
-- 
2.48.0

