Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C20C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 00:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE26614C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 00:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhKLAvj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbhKLAvi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 19:51:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18960C061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 16:48:48 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so5750736pju.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 16:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S082HjhvoINmVnjVwNJt8+VPfVgH9HKHe7qt1hFSnEI=;
        b=gn4TaBK+pewJQ/d9TZh8YFDTHQTCcUz8z3gj0VV6xttYOjLUKUV+FAYtOXgP5zWTBV
         eT4G2sIRzabMiAw8aFvqC2gyIcCjt01V/w+WHroxekDy0OkKC+Cr7SleHtiL4uOjUU6J
         ox344MTN97ztzE/lxkw40FhFQ8VT5gvkfWVQbaAXx3phjj1rUVAF8fOjZ+idY36lTdeu
         G3JyxaRIuz5CsQbMJ6ZnLZOYGSQt8nplbTOstg2sCbJV8ScdLYUSOXtsd5BOGS5CA2sn
         XPRTQX2kuAd+QEG+IlnIcgKcQFRsW1t5sBi+7Ta1YFTywT2NZdOrSQMJUd3kIv6JklZf
         si1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S082HjhvoINmVnjVwNJt8+VPfVgH9HKHe7qt1hFSnEI=;
        b=ZbrRd6EKAA/IxVU06LYRLWC8349aJ8mvb7tVr5zrZjii4rqbMVA8+maxjpJEhNlCod
         0pbYQeXoclrRm7UisAg5BSfhuFqt8N12FdmbvQLVteDrEmaOCdJncUWoHVvxW/kFcbYa
         YPjJJ+VOxHxPCyi9H3b2LxsahVUeszPTIDx5hSm9WqtKFpMGLorhZwQFYCviXIFPFB3y
         GTQo4dnwkned88f92VhkOuUKJnyhZLxl63fIBmncAhAOfJKhqeqVzz1l3M/WTscAr+CY
         gv7nUcBgVZu0gh2//IJYgVLzAfYw7/8AWFeklUXLt2Dyo5hAqnBYLgQKnVfMUM4CXtk9
         YrqA==
X-Gm-Message-State: AOAM5328+0vZ4k4F9FBtvOghYK39Q2PU4TQcOpilPbrxbdC78CYWMhjq
        0ldSFLGToublgStj428HFMLuREF2/LM=
X-Google-Smtp-Source: ABdhPJyAcOYM+ma89f/7STz6C6osgo7RXgBJbVLSfXACyLOAg1RQk0A1bMYVx84Ci3uuU1HO9wD3IA==
X-Received: by 2002:a17:90b:390f:: with SMTP id ob15mr13303718pjb.32.1636678127352;
        Thu, 11 Nov 2021 16:48:47 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 7sm3206442pgk.55.2021.11.11.16.48.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 16:48:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_request: Remove bg_scan_update work
Date:   Thu, 11 Nov 2021 16:48:44 -0800
Message-Id: <20211112004844.176271-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112004844.176271-1-luiz.dentz@gmail.com>
References: <20211112004844.176271-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This work is no longer necessary since all the code using it has been
converted to use hci_passive_scan/hci_passive_scan_sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   1 -
 net/bluetooth/hci_request.c      | 107 -------------------------------
 net/bluetooth/hci_request.h      |   5 --
 3 files changed, 113 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 70f2e16de18b..71dc02f1c4a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -494,7 +494,6 @@ struct hci_dev {
 	struct work_struct	tx_work;
 
 	struct work_struct	discov_update;
-	struct work_struct	bg_scan_update;
 	struct work_struct	scan_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 98bf425eaf1b..8b3205e4b23e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -368,82 +368,6 @@ static bool __hci_update_interleaved_scan(struct hci_dev *hdev)
 	return false;
 }
 
-/* This function controls the background scanning based on hdev->pend_le_conns
- * list. If there are pending LE connection we start the background scanning,
- * otherwise we stop it.
- *
- * This function requires the caller holds hdev->lock.
- */
-static void __hci_update_background_scan(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	if (!test_bit(HCI_UP, &hdev->flags) ||
-	    test_bit(HCI_INIT, &hdev->flags) ||
-	    hci_dev_test_flag(hdev, HCI_SETUP) ||
-	    hci_dev_test_flag(hdev, HCI_CONFIG) ||
-	    hci_dev_test_flag(hdev, HCI_AUTO_OFF) ||
-	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		return;
-
-	/* No point in doing scanning if LE support hasn't been enabled */
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return;
-
-	/* If discovery is active don't interfere with it */
-	if (hdev->discovery.state != DISCOVERY_STOPPED)
-		return;
-
-	/* Reset RSSI and UUID filters when starting background scanning
-	 * since these filters are meant for service discovery only.
-	 *
-	 * The Start Discovery and Start Service Discovery operations
-	 * ensure to set proper values for RSSI threshold and UUID
-	 * filter list. So it is safe to just reset them here.
-	 */
-	hci_discovery_filter_clear(hdev);
-
-	bt_dev_dbg(hdev, "ADV monitoring is %s",
-		   hci_is_adv_monitoring(hdev) ? "on" : "off");
-
-	if (list_empty(&hdev->pend_le_conns) &&
-	    list_empty(&hdev->pend_le_reports) &&
-	    !hci_is_adv_monitoring(hdev)) {
-		/* If there is no pending LE connections or devices
-		 * to be scanned for or no ADV monitors, we should stop the
-		 * background scanning.
-		 */
-
-		/* If controller is not scanning we are done. */
-		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			return;
-
-		hci_req_add_le_scan_disable(req, false);
-
-		bt_dev_dbg(hdev, "stopping background scanning");
-	} else {
-		/* If there is at least one pending LE connection, we should
-		 * keep the background scan running.
-		 */
-
-		/* If controller is connecting, we should not start scanning
-		 * since some controllers are not able to scan and connect at
-		 * the same time.
-		 */
-		if (hci_lookup_le_connect(hdev))
-			return;
-
-		/* If controller is currently scanning, we stop it to ensure we
-		 * don't miss any advertising (due to duplicates filter).
-		 */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(req, false);
-
-		hci_req_add_le_passive_scan(req);
-		bt_dev_dbg(hdev, "starting background scanning");
-	}
-}
-
 void __hci_req_update_name(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -2183,35 +2107,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	return 0;
 }
 
-static int update_bg_scan(struct hci_request *req, unsigned long opt)
-{
-	hci_dev_lock(req->hdev);
-	__hci_update_background_scan(req);
-	hci_dev_unlock(req->hdev);
-	return 0;
-}
-
-static void bg_scan_update(struct work_struct *work)
-{
-	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    bg_scan_update);
-	struct hci_conn *conn;
-	u8 status;
-	int err;
-
-	err = hci_req_sync(hdev, update_bg_scan, 0, HCI_CMD_TIMEOUT, &status);
-	if (!err)
-		return;
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-	if (conn)
-		hci_le_conn_failed(conn, status);
-
-	hci_dev_unlock(hdev);
-}
-
 static int le_scan_disable(struct hci_request *req, unsigned long opt)
 {
 	hci_req_add_le_scan_disable(req, false);
@@ -2798,7 +2693,6 @@ int __hci_req_hci_power_on(struct hci_dev *hdev)
 void hci_request_setup(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->discov_update, discov_update);
-	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
 	INIT_WORK(&hdev->scan_update, scan_update_work);
 	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
@@ -2812,7 +2706,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
 	hci_req_sync_cancel(hdev, ENODEV);
 
 	cancel_work_sync(&hdev->discov_update);
-	cancel_work_sync(&hdev->bg_scan_update);
 	cancel_work_sync(&hdev->scan_update);
 	cancel_delayed_work_sync(&hdev->discov_off);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index ba75c2da70f4..5f8e8846ec74 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -127,10 +127,5 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason);
 
-static inline void hci_update_background_scan(struct hci_dev *hdev)
-{
-	queue_work(hdev->req_workqueue, &hdev->bg_scan_update);
-}
-
 void hci_request_setup(struct hci_dev *hdev);
 void hci_request_cancel_all(struct hci_dev *hdev);
-- 
2.33.1

