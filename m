Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFEC3F4830
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786960570; cv=none; b=k0h41Ko2DWJ0dfE1erFSbeH0Qoo74jCmsqj2lPNLhKhBYuqfabGbaw5/0IcBlV24LZ1CWMZlsiVK2uVUNvPUusZ6gLhzbU2DH5aog4dLGCxDQIKHkLDAJvCsQzK27nsUE/fjDAW8VL6XjLzWIjUTp8JayIrMVeCYkjmKPqmM01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786960570; c=relaxed/simple;
	bh=IUaOznEiLFw9B1qoV5N4+8o8B1KZmv9fq8ebecxotvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpP9ZbRN83/kGLE7jzdLRQ5AEUn07LoeHK3tHCj9rYV+7ICFks1opQz0mSzf+F7A7ORRs4dKxm1osBBl01uxj3bdEnHvdPFVurnGIqfdtWha883hrW7NdzN/UG4tuanlTI+LQdQ/foq/6CWWYAQtsH32Q8/l9PNXAL5pavIMlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=pkH4OcBf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="pkH4OcBf"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38101f85591so3777010a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 02:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1786960566; x=1787565366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Egl/2bmcS13RHo+tZQinMeCCoNTolmzmlsrAYIeA+As=;
        b=pkH4OcBf/UizuiGhv2BkQwBYipZSypOl7ATjCnXiy7Tz3JB64T16XUivClWw6+FizV
         0vsYBc5B+TYXB9+iv0Y8zDPu+HXR7qcb/9CbXQLcrfMX/rYkEeM6H5LJHMevE5+r0eiz
         XdFWwOkZdsm6e5Iw3k2MS+CI4w/6P6XPyH2At0iU9aiBF1sRcyDo4w+SM4v8hvXuKuuS
         KytSpJf5RYX7sQHhZLsxJ7fvBGbdqS0IXkCjsqysTZeVt1l9QOfEwzk+cZidFvPwfbQi
         mGbo+VcLDTExqxY6nV1bV2Oon8avysu+p7oZpGllrlT3buCvn+gHAwAjksnih8m1muu0
         caCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786960566; x=1787565366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Egl/2bmcS13RHo+tZQinMeCCoNTolmzmlsrAYIeA+As=;
        b=DyXm5vthjIjFNShU2hh9rJxSdyTQwmNDDvgyiwvxzztYhtjQNzTSBfFCxukT2UEYjo
         TC0UUGfWQLToso+UhPuTmpkWFXhgL0IvYCiGcXtn9RPpCuskapziO1KCRFR23QfREpDU
         6bTYOdan4Bw9qxcLIAagL39tCOAIVhwYXkD4F32Mox1Vo7exRnZnDtWb21uSYfyy9k85
         OZgAcwJkVmgvtGjpP/2qbtbndtowFT4uweFrGd23bqFT9NE8sXbkWE75Os0az7uH2iPK
         df2zr+O0u9zE4KiYUapC6IhSftxI9iRnIc99yCheJRp+GrsvpURlgSxUXm9HiBBhM5eq
         UQiw==
X-Gm-Message-State: AOJu0Yy+33vw57vQReVnIACCbcMxi71iA9Mvy7p0H6kEDP7OCR4t8cRB
	GF6CltqL2jgpQBqiHoguWXWtLKIWm1TjFpkHKSu4hxDMIAuKCfXgxxck0ws7vfuTw4B0xhDnJUf
	L9oE=
X-Gm-Gg: AR+sD103rbhxhtm8CjyodDcuSSXAYJEUv3U4JoE16ynU7VDsiQrlxUgiEPJ3GcPMdnk
	/fS7zZSltG2j1Hmq4T5wTIAPJtdchZy8lvP98/YTSvEcRUKX6I/xdjxVpbWkrcqN6FPRsMQLMgp
	20XhTADPv6cIm0t3UaHoqilozxdf2HI+ha5OKCztkDKFBNym9vXmuoT8bEMEdju06T6HxN3LzwA
	Ka6lpo9Prw3iR5qLIBMFtW2IO8elgn0nW3RoC+BBmTdPJwERWOA2fi8rxEvXynB81tDnedCvx7g
	/xVz8z1y7WtKxxJIom0JXlFL64cuScH6mflYXSaTvDpEgAwW7cHHCx2oagIeuUmwtHGa/mdttDp
	ZItHCIwz5GxWp1TPMX2PfYJ1uir/g2SeOq6k5deP1umrf97a5Vccdb6yZ+K4/62hD/IUxXgUzBz
	7sQOatLZPvsQNsggRpwbjXqVqDxLZpFwwa5v9NT/wqeIYeBOTrA4f5Dkqcb9LnX7Sl46qy3TAoZ
	RZBGhnJ/bCBKbmCMs2Dr1ZbJoL2K7P08jDWujNjXLLoWZbb53sb0qwQOi4j/fiDeg==
X-Received: by 2002:a17:90b:48c2:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-3933af07e4dmr18029064a91.4.1786960565893;
        Mon, 17 Aug 2026 02:56:05 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d3b4383sm1692047a91.15.2026.08.17.02.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:56:05 -0700 (PDT)
From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: Kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Mon, 17 Aug 2026 17:55:50 +0800
Message-ID: <20260817095550.648774-3-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817095550.648774-1-kaihsin.chung@synaptics.com>
References: <20260817095550.648774-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Synaptics 4384 Bluetooth controller
by adding the corresponding chip IDs.
Verify the change on the VIM3 platform.Verified
that the controller initializes successfully and
that firmware loading and basic Bluetooth operation
work as expected.

Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
---
 drivers/bluetooth/btbcm.c   | 6 +++++-
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 463d59890bef..63c4c788d9c4 100644
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
@@ -514,6 +516,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
+	{ 0x2128, "BCM4384A0"	},	/* 001.001.040 */
+	{ 0x4119, "BCM4384B0"	},	/* 002.001.025 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 9a103db7e355..e70b9f3fd968 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1593,6 +1593,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4349-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
+	{ .compatible = "brcm,bcm4384-bt" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
 	{ },
-- 
2.43.0

