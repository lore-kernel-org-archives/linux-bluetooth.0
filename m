Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163213;
	b=JUmQliXcQbOuLWMFul/N+kcM1g0tFjniJ4J9rx0og4ZZ21PH1gmuG+JSKp8V5EX5YR2h
	 yWl0sx/fAdSL3IbEKgItH4stObmbwvTObSRYDWWQrgYQZuGJTsO/EwR9QcR7jRy8av/Ve
	 xhFkSw6JIzqpGobh4Nv12SbLXsoCnrvlQh+4iKfiiG8QGIGsZxgR5xSXd+6l+ZIKeRaBh
	 WyRa48A3Des/gvzv0nM5CfpJggUii2yKrCVUOqGxEBbtMQ3tiqctnJBJLzrio4PPtz39c
	 Q9VZSrnPP90ZMKYocHd3GWJnm0cmyWev159evgxmzG7uiU4GTfm+djYHbgTe4ipXvJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163213;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=1AxEsgABuTAFyHdRM7QVZWkIBRVYkwvUasb6delBUBI=;
	b=JUaWDh0LrH3sg9c0OIq7uIhSI1E4pyXxYqT+g7DkdOqDtdb63YpeMq5gLGM1t7CvGGYN
	 QjOwlIUhd2OKLpjvsiw1AA9pO1NBblX40tcVmx0oXlCM8UTW2FMtZfoSVPy34NgVaGKUh
	 J04t6YpT/L7ZpbDsS0t7ezikejkPs7AfnmWTCX2WgbXlUkKRDpeeaS8naHXAt6jUmIf+L
	 GIKRZLshadW6A5ndFIbop+77ODCoVAt8rrOnl2PirhGdNU8EcIs1ljsLv7J08l+jVv/ph
	 Q8MzEYgsrS7LbTYLdkcN9Ysy6JwLVlAGLywMs0RUO0HSh/b/VcvsA9anWAySFqckgOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=ZwX3IWjG;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A8606A33A;
	Fri, 20 Nov 2026 08:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A72A8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=ZwX3IWjG
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AK8QbbiE3249388, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1795163197; bh=1AxEsgABuTAFyHdRM7QVZWkIBRVYkwvUasb6delBUBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZwX3IWjGErCwZsU8r/eLwaI38dQ5jr4W3DhII1kabxeoPHcoFnkEib0gPfopthQkG
	 lMvlLGxAa7TromJq1kacHfQW+DWw3uU5TEinrL0LLrhiSIyEqSseMvs5Vfy8KchCeQ
	 QVNSHXy8d4oXIMvgkQnRbxucf2tsR69F7RBKHMh0GiKz2xPb0hmWmi6sh0mEK9QwGP
	 uYOfQkU+Aykim/HfS3KW+TLfs7DjqbiV00F5q0QwA1sGRtwHWrcXITVyiqWqnHkK0/
	 LSVNuuVlDauckpKAaqtCZV46YZbmsLrYKKBdT18x+e/AHIn7NvxoWi8LVot/a7zs0R
	 /ncBQmBB10qcQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AK8QbbiE3249388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Nov 2026 16:26:37 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 16:26:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 16:26:36 +0800
Received: from localhost.localhost (172.24.54.48) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 16:26:36 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
	<jason_mao@realsil.com.cn>, <zoey_zhou@realsil.com.cn>,
	<max.chou@realtek.com>, <kidman@realtek.com>, <arunr@valvesoftware.com>
Subject: [PATCH v10 2/2] Bluetooth: btrtl: Add the support for RTL8922D
Date: Fri, 20 Nov 2026 16:26:36 +0800
Message-ID: <20261120082636.3834168-3-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120082636.3834168-1-hildawu@realtek.com>
References: <20261120082636.3834168-1-hildawu@realtek.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the support for RTL8922D BT controller on USB interface.
The necessary firmware will be submitted to linux-firmware project.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=a82d Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=802.11be WLAN NIC
S:  SerialNumber=00e04c000001
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
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
I:* If#= 2 Alt= 0 #EPs= 9 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=8d(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=0e(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Zoey Zhou <zoey_zhou@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
 drivers/bluetooth/btrtl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 49a13049fc50..6f46336bca5f 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -73,6 +73,7 @@ enum btrtl_chip_id {
 	CHIP_ID_8922A = 44,
 	CHIP_ID_8852BT = 47,
 	CHIP_ID_8761C = 51,
+	CHIP_ID_8922D = 55,
 };
 
 static const struct id_table ic_id_table[] = {
@@ -310,6 +311,15 @@ static const struct id_table ic_id_table[] = {
 	  .cfg_name = "rtl_bt/rtl8852btu_config",
 	  .hw_info  = "rtl8852btu" },
 
+	/* 8922DU  */
+	{ IC_INFO(RTL_ROM_LMP_8922A, 0xd, 0xe, HCI_USB),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8922du_fw",
+	  .cfg_name = "rtl_bt/rtl8922du_config",
+	  .hw_info  = "rtl8922du" },
+
 	};
 
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
@@ -1366,6 +1376,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8922A:
 	case CHIP_ID_8852BT:
 	case CHIP_ID_8761C:
+	case CHIP_ID_8922D:
 		hci_set_quirk(hdev, HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED);
 
 		/* RTL8852C needs to transmit mSBC data continuously without
@@ -1643,3 +1654,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw_v2.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8922au_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8922au_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8922du_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8922du_config.bin");
-- 
2.34.1

