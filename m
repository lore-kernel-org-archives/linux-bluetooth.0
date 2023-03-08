Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B082CC678D5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 07:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCHHsJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCHHsH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Mar 2023 02:48:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67B17CCF
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 23:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678261685; x=1709797685;
  h=from:to:cc:subject:date:message-id;
  bh=RtZ5oIEUSoLHwRJW+yI4U0mCO+6mM7MVUFD0dEPLXOs=;
  b=LPvhyebfYiTFcUxjqOdlMiDmI+vH3lbFT8HUpCzaNKLBUT8FKnhIIZuk
   6yaRc7eKHCP/cx8HjHt2gY7RPzbAuLEnQez5FuwJzHWkMqtJpi3/zJ0WO
   jBDTQfuK9KSrqaSaVc2dDvH72rA2W2hoTkd5H747ia9xD0CEH6VRgq/sX
   rSQdn2DbrkGbGFyYkG7hCiiEXqdIfz6vdb67HGvaDVbeLbCWehh2Tif8N
   K8HBGTze87zUGN6Gj6ckohwxQlohdeBOljY952d33Ai1Bk91XNKcZtWsg
   0/QrB9cTGa2aEcmXBRjXJ3q4GKYtG7+SvCsT1HNwZWlaVaE79ePFG89gJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="319921287"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="319921287"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 23:48:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="679249755"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="679249755"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga007.fm.intel.com with ESMTP; 07 Mar 2023 23:48:02 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, lokendra.singh@intel.com,
        chethan.tumkur.narayan@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btinel: Check ACPI handle for NULL before accessing
Date:   Wed,  8 Mar 2023 13:28:37 +0530
Message-Id: <20230308075837.5559-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Older platforms and Virtual platforms which doesn't have support for
bluetooth device in ACPI firmware will not have valid ACPI handle. Check
for validity of handle before accessing.

dmesg log from simics environment (virtual platform):

BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
IP: acpi_ns_walk_namespace+0x5c/0x278
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
Modules linked in: bnep intel_powerclamp coretemp kvm_intel kvm irqbypass intel_cstate input_leds joydev serio_raw mac_hid btusb(OE) btintel(OE) bluetooth(OE) lpc_ich compat(OE) ecdh_generic i7core_edac i5500_temp shpchp binfmt_misc sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic usbhid hid e1000e psmouse ahci pata_acpi libahci ptp pps_core floppy
CPU: 0 PID: 35 Comm: kworker/u3:0 Tainted: G           OE    4.15.0-140-generic #144-Ubuntu
Hardware name: Simics Simics, BIOS Simics 01/01/2011
Workqueue: hci0 hci_power_on [bluetooth]
RIP: 0010:acpi_ns_walk_namespace+0x5c/0x278
RSP: 0000:ffffaa9c0049bba8 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 0000000000001001 RCX: 0000000000000010
RDX: ffffffff92ea7e27 RSI: ffffffff92ea7e10 RDI: 00000000000000c8
RBP: ffffaa9c0049bbf8 R08: 0000000000000000 R09: ffffffffc05b39d0
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: ffffffffc05b39d0 R15: ffffaa9c0049bc70
FS:  0000000000000000(0000) GS:ffff8be73fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 0000000075f0e000 CR4: 00000000000006f0

Fixes: ee9b749cb9ad ("Bluetooth: btintel: Iterate only bluetooth device ACPI entries")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e8d4b59e89c5..af774688f1c0 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2326,6 +2326,7 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	struct btintel_ppag ppag;
 	struct sk_buff *skb;
 	struct btintel_loc_aware_reg ppag_cmd;
+	acpi_handle handle;
 
 	/* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */
 	switch (ver->cnvr_top & 0xFFF) {
@@ -2335,12 +2336,18 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 		return;
 	}
 
+	handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
+	if (!handle) {
+		bt_dev_info(hdev, "No support for BT device in ACPI firmware");
+		return;
+	}
+
 	memset(&ppag, 0, sizeof(ppag));
 
 	ppag.hdev = hdev;
 	ppag.status = AE_NOT_FOUND;
-	acpi_walk_namespace(ACPI_TYPE_PACKAGE, ACPI_HANDLE(GET_HCIDEV_DEV(hdev)),
-			    1, NULL, btintel_ppag_callback, &ppag, NULL);
+	acpi_walk_namespace(ACPI_TYPE_PACKAGE, handle, 1, NULL,
+			    btintel_ppag_callback, &ppag, NULL);
 
 	if (ACPI_FAILURE(ppag.status)) {
 		if (ppag.status == AE_NOT_FOUND) {
-- 
2.17.1

