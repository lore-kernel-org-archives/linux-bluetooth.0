Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F23803F7
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407960; cv=none; b=WXKSyK2FkrHmI7HhQTKli0yUJeZIN7Po81XgU2lxGyOxu30tu3yj7nQAyv+25JOpy2ynWSrH5WJK4X2Xo751d3/HCxsm+whQTXrKLuLkWo+qNBYIYrwjtybcjvP5eN98Zjs0ZkPW44hZkDUwmLqANXsPVZAlFw/0nRPW3ZyMg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407960; c=relaxed/simple;
	bh=a/Zen0w90tMij5iqhPeoVzR8LiXYaB3RDaflEiW67OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpWN2WAMPn9qPLhdDqv+uWTnsZKMJGfyAUvL8TN/QVF3Spp9L9vlbL61M2HW5m0zAEPAQGfeyh25ehaQTSLyBEVOsrjEPnIOaCL3RMRNmO5+kssVW3D5IsQgujsRhb5pKB3SL+/ojCu4FuCcSswkee8hRstI9UKMGN/VmrnBrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOYB5Iyi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOYB5Iyi"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2020421077so336080366b.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 07:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787407957; x=1788012757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtlvMLrP2jUPQduDljPzGOvdFkacvebUJpx+3lFSi1E=;
        b=MOYB5Iyiuvr8kjUTiD2ipGJ4JZUxHmAg3tmAo9rVLcvJTNrJJ7nCt6Dzz+m78HHYl4
         ZHjRBslE9Gt+vVYPSnIda/evhFtXQvgKqnBR4Ow2qfG5sGZN3xSAMkztxtmYMMPxennr
         Tf5myLURuTXuiQ9h3kRnJe/k9D7tOstOvBSUyFB1v0E5fTYK9a+XYeIzC5qpIUaoH6tj
         yxaIyO8ib7ofm58m95YjVIL+DaWg9ps5jtYUSPspJdBi9Dib8rrGqCvUixZJ+Gtmhcbb
         3j7HXkRrglg7mNOIoezubDchKaWMvw8+1+IXJRAUpZm4Xmqrl2uWUOncXGkFC5j+hR4I
         WS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787407957; x=1788012757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rtlvMLrP2jUPQduDljPzGOvdFkacvebUJpx+3lFSi1E=;
        b=Izo/ODV94FUnvomobly1/qaTO6SnFbxIc/2AYkDYMSnpdrCJy6PrDiwa/BzlyXNQWc
         ulfk5ArMtr/cn1PQ8qniOGUcqBpimolfi+PclJBKSCKxdcfo5X4L4nWARdnQ9IudJNCW
         uMQ1vgN7NteLk5MhexCtTefLo9RavMeolYIO8n0IGbn4gaIpodX1HnGCu9k1ZyWoWzqx
         Hvw84Ar99r0PQYeWtZJ5jgYB7camJev4WuAIfiFg6YPub1Ur9Cwa/2dquOm45Z8wx9+6
         JcQ2vAdklWyA7AeXJmzBDRpuqkUm4p3qbLj9rSOocZJTZdiEyQPIOxcJUq7YNVJEZhms
         bREQ==
X-Gm-Message-State: AFuF++lYH7oXN3GiHRoQQpiuBhG7BY1a/VFYbeuKfUWIykyRCIdy4aMA
	9t6jISfeLTh6w3JCUrV7jhoFIuDb9rshKmHKdHYmWjQioqYp874zjMtVZ9RgZfE/
X-Gm-Gg: AR+sD10dcAqGPujftOGEGHrLz5I0aDYxfCZRBl0pGx115TR5HEj6/I6KfUPYRhP3zh3
	SxfmlO8jH/k+/1BEs7xcXAldJA6HqK2pEd8immt8xwG8MrLDhE1xzoNSiYl43gWo6hnwt/8KZM9
	D6w5+CRC9DbpGBWk32Hd71F3hTrk+ztZ3KGptCtPSSrIVAyA+xLWbGmaGJGVPIWuUtQi54h3CyH
	9SA+iBFEpcxsvsFznyY7LZuhZ7Cs3/NZX7q/WxkLJAs5QClY/b2o0X5ET5jBXqhI4UZOVXDu8ri
	znvB1VTU62+4Sfvt37IvJtmBzTsySDTLGEUkIWyY6yg1Mg9KbjWTcVdA84K5jI1swB8fxn6HiXU
	9rrMPlBEoOehOeFLNuyir9CR1x4ZKMsdEiMMtc999iNWq1gwXQu6ySkxrAwr3KxKkD2JFWJ6jET
	FHGKQPeN2nDKsgk4fyTFjib1sBzO2wQAPeCGYVOyu32ehLBCrtfaS7KkAcUiN3TUE1wPPGqxCoq
	R+m/BPXZPx/CqMiOEPSddj2krvE6CWSYBpepcZJvU2Jje/k07vA+LyEIXfBG4dnzDz6BxVui+V+
	M0BTry4xQjEhxanugA==
X-Received: by 2002:a17:907:d78a:b0:c20:899:b8bc with SMTP id a640c23a62f3a-c2491c836e7mr564736266b.6.1787407957178;
        Sat, 22 Aug 2026 07:12:37 -0700 (PDT)
Received: from bobo (d163-170.icpnet.pl. [109.173.163.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm340625266b.43.2026.08.22.07.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 07:12:36 -0700 (PDT)
From: Kamil Serwus <kserwus@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alexej Sidorenko <alexej@sidorenko.cz>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kamil Serwus <kserwus@gmail.com>
Subject: [RFC PATCH 2/2] Bluetooth: btrtl: drop the blanket RTL8761B extended scan quirk
Date: Sat, 22 Aug 2026 16:11:15 +0200
Message-ID: <20260822141115.58815-3-kserwus@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822141115.58815-1-kserwus@gmail.com>
References: <20260822141115.58815-1-kserwus@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5ead2063611ae5 ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
extended scan") sets HCI_QUIRK_BROKEN_EXT_SCAN for every CHIP_ID_8761B.
It was validated on one dongle, USB 0bda:a728, and it regresses others
that share the chip id but not the firmware bug.

On USB 0bda:8771 (fw 0xdfc6d922) extended scan works flawlessly, while
the legacy scan-disable command the quirk forces makes the controller
stop answering entirely:

  Bluetooth: hci0: command 0x200c tx timeout
  Bluetooth: hci0: Opcode 0x200c failed: -110
  Bluetooth: hci0: Unable to disable scanning: -110
  Bluetooth: hci0: Resetting usb device.

btusb then resets the device, it re-enumerates (hci0 -> hci1 -> hci2)
and every connected BLE device is dropped - here a Kensington SlimBlade
Pro trackball and a Keychron Q8 Max keyboard. Linux 7.1.x, without the
quirk, drives the same dongle with the same firmware for hours without a
single scan error.

Nothing in btrtl can tell the two apart: same project_id, same
ic_id_table entry, same rtl8761bu_fw.bin. They differ only by USB id,
which btrtl_set_quirks() cannot see, and both take their driver_info
from the same generic Realtek entry in btusb's quirks_table, so
driver_info cannot separate them either.

With the previous patch the 0bda:a728 dongle recognises itself on its
first rejected extended scan, so the static guess is no longer needed.

Fixes: 5ead2063611ae ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
Signed-off-by: Kamil Serwus <kserwus@gmail.com>
---
 drivers/bluetooth/btrtl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7f54d2d2d..03fa9409e 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1343,19 +1343,6 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	if (!btrtl_dev->ic_info)
 		return;
 
-	switch (btrtl_dev->project_id) {
-	case CHIP_ID_8761B:
-		/* RTL8761B/BU reports HCI version 5.1 but does not support
-		 * the LE Extended Scan commands (Opcode 0x2042), causing
-		 * repeated -EBUSY failures when BlueZ attempts extended
-		 * scanning while a connection is active.
-		 */
-		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
-		break;
-	default:
-		break;
-	}
-
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8703B:
 		/* 8723CS reports two pages for local ext features,
-- 
2.55.0

