Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E673909A5;
	Thu,  2 Jul 2026 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977328; cv=none; b=QQFHinbqjFeDEWwid/veYfHCOeuTWnvA2O4WDIFhDLEWc63hDKnLPeA6RrFlT8zpXqKHpMsA4wS+ELYktgNzELaBn1Wbl80qMK4eoWcy5z3SXzIpw8MKDGZ9voB88iiujFGJOBQpYAi8fXfVx8xXuTuFx6mpvlwhFgz0vXVzjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977328; c=relaxed/simple;
	bh=MmuxUMbyWpSTv6iXMU6eHpbmbJWcIObC9KVSH+TQ2Uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oqOYl8URHNnScqSqqyYLOKG6A2nPymiawp55zzRQKn+M/EwG4sIS8Uc5iYnK5h/xh/5KnxhvNZ3wO4silCmLWuus8l0d7+0LyOqTlj0qhkRel3ic7VaNmf1GLJoGN6vFevCyrf5yPzAPf7rQErndUvtWTSxb5vThUPgC0d+GEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=g224jKqu; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g224jKqu"
X-UUID: a76a24ce75e711f1b1788b6acf885367-20260702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YrokdWiFgz0+RYg6HbNZ5ygyiWPZhg28Eg4oHlA2GLA=;
	b=g224jKquWWtAwZvjv8/NmC17exFsGjX9nrG40d4fdwhrz/pOEt9fX/pInwQeVXF9WFZGfZZjpEl4p2sFsXijkHnaf3dspZJ+lqSZ9qNBKEIjlo71Ed3DOX6DotecB0/pP1ryR0nz1m9m4LVswivEBOjEXTbq6m82m1674MhWz4k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:8de50ae9-5aff-4dd8-905c-ce80bbe09d8a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:8c9db4c4-4062-4a8f-9776-acbccc936972,B
	ulkID:nil,BulkQuantity:0,SF:102|136|836|865|888|898,TC:-5,Content:0|15|50|
	99|100|102|156|200|213,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:
	nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a76a24ce75e711f1b1788b6acf885367-20260702
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 35107671; Thu, 02 Jul 2026 15:28:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 2 Jul 2026 15:28:41 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 2 Jul 2026 15:28:41 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
	Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v8 0/5] Bluetooth: btmtk: Add MT7928 support
Date: Thu, 2 Jul 2026 15:28:35 +0800
Message-ID: <20260702072840.1712057-1-chris.lu@mediatek.com>
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
quality, and finally add new functionality:

Patch 1 fixes a pre-existing security issue in btmtk_setup_firmware_79xx()
by adding comprehensive firmware size validation to prevent out-of-bounds
memory access with truncated or malicious firmware files.

Patch 2 fixes a regression introduced in commit 28b7c5a6db74
("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support") where
SDIO devices would incorrectly log "BT HW ver: 0x0000" due to
hardcoded dev_id=0.
The fix passes the device ID read from hardware register (0x70010200) to
mt79xx_setup(), ensuring SDIO devices display the correct chip ID, matching
the USB driver behavior.

Patch 3 refactors existing firmware download code by replacing magic
numbers with a descriptive BTMTK_WMT_PKT_* enum, making the packet
sequencing logic clearer.

Patch 4 improves BT firmware logging to provide more useful information
for debugging: adds firmware filename before loading and displays chip ID
as HW version instead of firmware's hwver field.

Patch 5 implements MT7928 firmware download flow, which requires loading
CBMCU firmware before Bluetooth firmware. The CBMCU firmware uses a
two-phase download sequence: Phase 1 downloads the section containing
global descriptor and signature data, Phase 2 downloads the remaining
firmware sections.

Tested on MT7928 hardware with successful firmware loading and
Bluetooth functionality verification.

Changes in v8:
- Add Patch 1 to fix firmware size validation in
  btmtk_setup_firmware_79xx()
- Add Patch 2 to fix SDIO device logging regression
  SDIO devices were passing hardcoded 0, causing "BT HW ver: 0x0000" log

Changes in v7:
- Patch 3 (was Patch 1): Extend magic number refactoring to
  btmtk_setup_firmware() in addition to btmtk_setup_firmware_79xx() for
  consistency
- Patch 4 (was Patch 2): Fix potential buffer over-read by
  using %.16s format specifier for hdr->datetime which is a 16-byte
  array that may not be null-terminated
- Patch 5 (was Patch 3): Apply same %.16s fix to CBMCU firmware logging

Changes in v6:
- Fix timeout handling in btmtk_cbmcu_patch_status() to return -ETIMEDOUT
  instead of success when polling exhausts retry count
- Add integer overflow protection in btmtk_load_cbmcu_firmware() using
  check_mul_overflow() and check_add_overflow()

Changes in v5:
- Split into three patches: refactoring, logging improvement, and
  new feature
- Add Patch 2 to improve BT firmware logging independently
- Apply same logging improvements to CBMCU firmware in Patch 3

Changes in v4:
- Split into two patches: refactoring and new feature
- Add BTMTK_WMT_PKT_* enum to improve code readability
- Replace magic numbers (0xF0, 0xF1) with descriptive macros

Changes in v3:
- Add firmware size validation with bounds checking
- Improve error messages with context information

Changes in v2:
- Simplified enum usage by consolidating status definitions

Chris Lu (5):
  Bluetooth: btmtk: Add firmware size validation in
    btmtk_setup_firmware_79xx()
  Bluetooth: btmtksdio: Pass hardware dev_id to mt79xx_setup()
  Bluetooth: btmtk: Replace magic numbers with WMT packet flag enum
  Bluetooth: btmtk: Improve BT firmware logging
  Bluetooth: btmtk: Add MT7928 support

 drivers/bluetooth/btmtk.c     | 427 +++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h     |   9 +
 drivers/bluetooth/btmtksdio.c |   6 +-
 3 files changed, 430 insertions(+), 12 deletions(-)

--
2.45.2

