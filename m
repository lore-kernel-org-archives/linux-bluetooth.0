Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F4CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5CD2074D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdiqcRc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgGAKBL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKBK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:10 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D7AC061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:01:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bf7so395861plb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yhFm8iVS8rF216LAKKaefGhuvOqn0g+HGfEb++sXEKQ=;
        b=hdiqcRc63sJZg87JBlBrYqCN/EuvRLRr0Q4xTHYcPEY9fft8NYzC2mYjSkPb0Qckuo
         Y0JTvEVd8gCB/G5u2kjcb2UuGtX1RIt6wKbw4JsPlFUig1okeouA/Xeo21DMwZrqg48C
         dh104Na4SW6oTFpa+TbntOVTraqSRcpvtGQ8TF/ffnA9qYg2wN+gpHo9U6D0UV4KnWk9
         USuRhIWhUewFnDewVPLfnjEOe5s+tWWl1kjel0RDZrViNkR0ib6toF/9/qCZGUNWdSAX
         akfIJcyu4KqDEgRA4kYBuEmpXXGrUPL6YrIZ8NfPvkbQWNc0rk08bgqrXM+JcWq5Jy8G
         dg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yhFm8iVS8rF216LAKKaefGhuvOqn0g+HGfEb++sXEKQ=;
        b=pC++NKP8GJ+iDGTLawS5aq4t3Ze7NW+/mOqX9qJK5zqk4cbi2w82UZnIlJIW7pmJ3g
         gJGezxI50bYIMiqEGGqy+W0gqWvl45zbf4dRDwi1MxYNTR/DX/4PF3inMeL0BfUkXNTl
         6MiBJw8csA91zObaU0VQXpvRcnLQjlQNbtvUqJ0FNOFhGXkd6vmTSYQjfFgAw76DDK60
         wS0kwKuIte5+OsTQDtkcqxv7Z+q4aIMqI635ZIwLzPusFdshKsGdhNpwln4CKCjaf3yT
         WO1POidvXh/GCEqgfwjnn85o9i0so7d35kiPxft0g5XLkRnhwVZt6A7enSkib91vp677
         fRfg==
X-Gm-Message-State: AOAM53027R8/PEELBJj/UJiBK9ujHlpW+l8TV2Atl7cN6U2/59PCjjbs
        +d0OuHczDsCs/cTgDiO6s5OLSm2zHQYvCw==
X-Google-Smtp-Source: ABdhPJz7pjDPMPwQk2aqCNZQcc80MO49nb4IBfUbOY0va6SS7YJlExR/vVF6IWntveQ/hYHOadll0w==
X-Received: by 2002:a17:902:7204:: with SMTP id ba4mr20563799plb.250.1593597669730;
        Wed, 01 Jul 2020 03:01:09 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:01:09 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Subject: [PATCH v2 2/8] Bluetooth: Configure controller address resolution if available
Date:   Wed,  1 Jul 2020 15:34:26 +0530
Message-Id: <20200701100432.28038-3-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701100432.28038-1-sathish.narasimman@intel.com>
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
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
index 836dc997ff94..915f7a48bfaa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1358,6 +1358,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
 
+/* Use LL Privacy based address resolution if supported */
+#define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
+
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
 			   ((dev)->commands[37] & 0x40))
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 116207009dde..5978f9177b3d 100644
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
@@ -815,7 +821,8 @@ static bool scan_use_rpa(struct hci_dev *hdev)
 }
 
 static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
-			       u16 window, u8 own_addr_type, u8 filter_policy)
+			       u16 window, u8 own_addr_type, u8 filter_policy,
+			       bool addr_resolv)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -824,6 +831,11 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
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
@@ -897,12 +909,18 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
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
@@ -948,7 +966,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 
 	bt_dev_dbg(hdev, "LE passive scan with whitelist = %d", filter_policy);
 	hci_req_start_scan(req, LE_SCAN_PASSIVE, interval, window,
-			   own_addr_type, filter_policy);
+			   own_addr_type, filter_policy, addr_resolv);
 }
 
 static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
@@ -2747,6 +2765,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	u8 own_addr_type;
 	/* White list is not used for discovery */
 	u8 filter_policy = 0x00;
+	/* Discovery doesn't require controller address resolution */
+	bool addr_resolv = false;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2768,7 +2788,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 		own_addr_type = ADDR_LE_DEV_PUBLIC;
 
 	hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
-			   own_addr_type, filter_policy);
+			   own_addr_type, filter_policy, addr_resolv);
 	return 0;
 }
 
-- 
2.17.1

