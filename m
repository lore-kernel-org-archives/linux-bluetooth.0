Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10BDEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 11:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjF1L23 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:28:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:52022 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbjF1L2U (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 07:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687951700; x=1719487700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VNokpdqNUMvToi4DzY5hRAgugzIb5OrVtl61Xpgyjyc=;
  b=DXYKv/vUcgUYECZdj0EGRTElzgPQWMcSRX804TINB7k6UKEDKgoJ8DNT
   zBehZwxUVyso+cH57jXQBwpdB/zUR7nEYhHdzyRQXg5knKA91NBmYAWeV
   MShs+nSykxTMIdYBMOVhUZCbs2mrotyrO6NDVayuS+hzB+51zHDmYFyKJ
   VZYlIgCJgjakaTvqLI03DR4GzeLaITzDIqfnmZBHpqgNmZxZve72UCXq0
   XUe90699nJQWRwSUxLa+ycUFm270WLzw4Bpcs5PRyCbm1pbXppV1r0MwU
   l8df9L/vs/1HOhwqz+oF9+d/YaeQeBWNFivlCA+dW2j/9xvM+p8fpe34S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427823877"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="427823877"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 04:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="782245092"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="782245092"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2023 04:28:18 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add support for GalePeak
Date:   Wed, 28 Jun 2023 17:09:34 +0530
Message-Id: <20230628113934.824668-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hardware variant for GalePeak core (CNVi) is added.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dd1e48808ee2..f4d096639080 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -480,6 +480,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x18:	/* Slr */
 	case 0x19:	/* Slr-F */
 	case 0x1b:      /* Mgr */
+	case 0x1c:	/* GaP */
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

