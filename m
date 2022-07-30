Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E6BC00144
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 00:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiG3Auy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiG3Auw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 20:50:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B603173920
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 17:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659142251; x=1690678251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWVMLX40dH07f9AcuVgzOKAC3bgG/LUVNEKInKLHVhY=;
  b=d3uTdhNNLuwnn96eDIYPyVv2/R2TYTO8Ba5jttmEJbDwoMrXHR8Qi8Bb
   /jpcygbcILnmc0UlYDN5CX+3qlEqFCVYJ3aDq1+OlTT8Z6u3BiEDWuIyB
   95oYgYVqoU3HsJGIM9qaBfh9nuva+RVFZvcTRHUw75ntS2nnDNCuKTUWx
   QDHQhRZdQ2e0aJsgMbdO3w8glDWs/Zl4JiMd2xhyxQl1LwTWYo/RdgV25
   zkrEhX6a3HBAmx/ZdbktyTMbQLE7nsg84vsuxke97r1Yyz/y2s4e3cEL0
   XcC+lA8chL+iWSoReQwKtHcOdUiDHCG//VNioQwiF4wlEb+tseiHeOMUP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268644789"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="268644789"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660458107"
Received: from agcodina-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.26.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 03/10] Bluetooth: Delete unused hci_req_stop_discovery()
Date:   Fri, 29 Jul 2022 17:50:31 -0700
Message-Id: <20220730005038.894650-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730005038.894650-1-brian.gix@intel.com>
References: <20220730005038.894650-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_req_stop_discovery has been deprecated in favor of
hci_stop_discovery_sync() as part of transition to hci_sync.c

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/hci_request.c | 48 -------------------------------------
 net/bluetooth/hci_request.h |  2 --
 2 files changed, 50 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 114af7350363..ef0a5ec067b6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1975,54 +1975,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	return 0;
 }
 
-bool hci_req_stop_discovery(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct discovery_state *d = &hdev->discovery;
-	struct hci_cp_remote_name_req_cancel cp;
-	struct inquiry_entry *e;
-	bool ret = false;
-
-	bt_dev_dbg(hdev, "state %u", hdev->discovery.state);
-
-	if (d->state == DISCOVERY_FINDING || d->state == DISCOVERY_STOPPING) {
-		if (test_bit(HCI_INQUIRY, &hdev->flags))
-			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-			cancel_delayed_work(&hdev->le_scan_disable);
-			cancel_delayed_work(&hdev->le_scan_restart);
-			hci_req_add_le_scan_disable(req, false);
-		}
-
-		ret = true;
-	} else {
-		/* Passive scanning */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-			hci_req_add_le_scan_disable(req, false);
-			ret = true;
-		}
-	}
-
-	/* No further actions needed for LE-only discovery */
-	if (d->type == DISCOV_TYPE_LE)
-		return ret;
-
-	if (d->state == DISCOVERY_RESOLVING || d->state == DISCOVERY_STOPPING) {
-		e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY,
-						     NAME_PENDING);
-		if (!e)
-			return ret;
-
-		bacpy(&cp.bdaddr, &e->data.bdaddr);
-		hci_req_add(req, HCI_OP_REMOTE_NAME_REQ_CANCEL, sizeof(cp),
-			    &cp);
-		ret = true;
-	}
-
-	return ret;
-}
-
 static void config_data_path_complete(struct hci_dev *hdev, u8 status,
 				      u16 opcode)
 {
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 39d001fa3acf..faf6d9a51a91 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -113,8 +113,6 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 void __hci_req_update_class(struct hci_request *req);
 
 /* Returns true if HCI commands were queued */
-bool hci_req_stop_discovery(struct hci_request *req);
-
 int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec);
 
 void __hci_req_update_scan(struct hci_request *req);
-- 
2.37.1

