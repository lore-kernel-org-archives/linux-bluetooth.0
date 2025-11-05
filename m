Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368927F749;
	Wed,  5 Nov 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762321835; cv=none; b=QRim9vS2TZrRBr2zMiTcrneH3+o67OkhVq+xWDRa5u7SyfPeg/bGslyxMGLC5JIEPU84HFzcKXbyl9Iddw9e8i9yumTUxgEj0VA8CJ/SFHRGlHsqT8KtBxQPgn9aVmpUk1fdVB4DZtSJNUG3zGerl+KL/1+RP0GYrYhcZsUaihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762321835; c=relaxed/simple;
	bh=RPicPCVopEvgvm0AMP8aAs+WZQKXxWf3ch40x7aUr00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTEJA6ZtnZcR3LPxFRMPGLYAumjHHwPX/wFeQ4bc+i/8w58rVH56zp2XDrEZUnjwrXj+aMbC4NCwqmGTq7v9Huczk3xuNHaNmbMX6xTCNey52vecoWEOIYbL4nHDvGD6xhhjpiotJM2G62lT1I6reRiEE3uLwupkv0Sti1mnnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R3wzQjVY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R3wzQjVY"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A55oMZj9506896, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762321822; bh=FUJUmkKgMyMxNMjetLQWaz7HP8KWqu0Bg+hg/PBiS/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=R3wzQjVY4ABO067IF9TnlIEofBBVJ0KEcYlkvfdwncZr1l3N9ea5GP2mWjt7AFCOE
	 YiwBlpiwcqYH8KI+vt+yeaqEDNw1u/V6eiRRx5oCIrvY7LC9dTpuLUarfs7WT/MIiX
	 0aYFGdYqb9r6UJy/Nsff/fmZPI5i94C3HBSDjJiqwlB0tJ8fx0/D7AXg/nVHlBLzgE
	 yJtN+pAIvZhQIpefSNQP+WP0fUXp05v53LgC2xc5N4gIbPLIqahPAC1wTkgWFf4QH3
	 65yEEtLjmYGroPYcZC+Y5XO820bgkml5EYbY2k9Po6iT3boOAb49yNA/aG3Mgmcs3S
	 0Fvo9ftrPzEAg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A55oMZj9506896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 13:50:22 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 13:50:22 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 13:50:22 +0800
Received: from rtkbt-D520MT-K.realtek.com.tw (172.24.54.67) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1544.27 via Frontend Transport; Wed, 5 Nov 2025 13:50:22 +0800
From: Max Chou <max.chou@realtek.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hilda Wu <hildawu@realtek.com>, alex_lu <alex_lu@realsil.com.cn>,
        <niall_ni@realsil.com.cn>, KidmanLee <kidman@realtek.com>,
        Max Chou
	<max.chou@realtek.com>
Subject: [PATCH 2/3] Bluetooth: btusb: Add new VID/PID 0x13d3/0x3618 for RTL8852BE-VT
Date: Wed, 5 Nov 2025 13:50:40 +0800
Message-ID: <20251105055041.456142-3-max.chou@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105055041.456142-1-max.chou@realtek.com>
References: <20251105055041.456142-1-max.chou@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the support ID(0x13d3, 0x3618) to usb_device_id table for
Realtek RTL8852BE-VT.

The device info from /sys/kernel/debug/usb/devices as below.

    T:  Bus=04 Lev=02 Prnt=02 Port=05 Cnt=01 Dev#= 86 Spd=12   MxCh= 0
    D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=13d3 ProdID=3618 Rev= 0.00
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
    I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
    I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
    I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0308fb92c122..6b4262755bda 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -587,6 +587,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe12f), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3618), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8922AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
-- 
2.43.0

