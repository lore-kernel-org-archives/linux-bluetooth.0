Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785921;
	b=OxXaF0fBaeJpTb5szJy9vd9CerfZ5B0hTT65oiKCmXb9+1cKNDIbM8aiM3CTACKExJLe
	 vhiv0zRO286D7jYYF+D/mO6kZQTWL9zhyy6kn7v+APHZBi0YBksv5eFWx3GGnJTXcrPHo
	 8CiX1PDx0fOOOE6kkiB2Sd0Kc5LhV/o/sHagFYNfBUKS7JmBQVe3D1z9whAMXB5ZKqtLD
	 fpFE3r9Mi42S3/hYBaV71BEc2/C23sK64S2HoioVJfuVB+tfszXjldFvQkWYengQemF7j
	 Bs7nU9de+1+pP8tuG8/KtICCZAkxJObJUWfJ/J0M9I4XrF+TnNUqnEmQBsVmGn60u2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785921;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nJ7i/lV5fWkejYj/nHVOUDs2jnq1DfOwLwLLwe6GDAw=;
	b=eqjFqAQ6aO4X/4GlCX5KIoXTWfKX6G5qg7Fq6KRR63PIeow4uXXa4TPCuQmqp62yViah
	 T+IBjcw4/AjyvN+fsl5GJ6bafKTdCsnPa57HgTkGjlstdWyGGeq8e0Y0s9taFd7PoGlkk
	 fmFEOYp6T9dDoMqTpX8PvVFPY9lNg+/6RJBSq+T0g3U3NPu3kSI/X7ZJ8tb5h81UzpKAn
	 h7Na9mW6gZJTB6Xj/t2FrRiefefZN2NbbUz42dl1KhI9vK3f9xj82XwInk8apKzit8LI+
	 L3K/BSM2JdZQuVB+l3hdQezrNeY06yV0zzrji4yLlN4ZN7ugn7XAp3RFu2kbk66U5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=ZldzcSjK;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66D606A335;
	Fri, 27 Nov 2026 13:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F66D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=ZldzcSjK
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1795785912;
	bh=J4K17xM/lvKD8rJFt9ZzUQWYOZ+o9QZB0HamYWyWF2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZldzcSjKfDM3c0ybDoLIlhTWFdL9l565UpnGysEb906GfuBYiBBt/UuDZdnmLy2Fs
	 asH/XV9NrMQw2qSud2vUVF/qOVwWG4gjOPoJgGWc4s9Be1xdouEzRAinw2VlSO5War
	 HhrfBCGgXj3ZNBEJhDvDrnMw5k1eXC0C9K5l2owwZCUDirMmg3G99ti8BjmA8bBzKY
	 +XLAh6rfeIab6hKkCvs849jobnn3t51BLA1MjV2aUY2J9x7o+1v0LBw+KwEzYF5Nfu
	 7B6ESpa960kXof1gQ6JmedogTCkkMODhWqX4tlX2pMBMQNrxmxhAfmwUjEML6EzVef
	 wqi1R1KEjhq5w==
To: sven@kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v3 3/3] Bluetooth: hci_bcm4377: keep ASPM off only while the firmware boots
Date: Fri, 27 Nov 2026 14:25:01 +0100
Message-ID: <20261127132501.262651-4-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127132501.262651-1-dev@deq.rocks>
References: <20261127132501.262651-1-dev@deq.rocks>
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

The BCM4377 needs ASPM disabled because of a hardware erratum, and the
driver disables it on the whole link for as long as the device is bound.
On the MacBookAir9,1 this keeps the link to the Wi-Fi and Bluetooth chip
in L0, and the package does not go deeper than PC3.

Disable ASPM only in this function's Link Control register before the
function level reset and the firmware boot, and restore the saved value
once the firmware runs. A non-ARI Multi-Function Device enables only the
ASPM states enabled in all of its functions, so the link stays in L0
until then.

Tested on a MacBookAir9,1: with ASPM L1 enabled by the PCI core the link
returns to L1 after probe and after the re-probe that follows ACPI S3,
Bluetooth and Wi-Fi keep working, and the package reaches PC8 instead of
PC3 at idle.

Acked-by: Sven Peter <sven@kernel.org>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/bluetooth/hci_bcm4377.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index f1beb09c9f5..fc1164a470c 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -497,7 +497,8 @@ struct bcm4377_data;
  * clear_pciecfg_subsystem_ctrl_bit19: Set to true if bit 19 in the
  *                                     vendor-specific subsystem control
  *                                     register has to be cleared
- * disable_aspm: Set to true if ASPM must be disabled due to hardware errata
+ * disable_aspm: Set to true if ASPM must be disabled while the firmware is
+ *               loaded and booted due to hardware errata
  * broken_ext_scan: Set to true if the chip erroneously claims to support
  *                  extended scanning
  * broken_mws_transport_config: Set to true if the chip erroneously claims to
@@ -572,6 +573,9 @@ struct bcm4377_data {
 	/* set when the controller lost its firmware during system sleep */
 	bool fw_lost;
 
+	/* Link Control value saved while ASPM is disabled for the boot */
+	u16 link_ctl;
+
 	void __iomem *bar0;
 	void __iomem *bar2;
 
@@ -2260,20 +2264,27 @@ static int bcm4377_probe_of(struct bcm4377_data *bcm4377)
 	return 0;
 }
 
+/*
+ * ASPM is disabled in this function's Link Control register only. A
+ * non-ARI Multi-Function Device enables only the ASPM states enabled in
+ * all of its functions, so the link stays in L0 until it is restored.
+ */
 static void bcm4377_disable_aspm(struct bcm4377_data *bcm4377)
 {
-	pci_disable_link_state(bcm4377->pdev,
-			       PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
-
-	/*
-	 * pci_disable_link_state can fail if either CONFIG_PCIEASPM is disabled
-	 * or if the BIOS hasn't handed over control to us. We must *always*
-	 * disable ASPM for this device due to hardware errata though.
-	 */
+	pcie_capability_read_word(bcm4377->pdev, PCI_EXP_LNKCTL,
+				  &bcm4377->link_ctl);
 	pcie_capability_clear_word(bcm4377->pdev, PCI_EXP_LNKCTL,
 				   PCI_EXP_LNKCTL_ASPMC);
 }
 
+static void bcm4377_restore_aspm(struct bcm4377_data *bcm4377)
+{
+	pcie_capability_clear_and_set_word(bcm4377->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   bcm4377->link_ctl &
+					   PCI_EXP_LNKCTL_ASPMC);
+}
+
 static void bcm4377_pci_free_irq_vectors(void *data)
 {
 	pci_free_irq_vectors(data);
@@ -2425,6 +2436,9 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
+	if (bcm4377->hw->disable_aspm)
+		bcm4377_restore_aspm(bcm4377);
+
 	ret = hci_register_dev(hdev);
 	if (ret < 0)
 		return ret;
