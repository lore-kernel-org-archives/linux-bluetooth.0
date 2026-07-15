Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F233644C5;
	Wed, 15 Jul 2026 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114460; cv=none; b=mi3qNpvg+HsNfG58O9PSTrQdV+laoDFQOd/Kmi1QMlMql/4i2iwzW6bTHp147YfU71PzRoUvjJod2EMfH8JbvVDfGGC3kKDEyPComuZQh62lTUhSlxXu28K0eB0WD7nejYw69f9ojouCrWL/3gZGJZGAZUq5kQ4ibs2nLG+LYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114460; c=relaxed/simple;
	bh=YKap3/vGxMXHuEqWG0FqQnF2Bd85ZflBYQrpmSS1kn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8usOpyQrJdpvV+vkRguhTPjeS1oIngr6ibhNyxXn/Jaxy7rAjALJhuY9VdRoCJR1KrNgsFfn/SscZbWyknttdi9A3vU71hh/+PWlSJTqvPrsxQsA6BpOUjUWa0iNgMftbAoGim5PjU0PYdGtOV06xBFCwgT9Ak1L3ol9NlxypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IssQoFP3; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IssQoFP3"
X-UUID: 3c72c83a803f11f18dc8c9802ae25ab1-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NrLmXw2+grSg8BDLzNZP31Z2rCqGp6CpomTh+kmD5Sk=;
	b=IssQoFP3YLZgqCfeHPJQ8a0PKcg8bbasb4FxK8Sf6OLpPm/rGSqqnRANoJfG2bFQOirF1RV9une3J7vGl/utSzdel6glcP0YcK8zjDgw+PHq1xhl9iqgE4pGp2iR6P5Lv6K9udann+G7vEYGbv3CSjWLmE/OhwZeF23izyAa0+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:0732702b-5e49-4399-be59-3e246aca482a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:d497b38,CLOUDID:7ff42619-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c72c83a803f11f18dc8c9802ae25ab1-20260715
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1542859525; Wed, 15 Jul 2026 19:20:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Jul 2026 19:20:49 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Jul 2026 19:20:49 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v11 2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()
Date: Wed, 15 Jul 2026 19:20:42 +0800
Message-ID: <20260715112048.1448868-3-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260715112048.1448868-1-chris.lu@mediatek.com>
References: <20260715112048.1448868-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add firmware size validation to prevent out-of-bounds access when loading
truncated or malicious firmware files.

Add three levels of validation:
1. Minimum size check for header and global descriptor
2. Section map bounds check with integer overflow protection using
   check_mul_overflow() and check_add_overflow()
3. Section data bounds check before accessing each section

This matches the validation approach used in btmtk_load_cbmcu_firmware().

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Assisted-by: Claude:Sonnet-4.5
---
 drivers/bluetooth/btmtk.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 02a96342e964..3491060b3ae9 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -145,6 +145,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 	int err, dlen, i, status;
 	u8 flag, first_block, retry;
 	u32 section_num, dl_size, section_offset;
+	size_t expected_size;
 	u8 cmd[64];
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
@@ -153,12 +154,40 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 		return err;
 	}
 
+	/* Validate minimum firmware size for header and global descriptor */
+	if (fw->size < MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE) {
+		bt_dev_err(hdev, "Firmware file too small: size=%zu, expected at least %u bytes",
+			   fw->size, MTK_FW_ROM_PATCH_HEADER_SIZE + MTK_FW_ROM_PATCH_GD_SIZE);
+		err = -EINVAL;
+		goto err_release_fw;
+	}
+
 	fw_ptr = fw->data;
 	fw_bin_ptr = fw_ptr;
 	hdr = (struct btmtk_patch_header *)fw_ptr;
 	globaldesc = (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE);
 	section_num = le32_to_cpu(globaldesc->section_num);
 
+	/* Check for potential integer overflow in size calculation */
+	if (check_mul_overflow((size_t)MTK_FW_ROM_PATCH_SEC_MAP_SIZE,
+			       (size_t)section_num, &expected_size) ||
+	    check_add_overflow(expected_size,
+			       (size_t)(MTK_FW_ROM_PATCH_HEADER_SIZE +
+					MTK_FW_ROM_PATCH_GD_SIZE),
+			       &expected_size)) {
+		bt_dev_err(hdev, "Firmware size calculation overflow (section_num=%u)",
+			   section_num);
+		err = -EINVAL;
+		goto err_release_fw;
+	}
+
+	if (fw->size < expected_size) {
+		bt_dev_err(hdev, "Firmware truncated: size=%zu, expected=%zu (section_num=%u)",
+			   fw->size, expected_size, section_num);
+		err = -EINVAL;
+		goto err_release_fw;
+	}
+
 	bt_dev_info(hdev, "HW/SW Version: 0x%04x%04x, Build Time: %s",
 		    le16_to_cpu(hdr->hwver), le16_to_cpu(hdr->swver), hdr->datetime);
 
@@ -171,6 +200,16 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 		section_offset = le32_to_cpu(sectionmap->secoffset);
 		dl_size = le32_to_cpu(sectionmap->bin_info_spec.dlsize);
 
+		/* Validate section boundaries to prevent out-of-bounds access */
+		if (dl_size > 0 &&
+		    (section_offset > fw->size ||
+		     dl_size > fw->size - section_offset)) {
+			bt_dev_err(hdev, "Section %d out of bounds: offset=%u, size=%u, fw_size=%zu",
+				   i, section_offset, dl_size, fw->size);
+			err = -EINVAL;
+			goto err_release_fw;
+		}
+
 		/* MT6639: only download sections where dlmode byte0 == 0x01,
 		 * matching the Windows driver behavior which skips WiFi/other
 		 * sections that would cause the chip to hang.
-- 
2.45.2

