Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056030C62A;
	Wed,  5 Nov 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344142; cv=none; b=t3gkpaKB7aj3kUdOk26r2vhZUKgJ+vrABvinNWswTVW1uZHrugf9gBozBO6mpK5hKfvxOmJ24dLx9XtuKVFLvEF0V9GmnMhOIQ4VrVOLwJwGQ60iyDWhmh3aGzJTTz2pmtn2sTh547xzE7Nt+DudFp0Q8L1kc49NWgCFdU15Tf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344142; c=relaxed/simple;
	bh=hKunlIjYtJkOA2nrFC8bxiKJsOwPK10JSsMoHf23m6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N3Z7QWQuCvxbeZsrIGNi3v3CYY3K35VHlkv3T3l7MbYo3Dnl2FOJNtNyhJHqXcVjdOPuDziFS2ZOTIWsr+4CunHfeD5FCWfSvVPcM3SSkSpEEILTPSyLWxfcGjCBFppUZOhve8W+gf4k3pOO6qZgVjgKHlVgCKQ/TkOXs4jJ46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BZiscM/U; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BZiscM/U"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5A5C1ib761065774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762344104; bh=j0T5lpYuIGgnLHjCCRP6kYy3bGupW+DrWPR2UmfUz2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=BZiscM/U+XuKTVZ1n3OsoF55v1wJ96v74IftwbLC61iKuTi81pQkCCHS3HlJRMj6p
	 qgomWoUdtT18dCOx8gmOrjSFQSrCbWTWWy7grPOu5ZSqKOHWopzurK6g9mnsCxSp1T
	 cA+FMNWg0W4GU8J2of7RsqSW1b1DHvqZpbfcdZZtQA7yYdkPyaHbCeH3uQYz+kJmGt
	 Tw7QfNySpXqHvzkl27nujohx28LGc8rEbeln8evqI1JG6l+9zWfGK7F/SRg3rOU3Av
	 sLsCsSrvatfjuTk9EHh1vSy9ZK7nXeGMGG7PXEg8xqkb+7mAI83JnjAoiBnUHFk6S2
	 RK55WFHniyQtA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5A5C1ib761065774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 20:01:44 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 5 Nov 2025 20:01:44 +0800
Received: from rtkbt-D520MT-K.realtek.com.tw (172.24.54.67) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1544.27 via Frontend Transport; Wed, 5 Nov 2025 20:01:44 +0800
From: Max Chou <max.chou@realtek.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
CC: Hilda Wu <hildawu@realtek.com>, alex_lu <alex_lu@realsil.com.cn>,
        <niall_ni@realsil.com.cn>, KidmanLee <kidman@realtek.com>,
        Max Chou
	<max.chou@realtek.com>
Subject: [PATCH v2] Bluetooth: btrtl: Avoid loading the config file on security chips
Date: Wed, 5 Nov 2025 20:02:04 +0800
Message-ID: <20251105120204.458231-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For chips with security enabled, it's only possible to load firmware
with a valid signature pattern.
If key_id is not zero, it indicates a security chip, and the driver will
not load the config file.

- Example log for a security chip.

Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000a
  lmp_ver=0c lmp_subver=8922
Bluetooth: hci0: RTL: rom_version status=0 version=1
Bluetooth: hci0: RTL: btrtl_initialize: key id 1
Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_fw.bin
Bluetooth: hci0: RTL: cfg_sz 0, total sz 71301
Bluetooth: hci0: RTL: fw version 0x41c0c905

- Example log for a normal chip.

Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000a
  lmp_ver=0c lmp_subver=8922
Bluetooth: hci0: RTL: rom_version status=0 version=1
Bluetooth: hci0: RTL: btrtl_initialize: key id 0
Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_fw.bin
Bluetooth: hci0: RTL: loading rtl_bt/rtl8922au_config.bin
Bluetooth: hci0: RTL: cfg_sz 6, total sz 71307
Bluetooth: hci0: RTL: fw version 0x41c0c905

Tested-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Nial Ni <niall_ni@realsil.com.cn>
Signed-off-by: Max Chou <max.chou@realtek.com>
---
Changes in V2:
- Print key_id at INFO level
- Update commit information for key_id based on review suggestions
---
 drivers/bluetooth/btrtl.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 8290932b8f7b..5603b282f9bc 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -50,7 +50,7 @@
 
 #define	RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0x04, 0x28, 0x80}})
 #define	RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0x04, 0x28, 0x80}})
-#define	RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0x0D, 0x00, 0xb0}})
+#define	RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0xAD, 0x00, 0xb0}})
 
 #define RTL_PATCH_SNIPPETS		0x01
 #define RTL_PATCH_DUMMY_HEADER		0x02
@@ -544,7 +544,6 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 {
 	struct rtl_epatch_header_v2 *hdr;
 	int rc;
-	u8 reg_val[2];
 	u8 key_id;
 	u32 num_sections;
 	struct rtl_section *section;
@@ -559,14 +558,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 		.len  = btrtl_dev->fw_len - 7, /* Cut the tail */
 	};
 
-	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
-	if (rc < 0)
-		return -EIO;
-	key_id = reg_val[0];
-
-	rtl_dev_dbg(hdev, "%s: key id %u", __func__, key_id);
-
-	btrtl_dev->key_id = key_id;
+	key_id = btrtl_dev->key_id;
 
 	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
 	if (!hdr)
@@ -1081,6 +1073,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
+	int rc;
+	u8 key_id;
 	u8 reg_val[2];
 
 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
@@ -1191,6 +1185,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_free;
 	}
 
+	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
+	if (rc < 0)
+		goto err_free;
+
+	key_id = reg_val[0];
+	btrtl_dev->key_id = key_id;
+	rtl_dev_info(hdev, "%s: key id %u", __func__, key_id);
+
 	btrtl_dev->fw_len = -EIO;
 	if (lmp_subver == RTL_ROM_LMP_8852A && hci_rev == 0x000c) {
 		snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
@@ -1213,7 +1215,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_free;
 	}
 
-	if (btrtl_dev->ic_info->cfg_name) {
+	if (btrtl_dev->ic_info->cfg_name && !btrtl_dev->key_id) {
 		if (postfix) {
 			snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
 				 btrtl_dev->ic_info->cfg_name, postfix);
-- 
2.43.0

