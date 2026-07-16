Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CB2330668;
	Thu, 16 Jul 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167175; cv=none; b=Uv5LAr4fNKLhZVnlT96lnHPhemH6rN0VeXOms5/a1Lt3Jezv77sOD9v8JBLK/D068QkojS87k5ymYF0o4cGPhCW3GG1peasYrGCK+n8HXG5eu0FXiPjVnqKxUS30DoY6p/XXEVZL8FS29D7EzPcgXzCNhzvpn/bXOQN8U97tcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167175; c=relaxed/simple;
	bh=//BiBQQ9/pb2D4p8oYQegRCGdVHAKxLO+GOCKtr63ZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3irhX/5ZzcBld45lBtnQX7iI0tIoyZ8GPT7MM8xiUAH9+i4W+EmEliFns01fmgsymHvvwXdPLINag5+LK/6W4PV9DGxMkbeVvWpp8WTuW48O2a2aT3ttLO8LT8qu7IeghLAFyLjzZ7h/+9s5+RQCG1FZsdSD0nXPC/Favhz8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QvXYYyjQ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QvXYYyjQ"
X-UUID: f74b2b1e80b911f1b1788b6acf885367-20260716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=biHARXTi5HhbkroAZdRCCqUki4qlgbYdasCtqlgw5xw=;
	b=QvXYYyjQdQLN4C2pvBfoeTEBBFrZi/Ufgbx5Zn5a4zxhCOp5g6Kh6oRS5IFZrRCCT34IsZIzpCwY+Sa/t7OJIqOj3YdogYKZIYFQ1RaEjhCj1BaADV+gtcpSvsqb98zx5/J77tfpnmSQYZA7ch6pbDKev3hHsK+wFXKqq1Sh1HQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:1578c101-09a7-4d99-b591-580bfce3e93b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:d497b38,CLOUDID:2d302d19-ab14-4403-9336-76696324c5a8,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f74b2b1e80b911f1b1788b6acf885367-20260716
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 911774566; Thu, 16 Jul 2026 09:59:23 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Jul 2026 09:59:22 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Jul 2026 09:59:22 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v12 5/7] Bluetooth: btmtksdio: Remove redundant firmware filename override
Date: Thu, 16 Jul 2026 09:59:17 +0800
Message-ID: <20260716015920.1886719-6-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260716015920.1886719-1-chris.lu@mediatek.com>
References: <20260716015920.1886719-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

btmtksdio_setup() calls btmtk_fw_get_filename() to generate the correct
firmware filename based on chip ID, then immediately overwrites it with
snprintf() using a generic legacy format. This causes newer chips that
require chip-specific firmware paths (MT6639, MT7925, MT7928) to request
incorrect legacy filenames, leading to firmware load failures.

The USB driver (btmtkusb.c) correctly uses btmtk_fw_get_filename()
without overriding the result. Match that behavior by removing the
redundant snprintf() call.

Fixes: 7f935b21bee4 ("Bluetooth: btmtk: apply the common btmtk_fw_get_filename")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 088fdfb56231..4a160d5131f1 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1164,9 +1164,6 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 		btmtk_fw_get_filename(fwname, sizeof(fwname), dev_id,
 				      fw_version, 0);
 
-		snprintf(fwname, sizeof(fwname),
-			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
-			 dev_id & 0xffff, (fw_version & 0xff) + 1);
 		err = mt79xx_setup(hdev, fwname, dev_id);
 		if (err < 0)
 			return err;
-- 
2.45.2

