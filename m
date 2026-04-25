Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B23112AD
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777137022; cv=none; b=NH4bIlhwW3DFs73VETC2TbnzLvWowK9XDAfIJJ9VRn+qAZHtRcO+S5J0WmI9l+bmkfAELM0lhDa7fF55nrgRCl71VkQcc9wwrbs+OWFusGqWQHn5dQrDMOlsqr7W9MI3YoyW+0lzQJVbXN0uNI6uXIehOFzAd8NCgsfR3s6IDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777137022; c=relaxed/simple;
	bh=X5Cg3xLyk5z2m6NK9vtJiWeFTQkmVMWSGf5neYS0rIE=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=WxRZog2JaNv8RF6q/5U60jk1LzklWFz5I32GCLXZPPIJZDDlr7AFJSdkm+QS2PiKR7oE96TOphIe3gswdlvqaip8iuVTW+sVb76OU4lAlp674Ui17jNcYf1YIkhe6b/3jzRbW0qlU83Lk/0CZLiZNiGiAT8PHbMxx+m0U+0vQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b=iF/yDc0i; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b="iF/yDc0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777137012; x=1777741812; i=nils.helmig@web.de;
	bh=8pwIEnlyECnK4RdSLIuLEuiOxOX632BAE7pJWGGlTGU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:
	 References:To:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iF/yDc0iM9ySxDDR5znXM+8Tm0wuIHuKsHxFoO3UCtDes655Y5UXUkONaZqfPDX6
	 EJtcJGfZdKgan6o+K7peiNOqB8c4sZxxn9ks0U1GO5TLcGaqxzLxAZQjh+0sUAUCB
	 pIXaaphLXZAQAmz4kZPKsZqf3v68GBANiPriFMamc+sof0V3NIxod6CyUIDeha8mO
	 60vwWAhpt90DnZq3Bui3jZaVzh8zzJKgRNNgQgbUUoiwTzc+lnvtgX+ZdV1KKUc7o
	 5PkEsVyPfPaqr6ijz41xwwHVYwK0b/HsINW1jGRzxV7eohx3tv49lVbJ/pb8hJtpf
	 OjXqFj0MFraiYBv9QA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvsln-1vPP6p0FV9-00wi37; Sat, 25
 Apr 2026 19:10:12 +0200
Message-ID: <3eb4038c-9f2c-4d53-86d6-f3ccbb7b37db@web.de>
Date: Sat, 25 Apr 2026 19:10:11 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nils Helmig <nils.helmig@web.de>
Subject: [PATCH] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
References: <0154e5ca-b75a-4ded-a7a7-dc990422e11a@web.de>
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Autocrypt: addr=nils.helmig@web.de; keydata=
 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
In-Reply-To: <0154e5ca-b75a-4ded-a7a7-dc990422e11a@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ra7WzmEqd/fhYhXwmi0oyVlSVr0VLJXhe3iBW2kkAnJ/pwwIFpK
 jdqx639sE4AbVEm6G5+HszdMqU4szPcsVJVltrRb5e9HyFU/VjV1WokK2OGYToZSupfJC+2
 ltXso8A6dJXWEsfzseTgPuVguCIjUqTkBVqCTxrJdY2A51UYGB1biRSJeoP7T2XtsLGnm29
 08pTD2T3C4MYhKJaE/s2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BbCXwmg1qOM=;qwII1pTrtn3Z1af/ypYg+aedjyw
 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
 FRsCnDGuhJfPnuA==



Add the vendor/product ID (0x37ad, 0x0600) to usb_device_id table
for Realtek 8761BUV.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  4 Spd=3D12   M=
xCh=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D37ad ProdID=3D0600 Rev=3D 2.00
S:  Manufacturer=3D
S:  Product=3DTP-Link Bluetooth USB Adapter
S:  SerialNumber=3DACA7F14FD2A5
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms

Signed-off-by: Nils Helmig <nils.helmig@web.de>
=2D--
  drivers/bluetooth/btusb.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 572091e601f9..2570ebc6ad9c 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -840,6 +840,8 @@ static const struct usb_device_id quirks_table[] =3D {
  						     BTUSB_WIDEBAND_SPEECH },
  	{ USB_DEVICE(0x2b89, 0x6275), .driver_info =3D BTUSB_REALTEK |
  						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x37ad, 0x0600), .driver_info =3D BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
   	/* Additional Realtek 8821AE Bluetooth devices */
  	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info =3D BTUSB_REALTEK },
=2D-=20
2.54.0

