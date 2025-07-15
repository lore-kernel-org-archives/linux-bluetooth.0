Received: from outbound.pv.icloud.com (p-west1-cluster3-host2-snip4-2.eps.apple.com [57.103.66.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B8C2E174B
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583240; cv=none; b=jcDNcC6hJsQgyGlBFanYwV6c2iNm8xybNdQlL0wk434CET4yzAT579pW9fRT1PpSe/P/ibY8FZmPKApKYUImC9RtwRKnglOKzvBWPgjotz2twInuUU1OWZprOlXGTUJdqy5ezG9BelIriEHbiFsvJ88sHBUR/qvZ8XZfyrBCkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583240; c=relaxed/simple;
	bh=D1W//qNw2jcSwxeFY6cnAciQNTc3BMzCNuI0IekI7B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STjh1DGVq+dvBi6YSLSPReC4ncwMseIvgi/iAqtIVM5W3Y6SRXbRspE/gPfSEvGsHsDsXD7TDM0BeRb1yKd+S2PCez5wcavWrndawuZ4gaKxhoGZ2wdKy+BIdS1YpMbOZR2FuC6p9Zy75eSmY5ubQedXLX2ubGJrFG816Lvb4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=mqaAejcm; arc=none smtp.client-ip=57.103.66.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mqaAejcm"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 5E01118002CD;
	Tue, 15 Jul 2025 12:40:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=vC8NO5NWY6I9G6YPYsJKZtUVLHXUh6Jv8sOvV4tOqV0=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=mqaAejcmDZdKt1S74ppbnqY8oCs/fDM3Vjg7+CnVMxJj5Kjo8XeiaqNnV6kkAEtAC/A1P3AKjnLRAFtw4rchddlvg9ShtTHG8Psaca3+Pspp3ohsa0iEFyYheTmq93O5cuI15Hg5gYp/JCxwuFcHnq0XlVS+O8tUr1cXiwI3u+De5DvlXrw+cWAFIWT7lHJol7Qun8FL92ghSJp3s3a3RWjL9QaKPJ5WZmAEGHRdklJYxPzrw1G9I4JVmU1urHHXVmQwXHY475lV+Ydq8Tgh9Hql4m2HIJ9lhcr5W/+2kHR4bOn18outHqmDzSXP2mZPuhlepf2wRnM8SF9V6rkWXw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 4558918002DF;
	Tue, 15 Jul 2025 12:40:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 15 Jul 2025 20:40:13 +0800
Subject: [PATCH 1/2] Bluetooth: btusb: QCA: Fix downloading wrong NVM for
 WCN6855 GF variant without board ID
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-bt_quec-v1-1-c519cf7a0e16@oss.qualcomm.com>
References: <20250715-bt_quec-v1-0-c519cf7a0e16@oss.qualcomm.com>
In-Reply-To: <20250715-bt_quec-v1-0-c519cf7a0e16@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExNiBTYWx0ZWRfX9c9mS9unVhor
 N47wAAdQUDLo+yHHPGlz/hjVKe9mzy/RXdVg8w/PRwXvNOrjEXxni+3RiMqRkT5F9BSacDywg1M
 EVaYBAE6AgjQx72kZbHsBdYgW31Gz37hHooU09CgvvnL/xM4r7wFtespcbAAtsuA/Tb3y2A45AJ
 mC+pc95VgX9Gw1wXcT6ZPA+F7HVGwcJxSmQZAL86Z//AB4QLcqoeOcOSoA9gnwBXbIBt2ZdV3QX
 HZLBXueTRZaDd9ntLcGSNXzgQBQG4RiOmT83iSEe8oQLIxq5K/4TyzCRKAXRmmdMNoEcXExzs=
X-Proofpoint-GUID: s0qsG9FlS4uue-0j7Tf8quiHaaHTntIQ
X-Proofpoint-ORIG-GUID: s0qsG9FlS4uue-0j7Tf8quiHaaHTntIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507150116

From: Zijun Hu <zijun.hu@oss.qualcomm.com>

For GF variant of WCN6855 without board ID programmed
btusb_generate_qca_nvm_name() will chose wrong NVM
'qca/nvm_usb_00130201.bin' to download.

Fix by choosing right NVM 'qca/nvm_usb_00130201_gf.bin'.
Also simplify NVM choice logic of btusb_generate_qca_nvm_name().

Fixes: d6cba4e6d0e2 ("Bluetooth: btusb: Add support using different nvm for variant WCN6855 controller")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 78 ++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f302c3f1e4cfdf01610bbd3b9ae6be4724aeadad..2dd665bc5703bae3a14d8dd3ab6d1f86e01cc559 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3203,6 +3203,32 @@ static const struct qca_device_info qca_devices_table[] = {
 	{ 0x00190200, 40, 4, 16 }, /* WCN785x 2.0 */
 };
 
+static u16 qca_extract_board_id(const struct qca_version *ver)
+{
+	u16 flag = le16_to_cpu(ver->flag);
+	u16 board_id = 0;
+
+	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
+		/* The board_id should be split into two bytes
+		 * The 1st byte is chip ID, and the 2nd byte is platform ID
+		 * For example, board ID 0x010A, 0x01 is platform ID. 0x0A is chip ID
+		 * we have several platforms, and platform IDs are continuously added
+		 * Platform ID:
+		 * 0x00 is for Mobile
+		 * 0x01 is for X86
+		 * 0x02 is for Automotive
+		 * 0x03 is for Consumer electronic
+		 */
+		board_id = (ver->chip_id << 8) + ver->platform_id;
+	}
+
+	/* Take 0xffff as invalid board ID */
+	if (board_id == 0xffff)
+		board_id = 0;
+
+	return board_id;
+}
+
 static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
 				     void *data, u16 size)
 {
@@ -3359,44 +3385,28 @@ static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
 					const struct qca_version *ver)
 {
 	u32 rom_version = le32_to_cpu(ver->rom_version);
-	u16 flag = le16_to_cpu(ver->flag);
+	const char *variant;
+	int len;
+	u16 board_id;
 
-	if (((flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
-		/* The board_id should be split into two bytes
-		 * The 1st byte is chip ID, and the 2nd byte is platform ID
-		 * For example, board ID 0x010A, 0x01 is platform ID. 0x0A is chip ID
-		 * we have several platforms, and platform IDs are continuously added
-		 * Platform ID:
-		 * 0x00 is for Mobile
-		 * 0x01 is for X86
-		 * 0x02 is for Automotive
-		 * 0x03 is for Consumer electronic
-		 */
-		u16 board_id = (ver->chip_id << 8) + ver->platform_id;
-		const char *variant;
+	board_id = qca_extract_board_id(ver);
 
-		switch (le32_to_cpu(ver->ram_version)) {
-		case WCN6855_2_0_RAM_VERSION_GF:
-		case WCN6855_2_1_RAM_VERSION_GF:
-			variant = "_gf";
-			break;
-		default:
-			variant = "";
-			break;
-		}
-
-		if (board_id == 0) {
-			snprintf(fwname, max_size, "qca/nvm_usb_%08x%s.bin",
-				rom_version, variant);
-		} else {
-			snprintf(fwname, max_size, "qca/nvm_usb_%08x%s_%04x.bin",
-				rom_version, variant, board_id);
-		}
-	} else {
-		snprintf(fwname, max_size, "qca/nvm_usb_%08x.bin",
-			rom_version);
+	switch (le32_to_cpu(ver->ram_version)) {
+	case WCN6855_2_0_RAM_VERSION_GF:
+	case WCN6855_2_1_RAM_VERSION_GF:
+		variant = "_gf";
+		break;
+	default:
+		variant = NULL;
+		break;
 	}
 
+	len = snprintf(fwname, max_size, "qca/nvm_usb_%08x", rom_version);
+	if (variant)
+		len += snprintf(fwname + len, max_size - len, "%s", variant);
+	if (board_id)
+		len += snprintf(fwname + len, max_size - len, "_%04x", board_id);
+	len += snprintf(fwname + len, max_size - len, ".bin");
 }
 
 static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,

-- 
2.34.1

