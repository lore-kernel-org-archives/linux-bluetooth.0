Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B913D516;
	Mon, 26 Aug 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661793; cv=none; b=MePIHD/u9pXiuH1VLaYey4S7FBO9EiIDUqyne9mqtBxGbermYh9wXe+2y7BkH6G9mcEUBbwcu0xfs1ho1/OArw2HoGi9bH4s1073/amaNfevMxauGcZG18FQyZVzAj20EDjkYXQf//h8kmEbS8gsgaoSRkh2P+p/glnLR5YkPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661793; c=relaxed/simple;
	bh=T4nlKPYILTaeeaP8x/8TspIg9b2lQOJQG7zl6YPpuN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AKdUIeDW/N58S83jT4S40rTX6NpfpPMiw640Pol3HqVOopqIWfI6DwM/AzkGDAaA/cfNL27iByLUrj62vnq8qZNgmIiRxquo4t0B3joZrKkhCgq+uptow9Uge7uCaYV6gRwyywdMHmeANqGEVTkXW3TnEB/nTae3g4pxGU72R8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=dnUBtpCI; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="dnUBtpCI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1724661791; x=1756197791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T4nlKPYILTaeeaP8x/8TspIg9b2lQOJQG7zl6YPpuN4=;
  b=dnUBtpCIrlliNt96207dokKSOIqF+b6lYC44qBKTGppMOshXZ40WKkqf
   kBr3MDfbbTWNn0esI5tJo76euqdeb5I7pPvn6d5XhkqEsW6B7ygFTW2zy
   3q4jDr3B7YzRkPEtcYxDCxZMpR7JC/bGbC1NMMA1FUsQUMW+DwcGkcu83
   c=;
X-CSE-ConnectionGUID: 5vr0WjKnQ7SJ1gQG7OGhhg==
X-CSE-MsgGUID: xgNVd0GgQAyn51RzYaczUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="27903999"
X-IronPort-AV: E=Sophos;i="6.10,177,1719871200"; 
   d="scan'208";a="27903999"
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:41:59 +0200
Received: from MUCSE832.infineon.com (172.23.7.104) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 26 Aug
 2024 10:41:58 +0200
Received: from ISCN5CG3203WLP.infineon.com (10.161.6.196) by
 MUCSE832.infineon.com (172.23.7.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 26 Aug 2024 10:41:56 +0200
From: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Nobuaki Tsunashima" <Nobuaki.Tsunashima@infineon.com>
Subject: [PATCH v6] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Date: Mon, 26 Aug 2024 17:41:37 +0900
Message-ID: <20240826084137.86671-1-nobuaki.tsunashima@infineon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE805.infineon.com (172.23.29.31) To
 MUCSE832.infineon.com (172.23.7.104)

From: Nobuaki Tsunashima <Nobuaki.Tsunashima@infineon.com>

CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command
as supported in a response of Read_Local_Supported_Command command but
rejects the LE_Read_Transmit_Power command with "Unknown HCI Command"
status. Because Bluetooth driver of kernel 5.11 added sending the
LE_Read_Transmit_Power command in initialize phase, hci up fails due to the
issue.

Especially in USB i/f case, it would be difficult to download patch FW that
includes its fix unless hci is up.

The driver already contains infrastructure to apply the quirk for the
issue, but currently it only supports DMI based matching. Add support to
match by chip id and baseline FW version to detect CYW4373 ROM FW build
in generic system.

Fixes: 7c395ea521e6 ("Bluetooth: Query LE tx power on startup")
Signed-off-by: Nobuaki Tsunashima <Nobuaki.Tsunashima@infineon.com>
---
V5 -> V6: Change two table names as simpler.
V4 -> V5: Use skb_pull_data() to access skb->data as safer manner.
V3 -> V4: Fix a few coding style warnings and refine comments for clarify.
V2 -> V3: Fix a few coding style warnings and change the subject as more specific.
V1 -> V2: Fix several coding style warnings.

 drivers/bluetooth/btbcm.c | 45 +++++++++++++++++++++++++++++++++++----
 drivers/bluetooth/btusb.c |  4 ++++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0a5445ac5e1b..154e5f4a26a8 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -391,7 +391,7 @@ static struct sk_buff *btbcm_read_usb_product(struct hci_dev *hdev)
 	return skb;
 }
 
-static const struct dmi_system_id disable_broken_read_transmit_power[] = {
+static const struct dmi_system_id broken_read_tx_power_dmi[] = {
 	{
 		 .matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Apple Inc."),
@@ -437,16 +437,53 @@ static const struct dmi_system_id disable_broken_read_transmit_power[] = {
 	{ }
 };
 
+struct bcm_chip_version_table {
+	u8 chip_id;			/* Chip ID */
+	u16 baseline;		/* Baseline version of patch FW */
+};
+#define BCM_ROMFW_BASELINE_NUM	0xFFFF
+static const struct bcm_chip_version_table broken_read_tx_power_chip_ver[] = {
+	{ 0x87, BCM_ROMFW_BASELINE_NUM }		/* CYW4373/4373E */
+};
+static bool btbcm_is_disable_broken_read_tx_power_by_chip_ver(u8 chip_id, u16 baseline)
+{
+	int i;
+	size_t table_size = ARRAY_SIZE(broken_read_tx_power_chip_ver);
+	const struct bcm_chip_version_table *entry =
+						&broken_read_tx_power_chip_ver[0];
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
+	u8 *chip_id;
+	u16 *baseline;
 
 	/* Read Verbose Config Version Info */
 	skb = btbcm_read_verbose_config(hdev);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
-
-	bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
+	skb_pull_data(skb, 1);
+	chip_id = skb_pull_data(skb, sizeof(*chip_id));
+	skb_pull_data(skb, 1);
+	baseline = skb_pull_data(skb, sizeof(*baseline));
+
+	if (chip_id) {
+		bt_dev_info(hdev, "BCM: chip id %u", *chip_id);
+
+		if (baseline) {
+			/* Check Chip ID and disable broken Read LE Min/Max Tx Power */
+			if (btbcm_is_disable_broken_read_tx_power_by_chip_ver(*chip_id, *baseline))
+				set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+		}
+	}
 	kfree_skb(skb);
 
 	return 0;
@@ -465,7 +502,7 @@ static int btbcm_print_controller_features(struct hci_dev *hdev)
 	kfree_skb(skb);
 
 	/* Read DMI and disable broken Read LE Min/Max Tx Power */
-	if (dmi_first_match(disable_broken_read_transmit_power))
+	if (dmi_first_match(broken_read_tx_power_dmi))
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
 
 	return 0;
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
2.34.1

