Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341953911C9;
	Thu,  2 Jul 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977331; cv=none; b=oIiDFXf7+IJ56XVTj4yIvj8Qg1P+6cWUTVUkzilEwNApT5b/RsrlRcriaE0Bc6ucrc0JJUJqCqCw61jR574vtT+fzdQx6vHpEdwNZwjLyfl1KZOVPxGfgCKuUGdD2djugGRHrPvH9E+IALt1WHiZOIrLCfjvF5RnPl3aqlpkFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977331; c=relaxed/simple;
	bh=DGVeYPZ0MZEnTBSKiwGlOgfqUKTe34AAu6a0BHoyf4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIU2935n3FK/pwSPk20C13L4G8RA68eKOo/vcUHTQ39iGX1J5nyNVpmLiq02fx+hBv3zPx0SYJecbTa/twaeKUjhJvDFqr0qs6GYjngWFoayan4JFeXA8H+v/SlKC3hlovtU6C7NqfHssuxrWnG0aNfJzzW/FQSIleQrS2qLLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WFZRlC3U; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WFZRlC3U"
X-UUID: a7ae15c675e711f1b1788b6acf885367-20260702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=epGXLRCmvcx4nX7CFVTmNreEgf6Ukls0mpRDETc2X1k=;
	b=WFZRlC3UVH0moNLetTf/KmYfHtbyaAwfc8N39u337/RvqAWWenWddMtnG3+gb3iADqNoTHdB8X9GAn00MuE1zjYCCRMKcgwcGch1jRXjQ7L6us1/sy1RuUia32IFxLxbAKCZvb1bLQ9bJ+V4ZjU0mOspvhQGwMcM/S+UTpt2+BM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:11fa3299-303f-441a-b2d2-1ec32366c12a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:498f3504-3795-4a90-800e-68e9393a343e,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a7ae15c675e711f1b1788b6acf885367-20260702
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 914689321; Thu, 02 Jul 2026 15:28:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 2 Jul 2026 15:28:42 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 2 Jul 2026 15:28:42 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
	Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v8 3/5] Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
Date: Thu, 2 Jul 2026 15:28:38 +0800
Message-ID: <20260702072840.1712057-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260702072840.1712057-1-chris.lu@mediatek.com>
References: <20260702072840.1712057-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add BTMTK_WMT_PKT_* enum to represent WMT download packet sequence flags,
improving code readability. Replace magic numbers (1, 2, 3) in
btmtk_setup_firmware_79xx() and btmtk_setup_firmware() with descriptive
enum values:

- BTMTK_WMT_PKT_START (1): First packet of a sequence
- BTMTK_WMT_PKT_CONTINUE (2): Continuation packet
- BTMTK_WMT_PKT_END (3): Final packet of a sequence

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Assisted-by: Claude:Sonnet-4.5
---
 drivers/bluetooth/btmtk.c | 12 ++++++------
 drivers/bluetooth/btmtk.h |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 3491060b3ae9..3fe6b4fdc438 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -269,12 +269,12 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			while (dl_size > 0) {
 				dlen = min_t(int, 250, dl_size);
 				if (first_block == 1) {
-					flag = 1;
+					flag = BTMTK_WMT_PKT_START;
 					first_block = 0;
 				} else if (dl_size - dlen <= 0) {
-					flag = 3;
+					flag = BTMTK_WMT_PKT_END;
 				} else {
-					flag = 2;
+					flag = BTMTK_WMT_PKT_CONTINUE;
 				}
 
 				wmt_params.flag = flag;
@@ -353,7 +353,7 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 
 	fw_size -= 30;
 	fw_ptr += 30;
-	flag = 1;
+	flag = BTMTK_WMT_PKT_START;
 
 	wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
 	wmt_params.status = NULL;
@@ -363,9 +363,9 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 
 		/* Tell device the position in sequence */
 		if (fw_size - dlen <= 0)
-			flag = 3;
+			flag = BTMTK_WMT_PKT_END;
 		else if (fw_size < fw->size - 30)
-			flag = 2;
+			flag = BTMTK_WMT_PKT_CONTINUE;
 
 		wmt_params.flag = flag;
 		wmt_params.dlen = dlen;
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index c83c24897c95..51c18dde0a80 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -66,6 +66,12 @@ enum {
 	BTMTK_WMT_ON_PROGRESS,
 };
 
+enum {
+	BTMTK_WMT_PKT_START = 1,
+	BTMTK_WMT_PKT_CONTINUE = 2,
+	BTMTK_WMT_PKT_END = 3,
+};
+
 struct btmtk_wmt_hdr {
 	u8	dir;
 	u8	op;
-- 
2.45.2

