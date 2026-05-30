Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3C3AFCE2
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780145107; cv=none; b=DeZafN3pG2v5ybo2+qzTcTqgKW52UkbnmFxGvoAJNHd7zHTKS+Q2zx20FccBzkfaFUCzsfndMSwebXnuwNQRtXKP+lkx3ed2IXSGcJWDxrXkGaS4MUyLR1OoaC75pQLGMsYT6XoqF+ddwm125gb/0pBxC4PlUJ1h2tgFD6md+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780145107; c=relaxed/simple;
	bh=c8tA7ZolW6JzgpL9t0Mp+jY8uYTEEEZ08yJBJ8wdlEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utYwQRyQhVku5/dm/A0+UPMH6NxptQEr7LiDqjaXqbBYhMBVMjHofrueyr/d/w+5ObmPUzwkpkC6vXvss5mpji/Env/LeOg8ZtXBjVw4CXdGM+byHNBF/kmds863r2iRxUihgSIN+vhUGHxpM796ul5IvU2u9vhHW1lmveoC/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b=b1FxZVVm; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=nils.helmig@web.de header.b="b1FxZVVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780145103; x=1780749903; i=nils.helmig@web.de;
	bh=5cAEW/114qfNK0RcknNytKEpx6cqdrVIGrzrpje9ouE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=b1FxZVVm1WCMZY8GMAusUUar6I03FJjkXZK9mIG5i3NOb6AWjcb+165S+1MrnOgz
	 aC+g3WFnSHoUIRDRonnUSSup3k6yhTGj7t1Kw/biGAFcALzkee0CK7XA7nNOQqBWm
	 /4VSPJSQSn0hnqi5cmX4umhWn/psW0dg9pqGAI0NsbVSeqr5yerW2ghEFeLX2NW3r
	 vEYU6JXz/nxbfMeTsJfRWepZq7fv5UfUZitzCEe78MWURT212hsdVo8Ke6FmCd0Vv
	 wlQ3ymfTesLB/qZ/U8O9QxmfXbvrDRcLPGacySD7O+lyqLKg77L9JmNdz94sQkffM
	 w5XUzWCXkjSfZ4iAiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfYN-1wdvyP26UF-00XDyq; Sat, 30
 May 2026 14:39:50 +0200
From: Nils Helmig <nils.helmig@web.de>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nils Helmig <nils.helmig@web.de>
Subject: [PATCH v3] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
Date: Sat, 30 May 2026 14:39:34 +0200
Message-ID: <20260530123934.4583-1-nils.helmig@web.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u/0Ysona2bmPS68FSQNW3HCyVUNFP75UtZmMKf8an9iFvyFX7O7
 OcVHCextuFoboKZuAo4/b/nR04qZ3zBJjmMeRb1xrWiEHWzCV31zXbtk/Ia3IZRWxzTlvaZ
 dHzgB2HMg4qPYF67OU9gu30IRSHIrHlCO7BOXFNCZAjb4aGjzRXew9yN+79wcBooe08Iqg9
 NydX/YAL1s9X1/YftbCzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2GlvGeYxeQk=;EadIbtctzYev9S5hchniiQaj6Vk
 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
 r/tSSA==

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
index a13f10c7a981..3aef21d4ccd3 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -845,6 +845,8 @@ static const struct usb_device_id quirks_table[] =3D {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2b89, 0x6275), .driver_info =3D BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x37ad, 0x0600), .driver_info =3D BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
=20
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info =3D BTUSB_REALTEK },
=2D-=20
2.54.0

