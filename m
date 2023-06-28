Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659EEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 12:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjF1MHU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 08:07:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:16081 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbjF1MHP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 08:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687954035; x=1719490035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ga7fUbmGAlxy8c6cPAmk558XDrxW+sqDcJCkkKRdIC8=;
  b=FW3/wjl8Z6NIUDlQgVzCMDM3b5IveYARvfZWwAcZePVJTkok2ijQgptT
   rgZri2qf9XSUXG3ctYRh5OVHHY/cGFAoBr6O/7XRBZbXyShFOY6HC/Kbb
   pNR67RzE3ii7l5/IWxK5YsnEkoBswFHRY9fd5Beei2HvSYfzD0LSHe1py
   pY/AKwdddTAOFgxJst8jkMJHvP/SkV1R1KPId/JmM6kqt9uBM3IFdPf47
   9q0Iqa0o9JeiCuKNX8f6NReYy/gK/swjkGr2mGOnPrsmA+dsCL3Aji1kd
   wk22ahKjdCh39aGkHNjLnCWyA8TtXTIIai0CCGeXbT2tUIz81g7YkMp+q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="342162475"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="342162475"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:07:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806866403"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="806866403"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 05:07:13 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Add support for Gale Peak
Date:   Wed, 28 Jun 2023 17:48:31 +0530
Message-Id: <20230628121831.827171-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add hardware variant(0x1c) for Gale Peak core (CNVi).

Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes  in v2:
1. Expand GaP to Gale Peak
2. s/GalePeak/Gale Peak/g

 drivers/bluetooth/btintel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dd1e48808ee2..b32277cb045d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -480,6 +480,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x18:	/* Slr */
 	case 0x19:	/* Slr-F */
 	case 0x1b:      /* Mgr */
+	case 0x1c:	/* Gale Peak (GaP) */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
@@ -2648,6 +2649,7 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x18:
 	case 0x19:
 	case 0x1b:
+	case 0x1c:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	default:
@@ -2862,6 +2864,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x18:
 	case 0x19:
 	case 0x1b:
+	case 0x1c:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.25.1

