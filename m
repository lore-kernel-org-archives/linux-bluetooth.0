Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A349C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Nov 2021 09:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhK3J5Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Nov 2021 04:57:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:25027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234925AbhK3J5Y (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Nov 2021 04:57:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="216198718"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="216198718"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 01:54:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="458775974"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.158])
  by orsmga003.jf.intel.com with ESMTP; 30 Nov 2021 01:54:03 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH] Bluetooth: HCI: Fix authentication failure error during pairing
Date:   Tue, 30 Nov 2021 15:26:43 +0530
Message-Id: <20211130095643.3140-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When Experimental LL_Privacy enabled & Privacy is set to device mode the
pairing of 2 linux devices fails with authentication failure error. This
happens only on the 2nd attempt when we swap the advertiser/initiator
role. This is because the init_addr is updated with dev->rpa which still
holds the previous connection RPA. This patch fixes the issue when
ll_privacy is enabled.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9d8d2d9e5d1f..bd40d8cedc27 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5314,8 +5314,10 @@ static void le_conn_update_addr(struct hci_conn *conn, bdaddr_t *bdaddr,
 			conn->init_addr_type = ADDR_LE_DEV_RANDOM;
 			bacpy(&conn->init_addr, local_rpa);
 		} else if (hci_dev_test_flag(conn->hdev, HCI_PRIVACY)) {
-			conn->init_addr_type = ADDR_LE_DEV_RANDOM;
-			bacpy(&conn->init_addr, &conn->hdev->rpa);
+			if (!use_ll_privacy(conn->hdev)) {
+				conn->init_addr_type = ADDR_LE_DEV_RANDOM;
+				bacpy(&conn->init_addr, &conn->hdev->rpa);
+			}
 		} else {
 			hci_copy_identity_address(conn->hdev, &conn->init_addr,
 						  &conn->init_addr_type);
-- 
2.17.1

