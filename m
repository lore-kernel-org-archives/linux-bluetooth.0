Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9E1AD5F5
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238552; cv=none; b=TQs89QQBLkGISMb1sqZafCGy7nM1axBZ8Lz1796RnFdXgGRb3CS13EhGSh4xx+s1AKsHIiqoBUUq+sNt0piOixSC/zfwcaZGWa2FIwYtAFXsXveahdGe2Vf9CTbo+GP0T5sVcpjucKUHf6z+fa/2bzWwe4ezZWVolosx6rxV+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238552; c=relaxed/simple;
	bh=YVrG6AJk5oTeTvrBiM6AaRbdQDZPPnctUwe3GRN/JEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3jxrEEmhJlwT0MFbo8cQq8YhvQ3LEAL4WzYTDzFZ1DEMMt7bT2Q/sKh5dupcenzMiy0OrvuZDQp7up8qe9/0aiSs4M/VjFMEWRoFOGPRbZqypeVvEEQPqMnkJxRCIc5gwr8qe8ox0e0xSd+X39q7bqS+Yb7e1jLW6abGkmdbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noa-labs.com; spf=pass smtp.mailfrom=noa-labs.com; dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b=kY2VMb/u; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noa-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noa-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b="kY2VMb/u"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5334879ba28so700688e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noa-labs.com; s=google; t=1724238546; x=1724843346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnBBEUZIAdlq3yl1ZnvHaxJFV8MOE1rmA6uzjWijJfY=;
        b=kY2VMb/u7b0jRGEaDa4Iadxx8Cq6NUy3ehMcym652SJLBgjygkYnMpiiTIyE6RTtbK
         3uAIkczMy9Emmp8uem5695k41m7JoT+swHtD+Shhgam/7+R5OIul7/+B4FROwGUNIIAa
         uMe3K4mk8d3epJ33osAwcFCklFHoECP5VS8bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238546; x=1724843346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnBBEUZIAdlq3yl1ZnvHaxJFV8MOE1rmA6uzjWijJfY=;
        b=ZtqDTw/wSRzSrA8vXr6hrjAY9+oN3swUyioIt4EO7ByUFhmGpOnTRrBTaFYczO5+XA
         n0kOjRcvI8dSb580gsytmtx35pqCl4vcaC1vd7fZvot0U6nk2E2V79ozzf7PJrnrTgUI
         1jeJjIQan19aGoyCU1fjD0DWi9QBLPl4ambOTCsraugucCIhDd/W/zEUHf1ad1tT4FET
         HwwRUTHYpN66nonGzFFLcMX7N4USQm7XESfueddNA4fYsjYer8Nm54ITdxbqsvxcup2b
         EyVWe+eRtMwfXAQZw4h/yauWWgnB5tMIpQthaclLUDaG/UvyiWyIKzUbkGYQUbKCFuX2
         PgiA==
X-Forwarded-Encrypted: i=1; AJvYcCXYU82RFcbnyhPpL9PcS+QtWCcf9YT04y1TAAn+2daaqc3kHn5/eUaEycY8NbleWHHm+nc/e4SwPnffsleB3nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiOHeuLpmZcqO/ffqNxl9u+JRY1VeuPdf2MiJGeshso+WlPmFJ
	cyeM3N9VhCpnX1VXn1mlGIe8ZJ8bQwunqbgT6J826vNuvwfWe0S7abWah+h2E2A=
X-Google-Smtp-Source: AGHT+IHyGX+VNc/3kgCB8wcBAoEf+95o0xcAMdv1G/Rx/SP8cw0D4TfUmfNU8NGEHo2eAj+3DziiKQ==
X-Received: by 2002:a05:6512:1256:b0:533:3268:b959 with SMTP id 2adb3069b0e04-5334859942amr1536260e87.53.1724238546347;
        Wed, 21 Aug 2024 04:09:06 -0700 (PDT)
Received: from localhost ([94.201.20.73])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-5330d41eb98sm2021351e87.205.2024.08.21.04.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 04:09:05 -0700 (PDT)
From: Pavel Nikulin <pavel@noa-labs.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pavel Nikulin <pavel@noa-labs.com>
Subject: [PATCH] Bluetooth: btusb: Add Realtek MT7925 support ID 0x13d3:0x3608
Date: Wed, 21 Aug 2024 15:08:56 +0400
Message-ID: <20240821110856.22552-1-pavel@noa-labs.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the support ID (0x13d3, 0x3608) to usb_device_id table for
Realtek MT7925B14L found on AW-EM637 WiFi+BT modules in 2024 Asus laptops.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3608 Rev= 1.00
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

Signed-off-by: Pavel Nikulin <pavel@noa-labs.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bb698ca98..df0d2e4ab 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -627,6 +627,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3604), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.44.2

