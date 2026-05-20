Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC33B2FCD
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267738; cv=none; b=mqgc/6LTl4wSTZ5wkkLlHe4bdX44zt7XdRjDBE1gyiy5++3/fqjn7IVIuU2W6IAeDRxMHXJjD7nB47SKk1BntFBd+vmmS5mlHluAzc4IuW6h7kIR4siSazrq+aRZXvdaG8bK2s2NyEk3V3W/4HWWOP511sYbgo7JnHIsBkIb6Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267738; c=relaxed/simple;
	bh=5VJJUhpTLg0TMTvLusXGmSZPcKBbflukMgQJbarNO78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVbKhiL0OseWFlHB6cAwDpMS+obtxR2bMPnGjEyEZCHE88UZBgOM9Siw5djbzHp0huPzcU3R/tNCy2ia7JGkpB0KHaAanQzr3Ya+JfR5UNXs0Xffeh0nQzylRHKE4ijr0QsERbe0j4esoVybpf04DYr/a8MkaFLuw5N6HU2BPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=Qe2inM5D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="Qe2inM5D"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2babfd18435so19115045ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1779267731; x=1779872531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsKEHgWib5RCguCFqL+aRwh6Wj4S3wweKTqstsPIqLY=;
        b=Qe2inM5DzLRjywVTrF56/cEi86VACktSBz7fKLvG+LfWkivDCEF5Bzxn6t8AgL4WNK
         pPa7aT6HPq2pvZoWnQslfrqMHMR2b4dThXyK6YHBkqwH7b/3iLTfjBaWhCqIVqRyAsDZ
         qJ61PW0EiPbrb0a8ksdQf2MYN+Gf+nzk3x4kmtDoU/eUugKvTsh+rszSL9GUVNHINdbZ
         hM+IYm6+E3A4LE30uqajFmGzVKKKM0/Nw+Ghwt/R9kfxndcCrL8K5tIdWIJD6aOgjUE0
         3sPixMWqKYHyP6ucWVHlO/rHuBCdA3qqPAdxZTk4BU1LwEyoMpjycbacBACbvnQQ34ul
         RKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779267731; x=1779872531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PsKEHgWib5RCguCFqL+aRwh6Wj4S3wweKTqstsPIqLY=;
        b=fBM1Rk2QB+Y3sZKwvwV27qNBCfC2ftm5GS1Sm4hRCah/k7ElA0wvSxR7X+f5KUXAkv
         ufc5RTdqlZoTKpYMr5911k+wSX4z/0Ovmg7iTzD+XJMRhSpTrhDmcZIhYsZWQ7nuqCri
         s/jvFFF6bR65hKtsIhzoLDR+l7rMPWP62vi09n8VzdOTJa4H80h77qG/Stz5PiW9FRqw
         S97Eynr/AC4PAy82sGpC9u0vI6KUeFsOM/7CQv0dYL5L0fMeqogPvhuaHl8hbfd/d1ZW
         N1SQn/G9Dor+kJwKZX42+NgGEb0JomG141+Qis+pqFRfRsHb3qUkMSEP31mnK1Tk8onV
         gzmA==
X-Gm-Message-State: AOJu0Yz0b/2lctjadc/THUsGzwX6UejKyPC2iqPIwCiSUn66D5R8Zak+
	t/yBBElv5rddQz/VGvpveh4pWcJzElq0Z/1ERufJOR5ws/AUbq5Dcm6wB7tfyQbvDLLGLRBqr9V
	XeOBAVQ==
X-Gm-Gg: Acq92OGVHXnyKPgMgXUsIHA5//i4nGkY/OZ3YvwYk+llP3p11ulTw08ZvZwHyINZhAG
	wEftmWaKUX+GEYenC9C+l9paAdYH86wogRlozBdKdFs0K8CIDNQkSalH18pBlmTXlrrTWd+wsgS
	fufdOr8qGON9VTUg/N3FyKiWL+wgwB1PuJ3USa8SwL1/57lLvxiX0Feccbt5M74z1zs7Enlyr7v
	9n2m5GIKlH0FT6+aE1LdnOxvwgZAlRfuHg/e2fGYXKQQWzdEMJyZyxv/tPJuwCdhYyVweLzyKkF
	YyY5cFn9Cbc13uZimTPin1AlCX0gON8kwhQEO8meppYS1LrIlZrWKiE3QAcUm0tL4kVu5fBxtun
	CwTJ8h3CVch0Fr4UHl8tQTr4JvcWMLLObbWAVhZTH9kEWLdbjQuS3PW8LcVF8Kgdg3016alKLeq
	tTHE4U49C7NY0wzT+ZWoEdeCowAfM1odbvyNR9ominek7ub+cigK0qKJAQki51fVVwmyp2r8tZy
	b1vssRtiKf0eEuM0Tk3ef39I88m
X-Received: by 2002:a17:902:efcb:b0:2bd:158d:299a with SMTP id d9443c01a7336-2bd7e88f5a8mr185231305ad.25.1779267730999;
        Wed, 20 May 2026 02:02:10 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm205333065ad.10.2026.05.20.02.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:02:10 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.von.dentz@intel.com,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v6 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Wed, 20 May 2026 17:01:31 +0800
Message-ID: <20260520090131.3505676-3-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520090131.3505676-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
 <20260520090131.3505676-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaihsin Chung <kaihsin.chung@synaptics.com>

Add support for the Synaptics 4384 Bluetooth controller
by adding the corresponding chip IDs and device tree
matching support

Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
---
 drivers/bluetooth/btbcm.c   | 6 +++++-
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index f9a7c790d7e2..1164cca40324 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -31,6 +31,7 @@
 #define BDADDR_BCM4334B0 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb0, 0x34, 0x43}})
 #define BDADDR_BCM4345C5 (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0xc5, 0x45, 0x43}})
 #define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
+#define BDADDR_BCM4384B0 (&(bdaddr_t) {{0x93, 0x76, 0x00, 0xb0, 0x84, 0x43}})
 
 #define BCM_FW_NAME_LEN			64
 #define BCM_FW_NAME_COUNT_MAX		4
@@ -130,7 +131,8 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A1) ||
-	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4384B0)) {
 		/* Try falling back to BDADDR EFI variable */
 		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
 			bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
@@ -515,6 +517,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
+	{ 0x2128, "BCM4384A0" },/* 001.001.040 */
+	{ 0x4119, "BCM4384B0"},/* 002.001.025 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 874d23089b39..783346a4a59b 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1609,6 +1609,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4335a0" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
+	{ .compatible = "brcm,bcm4384-bt" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-- 
2.43.0

