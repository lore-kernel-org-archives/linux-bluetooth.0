Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F87403B1F;
	Tue, 30 Jun 2026 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822951; cv=none; b=SyOcA2wQBgWhpjcmIBE3HyTpEsRXgAlVHF7WiLvZ/GOHEGOCvJC92auFpXbevTMBWvJqZU21EgcmIA0KDYVxnCrPFckXofJJ0n8ZJ223EUVze6dXi5ISFTuIAtV+ADfL1axWMKChZzD00jYnGVqHQSeRX9klXyhKbZlRf8Ek3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822951; c=relaxed/simple;
	bh=rJ1rP1UxGxl5Ygi8iKVb7tG9A+PrklXsCGbFAzMedVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyZ+KYMQH7D/9Jz08lXJs9AcqV4vwNvO74ioVCiUfhKAD93VWi6uY37q8ta+tHBDHfvvgTw6tNTMYHYERgvfeHa/Jg1YEYq+vVSmVSodispiMiF2cbbAARo57qYiuYJRDhjIDQZGwmoAq9CnJqfqito0SqqlV1+vRtJyxIH2P7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TmPfRYaM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TmPfRYaM"
X-UUID: 3643dd20748011f1b1788b6acf885367-20260630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JRnmu3oqHzMzTxJHD9VcSuIRVWX8gkncwlWBavYce90=;
	b=TmPfRYaMclyjBEsHB8E/GqwyS8bB+2hXypbkvSED+BDoiX9yckjqNx7Lbx/fw/TYc9rfGb10Axle+diIFlD+yJ8RVt2Usqy/ItjJXDsjFJNsDYRvbmPHAbHPpZkTKMPEZAAN+mKZsOK3hhq3xFlaMLdO1qBEomca77TWDyfmofs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:57b3fb10-4058-49aa-96d4-fa95f0b82669,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:d497b38,CLOUDID:08652104-3795-4a90-800e-68e9393a343e,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99|100|102|156|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS
	:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3643dd20748011f1b1788b6acf885367-20260630
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 414976198; Tue, 30 Jun 2026 20:35:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 30 Jun 2026 20:35:42 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 30 Jun 2026 20:35:42 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
	Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v6 3/3] Bluetooth: btmtk: Add MT7928 support
Date: Tue, 30 Jun 2026 20:35:39 +0800
Message-ID: <20260630123539.668776-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260630123539.668776-1-chris.lu@mediatek.com>
References: <20260630123539.668776-1-chris.lu@mediatek.com>
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
the combo chip (Wi-Fi/Bluetooth's subsystem), providing a better user
experience through improved coordination between subsystems.

Implement two-phase CBMCU firmware download: Phase 1 loads section with
type 0x5 containing global descriptor, section maps and signature data;
Phase 2 loads remaining firmware sections. Add retry mechanism for
concurrent download protection.

After CBMCU firmware loads successfully, the driver continues to load
corresponding BT firmware based on device ID through fallthrough to
case 0x7922/0x7925.

The firmware(CBMCU_CODE_MT7935_1_1.bin/BT_RAM_CODE_MT7935_1_1_hdr.bin)
required for MT7928 will be scheduled for upload to linux-firmware at
a later stage.

MT7928 bring-up kernel log:
[  159.784050] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00
[  159.784107] usb 1-3: New USB device strings: Mfr=5, Product=6, SerialNumber=7
[  159.784140] usb 1-3: Product: Wireless_Device
[  159.784166] usb 1-3: Manufacturer: MediaTek Inc.
[  159.784192] usb 1-3: SerialNumber: 000000000
[  159.795736] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin
[  159.807197] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+0800
[  160.123155] Bluetooth: hci1: CBMCU firmware download completed
[  160.143013] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin
[  160.152775] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816
[  163.242266] Bluetooth: hci1: Device setup in 3367430 usecs
[  163.242280] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  163.355900] Bluetooth: hci1: AOSP extensions version v2.00
[  163.355956] Bluetooth: hci1: AOSP quality report is supported
[  163.357902] Bluetooth: MGMT ver 1.23

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 370 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h |   3 +
 2 files changed, 372 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index dc40820bfea0..157d291dfa1a 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -21,6 +21,12 @@
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
@@ -120,6 +126,11 @@ void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
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
@@ -736,6 +747,7 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_ON_UNDONE;
 		break;
 	case BTMTK_WMT_PATCH_DWNLD:
+	case BTMTK_WMT_CBMCU_DWNLD:
 		if (wmt_evt->whdr.flag == 2)
 			status = BTMTK_WMT_PATCH_DONE;
 		else if (wmt_evt->whdr.flag == 1)
@@ -872,6 +884,351 @@ static u32 btmtk_usb_reset_done(struct hci_dev *hdev)
 	return val & MTK_BT_RST_DONE;
 }
 
+static int btmtk_cbmcu_patch_status(struct hci_dev *hdev,
+				    wmt_cmd_sync_func_t wmt_cmd_sync,
+				    u8 *patch_status)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	int status, err, retry = 20;
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
+	int status, err;
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
+	struct btmtk_global_desc *globaldesc;
+	struct btmtk_section_map *sectionmap;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	u8 *cert_buf = NULL;
+	u32 section_num, section_offset, dl_size, cert_len;
+	size_t expected_size;
+	int i, err;
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load CBMCU firmware file %s (%d)",
+			   fwname, err);
+		return err;
+	}
+
+	if (fw->size < MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE) {
+		bt_dev_err(hdev, "CBMCU firmware too small: size=%zu, min=%u",
+			   fw->size,
+			   MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE);
+		err = -EINVAL;
+		goto err_release_fw;
+	}
+
+	fw_ptr = fw->data;
+	hdr = (struct btmtk_patch_header *)fw_ptr;
+	globaldesc = (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE);
+	section_num = le32_to_cpu(globaldesc->section_num);
+
+	/* Check for potential integer overflow in size calculation */
+	if (check_mul_overflow((size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE,
+			       (size_t)section_num, &expected_size) ||
+	    check_add_overflow(expected_size,
+			       (size_t)(MTK_FW_ROM_PATCH_HEADER_SIZE +
+					MTK_FW_ROM_PATCH_GD_SIZE),
+			       &expected_size)) {
+		bt_dev_err(hdev, "CBMCU firmware size calculation overflow (section_num=%u)",
+			   section_num);
+		err = -EINVAL;
+		goto err_release_fw;
+	}
+
+	if (fw->size < expected_size) {
+		bt_dev_err(hdev, "CBMCU firmware truncated: size=%zu, expected=%zu (section_num=%u)",
+			   fw->size, expected_size, section_num);
+		err = -EINVAL;
+		goto err_release_fw;
+	}
+
+	bt_dev_info(hdev, "CBMCU HW ver: 0x%04x, SW ver: 0x%04x, Build Time: %s",
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
+		if (section_offset > fw->size ||
+		    dl_size > fw->size - section_offset) {
+			bt_dev_err(hdev, "CBMCU Phase 1 section out of bounds");
+			err = -EINVAL;
+			goto err_release_fw;
+		}
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
+		break;
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
+		if (section_offset > fw->size ||
+		    dl_size > fw->size - section_offset) {
+			bt_dev_err(hdev, "CBMCU Phase 2 section %d out of bounds", i);
+			err = -EINVAL;
+			goto err_release_fw;
+		}
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
 	u32 val;
@@ -896,7 +1253,7 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 		if (err < 0)
 			return err;
 		msleep(100);
-	} else if (dev_id == 0x7925 || dev_id == 0x6639) {
+	} else if (dev_id == 0x7925 || dev_id == 0x6639 || dev_id == 0x7935) {
 		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
 		if (err < 0)
 			return err;
@@ -1381,6 +1738,15 @@ int btmtk_usb_setup(struct hci_dev *hdev)
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
 		/*
@@ -1598,3 +1964,5 @@ MODULE_FIRMWARE(FIRMWARE_MT7922);
 MODULE_FIRMWARE(FIRMWARE_MT7961);
 MODULE_FIRMWARE(FIRMWARE_MT7925);
 MODULE_FIRMWARE(FIRMWARE_MT7927);
+MODULE_FIRMWARE(FIRMWARE_MT7928);
+MODULE_FIRMWARE(FIRMWARE_MT7928_CBMCU);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 51c18dde0a80..5fe4964b031b 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -9,6 +9,8 @@
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
 #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin"
 #define FIRMWARE_MT7927		"mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin"
+#define FIRMWARE_MT7928		"mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
+#define FIRMWARE_MT7928_CBMCU	"mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
 
 #define HCI_EV_WMT 0xe4
 #define HCI_WMT_MAX_EVENT_SIZE		64
@@ -54,6 +56,7 @@ enum {
 	BTMTK_WMT_RST = 0x7,
 	BTMTK_WMT_REGISTER = 0x8,
 	BTMTK_WMT_SEMAPHORE = 0x17,
+	BTMTK_WMT_CBMCU_DWNLD = 0x58,
 };
 
 enum {
-- 
2.45.2

