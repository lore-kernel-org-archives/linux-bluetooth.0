Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752DFC19F29
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jul 2022 23:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbiGZXBx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiGZXBw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 19:01:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C6E088
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658876511; x=1690412511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWVMLX40dH07f9AcuVgzOKAC3bgG/LUVNEKInKLHVhY=;
  b=QTsIGhixeOsJHl3cb0djKLpCld3Pa+9nNHFgPWmhEcVtYIyPzPqKDc3C
   p1IurUBW6PTXiZYzXiy8q1cnii6V2Rc8YbwnC/bM7hp9NDINkyn8FHMwB
   cFvrJtCzM5dT8U73GcdN/rKtta20lEnap1NPCW40y8BNdjd2tOylLvcK9
   inzYQ0wWetZZkLXkq+mQ4TDjcqzQ9kkxeF0T+mmu0OFutrib4TliF8fxA
   g8AzlrDGF9nlWTVLM1+X+H3i4eRFzUfxgaa4mJKZSVU7/rW+BV7qbEv3D
   fwVsiGbVW8p9me7IVMOz2VGQqgOxktl6VAVuXEEikTgUm8qpf/Rbr9Bq7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289284697"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="289284697"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 16:01:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="668098987"
Received: from srezaei-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.5.115])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 16:01:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v3 3/4] Bluetooth: Delete unused hci_req_stop_discovery()
Date:   Tue, 26 Jul 2022 16:01:39 -0700
Message-Id: <20220726230140.205481-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726230140.205481-1-brian.gix@intel.com>
References: <20220726230140.205481-1-brian.gix@intel.com>
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

