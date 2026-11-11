Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398584;
	b=W67IaHdqqHI9MlB+Vy53KybqMS4bG5kTZgslRDbz9qXM4t2YAtUU7oQDrC7K5LQ/z06F
	 iVR2PltRPxIb23a6IIhhwqRh3MvLbcAQ96ax4+M46MBS5Omz/723lVd5M6H9f84tPsIgP
	 AVMN6J/7y3CmhxOWwVWPKEH+thIdwmyxDrYqdwGeFosfC3h6owRlOkTi5rg20qj0STdbJ
	 6k3uZiK5mYNoqTwkZYy/ZXdyTa8nvEUEcZuE9V3iERNR7ZaZhIPwYVr+U0heDxSrtsBi9
	 p7DVwS6tev0fSrpcUVYNbe4z1cDRpWf6vmXm7m0jxKqeSJ/PFIVzaDjEjiHvYmKh/Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398584;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=an9CjgF3i7R41tdwZTyFePnX12f5lARONWktj1nVWlA=;
	b=ieqSFjH/kuCxmr3hvhL5zctc2QhvvQupNTvGn+hguH1sRLfRd2F6DqUKqjXe/3WtJcIP
	 2qjkXjzNz8Ps605i6gKCXzexnj2XVqjDjbda6xDpr542AZbRp3dNhHhZqj9+3VJeXhiD9
	 lXnAvqgrxNHHBLCD4ckpL+CzpyELlMBbcoL8Dl+D5KndhyhKqKPqiJFfNXQd3g19sISbU
	 NfAQxBf+A6+LUqVIOXwh+iDYtTspibqyeL1S/BNRmOGhJsWWw0TNyyamv4PEo7IZcAQec
	 qQAqLGhPS6gOxTy89u7hqokUj/PynipVc4kVdHqI4y+FbFcxXmHfpk+5zx+JLCw0y0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=B2CExKMR;
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1D606B607;
	Wed, 11 Nov 2026 12:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17C1D606B607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=B2CExKMR
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1794398579;
	bh=ZWZcKQnR07HF50YgzRPWJA+uhegvXnEEGjk8F3xSpu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2CExKMRncpTl3ifbkQVmUZkHdLLipQDeBCVYV2ApQE75IuFKP1uIPi0I00B6Stwb
	 LrDmb6OOWkvkseC+qJx3Wjf3TC0R/QOi3GzHBIReV4tbV30P/53MaTbWV3vZ46k3mT
	 dO8omGlmOFccUYpctzvXpG5PPtVKxXEsF3MQ1jNu538G8u1unDjQ0Wqx270NVV3ofH
	 tspUnzxdE1TBqAgTCi+Ofu+Dp63U7WOe9Wa3F+NqEcw1BR0dmzQb/nK85FW1EGYe2u
	 IKNi36e35DtTcAaqGb+aVoVKKTDQ89Myy5bMTusN2/O6BfWeGQQlGUvEgo1w3Ty1Nz
	 RMeSiR9tmxNbQ==
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
Subject: [PATCH v2 3/3] Bluetooth: hci_bcm4377: keep ASPM off only while the firmware boots
Date: Wed, 11 Nov 2026 13:02:48 +0100
Message-ID: <20261111120248.21062-4-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111120248.21062-1-dev@deq.rocks>
References: <20261111120248.21062-1-dev@deq.rocks>
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

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/bluetooth/hci_bcm4377.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 4e3630774c0..0d2103cfd9b 100644
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
