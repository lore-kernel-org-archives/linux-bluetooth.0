Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC3446829;
	Wed, 15 Jul 2026 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114461; cv=none; b=f6pGnrqx5lEy54Dzbk1joxAg3IzsTKb6cn7+jy4c9C4xoKGuNvhN/UoSviQ/GxUxsQuEuwkngXgzIdyWlqdE3o5JHpy48ZZllIk+U1ngMyS8TGsW6LC372CTG1qomN3kElOx74wnFKZg/xjYjKV25zeGUFH7zTA0cRBdM2EPlTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114461; c=relaxed/simple;
	bh=gO0OZtkEMQNs35kjvOr1GZQ9TDhfeiTy87WUo/l5ZZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WdVDsjioI5B3eUcNv9Z48sA/kn7ByGHNEmFoSot/CntzppWZf/xIvcOPWrJaPedJ0dSuKpyCGpgClHLFne9zraqxTAOuOBifGeyX37STYg70S2YKP7p33H20xsEmIYR7uArNAL+CzjrPDHMtif1jpYyqOCjOQsGSr/LsJXLUHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=L2nnAhZK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L2nnAhZK"
X-UUID: 3c3e8138803f11f1b1788b6acf885367-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/IM7jFgWDB5um+8imm8nQeI3msVAkY93k29B0Q5JTfY=;
	b=L2nnAhZKMuRYTsfWml19Lnzx89+SK9oIisFP9e/UqdyFADu38r7SOOLgStQ9mGKPUF0KGD8rmh2beTnzCAY6s2mprJ3HdeJqQO9hbO01UajvmXZsxkpRVKcCfPBVwk/qAhflL0eAfKBbdZt46ViL/b5/YPhY/c4TtIPdM5EQoew=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:d50fa8d0-657a-48a2-b9a7-7d7a35ec5f78,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:09c8b937-7759-43a9-ae06-f4df9d53bea1,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50|
	99|100|102|156|200|213,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
	nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c3e8138803f11f1b1788b6acf885367-20260715
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 31342151; Wed, 15 Jul 2026 19:20:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
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
Subject: [PATCH v11 0/7] Bluetooth: btmtk: Add MT7928 support
Date: Wed, 15 Jul 2026 19:20:40 +0800
Message-ID: <20260715112048.1448868-1-chris.lu@mediatek.com>
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

The series is organized to fix existing issues first, then improve code
quality, and finally add new functionality. Patches have been reordered
in v11 to ensure each commit is independently compilable and functional
(bisectable).

Patch 1 fixes a DMA out-of-bounds access in btmtksdio_tx_packet() where
round_up() alignment causes DMA to read beyond the skb buffer, potentially
leaking kernel memory or triggering IOMMU faults. Also fixes a use-after-free
bug where sdio_hdr pointer becomes invalid after pskb_expand_head() reallocation.

Patch 2 fixes a pre-existing security issue in btmtk_setup_firmware_79xx()
by adding comprehensive firmware size validation to prevent out-of-bounds
memory access with truncated or malicious firmware files.

Patch 3 improves BT firmware logging to provide more useful information
for debugging: adds firmware filename before loading, displays chip ID
as HW version instead of firmware's hwver field, and uses %.16s format
specifier to prevent buffer over-read of the 16-byte datetime field.

Patch 4 fixes a regression introduced in commit 28b7c5a6db74
("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support") where
SDIO devices would incorrectly log "BT HW ver: 0x0000" due to
hardcoded dev_id=0. This also prevents potential MT6639 hardware hangs.

Patch 5 fixes a pre-existing bug in btmtksdio_setup() where
btmtk_fw_get_filename() generates the correct firmware path but is
immediately overwritten by snprintf() with a generic legacy format,
causing newer chips to request incorrect filenames. This patch depends
on Patch 4's dev_id fix.

Patch 6 refactors existing firmware download code by replacing magic
numbers with a descriptive BTMTK_WMT_PKT_* enum, making the packet
sequencing logic clearer.

Patch 7 implements MT7928 firmware download flow, which requires loading
CBMCU firmware before Bluetooth firmware. The CBMCU firmware uses a
two-phase download sequence: Phase 1 downloads the section containing
global descriptor and signature data, Phase 2 downloads the remaining
firmware sections.

Tested on MT7928 hardware with successful firmware loading and
Bluetooth functionality verification.

Changes in v11:
- Patch 1: Fix use-after-free vulnerability in btmtksdio_tx_packet()
  After pskb_expand_head() reallocates the skb buffer, sdio_hdr pointer
  becomes invalid. Fix by reassigning sdio_hdr after reallocation.
  Reported by AI review (Sashiko/Gemini).
- Reorder patches for bisectability:
  * Move Patch 6->3 (firmware logging improvement) to prevent introducing
    buffer over-read risk in intermediate commits
  * Move Patch 3->5 and Patch 4->3 to ensure dev_id fix is applied before
    removing redundant filename override, preventing potential MT6639 hangs

Changes in v10:
- Add Patch 1 to fix DMA out-of-bounds access in btmtksdio_tx_packet()
  Discovered during v9 review - round_up() alignment can cause DMA to read
  beyond skb buffer, potentially leaking kernel memory or triggering IOMMU
  faults. Fix by expanding skb tailroom and zero-filling padding.

Changes in v9:
- Reorder patches to group SDIO fixes together (Patch 3-4)
- Patch 2 (was Patch 1 in v8): Fix firmware size validation in
  btmtk_setup_firmware_79xx()
- Patch 3 (was Patch 1, new in v9): Fix firmware filename override in
  btmtksdio_setup() where btmtk_fw_get_filename() result was incorrectly
  overwritten by snprintf()
- Patch 4 (was Patch 2 in v8): Fix SDIO device logging regression
  SDIO devices were passing hardcoded 0, causing "BT HW ver: 0x0000" log

Changes in v8:
- Add Patch 2 to fix firmware size validation in btmtk_setup_firmware_79xx()
- Add Patch 3 to fix SDIO device logging regression
  SDIO devices were passing hardcoded 0, causing "BT HW ver: 0x0000" log

Changes in v7:
- Patch 6 (was Patch 2): Extend magic number refactoring to
  btmtk_setup_firmware() in addition to btmtk_setup_firmware_79xx() for
  consistency
- Patch 3 (was Patch 2): Fix potential buffer over-read by
  using %.16s format specifier for hdr->datetime which is a 16-byte
  array that may not be null-terminated
- Patch 7 (was Patch 3): Apply same %.16s fix to CBMCU firmware logging

Changes in v6:
- Fix timeout handling in btmtk_cbmcu_patch_status() to return -ETIMEDOUT
  instead of success when polling exhausts retry count
- Add integer overflow protection in btmtk_load_cbmcu_firmware() using
  check_mul_overflow() and check_add_overflow()

Changes in v5:
- Split into three patches: refactoring, logging improvement, and
  new feature
- Add Patch 3 to improve BT firmware logging independently
- Apply same logging improvements to CBMCU firmware in Patch 7

Changes in v4:
- Split into two patches: refactoring and new feature
- Add BTMTK_WMT_PKT_* enum to improve code readability
- Replace magic numbers (0xF0, 0xF1) with descriptive macros

Changes in v3:
- Add firmware size validation with bounds checking
- Improve error messages with context information

Changes in v2:
- Simplified enum usage by consolidating status definitions

Chris Lu (7):
  Bluetooth: btmtksdio: Fix DMA out-of-bounds access in TX path
  Bluetooth: btmtk: Add firmware size validation in
    btmtk_setup_firmware_79xx()
  Bluetooth: btmtk: Improve BT firmware logging
  Bluetooth: btmtksdio: Pass hardware dev_id to mt79xx_setup()
  Bluetooth: btmtksdio: Remove redundant firmware filename override
  Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
  Bluetooth: btmtk: Add MT7928 support

 drivers/bluetooth/btmtk.c     | 427 +++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h     |   9 +
 drivers/bluetooth/btmtksdio.c |  42 +++-
 3 files changed, 459 insertions(+), 19 deletions(-)

--
2.45.2

