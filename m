Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC94ABBC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721221; cv=none; b=aBNYb7blNgDkU17/BE/nNzDLl9MSLjqrzRo8fPaMQLKR5lTB+Fz2RCSIxeYgZdiZPM2ro2MojI0aBK5sZJVZjqEKXoW/ZrcBbNJ/UzoMRI5VKVdsRs2svxVJ+3Imk6xnIYtQ7s4TskeImbgwSzIoN7DBTeDJkALLBKneIGpsRxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721221; c=relaxed/simple;
	bh=Q5qlMYo9jSHBanshjDTuLuxx1LRjDCls4AYwyLkEUGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QqVmQqeH9NkpiTXJLonQAKqqD0A/6grat4S+5PK17pp1rAyo+WsmSdiFhSI8bZP1YcG1lEpiFkSbiRN5PFSDjWPFdJwpuSipdvC8R7zdHjzuihXMp39BM3OFQYnsJFe8CNnLUe758a3l9POO/p8FnnORQA05nVHBGe4D0fKKL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsfrqVdM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsfrqVdM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789721216; x=1821257216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q5qlMYo9jSHBanshjDTuLuxx1LRjDCls4AYwyLkEUGw=;
  b=XsfrqVdM0VU1SY9DUUIgx95g8blwR1fBT2ZrKQa1lQRlMVumqs3Z6nCb
   VfBN6TmUzyYg975CLbHhLRGLeRoQMmKfVnO/GA/psUFl6piEDuDayIo0F
   M2oogfqFXRf3/X/Jsbxpwefz8XKVyUBw0tBhmuMGTLR9HUguErWzkEdfv
   o20YOusfuuFDdn5N0CO9EMceSQ9IzkkJ6U650Kk2DhN99VLm9VTAfpuHP
   JhbCLdLrd29gZuUG9z6OnG8G139Ch99VpRakLhw/iZ41VS5G+LluJka4e
   D881BTYTQFQbPcMdFu1QEInVj5h9SjhX8oxSWAIcSR2t7kCJFbQIJbIO0
   g==;
X-CSE-ConnectionGUID: U8ya4q16Q96Pu2SeIJjIdA==
X-CSE-MsgGUID: a2rI7z45SMqYwgqg2FzIsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="94044759"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="94044759"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 01:46:54 -0700
X-CSE-ConnectionGUID: n2zMlJeTS1+wVxNsvCo3vQ==
X-CSE-MsgGUID: A9Vx4o0+RBuSRwk2s2NPbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="299394094"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa001.fm.intel.com with ESMTP; 18 Sep 2026 01:46:52 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1] =?UTF-8?q?=EF=BB=BFBluetooth:=20btintel:=20validate=20?= =?UTF-8?q?DDC=20record=20lengths?=
Date: Fri, 18 Sep 2026 14:08:38 +0530
Message-ID: <20260918083838.23676-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Parse DDC record lengths in unsigned storage so 0xFF does not wrap.
Reject records smaller than the mandatory three-byte header, records
exceeding U8_MAX, and records exceeding remaining firmware bytes before
issuing Intel_Write_DDC.

This issue was reported by Claude Mythos.

Fixes: 145f2368c5fd ("Bluetooth: btintel: Add Device Configuration support")
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 964d2de30e65..aecfab25edff 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -409,8 +409,16 @@ int btintel_load_ddc_config(struct hci_dev *hdev, const char *ddc_name)
 	/* DDC file contains one or more DDC structure which has
 	 * Length (1 byte), DDC ID (2 bytes), and DDC value (Length - 2).
 	 */
-	while (fw->size > fw_ptr - fw->data) {
-		u8 cmd_plen = fw_ptr[0] + sizeof(u8);
+	while (fw->size > (size_t)(fw_ptr - fw->data)) {
+		size_t remaining = fw->size - (fw_ptr - fw->data);
+		u8 cmd_plen = fw_ptr[0] + 1U;
+
+		if (cmd_plen < 3 || cmd_plen > U8_MAX || cmd_plen > remaining) {
+			bt_dev_err(hdev, "Malformed DDC record (plen=%u, remaining=%zu)",
+				   cmd_plen, remaining);
+			release_firmware(fw);
+			return -EINVAL;
+		}
 
 		skb = __hci_cmd_sync(hdev, 0xfc8b, cmd_plen, fw_ptr,
 				     HCI_INIT_TIMEOUT);
-- 
2.53.0

