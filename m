Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA4C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 23:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiHEXmx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 19:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbiHEXmu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 19:42:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030C7A52D
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659742969; x=1691278969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWVMLX40dH07f9AcuVgzOKAC3bgG/LUVNEKInKLHVhY=;
  b=iVcgW3ujfybnF4+OyuKdGy2QC0FDRN4qmvUDIGKj+2QT/4Qqoti751y4
   Gz+MWb8s+OxAu7eAD9O7ikaR6lvZ4B8OdIpUdmuAOflgA+NamRFsVFZdw
   io5SL3PXluZ27ipZAQbs5x3B5oEvpc/54SVz86KhMaoVngNgkt2p6583l
   53l/7SFFoFM/uJf8R9qqT1Dn8nOPYtvdkqykvKF794z0oEbpKWGka08I9
   7mTfXEwW/Y6su1ZNCEjHuU8vttfDmfSITPgSbRjXrDio1U+JBW/MOTmdp
   vqbWdWsih65ftRclwqLgJzhQT0T3Malko19PoTOLV4OjSZKw+HUl7XLmS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="273362749"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="273362749"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636661812"
Received: from bkkx-mobl.gar.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.189.232])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:42:48 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 3/9] Bluetooth: Delete unused hci_req_stop_discovery()
Date:   Fri,  5 Aug 2022 16:42:30 -0700
Message-Id: <20220805234236.704986-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234236.704986-1-brian.gix@intel.com>
References: <20220805234236.704986-1-brian.gix@intel.com>
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

