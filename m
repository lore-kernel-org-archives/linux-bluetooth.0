Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315341754
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Feb 2026 04:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771649494; cv=none; b=jWoYCAqzRGMZv6ggc6Z/AhErFdh+yvVVLD9L1Uk4w37fn7ug+3NS9jNXPRTqR1rjmGknoCA3f22MS+b6bV9AeFtcx09IBQdcwH30Y+wJJfifyEBh+nihEAzKbkqPcXIqbx3ah6sFgrfaqqQYUajclBtK/MoRDzQig5LFxEIeiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771649494; c=relaxed/simple;
	bh=KXLPOe4FhiNeJKRakOuRcfGlWMs2uS0bZfVzft2i/Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJ8zwwpXYdwD+ulIXc0zzmfl/ZS3SiOg6CHgaw3oF6ef1YajUxX/Or/XX9tl3aWe4j30e01wcb4nv6SF6kg2iBLjFmAf82tFsfDI3ntnnaM5EzSI6dZ9hI/2Kp5HWNI34E89TI7V5A+0HaPsBZPsBybhvDuAUucqj3+8JrTIiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=onitsoga.com; spf=none smtp.mailfrom=onitsoga.com; dkim=pass (2048-bit key) header.d=onitsoga-com.20230601.gappssmtp.com header.i=@onitsoga-com.20230601.gappssmtp.com header.b=eKzywtYE; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=onitsoga.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=onitsoga.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onitsoga-com.20230601.gappssmtp.com header.i=@onitsoga-com.20230601.gappssmtp.com header.b="eKzywtYE"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c711959442so272032585a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 20:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=onitsoga-com.20230601.gappssmtp.com; s=20230601; t=1771649491; x=1772254291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=McqDfjI4TCDgrVey2EPokqRyzXicfvQlR7LBhS3nZew=;
        b=eKzywtYEE2dzMFDfMixu/WkMr3kAmgc86akrNc4KcS4hTiwBDL0RFqePD2hMsmep88
         eHWBMaQq9/rBvPlNRn0t8rgjMfyad69zSMGSpGkvFTqJisDYaYVnSU+RK/hPt7mduppM
         8lXdmR2PVGCmuYdmgjhqNUpOCqZOeD7ozQyQSpTk/pOKKydGk6r2PovEuxACli74wXF4
         IT325SRwcWDGwGzQrciP2y6ozduI3LplUl2LgFAdLWjVfUWO4FlqSJR50VtHfGUc7MJF
         3LpVJyuTXwWIStqio3xuhkuOSXmJG2+s45lbWg8k76edW9nX16Gqg9WSw/4aFMKadZgJ
         m/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771649491; x=1772254291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McqDfjI4TCDgrVey2EPokqRyzXicfvQlR7LBhS3nZew=;
        b=dNs2T3mYemhUGzUjbRI9wG1il5PBXQe4OSUXqCLnwEmAXocalf48y69yHNcJGZ/ySI
         sXRDr2UkpT5PTLVlCz7ukvGwkCrEy9moaNsXsTHE90bL4Be6v0OxTmjEu5/ZXJf1NxrE
         QeCEKT5PIyfirYUvhmyBA22+O9wrosY002VbOTAUAwPerd69u+Z7nCndHT9uGv1uh3dJ
         3J/Euje1Ft9geRwn0kRt6ghlAZOEPFxBo8wnrykL8/b7nt9nJ9KJFs6sORh+7cMIlEYi
         2GoE92V7XFqbpWBsj/J0ZnO5pQL9gnsv/3jwtKr4p8NLz1qsCB5VtqhnVMbLpQdW12ep
         So9g==
X-Gm-Message-State: AOJu0YxBayK+IYDiUz04KSOsUwIFgZE3NMGaFV30fK/grZdUNvqbCDvU
	M69jeuDVadojTbNvHFPtqHaUFMN+Va+stHon7bo/GZBOY19pBHzGeK5IyX24Dp9fuI2CXNg/aaV
	/AoRaXOU=
X-Gm-Gg: AZuq6aKwmgq18Nh+exscZWrDjjVEvXOihofciHVVWGm04fWpQ45l08xm8H+Q2aQFocO
	Foyni9WgOFvS/Y1cHbM4UgMYIIS29z952HOSYwBH1TNCsOr+NqFmH/UrTcrA4GwupL8IwHOHlL4
	5Zhq8Ei5k3mzbl5JieJjSpAPpSSHA3g5eEpuRk0FSWAJLFULxHTITlD4St2+VYDXK2lk0PwLQP0
	ooc864EuD+53NU214hDIIyYlQ6OSe3SKiHYKakoWvqBW+eQf0BVi3lSMEkfkgzaPtva+/iEmse8
	qHy8KcF68qwtHEywI9bKt1eqx3QZz0CtoQMPt9NjzQepXuAeys09pWcU58nyjN/6jZnm7Wgz3CC
	KjDIwlPq/U15qQnvFtXzXvPmPYD4N+8WxBOm+W4ltaC+ns5Q6NK2Cy4DK7PBa3culQY7pmmiLHq
	Ts0rsuZe88u/6R3LcGWLMEqwfYHFYvBbOICsDMHiPJBCZMcLINBYTyH0N1TtAieXi0ADshXv09D
	pMmmEaGFVhD+wzt
X-Received: by 2002:a05:620a:4727:b0:8c7:87a6:b25f with SMTP id af79cd13be357-8cb8c5b9334mr241197185a.10.1771649491511;
        Fri, 20 Feb 2026 20:51:31 -0800 (PST)
Received: from nixos.lan (pool-108-41-6-49.nycmny.fios.verizon.net. [108.41.6.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d101d77sm118735285a.37.2026.02.20.20.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 20:51:31 -0800 (PST)
From: Agostino Conte <git@onitsoga.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	Agostino Conte <git@onitsoga.com>
Subject: [PATCH] Bluetooth: btusb: Add support for Quectel MT7925
Date: Fri, 20 Feb 2026 23:51:30 -0500
Message-ID: <20260221045130.19653-1-git@onitsoga.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the USB Vendor ID and Product ID (2c7c:7009) for a Quectel
module featuring the MediaTek MT7925 Bluetooth chip.

Without this, the btusb driver binds the device generically and fails
to trigger the btmtk firmware loading routine, resulting in an
"Opcode 0x0c03 failed: -16" (HCI_Reset EBUSY) error during
initialization.

Applying the BTUSB_MEDIATEK and BTUSB_WIDEBAND_SPEECH quirks allows
the driver to cleanly load the BT_RAM_CODE_MT7925_1_1_hdr.bin firmware
and initialize the controller.

Signed-off-by: Agostino Conte <git@onitsoga.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d69d51e6d0ec..d58e7e4557b9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -765,6 +765,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3630), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c7c, 0x7009), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.52.0

