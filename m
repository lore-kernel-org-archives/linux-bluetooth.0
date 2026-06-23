Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE730595C;
	Tue, 23 Jun 2026 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186094; cv=none; b=h/sUM1L7YkPU/lu+CuSY9HPxQ9EM7o5H7DS1JRzD/A7F9EWIom9FHN05sECLc8PjSXk2/8WCin15fuR2NORdazn/JWOcFP2zoJWE/RvdNV9qAcLdRNIv1dl5ruyYcyfosL55yV7hHNEU4/IPfQBa7dwOBQgvap1lzyFbho7dEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186094; c=relaxed/simple;
	bh=YrfLuldVIEeJ1WoYOpL8vZU3/15hI7Jc/6sF4J4TQh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eiDV8RzVnsItNh33yGSuzPZ1BtdoNQCQrRaqC+UstcAveR7Mta8EeEeWbACaIrL3LzUNFIAfsUD2pW72VpquvVKfXICZWkxa7yk2Lwm/yd4FNIP8PFPs4ZB48raTvIAzrpo1zSFo3BnGDcV8tnY9gvStSS2Oerc6f7x1oWalHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JkvHRIMy; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JkvHRIMy"
X-UUID: 68aa76326eb511f18dc8c9802ae25ab1-20260623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CRcMvd4k5Agc5WGNOplqEUE6B7dDRP1ZZ158/UcAHKE=;
	b=JkvHRIMy4CH+GBpcdMQR6Z+A2/p0CCPcqdSA0Bydk/A7nPzmi+TAhipddVk1TCZo1mwzjJgw7HxcS07LuAenurgD1Zu1TRFcCTGZWrzePBxMov3bF9e8QhmRmCGptMRpMH9zC9HkiMiOLE6AR1D5fAnLd1vbDOK+JvEmlcaX7r0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:28455294-6a1e-4be3-bd4b-0d141ea6e3d6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:2324ffed-45e6-4692-a476-3f71842ee83b,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50,
	EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 68aa76326eb511f18dc8c9802ae25ab1-20260623
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 722313400; Tue, 23 Jun 2026 11:41:24 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 23 Jun 2026 11:41:23 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 23 Jun 2026 11:41:23 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4 0/2] Bluetooth: btmtk: Add MT7928 support
Date: Tue, 23 Jun 2026 11:41:19 +0800
Message-ID: <20260623034121.691031-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Patch 1 refactors existing firmware download code by replacing magic
numbers with a descriptive BTMTK_WMT_PKT_* enum, making the packet
sequencing logic clearer.

Patch 2 implements MT7928 firmware download flow, which requires loading
CBMCU firmware before Bluetooth firmware. The CBMCU firmware uses a
two-phase download sequence: Phase 1 downloads the section containing
global descriptor and signature data, Phase 2 downloads the remaining
firmware sections. After CBMCU firmware completes, the driver continues
to load the Bluetooth firmware following the standard flow.

Tested on MT7928 hardware with successful firmware loading and
Bluetooth functionality verification.

Changes in v4:
- Split into two patches: refactoring and new feature
- Add BTMTK_WMT_PKT_* enum to improve code readability
- Replace magic numbers (0xF0, 0xF1) with descriptive macros
- Define MTK_SEC_CBMCU_DESC macro for section type
- Add MT7928 marketing name comment
- Include firmware filename in error messages
- Add detailed size information in firmware validation errors
- Use BTMTK_WMT_PKT_* enum in CBMCU download function

Changes in v3:
- Add firmware size validation with bounds checking
- Improve error messages with context information
- Add section offset validation for both phases

Changes in v2:
- Simplified enum usage by consolidating status definitions
- Improved code maintainability

Chris Lu (2):
  Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
  Bluetooth: btmtk: Add MT7928 support

 drivers/bluetooth/btmtk.c | 358 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h |   9 +
 2 files changed, 363 insertions(+), 4 deletions(-)

-- 
2.45.2

