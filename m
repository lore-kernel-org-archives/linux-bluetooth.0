Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DF347FC0;
	Thu,  8 Oct 2026 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449770; cv=none; b=mOl3H/0Qcc0715nGjNFL2rHG7mIZGse1mhI6fstL+3LF1YNbYxYRIA2zdHBoJ+6VKirWcJkAJ1iOMtgBLL9OCjio695lHBFd4bIENLkjrX4euR22Hk8FZJthEj08KA26lKf6hLunrNsgngezOJCwAICS1vUXCVmgB7MCzB3gu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449770; c=relaxed/simple;
	bh=4JjOWtjziUX6IcEDimLsFGwNRvk3iTYsbelj2+hvxI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W3yDAAfV/Pvoz//bVCr3Bqtj4LconfID46NwvJknekUdKmxXCN5NmP+bHPrAByPjc2+k0h8/+B1IqSwXvq12Zv+R4VRZQQ5Zk1CGtQ2ltCPWJWSHVDWGE29eUjlB01t0eLl+mh5CIBVyupbyXKbFIZiSvgWQhIqmV9w/TvY3OI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=O9DVWw5G; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O9DVWw5G"
X-UUID: 16c2c2f8c2f611f18dc8c9802ae25ab1-20261008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GCGagNyWn4R5iajKsaMCwT8/gHKbtBI62rcCPZaeNNo=;
	b=O9DVWw5GXdDpvaz4PwdFjoDygmkeUPXcZxwokAXu7Wa7nSLbl98Hrjfqc1qUwOmqwLoPBSkr5AxWL9C3n3oAuMtT7NhfyIfFOmBn0DwMANYPUBRCDEDF37su6ouf3I4T+U49n5Zr562bQEYl3Mim+PY4U1EEIT90if8j4aB/DkE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:fd9cb38b-5332-4607-af68-297234dc0dfb,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:291e20b,CLOUDID:f4a059ec-a538-4631-9c6c-6898e3cb1d37,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50|
	99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 16c2c2f8c2f611f18dc8c9802ae25ab1-20261008
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 290106920; Thu, 08 Oct 2026 16:56:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Oct 2026 16:56:01 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 8 Oct 2026 16:56:01 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4] Bluetooth: btmtk: Add MT7928 support
Date: Thu, 8 Oct 2026 16:55:59 +0800
Message-ID: <20261008085559.813654-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for MT7928 (internal device ID is MT7935) which requires
additional firmware (CBMCU firmware) loading before Bluetooth firmware.

CBMCU is a new component on MT7928 to handle common part shared across
the combo chip, providing a better user experience through improved
coordination between subsystems.

Implement two-phase CBMCU firmware download: Phase 1 loads section with
type 0x5 containing global descriptor, section maps and signature data;
Phase 2 loads remaining firmware sections. The firmware is rejected if it
has no Phase 1 section.

The CBMCU is shared with the Wi-Fi driver, which may download the same
firmware concurrently, so the firmware reports a status per section and
hands each one to a single driver. This driver downloads a section the
firmware reports as not downloaded, waits while the other driver holds
it, and leaves alone one the firmware already has. This is the scheme
btmtk_setup_firmware_79xx() already uses for the ROM patch shared with
Wi-Fi, so no host side lock is needed.

The driver then continues to load the corresponding BT firmware based on
device ID through fallthrough to case 0x7922/0x7925. A CBMCU failure is
only warned about and does not abort the setup, because the Wi-Fi driver
may finish the same download on its own. A CBMCU left unusable makes the
BT firmware download fail instead, which triggers the existing one-shot
btmtk_reset_sync() recovery.

The CBMCU firmware layout and section-map bounds are validated by
reusing btmtk_fw_validate_layout() and btmtk_fw_validate_section(),
the same helpers btmtk_setup_firmware_79xx() uses, instead of
duplicating the overflow checks.

Add the MT7928 (0x7935) case to btmtk_usb_subsys_reset(), which triggers
the subsystem reset by setting BIT(31) of MTK_BT_RESET_REG_CONNV3.

MT7928 bring-up kernel log:
[ 6931.197167] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00
[ 6931.197212] usb 1-3: New USB device strings: Mfr=5, Product=6, SerialNumber=7
[ 6931.197237] usb 1-3: Product: Wireless_Device
[ 6931.197258] usb 1-3: Manufacturer: MediaTek Inc.
[ 6931.197279] usb 1-3: SerialNumber: 000000000
[ 6931.213478] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin
[ 6931.215214] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+
[ 6931.623962] Bluetooth: hci1: CBMCU firmware download completed
[ 6931.643916] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin
[ 6931.650467] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816
[ 6935.039790] Bluetooth: hci1: Device setup in 3369644 usecs
[ 6935.039833] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[ 6935.160654] Bluetooth: hci1: AOSP extensions version v2.00
[ 6935.160710] Bluetooth: hci1: AOSP quality report is supported
[ 6935.162954] Bluetooth: MGMT ver 1.23

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: LLM
---

Changes in v4:
 - Warn instead of aborting the setup when the CBMCU download fails, and
   let the BT firmware download decide whether the chip is usable
 - Drop the -EALREADY propagation and the "downloaded" flag added in v2/v3.
   A section the firmware already has is simply skipped and the download
   carries on, the same way btmtk_setup_firmware_79xx() handles the ROM
   patch shared with Wi-Fi. This also removes the case where Phase 1 being
   done made the whole CBMCU download report success
 - Wait while the other driver holds a section instead of failing with -EIO
 - Compute the section map offsets and the Phase 1 certificate length in
   size_t, and reject a certificate longer than U32_MAX, so a malformed
   firmware cannot wrap them
 - Build the certificate buffer before querying Phase 1, so an allocation
   failure no longer leaves a section handed to this driver; do not warn
   when that allocation fails
 - Reject an unexpected CBMCU patch status instead of treating it as done

Changes in v3:
 - Reject CBMCU firmware that has no Phase 1 section
 - Document the per-section status reported by the firmware

Changes in v2:
 - btmtk_query_cbmcu_section(): wait while another driver is downloading the
   CBMCU firmware instead of failing the probe with -EIO
 drivers/bluetooth/btmtk.c | 403 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |   3 +
 2 files changed, 406 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 115a11fcb254..496a5422f556 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -22,6 +22,12 @@
 #define MTK_FW_ROM_PATCH_SEC_MAP_SIZE	64
 #define MTK_SEC_MAP_COMMON_SIZE	12
 #define MTK_SEC_MAP_NEED_SEND_SIZE	52
+#define MTK_SEC_MAP_LENGTH_SIZE	4
+#define MTK_SEC_CBMCU_DESC	0x5
+
+/* CBMCU WMT command flags */
+#define BTMTK_CBMCU_FLAG_QUERY_STATUS	0xF0
+#define BTMTK_CBMCU_FLAG_ENABLE_PATCH	0xF1
 
 /* It is for mt79xx iso data transmission setting */
 #define MTK_ISO_THRESHOLD	264
@@ -182,6 +188,11 @@ void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 		snprintf(buf, size,
 			 "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
 			 dev_id & 0xffff, dev_id & 0xffff, (fw_ver & 0xff) + 1);
+	/* MT7928 */
+	else if (dev_id == 0x7935)
+		snprintf(buf, size,
+			 "mediatek/mt7928/BT_RAM_CODE_MT%04x_1_1_hdr.bin",
+			 dev_id & 0xffff);
 	else if (dev_id == 0x7961 && fw_flavor)
 		snprintf(buf, size,
 			 "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
@@ -809,6 +820,7 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_ON_UNDONE;
 		break;
 	case BTMTK_WMT_PATCH_DWNLD:
+	case BTMTK_WMT_CBMCU_DWNLD:
 		if (wmt_evt->whdr.flag == 2)
 			status = BTMTK_WMT_PATCH_DONE;
 		else if (wmt_evt->whdr.flag == 1)
@@ -933,6 +945,373 @@ static u32 btmtk_usb_reset_done(struct hci_dev *hdev)
 	return val & MTK_BT_RST_DONE;
 }
 
+static int btmtk_cbmcu_patch_status(struct hci_dev *hdev,
+				    wmt_cmd_sync_func_t wmt_cmd_sync,
+				    u8 *patch_status)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	int status = BTMTK_WMT_INVALID, err, retry = 20;
+
+	do {
+		wmt_params.op = BTMTK_WMT_CBMCU_DWNLD;
+		wmt_params.flag = BTMTK_CBMCU_FLAG_QUERY_STATUS;
+		wmt_params.dlen = 0;
+		wmt_params.data = NULL;
+		wmt_params.status = &status;
+
+		err = wmt_cmd_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to query CBMCU patch status (%d)", err);
+			return err;
+		}
+
+		*patch_status = (u8)status;
+
+		if (*patch_status == BTMTK_WMT_PATCH_PROGRESS) {
+			msleep(100);
+			retry--;
+		} else {
+			break;
+		}
+	} while (retry > 0);
+
+	if (*patch_status == BTMTK_WMT_PATCH_PROGRESS) {
+		bt_dev_err(hdev, "CBMCU patch status query timeout");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/* Ask the firmware for the status of the given CBMCU section. A status of
+ * BTMTK_WMT_PATCH_UNDONE means the section has to be downloaded by the
+ * Bluetooth driver, and 0 is returned so the caller downloads it. A section
+ * the firmware already has is not expected here, because
+ * btmtk_setup_cbmcu_firmware() only reaches this point when the CBMCU patch
+ * as a whole is not downloaded, but it is not an error either: 1 is returned
+ * so the caller leaves that section alone. Any other status is an error.
+ */
+static int btmtk_query_cbmcu_section(struct hci_dev *hdev,
+				     wmt_cmd_sync_func_t wmt_cmd_sync,
+				     u8 cbmcu_type,
+				     const u8 *section_map,
+				     u32 cert_len)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	u8 cmd[64];
+	int status = BTMTK_WMT_INVALID, err, retry = 20;
+
+	cmd[0] = 0;
+	cmd[1] = cbmcu_type;
+
+	if (cbmcu_type == 0)
+		put_unaligned_le32(cert_len, &cmd[2]);
+	else
+		memcpy(&cmd[2], section_map, MTK_SEC_MAP_NEED_SEND_SIZE);
+
+	wmt_params.op = BTMTK_WMT_CBMCU_DWNLD;
+	wmt_params.flag = 0;
+	wmt_params.dlen = cbmcu_type ?
+		MTK_SEC_MAP_NEED_SEND_SIZE + 2 :
+		MTK_SEC_MAP_LENGTH_SIZE + 2;
+	wmt_params.data = cmd;
+	wmt_params.status = &status;
+
+	/* The CBMCU is shared with the Wi-Fi driver, which may be downloading
+	 * the same firmware. Wait while the other driver holds this section,
+	 * the same way btmtk_setup_firmware_79xx() does for the ROM patch.
+	 */
+	while (retry--) {
+		err = wmt_cmd_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to query CBMCU section (%d)", err);
+			return err;
+		}
+
+		switch (status) {
+		case BTMTK_WMT_PATCH_UNDONE:
+			/* This section has to be downloaded by the BT driver */
+			return 0;
+		case BTMTK_WMT_PATCH_DONE:
+			/* Already downloaded, nothing to do for this section */
+			return 1;
+		case BTMTK_WMT_PATCH_PROGRESS:
+			msleep(100);
+			break;
+		default:
+			bt_dev_err(hdev, "CBMCU section query status error (%d)",
+				   status);
+			return -EIO;
+		}
+	}
+
+	bt_dev_err(hdev, "CBMCU section query timeout");
+	return -ETIMEDOUT;
+}
+
+static int btmtk_download_cbmcu_section(struct hci_dev *hdev,
+					wmt_cmd_sync_func_t wmt_cmd_sync,
+					const u8 *fw_data,
+					u32 dl_size)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	u32 sent_len, total_size = dl_size;
+	int err;
+
+	wmt_params.op = BTMTK_WMT_CBMCU_DWNLD;
+	wmt_params.status = NULL;
+
+	while (dl_size > 0) {
+		sent_len = min_t(u32, 250, dl_size);
+
+		if (dl_size == total_size)
+			wmt_params.flag = BTMTK_WMT_PKT_START;
+		else if (dl_size == sent_len)
+			wmt_params.flag = BTMTK_WMT_PKT_END;
+		else
+			wmt_params.flag = BTMTK_WMT_PKT_CONTINUE;
+
+		wmt_params.dlen = sent_len;
+		wmt_params.data = fw_data;
+
+		err = wmt_cmd_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to send CBMCU section data (%d)", err);
+			return err;
+		}
+
+		dl_size -= sent_len;
+		fw_data += sent_len;
+	}
+
+	return 0;
+}
+
+static int btmtk_enable_cbmcu_patch(struct hci_dev *hdev,
+				    wmt_cmd_sync_func_t wmt_cmd_sync)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	int err;
+
+	wmt_params.op = BTMTK_WMT_CBMCU_DWNLD;
+	wmt_params.flag = BTMTK_CBMCU_FLAG_ENABLE_PATCH;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = NULL;
+
+	err = wmt_cmd_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to enable CBMCU patch (%d)", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int btmtk_load_cbmcu_firmware(struct hci_dev *hdev,
+				     const char *fwname,
+				     wmt_cmd_sync_func_t wmt_cmd_sync,
+				     u32 dev_id)
+{
+	struct btmtk_patch_header *hdr;
+	struct btmtk_section_map *sectionmap;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	u8 *cert_buf = NULL;
+	u32 section_num, section_offset, dl_size, i;
+	size_t map_len, cert_len;
+	bool phase1_done = false;
+	int err;
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load CBMCU firmware file %s (%d)",
+			   fwname, err);
+		return err;
+	}
+
+	err = btmtk_fw_validate_layout(hdev, fw, &section_num);
+	if (err < 0)
+		goto err_release_fw;
+
+	fw_ptr = fw->data;
+	hdr = (struct btmtk_patch_header *)fw_ptr;
+
+	bt_dev_info(hdev, "CBMCU HW ver: 0x%04x, SW ver: 0x%04x, Build Time: %.16s",
+		    dev_id & 0xffff, le16_to_cpu(hdr->swver), hdr->datetime);
+
+	/* Phase 1: Download section type MTK_SEC_CBMCU_DESC */
+	for (i = 0; i < section_num; i++) {
+		sectionmap = (struct btmtk_section_map *)
+			(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
+			 MTK_FW_ROM_PATCH_GD_SIZE +
+			 (size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
+
+		/* Only process MTK_SEC_CBMCU_DESC section in Phase 1 */
+		if ((le32_to_cpu(sectionmap->sectype) & 0xFFFF) != MTK_SEC_CBMCU_DESC)
+			continue;
+
+		section_offset = le32_to_cpu(sectionmap->secoffset);
+		/* Unlike the sections downloaded in Phase 2, this one carries
+		 * the signature blob rather than a download target, so its
+		 * length is secsize and not bin_info_spec.dlsize.
+		 */
+		dl_size = le32_to_cpu(sectionmap->secsize);
+
+		if (dl_size == 0)
+			continue;
+
+		err = btmtk_fw_validate_section(hdev, fw, i,
+						section_offset, dl_size);
+		if (err < 0)
+			goto err_release_fw;
+
+		map_len = MTK_FW_ROM_PATCH_GD_SIZE +
+			  (size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num;
+		if (check_add_overflow(map_len, (size_t)dl_size, &cert_len) ||
+		    cert_len > U32_MAX) {
+			err = -EINVAL;
+			goto err_release_fw;
+		}
+
+		/* Build the certificate before the query, because the firmware
+		 * hands this section over to whoever is told to download it.
+		 */
+		cert_buf = kmalloc(cert_len, GFP_KERNEL | __GFP_NOWARN);
+		if (!cert_buf) {
+			err = -ENOMEM;
+			goto err_release_fw;
+		}
+
+		/* Global Descriptor + All Section Maps, then the section data */
+		memcpy(cert_buf, fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE, map_len);
+		memcpy(cert_buf + map_len, fw_ptr + section_offset, dl_size);
+
+		/* Query cbmcu section */
+		err = btmtk_query_cbmcu_section(hdev, wmt_cmd_sync, 0, NULL,
+						cert_len);
+		if (err < 0)
+			goto err_release_fw;
+
+		/* Download the section unless the firmware already has it */
+		if (!err) {
+			err = btmtk_download_cbmcu_section(hdev, wmt_cmd_sync,
+							   cert_buf, cert_len);
+			if (err < 0) {
+				bt_dev_err(hdev, "Failed to download CBMCU Phase 1 section (%d)",
+					   err);
+				goto err_release_fw;
+			}
+		}
+
+		kfree(cert_buf);
+		cert_buf = NULL;
+		phase1_done = true;
+		break;
+	}
+
+	if (!phase1_done) {
+		bt_dev_err(hdev, "CBMCU firmware has no Phase 1 section");
+		err = -EINVAL;
+		goto err_release_fw;
+	}
+
+	/* Phase 2: Download other sections (type != MTK_SEC_CBMCU_DESC) */
+	for (i = 0; i < section_num; i++) {
+		sectionmap = (struct btmtk_section_map *)
+			(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
+			 MTK_FW_ROM_PATCH_GD_SIZE +
+			 (size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
+
+		/* Skip MTK_SEC_CBMCU_DESC section in Phase 2 */
+		if ((le32_to_cpu(sectionmap->sectype) & 0xFFFF) == MTK_SEC_CBMCU_DESC)
+			continue;
+
+		section_offset = le32_to_cpu(sectionmap->secoffset);
+		dl_size = le32_to_cpu(sectionmap->bin_info_spec.dlsize);
+
+		if (dl_size == 0)
+			continue;
+
+		err = btmtk_fw_validate_section(hdev, fw, i,
+						section_offset, dl_size);
+		if (err < 0)
+			goto err_release_fw;
+
+		/* Query cbmcu section */
+		err = btmtk_query_cbmcu_section(hdev, wmt_cmd_sync, 1,
+						(u8 *)&sectionmap->bin_info_spec,
+						0);
+		if (err < 0)
+			goto err_release_fw;
+
+		/* Nothing to do if the firmware already has this section */
+		if (err)
+			continue;
+
+		/* Download section data */
+		err = btmtk_download_cbmcu_section(hdev, wmt_cmd_sync,
+						   fw_ptr + section_offset,
+						   dl_size);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to download CBMCU section %u (%d)", i, err);
+			goto err_release_fw;
+		}
+	}
+
+	/* A section the firmware already had leaves err > 0 */
+	err = 0;
+	bt_dev_info(hdev, "CBMCU firmware download completed");
+
+err_release_fw:
+	kfree(cert_buf);
+	release_firmware(fw);
+	return err;
+}
+
+static int btmtk_setup_cbmcu_firmware(struct hci_dev *hdev,
+				      wmt_cmd_sync_func_t wmt_cmd_sync,
+				      u32 dev_id)
+{
+	char cbmcu_fwname[64];
+	u8 patch_status;
+	int err;
+
+	err = btmtk_cbmcu_patch_status(hdev, wmt_cmd_sync, &patch_status);
+	if (err < 0)
+		return err;
+
+	bt_dev_dbg(hdev, "CBMCU patch status: 0x%02x", patch_status);
+
+	/* Nothing to do if the firmware is already running */
+	if (patch_status == BTMTK_WMT_PATCH_DONE)
+		return 0;
+
+	if (patch_status != BTMTK_WMT_PATCH_UNDONE) {
+		bt_dev_err(hdev, "Unexpected CBMCU patch status (0x%02x)",
+			   patch_status);
+		return -EIO;
+	}
+
+	snprintf(cbmcu_fwname, sizeof(cbmcu_fwname),
+		 "mediatek/mt7928/CBMCU_CODE_MT%04x_1_1.bin",
+		 dev_id & 0xffff);
+
+	bt_dev_info(hdev, "Loading CBMCU firmware: %s", cbmcu_fwname);
+
+	err = btmtk_load_cbmcu_firmware(hdev, cbmcu_fwname, wmt_cmd_sync, dev_id);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to download CBMCU firmware (%d)", err);
+		return err;
+	}
+
+	err = btmtk_enable_cbmcu_patch(hdev, wmt_cmd_sync);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 {
 	int reset_err = 0;
@@ -997,6 +1376,14 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err)
 			return err;
 		msleep(100);
+	} else if (dev_id == 0x7935) {
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err)
+			return err;
+		val |= BIT(31);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
 	} else {
 		/* It's Device EndPoint Reset Option Register */
 		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
@@ -1455,6 +1842,20 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7668:
 		fwname = FIRMWARE_MT7668;
 		break;
+	case 0x7935:
+		/* Requires CBMCU firmware before BT firmware */
+		err = btmtk_setup_cbmcu_firmware(hdev, btmtk_usb_hci_wmt_sync,
+						 dev_id);
+		/* Carry on with the BT firmware even if this failed. The Wi-Fi
+		 * driver may be downloading the same CBMCU firmware and finish
+		 * it on its own, and if the CBMCU is left unusable the BT
+		 * firmware download below fails and triggers the one-shot
+		 * btmtk_reset_sync() recovery.
+		 */
+		if (err < 0)
+			bt_dev_warn(hdev, "Failed to set up CBMCU firmware (%d)",
+				    err);
+		fallthrough;
 	case 0x7922:
 	case 0x7925:
 	case 0x7961:
@@ -1667,3 +2068,5 @@ MODULE_FIRMWARE(FIRMWARE_MT7961);
 MODULE_FIRMWARE(FIRMWARE_MT7920);
 MODULE_FIRMWARE(FIRMWARE_MT7925);
 MODULE_FIRMWARE(FIRMWARE_MT7927);
+MODULE_FIRMWARE(FIRMWARE_MT7928);
+MODULE_FIRMWARE(FIRMWARE_MT7928_CBMCU);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index e8ad281a93a0..58643ec39667 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -10,6 +10,8 @@
 #define FIRMWARE_MT7920		"mediatek/BT_RAM_CODE_MT7961_1a_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
 #define FIRMWARE_MT7927		"mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin"
+#define FIRMWARE_MT7928		"mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
+#define FIRMWARE_MT7928_CBMCU	"mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
 
 #define HCI_EV_WMT 0xe4
 #define HCI_WMT_MAX_EVENT_SIZE		64
@@ -55,6 +57,7 @@ enum {
 	BTMTK_WMT_RST = 0x7,
 	BTMTK_WMT_REGISTER = 0x8,
 	BTMTK_WMT_SEMAPHORE = 0x17,
+	BTMTK_WMT_CBMCU_DWNLD = 0x58,
 };
 
 enum {

base-commit: 036d4119079a757c9d1b4d35205c7c467f0018fb
-- 
2.45.2

