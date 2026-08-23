Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C233644DB
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481115; cv=none; b=ktgsq/ghg+87p2Egh3OQ9Lt7t4N6GJ70uZ4RKRVbojLndfw6XmSRyaUB38DMYg5iXGOZVVcgsmqO9S79a3MY0itBA5XXhvOlkA1lDou8VJnoalan2ZFfWXw33G4oIa6oJhtJnifBNnPv48NSDXHFJIsGEOAjTd63NeFxf4fVRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481115; c=relaxed/simple;
	bh=dQUbW3oLnHxWw4n65dJh3z82+rr/im6seKUc5Ma+wIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/ARQcf4+b80sisagJsTS4xjWtAnD34sU49LgebIjB3JfnuZhS1OT7XWxJ18Xu0zHEM+ROkHX8qQYkh+vZUspP+t2EgsvNT4xyKDpNuN2kdncaOkHSQWURoG3pc3XPxcaQHV4T13ads+o5j0Tq3dta84PSPapEN5hBKMSd3qr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LddqOiER; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LddqOiER"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c160420289bso366876566b.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787481111; x=1788085911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFnTFrfpFngdekWeSORF1sopRz6Cq1mU1Ri99WmzuVg=;
        b=LddqOiERg5iPZvU6IGLSJz9hxenlcWcoA3rgHvjDc2oQG+84s64GVnul10Cg8qIooz
         b8+RCWf1SOc9RmvNSO91F3wKsK6t7DBk7dYyI4i64isTPTmuqfMDpCKNxWjrkaUvWxki
         IiLvAS1e9rKXMvh3H7GZ7gooQIRGMXiwicQzxbUUi77l9jpAqX5fDlvAT48rfZTQcgkR
         k289CwZBJrT7gHPjXMKwVqvVwuJ5cm3H3caWJrczY2CUA1sIa6VWbio2tnCwCzJRhJqD
         gQxkuY1pSPG5hlngucfvOohnN+8VU2JELtzNzPh3DRzPi35YAUH8hqyV2wi1KTgGvaOx
         ObZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787481111; x=1788085911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFnTFrfpFngdekWeSORF1sopRz6Cq1mU1Ri99WmzuVg=;
        b=sCKCT67fhA12C/RBwhz/zQEvM8obNC/DgyCDi9JNMjHMgLMEN1hjG+D+oUU5xjN/G5
         IyrygsHSuEfHfwZxZjVIhcRPmFMnugDrbo4u9WsDcynPzCalJkFIUufXPRe+e1s9YC5e
         eeeIQhtHwvAfe54ZRj/XQDP/v+FwLnY8O3lUwxKkwEsFsVIQ4nI2Xm8hQ/uJRcvNARkp
         rfea/H3MWMyKa1+Yxqq2FsN2nkcFffIGnZB+WqgMZx8czPPxVLlejFT0aDlVETAZ/3/l
         +AoiKKDdytag6xzOM29j6MNvOu/sL9NbvhoB38BpVXEdWGMQsGpwFTMUDxfG2yRgLETx
         wrNg==
X-Gm-Message-State: AFuF++mSvb4clMX0gLd+oCrm8e8656RvW7RTPwxOGcVM5s4jbQ7/de3K
	+8c9+uqmc9IwP5jHSvHsefPXhXyXR9gzmLniIPBEUt1yCi+79G/cKVzvDPbGP7KL
X-Gm-Gg: AR+sD10/WPH62UT/LJpQeZq2uqEjLIMmj1ZMDqM0Y0jCwH/WXMZf+qD0qkIG8Lhp7uT
	AsE8QUS3nY9jtbZw6r0Z15QGO2W4gb/Vs2ZCVYtJZS8F4eXZfi/mHb5laEM6ThjMlgPuN4vmT7i
	m1b/dcGVu5/wuyuzAgA2m6wPxsuVzb4mh11OJ+lrIHzrEGUn9AsYI/HZlshfIIz+ExzXSF7xqIr
	pAR55iQePKse2yCLW/T/fTvQpzPYa7ANtIaoygNl4+QUn6HqzBXv7UkfGXtsYIiIXVnqlBpVK9U
	J2jnchdPMRlIKqiZIePahnCQgMM/BTPWzsFYS/sFAFRBLGjh7Ot7DJvRMheR+0caU6+hcqMmmq1
	IxQ0fmJrVcqDTZiHx6HLHuRB8/SoYRIcApxkvOqSGG4Q3zEiF4gAWGf48gL6kBvB6XgnWz6N5f2
	Dn+VrjKNv+fwFa3SL3znnfBjDD4wSRM/y8xEIDudktUYIJ6l95EPHnzFOhgBUC8rEbzmPt3wrB9
	IukLGa4Sbp4ch1XjXLlSOln+4LFFE1L1SWJRqLmXPLNgB90jG8BNrAXBqMhKRkovWa7vVd5wta2
	Iyi1W7wwU5NUk9y6Xg==
X-Received: by 2002:a17:906:81d8:b0:c16:12ff:dc93 with SMTP id a640c23a62f3a-c246a6ca584mr1761699566b.18.1787481111314;
        Sun, 23 Aug 2026 03:31:51 -0700 (PDT)
Received: from bobo (d163-170.icpnet.pl. [109.173.163.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm730232166b.43.2026.08.23.03.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 03:31:51 -0700 (PDT)
From: Kamil Serwus <kserwus@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alexej Sidorenko <alexej@sidorenko.cz>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Kamil Serwus <kserwus@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan"
Date: Sun, 23 Aug 2026 12:29:59 +0200
Message-ID: <20260823102959.100368-1-kserwus@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 5ead2063611ae56809b1b113ac44cef9547c81d7.

It sets HCI_QUIRK_BROKEN_EXT_SCAN for every CHIP_ID_8761B, which forces
the legacy LE Set Scan Enable command (0x200c). That was validated on one
dongle, USB 0bda:a728, and it breaks others sharing the chip id: on
0bda:8771 (fw 0xdfc6d922) extended scan works fine, but the firmware
stops answering the legacy scan-disable command:

  Bluetooth: hci0: command 0x200c tx timeout
  Bluetooth: hci0: Unable to disable scanning: -110
  Bluetooth: hci0: Resetting usb device.

btusb then resets the controller, it re-enumerates and every connected
BLE device is dropped, which on a machine with a Bluetooth keyboard and
trackball leaves no input at all. v7.1.x drives the same dongle, with the
same firmware, for hours without a single scan error.

This does put 0bda:a728 back to its pre-v7.2 behaviour, where extended
scan logged repeated -EBUSY messages but the controller stayed usable. A
detection-based fix is under discussion on the list, but the culprit has
already reached 7.1.9 and 6.18.45, so the regression is better undone
first.

Fixes: 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-bluetooth/20260822141115.58815-1-kserwus@gmail.com/
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

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.55.0

