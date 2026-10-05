Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0E4052B6;
	Mon,  5 Oct 2026 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791199199; cv=none; b=STRmtox0RT8fXNTfWVRzeXcKWtVRpYtIuEM2VUYK5B+NR2qhCBXJRmLWRza575cVt6M3uNcM41EVKEj2qb7lDCQym39XStRvEuCqjLyU9PBsvBYQtBT6A0r4ZnIqYFJ5pDoNGqT81fvPELRt0Gg1hBh8pnindry/DfQY7wwWVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791199199; c=relaxed/simple;
	bh=bZkKFTEOKCSBNKWBICI7W4S1ffjnYddZ/cQBLWuV16s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtDJ3HdyiETxBFHunx6+RRwK/3F1SJ2mHtiE1kbKTwbnGNnlmaRqOMMpRN5cssSb5sG0oeyk+ExSuFgTJKjaQziF5ba1C2Z1Hw+4legAYPFkyetREn8HuULozqcMS/p++VNX4IcS6WEf0azU5fuKzHsju1vZx/y8xIdro02i4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AysCdQ8j; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AysCdQ8j"
X-UUID: ada7a44ec0ae11f1b1788b6acf885367-20261005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kvpTf8mMBbKbspl3w7SLBnqh+GxvxtJzvZ6JYZZzij0=;
	b=AysCdQ8jYeeTh5r+2Y2vG8VfTy8xIKFIyHZ1mOs6YZHqHix+tB0TW+imAJJ5dORsOEcdx3vlbDurcouAndTxOfuV/5/66ACmnKpFjvSuto2YNyo5bfz0mLt1lf4ymAYkOEAeblgyJb04HYSNlEV4+BU9kqVTxpsWv7d6Zw0HKDU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:519331d7-5b27-4a37-abbc-4259039fc105,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:291e20b,CLOUDID:f07e15f2-1b1b-4e78-a2b0-48c3f94393b9,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50|
	99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ada7a44ec0ae11f1b1788b6acf885367-20261005
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 642573757; Mon, 05 Oct 2026 19:19:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Oct 2026 19:19:48 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 5 Oct 2026 19:19:48 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH] Bluetooth: btmtk: Add MT7928 support
Date: Mon, 5 Oct 2026 19:19:46 +0800
Message-ID: <20261005111946.550573-1-chris.lu@mediatek.com>
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
has no Phase 1 section. The CBMCU patch status is polled while another
download is in progress, to protect against concurrent downloads.

After CBMCU firmware loads successfully, the driver continues to load
corresponding BT firmware based on device ID through fallthrough to
case 0x7922/0x7925.

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
Assisted-by: Claude:Sonnet-5
---
 drivers/bluetooth/btmtk.c | 352 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |   3 +
 2 files changed, 355 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 115a11fcb254..87116fbb2b04 100644
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
@@ -933,6 +945,327 @@ static u32 btmtk_usb_reset_done(struct hci_dev *hdev)
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
+static int btmtk_query_cbmcu_section(struct hci_dev *hdev,
+				     wmt_cmd_sync_func_t wmt_cmd_sync,
+				     u8 cbmcu_type,
+				     const u8 *section_map,
+				     u32 cert_len)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	u8 cmd[64];
+	int status = BTMTK_WMT_INVALID, err;
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
+	err = wmt_cmd_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to query CBMCU section (%d)", err);
+		return err;
+	}
+
+	/* Query should return UNDONE status for successful section query */
+	if (status != BTMTK_WMT_PATCH_UNDONE) {
+		bt_dev_err(hdev, "CBMCU section query status error (%d)", status);
+		return -EIO;
+	}
+
+	return 0;
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
+	u32 section_num, section_offset, dl_size, cert_len;
+	bool phase1_done = false;
+	int i, err;
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
+			 MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
+
+		/* Only process MTK_SEC_CBMCU_DESC section in Phase 1 */
+		if ((le32_to_cpu(sectionmap->sectype) & 0xFFFF) != MTK_SEC_CBMCU_DESC)
+			continue;
+
+		section_offset = le32_to_cpu(sectionmap->secoffset);
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
+		cert_len = MTK_FW_ROM_PATCH_GD_SIZE +
+			   MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num +
+			   dl_size;
+
+		/* Query cbmcu section */
+		err = btmtk_query_cbmcu_section(hdev, wmt_cmd_sync, 0, NULL,
+						cert_len);
+		if (err < 0)
+			goto err_release_fw;
+
+		cert_buf = kmalloc(cert_len, GFP_KERNEL);
+		if (!cert_buf) {
+			err = -ENOMEM;
+			goto err_release_fw;
+		}
+
+		/* Copy Global Descriptor + All Section Maps */
+		memcpy(cert_buf,
+		       fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE,
+		       MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num);
+
+		/* Copy Phase 1 section data */
+		memcpy(cert_buf + MTK_FW_ROM_PATCH_GD_SIZE +
+		       MTK_FW_ROM_PATCH_SEC_MAP_SIZE * section_num,
+		       fw_ptr + section_offset,
+		       dl_size);
+
+		/* Download Phase 1 section */
+		err = btmtk_download_cbmcu_section(hdev, wmt_cmd_sync,
+						   cert_buf, cert_len);
+		kfree(cert_buf);
+		cert_buf = NULL;
+
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to download CBMCU Phase 1 section (%d)", err);
+			goto err_release_fw;
+		}
+
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
+			 MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
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
+		/* Download section data */
+		err = btmtk_download_cbmcu_section(hdev, wmt_cmd_sync,
+						   fw_ptr + section_offset,
+						   dl_size);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to download CBMCU section %d (%d)", i, err);
+			goto err_release_fw;
+		}
+	}
+
+	bt_dev_info(hdev, "CBMCU firmware download completed");
+
+err_release_fw:
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
+	if (patch_status != BTMTK_WMT_PATCH_UNDONE)
+		return 0;
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
@@ -997,6 +1330,14 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
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
@@ -1455,6 +1796,15 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7668:
 		fwname = FIRMWARE_MT7668;
 		break;
+	case 0x7935:
+		/* Requires CBMCU firmware before BT firmware */
+		err = btmtk_setup_cbmcu_firmware(hdev, btmtk_usb_hci_wmt_sync,
+						 dev_id);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to set up CBMCU firmware (%d)", err);
+			return err;
+		}
+		fallthrough;
 	case 0x7922:
 	case 0x7925:
 	case 0x7961:
@@ -1667,3 +2017,5 @@ MODULE_FIRMWARE(FIRMWARE_MT7961);
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
-- 
2.45.2

