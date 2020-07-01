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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A395C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612202074D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twp2rHZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgGAKBh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKBg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:01:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749FFC061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:01:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so11479848pgc.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tofe5K0oXmYz1C+QMUjX7aijC98yv1W6QBb5sW/j1KE=;
        b=Twp2rHZ5iwjWizLno7mIZY8KPEPwttjiFcf2vnx4Nj4Gw6UH6yHG4vKuOIPwQ6dde4
         ll2dzkEDsW3Vl3KpcP8FK6R/WvOPgkmA5nx8JLNiGtxv8evU/PD35u2qNEvM9H8thNdj
         nvdy5YXyReu32zkZO0Iva4/SbWvvRkk90IDd2heOd0dZkJUa4IE82BeXjwqk+PVpOwmv
         rlrse0CHYldXXW3Vf4Lv5iGgYUQ6EWpW9lPTReAX60ErpuxwI4dgI5E17ZdpIk0+LR3C
         f7ZvxXXbpiOdwgTJoMwDSUytFwwGNMZEctoPFq/YlXqLMyc/ObDHrCw8JQLtUKWlp5UR
         u6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tofe5K0oXmYz1C+QMUjX7aijC98yv1W6QBb5sW/j1KE=;
        b=NN2ABA3cL6SBwVcBoeNh/c/CkjZ8ddf2WyZg8AcjPM2FWDkPGuX9xGshc37wE+FLLA
         OEZ8aPKODWF/FHwnhKyRqB8C9vpUEDMSs13sObw3xKiPB6SYluMdf2QANxoFqX70EZNi
         ok/aOSGKhMLcjI2cYOY9GkEQSuTHGCoxeU10LI5pzxWVZ7vKyPlMDqML9gcm7sGkS3RO
         Utq6kXR8xSLrJn7uyQA2OtCi137VZrG+KovMdddIj5nM681vkRHWYaCUb+StN5XdJdeb
         dvy+QWxkP39niARl93tuOs8jira+OP6aIcTRni4T2e7Ti1/C1VXgJuh6wPaZXVkBNiF5
         bopw==
X-Gm-Message-State: AOAM5302LFOOfY3StHLlbEkjU7uQrmuX9qe58tKT0f+EHRKlSudKDxKC
        Ba9q+3O4cLbyKM7QZdiRXtCAOIkjG1MGeA==
X-Google-Smtp-Source: ABdhPJxmBmgJhpRJEGupfI4CgEleUolgb6zw7Q2qQncK/TwtxLFicyJWMAFJszLrQ6EmmeGT1+y9cQ==
X-Received: by 2002:a62:195:: with SMTP id 143mr16252194pfb.226.1593597695503;
        Wed, 01 Jul 2020 03:01:35 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:01:35 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v3 8/8] Bluetooth: Add support to enable LL PRIVACY using set_privacy
Date:   Wed,  1 Jul 2020 15:34:32 +0530
Message-Id: <20200701100432.28038-9-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701100432.28038-1-sathish.narasimman@intel.com>
References: <20200701100432.28038-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Enable LL Privacy using mgmt set_privacy command. The privacy
value 0x03 is used here to enable LL Privacy.
Still to use LL Privacy controller support is must.

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   |  6 ++++--
 net/bluetooth/hci_request.c | 15 ++++++++++-----
 net/bluetooth/mgmt.c        |  6 +++++-
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4ff2fc4498f3..2a42c7ceabb2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -286,6 +286,7 @@ enum {
 	HCI_SC_ONLY,
 	HCI_PRIVACY,
 	HCI_LIMITED_PRIVACY,
+	HCI_ENABLE_LL_PRIVACY,
 	HCI_RPA_EXPIRED,
 	HCI_RPA_RESOLVING,
 	HCI_HS_ENABLED,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 47a4050462ed..589bac9859ce 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2301,7 +2301,8 @@ static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
 	 * converted back into either public address or random address type
 	 */
 	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
 		switch (own_address_type) {
 		case ADDR_LE_DEV_PUBLIC_RESOLVED:
 			own_address_type = ADDR_LE_DEV_PUBLIC;
@@ -5223,7 +5224,8 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
 			     le16_to_cpu(ev->supervision_timeout));
 
 	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
 		hci_req_disable_address_resolution(hdev);
 }
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 0dc587026753..e1c2e2c13456 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -678,7 +678,8 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
 
 	/* Disable address resolution */
 	if (use_ll_privacy(hdev) &&
-	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
+	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
 		__u8 enable = 0x00;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
@@ -696,7 +697,8 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
 		   cp.bdaddr_type);
 	hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
 
-	if (use_ll_privacy(req->hdev)) {
+	if (use_ll_privacy(req->hdev) &&
+	    hci_dev_test_flag(req->hdev, HCI_ENABLE_LL_PRIVACY)) {
 		struct smp_irk *irk;
 
 		irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
@@ -748,7 +750,8 @@ static int add_to_white_list(struct hci_request *req,
 		   cp.bdaddr_type);
 	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
 
-	if (use_ll_privacy(hdev)) {
+	if (use_ll_privacy(hdev) &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
 		struct smp_irk *irk;
 
 		irk = hci_find_irk_by_addr(hdev, &params->addr,
@@ -869,7 +872,8 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		return;
 	}
 
-	if (use_ll_privacy(hdev) && addr_resolv) {
+	if (use_ll_privacy(hdev) && addr_resolv &&
+	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
 		u8 enable = 0x01;
 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
 	}
@@ -2226,7 +2230,8 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		/* If Controller supports LL Privacy use own address type is
 		 * 0x03
 		 */
-		if (use_ll_privacy(hdev))
+		if (use_ll_privacy(hdev) &&
+		    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
 			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
 		else
 			*own_addr_type = ADDR_LE_DEV_RANDOM;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 65d93a38e5b3..c1106d97e3a9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5652,7 +5652,8 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
-	if (cp->privacy != 0x00 && cp->privacy != 0x01 && cp->privacy != 0x02)
+	if (cp->privacy != 0x00 && cp->privacy != 0x01 && cp->privacy != 0x02
+	    && cp->privacy != 0x03)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
 				       MGMT_STATUS_INVALID_PARAMS);
 
@@ -5674,6 +5675,8 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		hci_adv_instances_set_rpa_expired(hdev, true);
 		if (cp->privacy == 0x02)
 			hci_dev_set_flag(hdev, HCI_LIMITED_PRIVACY);
+		else if (cp->privacy == 0x03)
+			hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
 		else
 			hci_dev_clear_flag(hdev, HCI_LIMITED_PRIVACY);
 	} else {
@@ -5682,6 +5685,7 @@ static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 		hci_dev_clear_flag(hdev, HCI_RPA_EXPIRED);
 		hci_adv_instances_set_rpa_expired(hdev, false);
 		hci_dev_clear_flag(hdev, HCI_LIMITED_PRIVACY);
+		hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
 	}
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_PRIVACY, hdev);
-- 
2.17.1

