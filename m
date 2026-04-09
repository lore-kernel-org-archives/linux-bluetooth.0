Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBA2D8382
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698259; cv=none; b=RwU3cLYnoBRXkmCFA7XlE9q73h/ZZv4ydytW0PehXB51y8znijY6XT+Q9IRKUsWuA7BpT4P2aNrKdmaw/wgAVOPHxYifHSmo/fZLBPSVk+CyvTcnj/BmrYUJtqOK2+cOxBCjtXRooBQT5y02GgVaab8wQla4dkM/Xtu+0Y762RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698259; c=relaxed/simple;
	bh=wmgOuJyZ0meJjLBrK9Y9Q/HGuOeC4MJ956/Ye/w9fnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMkXBAFp4D4MV0+bTwXhWBgxT1+nuX87SgE/MWnbDAdtrA6eASQI6efu3b7JfdTE/nSH3Gcaa2Y/2rWHxugcbsUcFrRC19yGFr1zNZ2U6AUNpllfVyI3hZT9mGEWUvh5m2Iu22pPHKRQ6WsZphch6oz80g/CIPT/ga6qco2WUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=p26lVjNw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="p26lVjNw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so454947a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 18:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1775698257; x=1776303057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXZbhramfcxWt6y9i8d1159KMTDu67Hv15gI5/kDd4E=;
        b=p26lVjNwIzNFEXneFKKKoux+uFsQeGoqiyfV3uQ5xI5MgG8CVrYFuqms+y7T3Xycig
         HP716YOxU6jfBwzLOnxY31Y5sowYyi7NGuaxfPCKlUUzL2wxAM1t0mNxi9tH8DK9NTbX
         MGTYr70CvsG3fJFEouCVyR6MsgjAf/FAR6Vh9YWiK/yRLFWIwqKXpIdx604JB3kWYlUO
         OwdONi4gTrJPGoLxyoKzRf6PXwWHiv3Ki0VDyY7k/h2zLiILlD5u7GuZfDLwzivAaZua
         3Q8BMj1LT6HZVnk6Zg7uoDjw4p1lPHubRzApKwgVD3J61H2oZAUepjS6LXnBo3URrL9s
         C8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698257; x=1776303057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXZbhramfcxWt6y9i8d1159KMTDu67Hv15gI5/kDd4E=;
        b=cFZgvMsxbemed9bpsZa3XGrPwGftISRakTJIqzqrd9rX5N6K8MOWDUeC37iX+jgFeT
         cjhyXvPA7dHlcG10Z+t+oHEvG0llW4um1WV+onfgRJMpgRpIVFAb6V0vASWtV+VZwwRN
         4sjbZpQnpz9Q4eM5mGi6aUH+pkq9SZRu6/WByXqneah7txKUXModerQbHdyHTy9IRj32
         4TJfXk9B70vqf5qQwc6jrxoRUbGjS+UmVQ76xWnirYOLDzdJIuCVnqwsdjQitwvKaHnv
         YEnVx4Ffax90QozGc6paKvn83XBF1flC303tS663vXROONjx7eF43awxi60fXQG0alHk
         /lqw==
X-Gm-Message-State: AOJu0Yzl+0L575THX4osDAyiewV55OTm352+8SLB+eLyCahnxnMlqhEx
	cxwlWPCk9DCaTN8ktziBRVo/EIxUNfJL8kMpPfCaHwCBo3VW80MSTzmc/q6rXsvfpO/uOe8po3S
	UVig=
X-Gm-Gg: AeBDieswUJ7xW/aDm6vB3C8LZvukt2CjE39cc564UJmIn6M+GM965/ICfJkpY84VytY
	ar/Am67zAbPeXLs6LubZvyaNijD+d/81MSFkTbub5qfzs9svIpKpJVhs9e+NCW3yml6rytiwBxD
	QdTrCOulvb5w+/kOw0d3GHcfflZr1M2m8l/euCe5Zczk2jh8JVkUmdOReEN8QLDxUmlrJVJ34DN
	4dONLjld2W2uZYO8jdYJRt+TNUrG0BMWjzDiPikHSB4l7Xw81Mqlu+f8ncAYvXhnk4c02fpsZ3j
	eSnLuQixByL3chyEQMSG1OsVSquq6hfuHwVER3LMimiI12rbk7MIDooYGTtzXxSnXfqixlTJ7qh
	9r9zR42Z1tkH4jtaFfwGpeNwCmYfARdyZ113TPhkOIRq47LcaPJpuVQqk7pM2af46/3VVQRT8Id
	HUqy7kMG9EPGAJ9Jwe2VuOj1WlsM0/IF0X1ZWetJ6DjXY2ah+EcHGj9nAKO+M9vkgZgvocHEOOk
	PixsuZG94wgRc5blP5gRr877JI/
X-Received: by 2002:a17:90b:5583:b0:35d:95eb:87a1 with SMTP id 98e67ed59e1d1-35de67daa63mr22714300a91.3.1775698257382;
        Wed, 08 Apr 2026 18:30:57 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34feedc2sm1003855a91.9.2026.04.08.18.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:30:57 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.von.dentz@intel.com,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v3] Bluetooth: Add Synaptics 4384 Chip Support
Date: Thu,  9 Apr 2026 09:30:35 +0800
Message-ID: <20260409013035.1923003-1-kaihsin.chung@synaptics.com>
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
 drivers/bluetooth/btbcm.c   | 2 ++
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index f9a7c790d7e2..21ef875d6aa7 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -515,6 +515,8 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
 	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
+	{ 0x2128, "BCM4384A0_AP6684P" },/* 001.001.040 */
+	{ 0x4119, "BCM4384B0_AP6684PL"},/* 002.001.025 */
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

