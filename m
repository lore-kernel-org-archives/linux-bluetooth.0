Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DC2C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D072083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="msz2NcBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIQIs4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgIQIrf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1682DC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s204so956872pfs.18
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FNIQ4TwzUmm1KHmokSEwCEB+0kpJ2JKM9cy2f0sja/s=;
        b=msz2NcBEHBn4//yvvlA9BvhRf9AbMQ4vFBBmV31mMDu/xsybwVA8JKpGL8YwGWRTkK
         C9dMyGQvzuutz7TlFpLoA/NBVj2arKtETcrRIRgihU50mn/CbHx1GuXnNSXeQZToOvKr
         YfRth3WHQ5gRXi3M9OmExnLIummqxyxMu0WVTQtHleO6IvGYoT/6KrbRB23ajEqNSYlt
         uwvdVtyB7wgxutDSPNaNMOR1uZ9qjBusTRqcHREfQEbW9EdmF75ccCe/O0rTbmVKNA+L
         yyMcvXj3zUc1QNX3ERlxjWJfytcDFCAJAYvEwPhE7O8YXBuY/PGfqTB10LGtUyzhK/r0
         aTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FNIQ4TwzUmm1KHmokSEwCEB+0kpJ2JKM9cy2f0sja/s=;
        b=CHZ1QYQdlN7RP1c4Wm+Cx1Am5iZT2bc8QWjv/yRL+ZVQPhVZ82tzOoZNfMU54BKdHE
         fS97S+QEM5oXQ8QNIK8h1XEWdYUokHKHB8VL4HgFZFWe5VTG5zxLOhdDWqCPyGVp6Uaz
         Zs1xk1+ejGa8Pd5zt6Uq0G8tjpXf5G9+bA75O8oqY3/6h+1DJ3kxjjRw4ZZSnn/5cqr3
         +k9Zcrdfwm6fE38VkScdsFDTmjMkvkgENmlekwBVFbhzsz0ECDbcNTt9m8TbuGw1miur
         EPGK6hOjHUBCbZCUUAAeqeTh1FJD2QdGHZYBeDI0NFIGs55B1F4Pqn9+CHobvQsd4fnt
         oKYw==
X-Gm-Message-State: AOAM53091YL0FhIb4ajGTjCKIpNCf+5Q4VQi+Kh0grXlywTFJY1mSzyy
        8pNd+c/o9ZdT8d9/gi0vgwKWJYKYmZSb0IUzyElI+Iy+hkqDF+UbyWN1qt4kuTeOMY3I9RFKO/q
        aa04eUWyFdITAskV5GZEscAcjfpPIW70+vcwuW+mMhYuZ0p+5/bchVQVDrCEtopGdxbkCcY6KRP
        if7o0rrO+QpYY=
X-Google-Smtp-Source: ABdhPJyZ5zr8aCmSNqrsGqhZ7eOqE5l90QCLj+GHKNbZg3/YWweber23RTxxs6jdmYjWgzSEI1Z9EfXTAg39J3fMNw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:90b:941:: with SMTP id
 dw1mr715085pjb.1.1600332452758; Thu, 17 Sep 2020 01:47:32 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:13 +0800
In-Reply-To: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917164632.BlueZ.v2.4.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 4/6] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@chromium.org,
        mcchou@chromium.org, howardchung@google.com, alainm@chromium.org,
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
2.28.0.618.gf4bc123cb7-goog

