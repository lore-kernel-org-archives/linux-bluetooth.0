Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75254C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F45120768
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 12:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWgmwkiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgGWMfd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMfc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 08:35:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F81CC0619DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so2510939plk.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fOhhEhAN0IQXzOutjvj87FBSYs5c2PC/vUaHzKbtuME=;
        b=gWgmwkiqxjY1LBLcBYL63OpWnSKuddqA3k/VwMvNEB+C/c9azazT59YSRKKDi7zPVU
         8y0uGnp0nfPM7FZvSd7IkbNm6shcJKR2mU1cWP+iQfaeiQzOWTTNQ/iECb8+rs4n1w3N
         0KektuqbaBghuUvk6kWcAIMl8NV758FVLBYPamw8JPmV5P5cePilneoeBcWSxIArE+5q
         jQ68hikY7ruflElCNapElVM7+fjCQANj/hGQYuddrYuluk1LroCdq+rs7XGO7snoc3jp
         Y9eP6zkvwkxD1KHLr/Uq2fQec4xQ/Gfh/udXm0XueyObQ8p6G679ZI/mGZyOACG2K4r7
         Hzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fOhhEhAN0IQXzOutjvj87FBSYs5c2PC/vUaHzKbtuME=;
        b=aEl60jESOQsFxRG7SNuSizkrLYiaNCwNRwruNyaoyBKC9UlCX+slL9PJ3qubhZeX0u
         ptvWye/VjpT/yvZtOuZX9KODYYsl2lQO1q90s1mHBdW3lz/mjTMkknpuKEK99Jvt4oQw
         Wmzk0ZahZeTGEtl9iuPRflCq3hCTlLHfIHaXZESSG7pIVimgABTZL3LT+WHHvmrZ22Fj
         vAHI9EEi6GdZ8wmW412SKBUxImCM8V4X0Y2Sq4+9GFhNAdRTU1PAYIWG4q1Zgehm+Vda
         DG8LaNsfqf6EsuD06rb5kyVPqTz87R+wwYMWzkTBbQ/JbUDtn9zric/aBZ+jTadsgap8
         EwfQ==
X-Gm-Message-State: AOAM533C8JICkNnxTW0eW9sYL9ANtBcw7yWAdFbV1cY1Yrd0FzTfYrlT
        EoT17NoDSqL8Bouu43DpnHcbeFVMlA3AXA==
X-Google-Smtp-Source: ABdhPJzn/yQDMH5oi/Wjf5PzbLjwDMFoe+LtHBuhw2WGryi2iVsV72s3oHuRQ/GO1nzTvzkLFDVyOg==
X-Received: by 2002:a17:90a:e602:: with SMTP id j2mr200480pjy.200.1595507731910;
        Thu, 23 Jul 2020 05:35:31 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id z11sm2849823pfr.71.2020.07.23.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:35:31 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v5 6/8] Bluetooth: Enable/Disable address resolution during le create conn
Date:   Thu, 23 Jul 2020 18:09:01 +0530
Message-Id: <20200723123903.29337-6-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723123903.29337-1-sathish.narasimman@intel.com>
References: <20200723123903.29337-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In this patch if le_create_conn process is started restrict to
disable address resolution and same is disabled during
le_enh_connection_complete

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_conn.c    |  7 +++++-
 net/bluetooth/hci_event.c   |  4 ++++
 net/bluetooth/hci_request.c | 45 ++++++++++++++++++++++++++++---------
 net/bluetooth/hci_request.h |  3 ++-
 net/bluetooth/mgmt.c        |  2 +-
 5 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index be67361ff2f0..9832f8445d43 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1003,6 +1003,11 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	struct hci_request req;
 	int err;
 
+	/* This ensures that during disable le_scan address resolution
+	 * will not be disabled if it is followed by le_create_conn
+	 */
+	bool rpa_le_conn = true;
+
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		if (lmp_le_capable(hdev))
@@ -1103,7 +1108,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * state.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(&req, rpa_le_conn);
 		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6388fb55b4d2..628831b15c0a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5228,6 +5228,10 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->interval),
 			     le16_to_cpu(ev->latency),
 			     le16_to_cpu(ev->supervision_timeout));
+
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+		hci_req_disable_address_resolution(hdev);
 }
 
 static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index e48f0945a417..70e077cc7dfa 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -428,7 +428,7 @@ static void __hci_update_background_scan(struct hci_request *req)
 		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			return;
 
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 		BT_DBG("%s stopping background scanning", hdev->name);
 	} else {
@@ -447,7 +447,7 @@ static void __hci_update_background_scan(struct hci_request *req)
 		 * don't miss any advertising (due to duplicates filter).
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(req);
+			hci_req_add_le_scan_disable(req, false);
 
 		hci_req_add_le_passive_scan(req);
 
@@ -652,7 +652,7 @@ void __hci_req_update_eir(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
-void hci_req_add_le_scan_disable(struct hci_request *req)
+void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -676,8 +676,9 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 	}
 
+	/* Disable address resolution */
 	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
 		__u8 enable = 0x00;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
@@ -1072,7 +1073,7 @@ static void hci_req_config_le_suspend_scan(struct hci_request *req)
 {
 	/* Before changing params disable scan if enabled */
 	if (hci_dev_test_flag(req->hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 	/* Configure params and enable scanning */
 	hci_req_add_le_passive_scan(req);
@@ -1140,7 +1141,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 
 		/* Disable LE passive scan if enabled */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(&req);
+			hci_req_add_le_scan_disable(&req, false);
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
@@ -1696,6 +1697,28 @@ int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
 	return hci_req_run(&req, NULL);
 }
 
+static void enable_addr_resolution_complete(struct hci_dev *hdev, u8 status,
+					    u16 opcode)
+{
+	BT_DBG("%s status %u", hdev->name, status);
+}
+
+void hci_req_disable_address_resolution(struct hci_dev *hdev)
+{
+	struct hci_request req;
+	__u8 enable = 0x00;
+
+	if (!use_ll_privacy(hdev) &&
+	    !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+		return;
+
+	hci_req_init(&req, hdev);
+
+	hci_req_add(&req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
+
+	hci_req_run(&req, enable_addr_resolution_complete);
+}
+
 static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	BT_DBG("%s status %u", hdev->name, status);
@@ -2667,7 +2690,7 @@ static void bg_scan_update(struct work_struct *work)
 
 static int le_scan_disable(struct hci_request *req, unsigned long opt)
 {
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 	return 0;
 }
 
@@ -2770,7 +2793,7 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 		return 0;
 	}
 
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 
 	if (use_ext_scan(hdev)) {
 		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
@@ -2861,7 +2884,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * discovery scanning parameters.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
@@ -2976,14 +2999,14 @@ bool hci_req_stop_discovery(struct hci_request *req)
 
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 			cancel_delayed_work(&hdev->le_scan_disable);
-			hci_req_add_le_scan_disable(req);
+			hci_req_add_le_scan_disable(req, false);
 		}
 
 		ret = true;
 	} else {
 		/* Passive scanning */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-			hci_req_add_le_scan_disable(req);
+			hci_req_add_le_scan_disable(req, false);
 			ret = true;
 		}
 	}
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index bbe892ab078a..6a12e84c66c4 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -65,11 +65,12 @@ void __hci_req_write_fast_connectable(struct hci_request *req, bool enable);
 void __hci_req_update_name(struct hci_request *req);
 void __hci_req_update_eir(struct hci_request *req);
 
-void hci_req_add_le_scan_disable(struct hci_request *req);
+void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn);
 void hci_req_add_le_passive_scan(struct hci_request *req);
 
 void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next);
 
+void hci_req_disable_address_resolution(struct hci_dev *hdev);
 void hci_req_reenable_advertising(struct hci_dev *hdev);
 void __hci_req_enable_advertising(struct hci_request *req);
 void __hci_req_disable_advertising(struct hci_request *req);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f45105d2de77..47bcfe2fb14c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5226,7 +5226,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 
 		hci_req_init(&req, hdev);
 
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(&req, false);
 		hci_req_add_le_passive_scan(&req);
 
 		hci_req_run(&req, NULL);
-- 
2.17.1

