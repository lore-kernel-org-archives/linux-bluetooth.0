Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B353F8EA6;
	Wed,  1 Jul 2026 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908038; cv=none; b=sBY/9S2VLHrjdjsFoF8GPYK+J9KPtdpAW8Kf58pqy3EN/5aonZ0wsGym3Jy1/El2m32VGvU07/o5zqL4du7Q6iWf2G+zDAMm7ROVPhkMpiHO2L95znM+/oP+d+ue/1gUk7nFd7BHH4QkieDbAKy36j7jr9ZAYHUKc7rV2fhrqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908038; c=relaxed/simple;
	bh=g5kFjC2o1lPg4TiirSUJIrYYcxUPcoB1mm7zR289U4Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OgN5L5c/kDqe0AO8MWvk+Kh7ssni/QTxdRTwbe3KhQm+QU55jIjiiDlNIlL6kHWyd88GkzDPqQhkkwN7tAg5poxw6r/V+6HmwVoq7UKn2NUOAFdzNGLGadCGsDptkRpTkEz0xRODpTliRLEqxbI1xdwwu0sMr2wIth8x73Gc1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oRp4qbKR; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oRp4qbKR"
X-UUID: 509c9fb0754611f18dc8c9802ae25ab1-20260701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sPC+uU4dZUPOEqH7jbkr5hTk4ommvFMEylVFhp/9i2w=;
	b=oRp4qbKRK8JsR7pkBl9hCo9ZarxGiITyw3Co7OoSPsoTybXpygEAFUAS1gjur0vugUio/0YOWGng2WEDrjZZAHC8VXHCunn7KMSYLsPdELeCHB8s3IzOjJ5JB0byBL058bgLabq8h1WFdRwrXh7DrbYUynUYttUl283m8whBCxk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:0d98c914-0fef-458f-b364-7f30396b1c2c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:2d61de81-6310-4e6b-a6b1-aca20d98ed8b,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50|
	99|100|102|156|200|213,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,B
	EC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 509c9fb0754611f18dc8c9802ae25ab1-20260701
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1401663171; Wed, 01 Jul 2026 20:13:48 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 1 Jul 2026 20:13:47 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 1 Jul 2026 20:13:47 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
	Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v7 0/3] Bluetooth: btmtk: Add MT7928 support
Date: Wed, 1 Jul 2026 20:13:42 +0800
Message-ID: <20260701121345.1231906-1-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for MT7928 (device ID 0x7935) to the
btmtk driver, which requires a new two-stage firmware loading process
with CBMCU firmware.

Patch 1 refactors existing firmware download code by replacing magic
numbers with a descriptive BTMTK_WMT_PKT_* enum, making the packet
sequencing logic clearer.

Patch 2 improves BT firmware logging to provide more useful information
for debugging: adds firmware filename before loading and displays chip ID
as HW version instead of firmware's hwver field.

Patch 3 implements MT7928 firmware download flow, which requires loading
CBMCU firmware before Bluetooth firmware. The CBMCU firmware uses a
two-phase download sequence: Phase 1 downloads the section containing
global descriptor and signature data, Phase 2 downloads the remaining
firmware sections. After CBMCU firmware completes, the driver continues
to load the Bluetooth firmware following the standard flow.

Tested on MT7928 hardware with successful firmware loading and
Bluetooth functionality verification.

Changes in v7:
- Patch 1: Extend magic number refactoring to btmtk_setup_firmware()
  in addition to btmtk_setup_firmware_79xx() for consistency across
  the driver
- Patch 2: Fix potential buffer over-read by using %.16s format
  specifier for hdr->datetime which is a 16-byte array that may not
  be null-terminated
- Patch 3: Apply same %.16s fix to CBMCU firmware logging to prevent
  reading beyond array boundary

Changes in v6:
- Fix timeout handling in btmtk_cbmcu_patch_status() to return -ETIMEDOUT
  instead of success when polling exhausts retry count, preventing silent
  timeout that could bypass concurrent download protection
- Add integer overflow protection in btmtk_load_cbmcu_firmware() using
  check_mul_overflow() and check_add_overflow() to prevent malicious
  firmware with large section_num from bypassing size validation through
  32-bit arithmetic wraparound on 32-bit architectures

Changes in v5:
- Split into three patches: refactoring, logging improvement, and
  new feature
- Add Patch 2 to improve BT firmware logging independently
  * Add firmware filename before loading
  * Display chip ID (dev_id) as HW version
  * Use clearer log format with separate HW/SW version fields
- Apply same logging improvements to CBMCU firmware in Patch 3
- Better separation of concerns for easier review

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

Chris Lu (3):
  Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
  Bluetooth: btmtk: Improve BT firmware logging
  Bluetooth: btmtk: Add MT7928 support

 drivers/bluetooth/btmtk.c | 388 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h |   9 +
 2 files changed, 388 insertions(+), 9 deletions(-)

--
2.45.2

