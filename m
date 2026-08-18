Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EC5379C57
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017816; cv=none; b=eefCyWmywuUloCQ48lF46KOtf4OSR6Ug14uZ+1WcTp2WfMglJKnSV35r9sPxRaqVkQd0feKy5YFKacSsvGyre7y4uRHfUub1pqz9xaokcZy6eALYfruaEvkcLMTJTMT3+qtFonZAkaXhwGfFrWAHcxHKDpVhelfmj/HvPVW826o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017816; c=relaxed/simple;
	bh=pLaNn13sddGWIS+ZhZrAJO2CTuekFIIbbmQOGiSs1CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjXYQKWuOVE74Ujs6Sbfmnk9/eR4j9vFumbK/sjl+4i0vfx80ptgVbGllQovNHn4ZkYgFjI/oj+gt3jsfh5/llK3FC1SK3weiNhXNF9MsUERZBYbgNsqxFzSm1++hvpW4KU6EDV2OfRrI4cDeEh+1XKIltPY0Hdrv+xYSV3GrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=aJbhb+sV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="aJbhb+sV"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3137482a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1787017811; x=1787622611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=af8ygkH1KGBuP0hwhu+QkUID7DsTVwf5aUZRxGZy9rc=;
        b=aJbhb+sVjcLFdWMoFCUNurmcz8YwFqSirDHwsshX/XMMqMzVGHG2aOyggjVxBPMUCE
         6UEnm/MIRvMl5+gZD7yWSOrI40yOXtTsUW7vkMHCfjpsqOQGPs+MIzN/iV6CLNY5kFqt
         VCdmq6kH8x0ulXbf5LAIKiN9f6lfBwr0iDvyLrYuG86iI/ipRh4wqC+Na254ELyhROn4
         fXOPRtG63CCSBq0ooXC9Z75kvKX2DC+iP0ubWS3MocqtG2NCSvCX12lYS21xSRy4GOuV
         UXsolB0uG5mhEIdFOU7J8f6fSDUPQBhfBO1Q4h99s2IX9HuPxcPBpuTFRwE21SRXIg72
         qucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787017811; x=1787622611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=af8ygkH1KGBuP0hwhu+QkUID7DsTVwf5aUZRxGZy9rc=;
        b=Q6irvfA1Kg/t8VmnWl3zrxTAt6kDGT52wvJInrwolFjB3ya3YEQkp7UoFCprdWifQT
         pDbNDUkOJtO93SDBttqGdJeI2w/bqCXj4IrfhsoVl9rFakEEbFCNxZ/I+PKKQbslH2QO
         yU9R/gSRGkebGnGGh5Btz12q94aEwqn0B8KzrjajgwixHF3F9KVowYGeo8M8quBv/Z94
         3ELDYPnJoMdqzcG69rssn8xP5NlP1H8RUo6ma7HYTMKeHXxQQQomv4jHJrPkN+zaqbF1
         9YKNXqkpOW8zvjSp0J3kcDQZiYeW3B2UeE719IKt70YMEYzljLmNQfUShIwWagUmUxF/
         bV9w==
X-Gm-Message-State: AOJu0YzzpwSFY1MBftqsFBb3AJr3aaQa3eornyBpeNwT5BaqSAWwx+Gw
	4Du/3Sz+C3Jj4wR0VdMKOcPHmfvNp6w0EZNuxxbrZx8CVL5Wn8myDYLa9cKnlKSLol5ox0rhYlu
	0K4Q=
X-Gm-Gg: AR+sD12aSHc60B9elydx037tCnx55cQyYj5BG8KQBFBZtduEpTQCRSXHGVdO3Uw0p85
	yQGdunYUMhynO1zUa1WKNRZUdloS4VF0iZTK/3TP8YoXU00MD9VB3NAuh3CWMZK8tdI2rcfyMoW
	RMa7rvVdeXbJfWqSI9nozmeyIAGkydCr59O4UnsL0mMM6h0IDKJqrlS6qOO/6dKN396LnvHUlLO
	FS2L1WLNepMrx38IM+fRg2nrKfHcmAODa1zBpHMXZ8nys8lKYwJR9y9peSF/YGxR0HZnXNRPc0F
	HL1joEd3FHOqK+Oi6QE0Re2jLSpIoN02dvUzEIRejRNZkRc4pF1fJDVRCcD+nrWpzV96gUaixiv
	ZxZ/3vvdpaVHkT3cc6v641thvz95dGMZex9R0D1b8ciTUf0DBf/SOwKcMmZ1XohjSdBrpqfiW4i
	9dED17UdaCzP69uUVF1CPwaINtyDeSLJrODEAO7TXqmq1/lQMLWfTgv32GXzEL0pj0PKoKxaarl
	euFZDuJSNtbX1zbbBVSixFVYmbODHBBBQcLZw3FVOTJxdVx4AaR4yOwsCqlwBRcABHwRnnJXcnk
	PBSmLw==
X-Received: by 2002:a17:90b:388d:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-3955a7ebd62mr4312506a91.16.1787017811428;
        Mon, 17 Aug 2026 18:50:11 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e84118sm7364750a91.5.2026.08.17.18.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 18:50:10 -0700 (PDT)
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
Subject: [PATCH v2 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Tue, 18 Aug 2026 09:49:48 +0800
Message-ID: <20260818014948.996739-3-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818014948.996739-1-kaihsin.chung@synaptics.com>
References: <20260818014948.996739-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Synaptics 4384 Bluetooth controller
by adding the corresponding chip IDs.

Tested on the VIM3 platform. Verified that the controller initializes
successfully and that firmware loading and basic Bluetooth operation
work as expected.

The VIM3 is a Khadas single-board computer that I used as the host
platform for testing the BCM4384 Bluetooth controller.

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

