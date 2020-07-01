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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E7CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B96220747
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbYLHpQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgGAKBY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKBY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE90C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:01:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so3147050plk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zJ2QpfO712U6ML1rl/3l7HQWUfo4RwY2Ra3Gjw2SIQM=;
        b=UbYLHpQGvfzsHOhj+sqEBJEbV4AEfMdA4TwWbBSk5G6f0mm5nOizgFIVG35TTlAyfq
         sQeXIku/xq+pKltA59QBbMqxWXWS1zwymqbZCjCYheHEgTD+dv632g7wy5zK6t6UsaVt
         vEy4rE1hcpPooQ5ORc8X0ALXfJhhYOTaYQ9m+xDFf5Tx0x9y0Oyb7OB+7sG2j1r3CO1B
         /MHwYkup9EZL3fAbqRFWUu1Uwehoc/5sa+DPfqqq21jyWruwYO+osdANblmI3qyVIiRc
         Jlr2kstV16LlC1VWpa1tNMZimoqjCIeaa9IDyrf3Sq4t60dTwE2WnB25OoCJJAzD6WLB
         WcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zJ2QpfO712U6ML1rl/3l7HQWUfo4RwY2Ra3Gjw2SIQM=;
        b=kHEej3PKPBPCDpEz3Bc41ectxugF4B2OJ9rQaVpowXf3JgE2jx+L0YoMnWPqPzB3Uw
         Fn68q3he3JDRFCVGrvt316FgNSpu7zR1uqvV4t/gKNCTRx23uGpo3gkJNpyw4Mv/VYn0
         MINtXxGMr6+djaGInUMLW0sLgbV3N7hlC5vRHAV1je2H53fMHljFeW+Zkxvv1hHkIGaq
         bSgyAwMKaapkfRKcpIzUbP+d+Rsv3XicwGRZXvls/sOycdAbAqroIZ3/DnfcmJWBYJBa
         uCLGMTbFeZzngUOusmFCCu9ilZNaJvck7BcMrtcyNwd8JK6QNGZXZpycdSj6RhMRFTCB
         Y0pw==
X-Gm-Message-State: AOAM533xopQlzuQx37O+QN6mFYw0Jlc6Kptt9HUuJ0jiRMTwXa3LR/9f
        iCX6adWxpk2yCMMQ+j6DKzD+jWV/KuT1rA==
X-Google-Smtp-Source: ABdhPJzVYm5C1xkGzoWc/dD359XYRJgvAXQ7ihhg9fERom3YSneeWtglAgZsr80eGiSM9o2mQMbLWg==
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11mr14305418plv.150.1593597682865;
        Wed, 01 Jul 2020 03:01:22 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:01:22 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v3 6/8] Bluetooth: Enable/Disable address resolution during le create conn
Date:   Wed,  1 Jul 2020 15:34:30 +0530
Message-Id: <20200701100432.28038-7-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701100432.28038-1-sathish.narasimman@intel.com>
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
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
index 8805d68e65f2..8d762567ea16 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1003,6 +1003,11 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	struct hci_request req;
 	int err;
 
+	/* This ensures that during disable le_scan address resolution
+	* will not be disabled if it is followed by le_create_conn
+	*/
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
index 592ef5dda3ab..47a4050462ed 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5221,6 +5221,10 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
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
index 906721759c2f..0dc587026753 100644
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
@@ -1071,7 +1072,7 @@ static void hci_req_config_le_suspend_scan(struct hci_request *req)
 {
 	/* Before changing params disable scan if enabled */
 	if (hci_dev_test_flag(req->hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 	/* Configure params and enable scanning */
 	hci_req_add_le_passive_scan(req);
@@ -1139,7 +1140,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 
 		/* Disable LE passive scan if enabled */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(&req);
+			hci_req_add_le_scan_disable(&req, false);
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
@@ -1700,6 +1701,28 @@ int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
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
@@ -2625,7 +2648,7 @@ static void bg_scan_update(struct work_struct *work)
 
 static int le_scan_disable(struct hci_request *req, unsigned long opt)
 {
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 	return 0;
 }
 
@@ -2728,7 +2751,7 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 		return 0;
 	}
 
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 
 	if (use_ext_scan(hdev)) {
 		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
@@ -2819,7 +2842,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * discovery scanning parameters.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
@@ -2933,14 +2956,14 @@ bool hci_req_stop_discovery(struct hci_request *req)
 
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
index 0e81614d235e..12bea10e7d70 100644
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
index 5e9b9728eeac..65d93a38e5b3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5205,7 +5205,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 
 		hci_req_init(&req, hdev);
 
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(&req, false);
 		hci_req_add_le_passive_scan(&req);
 
 		hci_req_run(&req, NULL);
-- 
2.17.1

