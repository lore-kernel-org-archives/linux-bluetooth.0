Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC328EA;
	Wed, 22 May 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341327; cv=none; b=Df/IDMaHaR2zaVRKhmjWEV14cERvbjeyT2HQ7R8MKJlmZdwzvAYrMgNkEmxvRInTpk777MIHzlyfAhpNyzX24lExAVsaXLG9mI9Kjeo2N2b1ttyTbdaQl2SVZdzw+eW7P6scEBkiLbVzeJDa0csxYAHQD3MlKKmSVk7smosN2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341327; c=relaxed/simple;
	bh=x2OX+yVenw6qmbZS4My6MkduStfU5KCOgXfHggeJ+u0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V7y9OJYm0XorYaDZj5SR4m3Fz3CoWQSElpiOfXu8TeadlvwtMrkyXIOITxY9DM4uZfoNoWVZ98kNNvWZiEkTelCZDNiJpltVbn15xArxlhrZBMeuDk9DjJ+T4mQBH2eMe3o5kDpscQiiu+LCvSO07e0QcvZH4rMPKAfpfbLCRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=jILIC/mv; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="jILIC/mv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1716341326; x=1747877326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x2OX+yVenw6qmbZS4My6MkduStfU5KCOgXfHggeJ+u0=;
  b=jILIC/mvXBLNeXT3PPk58BK8HRNH8GBK9MwvQzaqLb8DNen+esbzK6hc
   6gAqDuOJDkWyNE0Wg3Nhoq9kSDpvG+JQD6EM/0vM9EhJTb1mxea8wRptH
   DNEDFHmUDjPiS2HGHiaFg7f0c9ALsbtQ0zxzn2fDyjPp5L8SsNtupGSGy
   s=;
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="19653651"
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="19653651"
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 03:28:38 +0200
Received: from MUCSE832.infineon.com (172.23.7.104) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 May
 2024 03:28:38 +0200
Received: from icw-osk-deskmini.osa.infineon.com (10.161.6.196) by
 MUCSE832.infineon.com (172.23.7.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 May 2024 03:28:35 +0200
From: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Nobuaki Tsunashima" <Nobuaki.Tsunashima@infineon.com>
Subject: [PATCH v3] Bluetooth: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Date: Wed, 22 May 2024 17:17:35 +0900
Message-ID: <20240522081735.469503-1-nobuaki.tsunashima@infineon.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE824.infineon.com (172.23.29.55) To
 MUCSE832.infineon.com (172.23.7.104)

From: Nobuaki Tsunashima <Nobuaki.Tsunashima@infineon.com>

CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command
as supported in a response of Read_Local_Supported_Command command but
rejects the LE_Read_Transmit_Power command with "Unknown HCI Command"
status. Due to the issue, Bluetooth driver of 5.15 and later kernel fails
to hci up.

Especially in USB i/f case, it would be difficult to download patch FW that
includes Its fix unless hci is up.

The patch forces the driver to skip LE_Read_Transmit_Power Command when it
detects CYW4373 with ROM FW build.

Signed-off-by: Nobuaki Tsunashima <Nobuaki.Tsunashima@infineon.com>
---
V2 -> V3: Fix a few coding style warnings and change the subject as more specific.
V1 -> V2: Fix several coding style warnings.

 drivers/bluetooth/btbcm.c | 32 +++++++++++++++++++++++++++++++-
 drivers/bluetooth/btusb.c |  4 ++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0a5445ac5e1b..c763e368d6ad 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -437,18 +437,48 @@ static const struct dmi_system_id disable_broken_read_transmit_power[] = {
 	{ }
 };
 
+struct bcm_chip_version_table {
+	u8	chip_id;
+	u16 baseline;
+};
+#define BCM_ROMFW_BASELINE_NUM	0xFFFF
+static const struct bcm_chip_version_table disable_broken_read_transmit_power_by_chip_ver[] = {
+	{0x87, BCM_ROMFW_BASELINE_NUM}		/* CYW4373/4373E */
+};
+static bool btbcm_is_disable_broken_read_tx_power_by_chip_ver(u8 chip_id, u16 baseline)
+{
+	int i;
+	int table_size = ARRAY_SIZE(disable_broken_read_transmit_power_by_chip_ver);
+	const struct bcm_chip_version_table *entry =
+						&disable_broken_read_transmit_power_by_chip_ver[0];
+
+	for (i = 0 ; i < table_size ; i++, entry++)	{
+		if ((chip_id == entry->chip_id) && (baseline == entry->baseline))
+			return true;
+	}
+
+	return false;
+}
+
 static int btbcm_read_info(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	u8 chip_id;
+	u16 baseline;
 
 	/* Read Verbose Config Version Info */
 	skb = btbcm_read_verbose_config(hdev);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
-
+	chip_id = skb->data[1];
+	baseline = skb->data[3] | (skb->data[4] << 8);
 	bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
 	kfree_skb(skb);
 
+	/* Check Chip ID and disable broken Read LE Min/Max Tx Power */
+	if (btbcm_is_disable_broken_read_tx_power_by_chip_ver(chip_id, baseline))
+		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+
 	return 0;
 }
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d31edad7a056..52561c8d8828 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -142,6 +142,10 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x04ca, 0xff, 0x01, 0x01),
 	  .driver_info = BTUSB_BCM_PATCHRAM },
 
+	/* Cypress devices with vendor specific id */
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x04b4, 0xff, 0x01, 0x01),
+	  .driver_info = BTUSB_BCM_PATCHRAM },
+
 	/* Broadcom devices with vendor specific id */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
 	  .driver_info = BTUSB_BCM_PATCHRAM },
-- 
2.25.1

