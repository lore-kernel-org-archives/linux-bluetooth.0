Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050137D122
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728170; cv=none; b=CQfAWr98PfiGoSinVN12hT1rJYMtWf2VD9DgyobOoCi8Xiq2jbuHsWCtEuCN3uPFvqJjvA+NlZA5tnDFtzNMXqnaM6lS/Cp/reYHVh4UTAJOEnjsMgeKi3NMYiD4pNUi/J6JXMKWx1ExUuNmO7lvbVybrMFQGDByEdClCoLWoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728170; c=relaxed/simple;
	bh=ZRIBWkROeZoH+7rFAxfvoxD/hDBLYfbVQ0FLdSIxBZU=;
	h=Content-Type:MIME-Version:From:To:Date:Subject:Cc:In-Reply-To:
	 References:Message-Id; b=UFNnsGNqAtXRNWOWycb1+24b20vo7H2kbcGFQQiG3OYXByXz2RkFc2aCtdignTuEJEmmk1yfCuzrU/0gJo6hGg/NyG0cZeWMre9dvATxSiZFG20U6RGCmOQ9t8ZPirvZQwiDa3WAbjnuDL72Bu4RozsmtvB/ci0sm4sZv83Xp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=NKm/tQkt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPZtj8jb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="NKm/tQkt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPZtj8jb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A33DA7A0201
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 11:29:28 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 11:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772728168;
	 x=1772814568; bh=0w7KXuf/a/2BRb3PNhiB1Eltyv6Ado83wL3c+tkjfgM=; b=
	NKm/tQktcxmwA1S8K5Yab2JkKUzlFIny+7tCXiurD5M6QSE1K5Jb7Ux2xfRLyWkS
	W8YGJ4s3Z+AfPG9uYI5IQh8r+ZEroW8LY3srZvR+fYq329H1sQpT3Mj9t7THyL7n
	kkWCZyOZatOfVxUF90mhX+v+8dn7L2N8YZClQr11lKszcd2Kq9ECexDg3sMCi4cn
	aAka/bnY0MdIWLBzKrnYsbrRyIZvN7sslcoHHMhcox5UFQ6X6DhZr+HTcOWxwvmm
	oFeiSLBMLmHjborZnGbpKrgUFc0Oj1/c004q1A1oCk3D4RdAp65K4vLDH82O6ZnG
	bCf5DB/23YbhDq81Z0CPMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772728168; x=
	1772814568; bh=0w7KXuf/a/2BRb3PNhiB1Eltyv6Ado83wL3c+tkjfgM=; b=U
	PZtj8jbCkLZdxWsK47n6wFzJrV0LPii9wy6jMq+Hpnkvcdv5Vn6sYwZMKyG7B/a1
	u4UZr9rXK7RbzP96a2ix1noC8jjDDRw/4/Y9K2x/indmIsw+q11vqGq64rWNlzQt
	Af85nfjyFp+Jvc0UaZ5u3Qk1vPyrXBvflI/mLXqDlwJwMKGZF8FcPaREVCfIsvy/
	SavpczJcE73mnMwqCw1KxLVzC1yc/P23Q97b0Yo+55K1CC4ZOqle2H8RtcjygBy3
	cUJcfPnG72l+VibItOlZbwpx+39L6XC0GPlYoqcqzDtXMbRH7LADKhEuQ+mqwICO
	K3qCQxN09ZlmdxQL7ZvSw==
X-ME-Sender: <xms:aK-paTZUvLTr1bIjzqtZGNrenX_sItEiqbFjBQwdb854Soyz1erZaQ>
    <xme:aK-padMyL3m7wfoGbtOiYN69jXOgiOSpV0gLMInDlvqeFV3k-1AIcRj9hZyCidOnt
    Y008qAIK5KPRDMAlVjAPHo_UHf2PjF1Vd4EdFsT5W4VxwGdGi-13tEn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegopf
    hokfffucdluddtmdenucfjughrpefotggggffhvfffufevjghfsehtkedttdertdejnecu
    hfhrohhmpeflrghvihgvrhcuvfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtf
    frrghtthgvrhhnpeetheelfedvteffieffgfekvdehieeuvdefvdfhheeivdelffejudfh
    vdeugeegleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehflhho
    shhssehjvghtmhdrmhgvpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:aK-pabolU-a6daMxJqXn-2s3EjnH8aUaVFk-Q8vX3PTFDIEj7CjXAg>
    <xmx:aK-paVmtOUEJH1zsKlKWSXP4s0mMYjDO7gCkwLDgVpsRSomfxwAuHg>
    <xmx:aK-paVG6fTTEJ0IdkyQaMJENjTi8wHS28fCR0A_iZhIzsU5zzR2APQ>
    <xmx:aK-paWoHRBFrTEFFByB4hVJHR00LAThyqGpRLausm8LC5-GwnyKUbQ>
    <xmx:aK-paV-KPfhtuLlQsATHfpP4_iYYokRoYpolIevMaCwCKOeSnW3jaO68>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5E8F11EA006C; Thu,  5 Mar 2026 11:29:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Javier Tia <floss@jetm.me>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Mar 2026 10:05:29 -0600
Subject: [PATCH 1/2] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
Cc: =?utf-8?q?linux-mediatek=40lists=2Einfradead=2Eorg=2C_Marcel_Holtmann_=3Cmarcel=40holtmann=2Eorg=3E=2C_Luiz_Augusto_von_Dentz_=3Cluiz=2Edentz=40gmail=2Ecom=3E=2C_Matthias_Brugger_=3Cmatthias=2Ebgg=40gmail=2Ecom=3E=2C_AngeloGioacchino_Del_Regno_=3Cangelogioacchino=2Edelregno=40collabora=2Ecom=3E=2C_Jean-Fran=C3=A7ois_Marli=C3=A8re_=3Cfreelance=40marliere=2Efr=3E=2C_Paul_Menzel_=3Cpmenzel=40molgen=2Empg=2Ede=3E?=@messagingengine.com
In-Reply-To: <177272816248.352280.12453518046823439297@jetm.me>
References: <177272816248.352280.12453518046823439297@jetm.me>
Message-Id: <20260305162928.5E8F11EA006C@mailuser.phl.internal>

The MediaTek MT7927 (Filogic 380) combo WiFi 7 + BT 5.4 module uses
hardware variant 0x6639 for its Bluetooth subsystem. Without this patch,
the chip fails with "Unsupported hardware variant (00006639)" or hangs
during firmware download.

Three changes are needed to support MT6639:

1. Firmware naming: MT6639 uses firmware version prefix "2_1" instead of
   "1_1" used by MT7925 and other variants. The firmware path is
   mediatek/mt6639/BT_RAM_CODE_MT6639_2_1_hdr.bin.

2. Section filtering: The MT6639 firmware binary contains 9 sections, but
   only sections with (dlmodecrctype & 0xff) == 0x01 are Bluetooth-related.
   Sending the remaining WiFi/other sections causes an irreversible BT
   subsystem hang requiring a full power cycle. This matches the Windows
   driver behavior observed via USB captures.

3. Firmware persistence: MT6639 firmware persists across BT soft power
   cycles (WMT_FUNC_CTRL=0 does not clear firmware). Skip re-download on
   subsequent setups to avoid a ~2.6s delay on each BT power toggle.

Also add 0x6639 to the reset register (CONNV3) and firmware setup switch
cases alongside the existing 0x7925 handling.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221096
Link: https://github.com/openwrt/mt76/issues/927
Assisted-by: Claude Code <noreply@anthropic.com> [claude-opus-4-6]
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/bluetooth/btmtk.c | 32 ++++++++++++++++++++++++++++++--
 drivers/bluetooth/btmtk.h |  1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 2507d587f28a..3821fde9e361 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -112,7 +112,11 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor)
 {
-	if (dev_id == 0x7925)
+	if (dev_id == 0x6639)
+		snprintf(buf, size,
+			 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_2_%x_hdr.bin",
+			 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
+	else if (dev_id == 0x7925)
 		snprintf(buf, size,
 			 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
 			 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
@@ -130,6 +134,7 @@ EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			      wmt_cmd_sync_func_t wmt_cmd_sync)
 {
+	struct btmtk_data *data = hci_get_priv(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	struct btmtk_patch_header *hdr;
 	struct btmtk_global_desc *globaldesc = NULL;
@@ -166,6 +171,14 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
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
@@ -852,7 +865,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		msleep(100);
-	} else if (dev_id == 0x7925) {
+	} else if (dev_id == 0x7925 || dev_id == 0x6639) {
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
 		if (err < 0)
 			return err;
@@ -1339,9 +1352,20 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7925:
 	case 0x7961:
 	case 0x7902:
+	case 0x6639:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
+		/* MT6639: firmware persists across BT soft power cycles
+		 * (shutdown only sends WMT_FUNC_CTRL=0). Skip re-download
+		 * on subsequent setups to avoid ~2.6s delay.
+		 */
+		if (dev_id == 0x6639 &&
+		    test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags)) {
+			bt_dev_info(hdev, "MT6639: firmware already loaded, skipping download");
+			goto skip_fw_setup_79xx;
+		}
+
 		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
 						btmtk_usb_hci_wmt_sync);
 		if (err < 0) {
@@ -1352,6 +1376,10 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 			return err;
 		}
 
+		if (dev_id == 0x6639)
+			set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
+
+skip_fw_setup_79xx:
 		/* It's Device EndPoint Reset Option Register */
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
 					      MTK_EP_RST_IN_OUT_OPT);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index adaf385626ee..6645bcadb523 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -8,6 +8,7 @@
 #define FIRMWARE_MT7902		"mediatek/BT_RAM_CODE_MT7902_1_1_hdr.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
+#define FIRMWARE_MT7927		"mediatek/mt6639/BT_RAM_CODE_MT6639_2_1_hdr.bin"
 
 #define HCI_EV_WMT 0xe4
 #define HCI_WMT_MAX_EVENT_SIZE		64
-- 
2.53.0
