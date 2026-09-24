Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78C4503E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250813; cv=none; b=QWvu+hwegEVj6imeYacsESuFqA9UOVSltiQSqkl+U4gpH3KjX7EKOmxANkh/iTqnYVafrmG/hfIW+rQTfEgDTkV7Gk9DFeYn/JOWwrd0noNTCONtTboK7Tm6eB4WOf8uSKWiFqcVllVYisWizNiUDFPby6TnoV2DIPvRKPslG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250813; c=relaxed/simple;
	bh=RZ2ueiZmuXAjA+9pBuGtmURS2Ox3cmUGORO0ZPacFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSM2Saw51ucv95ZGE/b2tv7ivnJdE/3tZ2UW9ZfmjFgT8Yd0pSRS04O2V5sdEHRGCu03OxqDepcxhm/fAD/Y6I8FaPSrqRx6M/5umIE6v+H41kr5xXwZvSThPdS+B4DdHowAw+GICS7RuGL9RxCesPPjVoTULnDEFHF5zqtye7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeffTZDE; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeffTZDE"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48434392b02so1488728f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790250810; x=1790855610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoCNZki4mLCOXFp4ND3ktutmcdSz2Nv/njaEWHHDgw8=;
        b=XeffTZDEJgGDSYXEeqpvLBnfr0fcNV588PqnHp4dbZwBSP8/pa3iqOx2JetXeeWlni
         TDf0FJyj2V/WBSAELUHk+8D0vPwn8pd86AHtCvzu6mtLJpcbHKdKInGyHb/uB26athkC
         kymEmurJIe1vWLjcyynA0T4rEHINHR9ZNtqwQjEPJfD/wGsnqE7gawXaqvo04FRu0Tc6
         kLcJ7ZojGdTzqKfzsC2OLnmS0lrbLSe3jzsgLipeOtdlkyMNjp6Jabx79apculQJqZC/
         pbMl2aqDf2qq3cBBVhigRLNFrNWJTyzU1Uulk8fDdibBlBymVI/Zttbfty7woYbDdUwZ
         CJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790250810; x=1790855610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HoCNZki4mLCOXFp4ND3ktutmcdSz2Nv/njaEWHHDgw8=;
        b=EXtxz97rNMEjGu3KjYxkwDwXhGMExSqNOX87eoROZgFOeFM6d/2yq4ylK1HTTqlMzX
         e7ZrVP3iQLWvTOOgQpPTD4Y9RLQb8vfJk2cgrLOaau6Sx6zxt19yNmeuYbuMgs3RrMNL
         UAaopZwE9q4BBv16K0VgtzSqM/wdAliPQoxKwvzdCpfwVe/HEaOq0M38p2zqvPbbFkje
         bjdPCPr/OPkJqnUxHx47UmiRLc3Rd51UIC9PuTHkErnzRskG/yUJx2RN6Pq1EaXmr/Ds
         ADCH9YQOOiXDgreMY3lqm20V7sVbayWvQr0kLRGS/lZ8zjtJhyBrYurINHi7duL/OZ1L
         yVWQ==
X-Gm-Message-State: AFuF++k8o/34E4rLZBXk/kJV2hMBehslQKR6wwS8/m1n4Ud9WjoW26yQ
	ks4fZFxi4LCC0PsLaVUXN5CHKKtyPdzFhLJJm2mIr35+NBDQJVPsXiisxeqfNmqd
X-Gm-Gg: AYBFou0TxxaDwQ3YtdK8b79yHK4cSAnjnJfikitc1nnJXRFXCQt7IGIBIIJd87GU4ij
	b9R/YYaog0bJgovMJviY30p/SsWd6Q6/eAmu9WgSsywZVgpjgvGheu1iopLjNUg6iED6F8ofuCM
	es8XcsyRA4Z/4LZwzlpn4kfNx7qUckeySRCNfpYkBL1sGj3n892QirZ42GogRcx52eHxp+LAVsE
	qSF4y1a/o6JyGcFe4wiTUTbBMyLhGWlJtJQoy5lHaUBx4BvixNBMA/gWURI1sUmeAmedHluMtBR
	ByCNkPM1hVt20i25x0NSYKcbmnHZRiiSfY/Lh5t5rSztLa4PA9qNddCectyLSTIe9AP0sfVD3Vc
	HVcgQk3HYgFjIRzDTmsPg9pE3DTilTXXOetd/mOw63RyepDJfAG9D9byELdgu4pLB7w/UPm4WA4
	NKN7FSpkTrhiNAfRfXk+dlSLFgQyR7cbmVSEd8QlaQVy/PswnF3creGH3PjU4cfHdl3ABj0W3vo
	qicMSZfeadrlUmNZiQ8y+LyOJi9VdwT3u/+e311yUbGWhM4Qc4qsNLIG5Pa0Rhs5HKuB0Y3tWoV
	lMgsUB3RPYWdkpM=
X-Received: by 2002:a05:6000:1886:b0:486:e8fa:f9b7 with SMTP id ffacd0b85a97d-488716c12f0mr3894515f8f.13.1790250809631;
        Thu, 24 Sep 2026 04:53:29 -0700 (PDT)
Received: from computer (ptr-178-51-241-237.dyn.orange.be. [178.51.241.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868886e45sm14413282f8f.31.2026.09.24.04.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:53:29 -0700 (PDT)
From: Kenzi Voyer <kenzivoyer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com
Subject: [PATCH] Bluetooth: btusb: Add USB ID 13d3:3631 for MediaTek MT7925
Date: Thu, 24 Sep 2026 13:53:28 +0200
Message-ID: <20260924115328.15987-1-kenzivoyer@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Mercusys (TP-Link) MA37BE Wi-Fi/Bluetooth adapter uses a MediaTek
MT7925 chip whose Bluetooth part enumerates as USB ID 13d3:3631.
This ID is not present in the btusb device table, so the interfaces
bind without MediaTek driver data and HCI initialization fails with:

    Bluetooth: hci0: Opcode 0x0c03 failed: -16

leaving no usable Bluetooth controller. Adding the ID to the MT7925
section of the table makes the driver run the MediaTek setup path
(firmware load) and the adapter works normally afterwards.

Signed-off-by: Kenzi Voyer <kenzivoyer@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index dc7191bf4..68396d553 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -831,6 +831,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3630), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3631), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2c7c, 0x7009), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-- 
2.55.0

