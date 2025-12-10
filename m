Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DB2C0286;
	Wed, 10 Dec 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765370091; cv=none; b=MFU651UWOvYNuO1c0qZln1QC//HJsHO0Y2WWQW6GLKlQYIRTDgTWW/bo/W4sf/PlCccbh1AWOwUAMOjgNdNU8uRdRReELeKBRD3gSbryWPGz/xOg97BcnSppoQuYkaf3tyo49zalSGkY2lE0wULgFDnK+WOIqu5R4SVq/Wb2cLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765370091; c=relaxed/simple;
	bh=iZ3QXsipfQU8nr2auDgiYGWCSKyfG6vVHkpizkMB294=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGXV4QZX4ThlnBlhUTdwjePt7fqlsUCbIB0jnLkMngYD8ZXu/MvEyHAjYldgjiyqOR07wbg+oF196YXPafZ76FqC9kXMrWYZqHCWwjffwxvcMZ+3EE3e+6kTBA7mknSKdqIkeRrdW8O6EP4a/jriH3Nh6Ox7BAfv5WBcFwTjhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QpP+7jlb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QpP+7jlb"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BACYWtqC003714, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765370072; bh=BoZyWzq4soZA+/jFP58Mq21TX4f4zlfINEq6XdqJyII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QpP+7jlbDzKmzCGnhQ2dXGc92ObO6A+XhNAmzbt+P4yvXX47pCr2FDykGYW2Ho7K7
	 kM37tcYmm9GUk0VWdD0Uu+NRTMNSzL17PmnV71Fog3u/a/+ROqBhQKR5qyMlYCpOTR
	 Ro9Z3NS8UIQv/XkuCqfGfC+iuOHu4L+cuLt/4TwRxZXxNhCJdHxhI+XUuwArt86EKm
	 xpRqHbUYb3JYx3J09rZr5ZYnVGit5GXHv/jOoBaq6BThbGYUAYtBkY9VVOAkKLuoHs
	 sVynlReuyVHXMTR83PBac0vGKSGKNGSb24SxMQJHkMYQFU4A3eiGfGs1JtMrdOjN3c
	 7/pMOaFwIpRLg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BACYWtqC003714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:34:32 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 10 Dec 2025 20:34:32 +0800
Received: from localhost.localhost (172.24.54.48) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1544.27 via Frontend Transport; Wed, 10 Dec 2025 20:34:32 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <jason_mao@realsil.com.cn>, <zoey_zhou@realsil.com.cn>,
        <max.chou@realtek.com>
Subject: [PATCH v5 2/3] Bluetooth: btrtl: Add the support for RTL8922D
Date: Wed, 10 Dec 2025 20:34:06 +0800
Message-ID: <20251210123407.3971233-2-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210123407.3971233-1-hildawu@realtek.com>
References: <20251210123407.3971233-1-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the support for RTL8922D BT controller on USB interface.
The necessary firmware will be submitted to linux-firmware project.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=01 Lev=01 Prnt=01 Port=07 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=892d Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=Bluetoo
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

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Zoey Zhou <zoey_zhou@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
 drivers/bluetooth/btrtl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c90aa4ff5918..313005f37e33 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -90,6 +90,7 @@ enum btrtl_chip_id {
 	CHIP_ID_8922A = 44,
 	CHIP_ID_8852BT = 47,
 	CHIP_ID_8761C = 51,
+	CHIP_ID_8922D = 55,
 };
 
 struct id_table {
@@ -357,6 +358,15 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8852btu_fw",
 	  .cfg_name = "rtl_bt/rtl8852btu_config",
 	  .hw_info  = "rtl8852btu" },
+
+	/* 8922DU */
+	{ IC_INFO(RTL_ROM_LMP_8922A, 0xd, 0xe, HCI_USB),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8922du_fw",
+	  .cfg_name = "rtl_bt/rtl8922du_config",
+	  .hw_info  = "rtl8922du" },
 	};
 
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
@@ -1952,6 +1962,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8922A:
 	case CHIP_ID_8852BT:
 	case CHIP_ID_8761C:
+	case CHIP_ID_8922D:
 		hci_set_quirk(hdev, HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED);
 
 		/* RTL8852C needs to transmit mSBC data continuously without
@@ -2229,3 +2240,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8922au_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8922au_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8922du_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8922du_config.bin");
-- 
2.34.1

