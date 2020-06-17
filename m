Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6969420679
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h8gh68mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgFQEAn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQEAi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 00:00:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C84C0613ED
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 21:00:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z63so490668pfb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 21:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12CQMLW8zmSrgKFzSh+r0y7cKk1f3YOfpNSAMUhjbUc=;
        b=h8gh68mOHQHIj7mWB8bgLKRYk19xCBCgRI1kAoxM/LiqF74H19cbrjx+2QiPwKTHjY
         Zgfu8Y2FQVoO8teD3IEyNJRw3pSjlBwnSQ8tK5qrebKzRfgf6f/n8vm2MdgrGZMPll40
         SJ7WJJpT9iQK/ZkwAxI4bI8Y+YI+gZMNiEO2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12CQMLW8zmSrgKFzSh+r0y7cKk1f3YOfpNSAMUhjbUc=;
        b=LVJzW3q8XiOAIqGpBeSrFwFAK7kjVEkbUS390Y9gHNXgx4NGN3G4ouPxY1fJYOvRfg
         kLboBTUHsEtH2UBAvXr/3sp1ki7Edj5VZiQaII/tUPcdrToIqqNGcJWB6Neyw1HwGA0D
         pbr/Nlf7vdpLlvZhWP5pWJP+qxCmJCNQjQHe8/nslk9HQLHBQFv3lwgJmlujZQsPHnd1
         wopG/BuQfUUBbcZ2YAA6F+N9oq/uO+uDvtftQZRdXYC/dP1fNLeTTDqpoh3V+eAyhxpB
         Ky1NIFpgz95HEOhuoBdQaah7Ds5ojA5g0b5Da+LJvrNc+pdHV4/OklYJ2RuKnXsQkt+y
         28Kg==
X-Gm-Message-State: AOAM533LkMR/F2kejbVee8BIiVOcCeqtKYyh4DDm0tGCapXHe9Cwa9jl
        HTEkScPPjttFr1bwFwe27VtuTM9xTTA=
X-Google-Smtp-Source: ABdhPJyoKl99XxndMfj2zS2cjb84ilSQJswh72daWSynJYcRGmPoOb9p9VIUaP+6GQoMl15OzWu7vQ==
X-Received: by 2002:a62:6286:: with SMTP id w128mr4815132pfb.117.1592366437515;
        Tue, 16 Jun 2020 21:00:37 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id q1sm20013089pfk.132.2020.06.16.21.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 21:00:37 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/4] Bluetooth: Replace wakeable list with flag
Date:   Tue, 16 Jun 2020 21:00:20 -0700
Message-Id: <20200616210008.2.I577641918ec743663538eab7aa73c719daacb90d@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200617040022.174448-1-abhishekpandit@chromium.org>
References: <20200617040022.174448-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Since the classic device list now supports flags, convert the wakeable
list into a flag on the existing device list.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci_core.h | 11 ++++++++++-
 net/bluetooth/hci_core.c         |  1 -
 net/bluetooth/hci_request.c      | 12 ++++++++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 95a3935325bbbc..0643c737ba8528 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -143,6 +143,16 @@ struct bdaddr_list_with_flags {
 	u32 current_flags;
 };
 
+enum hci_conn_flags {
+	HCI_CONN_FLAG_REMOTE_WAKEUP,
+	HCI_CONN_FLAG_MAX
+};
+
+#define hci_conn_test_flag(nr, flags) ((flags) & (1U << nr))
+
+/* Make sure number of flags doesn't exceed sizeof(current_flags) */
+static_assert(HCI_CONN_FLAG_MAX < 32);
+
 struct bt_uuid {
 	struct list_head list;
 	u8 uuid[16];
@@ -463,7 +473,6 @@ struct hci_dev {
 	struct list_head	mgmt_pending;
 	struct list_head	blacklist;
 	struct list_head	whitelist;
-	struct list_head	wakeable;
 	struct list_head	uuids;
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a471bec2731ed..8e01afb2ee8c5c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3499,7 +3499,6 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->blacklist);
 	INIT_LIST_HEAD(&hdev->whitelist);
-	INIT_LIST_HEAD(&hdev->wakeable);
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index a7f572ad38ef08..a5b53d3ea50802 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -968,15 +968,19 @@ static void hci_req_clear_event_filter(struct hci_request *req)
 
 static void hci_req_set_event_filter(struct hci_request *req)
 {
-	struct bdaddr_list *b;
+	struct bdaddr_list_with_flags *b;
 	struct hci_cp_set_event_filter f;
 	struct hci_dev *hdev = req->hdev;
-	u8 scan;
+	u8 scan = SCAN_DISABLED;
 
 	/* Always clear event filter when starting */
 	hci_req_clear_event_filter(req);
 
-	list_for_each_entry(b, &hdev->wakeable, list) {
+	list_for_each_entry(b, &hdev->whitelist, list) {
+		if (!hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
+					b->current_flags))
+			continue;
+
 		memset(&f, 0, sizeof(f));
 		bacpy(&f.addr_conn_flt.bdaddr, &b->bdaddr);
 		f.flt_type = HCI_FLT_CONN_SETUP;
@@ -985,9 +989,9 @@ static void hci_req_set_event_filter(struct hci_request *req)
 
 		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
 		hci_req_add(req, HCI_OP_SET_EVENT_FLT, sizeof(f), &f);
+		scan = SCAN_PAGE;
 	}
 
-	scan = !list_empty(&hdev->wakeable) ? SCAN_PAGE : SCAN_DISABLED;
 	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-- 
2.27.0.290.gba653c62da-goog

