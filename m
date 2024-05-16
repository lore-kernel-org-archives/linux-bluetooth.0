Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1711182
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715836111; cv=none; b=J79TRa2jtEgAuqnr1eN1f/ANF4K7uP7/WebOGIrVUxQerVb5QSiXLyAp3Ne2lQFhYiA0HAr0NA7qO4/WvovRd5XoUjoljWpURiEYiA0WaEW/1DPbpBeomze4vRpyttKCbP1MFdC1nQi6cANKw61y1d5qIZK8B1Dj6Fibwqy2xas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715836111; c=relaxed/simple;
	bh=r5CXpKkb2JJizH9kG0U43RhdFOyHjP8VFqqjSoLi3lE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iNDbcIHdqBTtiI215xTs+SvrIF8atUnthc3ATv5zggaqV3/AS/3dIB9CXCaGen3XVI/DzdUVzYFR31LaEZAXyW9+haN1h4f0qTK47Ho8FLC1l8uBzBHvWP6rF2+5d1WHrh2/pjtcroTz/d4WAOJq75jwaxaXBoL4DXlqGPj95+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=qRy+HtF8; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="qRy+HtF8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1715836110; x=1747372110;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=r5CXpKkb2JJizH9kG0U43RhdFOyHjP8VFqqjSoLi3lE=;
  b=qRy+HtF8uXTUSYsTuQVK4mg+xL+2RsHXkWfl5bI/3qtEt7hT7TFAwX3g
   YVTTLourOTbJ9OsS4eHjEwnSsapXnM3eqSfkNZ5il9hEUy+67TGtzQSBg
   BhjCZvAtu4aAH6voexLIQkzaFqXjPJRf0evmQMZ/3V/k0V5gMPXybs0qF
   I=;
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="51074034"
X-IronPort-AV: E=Sophos;i="6.08,163,1712613600"; 
   d="scan'208";a="51074034"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 07:08:27 +0200
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 16 May
 2024 07:08:26 +0200
Received: from MUCSE832.infineon.com (172.23.7.104) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 16 May
 2024 07:08:26 +0200
Received: from MUCSE832.infineon.com ([fe80::6918:9b7d:1c9c:3175]) by
 MUCSE832.infineon.com ([fe80::6918:9b7d:1c9c:3175%15]) with mapi id
 15.02.1118.040; Thu, 16 May 2024 07:08:26 +0200
From: <Nobuaki.Tsunashima@infineon.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Patch for CYW4373 hci up fail issue
Thread-Topic: [PATCH] Bluetooth: Patch for CYW4373 hci up fail issue
Thread-Index: AdqnTUe0gn8yrR5qRPOdTOn0GveE1w==
Date: Thu, 16 May 2024 05:08:26 +0000
Message-ID: <6267800d70ae4344acaba3486b54bc0c@infineon.com>
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

CYW4373 ROM FW has an issue that it claims LE_Read_Transmit_Power command
as supported in a response of Read_Local_Supported_Command command but
rejects the LE_Read_Transmit_Power command with "Unknown HCI Command"
status.
Due to the issue, Bluetooth driver of 5.15 and later kernel fails to hci up=
.
Especially in USB i/f case, it would be difficult to download patch FW that=
 includes
Its fix unless hci is up. The patch forces the driver to skip LE_Read_Trans=
mit_Power
Command when it detects CYW4373 with ROM FW build.

Signed-off-by: Nobuaki Tsunashima <nobuaki.tsunashima@infineon.com>

---
 drivers/bluetooth/btbcm.c | 32 +++++++++++++++++++++++++++++++-
 drivers/bluetooth/btusb.c |  4 ++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0a5445ac5e1b..c64d1ddd140d 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -437,18 +437,48 @@ static const struct dmi_system_id disable_broken_read=
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
+	int table_size =3D sizeof(disable_broken_read_transmit_power_by_chip_ver)=
/sizeof(disable_broken_read_transmit_power_by_chip_ver[0]);
+	struct bcm_chip_version_table *entry =3D &disable_broken_read_transmit_po=
wer_by_chip_ver[0];
+
+	for( i=3D0 ; i<table_size ; i++, entry++)
+	{
+		if( (chip_id =3D=3D entry->chip_id) && (baseline =3D=3D entry->baseline)=
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

