Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E1C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 19:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EDD24655
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 19:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EBsTpwrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVTrt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:47:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43055 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVTrt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 14:47:49 -0500
Received: by mail-vs1-f66.google.com with SMTP id s16so179214vsc.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 11:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZHquoajQUtnF9C2BO0b6yquwX1857zFnjO9mJWC1R0=;
        b=EBsTpwrQaT4xqFPEMoUNqg7gQmP9pgKQ5qZCt/jQkoqDQ19lW1FACRHIImQtihEXm/
         +obCmtPszZvTYVhLFdH9XchvnTxv2hGpSudSCq4c29YOmHUb95bZ2o8V9d2b5/BUcCA3
         nJfMycumvA7dDMwoQCpKLlPkbRsRXrBfdMTpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZHquoajQUtnF9C2BO0b6yquwX1857zFnjO9mJWC1R0=;
        b=RVxmLZySGVg+/LKccSwrKrdwJXK+r37B3uwC8m7jwKPIjGAYLDuniIc8iD8vSccCPp
         FQD1c7SBLap2BaHgkpDtT0NuuJ5EPwQB+PCR3qvqIEc/cvF8VrsGffG5wyuJcchHMMqz
         9N8KZIiHkXqq0GQoPgqxU9WtGsdEipH5YdpAIgLkmlrzJfFXE8pgOCmGa7/ekdwiZYeX
         u7W8ZwYJAK+beGSo4glTZPsUy/mMbqv8lqNROUz/z+U64FiRT/KqMaUcJYh9fIWxzc6Q
         vE9RpaSkq3pNSkp6+fLA9970la+1Yj2oXjj5tb/VbfL8kTjS+tUZrrk8C/R11bg1MlDy
         yr5Q==
X-Gm-Message-State: APjAAAW/pAnvHY1N+2HEefK3GWPVr3QtoFG8YSqspbZOkmMi5W5PXyHB
        /yo+J/8Y9bYv0pKThCZg7cReQd5q6MfYog==
X-Google-Smtp-Source: APXvYqzLLrjwVKNyuRO+Rr7Sz75RoARv9qoIua1Os79Z8t7zLyBWMGxlHHO6mbeKGkdDFvAj6kUUFw==
X-Received: by 2002:a67:f10c:: with SMTP id n12mr3584453vsk.208.1579722468334;
        Wed, 22 Jan 2020 11:47:48 -0800 (PST)
Received: from alain.c.googlers.com.com (69.104.231.35.bc.googleusercontent.com. [35.231.104.69])
        by smtp.gmail.com with ESMTPSA id a196sm12076679vke.14.2020.01.22.11.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 11:47:47 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] bluetooth: fix appearance typo in mgmt.c
Date:   Wed, 22 Jan 2020 19:47:44 +0000
Message-Id: <20200122194744.239645-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change addresses a typo in the set_appearance handler.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/mgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0dc610faab70..19ea89b6a0ee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3291,7 +3291,7 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 len)
 {
 	struct mgmt_cp_set_appearance *cp = data;
-	u16 apperance;
+	u16 appearance;
 	int err;
 
 	BT_DBG("");
@@ -3300,12 +3300,12 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_APPEARANCE,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
-	apperance = le16_to_cpu(cp->appearance);
+	appearance = le16_to_cpu(cp->appearance);
 
 	hci_dev_lock(hdev);
 
-	if (hdev->appearance != apperance) {
-		hdev->appearance = apperance;
+	if (hdev->appearance != appearance) {
+		hdev->appearance = appearance;
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 			adv_expire(hdev, MGMT_ADV_FLAG_APPEARANCE);
-- 
2.25.0.341.g760bfbb309-goog

