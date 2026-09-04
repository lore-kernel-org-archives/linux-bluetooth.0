Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46A41684D
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499817; cv=none; b=CtMzBrU74baFLeZ7GEt2pfXf0mUP/s9RYYkEoqGQjCiVnJafQtLLDNVI39PIeFyxZ/Alp1EXQ2IMUNz7rO2e8mAIIVmW0GUlON3AS7eM5XSdrwiDdAQNCzZpJaNY53EFVH6kJ5NHzReRDQddmGg3CNXEcsndYN/OUtkFBZbC0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499817; c=relaxed/simple;
	bh=ImOh168kxeA1zuaF/xS9s+Ai/+OKoAZCi8OLGG3Sztw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBUBViyHKuuPo/lz2ZNd4UhjXr0hqIPaxPs2vRrurVhXPxAGZPm0yjGRYi1ONk3O3wvyrpoLOEdo+UmBuANOHjiWosj/VGG3ctQK1L5dSNhC8lnLSjdQQUL1UjzWqZywNinfE/v/wuDmGyqWK7dS4bMq3sybABIQW7BoSMTOdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=kPoyCHgr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="kPoyCHgr"
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9CA5242943
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 05:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788499812;
	bh=s9VeM2Hj9d1CYutblv9K9gniHtTbYGqC7kevoULcpcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=kPoyCHgruozjzrQzIrWZpv6LdfuNlNZSU0XUzk4pBYZgBcPqw8UC+CBAe4PLY9qMD
	 EkTMyLWpXDsYCZhTzISiV6e8GzXoows5Zm87tKGAAxAH1WaYPmTRjr/KMe7aU6XRmj
	 6qhdj1lB2CQ8yTy26DoAL7i+M0o2Y8r3Tt5qJLZ/qsWW88MGs6UwznWNkZqHGUP5ma
	 Asezl2BmluU2GoOIP4EDliBZfB0b3Gn/hz2ulqHEB5+YQJr73u4HTHUIwQrEJBxuFm
	 ONF58gjhY+mX8TSjDZDOkcf2CZCYdB0w6x3dSe765AarVG3WcD9TZKu2/QLO34r/ZK
	 bJBDUKxxKxm8hFq8JErjemUKSFj6bV9T9+BaFKwvgLQ+K91agXVAnSsIE2xC7e6jHJ
	 FEIHT1AwaP9CyO8j0psaaUeSrgkshdzBx2Dh+FEejpB+jHrjL025/0ukVFujva9H2b
	 ByH76eXIVZNJovbt3HXTKEdwrDCyfGelItY9MQELhu84N2MpvEa4ZhOeZk6QZyWa2C
	 b6FV+oB2LRMI+/2gI2dJ5GAhBk126zOErPy/xBR5faSGJIVFoF6MffUubsMtP8yMJ0
	 Clovb7GzJPdurot6TYn4ap60DprVjFKeGXytNmNuMm6HoVHKy/JWpMA4P5TSkWYzGW
	 a9J6jo+sYSlcSfNQwNz2so+g=
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-85722fc5a21so831954b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 22:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788499811; x=1789104611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9VeM2Hj9d1CYutblv9K9gniHtTbYGqC7kevoULcpcA=;
        b=j6P4zrLMozwRVLzsqo9dlmugbGtFfSIoFuZ+rNRmccY8p+f+AozTlt9Z5elh+GqfIC
         6VhhCqiiWxuuHPGiGuwLfEn6fPtxmlMRNTRVst/oKrpACZurDGsRIcKPWjdgq4x4SchC
         vCe4oH7zVYnqUeCdCzcmwCerN0fKSepJxUoKFDApBUsKX9rdL6HkRwtQGgmcGPLNMgqJ
         m9GZznszSEOUxhrwUCiKHsDJZdwgBD85ljndsV6u0XTsUhf84S+e146exiemGAfzWjR+
         4JEN8MWFnk3nhNXqPBnfweyaJbouUg0a3nMUEBJueBsgyVl8XfCc+hf74/D46tCSguZb
         Rigw==
X-Forwarded-Encrypted: i=1; AKwUvByK8htVSV8d6fWB9zJWFv/fAUIFrSk7DEapmwQHqt4I+yQlRTy7IVCiRLlvV/SuX2v309Wj20vbF611DbeOJxc=@vger.kernel.org
X-Gm-Message-State: AFuF++nk+B1Do1oGgDiltzyMluSJJgkjdsLRGa7q4enWWu8j+aDdFek+
	kqj8OuTAWulGTXANNSdY23i4b3iBLVMYZQzhMrMkHssFV/8uzcNXT4rv1i3fmKaSd+B0NWfd1Hl
	6VMpUa2Nt71WIZluY2H6Ufj9YPVt6GIcW86V2DV/wAmBIhBeHTMFeoDSRcZ631RNmUsSCFmKhaj
	37mlpbD5Etjw==
X-Gm-Gg: AYBFou0DWEwq2+6a4eckcqmhOCrNROxNrSg5JYKjkVmeYPL6E/jZC6fnMQOuj0SB7Vb
	JzLaL8znycqo3UuJBjUQhskiQQ7yn02x2j6GCVngPEJUaXNff+pvsPpDz7wbgP35poAtRClg1y2
	IXKsJ2sly0H2SofZHrVVuEeLuQ+a6iiySuxMhdD5VbB1RgmDjMHRsvrS7YeUNYRU7tSVhl99H08
	frWbTBpKqwEKFujyADt7hW6OoM5BDW2zIDGIU4Oe/gVjtQHokD5PliKbMotQLAEkMY5OgP4o7hZ
	lDrYxe4Cxwli2E+IcB8u2mpXZ9Olpcq/CP09MZVgPfa4YorwLPB8U5ixbiSAibJFPp4OSjaW14z
	3oI6WJNzHf3uH2wMqrI0cWzofDDxIiMpv1unSrPQh
X-Received: by 2002:a05:6a00:8d8d:b0:855:eb7b:5804 with SMTP id d2e1a72fcca58-861662d4c0fmr5800141b3a.4.1788499811001;
        Thu, 03 Sep 2026 22:30:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:8d8d:b0:855:eb7b:5804 with SMTP id d2e1a72fcca58-861662d4c0fmr5800075b3a.4.1788499810579;
        Thu, 03 Sep 2026 22:30:10 -0700 (PDT)
Received: from canonical.com (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152d29654sm711385b3a.33.2026.09.03.22.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 22:30:10 -0700 (PDT)
From: Ivan Hu <ivan.hu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	peter.tsao@mediatek.com
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Bluetooth: btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware
Date: Fri,  4 Sep 2026 13:30:07 +0800
Message-ID: <20260904053007.667472-1-ivan.hu@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btmtk_fw_get_filename() constructs the firmware name at runtime, so for
the MT7920 variant (dev_id 0x7961 with fw_flavor set) it requests
"mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin" without ever declaring it via
MODULE_FIRMWARE(). Tools that select firmware from module metadata (e.g.
"modinfo -F firmware") therefore omit this blob, so request_firmware()
fails and Bluetooth does not initialise on MT7920, even though the file
is present in linux-firmware.

Declare it with MODULE_FIRMWARE(), as the mt76 driver already does for
the corresponding MT7920 wifi firmware.

Fixes: 1cb63d80fff6 ("Bluetooth: btusb: Add support Mediatek MT7920")
Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
---
 drivers/bluetooth/btmtk.c | 1 +
 drivers/bluetooth/btmtk.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ea0c320f9827..911aba5c134e 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1581,5 +1581,6 @@ MODULE_FIRMWARE(FIRMWARE_MT7663);
 MODULE_FIRMWARE(FIRMWARE_MT7668);
 MODULE_FIRMWARE(FIRMWARE_MT7922);
 MODULE_FIRMWARE(FIRMWARE_MT7961);
+MODULE_FIRMWARE(FIRMWARE_MT7920);
 MODULE_FIRMWARE(FIRMWARE_MT7925);
 MODULE_FIRMWARE(FIRMWARE_MT7927);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index c83c24897c95..bc26148ec544 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -7,6 +7,7 @@
 #define FIRMWARE_MT7922		"mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
 #define FIRMWARE_MT7902		"mediatek/BT_RAM_CODE_MT7902_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
+#define FIRMWARE_MT7920		"mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
 #define FIRMWARE_MT7927		"mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin"
 
-- 
2.53.0

