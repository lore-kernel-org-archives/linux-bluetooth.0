Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89967377547;
	Tue,  3 Feb 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099922; cv=none; b=pjHY4HNuaX+TwsPxynatJKta6iC3zV/sYsGzczm4EyNwX25iNDXNp9STFBRHTTZmcfFk5M3bT4Uxofjrq0Ws8T86u3ydccRudMFrYllFFW51cNCIkR3QiW+S0qMnXKsBZ4ByTU+wd/ek4Bcf1p7WxjJRqGQ8hjNgNzf01Mt10M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099922; c=relaxed/simple;
	bh=X+9qS1S3n/8MV3IAlB9flAOcJBgUkfzU0uBXcHivbmk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngCbc53VqScOFJihgqTA+f01f1MO1y040c19MPjDK+NZruMn31ToEfLuk3+KRC9Chuqs7qmASFBG+YFcA50l51WY5ghE/gCZv1cm/nl0kjFQrVQeMDHXq/9bvGFbTPaX7tN++0Kve5dRpoXr85BbhlmTfwk3pXanxjn4mNYIEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FrCaN6kw; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FrCaN6kw"
X-UUID: 19607b4e00c911f185319dbc3099e8fb-20260203
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=llw5nIPmtNh9wxl3XcFeQkmLz9EI/2RnjokuZ1CWD6s=;
	b=FrCaN6kwZGOnMpt8pjs3IvC0XTUXpkW0AbQsEQW4O5HHS+4EEe6SoK10uUIfaHQgXfvRr2FOsZ5W1xLUNsK8ZKzUGarM12TW8CacuUH49TwtYkqy875ZAmbxfWvs9BrZEeDLlaC4Z++o9Dy3X8Y57FWdQZxEpO2h0ZtXhdQqg5c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:0901f239-411c-4b8e-9565-6403609d0a52,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:89c9d04,CLOUDID:b31544f0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 19607b4e00c911f185319dbc3099e8fb-20260203
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 235145318; Tue, 03 Feb 2026 14:25:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 14:25:12 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 3 Feb 2026 14:25:12 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v1 3/3] Bluetooth: btmtk: Add reset mechanism if downloading firmware failed
Date: Tue, 3 Feb 2026 14:25:10 +0800
Message-ID: <20260203062510.848761-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260203062510.848761-1-chris.lu@mediatek.com>
References: <20260203062510.848761-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a new flag 'BTMTK_FIRMWARE_DL_RETRY'.
If an error occurs during mt79xx firmware download process, this flag
will be set and cleared after a reset. If the flag is already set and
firmware still cannot be loaded successfully after a reset, no further
reset attempts will be made. In other words, if there is a problem during
firmware download, only one reset will be attempted.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 6 ++++++
 drivers/bluetooth/btmtk.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 67db5a48c3e4..14e2f4100806 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1344,6 +1344,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
 						btmtk_usb_hci_wmt_sync);
 		if (err < 0) {
+			/* retry once if setup firmware error */
+			if (!test_and_set_bit(BTMTK_FIRMWARE_DL_RETRY, &btmtk_data->flags))
+				btmtk_reset_sync(hdev);
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
 			return err;
 		}
@@ -1371,6 +1374,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		hci_set_msft_opcode(hdev, 0xFD30);
 		hci_set_aosp_capable(hdev);
 
+		/* Clear BTMTK_FIRMWARE_DL_RETRY if setup successfully */
+		test_and_clear_bit(BTMTK_FIRMWARE_DL_RETRY, &btmtk_data->flags);
+
 		/* Set up ISO interface after protocol enabled */
 		if (test_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags)) {
 			if (!btmtk_usb_isointf_init(hdev))
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 5df7c3296624..b9df2b8f0627 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -147,6 +147,7 @@ enum {
 	BTMTK_HW_RESET_ACTIVE,
 	BTMTK_ISOPKT_OVER_INTR,
 	BTMTK_ISOPKT_RUNNING,
+	BTMTK_FIRMWARE_DL_RETRY,
 };
 
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
-- 
2.45.2

