Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F3C55179
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4472D20725
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sO+NFzSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgJ3JJX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgJ3JIm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 05:08:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A02C0613D4
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:08:42 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u4so4184588pgg.14
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=y9r4BIYxJa4WnGbQ9pgMMQmBboczCy4Fi2w4BB7yPfI=;
        b=sO+NFzSuWYNKtwk3TsEE9K//jXOLQIeOGSB3EphRYpAtYk4KafmJqX5E9bQtt3CUia
         Zd9u/HnxqrG0OMkjBLYnNRnxiaDUVwFGyzsJn1xwL0h14En3ZQhdrfh3EwAEyoBVkRKM
         NGVrzGeCX+k4HplS3NrRPkRbmYa7Sfy5rUsjT5fJg2NDLSsmp3C696OMe2Di22AzOzRF
         796mRXdfWW4/4NVaDU5BrI6WN71CknoJwqt+1olsnaqiSJ/Br367X9YL0pMTcJ+U9fdW
         0e5UnP1E80pmFPK8dST2aeDDJpDASFaUeh5kWRyG2JKn2Xh6ZE20RmVwTGFfwWcdh8nv
         KLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y9r4BIYxJa4WnGbQ9pgMMQmBboczCy4Fi2w4BB7yPfI=;
        b=UTUiXBmI614+ZVZTIs84UkCBvxkc896KLy9fwKSB5meI9fISNi6LqOR6LBgvRkGC/t
         o+ddO8KdgnsuHwbGepdcySM9/qdYuWdDoKifDwgUhF4Am50bVKc/85dxUThB9/48v26+
         9MCqk7umRVotU06q4KbX1O2TUeYa4mYBqv+IFBPRcsPl3l69JtV+jXsy0evxnqqZcv/D
         w7Ink6MvnLrSM4nsmBPKT9kGwJz31wtug8Grw1nQkQD6rgNLGK56WDAKkYKWTFy9EytC
         FIbFtF5lrhekN1IhrUGz+mnJwxM0YEtC0kdhGXeVDvq9S/ocKhEOXRbYIcpoZynT26H1
         4tbA==
X-Gm-Message-State: AOAM532jPvU4OWIlH55eO/fKt0uXQOfStMyCOK+Ot6ZnABGczzb8zMzC
        Fw8fLG0dtbX9fYN2snakRWgGWDfY06bAuKb1qilabc33IMKLBLazKjhVE923v4Wkag5iRz/o313
        7mV0tyibcgJ6tGOJaPLaqPd+ZnQK8W6aUh05rh6mPvGesYAVPFDfqmJPqzn3HdmQKo4Sal1bKmT
        Ci68vo7PgVoN8=
X-Google-Smtp-Source: ABdhPJxw8+JnHM8cyQFea4nh/jbPrP8p85vdA9LnuWxX0qx0KGToUI00j3Jw/lYQ+3stUSj25WTQLCjamZ4jVpK3Ag==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:90b:f85:: with SMTP id
 ft5mr345340pjb.1.1604048921633; Fri, 30 Oct 2020 02:08:41 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:08:24 +0800
In-Reply-To: <20201030163529.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201030163529.v6.2.I3774a8f0d748c7c6ec3402c4adcead32810c9164@changeid>
Mime-Version: 1.0
References: <20201030163529.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 2/5] Bluetooth: Handle system suspend resume case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mmandlik@chromium.orgi, mcchou@chromium.org,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
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

Commit-changes 5:
- Remove the change in hci_req_config_le_suspend_scan

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 70ea126f56282..b615b981be9d6 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1284,8 +1284,10 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
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
2.29.1.341.ge80a0c044ae-goog

