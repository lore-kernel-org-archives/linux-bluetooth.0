Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2738B15B
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245854; cv=none; b=mmr38imIp7Bc733xMyOl0ISVGXoSY9cdCMCxyKGzqVYcTLydECBPRCGF1IyW6fBvw5cTGlOVT31Y2TvqeYH4+gwiFPy6dtP18IkYbB2DuP48qpl9bxDeforbQyfeTq61UrjJcHAlIydYlduXWPgpJyOA2k2etvmQ36VNMyKLJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245854; c=relaxed/simple;
	bh=T2bFpww+rgEEAyOGdp0PtXfda9eaAWspkZIPvXYBN1I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dF5CEXGo+dcHCKK0rSXxgIkL6O0S82dAxNUpT4Uot+Lbk4VtUqFa/ADEXQFtTLDceneTapepwfoLEZq3Ll1DUNqXl8trtGtN0HdDVM6dwTgNW/dx7SG/siM2vc6ueT6d9L0CW7/P1iIh8P3OP2XvByy/qz06J62IqWWsICXv8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKkYDfyI; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKkYDfyI"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so752544f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789245851; x=1789850651; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gkw8VJcAJ42dNVkJyi0skRnG8SBMgCJ1Y93cxpo1sc0=;
        b=HKkYDfyIfvpuIdKO47QQrevGo3QX88Iuc9+ghp1IScGMJ308ng4f0BOoJrZB0GMSbb
         as6tKXRuDWtMGzTKTQE1qqQkD+8E7tQo/LE4ZDMikZl1ffsisiRROrp/lqLlm4WjEJai
         fJqh1g+IeIDsyDLo7H1ReizogzStfSObX4Q77ZFzGf6643hFYRFWUTNCm9t/ZzhekncL
         SDHnp2FZvsASYDfE5YUrj+vTUJhWEyQHBnRPrF08TG9sZiH/TZz4FKw9i7dgTQGcl7cH
         JTZLgTtNDLzxVk2SLlaWL/w+BO3S6RPDdO4TySeK8i8K+aW5bkC6vhAKVI28bvkLAcJC
         uu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789245851; x=1789850651;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gkw8VJcAJ42dNVkJyi0skRnG8SBMgCJ1Y93cxpo1sc0=;
        b=omR8jXy/9nmurI/MWYRaFKJj34IRmYcGcwI3X9qPBUg0yqHyLEuGnJ/va12Zg3baxi
         8hvapp72rEeAqw9odhXK5dRCAM/FSfdFpgzj7HwSv/o35f3sydfJZxbVhOC8uTKkp2bE
         bT2LOwK4dsXnZAIQ7YmeuaG0ybHZ81VyKg7crIXZxmYpl9MkiY9hG33qdbVBJP5lGahA
         /YH595lKYXPk3WacbZri4+NkJuY/4DSWVdwxjlzA+oSpwg6PIi9xG6/AEZa3wJqotuJI
         64hdUB/tO1bRbptb2b8ATB6nG/3ggeZRZxwI5C3SZS0dOc9P2inChmc1cHlyjHUDFvwK
         O/TA==
X-Gm-Message-State: AFuF++k4j5KqUNlO0odhzZL0DdTuhZqTqG97Wuk4GwzgmNOvBGYBl9o0
	F1FV5LS+RXoJ7LX9G6tJlb/Um8lHWOcm7z93IAcpqtEVQoZAt70f/VAM2F9lqv1wI/P6og==
X-Gm-Gg: AYBFou22Q7v5eSKemS4zOG/KzjxYz9yruI6HoEq9jcnjzlWkJIuhvnCc7C8HGRQ1tqI
	x4QDmCLK8tioRyOX1V04XRfzBJK2sFG0tz2MA9D8oNi/yhDTjjqBjsUUAtpCcOPQ0pZhRQV99xY
	HaQ/zDUPgAHbUsbHr7K8SIVPM0rw6uRHZYuWTvJFZoQfcXztSUMQQiqi9+shnpgT19vOM3SsAmM
	9BidjNTL+WeroO9W2bxvsrgiwZklfWULqVRP0Pch7GAKY+gvRXl4PKDGxXvYQOKJVBIcitoqII/
	SoIN3O7+f0Ccumgt5CaIfL1JGeQRVJOZ/CGq+EduvFEihxFZp22I0xvVpz0xZCuBU807ORgubPh
	ooYi327X2jHkH1CnptpH2zBaDH2SWNXUWk83Ybs3eXBi5WPvuY9EziQCNHDhZsAqp+l2bYbbFRr
	J6RTbPMELq3Rc2Rupghc5vOuoO3N2zd7a/R5EItJIkQu2nqOhFdho1XWBRAQ8burfUxQXn+5lI9
	onO
X-Received: by 2002:a05:6000:605:b0:486:fa75:7d99 with SMTP id ffacd0b85a97d-486fa757ebfmr2368720f8f.27.1789245850627;
        Sat, 12 Sep 2026 13:44:10 -0700 (PDT)
Received: from [192.168.5.54] ([149.102.27.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e8d1sm14614411f8f.11.2026.09.12.13.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 13:44:10 -0700 (PDT)
From: Martin Luker-Brown <mlukerbrown@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add USB ID 13d3:3626 for RTL8851BE
Date: Sat, 12 Sep 2026 21:44:09 +0100
Message-ID: <178924584937.116572.13159457162680472249@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Teach btusb to recognize another IMC Networks / Realtek RTL8851BE
Bluetooth radio variant.

Without BTUSB_REALTEK, the device enumerates and HCI comes up, but
btrtl never loads rtl8851bu_fw.bin, so discovery finds no devices.

/sys/kernel/debug/usb/devices reports for this device:

T:  Bus=01 Lev=01 Prnt=01 Port=10 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3626 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

Tested on Dell Precision 7820 (Fedora 44, kernel 7.2.4) with the
combo RTL8851BE Wi-Fi/BT card. After the quirk, dmesg shows:

  Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000b lmp_ver=0c lmp_subver=8851
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8851bu_fw.bin
  Bluetooth: hci0: RTL: fw version 0x048ad230

and LE discovery/pairing works (Logitech M720 Triathlon).

Signed-off-by: Martin Luker-Brown <mlukerbrown@gmail.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 83d122de5..91e739c96 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -549,6 +549,7 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x13d3, 0x3626), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-- 
2.53.0

