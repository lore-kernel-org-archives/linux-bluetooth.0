Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03429374C4;
	Tue,  8 Jul 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978742; cv=none; b=USBxF0eBBkjSDaR+wcHggPbFFbk+vtumQHrw6zhLp34TUoEqpg3RaQqpjArwb4uJK1Ia4uoMDc5+SsU0ULZ/TV6jMGX1h0B4q9v9JlnWTjgDT+j5FDsp1Va2/Y/2TLjlWUNQE7qL1xmaYqu5NZyPG3k6hecl425Eitvt/zZulfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978742; c=relaxed/simple;
	bh=25rkmgqKQOS42fG/BRpMF84Kcc60DtJ8jX4xovxI35U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N7OAcen3m0lmyIiX0uybHiv61imhqIfIKRIIoWx24OzKq2C7b8osz0aJBNQJrpV38X02pbUPgIfwGjwZscynftaqtUzDBNI3H+xWaNIsMbvIejVQYq/8WVqiyqQM070bnX8earg/Wme0g7ETk37RwjE2+jXCzsw/s3vNJadqoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HO1ZTy1T; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HO1ZTy1T"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 568CjSWf93728236, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751978729; bh=RH5lK65dzixmFfupK79A2QzKkOsH162v83PCR6VsxTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=HO1ZTy1T7TNKWQwj22kjLVWZWLUY5R4GQI5Fw/SbHdDBDqckbMA3oaHWZDxHxvcXf
	 GkplpQR45K5fKesIHQ8yt5UVOpOnmF1fUgR2Z1fo0YORMbP7XvVjIoWgGZpaaZ/XfO
	 yEriiWs7TwoDPenV+14eVAhAKukug5XEZYNhGvP0CczMpBm67inw+7GOnJfpSmCC7U
	 pHu4PURov/APCvghW/Jy+XO6beZtwCiAin7bE946vBksMgzwRheakuDUXujeMJgsAX
	 mKFC8D4+lGaCYoydW95DXYuRkjqJt5V9ich843VaWhds/+QI9C0P1iLCTfWQl8j6Sh
	 JfYtNfriqGD2g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 568CjSWf93728236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 20:45:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 20:45:58 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 8 Jul
 2025 20:45:53 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>
Subject: [PATCH v3 1/2] Bluetooth: btrtl: Firmware format v3 support
Date: Tue, 8 Jul 2025 20:45:15 +0800
Message-ID: <20250708124516.2836881-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Realtek changed the format of the firmware file as v3. The driver
should implement the patch to extract the firmware data from the
firmware file. The future chips must apply this patch for firmware loading.
This patch is compatible with the both previous format, v2 and v3 as well.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change in V3:
- Fixed cocci warning

Change in V2:
- Fill in the missing symbols
- Fix build warnings
---
---
 drivers/bluetooth/btrtl.c | 669 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btrtl.h | 102 ++++++
 drivers/bluetooth/btusb.c |   3 +
 3 files changed, 766 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7838c89e529e..af28f5355aa1 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -22,6 +22,12 @@
 #define RTL_CHIP_8723CS_XX	5
 #define RTL_EPATCH_SIGNATURE	"Realtech"
 #define RTL_EPATCH_SIGNATURE_V2	"RTBTCore"
+#define RTL_EPATCH_SIGNATURE_V3	"BTNIC003"
+#define RTL_PATCH_V3_1			0x01
+#define RTL_PATCH_V3_PATCH_IMAGE	0x02
+#define IMAGE_ID_F000		0xf000
+#define IMAGE_ID_F001		0xf001
+#define IMAGE_ID_F002		0xf002
 #define RTL_ROM_LMP_8703B	0x8703
 #define RTL_ROM_LMP_8723A	0x1200
 #define RTL_ROM_LMP_8723B	0x8723
@@ -72,6 +78,7 @@ enum btrtl_chip_id {
 	CHIP_ID_8851B = 36,
 	CHIP_ID_8922A = 44,
 	CHIP_ID_8852BT = 47,
+	CHIP_ID_8922D = 55,
 };
 
 struct id_table {
@@ -98,8 +105,11 @@ struct btrtl_device_info {
 	int cfg_len;
 	bool drop_fw;
 	int project_id;
+	u32 opcode;
+	u8 fw_type;
 	u8 key_id;
 	struct list_head patch_subsecs;
+	struct list_head patch_images;
 };
 
 static const struct id_table ic_id_table[] = {
@@ -328,6 +338,15 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8852btu_fw",
 	  .cfg_name = "rtl_bt/rtl8852btu_config",
 	  .hw_info  = "rtl8852btu" },
+
+	/* 8922DU */
+	{ IC_INFO(RTL_ROM_LMP_8922A, 0xd, 0xe, HCI_USB),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8922du_fw",
+	  .cfg_name = "rtl_bt/rtl8922du_config",
+	  .hw_info  = "rtl8922du" },
 	};
 
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
@@ -361,6 +380,33 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
 	return &ic_id_table[i];
 }
 
+static int btrtl_read_chip_id(struct hci_dev *hdev, u8 *chip_id)
+{
+	struct rtl_rp_read_chip_id *rp;
+	struct sk_buff *skb;
+
+	/* Read RTL chip id command */
+	skb = __hci_cmd_sync(hdev, 0xfc6f, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	if (skb->len != sizeof(*rp)) {
+		rtl_dev_err(hdev, "read chip id event length mismatch");
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	rp = (struct rtl_rp_read_chip_id *)skb->data;
+	rtl_dev_info(hdev, "chip_id status=0x%02x id=0x%02x",
+		     rp->status, rp->chip_id);
+
+	if (chip_id)
+		*chip_id = rp->chip_id;
+
+	kfree_skb(skb);
+	return 0;
+}
+
 static struct sk_buff *btrtl_read_local_version(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -439,6 +485,26 @@ static int btrtl_vendor_read_reg16(struct hci_dev *hdev,
 	return 0;
 }
 
+static int btrtl_vendor_write_mem(struct hci_dev *hdev, u32 addr, u32 val)
+{
+	struct rtl_vendor_write_cmd cp;
+	struct sk_buff *skb;
+	int err = 0;
+
+	cp.type = 0x21;
+	cp.addr = cpu_to_le32(addr);
+	cp.val = cpu_to_le32(val);
+	skb = __hci_cmd_sync(hdev, 0xfc62, sizeof(cp), &cp, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "RTL: Write mem32 failed (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
 static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
 {
 	void *data = iov->data;
@@ -452,6 +518,30 @@ static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
 	return data;
 }
 
+static void btrtl_insert_ordered_patch_image(struct rtl_section_patch_image *image,
+					     struct btrtl_device_info *btrtl_dev)
+{
+	struct list_head *pos;
+	struct list_head *next;
+	struct rtl_section_patch_image *node;
+
+	list_for_each_safe(pos, next, &btrtl_dev->patch_images) {
+		node = list_entry(pos, struct rtl_section_patch_image, list);
+
+		if (node->image_id > image->image_id) {
+			__list_add(&image->list, pos->prev, pos);
+			return;
+		}
+
+		if (node->image_id == image->image_id &&
+		    node->index > image->index) {
+			__list_add(&image->list, pos->prev, pos);
+			return;
+		}
+	}
+	__list_add(&image->list, pos->prev, pos);
+}
+
 static void btrtl_insert_ordered_subsec(struct rtl_subsection *node,
 					struct btrtl_device_info *btrtl_dev)
 {
@@ -629,6 +719,295 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 		return -EPERM;
 
 	*_buf = ptr;
+	btrtl_dev->fw_type = FW_TYPE_V2;
+	return len;
+}
+
+static int rtlbt_parse_config(struct hci_dev *hdev,
+			      struct rtl_section_patch_image *patch_image,
+			      struct btrtl_device_info *btrtl_dev)
+{
+	const struct id_table *ic_info = NULL;
+	const struct firmware *fw;
+	char tmp_name[32];
+	char filename[64];
+	u8 *cfg_buf;
+	char *str;
+	char *p;
+	int len;
+	int ret;
+
+	if (btrtl_dev && btrtl_dev->ic_info)
+		ic_info = btrtl_dev->ic_info;
+
+	if (!ic_info)
+		return -EINVAL;
+
+	str = ic_info->cfg_name;
+	if (btrtl_dev->fw_type == FW_TYPE_V3_1) {
+		if (!patch_image->image_id && !patch_image->index) {
+			snprintf(filename, sizeof(filename), "%s.bin", str);
+			goto load_fw;
+		}
+		goto done;
+	}
+
+	len = strlen(str);
+	if (len > sizeof(tmp_name) - 1)
+		len = sizeof(tmp_name) - 1;
+	memcpy(tmp_name, str, len);
+	tmp_name[len] = '\0';
+
+	str = tmp_name;
+	p = strsep(&str, ".");
+
+	ret = snprintf(filename, sizeof(filename), "%s", p);
+	if (patch_image->config_rule && patch_image->need_config) {
+		switch (patch_image->image_id) {
+		case IMAGE_ID_F000:
+		case IMAGE_ID_F001:
+		case IMAGE_ID_F002:
+			ret += snprintf(filename + ret, sizeof(filename) - ret,
+					"_%04x", patch_image->image_id);
+			break;
+		default:
+			goto done;
+		}
+	} else {
+		goto done;
+	}
+
+	if (str)
+		snprintf(filename + ret, sizeof(filename) - ret, ".%s", str);
+	else
+		snprintf(filename + ret, sizeof(filename) - ret, ".bin");
+load_fw:
+	rtl_dev_info(hdev, "config file: %s", filename);
+	ret = request_firmware(&fw, filename, &hdev->dev);
+	if (ret < 0) {
+		rtl_dev_err(hdev, "request_firmware [%s] error", filename);
+		if (btrtl_dev->fw_type == FW_TYPE_V3_2) {
+			len = 4;
+			cfg_buf = kvmalloc(len, GFP_KERNEL);
+			if (!cfg_buf)
+				return -ENOMEM;
+
+			memset(cfg_buf, 0xff, len);
+			patch_image->cfg_buf = cfg_buf;
+			patch_image->cfg_len = len;
+			return 0;
+		}
+		goto err_req_fw;
+	}
+	cfg_buf = kvmalloc(fw->size, GFP_KERNEL);
+	if (!cfg_buf) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	memcpy(cfg_buf, fw->data, fw->size);
+	len = fw->size;
+	release_firmware(fw);
+
+	patch_image->cfg_buf = cfg_buf;
+	patch_image->cfg_len = len;
+done:
+	return 0;
+err:
+	release_firmware(fw);
+err_req_fw:
+	return ret;
+}
+
+static int rtlbt_parse_section_v3(struct hci_dev *hdev,
+				  struct btrtl_device_info *btrtl_dev,
+				  u32 opcode, u8 *data, u32 len)
+{
+	struct rtl_section_patch_image *patch_image;
+	struct rtl_patch_image_hdr *hdr;
+	u16 image_id;
+	u16 chip_id;
+	u32 patch_image_len;
+	u8 *ptr;
+	int ret = 0;
+	u8 i;
+	struct rtl_iovec iov = {
+		.data = data,
+		.len  = len,
+	};
+
+	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
+	if (!hdr)
+		return -EINVAL;
+
+	if (btrtl_dev->opcode && btrtl_dev->opcode != opcode) {
+		rtl_dev_err(hdev, "invalid opcode 0x%02x", opcode);
+		return -EINVAL;
+	}
+
+	if (!btrtl_dev->opcode) {
+		btrtl_dev->opcode = opcode;
+		switch (btrtl_dev->opcode) {
+		case RTL_PATCH_V3_1:
+			btrtl_dev->fw_type = FW_TYPE_V3_1;
+			break;
+		case RTL_PATCH_V3_PATCH_IMAGE:
+			btrtl_dev->fw_type = FW_TYPE_V3_2;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	patch_image_len = (u32)le64_to_cpu(hdr->patch_image_len);
+	chip_id = le16_to_cpu(hdr->chip_id);
+	image_id = le16_to_cpu(hdr->image_id);
+	rtl_dev_info(hdev, "image (%04x:%02x), chip id %u, cut 0x%02x, len %08x"
+		     , image_id, hdr->index, chip_id, hdr->ic_cut,
+		     patch_image_len);
+
+	if (btrtl_dev->key_id && btrtl_dev->key_id != hdr->key_id) {
+		rtl_dev_err(hdev, "invalid key_id (%u, %u)", hdr->key_id,
+			    btrtl_dev->key_id);
+		return -EINVAL;
+	}
+
+	if (hdr->ic_cut != btrtl_dev->rom_version + 1) {
+		rtl_dev_info(hdev, "unused ic_cut (%u, %u)", hdr->ic_cut,
+			    btrtl_dev->rom_version + 1);
+		return -EINVAL;
+	}
+
+	if (btrtl_dev->fw_type == FW_TYPE_V3_1 && !btrtl_dev->project_id)
+		btrtl_dev->project_id = chip_id;
+
+	if (btrtl_dev->fw_type == FW_TYPE_V3_2 &&
+	    chip_id != btrtl_dev->project_id) {
+		rtl_dev_err(hdev, "invalid chip_id (%u, %d)", chip_id,
+			    btrtl_dev->project_id);
+		return -EINVAL;
+	}
+
+	ptr = rtl_iov_pull_data(&iov, patch_image_len);
+	if (!ptr)
+		return -ENODATA;
+
+	patch_image = kzalloc(sizeof(*patch_image), GFP_KERNEL);
+	if (!patch_image)
+		return -ENOMEM;
+	patch_image->index = hdr->index;
+	patch_image->image_id = image_id;
+	patch_image->config_rule = hdr->config_rule;
+	patch_image->need_config = hdr->need_config;
+
+	for (i = 0; i < DL_FIX_ADDR_MAX; i++) {
+		patch_image->fix[i].addr =
+			(u32)le64_to_cpu(hdr->addr_fix[i * 2]);
+		patch_image->fix[i].value =
+			(u32)le64_to_cpu(hdr->addr_fix[i * 2 + 1]);
+	}
+
+	patch_image->image_len = patch_image_len;
+	patch_image->image_data = kvmalloc(patch_image_len, GFP_KERNEL);
+	if (!patch_image->image_data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	memcpy(patch_image->image_data, ptr, patch_image_len);
+	patch_image->image_ver =
+		get_unaligned_le32(ptr + patch_image->image_len - 4);
+	rtl_dev_info(hdev, "image version: %08x", patch_image->image_ver);
+
+	rtlbt_parse_config(hdev, patch_image, btrtl_dev);
+
+	ret = patch_image->image_len;
+
+	btrtl_insert_ordered_patch_image(patch_image, btrtl_dev);
+
+	return ret;
+err:
+	kfree(patch_image);
+	return ret;
+}
+
+static int rtlbt_parse_firmware_v3(struct hci_dev *hdev,
+				   struct btrtl_device_info *btrtl_dev)
+{
+	struct rtl_epatch_header_v3 *hdr;
+	int rc;
+	u32 num_sections;
+	struct rtl_section_v3 *section;
+	u32 section_len;
+	u32 opcode;
+	int len = 0;
+	int i;
+	u8 *ptr;
+	struct rtl_iovec iov = {
+		.data = btrtl_dev->fw_data,
+		.len  = btrtl_dev->fw_len,
+	};
+	struct rtl_vendor_cmd cmd_data = { {0x10, 0xa4, 0xad, 0x00, 0xb0} };
+	u8 reg_val[2];
+
+	if (btrtl_dev->project_id >= CHIP_ID_8922D) {
+		/* A0010DA4 */
+		cmd_data.param[2] = 0x0d;
+		cmd_data.param[3] = 0x01;
+		cmd_data.param[4] = 0xa0;
+	}
+
+	rc = btrtl_vendor_read_reg16(hdev, &cmd_data, reg_val);
+	if (rc < 0)
+		return -EIO;
+
+	rtl_dev_info(hdev, "key id %u", reg_val[0]);
+
+	btrtl_dev->key_id = reg_val[0];
+
+	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
+	if (!hdr)
+		return -EINVAL;
+	num_sections = le32_to_cpu(hdr->num_sections);
+
+	rtl_dev_dbg(hdev, "timpstamp %08x-%08x", *((u32 *)hdr->timestamp),
+		    *((u32 *)(hdr->timestamp + 4)));
+
+	for (i = 0; i < num_sections; i++) {
+		section = rtl_iov_pull_data(&iov, sizeof(*section));
+		if (!section)
+			break;
+
+		section_len = (u32)le64_to_cpu(section->len);
+		opcode = le32_to_cpu(section->opcode);
+
+		rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
+
+		ptr = rtl_iov_pull_data(&iov, section_len);
+		if (!ptr)
+			break;
+
+		rc = 0;
+		switch (opcode) {
+		case RTL_PATCH_V3_1:
+		case RTL_PATCH_V3_PATCH_IMAGE:
+			rc = rtlbt_parse_section_v3(hdev, btrtl_dev, opcode,
+						    ptr, section_len);
+			break;
+		default:
+			rtl_dev_warn(hdev, "Unknown opcode %08x", opcode);
+			break;
+		}
+		if (rc < 0) {
+			rtl_dev_err(hdev, "Parse section (%u) err (%d)",
+				    opcode, rc);
+			continue;
+		}
+		len += rc;
+	}
+
+	rtl_dev_info(hdev, "image payload total len: 0x%08x", len);
+	if (!len)
+		return -ENODATA;
+
 	return len;
 }
 
@@ -673,6 +1052,9 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	if (btrtl_dev->fw_len <= 8)
 		return -EINVAL;
 
+	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V3, 8))
+		return rtlbt_parse_firmware_v3(hdev, btrtl_dev);
+
 	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8))
 		min_size = sizeof(struct rtl_epatch_header) +
 				sizeof(extension_sig) + 3;
@@ -808,10 +1190,11 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	memcpy(buf + patch_length - 4, &epatch_info->fw_version, 4);
 
 	*_buf = buf;
+	btrtl_dev->fw_type = FW_TYPE_V1;
 	return len;
 }
 
-static int rtl_download_firmware(struct hci_dev *hdev,
+static int rtl_download_firmware(struct hci_dev *hdev, u8 fw_type,
 				 const unsigned char *data, int fw_len)
 {
 	struct rtl_download_cmd *dl_cmd;
@@ -822,6 +1205,13 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	int j = 0;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *rp;
+	u8 dl_rp_len = sizeof(struct rtl_download_response);
+
+	if (is_v3_fw(fw_type)) {
+		j = 1;
+		if (fw_type == FW_TYPE_V3_2)
+			dl_rp_len++;
+	}
 
 	dl_cmd = kmalloc(sizeof(*dl_cmd), GFP_KERNEL);
 	if (!dl_cmd)
@@ -834,7 +1224,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 		if (dl_cmd->index == 0x7f)
 			j = 1;
 
-		if (i == (frag_num - 1)) {
+		if (i == (frag_num - 1) && !is_v3_fw(fw_type)) {
 			dl_cmd->index |= 0x80; /* data end */
 			frag_len = fw_len % RTL_FRAG_LEN;
 		}
@@ -852,7 +1242,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 			goto out;
 		}
 
-		if (skb->len != sizeof(struct rtl_download_response)) {
+		if (skb->len != dl_rp_len) {
 			rtl_dev_err(hdev, "download fw event length mismatch");
 			kfree_skb(skb);
 			ret = -EIO;
@@ -863,6 +1253,9 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 		data += RTL_FRAG_LEN;
 	}
 
+	if (is_v3_fw(fw_type))
+		goto out;
+
 	skb = btrtl_read_local_version(hdev);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
@@ -880,6 +1273,226 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	return ret;
 }
 
+static int rtl_check_download_state(struct hci_dev *hdev,
+				    struct btrtl_device_info *btrtl_dev)
+{
+	struct sk_buff *skb;
+	int ret = 0;
+	u8 state;
+
+	skb = __hci_cmd_sync(hdev, 0xfdcf, 0, NULL, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		rtl_dev_err(hdev, "write tb error %lu", PTR_ERR(skb));
+		return -EIO;
+	}
+
+	/* Other driver might be downloading the combined firmware. */
+	state = skb->data[0];
+	kfree_skb(skb);
+	if (state == 0x03) {
+		btrealtek_set_flag(hdev, REALTEK_DOWNLOADING);
+		ret = btrealtek_wait_on_flag_timeout(hdev, REALTEK_DOWNLOADING,
+						     TASK_INTERRUPTIBLE,
+						     msecs_to_jiffies(5000));
+		if (ret == -EINTR) {
+			bt_dev_err(hdev, "Firmware loading interrupted");
+			return ret;
+		}
+
+		if (ret) {
+			bt_dev_err(hdev, "Firmware loading timeout");
+			return -ETIMEDOUT;
+		}
+
+		ret = -EALREADY;
+	}
+
+	return 0;
+}
+
+static int rtl_finalize_download(struct hci_dev *hdev,
+				 struct btrtl_device_info *btrtl_dev)
+{
+	struct hci_rp_read_local_version *rp_ver;
+	u8 params[2] = { 0x03, 0xb2 };
+	struct sk_buff *skb;
+	u16 opcode;
+	u32 len;
+	int ret;
+
+	opcode = 0xfc8e;
+	len = 2;
+	if (btrtl_dev->opcode == RTL_PATCH_V3_1) {
+		opcode = 0xfc20;
+		params[0] = 0x80;
+		len = 1;
+	}
+	skb = __hci_cmd_sync(hdev, opcode, len, params, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		rtl_dev_err(hdev, "Watchdog reset err (%ld)", PTR_ERR(skb));
+		return -EIO;
+	}
+	rtl_dev_info(hdev, "Watchdog reset status %02x", skb->data[0]);
+	kfree_skb(skb);
+
+	skb = btrtl_read_local_version(hdev);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		rtl_dev_err(hdev, "read local version failed (%d)", ret);
+		return ret;
+	}
+
+	rp_ver = (struct hci_rp_read_local_version *)skb->data;
+	rtl_dev_info(hdev, "fw version 0x%04x%04x",
+		     __le16_to_cpu(rp_ver->hci_rev),
+		     __le16_to_cpu(rp_ver->lmp_subver));
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int rtl_security_check(struct hci_dev *hdev,
+			      struct btrtl_device_info *btrtl_dev)
+{
+	struct rtl_section_patch_image *tmp = NULL;
+	struct rtl_section_patch_image *image = NULL;
+	u32 val;
+	int ret;
+
+	list_for_each_entry_reverse(tmp, &btrtl_dev->patch_images, list) {
+		/* Check security hdr */
+		if (!tmp->fix[DL_FIX_SEC_HDR_ADDR].value ||
+		    !tmp->fix[DL_FIX_SEC_HDR_ADDR].addr ||
+		    tmp->fix[DL_FIX_SEC_HDR_ADDR].addr == 0xffffffff)
+			continue;
+		rtl_dev_info(hdev, "addr 0x%08x, value 0x%08x",
+			     tmp->fix[DL_FIX_SEC_HDR_ADDR].addr,
+			     tmp->fix[DL_FIX_SEC_HDR_ADDR].value);
+		image = tmp;
+		break;
+	}
+
+	if (!image)
+		return 0;
+
+	rtl_dev_info(hdev, "sec image (%04x:%02x)", image->image_id,
+		     image->index);
+	val = image->fix[DL_FIX_PATCH_ADDR].value + image->image_len -
+					image->fix[DL_FIX_SEC_HDR_ADDR].value;
+	ret = btrtl_vendor_write_mem(hdev, image->fix[DL_FIX_PATCH_ADDR].addr,
+				     val);
+	if (ret) {
+		rtl_dev_err(hdev, "write sec reg failed (%d)", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int rtl_download_firmware_v3(struct hci_dev *hdev,
+				    struct btrtl_device_info *btrtl_dev)
+{
+	struct rtl_section_patch_image *image, *tmp;
+	struct rtl_rp_dl_v3 *rp;
+	struct sk_buff *skb;
+	u8 *fw_data;
+	int fw_len;
+	int ret = 0;
+	u8 i;
+
+	if (btrtl_dev->fw_type == FW_TYPE_V3_2) {
+		ret = rtl_check_download_state(hdev, btrtl_dev);
+		if (ret) {
+			if (ret == -EALREADY)
+				return 0;
+			return ret;
+		}
+	}
+
+	list_for_each_entry_safe(image, tmp, &btrtl_dev->patch_images, list) {
+		rtl_dev_dbg(hdev, "image (%04x:%02x)", image->image_id,
+			    image->index);
+
+		for (i = DL_FIX_CI_ID; i < DL_FIX_ADDR_MAX; i++) {
+			if (!image->fix[i].addr ||
+			    image->fix[i].addr == 0xffffffff) {
+				rtl_dev_dbg(hdev, "no need to write addr %08x",
+					    image->fix[i].addr);
+				continue;
+			}
+			rtl_dev_dbg(hdev, "write addr and val, 0x%08x, 0x%08x",
+				    image->fix[i].addr, image->fix[i].value);
+			if (btrtl_vendor_write_mem(hdev, image->fix[i].addr,
+						   image->fix[i].value)) {
+				rtl_dev_err(hdev, "write reg failed");
+				ret = -EIO;
+				goto done;
+			}
+		}
+
+		fw_len = image->image_len + image->cfg_len;
+		fw_data = kvmalloc(fw_len, GFP_KERNEL);
+		if (!fw_data) {
+			rtl_dev_err(hdev, "Couldn't alloc buf for image data");
+			ret = -ENOMEM;
+			goto done;
+		}
+		memcpy(fw_data, image->image_data, image->image_len);
+		if (image->cfg_len > 0)
+			memcpy(fw_data + image->image_len, image->cfg_buf,
+			       image->cfg_len);
+
+		rtl_dev_dbg(hdev, "patch image (%04x:%02x). len: %d",
+			    image->image_id, image->index, fw_len);
+		rtl_dev_dbg(hdev, "fw_data %p, image buf %p, len %u", fw_data,
+			    image->image_data, image->image_len);
+
+		ret = rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data,
+					    fw_len);
+		kvfree(fw_data);
+		if (ret < 0) {
+			rtl_dev_err(hdev, "download firmware failed (%d)", ret);
+			goto done;
+		}
+
+		if (image->list.next != &btrtl_dev->patch_images &&
+		    image->image_id == tmp->image_id)
+			continue;
+
+		if (btrtl_dev->fw_type == FW_TYPE_V3_1)
+			continue;
+
+		i = 0x80;
+		skb = __hci_cmd_sync(hdev, 0xfc20, 1, &i, HCI_CMD_TIMEOUT);
+		if (IS_ERR(skb)) {
+			ret = -EIO;
+			rtl_dev_err(hdev, "Failed to issue last cmd fc20, %ld",
+				    PTR_ERR(skb));
+			goto done;
+		}
+		rp = (void *)skb->data;
+		ret = rp->err;
+		kfree_skb(skb);
+		if (ret == 2) {
+			/* Verification failure */
+			ret = -EFAULT;
+			goto done;
+		}
+	}
+
+	if (btrtl_dev->fw_type == FW_TYPE_V3_1) {
+		ret = rtl_security_check(hdev, btrtl_dev);
+		if (ret) {
+			rtl_dev_err(hdev, "Security check failed (%d)", ret);
+			goto done;
+		}
+	}
+
+	ret = rtl_finalize_download(hdev, btrtl_dev);
+
+done:
+	return ret;
+}
+
 static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 {
 	const struct firmware *fw;
@@ -913,7 +1526,7 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	return rtl_download_firmware(hdev, btrtl_dev->fw_data,
+	return rtl_download_firmware(hdev, FW_TYPE_V0, btrtl_dev->fw_data,
 				     btrtl_dev->fw_len);
 }
 
@@ -928,7 +1541,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 	if (ret < 0)
 		goto out;
 
-	if (btrtl_dev->cfg_len > 0) {
+	if (!is_v3_fw(btrtl_dev->fw_type) && btrtl_dev->cfg_len > 0) {
 		tbuff = kvzalloc(ret + btrtl_dev->cfg_len, GFP_KERNEL);
 		if (!tbuff) {
 			ret = -ENOMEM;
@@ -944,9 +1557,14 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 		fw_data = tbuff;
 	}
 
+	if (is_v3_fw(btrtl_dev->fw_type)) {
+		ret = rtl_download_firmware_v3(hdev, btrtl_dev);
+		goto out;
+	}
+
 	rtl_dev_info(hdev, "cfg_sz %d, total sz %d", btrtl_dev->cfg_len, ret);
 
-	ret = rtl_download_firmware(hdev, fw_data, ret);
+	ret = rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data, ret);
 
 out:
 	kvfree(fw_data);
@@ -1042,6 +1660,7 @@ static int rtl_read_chip_type(struct hci_dev *hdev, u8 *type)
 void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
 	struct rtl_subsection *entry, *tmp;
+	struct rtl_section_patch_image *image, *next;
 
 	kvfree(btrtl_dev->fw_data);
 	kvfree(btrtl_dev->cfg_data);
@@ -1051,6 +1670,13 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev)
 		kfree(entry);
 	}
 
+	list_for_each_entry_safe(image, next, &btrtl_dev->patch_images, list) {
+		list_del(&image->list);
+		kvfree(image->image_data);
+		kvfree(image->cfg_buf);
+		kfree(image);
+	}
+
 	kfree(btrtl_dev);
 }
 EXPORT_SYMBOL_GPL(btrtl_free);
@@ -1058,7 +1684,7 @@ EXPORT_SYMBOL_GPL(btrtl_free);
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 					   const char *postfix)
 {
-	struct btrealtek_data *coredump_info = hci_get_priv(hdev);
+	struct btrealtek_data *btrtl_data = hci_get_priv(hdev);
 	struct btrtl_device_info *btrtl_dev;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
@@ -1069,6 +1695,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
 	u8 reg_val[2];
+	u8 chip_id = 0;
 
 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
 	if (!btrtl_dev) {
@@ -1077,8 +1704,15 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	}
 
 	INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
+	INIT_LIST_HEAD(&btrtl_dev->patch_images);
 
 check_version:
+	ret = btrtl_read_chip_id(hdev, &chip_id);
+	if (!ret && chip_id == CHIP_ID_8922D) {
+		btrtl_dev->project_id = chip_id;
+		goto read_local_ver;
+	}
+
 	ret = btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
 	if (ret < 0)
 		goto err_free;
@@ -1101,6 +1735,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		}
 	}
 
+read_local_ver:
 	skb = btrtl_read_local_version(hdev);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
@@ -1228,7 +1863,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		hci_set_msft_opcode(hdev, 0xFCF0);
 
 	if (btrtl_dev->ic_info)
-		coredump_info->rtl_dump.controller = btrtl_dev->ic_info->hw_info;
+		btrtl_data->rtl_dump.controller = btrtl_dev->ic_info->hw_info;
 
 	return btrtl_dev;
 
@@ -1301,6 +1936,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8851B:
 	case CHIP_ID_8922A:
 	case CHIP_ID_8852BT:
+	case CHIP_ID_8922D:
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
 		/* RTL8852C needs to transmit mSBC data continuously without
@@ -1387,6 +2023,23 @@ int btrtl_shutdown_realtek(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
 
+int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *)skb->data;
+
+	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
+	    hdr->plen > 0) {
+		if (skb->data[2] == 0x77 &&
+		    btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADING)) {
+			btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING);
+			return 0;
+		}
+	}
+
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL_GPL(btrtl_recv_event);
+
 static unsigned int btrtl_convert_baudrate(u32 device_baudrate)
 {
 	switch (device_baudrate) {
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index a2d9d34f9fb0..f6f03a5fefba 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -12,6 +12,19 @@
 #define rtl_dev_info(dev, fmt, ...) bt_dev_info(dev, "RTL: " fmt, ##__VA_ARGS__)
 #define rtl_dev_dbg(dev, fmt, ...) bt_dev_dbg(dev, "RTL: " fmt, ##__VA_ARGS__)
 
+#define FW_TYPE_V0		0
+#define FW_TYPE_V1		1
+#define FW_TYPE_V2		2
+#define FW_TYPE_V3_1		3
+#define FW_TYPE_V3_2		4
+#define is_v3_fw(type)	(type == FW_TYPE_V3_1 || type == FW_TYPE_V3_2)
+
+#define DL_FIX_CI_ID		0
+#define DL_FIX_CI_ADDR		1
+#define DL_FIX_PATCH_ADDR	2
+#define DL_FIX_SEC_HDR_ADDR	3
+#define DL_FIX_ADDR_MAX		4
+
 struct btrtl_device_info;
 
 struct rtl_chip_type_evt {
@@ -103,8 +116,79 @@ struct rtl_vendor_cmd {
 	__u8 param[5];
 } __packed;
 
+struct rtl_vendor_write_cmd {
+	u8 type;
+	__le32 addr;
+	__le32 val;
+} __packed;
+
+struct rtl_rp_read_chip_id {
+	__u8 status;
+	__u8 chip_id;
+} __packed;
+
+struct rtl_rp_dl_v3 {
+	__u8 status;
+	__u8 index;
+	__u8 err;
+} __packed;
+
+struct rtl_epatch_header_v3 {
+	__u8 signature[8];
+	__u8 timestamp[8];
+	__le32 ver_rsvd;
+	__le32 num_sections;
+} __packed;
+
+struct rtl_section_v3 {
+	__le32 opcode;
+	__le64 len;
+	u8 data[];
+} __packed;
+
+struct rtl_addr_fix {
+	u32 addr;
+	u32 value;
+};
+
+struct rtl_section_patch_image {
+	u16 image_id;
+	u8 index;
+	u8 config_rule;
+	u8 need_config;
+
+	struct rtl_addr_fix fix[DL_FIX_ADDR_MAX];
+
+	u32 image_len;
+	u8 *image_data;
+	u32 image_ver;
+
+	u8  *cfg_buf;
+	u16 cfg_len;
+
+	struct list_head list;
+};
+
+struct rtl_patch_image_hdr {
+	__le16 chip_id;
+	u8 ic_cut;
+	u8 key_id;
+	u8 enable_ota;
+	__le16 image_id;
+	u8 config_rule;
+	u8 need_config;
+	u8 rsv[950];
+
+	__le64 addr_fix[DL_FIX_ADDR_MAX * 2];
+	u8 index;
+
+	__le64 patch_image_len;
+	__u8 data[];
+} __packed;
+
 enum {
 	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
+	REALTEK_DOWNLOADING,
 
 	__REALTEK_NUM_FLAGS,
 };
@@ -130,8 +214,20 @@ struct btrealtek_data {
 #define btrealtek_get_flag(hdev)					\
 	(((struct btrealtek_data *)hci_get_priv(hdev))->flags)
 
+#define btrealtek_wake_up_flag(hdev, nr)				\
+	do {								\
+		struct btrealtek_data *rtl = hci_get_priv((hdev));	\
+		wake_up_bit(rtl->flags, (nr));				\
+	} while (0)
+
 #define btrealtek_test_flag(hdev, nr)	test_bit((nr), btrealtek_get_flag(hdev))
 
+#define btrealtek_test_and_clear_flag(hdev, nr)				\
+	test_and_clear_bit((nr), btrealtek_get_flag(hdev))
+
+#define btrealtek_wait_on_flag_timeout(hdev, nr, m, to)			\
+	wait_on_bit_timeout(btrealtek_get_flag(hdev), (nr), m, to)
+
 #if IS_ENABLED(CONFIG_BT_RTL)
 
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
@@ -148,6 +244,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
 void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name);
+int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
 
 #else
 
@@ -195,4 +292,9 @@ static inline void btrtl_set_driver_name(struct hci_dev *hdev, const char *drive
 {
 }
 
+static inline int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f8f256ff79a3..a87ea836d730 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2677,6 +2677,9 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 		return 0;
 	}
 
+	if (skb->data[0] == HCI_VENDOR_PKT)
+		return btrtl_recv_event(hdev, skb);
+
 	return hci_recv_frame(hdev, skb);
 }
 
-- 
2.34.1

