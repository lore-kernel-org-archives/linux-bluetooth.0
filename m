Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2438DC66
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792047; cv=none; b=ZRmnL6uUFRoqi6vdFthXR9YmtO0RkwG2M1GrcZYQ5vKonyi+MGGNfrDa6f1612vsvtelX4BeokgYJdhlMYczLbekR74gGOyOUmMPOelLdfTWGNmMi6MDJYIetWzZScctjWbKAO085RtfrGTplbx8nCS+V1KukrB95G+wuSfovGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792047; c=relaxed/simple;
	bh=OPGYFVz4FMWfgFxxKo+7+LipMYnld5aLYNDtgnYN3dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9f/reEnpFxcvhm2IAvPdvCHb8fXhzgShbmB3DyJILzXK2cZF9JzuZ2YSsT1A0ECWSCF0rtXH3ki9uabJkpfphyTy/eIIsU1QjtMIKX3tkcLqNXk6PHdgN/wz0ewx2tmM6L28SE7IoJunFqhrO9f/+e1OK9BKLDukq+BdKl+xSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZciYRAXW; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZciYRAXW"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3ae12b79so1103534e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790792044; x=1791396844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gXJfGzAbYR0X8APYsn/Qsci/3IB2V96SpvMDDyKvBfA=;
        b=ZciYRAXWm7k9GId00uG9c0oYp+FD4K3EghpwTzLt1hrJd8js4Pz2952Sr0rHpQLYI/
         PUWFP6X9BUIZ/OW4wqx8U6z97QIHMCeqCVMb/Fig1rKJZcSm0av/J0p1MrEKKhuUkx7G
         SOMdhUY4y5l1esG05/jvHEx36tB5xNenxwG74gXUUsqk6nknakfdZ7gBQwQrCsbdAjkz
         9FU9OGKP87K2q1IdufiKTyZidh14Cr3oaoJZtLtyWXEQTQZMayTRA2/2+ugjZOdCCSWp
         LmB3MvSavYfq9NObuQUEQCs4DQ5OvABd0miMXYtAO0M3MoAgc1cDqv/anjZAKuOgOwph
         nuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790792044; x=1791396844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gXJfGzAbYR0X8APYsn/Qsci/3IB2V96SpvMDDyKvBfA=;
        b=NX2sR5ugfw60tAEc29+z4cbWBVbnKZ0Bxwl3HJVKojwfaNJngpMqDGMckl12KJR2cD
         hnw1ZmQIKPwgnaOul/IZMEeAvuTx49rM8daO5JvajVLFAFJvS7fleWJLdt3qQimPGGAr
         h2oAkCGrwBWXDPpAdqqIBxUW+HAgpDRJ0wXEGOvWmSAJAmGL+FIED8p2RChEvvvVycHE
         mNbZ9V6XYeC0/2mN7CCQn7WeqHAlQZv8/+cz80cHlLUIwwCRrxmypdBD591LzWULGJQc
         gBtLLJreBiQnxxoujkIfxVLuMjVeR5lSJh+CVly4ITfWmJenFbkGGgYyn4yzwQcW19xg
         tWdQ==
X-Gm-Message-State: AFq9FYJNEy1QtvV8OqLYf8I1r4QL+vMr3SaskP8z3aEcFYnxh5S4Z70N
	eE8hmVX9L0zsd/y4MxRraV/y9+L9hdf+Lian6BNI59/h+vbauFinBu8J
X-Gm-Gg: AYBFou2nnxCILdS6G0TtkUu3GztjO242e9JYlfeu9ouQS5Wa/s6ZrnDTquzehHpgXQn
	ZDs1eAU9d3rkRaEMm15IR6eSq6SL4VB2e08HrX7OZlslYCepdyTqSNcwNmaC68pfrgwHRZkktvT
	IJulEahu+Zh06UuoTlLartfmB4qmw0VWvnxkI1cRq2qrvauFHvQDv2bRmswnOJsswEnRWS8NMO/
	YTGuE3n5PobtZ33FKA71AFFfNzBygeTuGNd7Zlfjg+OxwchvpRnqP0qnldz1d4nL+az8ERqNK2M
	TXFdCm33h1uhj9tHTP2DKq0Ym5A8andWnfccj84O3s2Mbc6k2ZBl4BZg02pTLzNkuNCl9NM1tUB
	Rfj3vDoQzbRPxXgOGaFBbe2S6XAtovmru10RJWUKc5fBCwXVrjMKeD+LP1QrRWVtWOzXa2fTgeT
	BAZ08PMWU9JgJ4BZ8U+Z51FBADiohiPEWUFzdCG9tC5rhW9WiyzIcQjYhXICSSCmedavhatoi4i
	K6QgVogNNmiJxg=
X-Received: by 2002:a05:6512:1593:b0:5b7:6581:8924 with SMTP id 2adb3069b0e04-5ba402b8471mr841779e87.7.1790792043979;
        Wed, 30 Sep 2026 11:14:03 -0700 (PDT)
Received: from localhost.localdomain ([95.31.11.153])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fb83b2sm143201e87.52.2026.09.30.11.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:14:03 -0700 (PDT)
From: Konstantin Nazarov <qwertyuiopyyy@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konstantin Nazarov <qwertyuiopyyy@gmail.com>
Subject: [PATCH] Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks
Date: Wed, 30 Sep 2026 21:11:04 +0300
Message-ID: <20260930181104.3375-1-qwertyuiopyyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Bluetooth controller with USB ID 0b05:1825 found on ASUS
systems uses a Qualcomm QCA Rome chipset, but is currently matched
only by the generic Bluetooth USB entry.

Without BTUSB_QCA_ROME, the driver does not load the QCA rampatch and
NVM firmware. BLE scanning also repeatedly reports:

    Bluetooth: hci0: unexpected event for opcode 0x2005

Mark the device as BTUSB_QCA_ROME with wideband speech support, in
line with the other QCA Rome USB IDs.

Same issue as https://github.com/bluez/bluetooth-next/pull/833 but
with different device id. After patching bluetooth is working fine,
no unexpected events in log.

Tested on: Qualcomm Atheros QCA6174 SoC integrated in motherboard
ASUS Z170I PRO GAMING, USB device id: 0b05:1825

Signed-off-by: Konstantin Nazarov <qwertyuiopyyy@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dc7191bf4..66e12b15e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -270,6 +270,8 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
+        { USB_DEVICE(0x0b05, 0x1825), .driver_info = BTUSB_QCA_ROME |
+                                                     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0x535b), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME |
-- 
2.43.0

