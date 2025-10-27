Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F202E54B3;
	Mon, 27 Oct 2025 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552641; cv=none; b=cssTYoRtE5LwB+4UYjePaKDe46SlCT5JofrmzPeu/zV2aiR50GAd34silWcy2k5vWmt0Hxd75kOIj65WRzOzSliRWKYeqruVb8GuS8HO5XzwyMdHl8q/kGCo0+AraJwJCRCQz4SX2XR4v4Ww+8fVUmdW5QN7rOd6dWiSra175Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552641; c=relaxed/simple;
	bh=A/FHwxJSA7obBoDVFib3NuWDqj1wszSeQK+0ZKb4DtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kY3PV+f0bK/AOGV4tkBGnzBol1zZFH4ORDocEKvLg/bhVi8h9/spurET3OD49Su0k/GtD7v2ENfq3fFjC69nNAAiek+dlQrtfCXsWIgSExRfGaJ4NwifgTf4KmVnUKKiNS1BzNehR0FahW9ekXzcSN3Z+Axea7ArgesuDGAEV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FMHvvs/A; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FMHvvs/A"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59R8AQ9R0364012, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761552626; bh=f5bHsZ8xufRsURvv3zBK6RvKRsMoHbynFtzzCOloXLs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=FMHvvs/AHskv7hOJt80Cq363s4+RRh27+JB+p99PcU5m1L+vQRQxxslEGBk54s3T+
	 7Vvv0xIOHBGCDm9mjpMIdjNj40Tmb5QoG9Fr9KzmORAS/3xDZqBj49E5yym1XQm6yj
	 ttsZ9ZItMn0rYzJ2SLzUKSkkC/MSDtoZmwYhSXo8Lpnw0D7DmfLxNyPHVQTqnHJBbD
	 dlUKg16a1a0E+m9/cMzkdgyQyLvvXm3Wn5YnEqVxokXRMl+qiSxzvlSsawmQ0dkWJ1
	 hcIn7HeP/18zjEmRlqjItWcfp23EwC6lmXCJ3jaklYXz5nRKSBBT1MYzP9LwupmR+S
	 fuCzlaQUTMRuQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59R8AQ9R0364012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 16:10:26 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 27 Oct 2025 16:10:26 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 27 Oct 2025 16:10:25 +0800
Received: from localhost.localhost (172.24.54.48) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1544.27 via Frontend Transport; Mon, 27 Oct 2025 16:10:25 +0800
From: Max Chou <max.chou@realtek.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hilda Wu <hildawu@realtek.com>, alex_lu <alex_lu@realsil.com.cn>,
        <niall_ni@realsil.com.cn>, <zhu_qing@realsil.com.cn>,
        Chih-Hsiang Wang
	<wangchihhs@realtek.com>, <brenda.li@ublnx.com>,
        Max Chou
	<max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btrtl: Add the support for RTL8761CUV
Date: Mon, 27 Oct 2025 16:10:44 +0800
Message-ID: <20251027081044.11158-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the support for RTL8761CUV BT controller on USB interface.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 13 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=c761 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Controller
S:  SerialNumber=10000
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
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

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btrtl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 6abd962502e3..329554f23542 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -72,6 +72,7 @@ enum btrtl_chip_id {
 	CHIP_ID_8851B = 36,
 	CHIP_ID_8922A = 44,
 	CHIP_ID_8852BT = 47,
+	CHIP_ID_8761C = 51,
 };
 
 struct id_table {
@@ -230,6 +231,14 @@ static const struct id_table ic_id_table[] = {
 	  .cfg_name = "rtl_bt/rtl8761bu_config",
 	  .hw_info  = "rtl8761bu" },
 
+	/* 8761CU */
+	{ IC_INFO(RTL_ROM_LMP_8761A, 0x0e, 0xc, HCI_USB),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8761cu_fw",
+	  .cfg_name = "rtl_bt/rtl8761cu_config",
+	  .hw_info  = "rtl8761cu" },
+
 	/* 8822C with UART interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
 	  .config_needed = true,
@@ -668,6 +677,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8851B, 36 },	/* 8851B */
 		{ RTL_ROM_LMP_8922A, 44 },	/* 8922A */
 		{ RTL_ROM_LMP_8852A, 47 },	/* 8852BT */
+		{ RTL_ROM_LMP_8761A, 51 },	/* 8761C */
 	};
 
 	if (btrtl_dev->fw_len <= 8)
@@ -1301,6 +1311,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8851B:
 	case CHIP_ID_8922A:
 	case CHIP_ID_8852BT:
+	case CHIP_ID_8761C:
 		hci_set_quirk(hdev, HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED);
 
 		/* RTL8852C needs to transmit mSBC data continuously without
@@ -1520,6 +1531,8 @@ MODULE_FIRMWARE("rtl_bt/rtl8761b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761bu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761cu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761cu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821c_fw.bin");
-- 
2.43.0

