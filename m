Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACF928687;
	Thu, 21 Nov 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206798; cv=none; b=t0aYRSMC7TZbQMGTkudT21tATfXNGood4j4NXfICmO6aB4MlAMp10Bx050/Rlyd9mGYygxtIaGWn/otQw1AbkYU2akocL4lPB3qpCAua1JNcqCqfML5FuZgy/5wLt/PA9DqVmn16TbONYIQv/dvlhEPS8sDSb9Js9nDNqUgztyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206798; c=relaxed/simple;
	bh=/mPU+UjIe8W+XHB0r1nL9kkH7H9EfZg2AivzAulbi00=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=K/+NRhmYB8kJDU+JneYAUr/LbGy3JniNEep9iXtVxAO1YwbMTlzR285yuUWkfBKv8Kjj2B1VaL/NxqbAajUiFW7AHCnZjaTl3P+g4YsHy+VmKyOMPINbfpZGYdIHN7G1Xy/1h81X7gEbR7fSMewqGIRWP3Z25m4EU7ww9r547jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=kmUQKBLY; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kmUQKBLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1732206789; x=1732465989;
	bh=h+YkN5aqE9/ZRH8oVk6vPYweoPBu1ZNIseF0k9zNoiQ=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=kmUQKBLYHWZNrvQnoX8T7dF3Xwxz7tefNpSbkfwn/llXh53+l74oLpKdSOkiAfafa
	 G/TQL3cg/qNtRQWV9qFhEMQuZnNCeULWUfllW9RbE1jaGwRtS1wSr7glwnyE803Xwk
	 5Fn0JprS0ccniBglFiRHJ//QuXRphpZcXCIz8obTE6mAS3+Wpmhk+oSYmwalFaagQJ
	 6tGYWmEZ3P8z2U94F89fCPRdWGj+fUiZakWuM1FUp3awpD8vbS/WV365fo6DEhuauV
	 WjQm1KIj3muLbBYiaNr0v8c3SB4T7RviT557tz6fZ0ZFa+hbwVp9ewt2yL0hCTA6fU
	 n7Os7H5zLrqjQ==
Date: Thu, 21 Nov 2024 16:33:05 +0000
From: Gregoire Stein <greyxor@protonmail.com>
Cc: greyxor@protonmail.com, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add one more ID 0x0489:0xe10a for Qualcomm WCN785x
Message-ID: <20241121163259.180589-1-greyxor@protonmail.com>
Feedback-ID: 1917010:user:proton
X-Pm-Message-ID: 8b25073af9a006b983ff9bc025140851c710cffc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an additional entry with ID (0x0489, 0xe10a) to the usb_device_id
table to support the Qualcomm WCN785x.
The device information from /sys/kernel/debug/usb/devices is provided below=
:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D04 Cnt=3D01 Dev#=3D  2 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0489 ProdID=3De10a Rev=3D 0.01
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 7 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  65 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  65 Ivl=3D1ms

Signed-off-by: Gregoire Stein <greyxor@protonmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e9534fbc92e3..5e77257eef65 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -371,6 +371,8 @@ static const struct usb_device_id quirks_table[] =3D {
 =09/* QCA WCN785x chipset */
 =09{ USB_DEVICE(0x0cf3, 0xe700), .driver_info =3D BTUSB_QCA_WCN6855 |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
+=09{ USB_DEVICE(0x0489, 0xe10a), .driver_info =3D BTUSB_QCA_WCN6855 |
+=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
=20
 =09/* Broadcom BCM2035 */
 =09{ USB_DEVICE(0x0a5c, 0x2009), .driver_info =3D BTUSB_BCM92035 },
--=20
2.47.0


