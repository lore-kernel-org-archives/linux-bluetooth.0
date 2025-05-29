Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBA20C47C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537010; cv=none; b=fR5Xx346bMuFxNetTdew6B1g7lEYPsadPujgEdq5lMI6M3mh5dUYNCo4gHoc/N+AXp4PFcBSivra4jtT3CQUY1QRzN7Uf5yfV5/Jr1UJXb5QNjIE4Wsaud0CCnzqXgpNs/Hh94/3uN6y1y2H7f5NhdVQatOuMyMUqZL8hHx6teU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537010; c=relaxed/simple;
	bh=cy8WXGn9kGrq+S0ZO+yrsLcycHnE5Osegmr4Cn/S6C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=inXuo1tFmtl/OI5Hgw5FlWPsTEzSDzo/DMhPeXa2pmYaoPp0o0w1z4HYhap4Pe+lpD3X/vlS8JQo9GWMNXS8bTshaYpeS/M2oUtPlzIi8z7I+UHEcnaYcLZMCsvfN65nVk3DtR/gf4I+3FFUiP0FtQE9+QLecxz4hH9TIs8W1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=e0ZvteSh; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="e0ZvteSh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=YmNR/X9c2dwORjvmIi0s30BqMlixo33q+IhZCSM5XLY=; b=e0
	ZvteShlMJGqPLRYRxcqci45UgYmVpKvGo9O02xhw0wZtHi1W7MWdYmY+NG+CQTQQjQUxYBXzdpS2q
	HfUtkexAcWVe4TqJ6UWWlwUO+hXB3NmXg265OPiCXUezbkq5J9SMVqk8NnTj3Dk5y3FborKpexwIS
	W7/wA6q/AzB7Q+zQ+SioD7zYWkiBQ78S8zKF1tT2/88Hizdm9P7iYsof1bQwNFpUEMA7ViweE6JiX
	qrLLpNXsu5Hl03M9XdJ0bYHscU/ImGgrMcgvK+pgNOOCD/H8OQAqmVIB1Qodd94gGR9Ik7zz21GGZ
	VO5J/arXEopXxtwZGxgTS3ykF79MycYA==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1uKg2j-006IKw-Og; Thu, 29 May 2025 16:23:45 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	1106386@bugs.debian.org,
	shdeb <shdeb3000000@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for variant of RTL8851BE (USB ID 13d3:3601)
Date: Thu, 29 May 2025 18:23:32 +0200
Message-ID: <20250529162333.462753-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2673; i=ukleinek@debian.org; h=from:subject; bh=cy8WXGn9kGrq+S0ZO+yrsLcycHnE5Osegmr4Cn/S6C0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoOIoFePv/cfRkVtAWM6G0HBBGUxeCBHyHcoNDJ tPxbxNMdcGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaDiKBQAKCRCPgPtYfRL+ TrwwB/9XKk4sA8+ld0bSvRvELM12fj8pcEtGBL8I9qi9ts1sPKOTBmFm+Kj95ZSXkXNyD/k9INr 73gD4kbh+SiHcVpT+dtbsIHWTezJI0583hJfzS1iZkBTZJGSMiKNVBmn+uiVxEcbilm+FNUHB3l 25wA3yTE28+Z1uVhLt7Cr8LvWyALqRAOYeb/YTs+2fw1nz0OB+sAJJPzMdemOD6drx9lkiE06Pb 8huiQBMjtKZVQVGW7Nih0MzbBbRer1dqMcMEhtp9Hngy2EhtrUWFb+19PCi9nk1KxLmhN3hAb/j xTAmbsbfD98a7d9ds8u7fEnfXrJmGfbAzVTLHcsK7I88NNkS
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Teach the btusb driver to recognize another variant of the RTL8851BE
bluetooth radio.

/sys/kernel/debug/usb/devices reports for that device:

	T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
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

Reported-by: shdeb <shdeb3000000@gmail.com>
Link: https://bugs.debian.org/1106386
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3016ee9f2932..39536d4b3d5a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -515,6 +515,7 @@ static const struct usb_device_id quirks_table[] = {
 	/* Realtek 8851BE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb850), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3600), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x13d3, 0x3601), .driver_info = BTUSB_REALTEK },
 
 	/* Realtek 8851BU Bluetooth devices */
 	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |

base-commit: 2a628f951ed54c30a232230b5b58349d2a8dbb11
-- 
2.47.2

