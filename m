Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8031064E;
	Tue, 31 Mar 2026 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976977; cv=none; b=TvtcWcuBe749Y0IdIm1Xk1FK2MkbG/eLVLZHl6KiARtDGvLoH40aBzOiZgUdAadZEtUj8nQkn1B5w8rBklbKRy98ePOppxda86ufcuzGWfz7H3QyY/kR0ATCE+hXcxWpSWhRdPhnO7s6ucIFc9PGazeD9BOmeuSiuZAu1QR/+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976977; c=relaxed/simple;
	bh=qMLYYCOe3JtxPEuwHOkWZAEJ3ybGtlDOkuTZYGcVSMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=twJCELyKjDvy/Shob8IJ0fQJ13aVEcSwM5vZmr44NSizLbt/IZDPIMvQJKFVfJmaZgYUO7O6pPkopJ95HJPWCxGAhYXlr5DsU9kaFZD9YictOP1H7FWByJ9KPfwssuIMZANxkpnUjizelkzu9sSrbO+4SJgMWVtkwa4KNyaESqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=AmDmAL0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fU/5eVLE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="AmDmAL0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fU/5eVLE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 175247A0204;
	Tue, 31 Mar 2026 13:09:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774976974;
	 x=1775063374; bh=yqQncMaQGJrTn7P2RgxikK1KdLZYs5JsDabvDW572Fo=; b=
	AmDmAL0npqEFdIkB1lTvXLef1/kM/w8NUwLTQrz2bhusE7h0n2vcHeqRWZBeynHA
	CZWkUKfOrqfFT6Beu6ZVlvuq6u/aMwJL6pGdPZsEiwIwRIWADxTXeofVkr8iYFKa
	AL41lJ+PqmwT0BfxHMUz6y6a11Af2oS0o2DBN3iZQE317rFvDtTNqxDbh0doPF2B
	z1ob7sc1klb3NxvwOMGc/NFavjarK4u7bd5LohzEbCJPCh9txfmn6AM8mnL4Kj15
	azWilfhTv2x8jrbhEoWU9g076elzAb0PWr/FOAwCVe0zmxS5tRY8P2vrtrtQNTq8
	qLo59k8Pi6xxCFYiwaNzsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774976974; x=
	1775063374; bh=yqQncMaQGJrTn7P2RgxikK1KdLZYs5JsDabvDW572Fo=; b=f
	U/5eVLEUM4ENh/S84FEkxSAK+jYIwYV7vWWcCWAC7Klj+RRctIQ0VGRMukjffTvx
	0LsKmscN0UTsorBDF8tvCM6J+L60H25KsiuqEp9R4N6rOChyiJYLAnRnJzpTR4fC
	X+/DAAzWMO5ZjiWu1CPCn1j9mJpfbzWLKcf0RSJp6e+hLLzlYJr54BlHH30dOEky
	WTcZLGwKK9UwuivzwpX2Q1Fn52x7SloFJwAKI3iBJoBA6r0YCH2a0mbFISYx5zSe
	h2Z2pE/BOmtk4Cvs1KhN0DFLO9RnCvJM0Oafzh17ZX3tSxYLid6fpMBO6/CwMzbZ
	zM1XY2iZmuEK39HykC8yA==
X-ME-Sender: <xms:zv_LaTsaBycffzD1ji-79mZA3bMcttn5inDl-twRrHNqSi8nKomprA>
    <xme:zv_LafQAijPbXZ2ubhuUTt7uKrSOIHbRJ84fsCz6sIVbWyrA8tIGnMr2Ag5aunK3F
    f7UFHkrCeZ-ytZdktPo6YN8pzP_qnT-Vh9H3w88fwH5kMUZ8bhify4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fohfffufggtgfgkffvvefojghfsehtjeertdertdejnecuhfhrohhmpeflrghvihgvrhcu
    vfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtffrrghtthgvrhhnpedtfedvfe
    ekuddtjeffhfehheffgfeftdfhueeiieetteegtddthfevfeelvdekjeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhgvg
    hlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhm
    pdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgrthhthhhirghsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgigvlhhn
    rghgrgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnh
    hnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhs
    rdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirghtvg
    hksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidq
    sghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zv_LafNwOWO0ydXI5rdSA3dK7u5Nhf_bn933clqaUWEqICoDRoqF8Q>
    <xmx:zv_LadBqaOWNLYC4VQ8kn3THHtFy_6jE-9LrL0eWWYUrjnnWNbreoA>
    <xmx:zv_LaY4ySrFCJT69CsCgKLp8pELfs1J--VLiuKWETS2cBU9NyR9nSA>
    <xmx:zv_Laf6R7b3F1mDdRCeSL_2VSd_81zT32CqfxUjqoTCRrQBJknB1RQ>
    <xmx:zv_LaVpo-TIYcZukSl3wGpMPx4LOJ_29wodCckrRoDLEdKcKXfsmoroF>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C2EFD1EA006C; Tue, 31 Mar 2026 13:09:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Tue, 31 Mar 2026 11:09:31 -0600
Subject: [PATCH v5 1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth
 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-mt7927-bt-support-v5-1-6f31b4342daa@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ryan Gilbert <xelnaga@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8423; i=floss@jetm.me;
 h=from:subject:message-id; bh=qMLYYCOe3JtxPEuwHOkWZAEJ3ybGtlDOkuTZYGcVSMs=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpy//KOpk9X0wwdDzR4Wj2WWJbW48WpiWdAup3O
 5BF46uYLCyJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacv/ygAKCRC17sMLqGd3
 H/wKDACDZoVqdtIR7r27CHd7VdRdRTGlfizayRjSy78fKlufSUI7Wx61aAa+fHx1cX2BwBjp8Ou
 dkIiuLt1tQMHK3Ee6IOZaLVuNSD7WAriGTPWfPvUE+CA2UWmaGB64XIUaXdwLeGeZTA0Vmlaoq5
 t3S3unfrjd8ejgHyxnxijVUpLXcO92XRREu+otHw149Fnj6Y//NMiv0JBJvn6OUWZOlqJArPWtH
 sBA0S4G4ex+mx/V1gg0C2DUZ4o+AbiHBQtQNXAdzysr+uK+xBvLhMKq6M5/SFYbPSWlRQ92TC69
 s7rJWYNRaout06j2DcJ6Y6nsESUEaSi/d/IdVBE6jHbmkd9VCAkNrht6maKrvFe50ng/dYB9OWU
 8T9mezr1t3M4viYendUtBqM5dDkyVMZP6PraPIMNM1JPY2BHl8H52qQebOHcfbNUGRo4tUjuEqT
 b4u9UfzPR/dMGCMbkVu9sTkdxyLNjdnrCpC0SPYmE6BAZ7e981LrV9BxuG4CpJPin6lLY=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
References: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>

The MediaTek MT7927 (Filogic 380) combo WiFi 7 + BT 5.4 module uses
hardware variant 0x6639 for its Bluetooth subsystem. Without this patch,
the chip fails with "Unsupported hardware variant (00006639)" or hangs
during firmware download.

Three changes are needed to support MT6639:

1. CHIPID workaround: On some boards the BT USB MMIO register reads
   0x0000 for dev_id, causing the driver to skip the 0x6639 init path.
   Force dev_id to 0x6639 only when the USB VID/PID matches a known
   MT6639 device, avoiding misdetection if a future chip also reads
   zero. This follows the WiFi-side pattern that uses PCI device IDs
   to scope the same workaround.

2. Firmware naming: MT6639 uses firmware version prefix "2_1" instead of
   "1_1" used by MT7925 and other variants. The firmware path is
   mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin, using the mt7927
   directory to match the WiFi firmware convention. The filename will
   likely change to use MT7927 once MediaTek submits a dedicated
   Linux firmware binary.

3. Section filtering: The MT6639 firmware binary contains 9 sections, but
   only sections with (dlmodecrctype & 0xff) == 0x01 are Bluetooth-related.
   Sending the remaining WiFi/other sections causes an irreversible BT
   subsystem hang requiring a full power cycle. This matches the Windows
   driver behavior observed via USB captures.

Also add 0x6639 to the reset register (CONNV3) and firmware setup switch
cases alongside the existing 0x7925 handling.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221096
Link: https://github.com/openwrt/mt76/issues/927
Reported-by: Ryan Gilbert <xelnaga@gmail.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/bluetooth/btmtk.c     | 60 +++++++++++++++++++++++++++++++++++++++----
 drivers/bluetooth/btmtk.h     |  7 +++--
 drivers/bluetooth/btmtksdio.c |  2 +-
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 2507d587f28a..4af19b86c551 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -25,6 +25,22 @@
 /* It is for mt79xx iso data transmission setting */
 #define MTK_ISO_THRESHOLD	264
 
+/* Known MT6639 (MT7927) Bluetooth USB devices.
+ * Used to scope the zero-CHIPID workaround to real MT6639 hardware,
+ * since some boards return 0x0000 from the MMIO chip ID register.
+ */
+static const struct {
+	u16 vendor;
+	u16 product;
+} btmtk_mt6639_devs[] = {
+	{ 0x0489, 0xe13a },	/* ASUS ROG Crosshair X870E Hero */
+	{ 0x0489, 0xe0fa },	/* Lenovo Legion Pro 7 16ARX9 */
+	{ 0x0489, 0xe10f },	/* Gigabyte Z790 AORUS MASTER X */
+	{ 0x0489, 0xe110 },	/* MSI X870E Ace Max */
+	{ 0x0489, 0xe116 },	/* TP-Link Archer TBE550E */
+	{ 0x13d3, 0x3588 },	/* ASUS ROG STRIX X870E-E */
+};
+
 struct btmtk_patch_header {
 	u8 datetime[16];
 	u8 platform[4];
@@ -112,7 +128,11 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor)
 {
-	if (dev_id == 0x7925)
+	if (dev_id == 0x6639)
+		snprintf(buf, size,
+			 "mediatek/mt7927/BT_RAM_CODE_MT%04x_2_%x_hdr.bin",
+			 dev_id & 0xffff, (fw_ver & 0xff) + 1);
+	else if (dev_id == 0x7925)
 		snprintf(buf, size,
 			 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
 			 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
@@ -128,7 +148,8 @@ void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
 
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
-			      wmt_cmd_sync_func_t wmt_cmd_sync)
+			      wmt_cmd_sync_func_t wmt_cmd_sync,
+			      u32 dev_id)
 {
 	struct btmtk_hci_wmt_params wmt_params;
 	struct btmtk_patch_header *hdr;
@@ -166,6 +187,14 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 		section_offset = le32_to_cpu(sectionmap->secoffset);
 		dl_size = le32_to_cpu(sectionmap->bin_info_spec.dlsize);
 
+		/* MT6639: only download sections where dlmode byte0 == 0x01,
+		 * matching the Windows driver behavior which skips WiFi/other
+		 * sections that would cause the chip to hang.
+		 */
+		if (dev_id == 0x6639 && dl_size > 0 &&
+		    (le32_to_cpu(sectionmap->bin_info_spec.dlmodecrctype) & 0xff) != 0x01)
+			continue;
+
 		if (dl_size > 0) {
 			retry = 20;
 			while (retry > 0) {
@@ -852,7 +881,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		msleep(100);
-	} else if (dev_id == 0x7925) {
+	} else if (dev_id == 0x7925 || dev_id == 0x6639) {
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
 		if (err < 0)
 			return err;
@@ -938,7 +967,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	}
 
 	err = btmtk_usb_id_get(hdev, 0x70010200, &val);
-	if (err < 0 || !val)
+	if (err < 0 || (!val && dev_id != 0x6639))
 		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
 
 	return err;
@@ -1322,6 +1351,24 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		fw_flavor = (fw_flavor & 0x00000080) >> 7;
 	}
 
+	if (!dev_id) {
+		u16 vid = le16_to_cpu(btmtk_data->udev->descriptor.idVendor);
+		u16 pid = le16_to_cpu(btmtk_data->udev->descriptor.idProduct);
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(btmtk_mt6639_devs); i++) {
+			if (vid == btmtk_mt6639_devs[i].vendor &&
+			    pid == btmtk_mt6639_devs[i].product) {
+				dev_id = 0x6639;
+				break;
+			}
+		}
+
+		if (dev_id)
+			bt_dev_info(hdev, "MT6639: CHIPID=0x0000 with VID=%04x PID=%04x, using 0x6639",
+				    vid, pid);
+	}
+
 	btmtk_data->dev_id = dev_id;
 
 	err = btmtk_register_coredump(hdev, btmtk_data->drv_name, fw_version);
@@ -1339,11 +1386,13 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7925:
 	case 0x7961:
 	case 0x7902:
+	case 0x6639:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
 		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
-						btmtk_usb_hci_wmt_sync);
+						btmtk_usb_hci_wmt_sync,
+						dev_id);
 		if (err < 0) {
 			/* retry once if setup firmware error */
 			if (!test_and_set_bit(BTMTK_FIRMWARE_DL_RETRY, &btmtk_data->flags))
@@ -1516,3 +1565,4 @@ MODULE_FIRMWARE(FIRMWARE_MT7668);
 MODULE_FIRMWARE(FIRMWARE_MT7922);
 MODULE_FIRMWARE(FIRMWARE_MT7961);
 MODULE_FIRMWARE(FIRMWARE_MT7925);
+MODULE_FIRMWARE(FIRMWARE_MT7927);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index adaf385626ee..c564aedc0ce0 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -8,6 +8,7 @@
 #define FIRMWARE_MT7902		"mediatek/BT_RAM_CODE_MT7902_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
+#define FIRMWARE_MT7927		"mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin"
 
 #define HCI_EV_WMT 0xe4
 #define HCI_WMT_MAX_EVENT_SIZE		64
@@ -189,7 +190,8 @@ typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
 int btmtk_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
-			      wmt_cmd_sync_func_t wmt_cmd_sync);
+			      wmt_cmd_sync_func_t wmt_cmd_sync,
+			      u32 dev_id);
 
 int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 			 wmt_cmd_sync_func_t wmt_cmd_sync);
@@ -228,7 +230,8 @@ static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
 
 static inline int btmtk_setup_firmware_79xx(struct hci_dev *hdev,
 					    const char *fwname,
-					    wmt_cmd_sync_func_t wmt_cmd_sync)
+					    wmt_cmd_sync_func_t wmt_cmd_sync,
+					    u32 dev_id)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 042064464d34..5b0fab7b89b5 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -883,7 +883,7 @@ static int mt79xx_setup(struct hci_dev *hdev, const char *fwname)
 	u8 param = 0x1;
 	int err;
 
-	err = btmtk_setup_firmware_79xx(hdev, fwname, mtk_hci_wmt_sync);
+	err = btmtk_setup_firmware_79xx(hdev, fwname, mtk_hci_wmt_sync, 0);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to setup 79xx firmware (%d)", err);
 		return err;

-- 
2.53.0

