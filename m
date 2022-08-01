Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D5C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 17:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiHARPx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiHARPc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 13:15:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349D38B9
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659374127; x=1690910127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QZIqcrGVe/FEbDMCSbePjFermtK5pvL/foLxcUoesp0=;
  b=Lqje4Zl4cYi2h3cCspNc9hXi2SkhDT7+hn8WgIUY8ih3dxyv68SLllEm
   q0XEzndIEOncwSIlXa+5GgA4N1dv3wEqCyMXjbxi90s9ExGEbbh36AnV/
   1OfWSFDoPTG2G2Xr4hJLAZEWMai4k5S5vxyZDI1tXZr3sBEqE4qYXcGgC
   pr8/yM09nQQVvSnT1zsETPFeskeLlFf6q9+TmNJ7ITpDsGE6eLUsOlC61
   Vya1qr/vSbXlSX87tRralUKMfM6wdN74cuE+7OjTRZW2T6/7cXLp0YBP4
   loQUHWbPyalvXKQtK/rmXGFI+ywRqlJVkj4EzQmzj4sP/ATaazyviSeH2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276104776"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="276104776"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="847899641"
Received: from gestarne-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.120.49])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:17 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v6 08/10] Bluetooth: move hci_get_random_address() to hci_sync
Date:   Mon,  1 Aug 2022 10:15:03 -0700
Message-Id: <20220801171505.1271059-9-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801171505.1271059-1-brian.gix@intel.com>
References: <20220801171505.1271059-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This function has no dependencies on the deprecated hci_request
mechanism, so has been moved unchanged to hci_sync.c

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |  5 +++
 net/bluetooth/hci_request.c      | 73 --------------------------------
 net/bluetooth/hci_request.h      |  4 --
 net/bluetooth/hci_sync.c         | 73 ++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index aea950440b9d..b6b975c2ed3e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -16,6 +16,7 @@ struct hci_cmd_sync_work_entry {
 	hci_cmd_sync_work_destroy_t destroy;
 };
 
+struct adv_info;
 /* Function with sync suffix shall not be called with hdev->lock held as they
  * wait the command to complete and in the meantime an event could be received
  * which could attempt to acquire hdev->lock causing a deadlock.
@@ -51,6 +52,10 @@ int hci_update_class_sync(struct hci_dev *hdev);
 int hci_update_name_sync(struct hci_dev *hdev);
 int hci_write_ssp_mode_sync(struct hci_dev *hdev, u8 mode);
 
+int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
+			   bool use_rpa, struct adv_info *adv_instance,
+			   u8 *own_addr_type, bdaddr_t *rand_addr);
+
 int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 				   bool rpa, u8 *own_addr_type);
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 458f21d4e0b2..31b75253a7eb 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -337,79 +337,6 @@ int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
 	return hci_req_run(&req, NULL);
 }
 
-int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
-			   bool use_rpa, struct adv_info *adv_instance,
-			   u8 *own_addr_type, bdaddr_t *rand_addr)
-{
-	int err;
-
-	bacpy(rand_addr, BDADDR_ANY);
-
-	/* If privacy is enabled use a resolvable private address. If
-	 * current RPA has expired then generate a new one.
-	 */
-	if (use_rpa) {
-		/* If Controller supports LL Privacy use own address type is
-		 * 0x03
-		 */
-		if (use_ll_privacy(hdev))
-			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
-		else
-			*own_addr_type = ADDR_LE_DEV_RANDOM;
-
-		if (adv_instance) {
-			if (adv_rpa_valid(adv_instance))
-				return 0;
-		} else {
-			if (rpa_valid(hdev))
-				return 0;
-		}
-
-		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
-		if (err < 0) {
-			bt_dev_err(hdev, "failed to generate new RPA");
-			return err;
-		}
-
-		bacpy(rand_addr, &hdev->rpa);
-
-		return 0;
-	}
-
-	/* In case of required privacy without resolvable private address,
-	 * use an non-resolvable private address. This is useful for
-	 * non-connectable advertising.
-	 */
-	if (require_privacy) {
-		bdaddr_t nrpa;
-
-		while (true) {
-			/* The non-resolvable private address is generated
-			 * from random six bytes with the two most significant
-			 * bits cleared.
-			 */
-			get_random_bytes(&nrpa, 6);
-			nrpa.b[5] &= 0x3f;
-
-			/* The non-resolvable private address shall not be
-			 * equal to the public address.
-			 */
-			if (bacmp(&hdev->bdaddr, &nrpa))
-				break;
-		}
-
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
-		bacpy(rand_addr, &nrpa);
-
-		return 0;
-	}
-
-	/* No privacy so use a public address. */
-	*own_addr_type = ADDR_LE_DEV_PUBLIC;
-
-	return 0;
-}
-
 static void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 			     u8 reason)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 8e42b892b679..9792c34a681c 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -71,8 +71,4 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 void __hci_req_update_adv_data(struct hci_request *req, u8 instance);
 int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance);
 
-int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
-			   bool use_rpa, struct adv_info *adv_instance,
-			   u8 *own_addr_type, bdaddr_t *rand_addr);
-
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bb664fa9f95e..f2f3a0e8fbaf 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6047,3 +6047,76 @@ int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle)
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_PA_TERM_SYNC,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
+
+int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
+			   bool use_rpa, struct adv_info *adv_instance,
+			   u8 *own_addr_type, bdaddr_t *rand_addr)
+{
+	int err;
+
+	bacpy(rand_addr, BDADDR_ANY);
+
+	/* If privacy is enabled use a resolvable private address. If
+	 * current RPA has expired then generate a new one.
+	 */
+	if (use_rpa) {
+		/* If Controller supports LL Privacy use own address type is
+		 * 0x03
+		 */
+		if (use_ll_privacy(hdev))
+			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
+		else
+			*own_addr_type = ADDR_LE_DEV_RANDOM;
+
+		if (adv_instance) {
+			if (adv_rpa_valid(adv_instance))
+				return 0;
+		} else {
+			if (rpa_valid(hdev))
+				return 0;
+		}
+
+		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+		if (err < 0) {
+			bt_dev_err(hdev, "failed to generate new RPA");
+			return err;
+		}
+
+		bacpy(rand_addr, &hdev->rpa);
+
+		return 0;
+	}
+
+	/* In case of required privacy without resolvable private address,
+	 * use an non-resolvable private address. This is useful for
+	 * non-connectable advertising.
+	 */
+	if (require_privacy) {
+		bdaddr_t nrpa;
+
+		while (true) {
+			/* The non-resolvable private address is generated
+			 * from random six bytes with the two most significant
+			 * bits cleared.
+			 */
+			get_random_bytes(&nrpa, 6);
+			nrpa.b[5] &= 0x3f;
+
+			/* The non-resolvable private address shall not be
+			 * equal to the public address.
+			 */
+			if (bacmp(&hdev->bdaddr, &nrpa))
+				break;
+		}
+
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		bacpy(rand_addr, &nrpa);
+
+		return 0;
+	}
+
+	/* No privacy so use a public address. */
+	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+
+	return 0;
+}
-- 
2.37.1

