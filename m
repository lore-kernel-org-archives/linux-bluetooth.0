Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFD93D667E
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264455; cv=none; b=DSam8HnJgtbPbdgRUQdPKfjPB3BLq0pPtRVBXe2i1iAhvolKdm+5dxu5/Pd6t2MCEJGtHn4b3+8fONhDinYwWlir/FN9AFACNxTMSOPNGQACiHVDwksTtnGnlD8IJ5cHXJ6qacCS3yZtFX1Xh59CaVQ2XiaB4K4aJ+gJjuGaW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264455; c=relaxed/simple;
	bh=UzIcKwXpw4fuUie2iBxAKODPGwpuUDtUgmAf/9WyNjc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nqqSbsCa7womFjsVGFUZF3FQeq6COPHgKy9pizbIidWCkuyO0vGCgb1Cz1cGo0XHjH471k+3UGQD4a/OTi7cDr/ch+dQ/WvdQ9qNZ7aaFxz271elpcfR8hFGsndc2eKUdOhUPO+t16oN5sCyG2kbK57IKZaYwj4Uyc496fgd40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korb.cz; spf=pass smtp.mailfrom=korb.cz; dkim=pass (2048-bit key) header.d=korb.cz header.i=@korb.cz header.b=Snt67Xeq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korb.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korb.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=korb.cz header.i=@korb.cz header.b="Snt67Xeq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so91785635e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korb.cz; s=google; t=1776264452; x=1776869252; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70dzwyc1gjl98sz/hl0UBQlHaUFIdk7Dc6ocK/SsSUg=;
        b=Snt67XeqBseUnYgacl/ECeouKjuAfkdjM76MPgb7TgnBmoKuloiAd2bUw+h8OzHJ8N
         7c0NO+HRpZFt2jpyCJVCAR93BZTpP6p5zjRyZ+E1NfjqYwP63hkLRrxAU2a6idtYMcSS
         lPiBQIgEmDYNHsBhTWFPD2O8mpK3J2/pYDHTDKD/nyRNZUv1zutBo1B9Mq+kHWaAv6VQ
         vctME7ayO8A+QHMA3RIw2RD+YPwIUMi1mHv9rzqOiFbjJ7V+3ma2cq0KOo6aOvX1RPpk
         9R20jDtWO4mKh4BAASaVs7gYrOjM7f6aTFBcFPtyM5YQwB08BkxoWhpS3SLkXe2cuMSp
         jQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264452; x=1776869252;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70dzwyc1gjl98sz/hl0UBQlHaUFIdk7Dc6ocK/SsSUg=;
        b=sF4n6u8g0Lnt3xwD4PitRnz0a9N6S03jsBC+24RXhLlTRbY/PRIFYfeLSQLtkU0nyy
         inuRf0dv5oXunizspanlr2Y37pq3sNlbXmXD8fUZWOr978yXYhRYNjPG/rKokl7u+xSb
         hWKu89QpGnzvgSdbrBr0zX+utvmk7Ou+y5Ay1/HyBY14RtkEfwfMrf7ZdunexsCldav5
         EH0xyOFFLLFHWjBstBgzIgSbP1JPNn3iomJqL1tFoW7hrj7mXhg01UMyn8FjK+V/1Ode
         j28gaLhXuN9V+KyMuv0X3KHX2KgBFrCUbnP72SBrnECcdjxM623fwnMaun5IpR7ixiDu
         Gv6g==
X-Forwarded-Encrypted: i=1; AFNElJ/Vv0paZdSyNXbPkmMe+yiIaPb/cp32lv9pPIS67Kbfb/han2lFW/A3OeE7iMYjqyTjbdwz78LG3xn4TsVPM2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnvlhbd6aQF5x4sQca3nsYimj9+BmtflB47dzjlL9M6zL8VsU
	Y+Z0GL/BjlNbqOPFrU3qE5+0znD2y2SHP/nHqC1ynaZotJFQIv5kiFO4jYrcG7WBPA==
X-Gm-Gg: AeBDietvdMDQBxrVuaWi2cfTrqQYAjWZgb36mUCQEK3r7AmhwzDHlMOe/2xLN1klLHW
	yCfxuJh3lHcIatiL31luDFywZ34w8XNR7lM6xkujKPsQkxF/g0H9HSvVgPSAJQuRXLMklbywhfK
	SppvRXAJ3JL0pI8X1JKfqZ2GXrEwDO8QNI+pG/LmKevsP9Oplkg2mvthB3skmXP95JnnPqMSiIx
	FX0NUbZNbYUdii/Hh7M2fbNPa8Zo/yGoZ7zp9cK8gA0oSlW2itEtFLC1eiL36ZWzgYTw2KK7Fgp
	OfV7tMWPYtwFvBiHwXU+zbBzwjkriBdHdxJdieQuY08XqJNaWOSSFeqFA+AE1Xlbv36soSzfMGN
	HbjshosbBIlx8ggb2I/9aCe3Jq0CIpU9RoAjgCNzDfZ0Da8OIQ/y3uYgkhjQJmMqUEmJ6nEoG5E
	9QRbs9p3Pc3KR1/dWjKfDE7KjbEDEsQp+OYT9429670Wnz7oNi8j8PkYYKi3OIvtbWMJbhA+pdl
	jNGdnYR1IFbc46uJod8fbQ03OJIeSphuOAIyRy6bmQV/U+Wd5HmleREsMqJKjQBSknl7sqNqdg=
X-Received: by 2002:a05:600c:a404:b0:488:bfc3:ef3 with SMTP id 5b1f17b1804b1-488d6671271mr273031825e9.0.1776264451581;
        Wed, 15 Apr 2026 07:47:31 -0700 (PDT)
Received: from smtpclient.apple (2001-1aef-c9-a746-809f-8b1b-99b2-55cd.ip6.tmcz.cz. [2001:1aef:c9:a746:809f:8b1b:99b2:55cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0948731sm23134665e9.5.2026.04.15.07.47.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 07:47:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Mercusys MA530 HWID 0x2c4e/0x0115
 for Realtek 8761BUV
From: =?utf-8?Q?Kry=C5=A1tof_Korb?= <krystof@korb.cz>
In-Reply-To: <20250225155825.1504841-1-mprnk@o2.pl>
Date: Wed, 15 Apr 2026 16:47:19 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C27221DE-E632-41C9-A15E-B393B6D314EB@korb.cz>
References: <20250225155825.1504841-1-mprnk@o2.pl>
To: Michal Piernik <mprnk@o2.pl>
X-Mailer: Apple Mail (2.3864.500.181)

Tested-by: Kry=C5=A1tof Korb <krystof@korb.cz>

Confirmed working on a device reporting as "MERCUSYS Bluetooth Adapter"
(USB ID 2c4e:0115, bcdDevice 2.00), retail product Mercusys MA550H.
Same RTL8761BU chipset, identical firmware load sequence.

Seems the USB ID 2c4e:0115 covers at least two distinct retail
products (MA530 and MA550H) from the same vendor.

/sys/kernel/debug/usb/devices excerpt:
P:  Vendor=3D2c4e ProdID=3D0115 Rev=3D 2.00
S:  Manufacturer=3D
S:  Product=3DMERCUSYS Bluetooth Adapter
S:  SerialNumber=3D088AF177D360

dmesg:
Bluetooth: hci0: RTL: examining hci_ver=3D0a hci_rev=3D000b lmp_ver=3D0a =
lmp_subver=3D8761
Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
Bluetooth: hci0: RTL: fw version 0xdfc6d922

> 25.=E2=80=AF2.=E2=80=AF2025 v 16:58, Michal Piernik <mprnk@o2.pl>:
>=20
> /sys/kernel/debug/usb/devices:
> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D05 Cnt=3D03 Dev#=3D  4 Spd=3D12 =
  MxCh=3D 0
> D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  =
1
> P:  Vendor=3D2c4e ProdID=3D0115 Rev=3D 2.00
> S:  Manufacturer=3D
> S:  Product=3DMercusys MA530 Adapter
> S:  SerialNumber=3D30169D905719
> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
>=20
> dmesg:
> [11106.761376] Bluetooth: hci0: RTL: examining hci_ver=3D0a =
hci_rev=3D000b lmp_ver=3D0a lmp_subver=3D8761
> [11106.762370] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
> [11106.762374] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
> [11106.762554] Bluetooth: hci0: RTL: loading =
rtl_bt/rtl8761bu_config.bin
> [11106.762579] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
> [11106.910393] Bluetooth: hci0: RTL: fw version 0xdfc6d922
> [11106.977569] Bluetooth: MGMT ver 1.22
>=20
> Signed-off-by: Michal Piernik <mprnk@o2.pl>
> ---
> drivers/bluetooth/btusb.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index f5609110f..0fc1dde8f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -739,6 +739,8 @@ static const struct usb_device_id quirks_table[] =3D=
 {
> 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info =3D BTUSB_REALTEK },
>=20
> 	/* Additional Realtek 8761BUV Bluetooth devices */
> +	{ USB_DEVICE(0x2c4e, 0x0115), .driver_info =3D BTUSB_REALTEK |
> +						     =
BTUSB_WIDEBAND_SPEECH },
> 	{ USB_DEVICE(0x2357, 0x0604), .driver_info =3D BTUSB_REALTEK |
> 						     =
BTUSB_WIDEBAND_SPEECH },
> 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info =3D BTUSB_REALTEK |
> --=20
> 2.34.1
>=20
>=20

