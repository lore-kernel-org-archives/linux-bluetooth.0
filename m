Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59DEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 01:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C5860F0F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 01:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhJFBLd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 21:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhJFBLc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 21:11:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1DC061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 18:09:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so1005408pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rx3d2c0kphzvb05A8Ead/k4LuBdJQpLK45fxj0cCwJ0=;
        b=qKICO+A5GIuhwV98iQimYR0juazyWQwnoFSHsloVylKbAPd2SEsQNKUW4TqUnNd80f
         6FQ0b9Gj2RoebkdhZd4wZbJPqJecQoIc5iT/mqe5rLJk54XsYcTud4jDUhtGjkhr6yWB
         0TnNmrOoXFQDl5v4tb6asXjyKm8XlyBuBUIcZoHarB9DyZ4s5lOhbOG3HsqsdLHEgOZV
         myxm04GBWZ0ZtOqpbW1p64Vdt9PmGnbx6NF2LUE/x00/eWEEkyZtUTCxfhFhNMcrQZPD
         mmIU0X7v+OSYqJyhf0YxQao0jno8NJuKTkrnn6QARNlJgI4vZfOU9oGuyumPugxCkkYV
         O7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx3d2c0kphzvb05A8Ead/k4LuBdJQpLK45fxj0cCwJ0=;
        b=ndBB98CEVMmVwvk1cidhRSy8kxg8yHvQjFTqcoMZsqbaqnWgLsRxNLlYMSDvkzLFED
         FvjNVZ1vNos5HjbtB5mTRJgqeg79pTH5ObQqcJFLhW0WKA4elykfjEURk8HsiNE8djBI
         qjOXWiGv+SBkyRJtoehjpbQf7/3mj56WkKafHSJEkcSEZ57z33cO7DzgIWdmCfqXhKx6
         VYOYyXYEoOFbznHWS5Cne058xnaL2DHUC30sA381KInqF0ZyhvsE6qoNJMepe3yWjBc5
         nmivkiqozEEPytI8jd4WrCwBUeJUsrOMhEcCWEBMzWOFLXEYd7QRons7UMmAR+m8pI00
         MNuQ==
X-Gm-Message-State: AOAM5331ms0had0NSAXt2qWuq8JOOs/ewzyGzFfZp3Nmkx8lH1+KIvw3
        XCj35wlv6E0koO9W2oK8gmGh05KycVk=
X-Google-Smtp-Source: ABdhPJypxOAUl2l1LkjZ0QS3cCzsd7gTjI8+iWpFFasHGDK27A8lxIBH/wn/h9cg4Ca4rJSnJN0yWA==
X-Received: by 2002:a17:902:7e4b:b0:13d:b90d:cdc1 with SMTP id a11-20020a1709027e4b00b0013db90dcdc1mr8386658pln.72.1633482580740;
        Tue, 05 Oct 2021 18:09:40 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id nr14sm3158988pjb.24.2021.10.05.18.09.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:09:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix wake up suspend_wait_q prematurely
Date:   Tue,  5 Oct 2021 18:09:35 -0700
Message-Id: <20211006010935.902645-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006010935.902645-1-luiz.dentz@gmail.com>
References: <20211006010935.902645-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

suspend_req_complete shall only attempt to wake up if there no tasks
left otherwise the WAKE_COND will evaluate to false causing a premature
timeout when in fact the tasks are still in progress.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_request.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 92611bfc0b9e..209f4fe17237 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1092,17 +1092,24 @@ static void suspend_req_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	bt_dev_dbg(hdev, "Request complete opcode=0x%x, status=0x%x", opcode,
 		   status);
-	if (test_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks) ||
-	    test_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks)) {
-		clear_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
-		clear_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
+
+	if (status) {
 		wake_up(&hdev->suspend_wait_q);
+		return;
 	}
 
-	if (test_bit(SUSPEND_SET_ADV_FILTER, hdev->suspend_tasks)) {
-		clear_bit(SUSPEND_SET_ADV_FILTER, hdev->suspend_tasks);
+	/* Clear all tasks that could be initiated using suspend_req_complete as
+	 * callback.
+	 */
+	clear_bit(SUSPEND_PAUSE_DISCOVERY, hdev->suspend_tasks);
+	clear_bit(SUSPEND_PAUSE_ADVERTISING, hdev->suspend_tasks);
+	clear_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
+	clear_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
+	clear_bit(SUSPEND_SET_ADV_FILTER, hdev->suspend_tasks);
+
+	/* Wake up only if there are no tasks left */
+	if (!hdev->suspend_tasks)
 		wake_up(&hdev->suspend_wait_q);
-	}
 }
 
 static void hci_req_prepare_adv_monitor_suspend(struct hci_request *req,
-- 
2.31.1

