Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805378;
	b=iIC0ao6Je2pV9VEWyvWar/143uQeMxzQltE93dEQgWTGVUUaTxGWZPXyMTWcDu4tHxv/
	 gDIq/vaAUYz88GJWwssf/VaEgHmZVFS2NT1xWZLcIKoC4rO5YRsWizh1nY2GvAqalVCuD
	 UjZqRd7wqx7Ow+oBLLeQA3K+f+vFHS2DoPeNr7LKE5WutTAH3arxMU+ET2g3+ZuCcilCq
	 VVRYxwx3TGUGg1icKVRmnI+10DPTa2O2Stn+RTKeWQMhfflfRCGvv3G+aWSMh2P/GUixr
	 j167kRYq7bI0VTMAopDLNwDp8I8BoV67UTdq78/HbIwKBhy1F1CQ/RBXCHIRyXI6qWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805378;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OqDo8ZjWnldpjQLZtviwEAKFTnnvBemRbk1Ky+Mok18=;
	b=Muqj2C1p7AtPVe/O7KQd7EB/K1S45ia7J9Q5fYjdCiZzv6yDwikG5zLUFS5DkEN0qP9t
	 C8svw4EURz1DT/NMG1xSe66uBcBtlfAJ9oS9Y5Z9FPfVm42nBSOcjMJs6xJRr6CR03Zgf
	 8f+XwSHZp3GbrYPZeFq/zRkX6a2nmgG46oiu+6Akr/3tr8wWEK8d5Jh3hmfyRd6gcJCqY
	 9Y902tITHVAZjRajgg8AZsSxN8HP97nUGxNMOiqZxuTgoW0kKiYKEqhk/fDEVAk1dPFQE
	 sbah1Wswm0vIu0ZA12HkRWRJKtxZPdVXpBhUKqxzlAB5kAfgWBgYNjGR/CcZkuxO1dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=ebBIYhlM;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA3606D833;
	Wed,  4 Nov 2026 15:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DAA3606D833
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=ebBIYhlM
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793805376;
	bh=JfQzV030AVQ0gGFAqN90Ocdak/ZrdoDwpXmDpK8ZLe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebBIYhlMVX8RH7xQ6B++3qwd5Lv5lPTWN8GoEJOK4SqgVgb3H6FK2eOH04V+qeMob
	 eJMG7K7RHrV9qvaDSkVwHEwnwJxVN0DYMWnbsRarCzoqyDI9OWT3ny3VpixW3l+6Zq
	 kOm0dztD0n1UO+vu2xXOMFfRCSQmoh/aiDRW5iX3ffbCZFIIeTux7f/SOFsTr9kvxG
	 5/Z1Kvr+sJzPgzyZCaiQq+KMKcvCYHMmXY5QNv++Qcu+6XKr3e3J8sDgVyDYxxR8+c
	 IDgyOL/JXne/SsqdOgSeUC5vc/Hz4br51u8XxVVCTpj9Lh54ENj2bm1UShojJ6rbpS
	 exvvHQ2iDJI3w==
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	66ton99@gmail.com,
	josemiguelo.ochoa@gmail.com,
	aditya.garg@linux.dev,
	Andre Eikmeyer <dev@deq.rocks>,
	Yossef Osman <Yossef.Osman@proton.me>
Subject: [PATCH 4/4] Bluetooth: set the strict duplicate filter quirk on Apple Broadcom controllers
Date: Wed,  4 Nov 2026 16:16:01 +0100
Message-ID: <20261104151601.70493-5-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104151601.70493-1-dev@deq.rocks>
References: <20261104151601.70493-1-dev@deq.rocks>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btbcm_finalize() sets HCI_QUIRK_STRICT_DUPLICATE_FILTER, but bcm_setup()
returns before it when no patch file was loaded. The MacBookPro15,1 has
none for its BCM4364B0 ("BCM: firmware Patch file not found").
hci_bcm4377 does not use btbcm_finalize() and never sets the quirk. A
service discovery then scans with "Filter duplicates: Enabled", and the
controller reports an address once per discovery cycle of about 10.7 s.
A Mac that changed its advertisement data on the same address was
reported 6 s after the change, at the next cycle.

Set the quirk in hci_bcm on that path and in hci_bcm4377.

Tested-by: Yossef Osman <Yossef.Osman@proton.me>
Tested-by: Aditya Garg <aditya.garg@linux.dev>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/bluetooth/hci_bcm.c     | 5 ++++-
 drivers/bluetooth/hci_bcm4377.c | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1ae9619ee1e..ee077c8502d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -597,8 +597,11 @@ static int bcm_setup(struct hci_uart *hu)
 	if (err)
 		return err;
 
-	if (!fw_load_done)
+	if (!fw_load_done) {
+		/* btbcm_finalize() sets this after loading a patch file */
+		hci_set_quirk(hu->hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER);
 		return 0;
+	}
 
 	/* Init speed if any */
 	if (bcm->dev && bcm->dev->init_speed)
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 8d99a7a8f76..7105372898d 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2392,6 +2392,11 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hdev->set_bdaddr = bcm4377_hci_set_bdaddr;
 	hdev->setup = bcm4377_hci_setup;
 
+	/* The controller reports an address once per scan with duplicate
+	 * filtering, also after its advertisement data changed.
+	 */
+	hci_set_quirk(hdev, HCI_QUIRK_STRICT_DUPLICATE_FILTER);
+
 	if (bcm4377->hw->broken_mws_transport_config)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG);
 	if (bcm4377->hw->broken_ext_scan)
