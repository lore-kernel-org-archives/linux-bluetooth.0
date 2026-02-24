Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51DA27587D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771913671; cv=none; b=RfBkCMhamoQfFYWJp777/e7lpqeo7REaQrpPrq9+4beYWyAGaPjFOH04qpy1YzJBZhOgKnr8w6t7fG+82gLFbfu5iZ50yqqC26VCTpDNJu+trJTM0wcB3s501lsP8FSY3azoBYLLazkq/66gFVC//ozuisTtkEybnLctnXT8jFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771913671; c=relaxed/simple;
	bh=z1IJOeSzMZAL1/xcLy8dG/0cKMLlMODvFu/RhDvuw/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T09xLSlXyQ6c8iB4xd0C93QMQ3l+9YHYeJh2eaoBic9BueptUr9w8HotRlR0PJhAZ43a+8xv/TmvSHOgtCIxxRvAKj5QfyJUL7COdnbtle9bptbaoSSvpBPIm2zZXBARgBcE5NNBzGNoYSorFXq8iqgJfCsDlQHoAi0++aeTOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-67997ce9e1cso3028146eaf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771913670; x=1772518470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iff0nX3eVlq1aXN5uKCYb/BBxBzq+NNIR/1dGHBeD1Q=;
        b=c5LIO6wyPGznTmpw3BqDipLIALA4PM1ByoKfdahJxqy48GUsYa3QZr5TSiIDB1fUGf
         G1oDtfG3IH83vz6ynmjs45kpITdColFjyFlb6jKHfySOw8yRt/m3WGauuPMJHHr7p7/D
         8XQiBLrAlnPFUhYm3yaJ6/h6QG4CBS7Slh/U3e1yPc68FBkiKQ/RFUdmcq3j2WDJvPOD
         B0XfbVvU+d73kc+B2Q7l5AbbS6jCH3T0Cua7Wmws04ikAhSSv41ph/9XybCVWxQpdfIA
         DwA5NyBsJInXXvryD1RawSeEdE9g+UIqqgHPgrD1Q5cLdULxFbAD4BlcY9bl1d35M0ua
         XX2Q==
X-Gm-Message-State: AOJu0Ywe1wXQSJsLD2KRQV0Vd1+csA6ymJt8coLvcp4ps21sdpWYMhgO
	TW+S961JLM/URnuMSmfEIm7AXYOU+pAIX2WAgv/FXfEmBFVcEG894RJY
X-Gm-Gg: AZuq6aKuCrpWx6cxW4/z8FXO2638ncHmtIMYdRwqgVdAWfAj1eMJs3hxfMfVw9TvNL+
	/wVcfGe6EDjX+WfnqkQlofRdQ6xGaKIvgMmpnCcz+bmpvRLNm6XnYOpMQJw/SIcGJMunFG1nt7E
	GLGbcJ4CswU3ySfBCTs/SEF5fyJCxC6CwRyqVYQ+MdmvCRNI+u4HmBU7Np82fqV6A+7AhPpejhe
	cOT+JwV1GD/ykgftGNGC4GVVHyRbqFGZpVk9ZokySOogRSd1cfQ1dzNUphymEqB232qhfw2Vi5s
	K2+I/nGKTkTrW6iU0Cn+9zvpzebV4DedwYdANCwgsGc4bJKrsl2tCjnxwyn4Bc0MolAcvQy2ioy
	113pqX7kdi38JEhAuFddDgloE8hzv+UVrN6Rh25s5fDmL596ji7FZi8fOFoGCD/VgQ+J2yhyDqM
	2LuTn0cTZvqxsQZIbmGWlS1sUVxRIvRdN2zpmBrvlmn8LrLvgphuioR/NcvSGVBL4=
X-Received: by 2002:a05:6820:221e:b0:679:c369:9ef0 with SMTP id 006d021491bc7-679c4259c8amr6083665eaf.15.1771913669779;
        Mon, 23 Feb 2026 22:14:29 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:8ac2:4fdd:a742:61b8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56dbde9sm7895306eaf.11.2026.02.23.22.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:14:28 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 7/8] Bluetooth: btusb: Add new VID/PID 0e8d/1ede for MT7902
Date: Tue, 24 Feb 2026 00:13:24 -0600
Message-ID: <20260224061325.20189-7-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224061325.20189-1-sean.wang@kernel.org>
References: <20260224061325.20189-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add VID 0e8d & PID 1ede for MediaTek MT7902 USB Bluetooth chip.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=01 Lev=01 Prnt=01 Port=05 Cnt=02 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0e8d ProdID=1ede Rev= 1.00
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
I:  If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:* If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Co-developed-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: newly added
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4e8bf032d35e..a5e44887a5b5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -672,6 +672,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	/* MediaTek MT7902 Bluetooth devices */
+	{ USB_DEVICE(0x0e8d, 0x1ede), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3580), .driver_info = BTUSB_MEDIATEK |
-- 
2.43.0

