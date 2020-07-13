Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2C9C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1ED2075F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCwdJeFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgGMGSv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGSu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:18:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D679EC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so5723971pjq.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gqesOFNLs3tg0XsWgFXS5D1nTeu/tqmZApdWPI1nKEU=;
        b=lCwdJeFOT+uC+zUVyZkAeAZ2Zo65yBgVERNGPrmBib9Fu1ugNCOmzpv4uKQ9kPz9BH
         9EFd2MBuMzCnv3Sm/J8/uVHvyZpOQ8Rhtm1MBXJ0QWjjen/75r2nCHli2jsslABeRBHI
         3EiFfr2pSfRhevZjmHd0Jooa5/bHIRU8BKKf8eZcjczrp0qOy9yiogcyw+vy5UAQOsuj
         sXXcB9/gz1EKwJQa/tHY/1dGnT8r7W9xWdDc0TQqDZH92V8CekJW2HFqsy7L6qL6SXFs
         9WpZq0H2/K1BO80nkBYUKJ3IVHT6BJtdo5NM5wl/RO/3RUmRm3LaMsaDi+LzNjWd1E6R
         fMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gqesOFNLs3tg0XsWgFXS5D1nTeu/tqmZApdWPI1nKEU=;
        b=Wy7HPEW4Qb3oIvQ8rg6jIJaEokRFlEbSWw6hVT/fK8c6uM5gTbsb43yOIkYQRSFREq
         8agQdxoDVhcRXZ9q4BuzsxwN6JIvP+Zo9gD6NxRIWSS3tB0zhVvJGzQWO0mexlCl67XU
         osuctGWqi94MLuTuSKCtWKFNByP2Pw4Tab08305Uf5OlV65X7Wv/oaSFiF5Azs/ESZ8T
         VQ487nnEIGOmysM9dAap9clwBGkGjt1K4D3296hedFU/lrMmaA/i4T6hXh2zzCz2+QJg
         n8K0Y4XpvZCFwEoe5EgK97qyzp0xbdPEMJfQPvBcM4EgxJwexuw+DrmqVZABpxzh/gkP
         Sm0Q==
X-Gm-Message-State: AOAM531AVDaxSgApRRQiaPyTzbMwe1OtY0lTX4AIyYXEg8Ys0vZw5Qjj
        hGRS6KiaTqNHWspJ33hg9Pjl6wYQ3zj7IQ==
X-Google-Smtp-Source: ABdhPJyapFmIKfe7aiayLpP33iR52qoGqLpIPyu3zAlAIwW6aB1PpWbC8QTH2Yhs1iMgnt4S1yf8Bw==
X-Received: by 2002:a17:90b:1650:: with SMTP id il16mr17833277pjb.79.1594621130040;
        Sun, 12 Jul 2020 23:18:50 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 204sm13096371pfx.3.2020.07.12.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:18:49 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 6/8] Bluetooth: Enable/Disable address resolution during le create conn
Date:   Mon, 13 Jul 2020 11:52:11 +0530
Message-Id: <20200713062213.3692-7-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713062213.3692-1-sathish.narasimman@intel.com>
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
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
index 8805d68e65f2..caf1598758bf 100644
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
index eae5bd4a53ac..684c68cb5c76 100644
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
index e16d5154b2cf..c3193f7f9ff0 100644
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
@@ -1701,6 +1702,28 @@ int hci_req_update_adv_data(struct hci_dev *hdev, u8 instance)
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
@@ -2626,7 +2649,7 @@ static void bg_scan_update(struct work_struct *work)
 
 static int le_scan_disable(struct hci_request *req, unsigned long opt)
 {
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 	return 0;
 }
 
@@ -2729,7 +2752,7 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 		return 0;
 	}
 
-	hci_req_add_le_scan_disable(req);
+	hci_req_add_le_scan_disable(req, false);
 
 	if (use_ext_scan(hdev)) {
 		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
@@ -2820,7 +2843,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * discovery scanning parameters.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
+		hci_req_add_le_scan_disable(req, false);
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
@@ -2935,14 +2958,14 @@ bool hci_req_stop_discovery(struct hci_request *req)
 
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
index 686ef4792831..c292d5de4dc3 100644
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

