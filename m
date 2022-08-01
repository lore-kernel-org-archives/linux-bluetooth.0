Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C461AC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 17:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiHARPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiHARP0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 13:15:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4AE05
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659374119; x=1690910119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWVMLX40dH07f9AcuVgzOKAC3bgG/LUVNEKInKLHVhY=;
  b=CgdHnK7diU3dGaZCHr5tjLAHn4GAxakxoYZpraffO9Id+pHcE1YSL4iV
   fcPmQiEa0QK+8U8qNEB0Jjglp35O5pg/+TlytK468bltLXzZaswb/n/Yo
   C2f1zIHFRZVe2cFzrnWjmOg2fskf1nqcxzfHPktqaGpoy1gmoD5KhoUMR
   nDTKVlqRAMeh0TbWBfGQVXVGOjfRavsOokZAldmVRQZqypE3NsUBKzGSI
   Hh7jlzn+qKLQN2NG3fB8NUBzwIiD63fmEtncJK9JqHIn6oOj2j+CoO7Tj
   u/A1zBUvcNap7lv+4ouCkangwx5z3/wtcj9+kDIZe6Wodag3KooEkdpyw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276104769"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="276104769"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="847899623"
Received: from gestarne-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.120.49])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 10:15:16 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v6 03/10] Bluetooth: Delete unused hci_req_stop_discovery()
Date:   Mon,  1 Aug 2022 10:14:58 -0700
Message-Id: <20220801171505.1271059-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801171505.1271059-1-brian.gix@intel.com>
References: <20220801171505.1271059-1-brian.gix@intel.com>
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

