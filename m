Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728019B;
	Fri, 24 May 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514304; cv=none; b=sis75zSGjLsK7mBq0CqFt29ioq676qgiUHP8U3s8i8hunLfmhXm/CBBU6qgRHeNJltcIy5P7yxQZeIqlw3+TMKUWcn9zwu2SrogB09hjx7Zd/LATyNCOGOg1Q1K8tBu4VXbQswIGrTN+OtgcrGVf/hOgY+yjnPbGE204/hZNFfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514304; c=relaxed/simple;
	bh=hS8TiiH1WQ8HBxgia2bpb9rfgZ+xhKtMyuS/NsF3gWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8WBk/HTuqYJJhEAGy1wReSFBaAiw4Gas6gPQZPlbjoWCuCK3hdo2TbDUlc0Jh2t1MK59ePZaDRXsaCI7hFJDr35UMwVgH3f38esIsb0rVP/HOyZi8un47+cbLtap31iujnrMBDVTBb//TSQJgNQUPYxrq6zOU9fkLF8AYoi7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=iXMNXKYv; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="iXMNXKYv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1716514303; x=1748050303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hS8TiiH1WQ8HBxgia2bpb9rfgZ+xhKtMyuS/NsF3gWM=;
  b=iXMNXKYv/NdsSrPihhOt166IdRrO/rNcgVpeimHp24gG79HSuS/XYA+o
   5+YwQ+0VJLdEZKQEOJquGP5sm3Ro4JTduCWUWcVVS9LpevnAbQvpQZchT
   pOlgP6CgK+1umwWZoV4buZj+an0PJG7zaPffargNlKiJRCtMnkXt9ElGF
   c=;
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="76904617"
X-IronPort-AV: E=Sophos;i="6.08,184,1712613600"; 
   d="scan'208";a="76904617"
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 03:31:35 +0200
Received: from MUCSE832.infineon.com (172.23.7.104) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 May
 2024 03:31:34 +0200
Received: from icw-osk-deskmini.osa.infineon.com (10.161.6.196) by
 MUCSE832.infineon.com (172.23.7.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 May 2024 03:31:32 +0200
From: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Nobuaki Tsunashima" <Nobuaki.Tsunashima@infineon.com>
Subject: [PATCH v4] Bluetooth: btbcm: Apply HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER to CYW4373
Date: Fri, 24 May 2024 10:31:27 +0900
Message-ID: <20240524013127.434500-1-nobuaki.tsunashima@infineon.com>
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
V3 -> V4: Fix a few coding style warnings and refine comments for clarify.
V2 -> V3: Fix a few coding style warnings and change the subject as more specific.
V1 -> V2: Fix several coding style warnings.

 drivers/bluetooth/btbcm.c | 32 +++++++++++++++++++++++++++++++-
 drivers/bluetooth/btusb.c |  4 ++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0a5445ac5e1b..29e3f83a19fa 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -437,18 +437,48 @@ static const struct dmi_system_id disable_broken_read_transmit_power[] = {
 	{ }
 };
 
+struct bcm_chip_version_table {
+	u8 chip_id;			/* Chip ID */
+	u16 baseline;		/* Baseline version of patch FW */
+};
+#define BCM_ROMFW_BASELINE_NUM	0xFFFF
+static const struct bcm_chip_version_table disable_broken_read_transmit_power_by_chip_ver[] = {
+	{ 0x87, BCM_ROMFW_BASELINE_NUM }		/* CYW4373/4373E */
+};
+static bool btbcm_is_disable_broken_read_tx_power_by_chip_ver(u8 chip_id, u16 baseline)
+{
+	int i;
+	size_t table_size = ARRAY_SIZE(disable_broken_read_transmit_power_by_chip_ver);
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

