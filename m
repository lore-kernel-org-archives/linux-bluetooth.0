Received: from outbound.pv.icloud.com (p-west1-cluster3-host12-snip4-7.eps.apple.com [57.103.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC202E2640
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583241; cv=none; b=f/u0BjCHRv3vUgwSU7YiFgNJps9AwEb2PVIcKU9FYWVE9XB920DCLQ1hctKV0JS9NhT1OpPR546HOQW/yuf1Lc02TkxQ7saQuxiio3Swf8xVAR5gvM6Lau1poqQ38uncJ1jp6rIv1TB3vHZkBfCKI34qGbPyV+eRH/h6qRvUYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583241; c=relaxed/simple;
	bh=H6dw3h5hq1YyHA9MgHeA7V7Qkd//GBRc+R2X1F5apdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMPzEhaH4g7/wAzhDr76fm/NC9Naiv2K/7Umq0DMCZQeIkf4cGWbEpk+hoFbevzBva3EVJask/VrGwYaCid17l9JN5kGEy3kKwfGLnkzr7wcEat29Qt0Ai8BSyS53MZ9G0HC2PWG0A6an0ITyWS+x/nM8Eg5N7eTO/WmZyps0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EzBsiRWL; arc=none smtp.client-ip=57.103.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EzBsiRWL"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 8AFC018002DF;
	Tue, 15 Jul 2025 12:40:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=XoyjlAkNkFBs8fTOlPVmI3g/uY0Xw9e5DKrJBuBVtxY=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=EzBsiRWLRs2mR9lg5xtsHoaFv5iDXfpPpdpgV0PtW0alCjzQEme23omiQcEFlIwM0sC4Kd3gSLgKSkFgPsHwLBILJweKiT91pzRkTmnx+CSvDs806Ubvkr9EsuFOTvGYCSwz8PbLhKiTofOvTA13T6BTUF48GHjuiEXD8RmxFNdLL2VW/qzaTX/yCbqHEBodzw9DbdvKfQXeBRxGrETH/CpvhkAo0wpkMpL/6b4LP7kbbYkLef7clOaum/iRCcrZ1MnPtTxFWffLOFnmxJm7YYGCQg2bGLZEwlN98QKGvkryBycZ8NudBx/KWnLpOLK/DB8Q/oCO4t/Iu7G3LxibRQ==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 7A06F18001F6;
	Tue, 15 Jul 2025 12:40:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 15 Jul 2025 20:40:14 +0800
Subject: [PATCH 2/2] Bluetooth: btusb: QCA: Support downloading custom-made
 firmwares
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-bt_quec-v1-2-c519cf7a0e16@oss.qualcomm.com>
References: <20250715-bt_quec-v1-0-c519cf7a0e16@oss.qualcomm.com>
In-Reply-To: <20250715-bt_quec-v1-0-c519cf7a0e16@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExNiBTYWx0ZWRfXwGBWIdeICwfv
 XEQxal97lvnKy/6cwoxa3p+FgVr1wNfU5YLk0/SQeAX5n0oQRWJY5VfvtUuITrhfzSw6o28i+Jd
 aCj9X3oCoFALsDZYuOEWi8aeT9MLpPopPNgw9BOXz863DOjuuH62qhgw+B+JBn6D+3zeuo8Nwgu
 NhxzhOSyUwEvwVCPrXvj9yTLO8Sx/nfo8v7tVi9r1T2jj5BGpKTdycU9j7oODnqi00KaPHBRfWU
 sxAc0XWTDyy/GAwK/XtH2MuAIlWGC55Gbtxf4kseHnpt3Zp56sCA11GurfT9OGjPXWmpqXJ4c=
X-Proofpoint-GUID: LL7sN2Ek42PC-fWFu2K9tH-w-V7ogSCQ
X-Proofpoint-ORIG-GUID: LL7sN2Ek42PC-fWFu2K9tH-w-V7ogSCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507150116

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

There are custom-made firmwares based on board ID for a given QCA BT
chip sometimes, and they are different with existing firmwares and put
in a separate subdirectory to avoid conflict, for example:
QCA2066, as a variant of WCN6855, has firmwares under 'qca/QCA2066/'
of linux-firmware repository.

Support downloading custom-made firmwares based on a table newly added.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 54 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2dd665bc5703bae3a14d8dd3ab6d1f86e01cc559..6b3499b8a717a247f235c44e459037481747118e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3190,6 +3190,12 @@ struct qca_device_info {
 	u8	ver_offset;	/* offset of version structure in rampatch */
 };
 
+struct qca_custom_firmware {
+	u32 rom_version;
+	u16 board_id;
+	const char *subdirectory;
+};
+
 static const struct qca_device_info qca_devices_table[] = {
 	{ 0x00000100, 20, 4,  8 }, /* Rome 1.0 */
 	{ 0x00000101, 20, 4,  8 }, /* Rome 1.1 */
@@ -3203,6 +3209,11 @@ static const struct qca_device_info qca_devices_table[] = {
 	{ 0x00190200, 40, 4, 16 }, /* WCN785x 2.0 */
 };
 
+static const struct qca_custom_firmware qca_custom_btfws[] = {
+	{ 0x00130201, 0x030A, "QCA2066" },
+	{ },
+};
+
 static u16 qca_extract_board_id(const struct qca_version *ver)
 {
 	u16 flag = le16_to_cpu(ver->flag);
@@ -3229,6 +3240,26 @@ static u16 qca_extract_board_id(const struct qca_version *ver)
 	return board_id;
 }
 
+static const char *qca_get_fw_subdirectory(const struct qca_version *ver)
+{
+	const struct qca_custom_firmware *ptr;
+	u32 rom_ver;
+	u16 board_id;
+
+	rom_ver = le32_to_cpu(ver->rom_version);
+	board_id = qca_extract_board_id(ver);
+	if (!board_id)
+		return NULL;
+
+	for (ptr = qca_custom_btfws; ptr->rom_version; ptr++) {
+		if (ptr->rom_version == rom_ver &&
+		    ptr->board_id == board_id)
+			return ptr->subdirectory;
+	}
+
+	return NULL;
+}
+
 static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
 				     void *data, u16 size)
 {
@@ -3333,15 +3364,22 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 {
 	struct qca_rampatch_version *rver;
 	const struct firmware *fw;
+	const char *fw_subdir;
 	u32 ver_rom, ver_patch, rver_rom;
 	u16 rver_rom_low, rver_rom_high, rver_patch;
-	char fwname[64];
+	char fwname[80];
 	int err;
 
 	ver_rom = le32_to_cpu(ver->rom_version);
 	ver_patch = le32_to_cpu(ver->patch_version);
 
-	snprintf(fwname, sizeof(fwname), "qca/rampatch_usb_%08x.bin", ver_rom);
+	fw_subdir = qca_get_fw_subdirectory(ver);
+	if (fw_subdir)
+		snprintf(fwname, sizeof(fwname), "qca/%s/rampatch_usb_%08x.bin",
+			 fw_subdir, ver_rom);
+	else
+		snprintf(fwname, sizeof(fwname), "qca/rampatch_usb_%08x.bin",
+			 ver_rom);
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err) {
@@ -3385,10 +3423,11 @@ static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
 					const struct qca_version *ver)
 {
 	u32 rom_version = le32_to_cpu(ver->rom_version);
-	const char *variant;
+	const char *variant, *fw_subdir;
 	int len;
 	u16 board_id;
 
+	fw_subdir = qca_get_fw_subdirectory(ver);
 	board_id = qca_extract_board_id(ver);
 
 	switch (le32_to_cpu(ver->ram_version)) {
@@ -3401,7 +3440,12 @@ static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
 		break;
 	}
 
-	len = snprintf(fwname, max_size, "qca/nvm_usb_%08x", rom_version);
+	if (fw_subdir)
+		len = snprintf(fwname, max_size, "qca/%s/nvm_usb_%08x",
+			       fw_subdir, rom_version);
+	else
+		len = snprintf(fwname, max_size, "qca/nvm_usb_%08x",
+			       rom_version);
 	if (variant)
 		len += snprintf(fwname + len, max_size - len, "%s", variant);
 	if (board_id)
@@ -3414,7 +3458,7 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
 				    const struct qca_device_info *info)
 {
 	const struct firmware *fw;
-	char fwname[64];
+	char fwname[80];
 	int err;
 
 	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);

-- 
2.34.1

