Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA62146588
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638831; cv=none; b=Giow52YmJRTz1KEPVk+hKga3k+aqDkQ3S64iXPvKMJlKGRHqDCVlHoqTGHWYh8ZnpOOwGt/zfTotxhh2tCx2Q6DZXiHg//65C8kesjGjmO/7vB4pXo6mZRnhcZYtMykoL50xnZ7gDv+xqW6KYaFQdPjmDOtwtQuAgEe79K1z0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638831; c=relaxed/simple;
	bh=s9x+FaGtAR06UzzIFNMfi9bExAx+t9IQ8+62SWFE8bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shBilrUts1Cf1w3NZAnQJiHnLup2Ysxad7/lveq++T5jYQO7WfwEPzegNEjX3jA2VrOQ/0W/2Ub1b++rpRtNEhvtIagyazNpn59V0yG5ngojzkqgjBHoLfLqihXB8ncUZ5oMvsnD39/VKHSkPn3Q1b9/Le95m+ertussvj4nagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=j5iewXvH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="j5iewXvH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so2832180a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1778638829; x=1779243629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNAPdBxKfvXRoDeOFlzj+gKOkQz0tluYNiGBWcnpS4g=;
        b=j5iewXvH3XW8p6uwZMr9BplTfsJZyzk7mFGP6y/puWYvu99P6nCD4Yt7NbNd26rTv7
         yNHHEsvp8XcrhP/033cwWbiYlbjhvn1JD5ZCNUZgneFy0CqFN6hM2cDjTF/7z6zzLTkJ
         YvI4qW4KVo5hcTJ6aRQ0kYWmuaKjg7Ww2PVNzrbMrlAnkTugQr1ht1RdrM2WmG1O0lyi
         +a6iTgnV/7alYGy5n5rHfvuTKMIeECkxrSfeN2/cujjMfuTzkT9o5JfIth6ho/ERBb+i
         T3NB5d/lscQVrh9rd6XdzsqXAu17nF8/n9BnqfTXm/WO55aB9gP3wtBq30kW0GYlZutB
         30mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778638829; x=1779243629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNAPdBxKfvXRoDeOFlzj+gKOkQz0tluYNiGBWcnpS4g=;
        b=qvECA9fDMmeMJ3Zba3x4WYuDzmo/mVchRHsgtRVKVqQGEQt391z3rg3OQFH1Ns4jPu
         VndV9FUo1JXjt+oFEBV1QuKL1wIAFlGWwKSsWtQLj5czkLgsqqRxVCzIc98r5BRwfKyV
         7349Wl68W+/JyUL3LXEb3UJvTT0/UiSL53IQf3BDU1owpMcgKeIJfxHr56LVb81cUQJp
         wYYjwRGK/FFiZEeN954xhxRv75iCiMNGZsvg2ETV5nN4aRieSAcPL+ngShixpb6DEYq5
         AG6l39vjKOumUozsVObrF2CpJDGbXnPRnmBg8o5l5OfheGBFTCUKdSn5Z381EtXlcH80
         DjcA==
X-Gm-Message-State: AOJu0YyA2XEb2gFCdppkU0rGSuY3AwlbS2xI+tmX57qXrpkYHc3RWifB
	4Xi84szJogR5K3hO5ZTQXqCol4ZFDUPUKFEmIQbfFkAqxlATJomPiJrfeDscWAvB/xt6jo8xXyY
	uZgi+LQ==
X-Gm-Gg: Acq92OFz55NgS9T26lPndSytlCErEb2IVhkB6XsjIbrsL7j0PKiE6dBshFGNNU95Hrs
	wNiWAESDfY00nlihEib166LzDhFPUzn7eDRzlxzhvglDQ1GMTek8rC9AQs6FWRZWQvmSodMyUud
	iKt502ZxH9f7iiLmb14uInMqA82ptHmJ67ysdWOZ61tuY45ibJxnRuF+4hlr3rNo/edkqZqdJxe
	YmmOaxm0jUvgsbAvoRjlkhRPcFRg4247GY/CxEoWBkUHmW9A3C/PObncSmgKT0t55nZOnMpisQ6
	Oiep1cWBzbwiN5qT42ZVJQXjsJJLaUMl0LShe3677tXF077Y9vccug86fJqtqfZTEDM5jo5lxXq
	QYyeYsFk3aIDYQFrXuYxcKTLMwe492aHILqUazg90eKUkzrY3NJNoUaAlYjczhMQ60Re3MwzkRo
	RL6o7NKoe0KGip0O3Pb71bp9KvlKWw/RlNoo6Hco8cH9ZXdzy4mJwMztxvK1mU5oLje5RN+DNv3
	hO1XaCSJN3HbkrZBOJVQ5M42ksW
X-Received: by 2002:a17:90b:3847:b0:368:1566:1ba5 with SMTP id 98e67ed59e1d1-368f3a94d3bmr1560408a91.7.1778638828759;
        Tue, 12 May 2026 19:20:28 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368edf9b543sm1248487a91.16.2026.05.12.19.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 19:20:28 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.von.dentz@intel.com,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v4] Bluetooth: Add Synaptics 4384 Chip Support
Date: Wed, 13 May 2026 10:20:08 +0800
Message-ID: <20260513022008.3238060-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaihsin Chung <kaihsin.chung@synaptics.com>

Add BCM4384A0 and BCM4384B0 identifiers to the Broadcom Bluetooth
subversion table and add device tree matching for brcm,bcm4384-bt.

Signed-off-by: kaihsin Chung <kaihsin.chung@synaptics.com>
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

