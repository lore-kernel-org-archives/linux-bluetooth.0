Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F286C433E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD24F20768
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1wM4Dfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgGWMfU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMfU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 08:35:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE89C0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so3030272pgc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VUqS07gPBeyv2W2P3TCEcoo0Bx0MtNnbq5B59KDRGS0=;
        b=Z1wM4DfvsvCcG6fWY8jGCPVJsVfd2JgZ+Tcw1MTcd1kYzfgVrWzNJUgjsV+jTYZ5nY
         Ky8UvuOTf6uCB+oKnM9UCGVWxDvrS6xZWLqMcLFn+0OSR/AH9iLcD8H5EEnPbffWPuGD
         2Ephum5uOS1pDfxZmSjeKS4K8KADNAWqT5hxPBK+AddN6mRVbSrgGAAqFx4T3VxYbh9D
         +twN9nxnfthtLSs4nYQNXCLZVHDSjU3T0o6TdNlsSlmcccEX6Te+SaA+zWT5TizlOZe2
         jhXw3bOFZxkTpy7kX/ktQjFB06wn19l9mYUNqOJtBHk7uyP93P7svUySWKSHoCTkLzl0
         zM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VUqS07gPBeyv2W2P3TCEcoo0Bx0MtNnbq5B59KDRGS0=;
        b=HezUaCw1ABVh+/X1ndHiN3Ljru/jeGf6IV+E2npTRpl4W33RWQIA20+C0QO/ZY6b8q
         W/hCoVm5HOQWkycKN2b+hjmvCaOzpqjetcw/718E4mKMjysqAAwcn/BxCvq1ryOi2W2C
         /Cq62/wcmKO9Unu6jWxyPEZyZPgjuJ+D/WkVwgGs6fUY0ewgdHZpgQ0yw3Gtb1SBLxF8
         n0EW2NtYKh4Xcf5NNWsao4z1wucPI5TzBOMj+2EvU+qQYcwcux3KDRNdy1p1ILoRWPrz
         xQ6BSr3Ha8ZssJSrJ9x4aH0DhG0W15LJ1xNRG5YxmDzrPp/uArNO1DbOiwa4Urs7Bn9A
         KRzg==
X-Gm-Message-State: AOAM532aK7nNQ713NnLkGpTVplNXRX7qSIBrwK7ic4Cy/hyDDdO9h/Me
        RBZ6JIMRB0hfXOSc9uiOE3WPaI8UKtrCZA==
X-Google-Smtp-Source: ABdhPJwsFiIvl6hBeNIO+87VkviFkdqsIAWzys49mPcqOUS48DMnGOEPw+PbZLYshfUdmbKo5XMe3Q==
X-Received: by 2002:a63:6ca:: with SMTP id 193mr4036706pgg.269.1595507719475;
        Thu, 23 Jul 2020 05:35:19 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id z11sm2849823pfr.71.2020.07.23.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:35:19 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v5 2/8] Bluetooth: Configure controller address resolution if available
Date:   Thu, 23 Jul 2020 18:08:57 +0530
Message-Id: <20200723123903.29337-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723123903.29337-1-sathish.narasimman@intel.com>
References: <20200723123903.29337-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

When the LL Privacy support is available, then as part of enabling or
disabling passive background scanning, it is required to set up the
controller based address resolution as well.

Since only passive background scanning is utilizing the whitelist, the
address resolution is now bound to the whitelist and passive background
scanning. All other resolution can be easily done by the host stack.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_request.c      | 26 +++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bee1b4778ccc..8caac20556b4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1359,6 +1359,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
 
+/* Use LL Privacy based address resolution if supported */
+#define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
 			   ((dev)->commands[37] & 0x40))
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 7c0c2fda04ad..7d0ba53ffed0 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -675,6 +675,12 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 		cp.enable = LE_SCAN_DISABLE;
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 	}
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+		__u8 enable = 0x00;
+		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+	}
 }
 
 static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
@@ -816,7 +822,8 @@ static bool scan_use_rpa(struct hci_dev *hdev)
 }
 
 static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
-			       u16 window, u8 own_addr_type, u8 filter_policy)
+			       u16 window, u8 own_addr_type, u8 filter_policy,
+			       bool addr_resolv)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -825,6 +832,11 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		return;
 	}
 
+	if (use_ll_privacy(hdev) && addr_resolv) {
+		u8 enable = 0x01;
+		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+	}
+
 	/* Use ext scanning if set ext scan param and ext scan enable is
 	 * supported
 	 */
@@ -898,12 +910,18 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 	}
 }
 
+/* Ensure to call hci_req_add_le_scan_disable() first to disable the
+ * controller based address resolution to be able to reconfigure
+ * resolving list.
+ */
 void hci_req_add_le_passive_scan(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
 	u8 filter_policy;
 	u16 window, interval;
+	/* Background scanning should run with address resolution */
+	bool addr_resolv = true;
 
 	if (hdev->scanning_paused) {
 		bt_dev_dbg(hdev, "Scanning is paused for suspend");
@@ -949,7 +967,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 
 	bt_dev_dbg(hdev, "LE passive scan with whitelist = %d", filter_policy);
 	hci_req_start_scan(req, LE_SCAN_PASSIVE, interval, window,
-			   own_addr_type, filter_policy);
+			   own_addr_type, filter_policy, addr_resolv);
 }
 
 static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
@@ -2789,6 +2807,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	u8 own_addr_type;
 	/* White list is not used for discovery */
 	u8 filter_policy = 0x00;
+	/* Discovery doesn't require controller address resolution */
+	bool addr_resolv = false;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2811,7 +2831,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 
 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval,
 			   hdev->le_scan_window_discovery, own_addr_type,
-			   filter_policy);
+			   filter_policy, addr_resolv);
 	return 0;
 }
 
-- 
2.17.1

