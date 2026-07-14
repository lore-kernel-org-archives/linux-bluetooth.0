Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D7381EBF
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998609; cv=none; b=SxwegHF1FjXTA/nd52/TJOvgeayItqf6q87tvxbzFBhWHQrnOnEsPwHQHfTBmf5Vs3Tna72EcG9HRl8+wvwJu61fTDuPpqYaxTXs206UbtTavFFc4GByzbS1tee+HYsRr5RMQ+dLdHnsqkJcMhO3YHIBwCmICap3OWKlLoX5gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998609; c=relaxed/simple;
	bh=RtZtQx9wJ1pyEfvFKv2a/RxEDtLVLE5MZfhP18omKwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3JkX4op+hU0ztIKOo35sLbJ2wRgObHytLfzg89hijh/g4XIg1LbAPZPbrfF+qIYs2Y5+8d/Priv0yZOX+BuXPPcn4yVmRTwBUq4naNG29gp4IbDbYXfQcf579wDAJQfxCcUoaaAuems19VwJNGpuV99feG4cPkRsWt7XILEkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox+AfNbl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox+AfNbl"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c149c5722so4381341cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783998607; x=1784603407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EmjQDTK+MwpGklh4rIiDwMeZv+1lFiIw7JjjLZliWBE=;
        b=Ox+AfNblUPTeghNV9EjGIeQs+YkU9TG8oKXfzDxsftBgmDBNqhsgjqBOfzUlPRPhra
         XZlTllpK0MS5s9q+ZNOKr/Eb+qiY2XIVEwHNgUNUd9mMCfiEdmfbj4T/CVBEoWRXnnHZ
         8Trkf2lydaHNUzGvmfrfG2uWagWCd+71iYucCTnl24ijJKq65gE+Pszv3BM42l3e99Ez
         P/69TXYCPNGVtyvPIN54UEsNsjpcGvJdUrmhuJZ76VwiHS19LC1Sy89WVywRTXmvNKqR
         V/hJTASv/ag5Wqd69Kg85r9ndtr092CAFNmwAjxt53rBV0E/3RGt5YGnOJG/5dlWXEpf
         YBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783998607; x=1784603407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EmjQDTK+MwpGklh4rIiDwMeZv+1lFiIw7JjjLZliWBE=;
        b=r/RH88+qqvGTDslua4dIJzawiNum/m25oApZvC0a/ULbq25qXGXf1ytOr1ts2pry3c
         yHxHyU5mN5f1ZDOtQnLJLT633NvfrStWDn1ywvgsI5I/JUxss85fXS6uuB8ZYTJXsG6k
         NjXczmS/LeXemIc1vUX0tk2W1ICEdd1xLVTgz6bJRPgjcVAbKIX2uwrlbm0A3Rn4gFt6
         re+i8+vTRwQR32T0hLF/OY7pTkCjXF60hazko/1jTfhNAxDFNTmRW9PIThY9gL84lpMS
         iHh1ZPmg09bSDlL0DdevDpCfbJKZD9a6cWN1tq6BKWHbZ56e5O4jrZtH9HTIKNrIf7Cz
         Ru6w==
X-Gm-Message-State: AOJu0Yy0uqRGs0yPciqXtDzmlQX7ATPv4UNUxpp5X5q83AnfGgTlYqBJ
	tAWyHrCpSUtoPzbSQhU36mLDVGBSY2OL9e4AOB7wcUCE6e+Q89zFHIW7n93STsrqjPk=
X-Gm-Gg: AfdE7cmH35k7LUtQyVXwjgUgaXknweQKFX8Ues16y+NR5AL0pDVu683W6oH7EegO9sN
	4Il8jzPa0KwOpkcxksXAG0eIuoa6LKmI4zkc1tYh6R5VzTrqz7LV0Ljz7dG6aF6m1/fFaPLjnkj
	X/Pr+Svp6V9jmtkXVe3BDd+m3EKdSBL4L7M7xTVO0Sp7G7W5DA2Z9UvDpQH+KHaN1VdPHyMGPH4
	NLCzuy54+1ZB0tmkD7s8etI6j0q+MdpSXYRTAxP1ZmjxF4nd2CN3U2Io6iB40Xd2PmHxUhrnKnN
	0PpC9BA8KqITqvPTbcEABGmW7WITf+hcyKVQHIXVcdFEZaFB2POYAKrR0bncTZ1obF7tYr5panp
	gR1DdHyah6XSimwhL59b1umWkK5IMX7vPr6x/Jmgy8ykrGqQU69J1ba4AZ2/DW9XqLrRWZXND9S
	HgbswcoObxuuZw8YfW2js7j/OVQ4LISbCpuMve
X-Received: by 2002:ac8:5a4c:0:b0:51c:65b:9ec with SMTP id d75a77b69052e-51cbf9674demr111872201cf.30.1783998607069;
        Mon, 13 Jul 2026 20:10:07 -0700 (PDT)
Received: from pc ([209.202.207.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm99098461cf.24.2026.07.13.20.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:10:06 -0700 (PDT)
From: Ameen Al-Asady <ameenaladdin@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Ameen Al-Asady <ameenaladdin@gmail.com>
Subject: [PATCH v2 1/2] Bluetooth: btintel: Fix spurious error on FW download error recovery
Date: Mon, 13 Jul 2026 23:10:04 -0400
Message-ID: <20260714031005.230895-1-ameenaladdin@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the firmware download errors out because the controller is
running an operational image whose version does not match the
firmware file on disk, btintel_reset_to_bootloader() sends the Intel
Reset vendor command to force the controller back into bootloader
mode and retry the download. This is the normal upgrade path after a
linux-firmware update followed by a warm reboot, since the
operational image survives in controller RAM. In the log below the
controller is still running build 81755 (2024.33) while
intel/ibt-0041-0041.sfi on disk contains build 82122 (2026.5).

The controller acts on Intel Reset by resetting and re-enumerating
on the bus. This can happen before the command complete event is
delivered, in which case __hci_cmd_sync() returns -ENODEV and the
driver logs a misleading error even though recovery is working:

  Bluetooth: hci0: Firmware timestamp 2024.33 buildtype 1 build 81755
  Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
  usb 1-6: USB disconnect, device number 4
  Bluetooth: hci0: FW download error recovery failed (-19)
  usb 1-6: new full-speed USB device number 5 using xhci_hcd
  ...
  Bluetooth: hci0: Firmware loaded in 2827613 usecs
  Bluetooth: hci0: Firmware timestamp 2026.5 buildtype 1 build 82122

Treat -ENODEV as the expected outcome of the reset and keep the
error message for genuine failures.

Tested on an Intel AX210 (USB 8087:0032) on a 7.1.3 kernel by
rebinding btusb with a non-matching firmware file on disk, in both
the downgrade and upgrade direction. Both runs took the -ENODEV
path, logged the info message instead of the error and completed
the download after re-enumeration.

Signed-off-by: Ameen Al-Asady <ameenaladdin@gmail.com>
---
v2: reword commit message, add firmware versions and tested system
    (Paul Menzel)

 drivers/bluetooth/btintel.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e9cac090..472542bff 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1363,12 +1363,22 @@ static void btintel_reset_to_bootloader(struct hci_dev *hdev)
 	skb = __hci_cmd_sync(hdev, BTINTEL_HCI_OP_RESET, sizeof(params),
 			     &params, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "FW download error recovery failed (%ld)",
-			   PTR_ERR(skb));
-		return;
+		/* The controller acts on Intel Reset by resetting and
+		 * re-enumerating on the bus, which can happen before the
+		 * command complete event is delivered. The resulting
+		 * -ENODEV means the reset took effect, not that recovery
+		 * failed.
+		 */
+		if (PTR_ERR(skb) != -ENODEV) {
+			bt_dev_err(hdev,
+				   "FW download error recovery failed (%ld)",
+				   PTR_ERR(skb));
+			return;
+		}
+	} else {
+		kfree_skb(skb);
 	}
 	bt_dev_info(hdev, "Intel reset sent to retry FW download");
-	kfree_skb(skb);
 
 	/* Current Intel BT controllers(ThP/JfP) hold the USB reset
 	 * lines for 2ms when it receives Intel Reset in bootloader mode.

base-commit: eab19cb7618e5c50fd1f8c1efdc4e66e16575975
-- 
2.55.0

