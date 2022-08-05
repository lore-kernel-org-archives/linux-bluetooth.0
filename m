Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236CDC00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241531AbiHEXm4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiHEXmw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:42:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF102983F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659742970; x=1691278970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lwAl9WTMhGfjC5Ca4i7ov1Raytp01jqclqkgNlNyARs=;
  b=iDBLNQkA/gRZO0vCGwTdhiiiqTDwK8BtH5X3RoxhhOVJsdNDAP63cNs7
   1KV0S+xRyd1tXDkEwpI9xaq8iJQwDIR/fuj69dAJUhTlF/9ig6H/2bAh7
   kLkxA/tLLOlECE9R1TXyAor4nqFUN3nH8VGaAJ9KUAuLcECqZhCZ4KUJZ
   sTOtNtc6P80GlQdXCXklDL5Lv3H/STDu8puvAF21GAfDXhYBan4hGxmVF
   Qnxr2LsMJl3ot9djh9qI+aQotA4mx/O6xGJztxoXBpoFuXNlFj9UB8g7O
   LSI8y5imEe37Uv4KnaE2B9WmDpIRbuAcx2g6APmoJax+4+SdhGJH29eU4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273362753"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273362753"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636661825"
Received: from bkkx-mobl.gar.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.189.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 7/9] Bluetooth: move hci_get_random_address() to hci_sync
Date:   Fri,  5 Aug 2022 16:42:34 -0700
Message-Id: <20220805234236.704986-8-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234236.704986-1-brian.gix@intel.com>
References: <20220805234236.704986-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This function has no dependencies on the deprecated hci_request
mechanism, so has been moved unchanged to hci_sync.c

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci_sync.h |   5 +
 net/bluetooth/hci_request.c      | 255 +++++++++++--------------------
 net/bluetooth/hci_request.h      |   9 --
 net/bluetooth/hci_sync.c         |  73 +++++++++
 4 files changed, 170 insertions(+), 172 deletions(-)

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
index 685dc0f983b7..b9875224ac7b 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -650,6 +650,96 @@ static inline bool hci_is_le_conn_scanning(struct hci_dev *hdev)
 	return false;
 }
 
+static void set_random_addr(struct hci_request *req, bdaddr_t *rpa);
+static int hci_update_random_address(struct hci_request *req,
+				     bool require_privacy, bool use_rpa,
+				     u8 *own_addr_type)
+{
+	struct hci_dev *hdev = req->hdev;
+	int err;
+
+	/* If privacy is enabled use a resolvable private address. If
+	 * current RPA has expired or there is something else than
+	 * the current RPA in use, then generate a new one.
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
+		if (rpa_valid(hdev))
+			return 0;
+
+		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
+		if (err < 0) {
+			bt_dev_err(hdev, "failed to generate new RPA");
+			return err;
+		}
+
+		set_random_addr(req, &hdev->rpa);
+
+		return 0;
+	}
+
+	/* In case of required privacy without resolvable private address,
+	 * use an non-resolvable private address. This is useful for active
+	 * scanning and non-connectable advertising.
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
+		set_random_addr(req, &nrpa);
+		return 0;
+	}
+
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
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
+	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		if (bacmp(&hdev->static_addr, &hdev->random_addr))
+			hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
+				    &hdev->static_addr);
+		return 0;
+	}
+
+	/* Neither privacy nor static address is being used so use a
+	 * public address.
+	 */
+	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+
+	return 0;
+}
+
 /* Ensure to call hci_req_add_le_scan_disable() first to disable the
  * controller based address resolution to be able to reconfigure
  * resolving list.
@@ -859,79 +949,6 @@ static void interleave_scan_work(struct work_struct *work)
 				   &hdev->interleave_scan, timeout);
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
 static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -956,96 +973,8 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
 }
 
-int hci_update_random_address(struct hci_request *req, bool require_privacy,
-			      bool use_rpa, u8 *own_addr_type)
-{
-	struct hci_dev *hdev = req->hdev;
-	int err;
-
-	/* If privacy is enabled use a resolvable private address. If
-	 * current RPA has expired or there is something else than
-	 * the current RPA in use, then generate a new one.
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
-		if (rpa_valid(hdev))
-			return 0;
-
-		err = smp_generate_rpa(hdev, hdev->irk, &hdev->rpa);
-		if (err < 0) {
-			bt_dev_err(hdev, "failed to generate new RPA");
-			return err;
-		}
-
-		set_random_addr(req, &hdev->rpa);
-
-		return 0;
-	}
-
-	/* In case of required privacy without resolvable private address,
-	 * use an non-resolvable private address. This is useful for active
-	 * scanning and non-connectable advertising.
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
-		set_random_addr(req, &nrpa);
-		return 0;
-	}
-
-	/* If forcing static address is in use or there is no public
-	 * address use the static address as random address (but skip
-	 * the HCI command if the current random address is already the
-	 * static one.
-	 *
-	 * In case BR/EDR has been disabled on a dual-mode controller
-	 * and a static address has been configured, then use that
-	 * address instead of the public BR/EDR address.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
-	    !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
-	    (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
-	     bacmp(&hdev->static_addr, BDADDR_ANY))) {
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
-		if (bacmp(&hdev->static_addr, &hdev->random_addr))
-			hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
-				    &hdev->static_addr);
-		return 0;
-	}
-
-	/* Neither privacy nor static address is being used so use a
-	 * public address.
-	 */
-	*own_addr_type = ADDR_LE_DEV_PUBLIC;
-
-	return 0;
-}
-
-void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
-		      u8 reason)
+static void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
+			     u8 reason)
 {
 	switch (conn->state) {
 	case BT_CONNECTED:
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 55205cc9f281..c7185ad77c6e 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -74,16 +74,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req);
 void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next);
 
 int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance);
-int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
-			   bool use_rpa, struct adv_info *adv_instance,
-			   u8 *own_addr_type, bdaddr_t *rand_addr);
-
-int hci_update_random_address(struct hci_request *req, bool require_privacy,
-			      bool use_rpa, u8 *own_addr_type);
 
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
-void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
-		      u8 reason);
-
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bc993dd2383d..46eb535ff466 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5992,3 +5992,76 @@ int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle)
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

