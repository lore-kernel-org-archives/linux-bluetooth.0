Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BC4B5CBD;
	Wed,  9 Sep 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955241; cv=none; b=E3jh6Bct7VlxcOmP7SQ+UfJjKBV3no5UIrTn/pkfRWLfo609H+rRGkQRbwbtk0XZQWk+Zq/Y75pgQ0gyh87S7PC6D1+t0Yx9+1faz/i5EsMo/xjRuEoUX5WOtDKqOgHJsLs7YJnuxEru4rDtIj/byoR37f8lDHqPyWkzv4jvFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955241; c=relaxed/simple;
	bh=d2+bqJRNFFL0Xdn4Sf6RIBNtSOPvLaCP6YzvSK494zU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBDqvefEkpxkf+o48455NVnnepk6E0VXq821RsmzaZ5Rq8ymSlD0wbSf103c5MJggUmw5kDE6swBNoSG+UHryp1OtIqLm2VWA9fVlPQPoWN6qoh+GeGhO0lwuWIbkzYnioxLL8JEAH4ojcd5AVaJaNjU0RmY+DI97BF0cb2TmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e0GeNIXj; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e0GeNIXj"
X-UUID: 0b36badcac4611f18dc8c9802ae25ab1-20260909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8SA+5XmJFgplp0HfiniIh3MEQjHiRyaGBxhiAo9V4C8=;
	b=e0GeNIXjKpCdl2BKdfEYXQgavxb4g0TkOBs+ov6d/AWTogneEPdP+nNATq26NS16OmCKQqZWp+K7TEnex7jZxoJZyYvyv3ITh+9suhbX2Kp4xoLkSJqZFmdmVkhQf0PwfOtokfTLX0J1sDXEv5rPJZ4mgOrSdwOLgBhRCpUI6Dg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:935630dc-5a04-41fb-b8e2-31317b294795,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:3b729de2-72a5-4ba1-af40-18bbd6ea8ffd,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0b36badcac4611f18dc8c9802ae25ab1-20260909
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1558801207; Wed, 09 Sep 2026 20:00:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 9 Sep 2026 20:00:24 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 9 Sep 2026 20:00:24 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH 1/3] Bluetooth: btmtk: Validate the firmware layout before parsing it
Date: Wed, 9 Sep 2026 20:00:09 +0800
Message-ID: <20260909120011.1198001-2-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260909120011.1198001-1-chris.lu@mediatek.com>
References: <20260909120011.1198001-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtk_setup_firmware_79xx() reads the section count out of the firmware's
global descriptor, then walks a 64-byte section map per section and hands
each section's file-supplied offset and length to the WMT download path.
None of that is checked against fw->size, so a truncated or corrupted
file makes the driver read past the end of request_firmware()'s buffer.
On 32-bit the section count can also wrap the section map size
calculation.

Add btmtk_fw_validate_layout() to check that the header, global
descriptor and section map array all fit, and btmtk_fw_validate_section()
to check one section's offset and length, both written so the size
arithmetic cannot wrap. A section count of zero is rejected as well: it
passes every size check but leaves the download loop with nothing to do,
so the function would report success on hardware it never programmed.
They are helpers rather than open-coded because the MT7928 CBMCU download
path added later needs the same arithmetic.

This is hardening against a corrupted /lib/firmware rather than a bug an
unprivileged user can trigger, hence bluetooth-next and no Fixes: tag.
Well-formed firmware files are unaffected.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/bluetooth/btmtk.c | 74 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 911aba5c134e..07a7a7a3656a 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -6,6 +6,7 @@
 #include <linux/firmware.h>
 #include <linux/usb.h>
 #include <linux/iopoll.h>
+#include <linux/overflow.h>
 #include <linux/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -59,6 +60,67 @@ struct btmtk_section_map {
 	};
 } __packed;
 
+/* Reject a firmware image whose header, global descriptor or section map
+ * array does not fit in the file, and hand back the validated section
+ * count, so that the section map walks stay inside the firmware buffer.
+ */
+static int btmtk_fw_validate_layout(struct hci_dev *hdev,
+				    const struct firmware *fw,
+				    u32 *section_num)
+{
+	const struct btmtk_global_desc *globaldesc;
+	size_t need;
+
+	if (fw->size < MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE) {
+		bt_dev_err(hdev, "Firmware too small: %zu bytes, need at least %u",
+			   fw->size,
+			   MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE);
+		return -EINVAL;
+	}
+
+	globaldesc = (const struct btmtk_global_desc *)(fw->data +
+			MTK_FW_ROM_PATCH_HEADER_SIZE);
+	*section_num = le32_to_cpu(globaldesc->section_num);
+
+	if (!*section_num) {
+		bt_dev_err(hdev, "Firmware declares no sections");
+		return -EINVAL;
+	}
+
+	if (check_mul_overflow((size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE,
+			       (size_t)*section_num, &need) ||
+	    check_add_overflow(need,
+			       (size_t)(MTK_FW_ROM_PATCH_HEADER_SIZE +
+					MTK_FW_ROM_PATCH_GD_SIZE),
+			       &need)) {
+		bt_dev_err(hdev, "Firmware section count too large: %u",
+			   *section_num);
+		return -EINVAL;
+	}
+
+	if (fw->size < need) {
+		bt_dev_err(hdev, "Firmware truncated: %zu bytes, need %zu for %u sections",
+			   fw->size, need, *section_num);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Reject a section whose payload does not lie within the firmware file. */
+static int btmtk_fw_validate_section(struct hci_dev *hdev,
+				     const struct firmware *fw, int index,
+				     u32 offset, u32 size)
+{
+	if (offset > fw->size || size > fw->size - offset) {
+		bt_dev_err(hdev, "Firmware section %d out of bounds: offset=%u, size=%u, fw_size=%zu",
+			   index, offset, size, fw->size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void btmtk_coredump(struct hci_dev *hdev)
 {
 	int err;
@@ -137,7 +199,6 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 {
 	struct btmtk_hci_wmt_params wmt_params;
 	struct btmtk_patch_header *hdr;
-	struct btmtk_global_desc *globaldesc = NULL;
 	struct btmtk_section_map *sectionmap;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
@@ -153,11 +214,13 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 		return err;
 	}
 
+	err = btmtk_fw_validate_layout(hdev, fw, &section_num);
+	if (err < 0)
+		goto err_release_fw;
+
 	fw_ptr = fw->data;
 	fw_bin_ptr = fw_ptr;
 	hdr = (struct btmtk_patch_header *)fw_ptr;
-	globaldesc = (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE);
-	section_num = le32_to_cpu(globaldesc->section_num);
 
 	bt_dev_info(hdev, "HW/SW Version: 0x%04x%04x, Build Time: %s",
 		    le16_to_cpu(hdr->hwver), le16_to_cpu(hdr->swver), hdr->datetime);
@@ -180,6 +243,11 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			continue;
 
 		if (dl_size > 0) {
+			err = btmtk_fw_validate_section(hdev, fw, i,
+							section_offset, dl_size);
+			if (err < 0)
+				goto err_release_fw;
+
 			retry = 20;
 			while (retry > 0) {
 				cmd[0] = 0; /* 0 means legacy dl mode. */
-- 
2.45.2

