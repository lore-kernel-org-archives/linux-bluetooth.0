Received: from mail.naujezde.cz (mail.naujezde.cz [46.167.198.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B3F1F2B88;
	Wed, 29 Apr 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.167.198.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476156; cv=none; b=CeGXeobwEe6HaUogxJwV694nP8Paa0ZGhZ5C8q3vmHRE2b2zBniSlAeYsnQG6PMd/mJbIwZLYRALNsGFLH2xkHAvHCNoInfpNHq6rrUVYdCmUNYFz1o3srsUUj4Bd95XPYORL4TYEUCDmUhd8bHFvL66jXXUkZTQH/QPkFRSf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476156; c=relaxed/simple;
	bh=HJXA6dYaLM9UHqPWf7nJtCYXHaMUWBmfQx43jMhoBQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLgCbCwTCU6PlezV6tCOIiywp3C85aVlZfpJ/UvjeTI1mMhh6gMOYjSVGhakI1/qnG9Bre+nlNh3sgSKjhD34x0CMWGAH4IC727hAZuqLjZvGXfbNSXdOocQ5bC+Ct4+J+Bxy2iJsbKmnm/LUQK0ouTTFYQ0VtwgMgI4RaXY/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sidorenko.cz; spf=pass smtp.mailfrom=sidorenko.cz; arc=none smtp.client-ip=46.167.198.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sidorenko.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sidorenko.cz
Received: from localhost.localdomain (unknown [192.168.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.naujezde.cz (Postfix) with ESMTPS id F1AD34A1;
	Wed, 29 Apr 2026 17:13:45 +0200 (CEST)
BIMI-Selector: v=BIMI1; s=mail
From: Alexej Sidorenko <alexej@sidorenko.cz>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Alexej Sidorenko <alexej@sidorenko.cz>
Subject: [PATCH] Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan
Date: Wed, 29 Apr 2026 17:13:43 +0200
Message-ID: <20260429151343.28142-1-alexej@sidorenko.cz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTL8761B and RTL8761BU devices report HCI version 5.1 but do not
support the LE Extended Scan commands. This causes repeated failures
with Opcode 0x2042 (LE Set Extended Scan Parameters) returning -EBUSY
when BlueZ attempts extended scanning while a connection is active.

Set HCI_QUIRK_BROKEN_EXT_SCAN for CHIP_ID_8761B to make BlueZ fall
back to legacy LE scan commands which the firmware supports correctly.

Tested with RTL8761BU (USB ID 0bda:a728) where the issue manifested
as continuous 'Opcode 0x2042 failed: -16' errors in dmesg whenever
a BLE connection was active.

Signed-off-by: Alexej Sidorenko <alexej@sidorenko.cz>
---
 drivers/bluetooth/btrtl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 62f9d4df3..49ecb18fe 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1342,6 +1342,19 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	if (!btrtl_dev->ic_info)
 		return;
 
+	switch (btrtl_dev->project_id) {
+	case CHIP_ID_8761B:
+		/* RTL8761B/BU reports HCI version 5.1 but does not support
+		 * the LE Extended Scan commands (Opcode 0x2042), causing
+		 * repeated -EBUSY failures when BlueZ attempts extended
+		 * scanning while a connection is active.
+		 */
+		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
+		break;
+	default:
+		break;
+	}
+
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8703B:
 		/* 8723CS reports two pages for local ext features,
-- 
2.45.2

