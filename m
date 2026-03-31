Received: from mail.nercone.dev (x162-43-93-16.static.xvps.ne.jp [162.43.93.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6EE3FA5FD;
	Tue, 31 Mar 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.43.93.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979596; cv=none; b=srhFN/4ATioyRpHc/XiUq4SK2QDdrvB1+fDx9OcIHir+9fB38k1fKgYXQFb8d7bg6xg+gxydqzzk93ys0LtQji6dBi4/RY5VidKmZ2hgcu+UcKJsHb2rm3HiwgXtHwh6zklIH1YQWTlXG+zKBKxmLIdw7TcpY/hDO78djdBKnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979596; c=relaxed/simple;
	bh=g+dIHvY9Y3VdGO4+4x6tO6ZcIpx2q+mWPIs2XKS8M0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+9Xi4VIidGKSxchqgP9Q/blW47wFN97lrvyV849Y33BsviR2YUwwM61Eyfxih97qKtR+HHoD5dG3CM8wC5nZ+Wm09LvpLFWnVfYjUtJX3rt8tSeUqo6no8t590fw6OUz+4Df5GbdadIeSXd6CtwXcDJ0jyqjcSxmaZndR1HNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nercone.dev; spf=fail smtp.mailfrom=nercone.dev; dkim=pass (2048-bit key) header.d=nercone.dev header.i=@nercone.dev header.b=Wt0rK3t9; arc=none smtp.client-ip=162.43.93.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nercone.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nercone.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nercone.dev header.i=@nercone.dev header.b="Wt0rK3t9"
Authentication-Results: mail.nercone.dev;
	auth=pass (plain)
From: Kamiyama Chiaki <nercone@nercone.dev>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de,
	Kamiyama Chiaki <nercone@nercone.dev>
Subject: [PATCH v2] Bluetooth: btusb: MediaTek MT7922: Add VID 0489 & PID e11d
Date: Wed,  1 Apr 2026 02:53:01 +0900
Message-ID: <20260331175301.6946-1-nercone@nercone.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.nercone.dev (Haraka) with ESMTPSA id AC2B06AE-EAAC-4399-B127-B22EFAF8DF3B.1
	envelope-from <nercone@nercone.dev>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 01 Apr 2026 02:53:10 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nercone.dev;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260328969; t=1774979590;
 bh=vRXLOAP+2mRLMy0NyokLwXwoZYpFQjtDKvX4vvtjGKM=;
 b=Wt0rK3t9gOVA9yN4TP1hz8Y/ra97FyP/nWRiVP4jevuxFANe7Ke9yWw0G5MR5j8a6tmAxVE9y
 RXNQ++dXKs78vVAzVAQcJP9/2c6znUJwq5k5TfE4vuNIPPc7hvKhTGxlB8r1zrTetp31wANKtMD
 w+Crgi+jnigjGQArNKgeW6KQmA+2nDkmZmLnrysQsQKaLHs6Xfo9aDKYS3jYqrv+cKAtfGTuWW2
 +0W1rSqVA/2k+0MYuBHGcp4NejwPLFPZ8strUrNgGVUqcGFMD5fp2r95PHSRdj8njJjxWavmluL
 2smhD5C0EwXKzihoujK9u01zVUuBExX0AH+tj1PLJciw==

Add VID 0489 & PID e11d for MediaTek MT7922 USB Bluetooth chip.
Found in Dynabook GA/ZY (W6GAZY5RCL).

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e11d Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kamiyama Chiaki <nercone@nercone.dev>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5c535f3ab..dc7df146a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -697,6 +697,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe102), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe11d), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe152), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0489, 0xe153), .driver_info = BTUSB_MEDIATEK |
-- 
2.53.0

