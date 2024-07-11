Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FF42042;
	Thu, 11 Jul 2024 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675001; cv=none; b=mN87sm8FpBB3NpD1iHgRlZUqQ04Xl8TdL7s9LuxA/NOyzb/m8XGHt5xcmHytgBR7HNbhhGV6wkPtMM5XEn3bvytO39FSfasBjCdmj4jDYI081MUyJxSkR2Ub9WsNjNeNbNf6ILpZuJ/0BhBxw75uV8uhiHGIF71zcE7h/8Hn+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675001; c=relaxed/simple;
	bh=1x+J9pMwfe4Qq5Rzv6ZaCSuQ7soSmd4rCdTjojJz6K4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PSFK2KuCnsQG3EMTLs0ZTViqsqc7Kzv8FfLrYmb2P6K9TNwyev2dSymSoBBMtYZKUdcjfn2a8ZTLGyuL+iZ1dFGseMLvccfVU2bH2sPhaAiVjMfdQiwmDchGsYbPOyKImfSjNTqkrnIOS/mXGDSVjMP7vXM1YwzC8pPvFvEOCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XkEXICJp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XkEXICJp"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46B5GScgC2979187, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720674988; bh=1x+J9pMwfe4Qq5Rzv6ZaCSuQ7soSmd4rCdTjojJz6K4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=XkEXICJpcg1YeRAgRgicYtWiKFitbujEyUcXoF3F6KOk97dPi3VK3kls1BgEnAqgH
	 NQ197oCtTxWFcqTjZRZYM13tH0IPKPp2Su1WeCVw8kBahXSMvisCSh56DZwd+2VTGS
	 56P1QxTgOjqaOW0ZXMyx2DsgRHjI14T7STA9fK2RtBFp8U9rpR0UIRahS/zdz0Dc0I
	 Ijeeq1jnzF7PYJAiR6kxTQG9gJAaL+cMiEdE9DyQb6EC92d0WX5nJcKL58ejxT4d97
	 fZpHWfN8RD1d3lOBNXSYx2+D78WFLNWSaCjLCG4Bis029FzcYWTARRbsBgjWUguXtN
	 Kb1gTYjlWm2sQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46B5GScgC2979187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:16:28 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 13:16:28 +0800
Received: from localhost.localhost (172.21.132.123) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jul 2024 13:16:26 +0800
From: <max.chou@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <hildawu@realtek.com>, <karenhsu@realtek.com>, <kidman@realtek.com>,
        <max.chou@realtek.com>
Subject: [PATCH V2 RESEND] Bluetooth: btrtl: Add the support for RTL8922A
Date: Thu, 11 Jul 2024 13:16:22 +0800
Message-ID: <20240711051622.51389-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Max Chou <max.chou@realtek.com>

Add the support for RTL8922A BT controller on USB interface.
The necessary firmware will be submitted to linux-firmware project.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=8922 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00E04C885A01
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
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Max Chou <max.chou@realtek.com>

---
change in v2:
 - update device info of commit log
---
 drivers/bluetooth/btrtl.c | 16 ++++++++++++++++
 drivers/bluetooth/btusb.c | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index f2f37143c454..555c2964ec1b 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -30,6 +30,7 @@
 #define RTL_ROM_LMP_8822B	0x8822
 #define RTL_ROM_LMP_8852A	0x8852
 #define RTL_ROM_LMP_8851B	0x8851
+#define RTL_ROM_LMP_8922A	0x8922
 #define RTL_CONFIG_MAGIC	0x8723ab55
 
 #define RTL_VSC_OP_COREDUMP	0xfcff
@@ -69,6 +70,7 @@ enum btrtl_chip_id {
 	CHIP_ID_8852B = 20,
 	CHIP_ID_8852C = 25,
 	CHIP_ID_8851B = 36,
+	CHIP_ID_8922A = 44,
 	CHIP_ID_8852BT = 47,
 };
 
@@ -309,6 +311,15 @@ static const struct id_table ic_id_table[] = {
 	  .cfg_name = "rtl_bt/rtl8851bu_config",
 	  .hw_info  = "rtl8851bu" },
 
+	/* 8922A */
+	{ IC_INFO(RTL_ROM_LMP_8922A, 0xa, 0xc, HCI_USB),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8922au_fw",
+	  .cfg_name = "rtl_bt/rtl8922au_config",
+	  .hw_info  = "rtl8922au" },
+
 	/* 8852BT/8852BE-VT */
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0x87, 0xc, HCI_USB),
 	  .config_needed = false,
@@ -655,6 +666,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8852A, 20 },	/* 8852B */
 		{ RTL_ROM_LMP_8852A, 25 },	/* 8852C */
 		{ RTL_ROM_LMP_8851B, 36 },	/* 8851B */
+		{ RTL_ROM_LMP_8922A, 44 },	/* 8922A */
 		{ RTL_ROM_LMP_8852A, 47 },	/* 8852BT */
 	};
 
@@ -1255,6 +1267,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8852A:
 	case RTL_ROM_LMP_8703B:
 	case RTL_ROM_LMP_8851B:
+	case RTL_ROM_LMP_8922A:
 		err = btrtl_setup_rtl8723b(hdev, btrtl_dev);
 		break;
 	default:
@@ -1286,6 +1299,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852B:
 	case CHIP_ID_8852C:
 	case CHIP_ID_8851B:
+	case CHIP_ID_8922A:
 	case CHIP_ID_8852BT:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
@@ -1529,3 +1543,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852btu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8922au_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8922au_config.bin");
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index acdba5d77694..ce08b5992d0e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -564,6 +564,17 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8852BT/8852BE-VT Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x8520), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+
+	/* Realtek 8922AE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0x8922), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3617), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3616), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
-- 
2.34.1

