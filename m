Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4462BD5B4;
	Thu, 26 Mar 2026 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563189; cv=none; b=RbOiq0fk2KHDP6OAatbfcShrh3fiS7Q2gJ9qShxKgwer9rn8BPsXGYa+vqcEiqOl+Re4YeCrJwith9/W5EL9pbkMTfQ0SEN6ebWyeQgUIr16Rd4e7i7dcxJ6Vf8PLnDBw8aaz5Xypmkpd6wFMFe7rHxEdCHf9L51/mbEcxHxXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563189; c=relaxed/simple;
	bh=k028IzpOLzyefC8lh+HkGq9e9Y/OCjM3t5s3hKR+plE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=mQh71dc2ckZslTtcOUwVx+264yIq52nAeLJ2tHunp1d2yCA14N7HUXihHyKWvXneVAGV2IkynPh8qW6gxgh3MrkW5EGTEtNIaNtn/tU0wune8xXb5kORFrXfq9gvt4Hb6qfBL7Q7ZkLwDI+pw1u/cRcYYc2PY31lHIFEjoDlqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=FFKHIIVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jtceBobr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="FFKHIIVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtceBobr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A42FD140027E;
	Thu, 26 Mar 2026 18:13:07 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 18:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774563187;
	 x=1774649587; bh=nmRwyCI/8YRQA7cAtMtcG+fFkazLXjESdEioP+CFUN4=; b=
	FFKHIIVKCEmDQ9p5lMR8iNyGnTp+IcLlMWa6s9NPcZ+0neieX2ULliAlWp2Kjtac
	6rEnr9tmsw7I7QLC0JLAYmBfFU1Ws9njLkgfqF/7KuQql5Jujl8gQleMbDnUX0CY
	nqqxNzJE3ogK8Ajth+hr2viNdJ/Eg9f/yd6TYXPd3Cw/jMYCujDL8uMUFzltkSeO
	/6BZnfpJFSm9N6TdJMH4oYn8COAZqjgcvkVZ27mzRo+4D/U6bbYVf28wpkbRhnZf
	OpmuygCuOjoVCHroMawViRP2ZoPk1xhZkx3nXMrcVDFzYACYF2hgRKaYuRrIJ6oy
	hSdHOIP4jqzmUQqwU9ZrBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774563187; x=
	1774649587; bh=nmRwyCI/8YRQA7cAtMtcG+fFkazLXjESdEioP+CFUN4=; b=j
	tceBobr6cL9ywKEqhLBB7/AXgCiM5kXXKsxY6azq27qrlgJ7SgpgIqieeh42zdLh
	4ZYw+wMA5LDm3c4zvftNsVsdNhC29/4he6XqpwHzbpjNVdtwvVEf0kdJZQj1Ysz5
	N/+pIFBGfwF9NEaUfcRYBg+HNcoecJVQSNA2SFe93Hmh9QWxAJVb8zPZETxBvEDP
	LrOgrz7nqT4ZjbQCFxIzMi4p0rCMAt6vNZnK21oI0gdXdRsPLHN/e9S39tCOO/lh
	WP9GBKm5P8FCBPWWFmw+zizGJR5lwsyZWNzSiRYH5SYrx6WfOnC3A9l3zxoAB1U5
	BBHqUvAI4jxMFfW6DN/ug==
X-ME-Sender: <xms:c6_FaSRm_6Y88PFhNcdOteAXphvgmfTY_ehKv8EH9eR2tu6mAMLEww>
    <xme:c6_FaSmpQc2_uobzYLda1e_bLGXe0MjicEUt2PeZTHOcgUyVJwt3oCsDDJlE1r-4N
    Rrf_rHKNRnh1WY_ae0XGHeIqas6va1JutYfepNuGn38wcULjhGIZI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:c6_FadxNAoNujpN7ea6ItKjuU5QextYwGSHrGbeNRKSnx08Qzk-PuA>
    <xmx:c6_FaQXQM5kJJ87LdEbJSInN0ROznjDKlfZz561KIUVI6jveoR_MPQ>
    <xmx:c6_FaR_orT7i-jybEFLC1U3xvmLKsh-FRZ-MEyOGiRhQOtVV5xBHSw>
    <xmx:c6_FabsmLqbtaeCwirVgyk7iWG01fQ6gbFE04GdA3sLVY9DrcAORxg>
    <xmx:c6_FaasZ6BEw0k2OylXCkJiZEvIfH6LIl7rkaFSP-tjv0kEvEzF4UMCf>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7D20B1EA006B; Thu, 26 Mar 2026 18:13:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 16:13:04 -0600
Subject: [PATCH v3 1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth
 support
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-mt7927-bt-support-v3-1-fa7ebd424323@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ryan Gilbert <xelnaga@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6436; i=floss@jetm.me;
 h=from:subject:message-id; bh=k028IzpOLzyefC8lh+HkGq9e9Y/OCjM3t5s3hKR+plE=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxa9vZRxNsGXSJuygeqoJqwSW01a5OLjHscYwk
 +YlMFZtkRiJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWvbwAKCRC17sMLqGd3
 H+hNC/4g9zYIQfGL5SIt9SpOUB+vzaYLQ7XB1i9vBwpqcyfM8PY2/xlU0ZWZ5Lae/PfdUHeYZE5
 SGFXJEglTyAeZX/OjLPJg4n7lQxqgNR3MNmkz/RSsDbOcNS5VR+VArhQIxYVkt0DODTSpNzDzfj
 AWG0xxNXCDAl5SpZ/Vl6vfSJDzmTDrQ9+Zmw34nrRqyaUQ2GJUITS1e1ZDxbm+RzfgAK6aY1zSk
 BQH9eUW+hiJN9YWPlzGqZLt2++uX3bXy24GhLUxzD4ug8uZkMd3BPzdNaLXb6f7WNEukFEFuyTG
 2xHhx86fGFZokvfyMvMjAoEUYGR8Ehbucjp2Fcd5KvFKchuXDVpyklqy2u/UtK8rosPDveoWTjm
 dk5JMpMidbvLPuebibagoDrmG2VDEKlP62dINgCfOA5VvSnEphKGHOECsPCt40L43Z7P4ihRFOM
 XAdyWrpbRZ4dIpYMdDstzRWvgIRHlkpLDPMn8XTE4ugCPvP8TePKxJtVjhy810/+Qi+0A=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>
References: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>

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
 drivers/bluetooth/btmtk.c | 53 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btmtk.h |  1 +
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 2507d587f28a..3f12f2ab6369 100644
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
@@ -130,6 +150,7 @@ EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			      wmt_cmd_sync_func_t wmt_cmd_sync)
 {
+	struct btmtk_data *data = hci_get_priv(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	struct btmtk_patch_header *hdr;
 	struct btmtk_global_desc *globaldesc = NULL;
@@ -166,6 +187,14 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 		section_offset = le32_to_cpu(sectionmap->secoffset);
 		dl_size = le32_to_cpu(sectionmap->bin_info_spec.dlsize);
 
+		/* MT6639: only download sections where dlmode byte0 == 0x01,
+		 * matching the Windows driver behavior which skips WiFi/other
+		 * sections that would cause the chip to hang.
+		 */
+		if (data->dev_id == 0x6639 && dl_size > 0 &&
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
@@ -1339,6 +1386,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7925:
 	case 0x7961:
 	case 0x7902:
+	case 0x6639:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
@@ -1516,3 +1564,4 @@ MODULE_FIRMWARE(FIRMWARE_MT7668);
 MODULE_FIRMWARE(FIRMWARE_MT7922);
 MODULE_FIRMWARE(FIRMWARE_MT7961);
 MODULE_FIRMWARE(FIRMWARE_MT7925);
+MODULE_FIRMWARE(FIRMWARE_MT7927);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index adaf385626ee..d95d023b6adc 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -8,6 +8,7 @@
 #define FIRMWARE_MT7902		"mediatek/BT_RAM_CODE_MT7902_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
+#define FIRMWARE_MT7927		"mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin"
 
 #define HCI_EV_WMT 0xe4
 #define HCI_WMT_MAX_EVENT_SIZE		64

-- 
2.53.0

