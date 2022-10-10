Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F32C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 20:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiJJUhN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJJUgg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 16:36:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD137EFFA
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665434130; x=1696970130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pgXwzFPx2tJhStAb9dugB7qWHfF5mmuTgdrd5/SwxlE=;
  b=n8YDUpah3/WLTexGufTd2zaw8fOlT2Bc8YAjgYnGzyVgrtqJksCpYBdE
   ZpW1PROEtjdrXv8CU32afpAgSjCJ7mGWRMyvZDfZ4Kpy2xS6PCpS+LfVW
   jSOI/VPKuE17RPUSjzY4HFJNnCLla6KvwXa/egMqkwCRDEunqEuZu/MIf
   Veg/lJMTirGCfJ+EZlkpQXRe7ekoJ4+JGGGWBS+nxJHcOCCm+5NqPwT4Z
   Fc18iGXRcmRieoeO8uxTK/SRcBHi8XKr83IwG6hukLXG7au25izDAaMa5
   lGR4NNcj5D2WwXmev3fnRDi8EbLAFgfNSk829fVp+H2sNMwdSm1infOEf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="330802908"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="330802908"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 13:35:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="730696017"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="730696017"
Received: from yvasudev-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.135.7])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 13:35:29 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 1/2] Bluetooth: hci_sync: Fix not setting static address
Date:   Mon, 10 Oct 2022 13:35:21 -0700
Message-Id: <20221010203522.1251151-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to program the address stored in hdev->static_addr after
the init sequence has been complete:

@ MGMT Command: Set Static A.. (0x002b) plen 6
        Address: C0:55:44:33:22:11 (Static)
@ MGMT Event: Command Complete (0x0001) plen 7
      Set Static Address (0x002b) plen 4
        Status: Success (0x00)
        Current settings: 0x00008200
          Low Energy
          Static Address
@ MGMT Event: New Settings (0x0006) plen 4
        Current settings: 0x00008200
          Low Energy
          Static Address
< HCI Command: LE Set Random.. (0x08|0x0005) plen 6
        Address: C0:55:44:33:22:11 (Static)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 7
      Set Powered (0x0005) plen 4
        Status: Success (0x00)
        Current settings: 0x00008201
          Powered
          Low Energy
          Static Address
@ MGMT Event: New Settings (0x0006) plen 4
        Current settings: 0x00008201
          Powered
          Low Energy
          Static Address

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/hci_sync.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 76c3107c9f91..b53bb0ee9d39 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3054,6 +3054,7 @@ int hci_update_name_sync(struct hci_dev *hdev)
  * Enable Authentication
  * lmp_bredr_capable(Set Fast Connectable -> Set Scan Type -> Set Class ->
  * Set Name -> Set EIR)
+ * HCI_FORCE_STATIC_ADDR | BDADDR_ANY && !HCI_BREDR_ENABLED (Set Static Address)
  */
 int hci_powered_update_sync(struct hci_dev *hdev)
 {
@@ -3093,6 +3094,23 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 		hci_update_eir_sync(hdev);
 	}
 
+	/* If forcing static address is in use or there is no public
+	 * address use the static address as random address (but skip
+	 * the HCI command if the current random address is already the
+	 * static one.
+	 *
+	 * In case BR/EDR has been disabled on a dual-mode controller
+	 * and a static address has been configured, then use that
+	 * address instead of the public BR/EDR address.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
+	    (!bacmp(&hdev->bdaddr, BDADDR_ANY) &&
+	    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))) {
+		if (bacmp(&hdev->static_addr, BDADDR_ANY))
+			return hci_set_random_addr_sync(hdev,
+							&hdev->static_addr);
+	}
+
 	return 0;
 }
 
-- 
2.37.3

