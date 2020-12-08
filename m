Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F1BC4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 00:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A2A23A1D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 00:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgLHAN6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgLHAN6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 19:13:58 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0074FC06179C
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 16:13:16 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t3so10525215pgi.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 16:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZPKJ8iyX4JiTuKS52IveePlvykbl+yKfx0dWwq1kK8=;
        b=lmsv5Gu9va9hMa7bt7nSxlp+wA8AgcilngVtUiJdSp58LhtJNevUH3Ef6fRHF6qQUD
         b48sd+v3vN4yKTbINTv4QVGxnf0dDzYTRGTaMOUPzqt6WJLnmAwT5WqnQl394pj+jCRb
         s9XL0FalTQHLIB/+xsUt2QR50a2TM+xUfX4Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZPKJ8iyX4JiTuKS52IveePlvykbl+yKfx0dWwq1kK8=;
        b=tFQE3f4TDEoGrOqYLFHnSCaTRE0Q08L1KkQEJPUb+KOh+aOfuK6R1lLaGBK/qofTQI
         KgARgcIW3XS1paxfKC04bK1kAMBPKzHwtlcuagQkrsEx/LcZwmqLpRerHfwGeiWrJ1af
         N8h47BAB8DRZTNcB2upe62mnx5yHtGNPOEuNwDYVSNOAva2O4BCcLz1lxhqUDfXgc0Gs
         ZYIXRkLW2Z8xGeyTX974Each8W8jU1Q3TIDDq6cfOXJL+iBlMHgHskFcxi2vWQgh1VEf
         WT2DJW9m3CKrJBMTd3QgVG85AxuoiCIy3nGlQT/R+bilSu3HBqkH2frII1ooDllm/N9l
         TaTw==
X-Gm-Message-State: AOAM531+kMXZs0z0rihq/Y3r7OdTyTi/9u7LTDEmMpGHZGELVJ3MhgUD
        y6mvW3EB8MorZ20R4UpwNiEJWA==
X-Google-Smtp-Source: ABdhPJzKxGhKehwPyGf5t01jU+bp7iiEJId5HG1oskHUVVXBkgWabjQT/SXwRWyy3sVtY8oJ+A8LDQ==
X-Received: by 2002:a17:90a:6a48:: with SMTP id d8mr1247629pjm.130.1607386396602;
        Mon, 07 Dec 2020 16:13:16 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id v8sm514214pjk.39.2020.12.07.16.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:13:16 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        netdev@vger.kernel.org, Howard Chung <howardchung@google.com>
Subject: [PATCH 1/1] Bluetooth: Remove hci_req_le_suspend_config
Date:   Mon,  7 Dec 2020 16:12:54 -0800
Message-Id: <20201207161221.1.I94feef9a75a69b0d0c7038d975239ef3b1b93ee6@changeid>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201208001254.575890-1-abhishekpandit@chromium.org>
References: <20201208001254.575890-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a missing SUSPEND_SCAN_ENABLE in passive scan, remove the separate
function for configuring le scan during suspend and update the request
complete function to clear both enable and disable tasks.

Fixes: dce0a4be8054 ("Bluetooth: Set missing suspend task bits")
Reviewed-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 net/bluetooth/hci_request.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 71bffd745472043..5aa7bd5030a218c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1087,6 +1087,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	if (hdev->suspended) {
 		window = hdev->le_scan_window_suspend;
 		interval = hdev->le_scan_int_suspend;
+
+		set_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
 	} else if (hci_is_le_conn_scanning(hdev)) {
 		window = hdev->le_scan_window_connect;
 		interval = hdev->le_scan_int_connect;
@@ -1170,19 +1172,6 @@ static void hci_req_set_event_filter(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-static void hci_req_config_le_suspend_scan(struct hci_request *req)
-{
-	/* Before changing params disable scan if enabled */
-	if (hci_dev_test_flag(req->hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req, false);
-
-	/* Configure params and enable scanning */
-	hci_req_add_le_passive_scan(req);
-
-	/* Block suspend notifier on response */
-	set_bit(SUSPEND_SCAN_ENABLE, req->hdev->suspend_tasks);
-}
-
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
@@ -1245,8 +1234,10 @@ static void suspend_req_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	bt_dev_dbg(hdev, "Request complete opcode=0x%x, status=0x%x", opcode,
 		   status);
-	if (test_and_clear_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks) ||
-	    test_and_clear_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks)) {
+	if (test_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks) ||
+	    test_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks)) {
+		clear_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
+		clear_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
 		wake_up(&hdev->suspend_wait_q);
 	}
 }
@@ -1336,7 +1327,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		/* Enable event filter for paired devices */
 		hci_req_set_event_filter(&req);
 		/* Enable passive scan at lower duty cycle */
-		hci_req_config_le_suspend_scan(&req);
+		__hci_update_background_scan(&req);
 		/* Pause scan changes again. */
 		hdev->scanning_paused = true;
 		hci_req_run(&req, suspend_req_complete);
@@ -1346,7 +1337,7 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 
 		hci_req_clear_event_filter(&req);
 		/* Reset passive/background scanning to normal */
-		hci_req_config_le_suspend_scan(&req);
+		__hci_update_background_scan(&req);
 
 		/* Unpause directed advertising */
 		hdev->advertising_paused = false;
-- 
2.29.2.576.ga3fc446d84-goog

