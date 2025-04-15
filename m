Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270B218FC92;
	Tue, 15 Apr 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684527; cv=none; b=LE6T5FilGFOkLyqxfN8LVL0dU0Xt+7DLm/O7EzC121jDFPKcFpzxxU6cJxMicBALxxy4Fy0GDpMA4VgrXELSM7EZZKgrjDcfOUvdAtX7yCqKzpwkxJx1D0fqtEHuuohO61MIecAXbmT6HppppHqaR5fjH0fI6kOmICdn0hFH6YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684527; c=relaxed/simple;
	bh=8xO8QHd7440KfceIwmOnULZ3bHZvcklj5KzN4oUY9VU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cUnXjkXwAr2k5GjT6drECfxFJYIJj5DA5dyliXGd8h9RHwhCXcRtr1m3kxwGhcrQg+zZWA114A98mq6p5fylETlg4hJYb5i2f0QwNKB+oQuBini3pB+eqKrY01+MXe6HCeFeeWn2UwP/y5v2EU1vMN1Hrebq8D+LxmuaaGO+Zsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CX26qXo7; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CX26qXo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744684448;
	bh=GDATfRuiPVKuN0P6EW0NvWKkf6BRv4AoJjjt3BMZBck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CX26qXo7q7iPMbd5ulV2OnDhnky9k9avy7oGrV+u67Jp32UylY5tKN208v/2IAR0Z
	 zcok480bDe7E/q4gHkrAA/uM7zMAWZX6OysDtPDFYn6uxgDlTAA/WpOlkAG6bySuty
	 KI9kqJIvg/CvpltgBqiZxwjdh2PYtp8KEZNXUExA=
X-QQ-mid: zesmtpip3t1744684436tb7f4f5c3
X-QQ-Originating-IP: 90JboaKXgdnM90l0at7Hujg6OLS3OwoT1QQqGCTHcIo=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Apr 2025 10:33:54 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 202749256733477988
EX-QQ-RecipientCnt: 11
From: WangYuli <wangyuli@uniontech.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lihao1@uniontech.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	garrett@system76.com,
	tcrawford@system76.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND PATCH] Bluetooth: btusb: Add RTL8851BE device 0x0bda:0xb850
Date: Tue, 15 Apr 2025 10:33:50 +0800
Message-ID: <CC9464EB852D10EC+20250415023350.16083-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OZsapEVPoiO6Lwj0hCcL2Hxvy10WcG2QAoOcnmM3bmzw6PvLQ879Edcn
	t2iS+9KOmyTk0LJRA0XgJ0bSMmrjlznwRowJMzTnsaLtzJOpARvCUbiXpq/uLd53yzwWnbl
	9mXeHJNEydVIUwdkT2ZuyGORhVSqlJBRr+Fyt/RmQStSlXWiN/FHPHEDra28TkceQcOPcZD
	Gy/pLJ6Z/dZMZHRi5mUBFCkXRtimp8rF2DhlUP6OouW+uOFMLNXKKIhKCcDIgApyhNC/N66
	sfObXxHQRJe3zmeW6RkOcMbLsoTlHyjfmg+907Gsv9jjIFz/WD4REnWxO2a2WeQ1MNq6d+0
	9cs6tah1fuCz7xLQmDHtfM2/QWkVzOY9f38k7mKPgACA6w7j8o7kPQJTV6TuKP9dQjGE1Yb
	5Wh+IQAM10VZDxMP83WeMbjXCpGVocoYyMvk6ZYPc4Xwu6dgjuzupJIhO3PCRiyk3nC0Dl0
	UvCbxgwNQXTBbDZpNJV4Pr4895Cx5ze5BfqAG8dsN9+3574jucACNkg/KL6p20K9xOVlBet
	zxqH4hRbApH8wUctnIJTw2OeyqRV2/x/N7WeLAPCkvoqDQtFbGQpc9nLgFLRktPvBwTiDpc
	ZoiK5Mt2B09Eku8AsfDk3Wmi8S9MDJ7wmaKSYZ3KrjXM0/m4vx680X5EmNEmy+TccpubRB5
	+FkY2v53E26p4bUoP5Mlp3yDLLgXK01jPfXfHN/7b7WjQGjFEq6SH2Zu4Qt3yk3DDDGtdZG
	EMwMwM/KJFaLGRs2yxmkU6DE/x7okwz7H7Fo7P1dcgOrDG4uwLz8oyaJoSYOG1tQ73Tl4zK
	jSCjSXXvRj2oX6B38V5FOHlFIex4kM5hxF0y5LYSXxgyFwnHlGh0BnMiG0YIyJuVJr7y1Us
	AidK7NI2I6pti+V1ge1pRwXyGGHeKwOqZeZwZhqrcMzp07o6cNQj1APJQrAqIgDrvUVbHSd
	CXLy5iwEmov5I856/N/bkZdfOOvNuNpvXLByjxCw6t8SUlb5w+JSiiKvAg7O9YrChypFCAg
	7/wFH2TUVjN24jS9/7JDIBpy3cwyhrBw4fBFAekJQTBWq1HyjY3FPAtGWHOdg=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
index 5012b5ff92c8..3dfcd71d6c01 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -513,6 +513,7 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8851BE Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
 
 	/* Realtek 8852AE Bluetooth devices */
-- 
2.49.0

