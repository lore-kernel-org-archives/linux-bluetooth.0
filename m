Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB62BFC85
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786795008; cv=none; b=tTMaEI6uKITATw5mnD7dqiFaksuebJlyhw0V14XL26WoJvn1ttHIcTQF3JGmA4L1nFIFAkf+YFIotVua88goVucrvDhIMkXQwWuzxoY6UWIFaqDt+duEQlbKd/Iml5XsJnUAhjsz5U113n3+8UlX8Z0hXvkmrQKa2RZoIYm6wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786795008; c=relaxed/simple;
	bh=b5LQIwGVpyvdNO/WfDgWI7hUw5OYOoA0sgu5/kZeQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUdgO4dEv6ANrYA69uaS3pT8wYVLLJO3Ga9s3lVoDtnYO4ixOXiwVCzxWRakXg2S5hi5IlINB1sillEujKoW0UUpU2aaT63h14gKWIbn20exohnl4JtFVrSwBLOk4ZyneWCq9bNqv2AwQAqVxObwScRS/+rqqT2F8P4u0WKBMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4UAO/7J; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4UAO/7J"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so1335986f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786795005; x=1787399805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/9+rmVvmvs6s8dnr8ttRWG5a1oyP8FaGHhemcTL1GA=;
        b=m4UAO/7Jrx2eKOR2GDdqDlQ1zZmhcy2bvhoZSSSY0gP4y8lHFbaAO7bCLXbcZvJRCS
         BupAgmNQ6zddMp2WtxJbXYgUNxOE82MwRBX1ckdJEQNiTPeawX0FiP/tg6W71Er4aiMA
         Po6y+G6DLG66SEmvmJ/Jd7K8gA59c0SPNCK3CRaE8AGdR0moZpfhgb54WtrgdXf8Uf7G
         +e0V3EDFQvsUCOCqqSzWzNJyGAlmFaX8Fmt2nWCUHa3ur2vUioUQPlDKpvFcOwyZ8QGL
         P2NDvJg3so7fYhd7rJDH9rrxeLH9SDvs3bug5dkxkMLv/HYPr7lsO37W06kna48R6XmP
         cxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786795005; x=1787399805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/9+rmVvmvs6s8dnr8ttRWG5a1oyP8FaGHhemcTL1GA=;
        b=U5BmY6u8G13DKm8+N+lLTCyHrUkZJvUhrCPJi3HeTkLebSk7LI+zP1Ni2pkcpL3VKe
         tUpCZgdqMK4RxPvbT2H5GQtGQqUfYJcsXA6Cu8U+z5fohR1TGmr7Pd+Y+vmuLl1wjPuk
         ztz36V3PKcGnphKxy8rwQ97lD6uTepCez4hTUagxDyDq1eCGOlnDt8BtFVjxQcHN2h1O
         aWkdxlbg6mb4CM2vqcvJWaNTWIEfHxI9VFrlRotU0nRGVrKm9btBADbRZjj774W0gWqh
         JiiVr16SocXnuDVmYy12wklv7sk6k+xYEFYNYsW77qmdv+9P89Rm7WJACf2/IK76QHg3
         dmZw==
X-Forwarded-Encrypted: i=1; AHgh+RoDxO6w0qaLSyz3oIxmKKBnciqb7a4eo7WEMg9c9ewE2n4SB4F0hclESHpCxzEoB+pxO2xeBY/VmYrQlaoDs5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dbCFL/G6QToWdC9oCQ5VTm1cOFH84Mrl+Bq6QAt1qatfNVfC
	rbQT5H4eSEwztyZ11emqRpoMuENUGba91RAzaLq82Gvk5OENrcwgHH9i
X-Gm-Gg: AR+sD134Che/s5B7tnJTvdwg47dwE988TwHnrhjOOXGNIy/LAuBBNT2+Lcn71AX9gr8
	eG59ifhcAVkGjoSYu11m9i4KA3JWVET2KPTjgtsrpUb/7+4XagzsU7UFxY+vgtEys4anBzL1mSQ
	8Q8Ik5Ugx+ZmhK+LGRVAnuubmHfHWZB763wAufebNV5G6tL7n9VQT1tlGwDAu0iBvfcvO5Q5cWM
	yU0Fj2a4NL35VoOEbCIEqD0P6ZRppIBS+8qz5MmDAt2w8hGP3Hef01egaUh/NPwY4Grm/d6US+R
	x9cfWjbHM1NUVRb5bqrK85V3L/AE9rx6E4Y5Wc+M4Grc5joG7lmUzeUF2jtRMEmDOa0kUJEsR+J
	dNbA7pqszTby63zh8CS0XKKyzDU7sVKQOe5LR4DC799R2N0gNPdf9UT92gSC9pm/q1jbcm+D9lA
	mzpRobufUqwV+EYoNyvVeANNVIwuZ1YipWnHVToLWTBWf4KnqYb5HX/+D7/r8sO2vZngo123qnT
	i6GDUZi7cw9
X-Received: by 2002:a05:6000:25f5:b0:482:984d:fdd2 with SMTP id ffacd0b85a97d-482984dff83mr6257452f8f.20.1786795005196;
        Sat, 15 Aug 2026 04:56:45 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([185.19.153.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c129dsm16085455f8f.26.2026.08.15.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:56:44 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ismail Tarim <ismailtarim7@gmail.com>
Subject: [PATCH v2 2/2] Bluetooth: btmtk: Do not discard the subsystem reset timeout
Date: Sat, 15 Aug 2026 14:56:24 +0300
Message-ID: <20260815115624.8309-3-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815115624.8309-1-ismailtarim7@gmail.com>
References: <20260815115624.8309-1-ismailtarim7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the MTK_BT_RST_DONE poll times out, btmtk_usb_subsys_reset() logs
"Reset timeout" and keeps the error in err, but err is then overwritten
by the return value of the following btmtk_usb_id_get() call, so the
timeout is never reported to the caller.

Commit 25b6d7593a3a ("Bluetooth: btmtk: introduce btmtk reset work")
discarded the return value of the chip id read, so the function returned
the timeout error as intended. Commit 3dcb122b3064 ("Bluetooth: btusb:
mediatek: return error for failed reg access") started assigning err at
that call and silently dropped it.

Keep the timeout in a separate variable and return it, restoring the
original behaviour without changing the control flow.

Fixes: 3dcb122b3064 ("Bluetooth: btusb: mediatek: return error for failed reg access")
Signed-off-by: Ismail Tarim <ismailtarim7@gmail.com>
---
 drivers/bluetooth/btmtk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index dc702c0a6034..c0ed51567ed4 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -860,6 +860,7 @@ static u32 btmtk_usb_reset_done(struct hci_dev *hdev)
 
 int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 {
+	int reset_err = 0;
 	u32 val;
 	int err;
 
@@ -958,8 +959,10 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 
 	err = readx_poll_timeout(btmtk_usb_reset_done, hdev, val,
 				 val & MTK_BT_RST_DONE, 20000, 1000000);
-	if (err < 0)
+	if (err < 0) {
 		bt_dev_err(hdev, "Reset timeout");
+		reset_err = err;
+	}
 
 	if (dev_id == 0x7922) {
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT, 0x000000FF);
@@ -973,7 +976,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		return err ? err : -ENODEV;
 	}
 
-	return err;
+	return reset_err;
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_subsys_reset);
 
-- 
2.55.0

