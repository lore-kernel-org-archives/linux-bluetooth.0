Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DC220674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxq6Vw7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgFCROb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCROb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:14:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E27C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:14:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 64so2016552pfg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bpSheGMCVgME0idzklrJ0le5PrZYkTpunntgt2JqXb8=;
        b=Cxq6Vw7mx18O6nNaFVmMnAxUq4MlVQtx/fS6enoGId8/Rs0rjM4G4Gvv2AJS9KHxwm
         9A6theXZl0V9hHLoHxkEKczZaSGRuv6vrXajdU6/YMvKAaC6NU2qRNtroF2u8FG/1H3R
         oIoay75lce/T5cFcoGAy9SrinbuqQnCytXavWDdxjzNCxe/KRtchecfkdVLl/bUypyOm
         6Z2pEUN3QszFGoTYVSWJ3nR1QE4SN3AuyejIKYDHYHAX4nVBhKbWq+m+d2Yb7Ewe1x72
         DJS5S+cqLOxfMnslPB+aYn4tqxMiWyeDNw8LQJ5oN/RePfkg12CGWBywnVIc835R2fRE
         TBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bpSheGMCVgME0idzklrJ0le5PrZYkTpunntgt2JqXb8=;
        b=IeYaMhgV7qPfEt/q7nK6n6zDJufaykbFwb2u8ROFM4Y5dSfB5lXQEmvjeF3LaKZ+Nh
         P3Kf5giWuw3tm6pvPkTJUxH1Ifu+yhx7DtUXwcUBrZl/f68P/tbc/nYh3TDUy7U7ymqn
         Ln1X5VPZWO6OPbaXBNjHKqsZ7E1dF7ZPws+mg/1HAnvaeyXZqDZEckmGXOHfi4Z0u1/a
         55scflrHZVKNmyszL/2yqD5lW18MVbGAWNkksKD248Q/126OinEi3eDKskpRyIHYkrC9
         T1o8/BI/LibK0DL6vHPzlSIFDM3VTkvOUyBO2TU7RD94ncE3lSy/PfHwTgAdWlWjh0XA
         KKVA==
X-Gm-Message-State: AOAM531AEXb6C08crWTvkl/lZJWoznJCN2W9Dsay2nJrfAIGsuj2f0EH
        vjJpIZAD0/OhJcMfAAt2boaHzwfLlkk=
X-Google-Smtp-Source: ABdhPJwA+wtH6no0KEQUxfKDXEHbsmEBf/sJNtPt6z+Th8d59dt4DEGHQwtE77oZMWKBC6U70PwoTg==
X-Received: by 2002:a17:90b:792:: with SMTP id l18mr914031pjz.24.1591204470274;
        Wed, 03 Jun 2020 10:14:30 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id x190sm2016770pgb.79.2020.06.03.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:14:29 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 6/7] Bluetooth: Enable/Disable address resolution during le create conn
Date:   Wed,  3 Jun 2020 22:47:12 +0530
Message-Id: <20200603171713.9882-7-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In this patch if le_create_conn process is started restrict to
disable address resolution and same is disabled during
le_enh_connection_complete

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_conn.c    |  6 ++++-
 net/bluetooth/hci_event.c   |  4 ++++
 net/bluetooth/hci_request.c | 46 ++++++++++++++++++++++++++++---------
 net/bluetooth/hci_request.h |  3 ++-
 net/bluetooth/mgmt.c        |  2 +-
 5 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 307800fd18e6..bbd6d06bc900 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1008,6 +1008,10 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	struct smp_irk *irk;
 	struct hci_request req;
 	int err;
+	/* This ensures that during disable le_scan address resolution
+	 * will not be disabled if it is followed by le_create_conn
+	 */
+	bool rpa_le_conn = true;
 
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
@@ -1109,7 +1113,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * state.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(&req, rpa_le_conn);
 		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9c9c434844f2..1866de712bb2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5225,6 +5225,10 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
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
index 6e1036cc8b1e..8552a37976ec 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -429,7 +429,7 @@ static void __hci_update_background_scan(struct hci_request *req)
 		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 			return;
 
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 		BT_DBG("%s stopping background scanning", hdev->name);
 	} else {
@@ -448,7 +448,7 @@ static void __hci_update_background_scan(struct hci_request *req)
 		 * don't miss any advertising (due to duplicates filter).
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(req);
+			hci_req_add_le_scan_disable(req, false);
 
 		hci_req_add_le_passive_scan(req);
 
@@ -653,7 +653,7 @@ void __hci_req_update_eir(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
-void hci_req_add_le_scan_disable(struct hci_request *req)
+void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 {
 	struct hci_dev *hdev = req->hdev;
 
@@ -677,8 +677,9 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 	}
 
+	/* Disable address resolution */
 	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
 		__u8 enable = 0x00;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
@@ -1054,7 +1055,7 @@ static void hci_req_set_event_filter(struct hci_request *req)
 static void hci_req_config_le_suspend_scan(struct hci_request *req)
 {
 	/* Can't change params without disabling first */
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 
 	/* Configure params and enable scanning */
 	hci_req_add_le_passive_scan(req);
@@ -1121,7 +1122,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
 
 		/* Disable LE passive scan */
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(&req, false);
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
@@ -1682,6 +1683,29 @@ int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
 	return hci_req_run(&req, NULL);
 }
 
+
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
@@ -2608,7 +2632,7 @@ static void bg_scan_update(struct work_struct *work)
 
 static int le_scan_disable(struct hci_request *req, unsigned long opt)
 {
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 	return 0;
 }
 
@@ -2706,7 +2730,7 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
 		return 0;
 
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 
 	if (use_ext_scan(hdev)) {
 		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
@@ -2797,7 +2821,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * discovery scanning parameters.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
@@ -2911,14 +2935,14 @@ bool hci_req_stop_discovery(struct hci_request *req)
 
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
index 9e8a3cccc6ca..97eb4f3a160b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4848,7 +4848,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 
 		hci_req_init(&req, hdev);
 
-		hci_req_add_le_scan_disable(&req);
+		hci_req_add_le_scan_disable(&req, false);
 		hci_req_add_le_passive_scan(&req);
 
 		hci_req_run(&req, NULL);
-- 
2.17.1

