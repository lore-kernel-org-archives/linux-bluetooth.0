Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893043CF6A;
	Sun, 29 Sep 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727596246; cv=none; b=sw71B9YIxB1snDLaF0oLtxjhsDVd77MdjHrpiUjFFMdiNiniviZ2s3QnyG90lSUYYG5TKPic3vPu3OCb8cZbJlMjo/bHyK5gRsqAFgZKnLyqVbCTHKEkCNSkqgVkLyJcBpQQo5QetYc7NCJwjss4J2jdpjWZUp8syVkmMc3vUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727596246; c=relaxed/simple;
	bh=JFaT0LYZbAmveZeB0SFySL/06wDYX5gBwrzQ14Dn2kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kuV5DImtbTsjj9TCXo2x5i3B0WLGTfXPJrCxVR95ORyW998691nK70QvnDoxhKcUYBu1u8aFIFTlrwREUjY7+RDfncfmCtgQdY6oY1VzQ/HXWtG6NIpOmoTXdv3UpaUCN14dT90Le54P6wOtCQpFfa7QHVpSW4lXXBcMAjCiuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=qTDaYWoA; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="qTDaYWoA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727596174;
	bh=rZHvVfowzI3daZqCxdNalDtcmaBy5OTc9UKJrJPe1mo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qTDaYWoATemcKVDnckNEezSgbHZlzHITJ/521n1qA7Xx4Sn5sSstYnxTo1t0/Tsc6
	 dezcx43VI4/ysLxToxpz7ePPNEKR4unxKjmQruA2PprG9f6jp3B1/rWP59oLRO9cU0
	 J5s+MspWS+gjtxo1fco/0nAtQGuPfQ90jQFFqb/A=
X-QQ-mid: bizesmtpsz9t1727596141tnyjnvd
X-QQ-Originating-IP: BUqR0Ifox5Ufw0S6i1dJLNx2AJS6rHQ08KlTnfvB5Ng=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 29 Sep 2024 15:48:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8712247480049243626
From: WangYuli <wangyuli@uniontech.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	matthias.bgg@gmail.com,
	hello@felixjara.me,
	wangyuli@uniontech.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	aaron.ma@canonical.com
Subject: [RESEND. PATCH v2] Bluetooth: btusb: Add MT7925 support for ID 0x13d3:0x3608
Date: Sun, 29 Sep 2024 15:48:52 +0800
Message-ID: <34A24B6870318797+20240929074852.977045-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: ND3CPZxVFFQcrZMmRvrULT/WYia1CRGTfCmc3ZWv/Q9o3QzC/s/5vXqN
	l8cX5D7xnnmx/VPULv/a+86JK6F5mP79DD37dGaq6mnRBeeB8L5ckGDK0RF8tMUHEkuF6se
	deZHxg9NLK1zauNT3uuQxvi9fZQ9DvTIgDaW8fdgQeq17aX/dlqTFxoS3gFRga4Kpe7Y76t
	IxWUoxVJf1RxqMjD8Wt7Md5iwAe6jH+hgEvpfqfvLKkFqF8to1R12LGGW2ENDuQWayLZBtS
	Ow2+gZCNQhloKd0+geBnuvrJ/LtB4JezAWe7FyRzWV+CnVlfuY+6euHqhfMTSF0TNBjrN9l
	ETTcnaUaLjj+MfVeDLNW3gWTVS8eheFZQpqU9z3Xu04hpuDH0JFhvZlToQWUUy2f4tcvrSX
	Cwxw6bV/wgvrLXP0FVbwaMhmz0dGU2vkNZWDxf6o8m8GD59Z8tYFei3xvQksg/Kn8OUlBzV
	XdnJtBLs82XBUtzUyGPICtlS5gp0t9G3LONfbUz+ROMvpsligT0vFOQyNJJDERO9PLBFB7G
	ifWd7jrWq4zii3xSNuSqyYgvZz+o/2p/Yw8kxNezXLu4AgNVbrN5iUfCLzIud7r0c516fiw
	L4BUY2zb28DJ4OZCrOT/Qz8IONrdUfWQ30Dpwn5IB9B7ow6+ZRBBZF8enzQhWY4EbG8185O
	CP+UOrmlwvOsXqm44U3KerQfIDfqFNpjUJ0u3+iywN4YZbRqxH6JjuofhSNz0T5r+wyrMGv
	zQAaexwdS/VYIiPEoBu3Cwx7YiEkwWlA38gbvRdyDVIh+r471FqAMymO5p/99cIch7f0t90
	OLI1J3EKOHeqHkbiCYzVndb8+q0qHUTSWAqMLUWH84RY94IKtX0QJc1eQYMCrWFp2/RQKJ6
	T4DPrJQcQtXJjzo+97VYOg8oOSuHP1ViqtZaWcD2pmrp+kWSi7n5ty6X92p8cH7exJ05S6r
	K8ccB9QP5hGHts9qPZv4QVgVNHTFCvMSyDyUcK0m0mDu9JA+ISlJyHWIZGU0zzF2jXium0L
	zfNbZJEQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

From: Félix Jara <hello@felixjara.me>

Add compatibility Bluetooth device MT7925 for Asus UM5606 with
ID 13d3:3608.

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3608 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
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
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Tested in Asus Zenbook S 16 UM5606XA

Co-developed-by: Félix Jara <hello@felixjara.me>
Signed-off-by: Félix Jara <hello@felixjara.me>
Tested-by: Félix Jara <hello@felixjara.me>
Link: https://github.com/openSUSE/kernel/pull/10
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cd22b34542d5..4adae0be8222 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -512,6 +512,11 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
 
+	/* MediaTek MT7925 Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3608), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },
-- 
2.45.2

