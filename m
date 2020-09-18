Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF7C43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 03:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8242083B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 03:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="FWdnEbfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgIRDM5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgIRDMc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 23:12:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7DC061788
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 20:12:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d15so4130340ybk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yq3AQHq0oby0gIEHvauwatHEbFOs+SQiwBq1B7FgTKo=;
        b=FWdnEbfoGFaKXpZHbnLC++79ZWY3a7aRIGxG2mH67sZoVYWZUYC4LcK2SJ2r8mq1IJ
         VN2fUkJ7EQnVl0TGDlhk3EWmIVC8FNtBt131mk65HSsyaCqmFj2XZ3dx837bKYLSTtTp
         KtiAl342ruTWqRQ7YjBWAyaixJN58jS/f+4kUhS9myHZl3p8TUEXUSbz/sbUF+agMq4K
         AAnNYh38Oh55uQbs3TtQ8IPZ8BVtJXVDqpmGk4u/rYTKeSVCH75gVy+RagaTyIrGQjPV
         ZQEzNtygW+Md++DGU88mU1D+gYeda6um7diigCHcmmmMcm3ee2Ge+VsOqtQCdC+PnjvA
         d8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yq3AQHq0oby0gIEHvauwatHEbFOs+SQiwBq1B7FgTKo=;
        b=jZh7cMQQTDJRT9eHbrPtY4vR0ubX4cyxmO5UJ0gie0qxdyd80MgW6NC42xusfc+EUO
         Iy9M+Gnu6V1SzQAfQ7eFvgEVX6wf8T9bTF4oYuK8919jLeicgy35XNtOGfdvc2bWhL5a
         3jdWgfu5g/iGHsVObYQ2eMTzce39zsXOi9WCLnF+MHMoKjtSPvHccXjLitFcTNXPzvxA
         rcAknxErH7qw9779XIpfoBW6KVC+SejR1V8IL2qiMtkpgA/U94+eE6BVIxREduErJ5l6
         gAM8yR6Q59arCNy/FGxytrEwHuvV7HvsLsp/QOVoAKs9jpnRX5QPTM0ssqLPPTo4uujl
         L3eA==
X-Gm-Message-State: AOAM532RqhxZpQp1506mN+/cEHnqf24Nc61WfXeQKPpnn/IC0NY2q++A
        vntxUkXH/rPQwlmlW61fqYm5lckGfWeM8HXTXZ4Ifd0sxwQuvUd73ZHLQlYUWDhOPjC4wHMOIrh
        cjm5mNrxJ5HensMiIZVyy5mMTGNRb8o/GWPCUgjdWdOWe+XhTmAsi4Puq60PzErJmFRxC0ayUA2
        E8HPa1x0aq8Nc=
X-Google-Smtp-Source: ABdhPJxpXqOdPBoIYXkioBEuMajlBbzI5RIYR8yLeXTdm8sYgj7Z8KPEw60I7kFQuiavazH6jfQ/uumb1tiOo/5KnA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a5b:3d2:: with SMTP id
 t18mr42152587ybp.333.1600398751314; Thu, 17 Sep 2020 20:12:31 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:11:51 +0800
In-Reply-To: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200918111110.v3.4.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20200918111110.v3.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 4/6] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     howardchung@google.com, luiz.dentz@gmail.com, marcel@holtmann.org,
        mcchou@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds code to handle the system suspension during interleave
scan. The interleave scan will be canceled when the system is going to
sleep, and will be restarted after waking up.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 89443b48d90ce..d9082019b6386 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1081,6 +1081,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 		filter_policy |= 0x02;
 
 	if (hdev->suspended) {
+		/* Block suspend notifier on response */
+		set_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
+
 		window = hdev->le_scan_window_suspend;
 		interval = hdev->le_scan_int_suspend;
 	} else if (hci_is_le_conn_scanning(hdev)) {
@@ -1167,10 +1170,8 @@ static void hci_req_config_le_suspend_scan(struct hci_request *req)
 		hci_req_add_le_scan_disable(req, false);
 
 	/* Configure params and enable scanning */
-	hci_req_add_le_passive_scan(req);
+	__hci_update_background_scan(req);
 
-	/* Block suspend notifier on response */
-	set_bit(SUSPEND_SCAN_ENABLE, req->hdev->suspend_tasks);
 }
 
 static void cancel_adv_timeout(struct hci_dev *hdev)
@@ -1282,8 +1283,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
 
 		/* Disable LE passive scan if enabled */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
+			cancel_interleave_scan(hdev);
 			hci_req_add_le_scan_disable(&req, false);
+		}
 
 		/* Mark task needing completion */
 		set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
-- 
2.28.0.681.g6f77f65b4e-goog

