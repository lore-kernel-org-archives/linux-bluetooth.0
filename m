Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCE234963;
	Thu, 10 Jul 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134498; cv=none; b=bIEdKcb8TP+5NzRNoRKtQjEy/z2cvi/XCQ3hF5PnPO+oF87RcnTfKCrlsCfVsh/iDb1fEgbClKD55/zrOYLJ2BWdni6mU+1mzx07WwlXGYhzg2b9x61T1cvpIRfs/lSeQHE6j/rW61oJkt8M6xbJQfP0PHvNzDO8tBy5A1eaxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134498; c=relaxed/simple;
	bh=DRXqcTGpVxb73VPyz4tMHlw6YPMLyxqlM+wBlmGLGLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtOaXcoWVUCyLFLJTlFCLwZkmctoARsBtvo2uZO5AqSgTXf8xWI+SmC51L3PMpavJhB65w1ZUrTdunef+xsOClgMRl27WjJZLwFiOUrPFjuXQjPMhv8RTUUAO9qt0PoDKUGu7bdFCWwOKJhF2JLdn9PRWbkOIoBRB6otLNpkuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CikTtMdx; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CikTtMdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752134448;
	bh=6lKlIi5ajAbS9uOFEmqwayvdHQUIcQAf/tUMGqLl7Hg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CikTtMdxIppDqbxA03RcR/6sDOO3PwTSv3X/Aze88mbnHIEimuzL79R4L+IY7KCuU
	 xziFaVENe5Q/9UIwvg/eg7AqQzzAoq4nxkv/vQKAGcNcLSO4XUXpSKkM3HTlRz5Vmd
	 3DOJuNoieRNwbTSOh4jmYGqcuU6bs7IAk+kMjZLA=
X-QQ-mid: zesmtpip3t1752134435ta4efbe0e
X-QQ-Originating-IP: oH408aLbArq/IBbIuc8rHcUhm8RTX0w0pHU25K5nhuc=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 16:00:33 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6375983909695600124
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
Subject: [PATCH] Bluetooth: btusb: Add RTL8851BE device 0x13d3:0x3601
Date: Thu, 10 Jul 2025 16:00:28 +0800
Message-ID: <5D4383E66D4177F3+20250710080028.177664-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4lPCacZ9YleRM+4rCi0M/hltC8h5TJkLO938qEo/u6FvgkAOpIDsLGr
	cdgheiiiznNUfk9U92WkEngKYyND2P2swkmJNoxsE0r/1zkHZ5BeK7iDglhS+IhIRmhIC/9
	LuhO3qjfa2vB01wlM39J+AigMfOClU44rwyOHYidCVoenb7KjMtcvhlFFWg/SgNp4hNoJDZ
	byvwK8xbctJ/fO2LiVR3cCagQd3qMq0JpwF+BC11oM8BlTdFGRXap0fM4Y/g/5fFo2gJICH
	fDdxBJQiMRHHBPeN6ysWcGcMQI1QxBgtN5JekMTluTew6QlK4R0cFKSLaRJr+WaY1rPue3r
	gStddsB2Vh4KUpzQ/YTAheyK1MvDEmOVIFtX6AEizM91U8euWpTc68yyd2Nea9fByPzptW9
	uwceM9bSOL9swWQpKaG1JK8+sXRAsiMqCc7+Fc2QYE29215DJzN6h0c02GDc5+1hpsE8sQD
	/Uk6LjxFfkd1QiHsn49rrWoUv32pzI3YWUog70czXtaI+FwyDgfVUoI9UXhwOlpMVAReQqC
	qIMqsjaZ6SavJoE3ptzBl4eqgBwkxcU43v7XNVkSyaSDxZQ2dwzFMq+aRs/ME4KcGW9ZlBR
	F4Et7qSs3YnZlr/pST/JBO9umGDEGmr0RWHJI9SfSycV6BLL+zeJDg6MDTktyF5OaHtZB4/
	eu+eOkCpaIHF2n2E5hnmwuvwKhLjPHt7qTt4dkdzrD8ctzNMGlkGF2SErB0StZFswQNRWTK
	HjBCqLJiIXhbxvSE+RCvU9P+2Q1ijtgJSOjaNgAHJNYz2gd2HnISMBEyPKjIM3Uahv2c3Or
	EGUB6U6x5OcTyWwUi330Nqvzyt/J88XboiiokggTRPIj84JT55tCGKsZZzcqUJC+1pVRfDe
	DTfuR4vzTQopKGh/bJk3UeN4GpK3BupKxaOyoUaXtK8Ouc8fhnjBZ38tCwYP0J0wfhLEReZ
	MKz5lEJFr5XbBIng0Okxuw6nIEqut2KoLTaCuJ3JxuSMmv86r82ba96Rcz7IbAI3dh80kWc
	vohP+jvnEKKDneUWb4ATlp8VJshD2198Dgp+KIi/4l8zEwK6rjKf0b4q9aXoz9vmU2gF+dl
	f7DU/MYW3ic
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3601 Rev= 0.00
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
index 9ab661d2d1e6..aa7ade6a1866 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -515,6 +515,7 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8851BE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
-- 
2.50.0

