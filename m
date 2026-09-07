Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219643A4F33
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791194; cv=none; b=n+fOA/N5FTDd6GY6Vv7DBjwsH7dZBDNB2R0PiXeQcgghau61gFkCkswWdUgZPMG82zmffCSLxPDDZpmvvvpc+EXktao7mt9JKiUQY+7Zi5GqxF/ZH25u6hE1tXd+KApi2FB+ZZI8Z91hmzOzRigL8O97MlI6Dbq9PBIXWxcj26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791194; c=relaxed/simple;
	bh=6M6BqSu+AARyDk9/i3i6nT6PArwCznAtKG+pD5PVZUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agaXVS0QoZKoaHLSim0FO2xrPLbOom52+3UY+Ge59exPf0mNLFOgUqvVk6Eujr9y+i3JN0FPG+pBVUSu0On6Ymc84bnCHgMM/B+pnQrNmxT3M0075ZDIaRCkeveBCIjD8Bl2z6lGUJWkZDolDEArMIGsprH4nxTkgC54wT8KpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6Dr4i0W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6Dr4i0W"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b9320423cso41040155e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788791190; x=1789395990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4f0/64qaNZYvJEcWhejwJa+PLE1/Em7ct5SbUix/fW8=;
        b=q6Dr4i0WkAjuFmycVhSSQRnVTczqfUrTQaeORur6Hd2bVgq9VoAdE6Wwx+qQABHvcH
         yacqumiHa9NTfk2p6UIHl9ZhgciVNMQLYg6fwIkh1iAcLsdn4nEP2JV0f4rzLfEZxNAf
         OM1sN0qTqoopKC7E7ab2G3lsoYl2oqr/v/l2GB0mfB5wOk/p/2YZlg9yKs+ZqrZJ0ogS
         XmFEUg/33CGHFA5vSfZ4BQ7Er5wDZNJt12yYr/Hzd0bw5a3lcMZdIKiNZBLTkxaZSuoN
         bbu1rjcC39MFGDDAIhtcPhoj4/iokqFcrXyLzhhKm97rTq99Hd8H9nW+bLRa77OyLgaY
         OcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791190; x=1789395990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4f0/64qaNZYvJEcWhejwJa+PLE1/Em7ct5SbUix/fW8=;
        b=GfEGCs3ukU2L0QoHXmoAyy+2zdVThDyD83Vxlj2X1okAx4VlHoazjNB18Q8xzjQQvS
         5hoxwiDVOXXkqMpWdUbKhtP1PmZsYeAiFRj3npDyCfeTK269g9cQ4zaauMTmIfGD9FaB
         2jXfRwbc/oSY6rgJrzE5TeaqfjTUnUxXKmFub2NsdXW4bUflsITlx1KvGYX50UMCpC1E
         UoGHI/oBEPWqQnkNXlA2eU1JCq8tsGoPsQskQcGguoLghqzyl3Y7rDDMC1HIjf7FryJ+
         2dFY7NHmCp0riV0yOEvqhQ1LH9RCsJb6+OUJ4sAsZCeGLik+jfs5LaDvzw93n8Fl/qJP
         GKmQ==
X-Gm-Message-State: AFuF++n/WXQTfPzD6GiwFlbsJX/KAwk/3h66ddwGPw/mdtUwLmJme6Fr
	vO5i0W6TQKQkrH+BXUinjmNHrWPdN4/fgPXucwjHmqUVW3C0+SdGoXVF
X-Gm-Gg: AYBFou2OLbpYFAKunwxWMi2/5owmSBL8buyEqOz6joK8UC2BVOyzZg3EXqE7NdElYZe
	09+QzUiGn3kczD9coWN4TOC/fChTTjZ940Q6RDUoo8uADoDymP0ckTrpwEdOenbVvAfzF5lkwUK
	IMwmGTzLh2rSyPwrZxdPYICHRDD4YfN8SFQ7EPLUhELe0q/OeWVQ9RXKO4esSfJhQAVAQfs4Vv5
	L2aVTRcYvc+siCAnNjI3y6aAcKr6t5NzzTFCm5gZtXt0CRB1h2IRU/2XCmK2e8q3NWVQaQNxqDk
	Vu5nKkFuxuzzwvW/PSojWbAa0gOVYElzCQ4WsVa0hgy+F5Jrf/e+4WTauQu7jx+Sn9+WgQ4XV+J
	Bh25Hqt0g7WfaVe1vZvpxwfOkFD5kVRQWrL4ZbOoHpr4p7+1TQZoLFvpaCY5fJ/pqkn5oAJsoPV
	7233XnkqGORIHtjc3TmqfTVecA5D5QRxgisFDOO36FRFbQMe6BxNgrAggIk7yLxyRZ1sFZJe/y2
	G8k0f6g6hoTPdCFzVqoV7B3kjkQZYJVKjA/hvN4r0bAlVs0yuW4Q0nMyjb0ut6pOKxCMgNeEM7r
	/ZOInXZgU0Ls4UrcsEOABXaEQw==
X-Received: by 2002:a05:600c:3b01:b0:49b:4d64:bbc4 with SMTP id 5b1f17b1804b1-49cf81f1592mr393945895e9.8.1788791190141;
        Mon, 07 Sep 2026 07:26:30 -0700 (PDT)
Received: from MYL150-3871.localdomain (80.151.89.79.rev.sfr.net. [79.89.151.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm414605655e9.6.2026.09.07.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:26:29 -0700 (PDT)
From: Nicolas Thibert <nithibert@gmail.com>
X-Google-Original-From: Nicolas Thibert <n.thibert@ext.mylight150.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Thibert <nithibert@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: fix NXP IW610 composite device handling
Date: Mon,  7 Sep 2026 16:26:04 +0200
Message-Id: <20260907142604.1080571-1-n.thibert@ext.mylight150.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Thibert <nithibert@gmail.com>

The NXP IW610 module exposes itself as a composite USB device
(0471:0215) with three interfaces: two real Bluetooth HCI interfaces
(class 0xe0) and one vendor-specific WiFi interface (class 0xff) used
by mwifiex-nxp.

The composite device's whole USB descriptor reports class 0xe0/01/01
(Bluetooth), so btusb_table's generic USB_DEVICE_INFO(0xe0, 0x01, 0x01)
entry matches every interface, not just the two real HCI ones -- btusb
ends up binding the WiFi interface too, and mwifiex-nxp never gets it.

Fix:
1. In btusb_table (the table the USB core actually matches against),
   explicitly ignore the WiFi interface via BTUSB_IGNORE, ahead of the
   generic entry.
2. In quirks_table, scope the existing BTUSB_MARVELL entry to the BT
   interface class instead of matching the whole device by VID/PID
   (harmless either way since quirks_table isn't consulted for initial
   binding, but keep it correct).

Not upstream anywhere: checked NXP's own i.MX kernel fork
(nxp-imx/linux-imx), no IW610 references in btusb.c on any branch --
their reference designs wire this chip differently (WiFi over SDIO
per their release notes), so they never hit this.

Signed-off-by: Nicolas Thibert <nithibert@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM (Claude Sonnet 5, Anthropic)
---
 drivers/bluetooth/btusb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -71,6 +71,15 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BROKEN_EXT_SCAN		BIT(29)
 
 static const struct usb_device_id btusb_table[] = {
+	/*
+	 * NXP IW610 (0471:0215): the composite device reports Bluetooth
+	 * class at the whole-device level, so the generic entry below
+	 * would also match this WiFi vendor interface. Ignore it here
+	 * first so mwifiex-nxp can bind it instead.
+	 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0471, 0x0215, 0xff, 0xff, 0xff),
+	  .driver_info = BTUSB_IGNORE },
+
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
@@ -477,6 +486,14 @@ static const struct usb_device_id quirks
 	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
+	/*
+	 * NXP IW610 BT interfaces (Marvell-lineage silicon, same quirk as
+	 * the 0x1286 entries above). Scoped to the BT interface class,
+	 * not just VID/PID -- see the btusb_table entry above.
+	 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0471, 0x0215, 0xe0, 0x01, 0x01),
+	  .driver_info = BTUSB_MARVELL },
+
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED },
 	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED },
--
2.34.1
