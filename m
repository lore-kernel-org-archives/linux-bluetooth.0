Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9E26E14C;
	Thu, 10 Jul 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134797; cv=none; b=fdvN/VUA3Mvx221uynEn8X3QZhAkfeHt2sCOWcDjlGAoMqPQTW7AF6Gy5JgbpehIatZ3DiObfFRkh2lgIDjDfR7js6JZdF4rVZAgoh7VgCH50QRBMLnaiMV/XN+P68wS9tLmYjfNss/g1taOqVhV/R5AZRtP4kb64CLWu7n5Ndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134797; c=relaxed/simple;
	bh=g97DMZDtpJ1kJvGWRlR7B3Sn1He/PQJNQ8m/ysttO/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ud0Zl+mX5vE1wXa+JlybsLx0z8grhsTmn1AYtI1Igi62/1L0e1JhT5A1fg1y45X0I8lSJ9CxJGd8614ThrX36snXVQC2JTawGxWavql/8PYlb1Bg3/UDOvWmdK44gRquqx3utzFC0SNfGOaRdF2G7jfEL/H71tGDis9vtlzcfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RfRgkunB; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RfRgkunB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752134766;
	bh=9pBXcmkS5dqa/3ho22UiSkwn1wSVVM4LYCclRvyOeio=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RfRgkunBEXkLn5qBVgL7STbdUYzbEpwWtEocqsdbtFLHgRjleVd6F2ooPulImH4K3
	 e+hn1mST27Olbfw8qffAkvzSkOGesaEf3DVKpBfs4ie1/y0yrCLiqMHXz7C1Gxej21
	 7IIA+YPl88VI6DOBDFtuTvoeS8K5n69IKpQfssmU=
X-QQ-mid: zesmtpip2t1752134754t8a6fc4e8
X-QQ-Originating-IP: XrbToqNref8QtDRBTbC3FB7/yHn/WZi2aJS2+w31baM=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 16:05:52 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16189720168025562383
EX-QQ-RecipientCnt: 9
From: WangYuli <wangyuli@uniontech.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	Hao Li <lihao1@uniontech.com>,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] Bluetooth: btusb: Add RTL8852BE device 0x13d3:0x3618
Date: Thu, 10 Jul 2025 16:05:48 +0800
Message-ID: <43D87E237D082F39+20250710080548.180268-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: NKHXOVLrVQ/Nwpj8NoO9hyBitrKmAcvWpq24LCd95gjz/wpswKcZGq1w
	boN6ewQYmQR6JNr0bWMjnUGJqUxCJLwAlIaffGNm3BSiCr5ZGlR8t2OLhSCUNzaG7tXuh05
	8tlJ5zfwYT8HCmMP2reJ5jMlJ1rtmfZDWlyQJ6CFHwIw0Q4I9k/yQnkefCeD9JtKNVnuONK
	9SCq9z5xxzROdZYmAPF0Z+uXa8s/rBsgL4/7iWpExponIrK676b2ugIZdSlFaGPLNUqPvvb
	R+Rl2NnK5ZsTWoMkJPEbzhre3vk0DGpdV/y6opSzl8Zzqk0xwNiREjDpgMBZ0P/8+0XUtJx
	CzgYmxHS2s2paRMAdNlhkenBycOE7tfY+tfzJ2EumAoWAv9zxtnHZosr+Yd0W2RRG6ONtr2
	hBKHk+okMKQl1MgTSvy/O2ksDk6U92e4l5yLf4bpoWlNbZChRepcKG7eCDjHbkjh9ln/oZd
	mzjEGrztD06VV0vlHuLYGY07F1btU1ApRHSo+BW3b0lalBq7K6+8aTJJEWxBnAuMMPJWy/j
	nECU7e6zxWTQFbKIwevBpq5rV4VDuMymjQjMDT6pW8iy+Rme8Hgkz2JzGH7EsX6499hsQ6E
	loNwWcoNYZKx75MNAuSRDRThcj0TkuopFnyai6J3nUZD2MfUBpCaNl63jqT3OiSDy6GmI/L
	S3pRusR/24nTZbOZ3ubcXoa2QqL3+PIU9LAo1xa6WXRzjouf7uBtDRX2E1LMilf0P0UYE1k
	iv4CruQrmgwYXyvOI/L7CDQj7VmEvb48/jiLdeAMIhxziFJFXk8Om/xh+7JFctRDMsYASsK
	qMpYt/jEZ3OIw1aYtF0FGp7hfHr5gQascgdNZ/9tZ+Gvx2YunuPlax0I3flzOzWk15+XnV+
	O4p40x7IR1yACLt3AcBwYzKfGmCX7TNjOtPMd6Qc4BFl1YsFDXShilZfG8Wozzw5r/9KRnN
	EiZ5N6a+oTmYJAkSyE7jsnkRc5c6CzWqR3W6zz/UdqNC+/2gD6nnBd/nzbh6QhPif3G71ZY
	PGeChMkyTQw6L3jrQCi/X9SCLd9hN1XPNJjvkkFMcQQjevdOHAX+qmUCqr9PUq2y+wWFHVa
	ciXH3XSc1XL9kmr2eRq0YwpMfB+ks495lUehMxxVdwh6IhwONsmw9LqtbN5WEH6B7zoVkYN
	DVq2
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

From: Hao Li <lihao1@uniontech.com>

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=13d3 ProdID=3618 Rev= 0.00
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

Signed-off-by: Hao Li <lihao1@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index aa7ade6a1866..1ec559fde9e7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -566,6 +566,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3618), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe123), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
-- 
2.50.0

