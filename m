Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71E3E639B
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872963; cv=none; b=p5YSt2xL3TmNgUc5rjnq5L3mxdypvwP4nQKjbrTAGPdkbRIkTYT2XueecbCtIAFFh7aVLNxrPIIdr1SrAJFpSjFYA7WhU/82wBvotfhkgzij2p0dLosoC9HDgBXxsmJ0hzmJoGfCbTMDkTkzDR8ZTNk3rFSw6QzyAWn15yhcaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872963; c=relaxed/simple;
	bh=mZbell9oeefD+kmA0lK52fWnCxropHDov+bmSUKtTuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWFQ/tNEHrvP11VXWytjU9SNx9eWTSw9UZFccfD4RGkPeCVWQvlUxgdDHx1/M1yKrNrOqMtRa79+fwCUgS6dEGfLjD4dlW755iKtSOycAHHGEsVncKbaPAamOgD5kmyI59NKhwKmzxXKWigaIQhlbcMh74KfeAcKGEcw1WRehEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=vBEawJrD; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="vBEawJrD"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3664df32e91so13183855a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 02:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1779872960; x=1780477760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOwRvQGChrpZIdqN3+3ZoW+e1ryNG27wl8CiHOr2R1A=;
        b=vBEawJrDjr4RNZmmIHVe+4sxyJwnJ88fijiDL0spW5/i7mouzN46k8seKz8myh8DxT
         L4jRJOWqAM2IdEm9bfHLvtn6bIADUJkY5hpCSRQXtJnwbZy+oi9iV4cTIWTzDl3cqCMs
         XLsd95ziNQr9EvatmhoLesnh14d4aa7HGn5ZsJcuAvKclyoSHt1vVKJqBlGQVkEHw3qW
         vWBqtZp8OpPEUinRh16BImqQt/bsZGfVLewlpFYThHJmlvYaiMVizmmpoWXz8cQygZBV
         w2dkkxQS2OOZBahXX5bGUBH6t3IoCgjozZeUX+ffakpkqEpuS8pbfQ6LuZhtv231bIO0
         3V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872960; x=1780477760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOwRvQGChrpZIdqN3+3ZoW+e1ryNG27wl8CiHOr2R1A=;
        b=PjiaesFHPOtwoYkQuR01bSQ8/QE511o43fFQDlYJz1eKsQ3ywft6aINg6iAoxX6I4t
         eKnTpCtDGK8D3S0f8GsJDaw2t1MJPEiwjzpCkzBQRqsK8kc8S4MznKs3r9LQNpb1oQE5
         cVMl42CmGLufr6QlRLQ4MMN5Oq/FtAlu2pH/iiTPXwTFE656vcYz6vcuTlzgAJdW+tNr
         ssEktYyNjSrpIpW+Q29ALyXabRy2zD5rYozLfFrMlYUoAoE9TQMJfyGBjKbfZT7yBBHG
         Ua5/lFFnijAUsY15iACWXSzhetYsD6iKTucIIz1jv6H8AnJHDLhj4od5k8Uc3Cuhj0G6
         FVHA==
X-Gm-Message-State: AOJu0YwQeLWGyyucmJqyQOyjOKyP2J3DfYD++xGCd5BvxfNslAgR2Fyl
	VNd34X+MGhsTenFGyKfn/OO5EBxw3yNk8H/lSsRe1Hm7xofWXEDAaSqQT2UJytypSptAgcExBS0
	K17F/8A==
X-Gm-Gg: Acq92OHNFaeLXGCpPz4DVPjTReCEc/aGvDBVBor4eBLmeGCZgfHqZqQLwnuborDlS5n
	KE/qjEjjUT14Qmkr+X0jYiBNZ0Yh5/BVTdmidAlWsiQyzKB9b9Pff7+9nA+2Wv6/NKJBBb1b7Vu
	EGIQlhDbST2IcKD4V1IfbwP2VW18SQDVjhNr+fBWuEOmC/ShV+tpxl2IJP4WaRd4YfRnxYYj4mO
	kROJxenO1cn9jpG9nt7BnWkOYVW1UdzZ2QTm4Zh7BF3IsD5RmFjonF0yxuQ92ktMsxdrd3FX8n9
	Ek9njzOHBCbPIHU01hkurqQg56aKh02x6pDCWyAakfFRUXfAgusuaFPGuKFrHTFPBk5FDhOoU81
	sbA/NCR+L15L2jNo/QxM9SLH2fQJAFTgfxM0C6Nu0AVK7RMk5cnOq4H94084X7gN6KA7u7poave
	OvZsI/5X56M17L+lEap9nKWGir1cAx34WyyvNcTCIdIyu7v/ZgPrJY54OzQjm1ER43HXqy1VExL
	4v219ZF915KwhEKBpoBHlstk6BY37izJ+oYZNo=
X-Received: by 2002:a17:903:2bcc:b0:2bd:e5d4:dc63 with SMTP id d9443c01a7336-2beb070343emr252025575ad.26.1779872960628;
        Wed, 27 May 2026 02:09:20 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm92430365ad.2.2026.05.27.02.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:09:20 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v7 2/2] Bluetooth: btbcm: Add Synaptics 4384 chip support
Date: Wed, 27 May 2026 17:08:49 +0800
Message-ID: <20260527090849.3647601-3-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527090849.3647601-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
 <20260527090849.3647601-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Synaptics 4384 Bluetooth controller
by adding the corresponding chip IDs and device tree
matching support.

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

