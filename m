Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAED1BC23
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193383; cv=none; b=c1KOOodmYTmdiy6jLhxeLSprzNVwrqv08GmNnQ7SbCKGYXxCNOrw7QC6qst9BwW3Z5iPdEd/lV+leWHl9RAQQ5ULG/Z+48Jgv5zIgEAYqpqLTu3AsDian0bqtrFg0S0aYxUHg0p2iAsOLCnsbPIiKje2HPPj7/ATufb+PNEcsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193383; c=relaxed/simple;
	bh=bGAyD3ixI6iTBtEyZPh/mmBmmc00y8EuZD435YwkgKg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ULnpiByqx3am0VRHLF58J/3/5MfITYBIMgQ9LdCmUhMTXEKrHlHfa3m0s72YGIfaWXDwiODgi+RvaCIjbpL/RXF/s05NvoeNSD5KU1cgxBOYOHyWoepbKPVtIRFnvdpHqIksvkhFNHUyXqm8IRDk8Jr04Wz5lqkczOaDRKRn8vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=TPqoTGqq; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="TPqoTGqq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1716193382; x=1747729382;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=bGAyD3ixI6iTBtEyZPh/mmBmmc00y8EuZD435YwkgKg=;
  b=TPqoTGqq1XIxiYN+cRfVWfy9VUNsqvVoN4Duxmp2Dr8XVSKKCrELd4wE
   MlKlQjaL+aDpBa4PmBwlyfHvbPzzQ650VyQkUYlMMMQpQt5+rrRgTNMo8
   izzwKko4oOsbQRo3lvjNuw1t6SLugFrd5pfnP+qglqesm5SP8nEnQMWCW
   8=;
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="19490355"
X-IronPort-AV: E=Sophos;i="6.08,174,1712613600"; 
   d="scan'208";a="19490355"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 10:22:54 +0200
Received: from MUCSE837.infineon.com (172.23.7.109) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 May
 2024 10:22:53 +0200
Received: from MUCSE832.infineon.com (172.23.7.104) by MUCSE837.infineon.com
 (172.23.7.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 May
 2024 10:22:52 +0200
Received: from MUCSE832.infineon.com ([fe80::6918:9b7d:1c9c:3175]) by
 MUCSE832.infineon.com ([fe80::6918:9b7d:1c9c:3175%15]) with mapi id
 15.02.1118.040; Mon, 20 May 2024 10:22:52 +0200
From: <Nobuaki.Tsunashima@infineon.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v2] Patch for CYW4373 hci up fail issue
Thread-Topic: [PATCH v2] Patch for CYW4373 hci up fail issue
Thread-Index: Adqqjj3ae2mX8VZUTA2IVSUTW9hBaw==
Date: Mon, 20 May 2024 08:22:52 +0000
Message-ID: <016dd2b28cd5435ba6f13b01d4da0d44@infineon.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command a=
s supported in a response
of Read_Local_Supported_Command command but rejects the LE_Read_Transmit_Po=
wer command with
"Unknown HCI Command" status.
Due to the issue, Bluetooth driver of 5.15 and later kernel fails to hci up=
.
Especially in USB i/f case, it would be difficult to download patch FW that=
 includes Its fix unless hci is up.
The patch forces the driver to skip LE_Read_Transmit_Power Command when it =
detects CYW4373 with ROM
FW build.

Signed-off-by: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>

---
V1 -> V2: Fix several coding style warnings.

 drivers/bluetooth/btbcm.c | 33 ++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btusb.c |  4 ++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0a5445ac5e1b..da4718a268d0 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -437,18 +437,49 @@ static const struct dmi_system_id disable_broken_read=
_transmit_power[] =3D {
 	{ }
 };
=20
+struct bcm_chip_version_table {
+	u8	chip_id;
+	u16 baseline;
+};
+#define BCM_ROMFW_BASELINE_NUM	0xFFFF
+static const struct bcm_chip_version_table disable_broken_read_transmit_po=
wer_by_chip_ver[] =3D {
+	{0x87, BCM_ROMFW_BASELINE_NUM}		/* CYW4373/4373E */
+};
+static bool btbcm_is_disable_broken_read_tx_power_by_chip_ver(u8 chip_id, =
u16 baseline)
+{
+	int i;
+	int table_size =3D ARRAY_SIZE(disable_broken_read_transmit_power_by_chip_=
ver);
+	const struct bcm_chip_version_table *entry =3D=20
+							&disable_broken_read_transmit_power_by_chip_ver[0];
+
+	for (i =3D 0 ; i < table_size ; i++, entry++)
+	{
+		if ((chip_id =3D=3D entry->chip_id) && (baseline =3D=3D entry->baseline)=
)
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
=20
 	/* Read Verbose Config Version Info */
 	skb =3D btbcm_read_verbose_config(hdev);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
-
+	chip_id =3D skb->data[1];
+	baseline =3D skb->data[3] | (skb->data[4] << 8);
 	bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
 	kfree_skb(skb);
=20
+	/* Check Chip ID and disable broken Read LE Min/Max Tx Power */
+	if (btbcm_is_disable_broken_read_tx_power_by_chip_ver(chip_id, baseline))
+		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+
 	return 0;
 }
=20
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d31edad7a056..52561c8d8828 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -142,6 +142,10 @@ static const struct usb_device_id btusb_table[] =3D {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x04ca, 0xff, 0x01, 0x01),
 	  .driver_info =3D BTUSB_BCM_PATCHRAM },
=20
+	/* Cypress devices with vendor specific id */
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x04b4, 0xff, 0x01, 0x01),
+	  .driver_info =3D BTUSB_BCM_PATCHRAM },
+
 	/* Broadcom devices with vendor specific id */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01),
 	  .driver_info =3D BTUSB_BCM_PATCHRAM },
--=20
2.25.1

