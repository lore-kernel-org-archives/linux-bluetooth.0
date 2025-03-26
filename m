Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2F1547C0;
	Wed, 26 Mar 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978547; cv=none; b=PEo20yDwTx1Y1xRsBOItR39h6ohncsFpb3jRWwHDM42HbLdItVzOEVmYNTL59Vs0Uflijp9yer5L73t1i0QhZTHK56nfYuovtEHwkaxQnXLsitzOdQqeHT4ucPPfDRlFkyP7Ac8/DUmNBywNH1xwUPmObWVJbaJWFXwBiWero+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978547; c=relaxed/simple;
	bh=My34K5TKuUnMrc1gVZKgmQLkVhJoBVbQZG2R52GRxSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xw4GBAg+6/O03Vd6gTBx6bgFQzh6jBeb/wsGnbeFXrAXYzCE26dCE/stGNXa8JzW/4Eby3IZh5ZjvX2FGRpatnK7DaI5DH/7AeYcy7RjWP1tDF0tQ81K805a/tBWzoR6MecOXVqZz2MvzeOAKNEdwvv57ZGp7amBzuANIXpjGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bC87zUeD; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bC87zUeD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742978513;
	bh=JtRy+QMeUiWjWHK0VCeWHxKW/SYd2pDjqLrvJqHva9s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bC87zUeDk5btGvGbTAL/rSeoBdkzz9iRcXW9yM6Hw/wWq9PbAXnvku8bOzdErr80L
	 v1RKThO7moKP1w+uxzb8UKpq8p7RuiXXJCqH9K5J68cLYffDaBQbwSqUt4LqIzaFkA
	 6oE1tl6HWJdqN7/EMqLTHZLtuaK4el8kR17q+qIk=
X-QQ-mid: bizesmtpip4t1742978501t2w2yga
X-QQ-Originating-IP: ShppA27fghodDXEBV+PsrNeueFJPD/tjZ0fOco6mXRQ=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Mar 2025 16:41:39 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5189072839362077449
EX-QQ-RecipientCnt: 9
From: WangYuli <wangyuli@uniontech.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Hao Li <lihao1@uniontech.com>
Subject: [PATCH] Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
Date: Wed, 26 Mar 2025 16:41:35 +0800
Message-ID: <933CB507F0C72912+20250326084135.18674-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N01He0LwNYkc0xWyT26piAoGbZ9yM0qU2WkAtR+i2CfXLKiorODxUJnZ
	KKWc4PvW9Mnq5wDCp/aDoEkIXwPB1URB3E8yfcAqjr5j6c0csWC04Cx5tZ1h+kUTxl77PGJ
	LYVAR5U6Y7Iz0v/HtsRrvYYkL2jYNAVngLYh/pzTShG5dxI0OFgeV3R1mFmQWMBiYrOHOnD
	Wg0HTUyGn2uLTUwCYBs/OYuRyE3mfw9ooGfepa9CbCBegMvo5xMYI3AseLUJsleZF+R9R94
	y+geGTzH8btTDDpjrWhArxbXEc5WWmxQnqnJQdHnWmXDQ4Gj5wCw4TaCRbd9eAxqabNPnqo
	B4dcwoFu0ratN/YkxiHffx1J8CyeDNxMA6+BDaPNPK4C/85TV1+2DiBiS+6eYRK7f6Y6Ila
	MAe4uW1vIXSSh3lTS5IHghG3sgppZ8OSTT40e1ZF8WOFaE8YcbZkhju8j3sYK4hDeJQY3mt
	Yhu9hyk2se0CbofiFHQCyJRZVXvXnmW3McFV0hPGbf1U2dFNNvld/penypb3jkZ1VDb36Ew
	oWfup6bI7fSR3NzpV9C+63lyy1QlYbgv3IPNV5qi2GpGnhvd3NPlpyS7RILpLM5LSOjRTCL
	w21RVN5AxLhHiH5lq0gZ8iTZ1XmOHIFwq9euPDmH/B8tV+sNri80I9R2DfFdac3ZrOo+kuh
	xeDWpQYcKo4mFfwrAcTr15CoG2lFKX8JLLMpFGdkpRCIAUcgBaI1FmfBenRLy+rZ7Ecbhgl
	TxMfbEFBfc47f7VUm90AXNDRjmuj6CFmrgQdtoVJjbF2Htorn7wHEa75GBYDRZF+T57o21C
	Um7GaWLnen5PM+9Yxyt1gXqXOGPjfaah6+CKmeDJNvnQN78El7QjjGCzk81+QE+TE0WFt8M
	jS56EN6kzlLEKipDtCAnGdkc7CmrJGV7fk738GMrk0W3+lS8lpvAgyYSNIWUT8fqx91d2yH
	VK0WQ4qujGdZx4Q4SbMamFluv8cUcujsUFhh2fZbTbgob4+1gaRHJh54dx2WDUvr17qjdpf
	ApD9baMjuxKQNDqW4a
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b850 Rev= 0.00
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
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Co-developed-by: Hao Li <lihao1@uniontech.com>
Signed-off-by: Hao Li <lihao1@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a0fc465458b2..8744496a9687 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -485,6 +485,7 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8851BE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 
 	/* Realtek 8852AE Bluetooth devices */
-- 
2.49.0

