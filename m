Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEF39E6F8;
	Mon, 30 Mar 2026 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903170; cv=none; b=VLH4uxgGPBsrdN3vACbWdwnhX7jPCLP4NTj9A01u7Qt2v+1l186jlNvQRmhnlWaNqgr41YTpQLldOfgHfB224sBOo2L94OyDMXPsOCjoXv47Gqz6eNgfzaqI1aiiLf2BW5CEcFhdJtTz7fJGWawwxQ3FU3mZOJgYJPRaxKsDi3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903170; c=relaxed/simple;
	bh=qMLYYCOe3JtxPEuwHOkWZAEJ3ybGtlDOkuTZYGcVSMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=D/5mkw7k0eVK4GzJGjS5A0upAgJ5rTjgo3TlAMUlEfA06rMFq+9F67i9SYxtbwA2Ueow7B/ULBQG6A3umlNFrZzNlzYMzxAZnYuzY6mO6oX3LLpJnJA7kEHv2cDAxO31Edz7SoabZ60pa5QSdm2MJ/ZtPR/5j5IAbS+R/Yft5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=HRG7lcQr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IcA/AudJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="HRG7lcQr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IcA/AudJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05F7A14001C1;
	Mon, 30 Mar 2026 16:39:28 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 16:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774903168;
	 x=1774989568; bh=yqQncMaQGJrTn7P2RgxikK1KdLZYs5JsDabvDW572Fo=; b=
	HRG7lcQrCWm4hlnLrwLl60ptrT37XHNFWeCG5C02k2uyDfBEst9DPvrI7OkN5ZpT
	UlVnSkD6meogakHGFPgRsE4xXFew7W4DquMMlTb0wZ96giTtYwHlzGSKc1fVa16x
	T5dPXhE86yQrGH+21nwtVWOrovCZ0aeBccwbRhgVYDDxRjNVpneV8Up3EuXnn4JD
	AJ3jvYIaBsg2eeDpVTG7p8X55mWYbW6WlvaG7MuPpVzt3r9zLvRQXgRxDgddqq9g
	yuZ5tF0YiJFwu6awlnFnyAxc5QEZEyi8Y8YIVSJ+LKPX8/o7g4/+/6d6ls4CP/5h
	PCVxx1hZa347sqYsPxGWhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774903168; x=
	1774989568; bh=yqQncMaQGJrTn7P2RgxikK1KdLZYs5JsDabvDW572Fo=; b=I
	cA/AudJxwtpKzWD385EyO2hwy7Q8VX8lV6YhpZho33dgnm60pzjt1wwkIaICQBll
	L6WUFBOtrgXpzwSayqEqWjtTpXjoRpVJhwuNuIvy+lBk0JhBUKDGRIAQXNNectQS
	3ZudTbHwUwprVkpG9WMqU3NlQjVPhceXA1P5Zk7eeTEbWpTrTr7T/AqARnde+HJO
	2sh0xJQDKWHQi93LjfqE6EMG+3OfDptFWcITMS0Wx7nNFG36A0xqSwk9ID1mNdU9
	y0hWICnh2SM41KY5kqdyhmLwRh4kW02sbGow1RWiZb84ccf1NIJwCLE6DiJ6r797
	9zM2q+rW4RXthOy2i6QVw==
X-ME-Sender: <xms:f9_Kadd3jko24oOgy0FbQTp1BP05KH25AcTxXTS0DdGFbMOyD9c9iQ>
    <xme:f9_KaWAEF4YKSlrh-RKSnrH9Xr7KaKBcO5BsVZqwf1U4ob1E5z4cCSITDESYsjKRX
    _A4ottuytzTd3IXk20k77X4Sa9P5MvQ09NFgka6hKPy-KSVR3ZyPb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    efvdefkedutdejfffhheehfffgfedthfeuieeiteetgedttdfhveefledvkeejnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhm
    vgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hnghgvlhhoghhiohgrtggthhhinhhordguvghlrhgvghhnohestgholhhlrggsohhrrgdr
    tghomhdprhgtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtph
    htthhopehmrghtthhhihgrshdrsghgghesghhmrghilhdrtghomhdprhgtphhtthhopeig
    vghlnhgrghgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhgtvghlsehhohhlth
    hmrghnnhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhi
    shhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguih
    grthgvkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:f9_KaY_K7W4ZljiXvGE4zraQTcHd3FJkMdo_wM9EQ4ZOk0ypFBFQVQ>
    <xmx:f9_KaTy6hM2eYF8O1kievWIbFW_usvpufXsuvGaZMacHF_f9h9YUYA>
    <xmx:f9_KaYoLQ9SWlsa5p9FW5-wRIvLTOT_74GzOfD9DEu2jqi5E2gcInw>
    <xmx:f9_KaUpdJMVlCL5KcJWf379lV2n5HmVULlw9o3bMadn9OYEL9Ql0rw>
    <xmx:gN_KaVaCEr6V1-BFcS9KJvCKOLuZR937XYutJad11dXM6W0TuUeC18_z>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D4E6C1EA006B; Mon, 30 Mar 2026 16:39:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Mon, 30 Mar 2026 14:39:23 -0600
Subject: [PATCH v4 1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth
 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mt7927-bt-support-v4-1-cecc025e7062@jetm.me>
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
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpyt96gHLKd0HBgKNzSX7bH/xPQ2UpTJCBEbGzd
 /yQtBTe1bCJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacrfegAKCRC17sMLqGd3
 H0K7C/4kJfcYvPH31Z4c6m55vp6qxavnEFr7hcUKpPjnewUsOOKj4nBr1JB1aCH5sx4yilsdD+D
 aVglFLbf6LQj4g20ddI/z4SeYIJNreobFOHfNlfqhDgEMfTS4BO70z8dGclzE0yeFnwTgzLq3vF
 j5l30sDzAGMjAQ68Tzhjm0NfobmGSB0yoPinpQAioxuplPw9MmxXU2qaY6r0RiEUVx3TmTakvBW
 /YJ5+camKiQj32fHbTGN+9rqVAe1EzAOhwkxe+/BFCSl+ftSt68CxIfFGGVNk84lyw1gcBLfnUX
 1/cL8061CzwwUbP7tEWpl23+kRB7XtyEFZD4uEOoT+1Jsl8/Rqr7dnU2Gm3ygjBsiEzIiSOMu5E
 RNgHmjl1gBOZlYuYQx6QtLtBdgwuzkZ1BPDXdwVyUU+M+Wz69kO41yu6ogF8csFt07qZo5SEY2C
 NhqaTRHxrS8wunZJhyCxxdp8Gqidt2m3meekBBEjqdmT0YY0MRFkQ73242m+WyhFXyr6I=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
References: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>

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

